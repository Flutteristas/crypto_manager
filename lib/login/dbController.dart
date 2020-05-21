import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider {
  final Firestore firestore = Firestore.instance;

  void createUser(String name,String email, String password)  async{
    await firestore.collection("user").add({
      "name": name,
      "email": email, 
      "password": password
    });
  }
}