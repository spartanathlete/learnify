import 'package:learnify/models/profile.dart';

class CommentModel {
  final Profile user;
  final String comment;
  final DateTime dateTime;
  final List<CommentModel> replies;

  CommentModel({
    required this.user,
    required this.comment,
    required this.dateTime,
    required this.replies,
  });
}
