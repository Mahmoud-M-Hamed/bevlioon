import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart';
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart';
import 'package:bevlioon/utils/helpers/result.dart';

abstract class BaseHomeRepo {
  Future<Result<NetworkResponse<PopularMoviesResponseModel>>>
  retrievePopularMovies({required PaginationRequestModel requestModel});

  Future<Result<NetworkResponse<MovieDetailsResponseModel>>>
  retrieveMovieDetails({required int movieId});
}
