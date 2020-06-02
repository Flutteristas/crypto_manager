import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final Firestore firestore = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> SignInEmail(String email, String password) async {

      AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);

      return user;

    }

  Future<FirebaseUser> SignUpEmail(email, password) async {

      AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = result.user;

      assert (user != null);
      assert (await user.getIdToken() != null);

      return user;

    } 
}
