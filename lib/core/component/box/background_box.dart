import 'package:flutter/material.dart';

import '../../base/state/base_state.dart';


class BackgroundBox extends BaseStateless {
  BackgroundBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight(context),
      width: deviceWidth(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ColorUtility.primary,
            ColorUtility.secondary,
          ],
          stops: const [0.4, 1.0],
        ),
      ),
    );
  }
}
