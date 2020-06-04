import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_manager/cryption/crypt.dart';

class AuthProvider {
  final Firestore firestore = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInEmail(String email, String password) async {
    AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  }

  Future<FirebaseUser> signUpEmail(email, password) async {
    AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert (user != null);
    assert (await user.getIdToken() != null);

    return user;
  } 

  Future<void> logoutUser() async {
    await auth.signOut();
  }

  Future<String> userID() async {
    final FirebaseUser currentUser = await auth.currentUser();
    
    String userUID = currentUser.uid;

    return Future<String>.value(userUID);
  }

  Future<bool> deleteUserAccount() async{
    final FirebaseUser currentUser = await auth.currentUser();

    await currentUser.delete();

    return true;
  }

  Future<bool> updateAccountEmail(String email) async{
    final FirebaseUser currentUser = await auth.currentUser();
    await currentUser.updateEmail(email);
    return true;
  }

  Future<bool> updateAccountPassword(String password) async{
    final FirebaseUser currentUser = await auth.currentUser();
    await currentUser.updatePassword(password);
    return true;
  }

  Future<bool> signNewCryptoProfile(title, account, username, password) async{
    final FirebaseUser currentUser = await auth.currentUser();
    String userUID = currentUser.uid;

    print(password);
    String cryptedPassword = CryptFunction().encrypt(username, password);
    print(cryptedPassword);

    await firestore.collection('profiles').document().setData({
      "uid": userUID,
      "title": title,
      "account": account,
      "username": username,
      "password": cryptedPassword
    });
    
    return true;
  }

  Future<bool> deleteCryptoProfile(String documentID) async{
    await firestore.collection("profiles").document(documentID).delete();
    return true;
  }

  Future<bool> updateCryptoProfile(Map<String, dynamic> profileDatas) async{
    await firestore.collection("profiles").document(profileDatas["id"]).updateData({
      "title": profileDatas["title"],
      "account": profileDatas["account"],
      "username": profileDatas["username"],
      "password": profileDatas["password"]
    });  
    return true;
  }
}
