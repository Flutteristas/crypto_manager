import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider {
  final Firestore firestore = Firestore.instance;

  void createUser(String email, String password)  async{
    firestore.collection('logins').document().setData({'user': email, 'password': password});
    print(' {$email}  {$password}');
  }
}