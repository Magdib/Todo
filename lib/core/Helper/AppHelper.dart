import 'package:flutter/material.dart';

class AppHelper {
  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static const String lottiePath = "assets/lottie/";
}
