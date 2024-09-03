import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../base/state/base_state.dart';
import '../../constant/button_variant.dart';
export '../../constant/button_variant.dart';

class AppButton extends StatefulWidget {
  final ButtonVariant variant;
  final String title;
  final Function() onPressed;
  final double? padding;
  final double? innerPadding;
  final double? width;

  const AppButton({
    required this.variant,
    required this.title,
    required this.onPressed,
    this.padding,
    this.innerPadding,
    this.width,
    Key? key,
  }) : super(key: key);

  const AppButton.zero({
    required this.variant,
    required this.title,
    required this.onPressed,
    this.padding = 0.0,
    this.innerPadding = 0.0,
    this.width,
    Key? key,
  }) : super(key: key);

  const AppButton.fixed({
    required this.variant,
    required this.title,
    required this.onPressed,
    this.padding = 0.0,
    this.innerPadding = 0.0,
    this.width = 230.0,
    Key? key,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends BaseState<AppButton> {
  Color get color {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return colorScheme.primary;
      case ButtonVariant.secondary:
        return colorScheme.primary;
      case ButtonVariant.light:
        return colorScheme.surface;
      case ButtonVariant.disabled:
        return colorScheme.primary;
    }
  }

  Color get textColor {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return colorScheme.surface;
      case ButtonVariant.secondary:
        return colorScheme.onSurface;
      case ButtonVariant.light:
        return colorScheme.primary;
      case ButtonVariant.disabled:
        return colorScheme.primary;
    }
  }

  Future<void> onPressed() async {
    if (isLoading) return;
    changeLoading();
    try {
      await widget.onPressed();
      changeLoading();
    } catch (e) {
      Logger().e(e);
      changeLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddings.h(widget.padding ?? sizes.s60),
      child: InkWell(
        onTap: () async => await onPressed(),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(sizes.s8)),
        ),
        child: Container(
          height: sizes.s60,
          width: widget.width,
          padding: paddings.h(widget.innerPadding ?? 0),
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(sizes.s8)),
            ),
            shadows: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 10,
                color: colorScheme.onSurface.withOpacity(0.1),
              )
            ],
          ),
          child: Center(
            child: Visibility(
              visible: !isLoading,
              replacement: CircularProgressIndicator(color: textColor),
              child: Text(
                widget.title,
                style: textTheme.headlineMedium!.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
