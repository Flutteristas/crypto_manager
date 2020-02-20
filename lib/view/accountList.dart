import 'package:flutter/material.dart';

class AccountList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new AccountListState();
}

class AccountListState extends State<AccountList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}