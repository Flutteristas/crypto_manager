import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider {
  final Firestore firestore = Firestore.instance;

  Future<bool> createUser(String email, String password)  async{
    firestore.collection('logins').document().setData({'user': email, 'password': password});
    print(' {$email}  {$password}');
    return true;
  }
}