import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/view/accountsList.dart';
import 'package:password_manager/view/profileSettings.dart';

class ProfileHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfileHomeState();
}

class ProfileHomeState extends State<ProfileHome>{

  int _selectedBottomBar = 0;

   List<Widget> _children() => [
    AccountsList(),
    ProfileSettings()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedBottomBar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = _children();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          child: children[_selectedBottomBar]
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar(){
    return BottomNavigationBar(      
      backgroundColor: ColorConverter().backgroundColor(),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.book, color: Colors.lightGreen),
          title: Text('Accounts', style: TextStyle(color: Colors.lightGreen))
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.lightGreen),
          title: Text('Profile', style: TextStyle(color: Colors.lightGreen))
        ),
      ],
      currentIndex: _selectedBottomBar,
      onTap: _onItemTapped,
    );
  }

}