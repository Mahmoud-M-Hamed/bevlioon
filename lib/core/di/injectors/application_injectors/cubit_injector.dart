import 'package:bevlioon/core/di/dependency_injector.dart';
import 'package:bevlioon/core/di/injectors/base_injector.dart';
import 'package:bevlioon/domain/repository/favorite_movie_hive/movie_hive_repo.dart';
import 'package:bevlioon/domain/repository/home/base_home_repo.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/cubit/popular_movies_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/movie_details/cubit/movie_details_cubit.dart';

/// [CubitsInjector] hold all application global singleton cubits dependencies
///
/// global cubits are injected here
class CubitsInjector implements BaseInjector {
  static final cubitsInjectors = [
    () => serviceLocatorInstance.registerFactory<FavoriteMoviesCubit>(
      () => FavoriteMoviesCubit(
        favoriteMovieHiveRepo:
            serviceLocatorInstance<BaseFavoriteMovieHiveRepo>(),
      ),
    ),
    () => serviceLocatorInstance.registerFactory<PopularMoviesCubit>(
      () => PopularMoviesCubit(
        baseHomeRepo: serviceLocatorInstance<BaseHomeRepo>(),
      ),
    ),
    () => serviceLocatorInstance.registerFactory<MovieDetailsCubit>(
      () => MovieDetailsCubit(
        baseHomeRepo: serviceLocatorInstance<BaseHomeRepo>(),
      ),
    ),
  ];

  /// iterate and inject all cubits
  @override
  void injectModules() {
    for (final cubitInjector in cubitsInjectors) {
      cubitInjector.call();
    }
  }
}
