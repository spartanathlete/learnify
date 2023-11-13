import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';

class LessonChapterData {
  final String name;
  final String lastMessage;
  final int beginAt;

  const LessonChapterData({
    required this.beginAt,
    required this.lastMessage,
    required this.name,
  });
}

class LessonChapterCard extends StatelessWidget {
  final bool isDone;

  const LessonChapterCard({
    Key? key,
    required this.data,
    required this.onPressed,
    required this.isDone,
    required this.themeProvider,
  }) : super(key: key);

  final LessonChapterData data;
  final Function()? onPressed;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            data.name,
            style: TextStyle(
              fontSize: 13,
              color: (themeProvider.isDarkTheme)
                  ? kFontColorPallets[0]
                  : const Color.fromARGB(255, 39, 38, 67),
            ),
          ),
          subtitle: Text(
            data.lastMessage,
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
