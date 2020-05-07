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
      body: Container(
        color: ColorConverter().backgroundColor(),
      ),
    );
  }
}