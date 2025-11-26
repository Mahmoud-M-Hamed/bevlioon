import 'package:flutter/material.dart';

import '../../../utils/extensions/localization_extension.dart';
import '../../../utils/extensions/theme_extension.dart';
import '../../app/resources/resources.dart';
import 'app_text.dart';
import 'reusable_components/custom_button.dart';

class CommonErrorHandlerWrapperPage extends StatelessWidget {
  /// Whether the API call is currently loading.
  final bool isLoading;

  /// Whether an error occurred.
  final bool hasError;
  final String? errorMessage;

  /// Function called when user taps retry.
  final VoidCallback? onRetry;

  /// Widget builder when data is successfully loaded.
  final WidgetBuilder onSuccessBuilder;

  /// Optional error widget builder (for custom UI).
  /// If not provided, a default image + retry button is shown.
  final WidgetBuilder? onErrorBuilder;

  /// Widget displayed while loading or before data is ready.
  final Widget loadingWidget;

  const CommonErrorHandlerWrapperPage({
    super.key,
    required this.isLoading,
    required this.hasError,
    this.onRetry,
    required this.onSuccessBuilder,
    required this.loadingWidget,
    this.errorMessage,
    this.onErrorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    if (isLoading) {
      /// shimmer or CircularProgressIndicator
      return loadingWidget;
    }

    if (hasError) {
      if (onErrorBuilder != null) {
        return onErrorBuilder!(context);
      }

      /// Default error fallback UI
      return Center(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: Resources.horizontalDims.$24,
            vertical: Resources.verticalDims.$24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Resources.drawables.errorImage,
                fit: BoxFit.cover,
                height: Resources.verticalDims.$192,
              ),
              SizedBox(height: Resources.verticalDims.$16),
              AppText(
                text: errorMessage ?? localization.something_went_wrong,
                style: context.textTheme.labelSmall,
              ),
              SizedBox(height: Resources.verticalDims.$12),
              CustomButton.elevated(
                size: ButtonSize.medium,
                isExpanded: true,
                isLoading: isLoading,
                gradientColors:
                    Resources.gradientColors.grayCharcoalBlackGradient,
                onPressed: onRetry,
                child: AppText(text: localization.retry),
              ),
            ],
          ),
        ),
      );
    }

    /// Success case
    return onSuccessBuilder(context);
  }
}
