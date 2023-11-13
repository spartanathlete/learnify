import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily: Font.poppins,
      primarySwatch: Colors.cyan,
      primaryColor:
          isDarkTheme ? const Color.fromARGB(255, 255, 255, 255) : Colors.white,
      scaffoldBackgroundColor: isDarkTheme
          ? const Color.fromARGB(255, 15, 14, 28)
          : const Color(0xffF1F5FB),
      indicatorColor: isDarkTheme
          ? const Color(
              0xff0E1D36,
            )
          : const Color(
              0xffCBDCF8,
            ),
      hintColor: isDarkTheme
          ? const Color(
              0xff280C0B,
            )
          : const Color(
              0xffEECED3,
            ),
      highlightColor: isDarkTheme
          ? const Color(
              0xff372901,
            )
          : const Color.fromARGB(255, 186, 232, 232),
      hoverColor: isDarkTheme
          ? const Color(
              0xff3A3A3B,
            )
          : const Color.fromARGB(255, 44, 105, 141),
      focusColor: isDarkTheme
          ? const Color(
              0xff0B2512,
            )
          : const Color(
              0xffA8DAB5,
            ),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 24, 42, 61)
          : const Color.fromARGB(255, 65, 60, 110),
      canvasColor: isDarkTheme
          ? const Color.fromARGB(255, 80, 94, 108)
          : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
