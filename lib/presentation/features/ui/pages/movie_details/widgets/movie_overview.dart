import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/app_text.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/custom_network_icon_builder.dart';
import 'package:bevlioon/presentation/features/ui/pages/movie_details/cubit/movie_details_cubit.dart';
import 'package:bevlioon/presentation/features/ui/shared/favorite_icon_button.dart';
import 'package:bevlioon/presentation/features/ui/shared/movie_adapter.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:bevlioon/utils/extensions/localization_extension.dart';
import 'package:bevlioon/utils/helpers/movie_model_helper.dart';
import 'package:bevlioon/utils/helpers/system_ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieOverview extends StatelessWidget {
  const MovieOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final movieDetailsState = context.watch<MovieDetailsCubit>().state;
    final movieDetails = movieDetailsState.movieDetails;
    final String posterPath = MovieModelHelper.getPosterUrl(
      movieDetails?.posterPath,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUIHelper.darkSystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Resources.colors.white,
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: Resources.verticalDims.$400,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: AppConstants.posterTag,
                child: CustomNetworkImageBuilder(srcUrl: posterPath),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: Resources.horizontalDims.$16,
                vertical: Resources.verticalDims.$16,
              ),
              color: Colors.grey.shade900,
              child: const _MovieOverviewInfoSection(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieOverviewInfoSection extends StatelessWidget {
  const _MovieOverviewInfoSection();

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final movieDetailsState = context.watch<MovieDetailsCubit>().state;
    final movieDetails = movieDetailsState.movieDetails;

    final title = movieDetails?.title;
    final overview = movieDetails?.overview;

    final String releaseYear = MovieModelHelper.getReleaseYear(
      movieDetails?.releaseYear,
    );

    final String rating = MovieModelHelper.getRating(movieDetails?.rating);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: AppText(
                text: title ?? localization.untitled,
                style: TextStyle(
                  color: Resources.colors.white,
                  fontSize: Resources.fontSizes.$26,
                  fontWeight: Resources.fontWeights.bold,
                ),
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            FittedBox(
              child: FavoriteIconButton(
                movieModel: MovieAdapter.fromDetails(
                  movie: movieDetails,
                  id: movieDetailsState.movieId,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$8),
        Row(
          children: [
            AppText(
              text: releaseYear,
              style: TextStyle(
                color: Resources.colors.grayMedium,
                fontSize: Resources.fontSizes.$14,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$12),
            Icon(
              Icons.star,
              color: Colors.amber.shade400,
              size: Resources.iconSizes.$18,
            ),
            SizedBox(width: Resources.horizontalDims.$2),
            AppText(
              text: rating,
              style: TextStyle(
                color: Resources.colors.white,
                fontSize: Resources.fontSizes.$14,
              ),
            ),
          ],
        ),
        SizedBox(height: Resources.verticalDims.$22),
        AppText(
          text: localization.overview,
          style: TextStyle(
            color: Resources.colors.white,
            fontSize: Resources.fontSizes.$18,
            fontWeight: Resources.fontWeights.semiBold,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$5),
        AppText(
          text: overview ?? localization.noOverviewAvailable,
          maxLines: 20,
          style: TextStyle(
            color: Resources.colors.graySlate,
            fontSize: Resources.fontSizes.$14,
            height: 1.4,
          ),
        ),
        SizedBox(height: Resources.verticalDims.$20),
      ],
    );
  }
}
