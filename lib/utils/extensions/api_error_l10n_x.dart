import 'package:bevlioon/core/error/error_codes_enum.dart';
import 'package:bevlioon/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

/// Extension that provides user-friendly error titles and messages
/// for each [ErrorCodesEnum] value.
///
/// Currently returns default English strings.
/// If localization is introduced later, you can replace the string
/// literals with `context.localization.errXxx` calls (keeping the
/// same API).
///
/// Example:
/// ```dart
/// final error = ErrorCodesEnum.unauthorized;
/// print(error.title);   // "Unauthorized"
/// print(error.message); // "You are not authorized to perform this action."
/// ```
extension ApiErrorL10nX on ErrorCodesEnum {
  String titleOf(BuildContext context) {
    final l10n = context.localization;
    switch (this) {
      case ErrorCodesEnum.unauthorized:
        return l10n.error_title_unauthorized;
      case ErrorCodesEnum.forbidden:
        return l10n.error_title_forbidden;
      case ErrorCodesEnum.notFound:
        return l10n.error_title_not_found;
      case ErrorCodesEnum.timeout:
        return l10n.error_title_timeout;
      case ErrorCodesEnum.serverError:
        return l10n.error_title_server_error;
      case ErrorCodesEnum.network:
        return l10n.error_title_network;
      case ErrorCodesEnum.invalidResponseFormat:
        return l10n.error_title_invalid_response_format;
      case ErrorCodesEnum.unknown:
      case ErrorCodesEnum.inAppErrorCode:
        return l10n.error_title_unknown;
    }
  }

  String messageOf(BuildContext context) {
    final l10n = context.localization;
    switch (this) {
      case ErrorCodesEnum.unauthorized:
        return l10n.error_message_unauthorized;
      case ErrorCodesEnum.forbidden:
        return l10n.error_message_forbidden;
      case ErrorCodesEnum.notFound:
        return l10n.error_message_not_found;
      case ErrorCodesEnum.timeout:
        return l10n.error_message_timeout;
      case ErrorCodesEnum.serverError:
        return l10n.error_message_server_error;
      case ErrorCodesEnum.network:
        return l10n.error_message_network;
      case ErrorCodesEnum.invalidResponseFormat:
        return l10n.error_message_invalid_response_format;
      case ErrorCodesEnum.unknown:
      case ErrorCodesEnum.inAppErrorCode:
        return l10n.error_message_unknown;
    }
  }
}
