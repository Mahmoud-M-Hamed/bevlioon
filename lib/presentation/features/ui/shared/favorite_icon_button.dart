import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/common_favorite_alies_dialog.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/index.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_cubit.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:bevlioon/utils/helpers/movie_model_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_movie_payload.dart';
import 'movie_adapter.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({super.key, required this.movieModel});

  final MovieLike? movieModel;

  @override
  Widget build(BuildContext context) {
    final favoriteMoviesState = context.watch<FavoriteMoviesCubit>().state;

    final String posterUrl = MovieModelHelper.getPosterUrl(
      movieModel?.posterPath,
    );

    final String releaseYear = MovieModelHelper.getReleaseYear(
      movieModel?.releaseYear,
    );

    final String rating = MovieModelHelper.getRating(movieModel?.rating);

    final isFavorite = favoriteMoviesState.favoriteMovies.any(
      (favMovie) => favMovie.id == movieModel?.id,
    );

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Resources.colors.red : Resources.colors.grayMedium,
      ),
      onPressed: () => _toggleFavorite(
        context,
        FavoriteMoviePayload(
          movie: movieModel,
          posterUrl: posterUrl,
          releaseYear: releaseYear,
          rating: rating,
          isFavorite: isFavorite,
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
    FavoriteMoviePayload payload,
  ) async {
    final cubit = context.read<FavoriteMoviesCubit>();

    if (!payload.isFavorite) {
      final alias = await _getAliasForFavorite(context);
      if (alias.trim().isEmpty) return;

      await cubit.toggleFavorite(
        _favoriteMovieModelBuilder(
          movie: payload.movie,
          posterUrl: payload.posterUrl,
          releaseYear: payload.releaseYear,
          rating: payload.rating,
          alias: alias,
        ),
      );
      return;
    }

    await cubit.toggleFavorite(
      _favoriteMovieModelBuilder(
        movie: payload.movie,
        posterUrl: payload.posterUrl,
        releaseYear: payload.releaseYear,
        rating: payload.rating,
        alias: AppConstants.emptyString,
      ),
    );
  }

  Future<String> _getAliasForFavorite(BuildContext context) async {
    final alias = await CommonFavoriteAliesDialog.showFavoriteDialog(context);
    if (alias != null && alias.trim().isNotEmpty) {
      return alias.trim();
    }
    return AppConstants.emptyString;
  }

  FavoriteMovieModel _favoriteMovieModelBuilder({
    required MovieLike? movie,
    required String posterUrl,
    required String releaseYear,
    required String rating,
    required String alias,
  }) => FavoriteMovieModel(
    id: movie?.id,
    title: movie?.title,
    releaseYear: releaseYear,
    posterUrl: posterUrl,
    rating: rating,
    alias: alias,
  );
}
