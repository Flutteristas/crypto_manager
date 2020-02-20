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
    return Center(
      child: ListWheelScrollView(
        itemExtent: 80, 
        diameterRatio: 1.5,
        children: <Widget>[
          Container(
            width: 300,
            color: Colors.black,
          ),
          Container(
            width: 300,
            color: Colors.green,
          ),
          Container(
            width: 300,
            color: Colors.purple,
          ),
          Container(
            width: 300,
            color: Colors.red,
          ),
          Container(
            width: 300,
            color: Colors.blue,
          ),
        ]
      ),
    );
  }
}