import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/utils/extensions/non_null_extension.dart';
import 'package:toastification/toastification.dart';

import '../app_text.dart';
import 'index.dart';

/// A reusable toast with icon, title, and dimmed background overlay
class CustomToastification {
  final BuildContext context;
  final String message;
  final String iconPath;
  final Duration duration;
  final Color? shadowColor;
  final bool? hasShadow;

  CustomToastification({
    required this.context,
    required this.message,
    required this.iconPath,
    this.hasShadow,
    this.shadowColor,
    this.duration = const Duration(seconds: 3),
  });

  /// Show the toast with overlay
  Future<void> showToast() async {
    final overlayEntry = _showOverlay();
    _showToast();

    await Future.delayed(duration);
    overlayEntry.remove();
  }

  /// Creates and inserts the dimmed overlay
  OverlayEntry _showOverlay() {
    final overlayEntry = OverlayEntry(
      builder: (_) => GestureDetector(
        child: Container(color: Resources.colors.black.withValues(alpha: 0.4)),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    return overlayEntry;
  }

  /// Shows the actual toast
  void _showToast() {
    Toastification().showCustom(
      context: context,
      autoCloseDuration: duration,
      builder: (BuildContext context, ToastificationItem holder) => Container(
        height: Resources.verticalDims.$50,
        margin: EdgeInsetsDirectional.symmetric(
          vertical: Resources.verticalDims.$16,
          horizontal: Resources.horizontalDims.$16,
        ),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: Resources.horizontalDims.$16,
        ),
        decoration: BoxDecoration(
          color: Resources.colors.white,
          borderRadius: BorderRadius.circular(Resources.radius.$r16),
          boxShadow: (hasShadow.orTrue)
              ? [
                  BoxShadow(
                    color: shadowColor ?? Resources.colors.accentPrimary,
                    offset: Offset(0, Resources.horizontalDims.$10),
                  ),
                  BoxShadow(
                    color: Resources.colors.black.withValues(alpha: 0.3),
                    offset: Offset(0, Resources.horizontalDims.$10),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: Resources.horizontalDims.$6,
                vertical: Resources.verticalDims.$6,
              ),
              decoration: BoxDecoration(
                color: Resources.colors.black,
                borderRadius: BorderRadius.circular(Resources.radius.$r12),
              ),
              child: CustomSvgIcon(
                assetPath: iconPath,
                fit: BoxFit.cover,
                height: Resources.verticalDims.$20,
                width: Resources.horizontalDims.$20,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Flexible(child: AppText(text: message, maxLines: 2)),
          ],
        ),
      ),
    );
  }
}
