import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class SignHome extends StatelessWidget{

  final formKey = new GlobalKey<FormState>();
  static String _email;
  static String _password;

  void _validateAndSave(BuildContext context){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();    
      Navigator.of(context).pushNamed('/profileHome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: ColorConverter().backgroundColor(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(                
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,                                            
                children: <Widget>[
                  _homeTitle(),
                  _buildForm(context),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget _homeTitle(){
    return Text(
      'CRYPTO MANAGER',
      style: TextStyle(
        fontSize: 24, 
        letterSpacing: 4,
        color: ColorConverter().firstButtonGradient().withOpacity(0.8),
      ),        
    );
  }

  Widget _buildForm(BuildContext context){
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildEmailField(),
          SizedBox(height: 16),
          _buildPasswordField(),
          _buildLoginButton(context),
          _buildSignUpRow(context),
        ],
      ),
    );
  }

  Widget _buildEmailField(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField( 
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.white),
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.white)
        ),          
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,    
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _buildPasswordField(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        maxLines: 1,
        maxLength: 16,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white)
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Container(
        height: 50,        
        child: RaisedButton(
          onPressed: (){
            _validateAndSave(context);
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorConverter().firstButtonGradient().withOpacity(0.8),
                  ColorConverter().secondButtonGradient()
                ]
              ),
            ),
            child: Container(                          
              alignment: Alignment.center,
              child: Text(
                'LOG IN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget _buildSignUpRow(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(72, 24, 72, 0),
      child: Container(
        alignment: Alignment.center,     
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Don\'t have an account?'
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/signUp');
              },
              child: Text(
                'Sign up!',
                style: TextStyle(color: ColorConverter().firstButtonGradient()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}