import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/view/accountSettings.dart';
import 'package:password_manager/view/alterEntry.dart';
import 'package:password_manager/view/changePassword.dart';
import 'package:password_manager/view/createEntry.dart';
import 'package:password_manager/view/entriesList.dart';
import 'package:password_manager/view/signHome.dart';
import 'package:password_manager/view/signUp.dart';
import 'package:password_manager/view/accountCreated.dart';

void main() => runApp(PasswordManager());

class PasswordManager extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signHome': (context) => SignHome(),
        '/signUp': (context) => SignUp(),
        '/entriesList': (context) => EntriesList(),
        '/accountCreated': (context) => AccountCreated(),
        '/createEntry': (context) => CreateEntry(),
        '/alterEntry': (context) => AlterEntry(),
        '/accountSettings': (context) => AccountSettings(),
        '/changePassword': (context) => ChangePassword()
      },
      title: 'Crypto Manager',
      theme: ThemeData(        
        primaryColor: ColorConverter().backgroundColor(),
        canvasColor: ColorConverter().backgroundColor(),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white
        ),           
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      ),
      home: SignHome(),
    );
  }
}
