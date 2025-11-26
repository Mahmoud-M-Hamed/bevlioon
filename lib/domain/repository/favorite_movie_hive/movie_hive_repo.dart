import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';

abstract class BaseFavoriteMovieHiveRepo {
  Future<List<FavoriteMovieModel>> getFavoriteMovies();

  Future<void> addFavorite(FavoriteMovieModel movie);

  Future<void> removeFavorite(int movieId);

  Future<bool> isFavorite(int movieId);

  Future<void> ensureBoxIsOpen();
}
