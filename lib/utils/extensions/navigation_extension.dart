import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> push<T extends Object?>(String name, {Object? extra}) {
    return GoRouter.of(this).pushNamed<T>(name, extra: extra);
  }

  Future<T?> pushReplacement<T extends Object?>(String name, {Object? extra}) {
    return GoRouter.of(this).pushReplacementNamed<T>(name, extra: extra);
  }

  void pop<T extends Object?>([T? result]) {
    if (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop(result);
    }
  }

  void goTo(String name, {Object? extra}) {
    GoRouter.of(this).goNamed(name, extra: extra);
  }

  String get currentLocation => GoRouterState.of(this).matchedLocation;
}
