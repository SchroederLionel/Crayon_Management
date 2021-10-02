enum LectureType { lecture, exercise }

class Lecture {
  String id;
  String pid;
  String title;
  String lastPowerPointTitle;
  String image = '';
  List<LectureDate> dates;

  Lecture(
      {required this.id,
      required this.pid,
      required this.title,
      required this.lastPowerPointTitle,
      this.image = '',
      required this.dates});
}

class LectureDate {
  String room;
  String day;
  String starting_time;
  String ending_time;
  LectureType type;

  LectureDate(
      {required this.room,
      required this.day,
      required this.starting_time,
      required this.ending_time,
      required this.type});
}
