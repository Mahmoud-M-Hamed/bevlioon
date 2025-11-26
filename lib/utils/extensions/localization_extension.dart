import 'package:bevlioon/core/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension L10nContextX on BuildContext {
  /// Localizations instance
  AppLocalizations get localization => AppLocalizations.of(this);

  /// Current locale + text direction helpers
  Locale get locale => Localizations.localeOf(this);
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}
