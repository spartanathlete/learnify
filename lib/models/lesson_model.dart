import 'package:flutter/cupertino.dart';
import 'package:learnify/utils/helpers/app_helpers.dart';

class LessonModel {
  final String lessonUrl;
  final String title;
  final String subTitle;
  final List<ImageProvider> profilContributors;
  final LessonCategory type;
  final int totalComments;
  final int totalContributors;

  const LessonModel({
    required this.lessonUrl,
    required this.title,
    required this.subTitle,
    required this.totalComments,
    required this.totalContributors,
    required this.type,
    required this.profilContributors,
  });
}
