import 'package:bevlioon/presentation/app/resources/resources.dart';

import 'index.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.backgroundColor,
    this.height,
    this.margin,
    this.padding,
    this.child,
  });

  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsetsDirectional? margin;
  final EdgeInsetsDirectional? padding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding:
          padding ??
          EdgeInsetsDirectional.symmetric(
            horizontal: Resources.horizontalDims.$12,
            vertical: Resources.verticalDims.$12,
          ),
      margin: margin,
      decoration: ShapeDecoration(
        color: backgroundColor ?? Resources.colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Resources.radius.$r16),
        ),
        shadows: [
          BoxShadow(
            color: Resources.colors.grayLight,
            blurRadius: Resources.radius.$r32_4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
