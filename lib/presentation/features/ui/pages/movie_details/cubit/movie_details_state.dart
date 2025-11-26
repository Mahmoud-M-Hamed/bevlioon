import 'package:bevlioon/core/error/app_error_model.dart';
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class MovieDetailsState extends Equatable {
  final CubitStatus cubitStatus;
  final AppErrorModel? appErrorModel;
  final MovieDetailsResponseModel? movieDetails;
  final int? movieId;

  const MovieDetailsState({
    required this.cubitStatus,
    required this.appErrorModel,
    required this.movieDetails,
    required this.movieId,
  });

  const MovieDetailsState.initial()
    : this(
        cubitStatus: CubitStatus.initial,
        appErrorModel: null,
        movieDetails: null,
        movieId: null,
      );

  bool get isLoading => cubitStatus == CubitStatus.loading;

  bool get isSuccess => cubitStatus == CubitStatus.success;

  bool get isError => cubitStatus == CubitStatus.error;

  MovieDetailsState copyWith({
    CubitStatus? cubitStatus,
    AppErrorModel? appErrorModel,
    MovieDetailsResponseModel? movieDetails,
    int? movieId,
  }) => MovieDetailsState(
    cubitStatus: cubitStatus ?? this.cubitStatus,
    appErrorModel: appErrorModel ?? this.appErrorModel,
    movieDetails: movieDetails ?? this.movieDetails,
    movieId: movieId ?? this.movieId,
  );

  @override
  List<Object?> get props => [
    cubitStatus,
    appErrorModel,
    movieDetails,
    movieId,
  ];
}
