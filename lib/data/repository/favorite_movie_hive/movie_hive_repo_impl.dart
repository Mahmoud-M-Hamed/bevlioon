import 'package:bevlioon/data/data_source/local/constants/hive_box_keys.dart';
import 'package:bevlioon/data/data_source/local/services/hive_db_service/hive_service.dart';
import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:bevlioon/domain/repository/favorite_movie_hive/movie_hive_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteMovieHiveRepoImpl implements BaseFavoriteMovieHiveRepo {
  Box<FavoriteMovieModel> get _box =>
      Hive.box<FavoriteMovieModel>(HiveBoxKeys.favoriteMoviesBoxKey);

  @override
  Future<List<FavoriteMovieModel>> getFavoriteMovies() async =>
      _box.values.toSet().toList();

  @override
  Future<void> addFavorite(FavoriteMovieModel movie) async {
    await ensureBoxIsOpen();
    await _box.put(movie.id, movie);
  }

  @override
  Future<void> removeFavorite(int movieId) async {
    await ensureBoxIsOpen();
    await _box.delete(movieId);
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    await ensureBoxIsOpen();
    return _box.containsKey(movieId);
  }

  @override
  Future<void> ensureBoxIsOpen() async {
    final isBoxOpen = Hive.isBoxOpen(HiveBoxKeys.favoriteMoviesBoxKey);
    if (isBoxOpen == false) {
      await HiveDatabaseService.openBox<FavoriteMovieModel>(
        boxName: HiveBoxKeys.favoriteMoviesBoxKey,
      );
    }
  }
}
