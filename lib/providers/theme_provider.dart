import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:learnify/config/themes/theme_preferences.dart';
import 'package:learnify/models/user_model.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserById() async {
    try {
      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.toString())
          .get();

      // If the user document exists, return a UserModel
      return UserModel.fromJson(
        map: userSnapshot.data() as Map<String, dynamic>,
        id: userSnapshot.id,
      );
    } catch (error) {
      // Handle any errors that might occur during the process
      print('Error retrieving user: $error');
      return null;
    }
  }
}
