import 'package:flutter/material.dart';

class SignHome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              _build
              _buildSignInButton(),
              _buildSignUpButton()
            ],
          ),
        ),
      )
    );
  }

  Widget _buildSignInButton(){
    return RaisedButton(
      onPressed: (){
      },
      child: Text('SignIn'),
      color: Colors.blue,
    );
  }
}