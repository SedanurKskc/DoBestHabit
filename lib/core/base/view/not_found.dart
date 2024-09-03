import 'package:flutter/material.dart';
import '../state/base_state.dart';

class NotFoundView extends BaseStateless {
  NotFoundView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        "Page Not Found!\nPlease Try Again Later!",
        textAlign: TextAlign.center,
      ),
    ));
  }
}
