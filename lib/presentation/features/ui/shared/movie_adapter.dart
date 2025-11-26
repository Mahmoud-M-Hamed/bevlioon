import 'package:bevlioon/data/models/response/movie_details/movie_details_response_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/movie_response_model.dart';

abstract class MovieLike {
  int? get id;

  String? get title;

  String? get posterPath;

  String? get releaseYear;

  double? get rating;

  String? get overview;
}

class MovieAdapter implements MovieLike {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? posterPath;
  @override
  final String? releaseYear;
  @override
  final double? rating;
  @override
  final String? overview;

  MovieAdapter.fromSummary({required MovieSummaryResponseModel? movie})
    : id = movie?.id,
      title = movie?.title,
      posterPath = movie?.posterPath,
      releaseYear = movie?.releaseYear?.split('-').first,
      rating = movie?.rating,
      overview = null;

  MovieAdapter.fromDetails({
    required MovieDetailsResponseModel? movie,
    required this.id,
  }) : title = movie?.title,
       posterPath = movie?.posterPath,
       releaseYear = movie?.releaseYear,
       rating = movie?.rating,
       overview = movie?.overview;
}
