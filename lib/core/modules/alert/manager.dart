import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'snack.dart';
export 'snack.dart';

class AlertManager {
  static AlertManager? _instance;
  static AlertManager get instance {
    _instance ??= AlertManager._init();
    return _instance!;
  }

  AlertManager._init();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void showSnack(SnackType type, {String? message}) {
    SnackBar snackBar = SnackBar(
      content: Text(message ?? type.message),
      backgroundColor: type.color,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    Logger().d("$type Snackbar Called with message: ${message ?? type.message}");
  }

  Future dialog(BuildContext context, {required Widget child, bool barrierDismissible = true}) async {
    return await showDialog(barrierDismissible: barrierDismissible, context: context, builder: (context) => child);
  }
}
