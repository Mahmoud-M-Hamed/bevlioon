import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'app_theme.dart';
part 'colors.dart';
part 'dimens.dart';
part 'drawables.dart';
part 'elevations.dart';
part 'font_sizes.dart';
part 'font_weights.dart';
part 'gradient_colors.dart';
part 'radius.dart';

class Resources {
  const Resources._();
  static const colors = _AppColors();
  static const dimens = _AppDimens();
  static _AppTheme theme = _AppTheme();
  static const drawables = _AppDrawables();
  static const fontWeights = _FontWeights();
  static const radius = _Radius();
  static const elevation = _Elevations();
  static const fontSizes = _FontSizes();
  static const horizontalDims = _HorizontalDimens();
  static const verticalDims = _VerticalDimens();
  static const iconSizes = _IconSizes();
  static const gradientColors = _AppGradientColors();
}
