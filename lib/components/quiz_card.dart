import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';

class QuizCardData {
  final String name;
  final int length;
  final bool success;
  final bool inProgress;

  const QuizCardData({
    required this.inProgress,
    required this.name,
    required this.length,
    required this.success,
  });
}

class QuizCard extends StatelessWidget {
  const QuizCard({
    Key? key,
    required this.data,
    required this.onPressed,
    // required this.isDone,
    required this.themeProvider,
  }) : super(key: key);

  // final bool isDone;
  final QuizCardData data;
  final Function()? onPressed;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          ListTile(
            tileColor: (data.inProgress)
                ? const Color.fromARGB(225, 44, 105, 141)
                : null,
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
              "${data.length} Questions",
              style: TextStyle(
                fontSize: 11,
                color: kFontColorPallets[2],
              ),
            ),
            onTap: onPressed,
            trailing: (data.success)
                ? const Icon(
                    size: 30,
                    Icons.check,
                    color: Color.fromARGB(255, 65, 155, 70),
                  )
                : const Icon(
                    size: 30,
                    Icons.close,
                    color: Color.fromARGB(255, 220, 60, 50),
                  ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
