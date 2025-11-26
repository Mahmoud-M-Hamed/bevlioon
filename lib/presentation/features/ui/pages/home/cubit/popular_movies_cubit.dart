import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/movie_response_model.dart';
import 'package:bevlioon/domain/repository/home/base_home_repo.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/cubit/popular_movies_state.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:bevlioon/utils/enums/cubit_status.dart';
import 'package:bloc/bloc.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final BaseHomeRepo _homeRepo;

  PopularMoviesCubit({required BaseHomeRepo baseHomeRepo})
    : _homeRepo = baseHomeRepo,
      super(const PopularMoviesState.initial());

  Future<List<MovieSummaryResponseModel>> retrievePopularMovies({
    required PaginationRequestModel requestModel,
  }) async {
    final result = await _homeRepo.retrievePopularMovies(
      requestModel: requestModel,
    );

    List<MovieSummaryResponseModel> movies = [];

    result.when(
      success: (data) {
        movies = data.data?.results ?? [];
        final totalPages = data.data?.totalPages;
        final initialPageNumber = AppConstants.initialPagingPageNumber;
        if (requestModel.paging! >= (totalPages ?? initialPageNumber)) {
          movies = [];
        }

        emit(
          state.copyWith(
            cubitStatus: CubitStatus.success,
            popularMovies: data.data,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(cubitStatus: CubitStatus.error, appErrorModel: error),
        );
        movies = [];
      },
    );

    return movies;
  }
}
