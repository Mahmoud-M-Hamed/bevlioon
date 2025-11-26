import 'package:bevlioon/core/error/app_error_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart';
import 'package:bevlioon/utils/enums/cubit_status.dart';
import 'package:equatable/equatable.dart';

class PopularMoviesState extends Equatable {
  final CubitStatus cubitStatus;
  final AppErrorModel? appErrorModel;
  final PopularMoviesResponseModel? popularMovies;

  const PopularMoviesState({
    required this.cubitStatus,
    required this.appErrorModel,
    required this.popularMovies,
  });

  const PopularMoviesState.initial()
    : this(
        cubitStatus: CubitStatus.initial,
        appErrorModel: null,
        popularMovies: null,
      );

  bool get isLoading => cubitStatus == CubitStatus.loading;

  bool get isSuccess => cubitStatus == CubitStatus.success;

  bool get isError => cubitStatus == CubitStatus.error;

  PopularMoviesState copyWith({
    CubitStatus? cubitStatus,
    AppErrorModel? appErrorModel,
    PopularMoviesResponseModel? popularMovies,
  }) => PopularMoviesState(
    cubitStatus: cubitStatus ?? this.cubitStatus,
    appErrorModel: appErrorModel ?? this.appErrorModel,
    popularMovies: popularMovies ?? this.popularMovies,
  );

  @override
  List<Object?> get props => [cubitStatus, appErrorModel, popularMovies];
}
