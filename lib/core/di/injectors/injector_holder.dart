import 'package:bevlioon/core/di/injectors/application_injectors/cubit_injector.dart';
import 'package:bevlioon/core/di/injectors/application_injectors/data_source_injector.dart';
import 'package:bevlioon/core/di/injectors/base_injector.dart';

import 'application_injectors/repo_injector.dart';

/// [InjectorHolder] hold all applicationInjectors e.g [DataSourcesInjector] ,[ReposInjector] ...
/// Must be in order,

class InjectorHolder {
  static final List<BaseInjector> _applicationInjectors = [
    DataSourcesInjector(),
    ReposInjector(),
    CubitsInjector(),
  ];

  /// iterate and inject all application modules
  static void injectAllApplicationModules() {
    for (var injector in _applicationInjectors) {
      injector.injectModules();
    }
  }
}
