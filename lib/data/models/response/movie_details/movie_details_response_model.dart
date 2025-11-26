import 'package:equatable/equatable.dart';

class MovieDetailsResponseModel extends Equatable {
  final String? posterPath;
  final String? title;
  final String? releaseYear;
  final double? rating;
  final String? overview;

  const MovieDetailsResponseModel({
    required this.posterPath,
    required this.title,
    required this.releaseYear,
    required this.rating,
    required this.overview,
  });

  factory MovieDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailsResponseModel(
        posterPath: json['poster_path'],
        title: json['title'],
        releaseYear: json['release_date'],
        rating: json['vote_average'],
        overview: json['overview'],
      );

  @override
  List<Object?> get props => [posterPath, title, releaseYear, rating, overview];
}
