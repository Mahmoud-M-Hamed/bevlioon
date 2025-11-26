import 'package:bevlioon/core/di/dependency_injector.dart';
import 'package:bevlioon/core/di/injectors/base_injector.dart';
import 'package:bevlioon/data/data_source/remote/network/api_client.dart';
import 'package:bevlioon/data/data_source/remote/services/home/home_service.dart';

/// [DataSourcesInjector] hold all application data sources dependencies
class DataSourcesInjector implements BaseInjector {
  static final dataSourcesInjectors = [
    () => serviceLocatorInstance.registerLazySingleton<HomeService>(
      () => HomeService(apiClient: serviceLocatorInstance<ApiClient>()),
    ),
  ];

  /// iterate and inject all data sources
  @override
  Future<void> injectModules() async {
    for (final dataSourceInjector in dataSourcesInjectors) {
      dataSourceInjector.call();
    }
  }
}
