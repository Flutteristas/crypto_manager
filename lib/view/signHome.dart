import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class SignHome extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new SignHomeState();
}

class SignHomeState extends State<SignHome> {

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  

  void _validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();    

      Navigator.of(context).pushNamed('/profilesList');
    }
  }

    @override
  Widget build(BuildContext context) {
   return Scaffold(      
      resizeToAvoidBottomPadding: false,
      body: Container(   
        margin: EdgeInsets.all(32),             
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,                                            
          children: <Widget>[
            _homeTitle(),
            _buildForm(),
          ],
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

  Widget _buildForm(){
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildEmailField(),
            _buildPasswordField(),
            _buildLoginButton(),
            _buildSignUpRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(){
    return TextFormField( 
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Colors.white),
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white)
      ),          
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,    
      onSaved: (value) => _email = value,
    );
  }

  Widget _buildPasswordField(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
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

  Widget _buildLoginButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
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
                ]
              ),
            ),
            child: Container(                          
              alignment: Alignment.center,
              child: Text(
                'Login',
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

  Widget _buildSignUpRow(){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 24, 0, 0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account?'
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/signUp');
              },
              child: Text(
                'Sign up!',
                style: TextStyle(
                  color: ColorConverter().firstButtonGradient(),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}