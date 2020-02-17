import 'package:flutter/material.dart';
import 'package:password_manager/view/account.dart';

class Home extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home>{

  int selectedindex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> widgetOptions = <Widget>[
    Text(
    'Index 0: Home',
    style: optionStyle,
    ),
    Text(
      'Index 1: Account',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget _buildBody(){
    return Center(
      child: widgetOptions.elementAt(selectedindex),
    );
  }

  void onItemTapped(int index){
    setState(() {
      selectedindex = index;
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(
        builder: (context) => new Account(),
      ));
      }
    });
  }

  Widget buildBottomNavigationBar(){
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle,),
          title: Text('Account'),
        ),
      ],
      currentIndex: selectedindex,
      selectedItemColor: Colors.green,
      onTap: onItemTapped,
    );
  }

}

