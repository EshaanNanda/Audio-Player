import 'package:audio_player/theme/dark_theme.dart';
import 'package:audio_player/theme/light_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //initially, light mode
  ThemeData _themeData = lightmode;

  //get theme
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkmode;

  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

//toggle theme
  void toggleTheme() {
    if (_themeData == lightmode) {
      themeData = darkmode;
    } else {
      themeData = lightmode;
    }
  }
}
