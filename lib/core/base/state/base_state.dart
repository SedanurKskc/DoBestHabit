import 'package:flutter/material.dart';
import '../../setup.dart';
import '../util/color.dart';
import '../util/padding.dart';
import '../util/size.dart';
export '../util/color.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => Theme.of(context);
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
  TextTheme get textTheme => Theme.of(context).textTheme;
  TextTheme get primaryTextTheme => Theme.of(context).primaryTextTheme;
  double get deviceHeight => MediaQuery.of(context).size.height;
  double get deviceWidth => MediaQuery.of(context).size.width;
  double get topPadding => MediaQuery.of(context).padding.top;
  double get bottomPadding => MediaQuery.of(context).padding.bottom;

  ///Loading variable
  bool isLoading = false;

  ///Change loading function
  changeLoading() => setState(() => isLoading = !isLoading);

  ///Color variable
  final ColorUtility colors = ColorUtility();

  ///Padding variable
  final PaddingUtility paddings = PaddingUtility();

  ///Size variable
  final SizeUtility sizes = SizeUtility();

  //Empty bottom padding
  double get emptyBottom => bottomPadding + sizes.s20;

  //Empty top padding
  double get emptyTop => topPadding + kToolbarHeight + sizes.s20;

  ///Manage feature status active or not
  bool get featureActive => ApplicationSetup.featureActive;
}

abstract class BaseStateless extends StatelessWidget {
  BaseStateless({super.key});
  ThemeData themeData(BuildContext context) => Theme.of(context);
  ColorScheme colorScheme(BuildContext context) => Theme.of(context).colorScheme;
  TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
  TextTheme primaryTextTheme(BuildContext context) => Theme.of(context).primaryTextTheme;
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  double topPadding(BuildContext context) => MediaQuery.of(context).padding.top;
  double bottomPadding(BuildContext context) => MediaQuery.of(context).padding.bottom;

  ///Color variable
  final ColorUtility colors = ColorUtility();

  ///Padding variable
  final PaddingUtility paddings = PaddingUtility();

  ///Size variable
  final SizeUtility sizes = SizeUtility();

  ///Manage feature status active or not
  bool get featureActive => ApplicationSetup.featureActive;
}
