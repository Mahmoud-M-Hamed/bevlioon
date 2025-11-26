import 'package:bevlioon/data/data_source/local/services/hive_db_service/hive_service.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/index.dart';
import 'package:bevlioon/utils/helpers/system_ui_helper.dart';
import 'package:bevlioon/utils/logging/app_logger.dart';
import 'package:bevlioon/utils/observers/app_bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../di/dependency_injector.dart';

class AppInitialization {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: '.env');
    await DependencyInjector().injectModules();
    await ScreenUtil.ensureScreenSize();
    await _setPreferredOrientation();
    await _initializeHiveDatabase();

    Bloc.observer = AppBlocObserver();
    SystemUIHelper.configureSystemUIOverlayStyle();

    FlutterError.onError = AppInitialization._handleFlutterError;
  }

  static Future<void> _setPreferredOrientation() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  static Future<void> _initializeHiveDatabase() async {
    await HiveDatabaseService.initialize();
    await HiveDatabase.offlineDBInitialization();
  }

  static void _handleFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
      logInitializationError(
        details.exception,
        details.stack ?? StackTrace.current,
      );
    }

    /// In release mode: do nothing ex: crashlytics, sentry, etc.
  }

  static void logInitializationError(Object e, StackTrace s) {
    AppLogger.instance.logError('App error failed', error: e, stackTrace: s);
  }
}
