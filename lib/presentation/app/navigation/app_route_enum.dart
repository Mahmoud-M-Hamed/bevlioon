import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/favorite_movies_page.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/home_page.dart';
import 'package:bevlioon/presentation/features/ui/pages/movie_details/movie_details_page.dart';
import 'package:bevlioon/presentation/features/ui/pages/splash/splash_page.dart';

enum AppRouteEnum {
  splashPage(name: SplashPage.routeName, path: SplashPage.routePath),
  homePage(name: HomePage.routeName, path: HomePage.routePath),
  movieDetailsPage(
    name: MovieDetailsPage.routeName,
    path: MovieDetailsPage.routePath,
  ),
  favoriteMoviesPage(
    name: FavoriteMoviesPage.routeName,
    path: FavoriteMoviesPage.routePath,
  );

  const AppRouteEnum({required this.path, required this.name});

  final String path;
  final String name;
}
