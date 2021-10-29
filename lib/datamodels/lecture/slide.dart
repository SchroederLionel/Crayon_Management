class Slide {
  final String title;
  final String fileId;
  late String url;
  Slide({required this.title, required this.fileId});

  setUrl(String url) => this.url = url;

  factory Slide.fromJson(Map<String, dynamic>? json) {
    final title = json!['title'];
    final fileId = json['fileId'];
    final url = json['url'];
    Slide slide = Slide(title: title, fileId: fileId);
    slide.setUrl(url);
    return slide;
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'fileId': fileId, 'url': url};
}
