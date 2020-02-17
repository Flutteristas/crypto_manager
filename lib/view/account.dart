import 'package:flutter/material.dart';
import 'package:password_manager/view/home.dart';

class Account extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new AccountState();
}

class AccountState extends State<Account>{

  HomeState home = new HomeState();

  @override
  Widget build(BuildContext context) {
    return _buildAccountInfo();
  }

  Widget _buildAccountInfo(){
    return Scaffold(
      body: _buildInfo(),
      bottomNavigationBar: home.buildBottomNavigationBar(),
    );
  }

  Widget _buildInfo(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue[600].withOpacity(0.5),
            Colors.blue[600]
          ]
        ),
      ),
    );
  }
}