import 'package:flutter/material.dart';
import '../theme/manager.dart';
import '../theme/theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeManager.instance.theme();
  ThemeData get currentTheme => _currentTheme;

  void changeAppTheme(AppThemes theme) {
    if (theme == AppThemes.light) {
      _currentTheme = Themes().light;
    } else {
      _currentTheme = Themes().dark;
    }
    notifyListeners();
  }
}

enum AppThemes { light, dark }
