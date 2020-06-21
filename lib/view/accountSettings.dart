import 'package:flutter/material.dart';
import 'package:password_manager/Firebase/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/utils/appSize.dart';

class AccountSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AccountSettingsState();
} 

class AccountSettingsState extends State<AccountSettings>{

  final formkey = GlobalKey<FormState>();

  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildAccountSettings(),
      appBar: _buildAppBar(),
    );
  }

  void _validateAndSave() async{
    final form = formkey.currentState;
    if(form.validate()){
      form.save();

      await AuthProvider().updateAccountEmail(_email).then((bool isUpdated){
        if(isUpdated)
           _alertAccountUpdated();
      });      
    }
  }

  void _alertAccountUpdated(){
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
              'Email updated, Please Login Again',
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
                  Navigator.of(context).pushNamed('/signHome');
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

  void _confirmEmailUpdate(){
    Future.delayed(Duration(seconds: 1), (){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2)),
            content: Text(
              'Are you sure you want to update your email?',
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

  Widget _buildAppBar(){
    return AppBar(
      title: Text(
        'Account Settings',
        style: TextStyle(
          color: Colors.white
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _buildAccountSettings(){
    return LayoutBuilder(
      builder: (context, constraint){
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 5, 0, SizeConfig.blockSizeHorizontal * 5, 0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildFormField('Email', 'Email can\'t be empty'),
                    _buildUpdateButton(),
                    _buildChangePasswordButton(),            
                    _buildDeleteButton()
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
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.blockSizeVertical * 2.0
          ),        
        ),
        validator: (value) => value.isEmpty ? error : null,
        onSaved: (value){
          if (label == 'Email'){
            _email = value;
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
          Navigator.of(context).pushNamed('/changePassword');
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

  Widget _buildUpdateButton(){
    return Container(
      height: SizeConfig.blockSizeVertical * 5.5,
      margin: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 4.0, 0, 0),
      child: RaisedButton(
        onPressed: (){
          _confirmEmailUpdate();
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
              'Update Email',
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

  Widget _buildDeleteButton(){
    return Container(
      height: SizeConfig.blockSizeVertical * 5.5,
      margin: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 4.0, 0, 0),
      child: RaisedButton(
        onPressed: (){
          _confirmAccountDelete();
        },
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6.0)),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6.0)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Delete Account',
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

  void _deleteAccount() async{
    await AuthProvider().deleteUserAccount().then((bool isDeleted){            
      _accountDeleted();
    });
  }

  void _confirmAccountDelete(){
    Future.delayed(Duration(seconds: 1), (){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2)),
            content: Text(
              'Are you sure you want to delete your account?',
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
                  _deleteAccount();                  
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

  void _accountDeleted(){
    Future.delayed(Duration(seconds: 0), (){
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
              'Account deleted',
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
                  Navigator.of(context).pushNamed('/signHome');
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
}
