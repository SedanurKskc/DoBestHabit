import 'dart:ui';
import 'package:flutter/material.dart';
import '../../setup.dart';
import 'theme.dart';

class AppThemeManager {
  static AppThemeManager? _instance;
  static AppThemeManager get instance {
    _instance ??= AppThemeManager._init();
    return _instance!;
  }

  AppThemeManager._init();

  ThemeData theme() {
    if (ApplicationSetup.multiThemeActive) {
      if (PlatformDispatcher.instance.platformBrightness == Brightness.dark) {
        return Themes().dark;
      } else {
        return Themes().light;
      }
    } else {
      return Themes().light;
    }
  }
}
