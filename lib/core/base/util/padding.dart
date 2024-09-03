import 'package:flutter/material.dart';

class PaddingUtility {
  ///all
  EdgeInsets a(double padding) => EdgeInsets.all(padding);

  ///vertical
  EdgeInsets v(double padding) => EdgeInsets.symmetric(vertical: padding);

  ///horizontal
  EdgeInsets h(double padding) => EdgeInsets.symmetric(horizontal: padding);

  ///left
  EdgeInsets l(double padding) => EdgeInsets.only(left: padding);

  ///right
  EdgeInsets r(double padding) => EdgeInsets.only(right: padding);

  ///top
  EdgeInsets t(double padding) => EdgeInsets.only(top: padding);

  ///bottom
  EdgeInsets b(double padding) => EdgeInsets.only(bottom: padding);
}
