import 'package:flutter/material.dart';

/// A convenient [BuildContext] extension that provides
/// quick access to common [MediaQuery] properties.
///
/// Instead of repeatedly writing:
/// ```dart
/// MediaQuery.of(context).size.width
/// ```
/// You can simply use:
/// ```dart
/// context.screenWidth
/// ```
extension MediaQueryExtension on BuildContext {
  /// The total width of the device screen in logical pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// The total height of the device screen in logical pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// The device pixel ratio, i.e. the number of device pixels
  /// for each logical pixel. Useful for working with images and DPI scaling.
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// The top padding of the screen (e.g., status bar or notch area).
  double get topPadding => MediaQuery.paddingOf(this).top;

  /// The bottom padding of the screen (e.g., system navigation bar or gesture area).
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  /// The current orientation of the device (portrait or landscape).
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Returns `true` if the device is in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Returns `true` if the device is in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;
}
