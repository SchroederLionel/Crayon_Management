import 'package:crayon_management/datamodels/lecture/lecture_snipped.dart';

class UserData {
  final String path = 'users';

  String uid; // non-nullable
  String email; // non-nullable
  String firstName; // non-nullable
  String lastName; //nullable
  String? office; //nullable
  String? phoneNumber; // non-nullable
  List<LectureSnipped>? myLectures; //nullable

  UserData(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.office,
      this.phoneNumber,
      this.myLectures});

  factory UserData.fromJson(Map<String, dynamic>? json) {
    final uid = json!['uid'] as String;
    final email = json['email'] as String;
    final firstName = json['firstName'] as String;
    final lastName = json['lastName'] as String;
    final office = json['office'];
    final phoneNumber = json['phoneNumber'];
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
        myLectures: lectures,
        office: office,
        phoneNumber: phoneNumber);
  }

  // lectureDates.map((date) => date.toJson()
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'myLectures':
            myLectures!.map((lectureSnipped) => lectureSnipped.toJson()),
        'lastName': lastName,
        'office': office,
        'phoneNumber': phoneNumber,
      };

  Map<String, dynamic> toJsonWithoutLectures() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'office': office,
        'phoneNumber': phoneNumber,
      };

  @override
  bool operator ==(other) {
    return (other is UserData) &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.office == office &&
        other.phoneNumber == phoneNumber;
  }
}
