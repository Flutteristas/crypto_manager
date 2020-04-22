import 'package:flutter/material.dart';
import 'package:password_manager/login/dbController.dart';

class SignIn extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new SignInState();
}

class SignInState extends State<SignIn>{

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) => _buildHome();

  void validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();    
      AuthProvider().createUser(_email, _password);
    }
  }

  Widget _buildHome(){
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildForm(),        
        ],
      ),
    );
  }

  Widget _buildForm(){
    return Form(
      key: formKey,
      child: Center(
        child: Column(          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildEmailField(),
            _buildPasswordField(),
            _buildSubmitButton(),
          ],
        )
      ),
    );
  }

  Widget _buildEmailField(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        maxLines: 1,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email, 
            color: Colors.blue,
          ),
          hintText: 'Email'
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) {
          _email = value;
          print(_email);
        },
      ),           
    );
  }

  Widget _buildPasswordField(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.blue,
          )
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),      
    );
  }

  Widget _buildSubmitButton(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: RaisedButton(
        onPressed: (){
          validateAndSave();
        },
        color: Colors.blue,
        child: Text('Sign In'),
      ),
    );
  }
}