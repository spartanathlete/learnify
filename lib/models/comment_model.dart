import 'package:learnify/models/user_model.dart';

class CommentModel {
  final String? id;
  final String? user;
  final String? comment;
  final String? pubDate;
  final List<CommentModel>? replies;

  CommentModel({
    this.id,
    this.user,
    this.comment,
    this.pubDate,
    this.replies,
  });

  factory CommentModel.fromJson({
    required Map<String, dynamic> map,
    required String id,
  }) {
    return CommentModel(
      id: id,
      user: map["user"] ?? '',
      comment: map["comment"] ?? '',
      pubDate: map["pubDate"] ?? '',
      // replies: map["replies"] ?? [],
    );
  }

  toJson() {
    return {
      'user': user ?? '',
      'comment': comment ?? '',
      'pubDate': DateTime.now().toString(),
      // 'replies': replies ?? [],
    };
  }
}
