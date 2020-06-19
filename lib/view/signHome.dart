import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Firebase/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/utils/appSize.dart';

class SignHome extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new SignHomeState();
}

class SignHomeState extends State<SignHome> {

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  

  void _validateAndSave() async{
    final form = formKey.currentState;
    if (form.validate()){
      form.save();    

      await AuthProvider().signInEmail(_email, _password).then((FirebaseUser user){
        Navigator.of(context).pushNamed('/entriesList');        
      }).catchError((e){
        _incorrectEmailOrPassword();
      }); 
    }
  }

  void _incorrectEmailOrPassword(){
    Future.delayed(Duration(seconds: 0), (){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 2)),
            backgroundColor: ColorConverter().backgroundColor(),
            title: Text(
              'Invalid values', 
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 1.8
              ),
            ),
            content: Text(
              'Email or password invalid',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 1.8
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context); 
                },
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 1.8
                  ),
                )
              ),
            ],
          );
        }
      );
    }); 
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(      
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(   
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),                           
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _homeTitle(),
                    _buildForm(),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  Widget _homeTitle(){
    return Text(
      'CRYPTO MANAGER',
      style: TextStyle(
        fontSize: SizeConfig.safeBlockVertical * 3.0, 
        letterSpacing: SizeConfig.safeBlockHorizontal * 2.0,
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
        labelStyle: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2.0)
      ),          
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,    
      onSaved: (value) => _email = value,
    );
  }

  Widget _buildPasswordField(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 3.0, 0, 0),
      child: TextFormField(
        maxLines: 1,
        maxLength: 16,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2.0)
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _buildLoginButton(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 4.0, 0, 0),
      child: Container(
        height: SizeConfig.blockSizeVertical * 5.5,        
        child: RaisedButton(
          onPressed: (){
            _validateAndSave();
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6.0)),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6.0),
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
                  fontSize: SizeConfig.blockSizeVertical * 2.0
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
      margin: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 3.0, 0, 0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 1.8
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 2.0, 0, 0, 0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/signUp');
              },
              child: Text(
                'Sign up!',
                style: TextStyle(
                  color: ColorConverter().firstButtonGradient(),
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 1.8
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}