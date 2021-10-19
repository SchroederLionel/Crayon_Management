class Lecture {
  final String path = 'lectures';
  String id;
  String title;

  List<LectureDate> lectures;

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        id: json['id'],
        title: json['title'],
        lectures: List<LectureDate>.from(json["lectures"]
            .map((singleLecture) => LectureDate.fromJson(singleLecture))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "lectures": List<LectureDate>.from(
            lectures.map((LectureDate singleLecture) => singleLecture.toJson()))
      };

  Lecture({required this.id, required this.title, required this.lectures});
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

  LectureDate.fromJson(Map<String, dynamic>? json)
      : room = json!['room'],
        day = json['day'],
        starting_time = json['starting_time'],
        ending_time = json['ending_time'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'room': room,
        'day': day,
        'startingTime': starting_time,
        'endingTime': ending_time,
        'type': type
      };
}
