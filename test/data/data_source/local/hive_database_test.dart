import 'dart:io';

import 'package:bevlioon/data/data_source/local/constants/hive_box_keys.dart';
import 'package:bevlioon/data/data_source/local/services/hive_db_service/hive_service.dart';
import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_db_test');
    Hive.init(tempDir.path);
  });

  tearDownAll(() async {
    await Hive.close();
    final testBoxes = ['test_box', HiveBoxKeys.favoriteMoviesBoxKey];

    for (var boxName in testBoxes) {
      if (await Hive.boxExists(boxName)) {
        await Hive.deleteBoxFromDisk(boxName);
      }
    }

    await tempDir.delete(recursive: true);
  });

  group('HiveDatabase', () {
    test('offlineDBInitialization opens favoriteMoviesBox', () async {
      final future = HiveDatabase.offlineDBInitialization();

      expect(future, completes);

      await future;

      final isOpen = Hive.isBoxOpen(HiveBoxKeys.favoriteMoviesBoxKey);
      expect(isOpen, true);

      final box = Hive.box<FavoriteMovieModel>(
        HiveBoxKeys.favoriteMoviesBoxKey,
      );
      await box.clear();
      await box.close();
    });
  });
}

