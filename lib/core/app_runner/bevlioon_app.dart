import 'package:bevlioon/core/di/dependency_injector.dart';
import 'package:bevlioon/core/l10n/app_localizations.dart';
import 'package:bevlioon/presentation/app/navigation/app_router.dart';
import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_cubit.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BevlioonApp extends StatelessWidget {
  const BevlioonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => serviceLocatorInstance<FavoriteMoviesCubit>(),
      child: ScreenUtilInit(
        designSize: Size(
          Resources.dimens.designWidth,
          Resources.dimens.designHeight,
        ),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            scrollBehavior: _NoGlowScrollBehavior(),
            theme: Resources.theme.lightTheme,
            routerConfig: AppRouter.router,
            title: AppConstants.appName,
            locale: const Locale(AppConstants.defaultLocale),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            debugShowCheckedModeBanner: kDebugMode,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
                boldText: false,
              ),
              child: child ?? const Placeholder(),
            ),
          );
        },
      ),
    );
  }
}

class _NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
