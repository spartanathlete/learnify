import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/utils/strings.dart';

class ActiveLessonCard extends StatelessWidget {
  const ActiveLessonCard({
    required this.child,
    required this.onPressedSeeAll,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final Widget child;
  final Function() onPressedSeeAll;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _title(
                  (themeProvider.lang == 'fr')
                      ? Strings.translations['tea_mem0']!['fr']!
                      : Strings.translations['tea_mem0']!['en']!,
                  themeProvider,
                ),
                _seeAllButton(onPressed: onPressedSeeAll),
              ],
            ),
            Divider(
              thickness: 1,
              height: kSpacing,
              color: (themeProvider.isDarkTheme)
                  ? null
                  : const Color.fromARGB(255, 255, 255, 255),
            ),
            const SizedBox(height: kSpacing),
            child,
          ],
        ),
      ),
    );
  }

  Widget _title(String value, ThemeProvider themeProvider) {
    return Text(
      value,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: (themeProvider.isDarkTheme)
            ? null
            : const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  Widget _seeAllButton({required Function() onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: kFontColorPallets[1]),
      child: Text(
        (themeProvider.lang == 'fr')
            ? Strings.translations['act_les1']!['fr']!
            : Strings.translations['act_les1']!['en']!,
      ),
    );
  }
}
