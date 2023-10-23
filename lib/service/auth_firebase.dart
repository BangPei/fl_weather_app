import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/models/user_model.dart';

class AuthFirebase {
  AuthFirebase._();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static User? get currUser => firebaseAuth.currentUser;

  static CollectionReference users =
      FirebaseFirestore.instance.collection('user');

  Stream<User?> get authState => firebaseAuth.authStateChanges();

  static Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      firebaseAuth.signInWithCredential(credential).then((value) {
        context.go("/");
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

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
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  static Future verifyPhoneNumber(BuildContext context, String phone) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (phoneAuthCredential) {
        print(phoneAuthCredential);
      },
      verificationFailed: (error) {
        print(error);
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        final smsCode = await getSmsCodeFromUser(context);

        if (smsCode != null) {
          final credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          try {
            await firebaseAuth.signInWithCredential(credential);
          } on FirebaseAuthException catch (e) {
            print(e);
          }
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print(verificationId);
      },
    );
  }

  static Future signOut() async {
    await firebaseAuth.signOut();
  }

  static Future registerUserFirestore(
      BuildContext context, UserModel user) async {
    final QuerySnapshot emailResult = await Future.value(
        users.where("email", isEqualTo: user.email).limit(1).get());
    var email = emailResult.docs;
    final QuerySnapshot phoneResult = await Future.value(
        users.where("phoneNumber", isEqualTo: user.phoneNumber).limit(1).get());
    var phone = phoneResult.docs;
    if (email.isEmpty && phone.isEmpty) {
      await createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      // ignore: use_build_context_synchronously
      await verifyPhoneNumber(context, user.phoneNumber!);
      await users.add(user.toJson()).whenComplete(() {
        print("ok");
      }).catchError((error, stactTrace) {
        print(error);
      });
    } else {
      print("email or phone number already registered");
    }
  }

  static Future sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  static Future<String?> getSmsCodeFromUser(BuildContext context) async {
    String? smsCode;

    // Update the UI - wait for the user to enter the SMS code
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('SMS code:'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Sign in'),
            ),
            OutlinedButton(
              onPressed: () {
                smsCode = null;
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          content: Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                smsCode = value;
              },
              textAlign: TextAlign.center,
              autofocus: true,
            ),
          ),
        );
      },
    );

    return smsCode;
  }
}
