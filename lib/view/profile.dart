import 'package:flutter/material.dart';
import 'package:password_manager/view/home.dart';

class Profile extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new ProfileState();
}

class ProfileState extends State<Profile>{

  HomeState home = new HomeState();

  @override
  Widget build(BuildContext context) {
    return _buildProfile();
  }

  Widget _buildProfile(){
    return Scaffold(
      body: _buildInfo(),
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