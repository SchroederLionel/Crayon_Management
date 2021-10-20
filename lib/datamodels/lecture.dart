import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Lecture {
  final String path = 'lectures';
  final String id;
  final String title;
  String? uid;
  final List<LectureDate> lectureDates;

  Lecture(
      {this.uid,
      required this.id,
      required this.title,
      required this.lectureDates});

  factory Lecture.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final title = json['title'] as String;
    // Cast to a nullable list as the lectureDates may be missing.
    final lectureDates = json['lectureDates'] as List<dynamic>?;
    // if the lecture dates are not missing

    final lectures = lectureDates != null
        ? lectureDates
            .map((lectureDate) => LectureDate.fromJson(lectureDate))
            .toList()
        : <LectureDate>[];

    return Lecture(id: id, title: title, lectureDates: lectures);
  }
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "id": id,
        "title": title,
        "lectureDates":
            lectureDates.map((lectureDate) => lectureDate.toJson()).toList()
      };

  Map<String, dynamic> toJsonForUser() => {
        "id": id,
        "title": title,
        "lectureDates":
            lectureDates.map((lectureDate) => lectureDate.toJson()).toList()
      };

  void setUid(String uid) => this.uid = uid;
}

class LectureDate {
  String room;
  String day;
  String starting_time;
  String ending_time;
  String type;

  LectureDate(
      {required this.room,
      required this.day,
      required this.starting_time,
      required this.ending_time,
      required this.type});

  factory LectureDate.fromJson(Map<String, dynamic>? json) {
    final room = json!['room'];
    final day = json['day'];
    final starting_time = json['startingTime'];
    final ending_time = json['endingTime'];
    final type = json['type'];

    return LectureDate(
        room: room,
        day: day,
        starting_time: starting_time,
        ending_time: ending_time,
        type: type);
  }

  Map<String, dynamic> toJson() => {
        'room': room,
        'day': day,
        'startingTime': starting_time,
        'endingTime': ending_time,
        'type': type
      };
}
