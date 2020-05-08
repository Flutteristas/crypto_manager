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
      body: _buildListBody()
    );
  }

  Widget _buildListBody(){
    return Container(        
      color: ColorConverter().backgroundColor(),
      child: SafeArea(          
        child: Container(          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildSearchBar(),
              _buildProfilesList(),
            ],
          )
        ),
      ),
    );
  }

  Widget _buildSearchBar(){
    return Container(
      margin: EdgeInsets.all(8),
      height: 40,
      color: Colors.black54,
    );
  }

  Widget _buildProfilesList(){
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(                
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ColorConverter().firstButtonGradient()
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: ColorConverter().fieldTextColor().withOpacity(0.1),
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