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
