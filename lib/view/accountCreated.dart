import 'package:flutter/material.dart';
import 'package:password_manager/utils/ColorConverter.dart';

class AccountCreated extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() => new AccountCreatedState();
}

class AccountCreatedState extends State<AccountCreated> {

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: SafeArea(
        child: _buildLayout(),
      ),
    );
  }

  Widget _buildLayout(){
    return Center(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Column(    
          mainAxisAlignment: MainAxisAlignment.start,  
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildConfirmationIcon(),
            _buildConfirmationInfo(),          
            _buildConfirmationButton()
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationIcon(){
    return Icon(
      Icons.check_circle_outline,
      color: ColorConverter().firstButtonGradient(),
      size: 120,
    );
  }

  Widget _buildConfirmationInfo(){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 24, 0, 56),
      child: Text(
        'You\'re all set',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: ColorConverter().fieldTextColor()
        ),
      ) 
    ); 
  }

  Widget _buildConfirmationButton(){
    return Container(
      height: 50,
      child: RaisedButton(
        onPressed: (){          
          Navigator.of(context).pushNamed('/profilesList');
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
              'Start Using App',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }

}