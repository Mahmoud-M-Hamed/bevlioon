import 'package:bevlioon/data/models/response/popular_movies/movie_response_model.dart';
import 'package:bevlioon/presentation/app/navigation/app_route_enum.dart';
import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/app_text.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_cubit.dart';
import 'package:bevlioon/presentation/features/ui/shared/favorite_icon_button.dart';
import 'package:bevlioon/presentation/features/ui/shared/movie_adapter.dart';
import 'package:bevlioon/utils/extensions/localization_extension.dart';
import 'package:bevlioon/utils/extensions/navigation_extension.dart';
import 'package:bevlioon/utils/extensions/non_null_extension.dart';
import 'package:bevlioon/utils/extensions/theme_extension.dart';
import 'package:bevlioon/utils/helpers/movie_model_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_card_icon_text_row.dart';

class MovieListItem extends StatefulWidget {
  final MovieSummaryResponseModel? movieSummary;

  const MovieListItem({required this.movieSummary, super.key});

  @override
  State<MovieListItem> createState() => _MovieListItemState();
}

class _MovieListItemState extends State<MovieListItem> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<FavoriteMoviesCubit>();
      final movieId = widget.movieSummary?.id;
      if (movieId != null) {
        cubit.checkIfFavorite(movieId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final String posterUrl = MovieModelHelper.getPosterUrl(
      widget.movieSummary?.posterPath,
    );

    final String releaseYear = MovieModelHelper.getReleaseYear(
      widget.movieSummary?.releaseYear,
    );

    final String rating = MovieModelHelper.getRating(
      widget.movieSummary?.rating,
    );

    return GestureDetector(
      onTap: () => context.push(
        AppRouteEnum.movieDetailsPage.name,
        extra: widget.movieSummary?.id,
      ),
      child: Card(
        elevation: Resources.elevation.$e3,
        margin: EdgeInsets.symmetric(horizontal: Resources.horizontalDims.$16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Resources.radius.$r16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Resources.horizontalDims.$12,
            vertical: Resources.verticalDims.$10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Resources.radius.$r8),
                child: posterUrl.isNotNullOrEmpty
                    ? Image.network(
                        posterUrl,
                        width: Resources.horizontalDims.$100,
                        height: Resources.verticalDims.$115,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: Resources.horizontalDims.$100,
                        height: Resources.verticalDims.$115,
                        color: Resources.colors.grayMediumLight,
                        child: Icon(
                          Icons.movie,
                          size: Resources.iconSizes.$50,
                          color: Resources.colors.grayMedium,
                        ),
                      ),
              ),
              SizedBox(width: Resources.horizontalDims.$15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text:
                          widget.movieSummary?.title ??
                          context.localization.untitled,
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: Resources.verticalDims.$8),
                    MovieCardIconTextRow(
                      icon: Icons.calendar_today,
                      text: releaseYear,
                      style: textTheme.bodySmall,
                    ),
                    SizedBox(height: Resources.verticalDims.$8),
                    MovieCardIconTextRow(
                      icon: Icons.star,
                      text: rating,
                      style: textTheme.bodySmall,
                      iconColor: Colors.amber,
                    ),
                    FavoriteIconButton(
                      movieModel: MovieAdapter.fromSummary(
                        movie: widget.movieSummary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
