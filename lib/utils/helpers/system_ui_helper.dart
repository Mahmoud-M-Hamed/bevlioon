import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SystemUIHelper {
  static void configureSystemUIOverlayStyle() =>
      SystemChrome.setSystemUIOverlayStyle(darkSystemUiOverlayStyle());

  static SystemUiOverlayStyle darkSystemUiOverlayStyle({
    Color statusBarColor = Colors.transparent,
    Brightness statusBarIconBrightness = Brightness.dark,
  }) => SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarIconBrightness: statusBarIconBrightness,
  );

  static SystemUiOverlayStyle lightSystemUiOverlayStyle({
    Color statusBarColor = Colors.transparent,
    Brightness statusBarIconBrightness = Brightness.light,
  }) => SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarIconBrightness: statusBarIconBrightness,
  );
}
