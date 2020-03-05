import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInEmailPassword(String email, String password) async{
  
    AuthResult authentication = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = authentication.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print(user.toString());
    return user;
  
  }

  Future<FirebaseUser> signUpEmailPassword(String email, String password) async{
    AuthResult authentication = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = authentication.user;

    assert(user != null);
    assert(await user.getIdToken() != null);
    
    print(user.uid);
    return user;
  }

  void signOut() async{
    _auth.signOut();
    assert(_auth.currentUser() == null);
    print('User Signed Out');
  }

  void createUser(){
    Firestore.instance.collection('logins').document().setData({'user': 'Rafael', 'password': 'Rafael1234'});
  }

}