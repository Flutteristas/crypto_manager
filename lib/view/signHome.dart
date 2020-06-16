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
        if(user.uid != null){
          Navigator.of(context).pushNamed('/entriesList');
        }
      }); 
    }
  }

    @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(      
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
      ),
    );
  }

  Widget _homeTitle(){
    return Text(
      'CRYPTO MANAGER',
      style: TextStyle(
        fontSize: SizeConfig.safeBlockVertical * 2, 
        letterSpacing: SizeConfig.safeBlockHorizontal * 3,
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
        labelStyle: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 1.5)
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
          labelStyle: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 1.5)
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
        height: SizeConfig.blockSizeVertical * 4,        
        child: RaisedButton(
          onPressed: (){
            _validateAndSave();
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6)),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6),
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
                  fontSize: SizeConfig.blockSizeVertical * 1.5
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
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 1.3
            ),
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
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 1.3
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}