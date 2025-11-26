import 'package:hive/hive.dart';

part 'favorite_movie_model.g.dart';

@HiveType(typeId: 1)
class FavoriteMovieModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? posterUrl;

  @HiveField(3)
  final String? alias;

  @HiveField(4)
  final String? releaseYear;

  @HiveField(5)
  final String? rating;

  FavoriteMovieModel({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.alias,
    required this.releaseYear,

    required this.rating,
  });
}
