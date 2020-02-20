import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/login/sign_in.dart';

import 'package:password_manager/view/mainWidget.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new LoginState();
}

class LoginState extends State<Login>{

  void isLoggedIn(){
    GoogleSignInAccount user = AuthProvider().googleSignIn.currentUser;
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return Scaffold(
      body: _loginHomePage(),
    );
  }


  Widget _loginHomePage(){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/lock_logo.png', height: 200),
          _buildGoogleSignIn(),
          SizedBox(height: 25),
          _buildPhoneSignIn(),
        ],
      ),
    );
  }

  Widget _buildGoogleSignIn(){
    return OutlineButton(
      onPressed: () async {
        FirebaseUser user = await AuthProvider().signInWithGoogle();
        if(user != null)          
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => new MainWidget(),
          ));        
      },      
      borderSide: BorderSide(color: Colors.blue),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      highlightElevation: 0,
      highlightedBorderColor: Colors.white,
      highlightColor: Colors.lightBlue,
      splashColor: Colors.lightBlue,
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/images/google_logo.png', height: 35),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Sign in with Google',  
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneSignIn(){
    return OutlineButton(
      onPressed: (){

      },

      borderSide: BorderSide(color: Colors.blue),
      highlightElevation: 0,
      highlightedBorderColor: Colors.white,
      highlightColor: Colors.lightBlue,
      splashColor: Colors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('assets/images/phone_logo.png', height: 35),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Sign in with Phone',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}