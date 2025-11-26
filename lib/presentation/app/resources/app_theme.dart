part of 'resources.dart';

class _AppTheme {
  final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Resources.colors.graySuperLight,
    primaryColor: Resources.colors.primary,
    textTheme: _AppTextTheme.lightTextTheme,
    textSelectionTheme: _AppTextTheme.textSelectionTheme,
    buttonTheme: _AppButtonTheme.legacyButtonTheme,
    textButtonTheme: _AppButtonTheme.textButtonTheme,
    elevatedButtonTheme: _AppButtonTheme.elevatedButtonTheme,
  );
}

/// ----------------------
/// Text Theme
/// ----------------------
class _AppTextTheme {
  static final TextSelectionThemeData textSelectionTheme =
      TextSelectionThemeData(
        cursorColor: Resources.colors.primary,
        selectionColor: Resources.colors.primary.withValues(alpha: 0.4),
        selectionHandleColor: Resources.colors.primary,
      );

  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$30,
      fontWeight: Resources.fontWeights.bold,
    ),
    titleLarge: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$24,
      fontWeight: Resources.fontWeights.bold,
    ),
    titleMedium: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$18,
      fontWeight: Resources.fontWeights.bold,
    ),
    titleSmall: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$16,
      fontWeight: Resources.fontWeights.bold,
    ),
    labelSmall: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$14,
      fontWeight: Resources.fontWeights.regular,
      letterSpacing: 0.2,
    ),
    bodyMedium: TextStyle(
      color: Resources.colors.grayMedium,
      fontSize: Resources.fontSizes.$16,
      fontWeight: Resources.fontWeights.regular,
    ),
    bodySmall: TextStyle(
      color: Resources.colors.grayMedium,
      fontSize: Resources.fontSizes.$14,
      fontWeight: Resources.fontWeights.regular,
    ),
    headlineLarge: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$16,
      fontWeight: Resources.fontWeights.medium,
    ),
    headlineMedium: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$14,
      fontWeight: Resources.fontWeights.medium,
    ),
    headlineSmall: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$12,
      fontWeight: Resources.fontWeights.medium,
    ),
    displaySmall: TextStyle(
      color: Resources.colors.black,
      fontSize: Resources.fontSizes.$30,
      fontWeight: Resources.fontWeights.bold,
    ),
  );
}

/// ----------------------
/// Buttons Theme
/// ----------------------
class _AppButtonTheme {
  static final ButtonThemeData legacyButtonTheme = ButtonThemeData(
    buttonColor: Resources.colors.primary,
  );

  static final TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      foregroundColor: WidgetStatePropertyAll(Resources.colors.white),
    ),
  );

  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Resources.colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Resources.radius.$r18),
            ),
          ),
        ),
      );
}
