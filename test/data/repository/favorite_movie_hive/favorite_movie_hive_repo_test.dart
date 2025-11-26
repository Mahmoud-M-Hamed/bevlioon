import 'dart:io';

import 'package:bevlioon/data/data_source/local/constants/hive_box_keys.dart';
import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:bevlioon/data/repository/favorite_movie_hive/movie_hive_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  late Box<FavoriteMovieModel> box;
  late FavoriteMovieHiveRepoImpl repo;
  final String boxName = HiveBoxKeys.favoriteMoviesBoxKey;

  late Directory tempDir;
  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test_repo');
    Hive.init(tempDir.path);
    Hive.registerAdapter(FavoriteMovieModelAdapter());
    box = await Hive.openBox<FavoriteMovieModel>(boxName);
  });

  tearDown(() async {
    await box.clear();
  });

  tearDownAll(() async {
    await box.close();
    await Hive.deleteBoxFromDisk(boxName);
    await tempDir.delete(recursive: true);
  });

  setUp(() {
    repo = FavoriteMovieHiveRepoImpl();
  });

  group('FavoriteMovieHiveRepoImpl', () {
    test('getFavoriteMovies returns list of items', () async {
      final movie = FavoriteMovieModel(
        id: 1,
        title: 'A',
        posterUrl: '',
        alias: '',
        releaseYear: '',
        rating: '',
      );

      await box.put(1, movie);

      final result = await repo.getFavoriteMovies();

      expect(result.length, 1);
      expect(result.first.id, 1);
    });

    test('addFavorite inserts movie with id as key', () async {
      final movie = FavoriteMovieModel(
        id: 5,
        title: 'Movie',
        posterUrl: '',
        alias: '',
        releaseYear: '',
        rating: '',
      );

      await repo.addFavorite(movie);

      expect(box.get(5)?.id, 5);
    });

    test('removeFavorite deletes movie by key', () async {
      await box.put(
        10,
        FavoriteMovieModel(
          id: 10,
          title: 'T',
          posterUrl: '',
          alias: '',
          releaseYear: '',
          rating: '',
        ),
      );

      await repo.removeFavorite(10);

      expect(box.containsKey(10), isFalse);
    });

    test('isFavorite checks key existence', () async {
      await box.put(
        3,
        FavoriteMovieModel(
          id: 3,
          title: 'T',
          posterUrl: '',
          alias: '',
          releaseYear: '',
          rating: '',
        ),
      );

      final result = await repo.isFavorite(3);

      expect(result, true);
    });

    test('ensureBoxIsOpen opens box if closed', () async {
      await box.close();
      expect(Hive.isBoxOpen(boxName), isFalse);

      await repo.ensureBoxIsOpen();

      expect(Hive.isBoxOpen(boxName), isTrue);
      box = Hive.box<FavoriteMovieModel>(boxName);
    });
  });
}
