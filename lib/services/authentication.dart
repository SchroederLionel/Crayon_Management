import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// https://firebase.google.com/docs/auth/admin/errors
final FirebaseAuth _auth = FirebaseAuth.instance;
String? uid;
String? userEmail;

Future<UserData> registerWithEmailPassword(
    String email, String password, String firstName, String lastName) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserData userData = UserData(
        uid: userCredential.user!.uid,
        email: email,
        firstName: firstName,
        lastName: lastName);

    await FirebaseFirestore.instance
        .collection(userData.path)
        .doc(userCredential.user!.uid)
        .set(userData.toJson());

    return userData;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw Failure(code: 'weak-password');
    } else if (e.code == 'email-already-in-use') {
      throw Failure(code: 'email-already-exists');
    }
    throw Failure(code: 'firebase-exception');
  } on SocketException {
    throw Failure(code: 'no-internet');
  } on HttpException {
    throw Failure(code: 'not-found');
  } on FormatException {
    throw Failure(code: 'bad-format');
  }
}

Future<UserData> signInWithEmailPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    var userDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    if (!userDocument.exists) {
      throw Failure(code: 'user-not-exists');
    }
    return UserData.fromJson(userDocument.data());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw Failure(code: 'no-user-found');
    } else if (e.code == 'wrong-password') {
      throw Failure(code: 'wrong-password');
    }
    throw Failure(code: 'firebase-exception');
  } on SocketException {
    throw Failure(code: 'no-internet');
  } on HttpException {
    throw Failure(code: 'not-found');
  } on FormatException {
    throw Failure(code: 'bad-format');
  }
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;
  return 'User signed out';
}
