import 'package:flutter/material.dart';
import 'package:notes/themes/theme.dart';

class ThemeProvider extends ChangeNotifier {
  // initial theme
  ThemeData _themeData = lightMode;

  // getter to access the current theme
  ThemeData get themeData => _themeData;

  // getter to check wheter current theme is dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  // setter to set new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // method to toggle between dark mode and light mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
  }
}
