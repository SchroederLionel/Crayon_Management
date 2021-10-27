import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String? uid;
String? userEmail;

Future<User?> registerWithEmailPassword(
    String email, String password, String firstName, String lastName) async {
  User? user;
  print('Password: $password');
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    user = userCredential.user;
    UserData userData = UserData(
        uid: user!.uid, email: email, firstName: firstName, lastName: lastName);

    await FirebaseFirestore.instance
        .collection(userData.path)
        .doc(user.uid)
        .set(userData.toJson());

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;
    }
  } on FirebaseAuthException catch (e) {
    print(e);
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('An account already exists for that email.');
    }
  }

  return user;
}

Future<UserData?> signInWithEmailPassword(String email, String password) async {
  UserData? userData;
  User? user;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;

    if (user != null) {
      uid = user.uid;
      userEmail = user.email;

      var userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth', true);

      if (userDocument.exists) {
        print('Logged IN!');
        userData = UserData.fromJson(userDocument.data());
        return userData;
      }
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided.');
    }

    return null;
  }

  return userData;
}

Future<String> signOut() async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;
  return 'User signed out';
}
