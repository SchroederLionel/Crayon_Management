import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crayon_management/datamodels/user/user_data.dart';

class UserService {
  static updateUser(UserData userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userData.uid)
        .set(userData.toJsonWithoutLectures(), SetOptions(merge: true));
  }
}
