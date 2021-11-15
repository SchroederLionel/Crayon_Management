import 'package:crayon_management/datamodels/lecture/custom_time_of_day.dart';

class LectureDate {
  String room;
  String day;
  CustomTimeOfDay startingTime;
  CustomTimeOfDay endingTime;
  String type;

  LectureDate(
      {required this.room,
      required this.day,
      required this.startingTime,
      required this.endingTime,
      required this.type});

  factory LectureDate.fromJson(Map<String, dynamic>? json) {
    final room = json!['room'];
    final day = json['day'];
    final startingTime = CustomTimeOfDay.fromJson(json['startingTime']);
    final endingTime = CustomTimeOfDay.fromJson(json['endingTime']);
    final type = json['type'];

    return LectureDate(
        room: room,
        day: day,
        startingTime: startingTime,
        endingTime: endingTime,
        type: type);
  }

  Map<String, dynamic> toJson() => {
        'room': room,
        'day': day,
        'startingTime': startingTime.toJson(),
        'endingTime': endingTime.toJson(),
        'type': type
      };
}
