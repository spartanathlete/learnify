import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/utils/strings.dart';

class SideList extends StatelessWidget {
  const SideList({
    required this.onPressedMore,
    Key? key,
    required this.themeProvider,
    required this.title,
  }) : super(key: key);

  final String title;
  final Function() onPressedMore;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          EvaIcons.book,
          color: (themeProvider.isDarkTheme)
              ? Theme.of(context).primaryColor
              : const Color.fromARGB(255, 39, 38, 67),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          // (themeProvider.lang == 'fr')
          //     ? Strings.translations['les_cha0']!['fr']!
          //     : Strings.translations['les_cha0']!['en']!,
          style: TextStyle(
            color: (themeProvider.isDarkTheme)
                ? Theme.of(context).primaryColor
                : const Color.fromARGB(255, 39, 38, 67),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressedMore,
          icon: const Icon(EvaIcons.moreVertical),
          tooltip: (themeProvider.lang == 'fr')
              ? Strings.translations['rec_mes1']!['fr']!
              : Strings.translations['rec_mes1']!['en']!,
        )
      ],
    );
  }
}
