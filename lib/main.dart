import 'package:flutter/material.dart';
import 'package:password_manager/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(PasswordManager());

class PasswordManager extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
