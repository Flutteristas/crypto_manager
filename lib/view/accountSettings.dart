import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class AccountSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AccountSettingsState();
} 

class AccountSettingsState extends State<AccountSettings>{

  final formkey = GlobalKey<FormState>();

  String _name;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildAccountSettings(),
      appBar: _buildAppBar(),
    );
  }

  void _validateAndSave(){
    final form = formkey.currentState;
    if(form.validate()){
      form.save();
    }
  }

  void _alertProfileCreated(){
    Future.delayed(Duration(seconds: 1), (){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Icon(
              Icons.check_circle,
              color: ColorConverter().firstButtonGradient(),
              size: 50,
            ),
            content: Text(
              'Profile updated',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            backgroundColor: ColorConverter().backgroundColor(),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/profilesList');
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: ColorConverter().firstButtonGradient()
                  ),
                ),
              )
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
    );
  }

  Widget _buildAccountSettings(){
    return Container(
      margin: EdgeInsets.all(32),
      child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildFormField('Name', 'Name can\'t be empty'),
            _buildFormField('Email', 'Email can\'t be empty'),
            _buildChangePasswordButton(),
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String error){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white
          ),        
        ),
        validator: (value) => value.isEmpty ? error : null,
        onSaved: (value){
          if (label == 'Name'){
            _name = value;
          }
          else if (label == 'Email'){
            _email = value;
          }          
        },
      ),
    );
  }

  Widget _buildChangePasswordButton(){
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: RaisedButton(
        onPressed: (){       
          Navigator.of(context).pushNamed('/changePassword');
        },
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
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
            borderRadius: BorderRadius.circular(32)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Change Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateButton(){
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: RaisedButton(
        onPressed: (){
          _validateAndSave();
          _alertProfileCreated();
        },
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
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
            borderRadius: BorderRadius.circular(32)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Update Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
          ),
        ),
      ),
    );
  }

}
