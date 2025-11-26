import 'package:bevlioon/core/di/injectors/injector_holder.dart';
import 'package:bevlioon/data/data_source/remote/constants/api_constants.dart';
import 'package:bevlioon/data/data_source/remote/network/api_client.dart';
import 'package:bevlioon/data/data_source/remote/network/interceptors/custom_interceptor.dart';
import 'package:bevlioon/data/data_source/remote/network/network_info/network_info.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final GetIt serviceLocatorInstance = GetIt.instance;

class DependencyInjector {
  DependencyInjector() : super();

  Future<void> injectModules() async {
    WidgetsFlutterBinding.ensureInitialized();

    serviceLocatorInstance.registerLazySingleton<ApiClient>(
      () => ApiClient(_dioFactory(), networkInfo: NetworkInfoImpl()),
    );

    /// Injects all modules in app
    InjectorHolder.injectAllApplicationModules();

    /// Ensure all async regs are done before use
    await serviceLocatorInstance.allReady();
  }

  Dio _dioFactory() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env[AppConstants.baseUrl] ?? AppConstants.emptyString,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: ApiConstants.defaultHeaders,
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.addAll([
      if (kDebugMode) PrettyDioLogger(),
      LoggingInterceptor(),
    ]);

    return dio;
  }
}
