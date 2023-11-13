import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/utils/strings.dart';

class RecentMessages extends StatelessWidget {
  const RecentMessages({
    required this.onPressedMore,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final Function() onPressedMore;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          EvaIcons.messageCircle,
          color: (themeProvider.isDarkTheme)
              ? Theme.of(context).primaryColor
              : const Color.fromARGB(255, 0, 0, 0),
        ),
        const SizedBox(width: 10),
        Text(
          (themeProvider.lang == 'fr')
              ? Strings.translations['rec_mes0']!['fr']!
              : Strings.translations['rec_mes0']!['en']!,
          style: TextStyle(
            color: (themeProvider.isDarkTheme)
                ? Theme.of(context).primaryColor
                : const Color.fromARGB(255, 0, 0, 0),
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
