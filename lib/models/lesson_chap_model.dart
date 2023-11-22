class LessonChapModel {
  final String? id;
  final String title;
  final String subTitle;
  final int beginAt;

  const LessonChapModel({
    this.id,
    required this.beginAt,
    required this.subTitle,
    required this.title,
  });

  factory LessonChapModel.fromJson({
    required Map<String, dynamic> map,
    required String id,
  }) {
    return LessonChapModel(
      id: id,
      beginAt: map["beginAt"] ?? 0,
      subTitle: map["subTitle"] ?? '',
      title: map["title"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'beginAt': beginAt,
      'subTitle': subTitle,
      'title': title,
    };
  }
}
