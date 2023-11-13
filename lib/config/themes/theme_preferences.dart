import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const themeStatus = "THEMESTATUS";
  static const langStatus = "LANGSTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }

  setLang(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(langStatus, value);
  }

  Future<String> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(langStatus) ?? 'fr';
  }
}
