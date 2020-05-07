import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class ProfileSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfileSettingsState();
}

class ProfileSettingsState extends State<ProfileSettings>{

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: Container(
        color: ColorConverter().backgroundColor(),
      ),
    );
  }
}