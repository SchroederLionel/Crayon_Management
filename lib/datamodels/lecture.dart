class Lecture {
  late final String path = 'lectures';
  late final String? id;
  late final String? title;
  late String? uid;
  List<LectureDate> lectureDates = <LectureDate>[];
  List<Slide> slides = <Slide>[];

  Lecture({
    this.uid,
    this.id,
    this.title,
  });

  setSlides(List<Slide> slides) => this.slides = slides;
  setLectureDates(List<LectureDate> lectureDates) =>
      this.lectureDates = lectureDates;

  factory Lecture.fromJson(Map<String, dynamic>? json) {
    final id = json!['id'] as String;
    final title = json['title'] as String;

    final slidesData = json['slides'] as List<dynamic>?;
    final slides = slidesData != null
        ? slidesData.map((slide) => Slide.fromJson(slide)).toList()
        : <Slide>[];

    // Cast to a nullable list as the lectureDates may be missing.
    final lectureDates = json['lectureDates'] as List<dynamic>?;
    // if the lecture dates are not missing

    final lectures = lectureDates != null
        ? lectureDates
            .map((lectureDate) => LectureDate.fromJson(lectureDate))
            .toList()
        : <LectureDate>[];

    Lecture currentLecture = Lecture(id: id, title: title);
    currentLecture.setSlides(slides);
    currentLecture.setLectureDates(lectures);
    return currentLecture;
  }
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "id": id,
        "title": title,
        "lectureDates":
            lectureDates.map((lectureDate) => lectureDate.toJson()).toList(),
        "slides": slides.map((slide) => slide.toJson()).toList()
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

class Slide {
  final String title;
  final String fileId;
  Slide({required this.title, required this.fileId});

  factory Slide.fromJson(Map<String, dynamic>? json) {
    final title = json!['title'];
    final fileId = json['fileId'];

    return Slide(
      title: title,
      fileId: fileId,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'fileId': fileId,
      };
}
