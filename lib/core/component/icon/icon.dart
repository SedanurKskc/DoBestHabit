import 'package:flutter/material.dart';
import '../../base/state/base_state.dart';

class IconWidget extends BaseStateless {
  final IconData icon;
  final Function() onPressed;

  IconWidget({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: CircleAvatar(
          backgroundColor: colorScheme(context).background,
          child: Icon(icon, color: colorScheme(context).primary, size: sizes.s20),
        ),
      ),
    );
  }
}
