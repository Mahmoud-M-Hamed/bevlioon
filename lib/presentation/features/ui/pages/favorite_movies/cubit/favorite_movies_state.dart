import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:bevlioon/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class FavoriteMoviesState extends Equatable {
  final CubitStatus cubitStatus;
  final CubitStatus checkStatus;
  final List<FavoriteMovieModel> favoriteMovies;
  final bool isFavorite;

  const FavoriteMoviesState({
    required this.cubitStatus,
    required this.checkStatus,
    required this.favoriteMovies,
    required this.isFavorite,
  });

  const FavoriteMoviesState.initial()
    : this(
        cubitStatus: CubitStatus.initial,
        checkStatus: CubitStatus.initial,
        favoriteMovies: const [],
        isFavorite: false,
      );

  bool get isLoading => cubitStatus == CubitStatus.loading;

  bool get isError => cubitStatus == CubitStatus.error;

  bool get isSuccess => cubitStatus == CubitStatus.success;

  bool get isChecking => checkStatus == CubitStatus.loading;

  FavoriteMoviesState copyWith({
    CubitStatus? cubitStatus,
    CubitStatus? checkStatus,
    List<FavoriteMovieModel>? favoriteMovies,
    bool? isFavorite,
  }) {
    return FavoriteMoviesState(
      cubitStatus: cubitStatus ?? this.cubitStatus,
      checkStatus: checkStatus ?? this.checkStatus,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    cubitStatus,
    checkStatus,
    favoriteMovies,
    isFavorite,
  ];
}
