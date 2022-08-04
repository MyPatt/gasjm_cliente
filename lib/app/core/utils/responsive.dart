import 'package:flutter/material.dart';

class Responsive {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double wp(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double hp(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
