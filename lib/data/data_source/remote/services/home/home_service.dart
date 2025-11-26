import 'package:bevlioon/data/data_source/remote/network/api_client.dart';
import 'package:bevlioon/data/data_source/remote/network/models/endpoint.dart';
import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart';
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart';

import 'constant/home_endpoints.dart';

class HomeService {
  const HomeService({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  Future<NetworkResponse<PopularMoviesResponseModel>> retrievePopularMovies({
    required PaginationRequestModel requestModel,
  }) => _apiClient.get(
    Endpoint(
      path: HomeEndpoints.popularMoviesPath,
      query: requestModel.toJson(),
    ),
    onMap: (json) => PopularMoviesResponseModel.fromJson(json),
  );

  Future<NetworkResponse<MovieDetailsResponseModel>> retrieveMovieDetails({
    required int movieId,
  }) => _apiClient.get(
    Endpoint(path: HomeEndpoints.movieDetailsPath(movieId: movieId)),
    onMap: (json) => MovieDetailsResponseModel.fromJson(json),
  );
}
