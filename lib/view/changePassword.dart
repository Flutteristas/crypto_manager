import 'package:flutter/material.dart';
import 'package:password_manager/Firebase/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/utils/appSize.dart';

class ChangePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword>{

   final formKey = GlobalKey<FormState>();

  String _newPassword;
  String _confirmedPassword;

  void _validateAndSave() async{    
    await AuthProvider().updateAccountPassword(_newPassword).then((bool isUpdated){    
      _alertPasswordUpdated();
    });          
  }

  void _confirmPasswordUpdate(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();

      if(_newPassword == _confirmedPassword){
        if(_newPassword.length < 6){      
          _passwordInvalidLength();  
        } else {       
          _alertDialogConfirmPasswordDelete();
        }
      } else{
        _alertPasswordsDontMatch();
      }
    }
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

  void _alertDialogConfirmPasswordDelete(){
    Future.delayed(Duration(seconds: 1), (){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2)),
            content: Text(
              'Are you sure you want to change your password?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeVertical * 2.0
              ),
            ),
            backgroundColor: ColorConverter().backgroundColor(),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);                  
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: ColorConverter().firstButtonGradient(),
                    fontSize: SizeConfig.blockSizeVertical * 2.0
                  ),
                ),
              ),
              FlatButton(
                onPressed: (){            
                  Navigator.pop(context);
                  _validateAndSave();                  
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: ColorConverter().firstButtonGradient(),
                    fontSize: SizeConfig.blockSizeVertical * 2.0
                  ),
                ),
              ),
            ],
          );
        }
      );
    });
  }

  void _alertPasswordUpdated(){
    Future.delayed(Duration(seconds: 1), (){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Icon(
              Icons.check_circle,
              color: ColorConverter().firstButtonGradient(),
              size: SizeConfig.blockSizeVertical * 6.0,
            ),
            content: Text(
              'Password Updated',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeVertical * 2.0
              ),
            ),
            backgroundColor: ColorConverter().backgroundColor(),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: ColorConverter().firstButtonGradient(),
                    fontSize: SizeConfig.blockSizeVertical * 2.0
                  ),
                ),
              )
            ],
          );
        }
      );
    });
  }

  void _alertPasswordsDontMatch(){
    Future.delayed(Duration(seconds: 1), (){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Icon(
              Icons.error,
              color: Colors.red,
              size: SizeConfig.blockSizeVertical * 6.0,
            ),
            content: Text(
              'Passwords Don\'t Match',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeVertical * 2.0
              ),
            ),
            backgroundColor: ColorConverter().backgroundColor(),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: ColorConverter().firstButtonGradient(),
                    fontSize: SizeConfig.blockSizeVertical * 2.0
                  ),
                ),
              )
            ],
          );
        }
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildChangePasswordLayout(),
      appBar: _buildAppBar(),
    );
  }
  
  Widget _buildChangePasswordLayout(){
    return LayoutBuilder(
      builder: (context, constraint){
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 5, 0, SizeConfig.blockSizeHorizontal * 5, 0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildFormField('New Password', 'New Password can\'t be empty'),
                    _buildFormField('Confirm Password', 'Confirm Password can\'t be empty'),
                    _buildChangePasswordButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );      
  }

  Widget _buildFormField(String label, String error){
    return Container(
      margin: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 3.5, 0, 0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.blockSizeVertical * 2.0
          ),        
        ),
        validator: (value) => value.isEmpty ? error : null,
        onSaved: (value){
          if (label == 'New Password'){
            _newPassword = value;
          }
          else if (label == 'Confirm Password'){
            _confirmedPassword = value;
          }
        },
      ),
    );
  }

  Widget _buildChangePasswordButton(){
    return Container(
      height: SizeConfig.blockSizeVertical * 5.5,
      margin: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 4.0, 0, 0),
      child: RaisedButton(
        onPressed: (){
          _confirmPasswordUpdate();      
        },
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6.0)),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                ColorConverter().firstButtonGradient(),
                ColorConverter().secondButtonGradient()
              ],              
            ),
            borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6.0)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Change Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeVertical * 2.0
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildAppBar(){
    return AppBar(
      title: Text(
        'Change Password',
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}