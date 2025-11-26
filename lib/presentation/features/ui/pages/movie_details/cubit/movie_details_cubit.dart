import 'package:bevlioon/domain/repository/home/base_home_repo.dart';
import 'package:bevlioon/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final BaseHomeRepo _homeRepo;

  MovieDetailsCubit({required BaseHomeRepo baseHomeRepo})
    : _homeRepo = baseHomeRepo,
      super(const MovieDetailsState.initial());

  Future<void> retrieveMovieDetails({required int movieId}) async {
    emit(state.copyWith(cubitStatus: CubitStatus.loading));
    final result = await _homeRepo.retrieveMovieDetails(movieId: movieId);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            cubitStatus: CubitStatus.success,
            movieDetails: data.data,
            movieId: movieId,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
        );
      },
    );
  }
}
