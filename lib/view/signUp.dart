import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/Firebase/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/utils/appSize.dart';

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
        if(_password.length < 6){
          _passwordInvalidLength();
        } else {
          await AuthProvider().signUpEmail(_email, _password).then((FirebaseUser user){
            Navigator.of(context).pushNamed('/accountCreated');
          }).catchError((e){
            _invalidEmail();
          });
        }
      } else {
        _passwordsDontMatch();
      }  
    }
  }

  void _invalidEmail(){
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
              'Email is invalid',
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

  void _passwordsDontMatch(){
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
              'Passwords don\'t match',
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

  void _passwordInvalidLength(){
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
              'Password must contain at least 6 characters',
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
    return Scaffold(
      body: _buildBody(),    
      appBar: _buildAppBar(),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: ColorConverter().backgroundColor(),
    );
  }


  Widget _buildBody(){
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraint){
          return SingleChildScrollView(    
            padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 5, 0, SizeConfig.blockSizeHorizontal * 5, 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: formKey,
                  child: Column(       
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildEmailField(),
                      _buildPasswordField(),
                      _buildConfirmPasswordField(),
                      _buildSignUpButton()
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildEmailField(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 3.0, 0, SizeConfig.blockSizeVertical * 3.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2.0),
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
        labelStyle: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2.0),
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
      padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 3.0, 0, 0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          labelStyle: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2.0),
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
      padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 8.0, 0, 0),
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
                ],
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeVertical * 2.0
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}