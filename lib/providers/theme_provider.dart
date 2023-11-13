import 'package:flutter/foundation.dart';
import 'package:learnify/config/themes/theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference themePreference = ThemePreference();
  bool _theme = false;
  bool get isDarkTheme => _theme;

  ThemePreference langPreference = ThemePreference();
  String _lang = 'fr';
  String get lang => _lang;

  set setDarkTheme(bool value) {
    _theme = value;
    themePreference.setDarkTheme(value);
    notifyListeners();
  }

  set setLang(String value) {
    _lang = value;
    themePreference.setLang(value);
    notifyListeners();
  }
}
