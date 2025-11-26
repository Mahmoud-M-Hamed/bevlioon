import 'package:equatable/equatable.dart';

class MovieSummaryResponseModel extends Equatable {
  final int id;
  final String? posterPath;
  final String? title;
  final String? releaseYear;
  final double? rating;

  const MovieSummaryResponseModel({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.releaseYear,
    required this.rating,
  });

  factory MovieSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieSummaryResponseModel(
        id: json['id'],
        posterPath: json['poster_path'],
        title: json['title'],
        releaseYear: json['release_date'],
        rating: json['vote_average'],
      );

  @override
  List<Object?> get props => [id, posterPath, title, releaseYear, rating];
}
