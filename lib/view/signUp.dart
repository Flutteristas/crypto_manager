import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/login/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp>{

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  String _confirmedPassword;

  void _validateAndSave() async{
    final form = formKey.currentState;
    if(form.validate()){
      form.save();  

      if (_password == _confirmedPassword){
        await AuthProvider().SignUpEmail(_email, _password).then((FirebaseUser user){
          Navigator.of(context).pushNamed('/accountCreated');
        });
      } else {
        print('User wasn\'t created');
      }  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      resizeToAvoidBottomPadding: false,
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
            _buildEmailField(),
            _buildPasswordField(),
            _buildConfirmPasswordField(),
            _buildSignUpButton()
          ],
        ),
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
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value){
          _email = value;
        },
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
      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      onSaved: (value){
        _password = value;
      },
    );
  }

  Widget _buildConfirmPasswordField(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.lock, color: Colors.white),
        ),
        validator: (value) => value.isEmpty ? 'Confirmed Password can\'t be empty' : null,
        onSaved: (value){
          _confirmedPassword = value;
        },
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
            _validateAndSave();
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
                  ColorConverter().firstButtonGradient(),
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