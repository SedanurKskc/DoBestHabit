import 'package:flutter/material.dart';

enum SnackType {
  error(Color(0xffF7444E), "Error"),
  warning(Color(0xffFD9D42), "Warning"),
  success(Color(0xff328048), "Success");

  final Color color;
  final String message;
  const SnackType(this.color, this.message);
}
