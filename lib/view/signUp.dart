import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp>{

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Container(
      margin: EdgeInsets.all(32),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,                    
          children: <Widget>[
            _buildNameField(),
            _buildEmailField(),
            _buildPasswordField(),
            _buildSignUpButton()
          ],
        ),
      ),
    );
  }

  Widget _buildNameField(){
    return TextFormField(    
      decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.person, color: Colors.white),
      ),
    ); 
  }

  Widget _buildEmailField(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.email, color: Colors.white),
        ),
      ),
    ); 
  }

  Widget _buildPasswordField(){
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.lock, color: Colors.white),
      ),
    );
  }

  Widget _buildSignUpButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 64, 0, 0),
      child: Container(
        height: 50,
        child: RaisedButton(
          onPressed: (){

          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorConverter().firstButtonGradient().withOpacity(0.8),
                  ColorConverter().secondButtonGradient()
                ],
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}