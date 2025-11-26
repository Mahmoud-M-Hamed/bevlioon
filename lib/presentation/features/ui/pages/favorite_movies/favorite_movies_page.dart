import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/app_text.dart';
import 'package:bevlioon/presentation/features/common_widgets/common_error_handler_page.dart';
import 'package:bevlioon/presentation/features/common_widgets/custom_loading_widget.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_movies_cubit.dart';
import 'package:bevlioon/utils/extensions/localization_extension.dart';
import 'package:bevlioon/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/favorite_movie_card.dart';

class FavoriteMoviesPage extends StatelessWidget {
  const FavoriteMoviesPage({super.key});

  static const routeName = 'FavoriteMoviesPage';
  static const routePath = '/FavoriteMoviesPage';

  @override
  Widget build(BuildContext context) {
    final favoriteMoviesState = context.watch<FavoriteMoviesCubit>().state;
    final isLoading = favoriteMoviesState.isLoading;
    final favoriteMovies = favoriteMoviesState.favoriteMovies;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        elevation: 0,
        title: AppText(
          text: context.localization.favoriteMovies,
          style: context.textTheme.titleMedium?.copyWith(
            color: Resources.colors.white,
          ),
        ),
        backgroundColor: Colors.grey.shade900,
      ),
      body: CommonErrorHandlerWrapperPage(
        isLoading: isLoading,
        hasError: favoriteMoviesState.isError,
        loadingWidget: CustomLoadingWidget(color: Resources.colors.red),
        onSuccessBuilder: (context) {
          if (favoriteMovies.isEmpty) {
            return const _FavoriteEmptyState();
          }

          return ListView.separated(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: Resources.horizontalDims.$16,
              vertical: Resources.verticalDims.$12,
            ),
            separatorBuilder: (_, __) =>
                SizedBox(height: Resources.verticalDims.$16),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) =>
                FavoriteMovieCard(movie: favoriteMovies[index]),
          );
        },
      ),
    );
  }
}

class _FavoriteEmptyState extends StatelessWidget {
  const _FavoriteEmptyState();

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            color: Colors.white38,
            size: Resources.iconSizes.$80,
          ),
          SizedBox(height: Resources.verticalDims.$16),
          AppText(
            text: localization.noFavorites,
            style: context.textTheme.titleSmall?.copyWith(
              color: Resources.colors.white.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: Resources.verticalDims.$5),
          AppText(
            text: localization.addMovies,
            style: context.textTheme.labelSmall?.copyWith(
              color: Resources.colors.grayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
