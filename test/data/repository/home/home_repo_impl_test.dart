import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart';
import 'package:bevlioon/data/data_source/remote/services/home/home_service.dart';
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart';
import 'package:bevlioon/data/repository/home/home_repo_impl.dart';
import 'package:bevlioon/utils/helpers/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeService])
void main() {
  late MockHomeService mockHomeService;
  late HomeRepoImpl repo;

  setUp(() {
    mockHomeService = MockHomeService();
    repo = HomeRepoImpl(homeService: mockHomeService);
  });

  group('HomeRepoImpl', () {
    test('retrievePopularMovies returns Success', () async {
      final request = PaginationRequestModel(paging: 1);
      final fakeResponse = const NetworkResponse(
        data: PopularMoviesResponseModel(
          results: [],
          page: 1,
          totalPages: 1,
          totalResults: 50,
        ),
        message: "OK",
        isSuccess: true,
      );

      when(
        mockHomeService.retrievePopularMovies(requestModel: request),
      ).thenAnswer((_) async => fakeResponse);

      final result = await repo.retrievePopularMovies(requestModel: request);

      expect(result, isA<Success>());
      expect((result as Success).data.data?.page, 1);
    });

    test('retrieveMovieDetails returns Success', () async {
      const movieId = 10;

      final fakeResponse = const NetworkResponse<MovieDetailsResponseModel>(
        isSuccess: true,
        data: MovieDetailsResponseModel(
          title: "Movie",
          overview: "",
          posterPath: "",
          rating: 2.0,
          releaseYear: '',
        ),
        message: "OK",
      );

      when(
        mockHomeService.retrieveMovieDetails(movieId: movieId),
      ).thenAnswer((_) async => fakeResponse);

      final result = await repo.retrieveMovieDetails(movieId: movieId);

      expect(result, isA<Success<NetworkResponse<MovieDetailsResponseModel>>>());
      final resp = (result as Success<NetworkResponse<MovieDetailsResponseModel>>).data;
      expect(resp.data?.title, "Movie");
    });
  });
}

