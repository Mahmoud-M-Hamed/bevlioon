import 'package:bevlioon/core/di/dependency_injector.dart';
import 'package:bevlioon/core/di/injectors/base_injector.dart';
import 'package:bevlioon/data/data_source/remote/services/home/home_service.dart';
import 'package:bevlioon/data/repository/favorite_movie_hive/movie_hive_repo_impl.dart';
import 'package:bevlioon/data/repository/home/home_repo_impl.dart';
import 'package:bevlioon/domain/repository/favorite_movie_hive/movie_hive_repo.dart';
import 'package:bevlioon/domain/repository/home/base_home_repo.dart';

/// [ReposInjector] hold all application repos dependencies
class ReposInjector implements BaseInjector {
  static final reposInjectors = [
    () =>
        serviceLocatorInstance.registerLazySingleton<BaseFavoriteMovieHiveRepo>(
          () => FavoriteMovieHiveRepoImpl(),
        ),
    () => serviceLocatorInstance.registerLazySingleton<BaseHomeRepo>(
      () => HomeRepoImpl(homeService: serviceLocatorInstance<HomeService>()),
    ),
  ];

  /// iterate and inject all repos
  @override
  Future<void> injectModules() async {
    for (final repoInjector in reposInjectors) {
      repoInjector.call();
    }
  }
}
