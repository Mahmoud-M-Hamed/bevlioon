import 'package:bevlioon/core/error/app_error_model.dart';
import 'package:bevlioon/core/error/error_codes_enum.dart';
import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart';
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/movie_response_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/popular_movies_response_model.dart';
import 'package:bevlioon/domain/repository/home/base_home_repo.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/cubit/popular_movies_cubit.dart';
import 'package:bevlioon/utils/helpers/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_cubit_test.mocks.dart';

@GenerateMocks([BaseHomeRepo])
void main() {
  late MockBaseHomeRepo mockRepo;
  late PopularMoviesCubit cubit;

  final movie = const MovieSummaryResponseModel(
    id: 1,
    title: 'Inception',
    posterPath: '',
    releaseYear: '2023',
    rating: 8.5,
  );

  final responseModel = PopularMoviesResponseModel(
    page: 1,
    totalPages: 5,
    totalResults: 100,
    results: [movie],
  );

  setUpAll(() {
    provideDummy<Result<NetworkResponse<PopularMoviesResponseModel>>>(
      Success(
        NetworkResponse<PopularMoviesResponseModel>(
          isSuccess: true,
          data: responseModel,
        ),
      ),
    );
  });

  setUp(() {
    mockRepo = MockBaseHomeRepo();
    cubit = PopularMoviesCubit(baseHomeRepo: mockRepo);
  });

  tearDown(() async {
    await cubit.close();
  });

  group('retrievePopularMovies', () {
    test('emits success state and returns list of movies on success', () async {
      final request = PaginationRequestModel(paging: 1);
      final networkResponse = NetworkResponse<PopularMoviesResponseModel>(
        data: responseModel,
        httpStatusCode: 200,
        message: 'OK',
        isSuccess: true,
      );

      when(
        mockRepo.retrievePopularMovies(requestModel: request),
      ).thenAnswer((_) async => Success(networkResponse));

      final movies = await cubit.retrievePopularMovies(requestModel: request);

      expect(movies, isA<List<MovieSummaryResponseModel>>());
      expect(movies.length, 1);
      expect(movies[0].title, 'Inception');
      verify(mockRepo.retrievePopularMovies(requestModel: request)).called(1);
    });

    test('emits error state and returns empty list on failure', () async {
      final request = PaginationRequestModel(paging: 1);
      final error = const AppErrorModel(
        code: ErrorCodesEnum.serverError,
        message: 'Error',
        title: 'Error',
      );

      when(
        mockRepo.retrievePopularMovies(requestModel: request),
      ).thenAnswer((_) async => Failure(error));

      final movies = await cubit.retrievePopularMovies(requestModel: request);

      expect(movies, isEmpty);
      verify(mockRepo.retrievePopularMovies(requestModel: request)).called(1);
    });

    test('returns empty list when paging >= totalPages', () async {
      final request = PaginationRequestModel(paging: 6);

      when(mockRepo.retrievePopularMovies(requestModel: request)).thenAnswer(
        (_) async => Success(
          NetworkResponse<PopularMoviesResponseModel>(
            data: responseModel,
            httpStatusCode: 200,
            message: 'OK',
            isSuccess: true,
          ),
        ),
      );

      final movies = await cubit.retrievePopularMovies(requestModel: request);

      expect(movies, isEmpty);
    });
  });
}
