import 'package:bevlioon/data/data_source/remote/network/api_client.dart';
import 'package:bevlioon/data/data_source/remote/network/models/endpoint.dart';
import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart';
import 'package:bevlioon/data/data_source/remote/services/home/home_service.dart';
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_service_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late HomeService homeService;

  setUp(() {
    mockApiClient = MockApiClient();
    homeService = HomeService(apiClient: mockApiClient);
  });

  group('HomeService', () {
    test('retrievePopularMovies returns successful response', () async {
      final request = PaginationRequestModel(paging: 1);
      final fakePopularMovies = PopularMoviesResponseModel(
        page: 1,
        results: [],
        totalPages: 10,
        totalResults: 100,
      );

      final fakeResponse = NetworkResponse(
        isSuccess: true,
        data: fakePopularMovies,
        httpStatusCode: 200,
        message: '',
        raw: fakePopularMovies,
      );

      when(
        mockApiClient.get(any, onMap: anyNamed('onMap')),
      ).thenAnswer((_) async => fakeResponse);

      final result = await homeService.retrievePopularMovies(
        requestModel: request,
      );

      expect(result.isSuccess, true);
      expect(result.data, fakePopularMovies);
    });

    test('retrieveMovieDetails returns successful response', () async {
      const movieId = 123;
      final fakeMovieDetails = MovieDetailsResponseModel(
        title: 'Fake Movie',
        overview: 'Fake overview',
        posterPath: null,
        releaseYear: '',
        rating: null,
      );

      final fakeResponse = NetworkResponse(
        isSuccess: true,
        data: fakeMovieDetails,
        httpStatusCode: 200,
        message: '',
        raw: fakeMovieDetails,
      );
      when(
        mockApiClient.get(any, onMap: anyNamed('onMap')),
      ).thenAnswer((_) async => fakeResponse);

      final result = await homeService.retrieveMovieDetails(movieId: movieId);

      expect(result.isSuccess, true);
      expect(result.data, fakeMovieDetails);
    });
  });
}

