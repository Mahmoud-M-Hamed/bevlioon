import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart';
import 'package:bevlioon/data/data_source/remote/services/home/home_service.dart';
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart';
import 'package:bevlioon/domain/repository/home/base_home_repo.dart';
import 'package:bevlioon/utils/helpers/result.dart';
import 'package:bevlioon/utils/helpers/safe_async_call.dart';

class HomeRepoImpl implements BaseHomeRepo {
  final HomeService _homeService;

  HomeRepoImpl({required HomeService homeService}) : _homeService = homeService;

  @override
  Future<Result<NetworkResponse<PopularMoviesResponseModel>>>
  retrievePopularMovies({required PaginationRequestModel requestModel}) =>
      safeAsyncCall(
        () => _homeService.retrievePopularMovies(requestModel: requestModel),
      );

  @override
  Future<Result<NetworkResponse<MovieDetailsResponseModel>>>
  retrieveMovieDetails({required int movieId}) =>
      safeAsyncCall(() => _homeService.retrieveMovieDetails(movieId: movieId));
}
