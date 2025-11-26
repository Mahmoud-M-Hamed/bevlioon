import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/favorite_movies_page.dart';
import 'package:bevlioon/presentation/features/ui/pages/movie_details/movie_details_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/ui/pages/home/home_page.dart';
import '../../features/ui/pages/splash/splash_page.dart';
import 'app_route_enum.dart';
import 'nav_keys.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: AppRouteEnum.splashPage.path,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRouteEnum.splashPage.path,
        name: AppRouteEnum.splashPage.name,
        builder: (_, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRouteEnum.homePage.path,
        name: AppRouteEnum.homePage.name,
        builder: (_, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRouteEnum.movieDetailsPage.path,
        name: AppRouteEnum.movieDetailsPage.name,
        builder: (_, state) =>
            MovieDetailsPage(movieId: state.extra as int? ?? 0),
      ),
      GoRoute(
        path: AppRouteEnum.favoriteMoviesPage.path,
        name: AppRouteEnum.favoriteMoviesPage.name,
        builder: (_, state) => const FavoriteMoviesPage(),
      ),
    ],
  );
}
