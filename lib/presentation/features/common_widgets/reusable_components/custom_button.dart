import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/utils/extensions/theme_extension.dart';

import 'index.dart';

enum _ButtonType { elevated, text }

enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final ButtonStyle? style;
  final bool isLoading;
  final bool isExpanded;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderSideColor;
  final IconData? prefixIcon;
  final IconData? postfixIcon;
  final _ButtonType _type;
  final ButtonSize size;
  final MainAxisAlignment? mainAxisAlignment;
  final double? borderRadius;
  final List<Color>? gradientColors;

  const CustomButton._({
    required _ButtonType type,
    required this.size,
    this.child,
    this.onPressed,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
    this.borderSideColor,
    this.borderRadius,
    this.gradientColors,
    this.isLoading = false,
    this.isExpanded = false,
    this.prefixIcon,
    this.postfixIcon,
    this.mainAxisAlignment,
  }) : _type = type;

  factory CustomButton.elevated({
    required void Function()? onPressed,
    required Widget child,
    ButtonStyle? style,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderSideColor,
    double? borderRadius,
    List<Color>? gradientColors,
    bool isLoading = false,
    bool isExpanded = false,
    IconData? prefixIcon,
    IconData? postfixIcon,
    ButtonSize size = ButtonSize.medium,
  }) {
    return CustomButton._(
      type: _ButtonType.elevated,
      onPressed: onPressed,
      style: style,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderSideColor: borderSideColor,
      borderRadius: borderRadius,
      gradientColors: gradientColors,
      isLoading: isLoading,
      isExpanded: isExpanded,
      prefixIcon: prefixIcon,
      postfixIcon: postfixIcon,
      size: size,
      child: child,
    );
  }

  factory CustomButton.text({
    required void Function()? onPressed,
    required Widget child,
    ButtonStyle? style,
    Color? backgroundColor,
    List<Color>? gradientColors,
    Color? foregroundColor,
    Color? borderSideColor,
    double? borderRadius,
    bool isLoading = false,
    bool isExpanded = false,
    IconData? prefixIcon,
    IconData? postfixIcon,
    ButtonSize size = ButtonSize.medium,
  }) {
    return CustomButton._(
      type: _ButtonType.text,
      onPressed: onPressed,
      style: style,
      backgroundColor: backgroundColor,
      gradientColors: gradientColors,
      foregroundColor: foregroundColor,
      borderSideColor: borderSideColor,
      borderRadius: borderRadius,
      isLoading: isLoading,
      isExpanded: isExpanded,
      prefixIcon: prefixIcon,
      postfixIcon: postfixIcon,
      size: size,
      child: child,
    );
  }

  EdgeInsetsDirectional get _padding {
    switch (size) {
      case ButtonSize.small:
        return EdgeInsetsDirectional.symmetric(
          vertical: Resources.verticalDims.$9,
          horizontal: Resources.horizontalDims.$14,
        );
      case ButtonSize.medium:
        return EdgeInsetsDirectional.symmetric(
          vertical: Resources.verticalDims.$14,
          horizontal: Resources.horizontalDims.$20,
        );
      case ButtonSize.large:
        return EdgeInsetsDirectional.symmetric(
          vertical: Resources.verticalDims.$16,
          horizontal: Resources.horizontalDims.$26,
        );
    }
  }

  EdgeInsetsDirectional get _margin {
    switch (size) {
      case ButtonSize.small:
        return EdgeInsetsDirectional.symmetric(
          horizontal: Resources.horizontalDims.$28,
        );
      case ButtonSize.medium:
        return EdgeInsetsDirectional.symmetric(
          horizontal: Resources.horizontalDims.$40,
        );
      case ButtonSize.large:
        return EdgeInsetsDirectional.symmetric(
          horizontal: Resources.horizontalDims.$56,
        );
    }
  }

  double get _fontSize {
    switch (size) {
      case ButtonSize.small:
        return Resources.fontSizes.$12;
      case ButtonSize.medium:
        return Resources.fontSizes.$15;
      case ButtonSize.large:
        return Resources.fontSizes.$18;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonChild = AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      child: isLoading
          ? Container(
              margin: _margin,
              height: Resources.horizontalDims.$20,
              width: Resources.verticalDims.$20,
              child: CircularProgressIndicator(
                strokeWidth: Resources.verticalDims.$1,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _type == _ButtonType.text
                      ? context.theme.colorScheme.primary
                      : context.theme.colorScheme.onPrimary,
                ),
              ),
            )
          : Row(
              mainAxisSize: (mainAxisAlignment == MainAxisAlignment.start)
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              mainAxisAlignment: (mainAxisAlignment == MainAxisAlignment.start)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  Icon(prefixIcon, size: Resources.iconSizes.$18),
                  Resources.horizontalDims.$6.horizontalSpace,
                ],
                if (child != null) Flexible(child: child!),
                if (postfixIcon != null) ...[
                  Resources.horizontalDims.$6.horizontalSpace,
                  Icon(postfixIcon, size: Resources.iconSizes.$18),
                ],
              ],
            ),
    );

    final commonStyle =
        style ??
        switch (_type) {
          _ButtonType.elevated => ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: (gradientColors != null)
                ? Colors.transparent
                : backgroundColor ??
                      context.theme.buttonTheme.colorScheme?.primary,
            foregroundColor:
                foregroundColor ?? context.theme.colorScheme.onPrimary,
            padding: _padding,
            textStyle: context.theme.textTheme.bodyLarge?.copyWith(
              fontSize: _fontSize,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? Resources.radius.$r14,
              ),
            ),
          ),
          _ButtonType.text => TextButton.styleFrom(
            backgroundColor: (gradientColors != null)
                ? Colors.transparent
                : backgroundColor ??
                      context.theme.buttonTheme.colorScheme?.primary,
            foregroundColor:
                foregroundColor ?? context.theme.colorScheme.primary,
            padding: _padding,
            textStyle: context.theme.textTheme.bodyLarge?.copyWith(
              fontSize: _fontSize.sp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? Resources.radius.$r18,
              ),
            ),
          ),
        };

    final button = switch (_type) {
      _ButtonType.elevated => ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: commonStyle,
        child: buttonChild,
      ),
      _ButtonType.text => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: commonStyle,
        child: buttonChild,
      ),
    };

    final decoratedButton = (gradientColors != null)
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors!,
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
              ),
              borderRadius: BorderRadius.circular(
                borderRadius ?? Resources.radius.$r18,
              ),
            ),
            child: button,
          )
        : button;

    return isExpanded
        ? SizedBox(width: double.infinity, child: decoratedButton)
        : decoratedButton;
  }
}
