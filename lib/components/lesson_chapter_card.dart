import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/models/lesson_chap_model.dart';
import 'package:learnify/providers/theme_provider.dart';

class LessonChapterCard extends StatelessWidget {
  final bool isDone;

  const LessonChapterCard({
    Key? key,
    required this.data,
    required this.onPressed,
    required this.isDone,
    required this.themeProvider,
  }) : super(key: key);

  final LessonChapModel data;
  final Function()? onPressed;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            data.title,
            style: TextStyle(
              fontSize: 13,
              color: (themeProvider.isDarkTheme)
                  ? kFontColorPallets[0]
                  : const Color.fromARGB(255, 39, 38, 67),
            ),
          ),
          subtitle: Text(
            data.subTitle,
            style: TextStyle(
              fontSize: 11,
              color: kFontColorPallets[2],
            ),
          ),
          onTap: onPressed,
          trailing: Icon(
            size: 30,
            Icons.check,
            color: isDone ? Colors.grey : Colors.green,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
