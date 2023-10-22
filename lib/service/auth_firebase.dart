import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFirebase {
  AuthFirebase._();
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

  static Future signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    await firebaseAuth.signInWithPhoneNumber(phoneNumber);
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
          // Create a PhoneAuthCredential with the code
          final credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          try {
            // Sign the user in (or link) with the credential
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
