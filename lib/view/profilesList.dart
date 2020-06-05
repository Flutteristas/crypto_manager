import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Firebase/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/utils/fingerAuth.dart';

class ProfilesList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfilesListState();
}

class ProfilesListState extends State<ProfilesList>{

  String userUID;

  @override
  Widget build(BuildContext context) {    
    AuthProvider().userID().then((String user){
      userUID = user;
    });
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _buildListBody(),
        drawer: _buildDrawer(),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: ColorConverter().firstButtonGradient()),        
        ),
        floatingActionButton: _buildFloatActionButton(),
      ),
    );
  }

  Widget _buildListBody(){
    return SafeArea(          
      child: Container(          
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildProfilesList(),
          ],
        )
      ),
    );
  }

  Widget _buildDrawer(){
    return Drawer(            
      child: ListView(
        children: <Widget>[
          DrawerHeader(            
            child: Text(
              'CRYPTO MANAGER',
              style: TextStyle(
                color: ColorConverter().firstButtonGradient().withOpacity(0.8),
                fontSize: 24
              ),
            )
          ),          
          _buildDrawerAccount(),
          _buildDrawerLogout()
        ],
      ),
    );
  }

  Widget _buildDrawerAccount(){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/accountSettings');
      },
      child: Container(
        child: ListTile(
          leading: Icon(
            Icons.person,
            color: ColorConverter().firstButtonGradient().withOpacity(0.8),
          ),
          title: Text(
            'Account',
            style: TextStyle(
              color: ColorConverter().firstButtonGradient().withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

  void _logoutCurrentUser() async{
    await AuthProvider().logoutUser();
    Navigator.of(context).pushNamed('/signHome');
  }

  Widget _buildDrawerLogout(){
    return GestureDetector(
      onTap: (){
        _logoutCurrentUser();
      },
      child: Container(
        child: ListTile(
          leading: Icon(
            Icons.exit_to_app, 
            color: Colors.red,
          ),
          title: Text(
            'Logout', 
            style: TextStyle(
              color: Colors.red
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilesList(){
    return Expanded(
      child: StreamBuilder(
        stream: Firestore.instance.collection("profiles").where(
          "uid",
          isEqualTo: userUID
        ).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          return ListView(
            children: snapshot.data.documents.map((DocumentSnapshot document) {              
                return _buildProfileInteration(document.documentID, document["title"], document["account"], document["username"], document["password"]);
            }).toList(),
          );
        },
      ),  
    );
  }

  void _authenticateFingerprint(Map<String, dynamic> profileDatas) async{
    await FingerPrintAuthentication().authenticateUserWithFingerPrint().then((bool isAuthenticated){
      if(isAuthenticated) 
        Navigator.of(context).pushNamed('/alterProfile', arguments: profileDatas);
    });
  }

  Widget _buildProfileInteration(documentID, title, account, username, password){
    Map<String, dynamic> profileDatas = {"id": documentID, "title": title, "account":  account, "username": username, "password": password};
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          _authenticateFingerprint(profileDatas);          
        },
        child: _buildProfileContainer(title, account)
      ),
    );
  }

  Widget _buildProfileContainer(title, account){
    return Container(                
      height: 80,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorConverter().firstButtonGradient()
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorConverter().fieldTextColor().withOpacity(0.05),
            offset: Offset(3, 3),
            blurRadius: 1,                      
          )
        ]
      ),
      child: ListTile(                
        leading: Text(title),
        title: Text(title),
      ),
    );
  }

  Widget _buildFloatActionButton(){
    return FloatingActionButton(
      onPressed: (){
        Navigator.of(context).pushNamed('/createProfile');
      },
      backgroundColor: ColorConverter().firstButtonGradient(),
      child: Icon(
        Icons.add,        
      ),
    );
  }
}