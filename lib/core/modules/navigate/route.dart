import 'dart:io' show Platform;
import 'package:dobesthabit/product/gemini/gemini_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../product/habits/habits_view.dart';

import '../../../product/home/home_view.dart';
import '../../../product/motivation/motivation_view.dart';
import '../../../product/onboarding/onboarding_view.dart';
import '../../../product/progress/progress_view.dart';
import '../../../product/splash/splash_view.dart';
import '../../base/view/not_found.dart';
import 'path.dart';

class NavigationRoute {
  static NavigationRoute? _instance;
  static NavigationRoute get instance {
    _instance ??= NavigationRoute._init();
    return _instance!;
  }

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavPath.splash:
        return normalNavigate(const SplashView());
      case NavPath.home:
        return normalNavigate( HomeView());
      case NavPath.onboarding:
        return normalNavigate(const OnboardingView());
      case NavPath.habits:
        return normalNavigate( HabitsView());
      case NavPath.progress:
        return normalNavigate( ProgressView());
      case NavPath.motivation:
        return normalNavigate( MotivationView());
      case NavPath.gemini:
        return normalNavigate( GeminiView());
      default:
        return normalNavigate(NotFoundView());
    }
  }

  PageRoute normalNavigate(Widget widget) {
    return Platform.isAndroid ? MaterialPageRoute(builder: (context) => widget) : CupertinoPageRoute(builder: (context) => widget);
  }

  PageRoute normalNavigateToPop(Widget widget) {
    return Platform.isAndroid ? MaterialPageRoute(builder: (context) => widget) : CupertinoPageRoute(builder: (context) => widget, fullscreenDialog: true);
  }
}
