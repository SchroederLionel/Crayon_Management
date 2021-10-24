import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';

class UserData {
  final String path = 'users';

  String uid; // non-nullable
  String email; // non-nullable
  String firstName; // non-nullable
  String lastName; // non-nullable
  List<LectureSnipped>? myLectures; //nullable

  UserData(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.myLectures});

  factory UserData.fromJson(Map<String, dynamic>? json) {
    final uid = json!['uid'] as String;
    final email = json['email'] as String;
    final firstName = json['firstName'] as String;
    final lastName = json['lastName'] as String;
    // Cast to a nullable list as the Lectures may be missing.
    final lecturesData = json['myLectures'] as List<dynamic>?;

    // if the lecture dates are not missing
    final lectures = lecturesData != null
        ? lecturesData
            .map((lecture) => LectureSnipped.fromJson(lecture))
            .toList()
        : <LectureSnipped>[];

    return UserData(
        uid: uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        myLectures: lectures);
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      };
}
