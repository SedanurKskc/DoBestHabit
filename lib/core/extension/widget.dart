import 'package:flutter/material.dart';
import '../base/util/color.dart';

extension WidgetExtension on Widget {}

extension ListWidgetExtension on List<Widget> {
  List<Widget> buildWithSpace({double size = 20, bool isFullView = false}) {
    List<Widget> spacedWidgets = [];
    Widget spacer = SizedBox(height: size);

    if (isFullView) spacedWidgets.add(spacer);
    for (int i = 0; i < length; i++) {
      spacedWidgets.add(this[i]);
      if (i < length - 1) spacedWidgets.add(spacer);
    }
    return spacedWidgets;
  }

  List<Widget> buildWithDivider({bool isFullView = false}) {
    List<Widget> spacedWidgets = [];
    Widget spacer = const SizedBox(height: 20);
    Widget divider = Divider(thickness: 1, color: ColorUtility.primary);

    if (isFullView) spacedWidgets.add(spacer);
    for (int i = 0; i < length; i++) {
      spacedWidgets.add(this[i]);
      if (i < length - 1) spacedWidgets.add(divider);
    }
    return spacedWidgets;
  }

  Widget scrollList() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: this),
      ),
    );
  }
}
