import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/services/authentication.dart';

class UserService {
  static Future<UserData> updateUser(UserData userData) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.uid)
          .set(userData.toJsonWithoutLectures(), SetOptions(merge: true));
      return userData;
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }

  static Future<UserData> getUserData() async {
    try {
      var userDocument =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!userDocument.exists) {
        throw Failure(code: 'user-not-exists');
      }
      return UserData.fromJson(userDocument.data());
    } on FirebaseException catch (_) {
      throw Failure(code: 'firebase-exception');
    } on SocketException {
      throw Failure(code: 'no-internet');
    } on HttpException {
      throw Failure(code: 'not-found');
    } on FormatException {
      throw Failure(code: 'bad-format');
    }
  }
}
