import 'package:flutter/material.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/providers/theme_provider.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.total,
    required this.onPressed,
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final IconData icon;
  final int total;
  final Function() onPressed;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: (themeProvider.isDarkTheme)
            ? const Color.fromARGB(255, 80, 94, 108)
            : const Color.fromARGB(255, 44, 105, 141),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
      ),
      onPressed: onPressed,
      icon: _icon(icon, themeProvider),
      label: _label("$total", themeProvider),
    );
  }

  Widget _label(String data, ThemeProvider provider) {
    return Text(
      style: (provider.isDarkTheme)
          ? const TextStyle(
              color: Colors.white54,
              fontSize: 10,
            )
          : const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      data,
    );
  }

  Widget _icon(IconData iconData, ThemeProvider provider) {
    return Icon(
      iconData,
      color: (provider.isDarkTheme)
          ? const Color.fromARGB(255, 255, 255, 255)
          : Colors.white54,
      size: 14,
    );
  }
}
