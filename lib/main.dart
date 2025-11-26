import 'dart:async';

import 'package:bevlioon/core/app_runner/bevlioon_app.dart';
import 'package:flutter/material.dart';

import 'core/app_runner/app_initialization.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    await AppInitialization.initialize();
    runApp(const BevlioonApp());
  }, AppInitialization.logInitializationError);
}
