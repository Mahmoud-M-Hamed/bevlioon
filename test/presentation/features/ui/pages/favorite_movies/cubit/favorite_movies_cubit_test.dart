import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:bevlioon/domain/repository/favorite_movie_hive/movie_hive_repo.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_state.dart';
import 'package:bevlioon/utils/enums/cubit_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_movies_cubit_test.mocks.dart';

@GenerateMocks([BaseFavoriteMovieHiveRepo])
void main() {
  group('FavoriteMoviesCubit', () {
    late FavoriteMoviesCubit cubit;
    late MockBaseFavoriteMovieHiveRepo mockRepo;

    final testMovie = FavoriteMovieModel(
      id: 1,
      title: 'Test Movie',
      posterUrl: '/test.jpg',
      alias: 'Test Alias',
      releaseYear: '2023',
      rating: '8.5',
    );

    setUp(() {
      mockRepo = MockBaseFavoriteMovieHiveRepo();

      when(mockRepo.ensureBoxIsOpen()).thenAnswer((_) async {});
      when(mockRepo.getFavoriteMovies()).thenAnswer((_) async => []);
      when(mockRepo.isFavorite(any)).thenAnswer((_) async => false);
      when(mockRepo.addFavorite(any)).thenAnswer((_) async {});
      when(mockRepo.removeFavorite(any)).thenAnswer((_) async {});

      cubit = FavoriteMoviesCubit(favoriteMovieHiveRepo: mockRepo);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(
        cubit.state,
        const FavoriteMoviesState(
          cubitStatus: CubitStatus.initial,
          checkStatus: CubitStatus.initial,
          favoriteMovies: [],
          isFavorite: false,
        ),
      );
    });

    group('loadFavorites', () {
      test('emits loading and success states', () async {
        when(mockRepo.getFavoriteMovies()).thenAnswer((_) async => [testMovie]);

        final states = [];
        final subscription = cubit.stream.listen(states.add);
        await cubit.loadFavorites();
        await Future.delayed(Duration.zero);

        expect(states.length, 2);
        expect(states[0].cubitStatus, CubitStatus.loading);
        expect(states[1].cubitStatus, CubitStatus.success);
        expect(states[1].favoriteMovies, [testMovie]);

        verify(mockRepo.ensureBoxIsOpen()).called(1);
        verify(mockRepo.getFavoriteMovies()).called(1);

        await subscription.cancel();
      });
    });

    group('addFavorite', () {
      test('calls repository methods', () async {
        when(mockRepo.getFavoriteMovies()).thenAnswer((_) async => [testMovie]);

        await cubit.addFavorite(testMovie);

        verifyInOrder([
          mockRepo.addFavorite(testMovie),
          mockRepo.ensureBoxIsOpen(),
          mockRepo.getFavoriteMovies(),
        ]);
      });
    });

    group('removeFavorite', () {
      test('calls repository methods', () async {
        await cubit.removeFavorite(1);

        verifyInOrder([
          mockRepo.removeFavorite(1),
          mockRepo.ensureBoxIsOpen(),
          mockRepo.getFavoriteMovies(),
        ]);
      });
    });

    group('checkIfFavorite', () {
      test('updates state with favorite status', () async {
        when(mockRepo.isFavorite(1)).thenAnswer((_) async => true);

        await cubit.checkIfFavorite(1);

        expect(cubit.state.isFavorite, true);
        verify(mockRepo.isFavorite(1)).called(1);
      });
    });

    group('toggleFavorite', () {
      test('calls addFavorite when movie is not favorite', () async {
        when(mockRepo.isFavorite(1)).thenAnswer((_) async => false);

        await cubit.toggleFavorite(testMovie);

        verify(mockRepo.isFavorite(1)).called(1);
        verify(mockRepo.addFavorite(testMovie)).called(1);
      });

      test('calls removeFavorite when movie is already favorite', () async {
        when(mockRepo.isFavorite(1)).thenAnswer((_) async => true);

        await cubit.toggleFavorite(testMovie);

        verify(mockRepo.isFavorite(1)).called(1);
        verify(mockRepo.removeFavorite(1)).called(1);
      });
    });
  });
}

