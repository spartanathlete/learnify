import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/utils/strings.dart';

class TeamMember extends StatelessWidget {
  const TeamMember({
    Key? key,
    required this.totalMember,
    required this.onPressedAdd,
    required this.themeProvider,
  }) : super(key: key);

  final int totalMember;
  final Function() onPressedAdd;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kFontColorPallets[0],
            ),
            children: [
              TextSpan(
                text: (themeProvider.lang == 'fr')
                    ? Strings.translations['tea_mem0']!['fr']!
                    : Strings.translations['tea_mem0']!['en']!,
                style: (themeProvider.isDarkTheme)
                    ? null
                    : const TextStyle(
                        color: Color.fromARGB(255, 39, 38, 67),
                      ),
              ),
              TextSpan(
                text: "($totalMember)",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: kFontColorPallets[2],
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onPressedAdd,
          icon: const Icon(EvaIcons.plus),
          tooltip: (themeProvider.lang == 'fr')
              ? Strings.translations['tea_mem1']!['fr']!
              : Strings.translations['tea_mem1']!['en']!,
        )
      ],
    );
  }
}
