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
        diameterRatio: 1.6,
        children: <Widget>[
          Container(
            width: 330,
            color: Colors.black,
          ),
          Container(
            width: 330,
            color: Colors.green,
          ),
          Container(
            width: 330,
            color: Colors.purple,
          ),
          Container(
            width: 330,
            color: Colors.red,
          ),
          Container(
            width: 330,
            color: Colors.blue,
          ),
        ]
      ),
    );
  }
}