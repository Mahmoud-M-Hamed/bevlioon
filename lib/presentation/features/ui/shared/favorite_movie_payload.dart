import 'movie_adapter.dart';

class FavoriteMoviePayload {
  final MovieLike? movie;
  final String posterUrl;
  final String releaseYear;
  final String rating;
  final bool isFavorite;

  FavoriteMoviePayload({
    required this.movie,
    required this.posterUrl,
    required this.releaseYear,
    required this.rating,
    required this.isFavorite,
  });
}
