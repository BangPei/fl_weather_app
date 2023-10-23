// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_app/common/common.dart';
import 'package:weather_app/models/user_model.dart';

class AuthFirebase {
  AuthFirebase._();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static User? get currUser => firebaseAuth.currentUser;

  static CollectionReference users =
      FirebaseFirestore.instance.collection('user');

  static Stream<User?> get authState => firebaseAuth.authStateChanges();

  static Future<UserModel> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    firebaseAuth.signInWithCredential(credential);
    UserModel user = UserModel(
      email: gUser.email,
      fullname: gUser.displayName,
      phoneNumber: "",
    );
    return user;
  }

  static Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final QuerySnapshot emailResult =
        await users.where("email", isEqualTo: email).get();
    if (emailResult.docs.isEmpty) {
      return null;
    }
    var data = emailResult.docs[0].data() as Map<String, dynamic>;
    UserModel user = UserModel.fromJson(data);
    return user;
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
          final credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          await firebaseAuth.signInWithCredential(credential);
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print(verificationId);
      },
    );

    final QuerySnapshot phoneResult =
        await users.where("phoneNumber", isEqualTo: phone).get();
    if (phoneResult.docs.isEmpty) {
      return null;
    }
    var data = phoneResult.docs[0].data() as Map<String, dynamic>;
    UserModel user = UserModel.fromJson(data);
    return user;
  }

  static Future signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }

  static Future<UserModel> registerUserFirestore(
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
      await verifyPhoneNumber(context, user.phoneNumber!);
      await users.add(user.toJson()).whenComplete(() {
        print("ok");
      });
    } else {
      Common.modalInfo(
        context,
        title: "Email or Phone number already registered",
        message: "Error",
      );
    }
    return user;
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
