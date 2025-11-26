import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:bevlioon/domain/repository/favorite_movie_hive/movie_hive_repo.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_state.dart';
import 'package:bevlioon/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

class FavoriteMoviesCubit extends Cubit<FavoriteMoviesState> {
  final BaseFavoriteMovieHiveRepo _movieHiveRepo;

  FavoriteMoviesCubit({
    required BaseFavoriteMovieHiveRepo favoriteMovieHiveRepo,
  }) : _movieHiveRepo = favoriteMovieHiveRepo,
       super(const FavoriteMoviesState.initial());

  Future<void> loadFavorites() async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    await _movieHiveRepo.ensureBoxIsOpen();
    final movies = await _movieHiveRepo.getFavoriteMovies();

    emit(
      state.copyWith(cubitStatus: CubitStatus.success, favoriteMovies: movies),
    );
  }

  Future<void> addFavorite(FavoriteMovieModel movie) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    await _movieHiveRepo.addFavorite(movie);
    await loadFavorites();
  }

  Future<void> removeFavorite(int movieId) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    await _movieHiveRepo.removeFavorite(movieId);
    await loadFavorites();
  }

  Future<void> checkIfFavorite(int movieId) async {
    emit(state.copyWith(checkStatus: CubitStatus.loading));

    await _movieHiveRepo.ensureBoxIsOpen();
    await loadFavorites();
    final isFav = await _movieHiveRepo.isFavorite(movieId);

    emit(state.copyWith(checkStatus: CubitStatus.success, isFavorite: isFav));
  }

  Future<void> toggleFavorite(FavoriteMovieModel movie) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));

    await _movieHiveRepo.ensureBoxIsOpen();

    final isFav = await _movieHiveRepo.isFavorite(movie.id ?? 0);

    if (isFav) {
      await removeFavorite(movie.id ?? 0);
    } else {
      await addFavorite(movie);
    }
    final refreshed = await _movieHiveRepo.getFavoriteMovies();

    emit(
      state.copyWith(
        cubitStatus: CubitStatus.success,
        favoriteMovies: refreshed,
        isFavorite: !isFav,
      ),
    );
  }
}
