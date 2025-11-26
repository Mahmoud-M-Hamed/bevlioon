import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  void get safePop {
    if (canPop()) {
      GoRouter.of(this).pop();
    }
  }
}
