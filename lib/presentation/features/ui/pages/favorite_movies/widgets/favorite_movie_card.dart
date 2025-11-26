import 'package:bevlioon/data/models/response/favorite_movie/favorite_movie_model.dart';
import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/app_text.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/custom_network_icon_builder.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/index.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_cubit.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:bevlioon/utils/extensions/localization_extension.dart';
import 'package:bevlioon/utils/extensions/theme_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteMovieCard extends StatelessWidget {
  final FavoriteMovieModel movie;

  const FavoriteMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final favoriteMoviesCubit = context.read<FavoriteMoviesCubit>();

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(Resources.radius.$r16),
          boxShadow: [
            BoxShadow(
              color: Resources.colors.red.withValues(alpha: 0.15),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Resources.radius.$r14),
                bottomLeft: Radius.circular(Resources.radius.$r14),
              ),
              child: CustomNetworkImageBuilder(
                srcUrl: movie.posterUrl ?? AppConstants.emptyString,
                height: Resources.verticalDims.$104,
                width: Resources.verticalDims.$80,
              ),
            ),
            SizedBox(width: Resources.horizontalDims.$16),
            Expanded(child: _MovieCardInfo(movie: movie)),
            IconButton(
              icon: Icon(Icons.favorite, color: Resources.colors.red),
              onPressed: () =>
                  favoriteMoviesCubit.removeFavorite(movie.id ?? 0),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieCardInfo extends StatelessWidget {
  const _MovieCardInfo({required this.movie});

  final FavoriteMovieModel movie;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: Resources.verticalDims.$16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: movie.alias ?? AppConstants.emptyString,
            style: textTheme.headlineSmall?.copyWith(
              color: Resources.colors.accentPrimary,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$5),
          AppText(
            text: movie.title ?? context.localization.untitled,
            style: textTheme.titleSmall?.copyWith(
              color: Resources.colors.white,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$2),
          Text(
            movie.releaseYear ?? AppConstants.emptyString,
            style: textTheme.headlineSmall?.copyWith(
              color: Resources.colors.grayMedium,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$8),
          Container(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: Resources.horizontalDims.$10,
              vertical: Resources.verticalDims.$3,
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Resources.radius.$r10),
            ),
            child: Text(
              movie.rating ?? AppConstants.nanString,
              style: context.textTheme.headlineSmall?.copyWith(
                color: Resources.colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
