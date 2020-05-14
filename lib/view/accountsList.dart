import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class AccountsList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AccountsListState();
}

class AccountsListState extends State<AccountsList>{
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: _buildListBody(),
      drawer: _buildDrawer(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConverter().firstButtonGradient()),
      ),
    );
  }

  Widget _buildListBody(){
    return SafeArea(          
      child: Container(          
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildSearchBar(),
            _buildProfilesList(),
          ],
        )
      ),
    );
  }

  Widget _buildSearchBar(){
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
        border: Border.all(
          color: Colors.white
        )
      ),
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
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
          _buildDrawerProfile(),
          _buildDrawerLogout()
        ],
      ),
    );
  }

  Widget _buildDrawerProfile(){
    return GestureDetector(
      onTap: (){},
      child: Container(
        child: ListTile(
          leading: Icon(
            Icons.person,
            color: ColorConverter().firstButtonGradient().withOpacity(0.8),
          ),
          title: Text(
            'Profile',
            style: TextStyle(
              color: ColorConverter().firstButtonGradient().withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerLogout(){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/signHome');
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(                
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
                  leading: Text('Rafael'),
                  title: Text('Soares'),
                ),
              ),
            );
          }
        ),
      ),    
    );
  }
}