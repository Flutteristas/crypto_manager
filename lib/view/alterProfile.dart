import 'package:flutter/material.dart';
import 'package:password_manager/login/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class AlterProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AlterProfileState();
}

class AlterProfileState extends State<AlterProfile>{

  final formKey = GlobalKey<FormState>();

  String _title;
  String _account;
  String _username;
  String _password;

  Map<String, dynamic> profileDatas;
  Map<String, dynamic> datasToUpdate;

  void _validateAndSave() async{
    final form = formKey.currentState;
    if (form.validate()){
      form.save(); 

      datasToUpdate = {
        "id": profileDatas["id"],
        "title": _title,
        "account": _account,
        "username": _username,
        "password": _password
      };
      print(datasToUpdate);
      await AuthProvider().updateCryptoProfile(datasToUpdate).then((bool isUpdated){
        if(isUpdated){
          _alertProfileCreated(); 
        }
      });      
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
                  Navigator.pop(context);
                  Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {    
    profileDatas = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildCreateProfileLayout(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title: Text(
        'Update Profile',
      ),
      centerTitle: true,
    );
  }

  Widget _buildCreateProfileLayout(){
    return Container(
      margin: EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildFormField('Title', 'Title can\'t be empty', profileDatas["title"]),
            _buildFormField('Account', 'Account can\'t be empty', profileDatas["account"]),
            _buildFormField('Username', 'Username can\'t be empty', profileDatas["username"]),
            _buildPasswordField('Password', 'Password can\'t be empty', profileDatas["password"]),
            _buildCreateProfileButton(),
            _buildDeleteProfileButton(),
          ],
        ),
      ),
    );  
  }

  Widget _buildFormField(String label, String error, String initialData){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: TextFormField(
        initialValue: initialData,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white
          ),        
        ),
        validator: (value) => value.isEmpty ? error : null,
        onSaved: (value){
          if (label == 'Title'){
            _title = value;
          }
          else if (label == 'Account'){
            _account = value;
          }
          else if (label == 'Username'){
            _username = value;
          }
          else if (label == 'Password'){
            _password = value;
          }
        },
      ),
    );
  }

  Widget _buildPasswordField(String label, String error, String initialData){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: TextFormField(
        obscureText: true,
        initialValue: initialData,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white
          ),        
        ),
        validator: (value) => value.isEmpty ? error : null,
        onSaved: (value){
          if (label == 'Title'){
            _title = value;
          }
          else if (label == 'Account'){
            _account = value;
          }
          else if (label == 'Username'){
            _username = value;
          }
          else if (label == 'Password'){
            _password = value;
          }
        },
      ),
    );
  }

  Widget _buildCreateProfileButton(){
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: RaisedButton(
        onPressed: (){
          _validateAndSave();
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
              'Update Profile',
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

  Widget _buildDeleteProfileButton(){
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: RaisedButton(
        onPressed: (){
          _deleteProfile();
        },
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(32)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Delete Profile',
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

  void _deleteProfile() async{
    await AuthProvider().deleteCryptoProfile(profileDatas["id"]).then((bool isDeleted){
      if(isDeleted){
        _alertProfileDeleted();
      }
    });
  }

  void _alertProfileDeleted(){
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
              'Profile deleted',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white
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
}