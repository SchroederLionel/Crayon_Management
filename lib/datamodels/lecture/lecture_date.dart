class LectureDate {
  String room;
  String day;
  String startingTime;
  String endingTime;
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
    final startingTime = json['startingTime'];
    final endingTime = json['endingTime'];
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
        'startingTime': startingTime,
        'endingTime': endingTime,
        'type': type
      };
}
