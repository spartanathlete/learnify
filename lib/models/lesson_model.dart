import 'package:learnify/models/comment_model.dart';

class LessonModel {
  final String? id;
  final String? title;
  final String? subTitle;
  final String? lessonUrl;
  final List<dynamic>? comments;
  final List<dynamic>? likes;
  final String? type;
  final String? pubDate;

  const LessonModel({
    this.pubDate,
    this.id,
    this.title,
    this.subTitle,
    this.lessonUrl,
    this.type,
    this.comments,
    this.likes,
  });

  factory LessonModel.fromJson({
    required Map<String, dynamic> map,
    required String id,
  }) {
    return LessonModel(
      id: id,
      title: map["title"] ?? '',
      subTitle: map["subTitle"] ?? '',
      lessonUrl: map["lessonUrl"] ?? '',
      comments: List.from(map["comments"] ?? []),
      likes: List.from(map["likes"] ?? []),
      type: map['type'] ?? '',
      pubDate: map["pubDate"] ?? '',
    );
  }

  toJson() {
    return {
      'title': title ?? '',
      'subTitle': subTitle ?? '',
      'lessonUrl': lessonUrl ?? '',
      'comments': List.from(comments ?? []),
      'likes': List.from(likes ?? []),
      'type': type ?? '',
      'pubDate': DateTime.now().toString(),
    };
  }
}
