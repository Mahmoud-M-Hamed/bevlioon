import 'package:bevlioon/core/error/app_error_model.dart';
import 'package:bevlioon/core/error/error_codes_enum.dart';
import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart';
import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/domain/repository/home/base_home_repo.dart';
import 'package:bevlioon/presentation/features/ui/pages/movie_details/cubit/movie_details_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/movie_details/cubit/movie_details_state.dart';
import 'package:bevlioon/utils/enums/cubit_status.dart';
import 'package:bevlioon/utils/helpers/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_details_cubit_test.mocks.dart';

@GenerateMocks([BaseHomeRepo])
void main() {
  late MockBaseHomeRepo mockRepo;
  late MovieDetailsCubit cubit;

  const fakeDetails = MovieDetailsResponseModel(
    title: 'Test Movie',
    overview: 'Test overview',
    releaseYear: '2023',
    posterPath: '/test.jpg',
    rating: 8.0,
  );

  setUpAll(() {
    provideDummy<Result<NetworkResponse<MovieDetailsResponseModel>>>(
      const Success(
        NetworkResponse<MovieDetailsResponseModel>(
          isSuccess: true,
          data: fakeDetails,
        ),
      ),
    );
  });

  setUp(() {
    mockRepo = MockBaseHomeRepo();
    cubit = MovieDetailsCubit(baseHomeRepo: mockRepo);
  });

  tearDown(() async {
    await cubit.close();
  });

  group('MovieDetailsCubit Tests', () {
    test(
      'emits [loading, success] when retrieveMovieDetails succeeds',
      () async {
        const movieId = 10;

        final networkResponse =
            const NetworkResponse<MovieDetailsResponseModel>(
              data: fakeDetails,
              httpStatusCode: 200,
              message: 'OK',
              isSuccess: true,
            );

        when(
          mockRepo.retrieveMovieDetails(movieId: movieId),
        ).thenAnswer((_) async => Success(networkResponse));

        expectLater(
          cubit.stream,
          emitsInOrder([
            isA<MovieDetailsState>().having(
              (s) => s.cubitStatus,
              'loading',
              CubitStatus.loading,
            ),
            isA<MovieDetailsState>().having(
              (s) =>
                  s.cubitStatus == CubitStatus.success &&
                  s.movieDetails?.title == 'Test Movie',
              'success',
              true,
            ),
          ]),
        );

        await cubit.retrieveMovieDetails(movieId: movieId);
      },
    );

    test('emits [loading, error] when retrieveMovieDetails fails', () async {
      const movieId = 10;

      final error = const AppErrorModel(
        code: ErrorCodesEnum.serverError,
        message: 'Test error',
        title: 'Test error',
      );

      when(
        mockRepo.retrieveMovieDetails(movieId: movieId),
      ).thenAnswer((_) async => Failure(error));

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<MovieDetailsState>().having(
            (s) => s.cubitStatus,
            'loading',
            CubitStatus.loading,
          ),
          isA<MovieDetailsState>().having(
            (s) =>
                s.cubitStatus == CubitStatus.error && s.appErrorModel != null,
            'error',
            true,
          ),
        ]),
      );

      await cubit.retrieveMovieDetails(movieId: movieId);
    });
  });
}
