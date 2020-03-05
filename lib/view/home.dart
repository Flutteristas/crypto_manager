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
    return ListTile(
      title: Text('Url'),
      subtitle: Text('username'),
      trailing: Icon(Icons.menu),
      leading: Icon(Icons.person_outline),
    );
  }
}