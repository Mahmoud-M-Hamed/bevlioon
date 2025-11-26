import 'package:bevlioon/data/models/response/popular_movies/movie_response_model.dart';
import 'package:equatable/equatable.dart';

class PopularMoviesResponseModel extends Equatable {
  final int? page;
  final List<MovieSummaryResponseModel>? results;
  final int? totalPages;
  final int? totalResults;

  const PopularMoviesResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularMoviesResponseModel.fromJson(Map<String, dynamic> json) =>
      PopularMoviesResponseModel(
        page: json['page'],
        results: (json['results'] as List)
            .map(
              (e) =>
                  MovieSummaryResponseModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
