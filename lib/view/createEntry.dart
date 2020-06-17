import 'package:flutter/material.dart';
import 'package:password_manager/Firebase/dbController.dart';
import 'package:password_manager/utils/ColorConverter.dart';
import 'package:password_manager/utils/appSize.dart';
import 'package:password_manager/utils/cryptoRandomString.dart';

class CreateEntry extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CreateEntryState();
}

class CreateEntryState extends State<CreateEntry> {

  final formKey = GlobalKey<FormState>();

  String _title;
  String _account;
  String _username;
  String _password;

  var _passwordController = new TextEditingController();

  bool hidePassword = true;

  Icon visibleOnOff = Icon(Icons.visibility, color: Colors.white);

  void _validateAndSave() async{
    final form = formKey.currentState;
    if (form.validate()){
      form.save(); 
      await AuthProvider().signNewCryptoEntry(_title, _account, _username, _password).then((bool signed){
        if(signed){
          _alertEntryCreated();
        }
      });           
    }
  }

  void _alertEntryCreated(){
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
              'Entry added',
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

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildCreateEntryLayout(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title: Text(
        'Add Entry',
      ),
      centerTitle: true,
    ); 
  }

  Widget _buildCreateEntryLayout(){
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeVertical * 3.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildFormField('Title', 'Title can\'t be empty'),
            _buildFormField('Account', 'Account can\'t be empty'),
            _buildFormField('Username', 'Username can\'t be empty'),
            _buildPasswordField('Password', 'Password can\'t be empty'),
            _buildCreateEntryButton(),
          ],
        ),
      ),
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

  Widget _buildPasswordField(String label, String error){
    return Container(
      margin: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 3.5, 0, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              obscureText: hidePassword,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeVertical * 2.0
                ),
              ),
              validator: (value) => value.isEmpty ? error : null,
              onSaved: (value){
                  _password = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 4.0, 0, 0, 0),
            child: GestureDetector(
              onTap: (){                
                String encondedPassword = CryptoRandomString().createCryptoRandomString();
                setState(() {
                  _passwordController.text = encondedPassword;
                });
              },
              child: Icon(
                Icons.replay, 
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(SizeConfig.blockSizeHorizontal * 6.0, 0, 0, 0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  if(hidePassword == false){
                    hidePassword = true;
                    visibleOnOff = Icon(Icons.visibility, color: Colors.white);
                  } else {
                    hidePassword = false;
                    visibleOnOff = Icon(Icons.visibility_off, color: Colors.white);
                  }                
                });
              },
              child: visibleOnOff
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateEntryButton(){
    return Container(
      height: SizeConfig.blockSizeVertical * 5.5,
      margin: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeVertical * 8.0, 0, 0),
      child: RaisedButton(
        onPressed: (){
          _validateAndSave();
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
              'Add Entry',
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
}