import 'package:flutter/material.dart';
import 'package:password_manager/view/profileHome.dart';
import 'package:password_manager/view/signIn.dart';
import 'package:password_manager/view/signUp.dart';

void main() => runApp(PasswordManager());

class PasswordManager extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signHome': (context) => SignHome(),
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
        '/profileHome': (context) => ProfileHome()
      },
      title: 'Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
