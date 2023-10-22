import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Auth._();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static User? get currUser => firebaseAuth.currentUser;

  Stream<User?> get authState => firebaseAuth.authStateChanges();

  static Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future signOut() async {
    await firebaseAuth.signOut();
  }
}
