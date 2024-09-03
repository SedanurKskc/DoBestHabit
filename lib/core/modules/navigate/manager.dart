import 'package:flutter/material.dart';
import 'base.dart';
export 'path.dart';
export 'route.dart';

class NavigationManager implements BaseNavigationService {
  static NavigationManager? _instance;
  static NavigationManager get instance {
    _instance ??= NavigationManager._init();
    return _instance!;
  }

  NavigationManager._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  removeOldRoutes() => (Route<dynamic> route) => false;

  @override
  Future nav({required String path, Object? arguments}) async {
    return await navigatorKey.currentState!.pushNamed(path, arguments: arguments);
  }

  @override
  Future<void> replace({required String path, Object? arguments}) async {
    await navigatorKey.currentState!.pushReplacementNamed(path, arguments: arguments);
  }

  @override
  Future<void> clear({required String path, Object? arguments}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(path, removeOldRoutes(), arguments: arguments);
  }

  @override
  Future<void> pop<T extends Object?>({T? res}) async {
    return navigatorKey.currentState!.pop<T>(res);
  }

  @override
  Future<void> popUntil({required int viewCount}) async {
    int count = viewCount;
    navigatorKey.currentState!.popUntil((_) => count-- <= 0);
  }

  @override
  Future<void> popHome() async {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
