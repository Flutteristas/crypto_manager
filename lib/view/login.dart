import 'package:flutter/material.dart';
import 'package:password_manager/login/sign_in.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new LoginState();
}

class LoginState extends State<Login>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginHomePage(),
    );
  }

  Widget _loginHomePage(){
    return Container(
      child: Form(
        child: Column(          
          children: <Widget>[
            _buildEmailField(),
            _buildPasswordField(),
            _buildSubmitButton()
          ],
        ) 
      ),
    );
  }

  Widget _buildEmailField(){
    return TextFormField(
      maxLines: 1,
      decoration: new InputDecoration(
        hintText: 'Email',
        icon: Icon(
          Icons.person,
          color: Colors.blue,
        )
      ),
    );
  }

  Widget _buildPasswordField(){
    return TextFormField(
      obscureText: true,
      maxLines: 1,      
      decoration: new InputDecoration(
        labelText: 'Password',
        icon: Icon(
          Icons.lock,
          color: Colors.blue,
        )        
      ),
    );
  }

  Widget _buildSubmitButton(){
    return RaisedButton(
      onPressed: (){
        //AuthProvider().createUser();
      },
      color: Colors.blue,
      child: Text(
        'Sign In', 
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}