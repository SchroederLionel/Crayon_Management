class Lecture {
  String id;
  String pid;
  String title;

  List<LectureDate> dates;

  Lecture(
      {required this.id,
      required this.pid,
      required this.title,
      required this.dates});
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
}
