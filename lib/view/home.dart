import 'package:flutter/material.dart';

class AccountList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new AccountListState();
}

class AccountListState extends State<AccountList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListWheel(),
    );
  }

  Widget _buildListWheel(){
    return ListView(
      children: <Widget>[
        SizedBox(
          child: Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              leading: Icon(Icons.account_box),
              title: Text('URL'),
              trailing: Icon(Icons.more_vert),
            ),
          ),
        )
      ],
    );
  }
}