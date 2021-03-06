import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Firebase/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/utils/appSize.dart';
import 'package:password_manager/utils/fingerAuth.dart';

class EntriesList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => EntriesListState();
}

class EntriesListState extends State<EntriesList>{

  String userUID;
  bool isLoaded = false;

  void _getUserUID() async{
    await AuthProvider().userID().then((String user){
      userUID = user;
    });
    isLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    _getUserUID();  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {        
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: !isLoaded ? Container(height: 60, child: Center(child: CircularProgressIndicator())) : _buildListBody(),
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
    return Container(          
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildEntriesList(),
        ],
      )
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
                fontSize: SizeConfig.safeBlockVertical * 3.0
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
            size: SizeConfig.blockSizeVertical * 2.5,
          ),
          title: Text(
            'Account',
            style: TextStyle(
              color: ColorConverter().firstButtonGradient().withOpacity(0.8),
              fontSize: SizeConfig.blockSizeVertical * 2.0
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
            size: SizeConfig.blockSizeVertical * 2.5,
          ),
          title: Text(
            'Logout', 
            style: TextStyle(
              color: Colors.red,
              fontSize: SizeConfig.blockSizeVertical * 2.0
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEntriesList(){
    return Expanded(
      child: StreamBuilder(
        stream: Firestore.instance.collection("entries").where(
          "uid",
          isEqualTo: userUID
        ).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          //Verifico se existe algum dado
          if(snapshot.data == null)
            return CircularProgressIndicator();
          else{
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {              
                  return _buildEntryInteration(document.documentID, document["title"], document["account"], document["username"], document["password"]);
              }).toList(),
            );
          }
        },
      ),  
    );
  }

  void _authenticateFingerprint(Map<String, dynamic> profileDatas) async{
    await FingerPrintAuthentication().checkIfBiometricIsAvailable().then((bool hasBiometric) async {      
      if(hasBiometric) {        
        await FingerPrintAuthentication().authenticateUserWithFingerPrint().then((bool isAuthenticated){
        if(isAuthenticated) 
          Navigator.of(context).pushNamed('/alterEntry', arguments: profileDatas);
        });
      } else {
        Navigator.of(context).pushNamed('/alterEntry', arguments: profileDatas);        
      }
    });
    
  }

  Widget _buildEntryInteration(documentID, title, account, username, password){
    Map<String, dynamic> profileDatas = {"id": documentID, "title": title, "account":  account, "username": username, "password": password};
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2.0),
      child: GestureDetector(
        onTap: (){
          _authenticateFingerprint(profileDatas);          
        },
        child: _buildEntryContainer(title, account)
      ),
    );
  }

  Widget _buildEntryContainer(title, account){
    return Container(                
      height: SizeConfig.blockSizeVertical * 8.5,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5.0),
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
        Navigator.of(context).pushNamed('/createEntry');
      },
      backgroundColor: ColorConverter().firstButtonGradient(),
      child: Icon(
        Icons.add,        
      ),
    );
  }
}