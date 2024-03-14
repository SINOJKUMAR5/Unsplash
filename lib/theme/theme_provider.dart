import 'package:flutter/material.dart';
import 'package:unsplash/theme/dark_theme.dart';
import 'package:unsplash/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = dark_theme;

  ThemeData get themeData {
    return _themeData;
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;

    notifyListeners();
  }

  bool get isdark => _themeData == dark_theme;

  void toggle() {
    if (_themeData == dark_theme) {
      themeData = light_theme;
    } else {
      themeData = dark_theme;
    }
  }
}
