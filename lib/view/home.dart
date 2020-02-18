import 'package:flutter/material.dart';
import 'package:password_manager/view/accountList.dart';
import 'package:password_manager/view/profile.dart';

class Home extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody(){
    return TabBarView(children: 
    <Widget>[
      AccountList(),
      Profile(),
    ],
    controller: controller,
    );
  }

  Widget _buildBottomNavigationBar(){
    return Material(
      child: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(Icons.home, color: Colors.blue),
          ),
          Tab(
            icon: Icon(Icons.account_circle, color: Colors.blue),
          ),
        ],
        controller: controller,
      ),
    );
  }

}

