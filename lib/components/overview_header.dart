import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/utils/helpers/app_helpers.dart';
import 'package:learnify/utils/strings.dart';

class OverviewHeader extends StatelessWidget {
  const OverviewHeader({
    required this.onSelected,
    this.axis = Axis.horizontal,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final Function(LessonCategory? task) onSelected;
  final Axis axis;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    // final Rx<LessonCategory?> task = Rx(null);

    return (axis == Axis.horizontal)
        ? Row(
            children: [
              Text(
                (themeProvider.lang == 'fr')
                    ? Strings.translations['les_ove0']!['fr']!
                    : Strings.translations['les_ove0']!['en']!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              ..._listButton(
                context: context,
                themeProvider: themeProvider,
                task: LessonCategory.algebra,
                onSelected: (value) {
                  // task.value = value;
                  // onSelected(value);
                  log("onSelect Activated");
                },
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (themeProvider.lang == 'fr')
                    ? Strings.translations['les_ove0']!['fr']!
                    : Strings.translations['les_ove0']!['en']!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: _listButton(
                    context: context,
                    themeProvider: themeProvider,
                    task: LessonCategory.algebra,
                    onSelected: (value) {
                      // task.value = value;
                      // onSelected(value);
                      log("onSelect Activated");
                    },
                  ),
                ),
              ),
            ],
          );
  }

  List<Widget> _listButton({
    required BuildContext context,
    required LessonCategory? task,
    required Function(LessonCategory? value) onSelected,
    required ThemeProvider themeProvider,
  }) {
    return [
      _button(
        context: context,
        themeProvider: themeProvider,
        selected: task == null,
        label: (themeProvider.lang == 'fr')
            ? Strings.translations['les_ove1']!['fr']!
            : Strings.translations['les_ove1']!['en']!,
        onPressed: () {
          // task = null;
          // onSelected(null);
        },
      ),
      _button(
        context: context,
        themeProvider: themeProvider,
        selected: task == LessonCategory.calculus,
        label: (themeProvider.lang == 'fr')
            ? Strings.translations['les_ove2']!['fr']!
            : Strings.translations['les_ove2']!['en']!,
        onPressed: () {
          // task = LessonCategory.todo;
          // onSelected(LessonCategory.todo);
        },
      ),
      _button(
        context: context,
        themeProvider: themeProvider,
        selected: task == LessonCategory.geometry,
        label: (themeProvider.lang == 'fr')
            ? Strings.translations['les_ove3']!['fr']!
            : Strings.translations['les_ove3']!['en']!,
        onPressed: () {
          // task = LessonCategory.geometry;
          // onSelected(LessonCategory.geometry);
        },
      ),
      _button(
        context: context,
        themeProvider: themeProvider,
        selected: task == LessonCategory.geometry,
        label: (themeProvider.lang == 'fr')
            ? Strings.translations['les_ove4']!['fr']!
            : Strings.translations['les_ove4']!['en']!,
        onPressed: () {
          // task = LessonCategory.geometry;
          // onSelected(LessonCategory.geometry);
        },
      ),
    ];
  }

  Widget _button({
    required BuildContext context,
    required bool selected,
    required String label,
    required Function() onPressed,
    required ThemeProvider themeProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: selected
              ? (themeProvider.isDarkTheme)
                  ? const Color.fromARGB(255, 49, 49, 85)
                  : const Color.fromARGB(255, 146, 166, 199)
              : (themeProvider.isDarkTheme)
                  ? const Color.fromARGB(255, 80, 80, 129)
                  : const Color.fromARGB(255, 170, 190, 220),
          foregroundColor: (themeProvider.isDarkTheme)
              ? (selected ? kFontColorPallets[0] : kFontColorPallets[2])
              : (selected
                  ? const Color.fromARGB(255, 39, 38, 67)
                  : const Color.fromARGB(255, 70, 69, 121)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: (themeProvider.isDarkTheme)
                ? const Color.fromARGB(255, 225, 225, 225)
                : const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
