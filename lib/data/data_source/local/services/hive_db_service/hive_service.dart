import 'package:bevlioon/data/data_source/local/constants/hive_box_keys.dart';
import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabaseService {
  static Future<void> initialize() => Hive.initFlutter();

  static void registerAdapter<T>({required TypeAdapter<T> registeredAdapter}) =>
      Hive.registerAdapter<T>(registeredAdapter);

  static Future<void> openBox<R>({required String boxName}) =>
      Hive.openBox<R>(boxName);
}

class HiveDatabase {
  static Future<void> offlineDBInitialization() async {
    final String favoriteMoviesBoxName = HiveBoxKeys.favoriteMoviesBoxKey;
    HiveDatabaseService.registerAdapter<FavoriteMovieModel>(
      registeredAdapter: FavoriteMovieModelAdapter(),
    );
    await HiveDatabaseService.openBox<FavoriteMovieModel>(
      boxName: favoriteMoviesBoxName,
    );
  }
}
