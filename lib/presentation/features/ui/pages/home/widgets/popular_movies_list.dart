import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/data/models/response/popular_movies/movie_response_model.dart';
import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/custom_pagination/custom_paginated_list.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/cubit/popular_movies_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/widgets/popular_movie_item.dart';
import 'package:bevlioon/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesList extends StatelessWidget {
  const PopularMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final popularMoviesCubit = context.read<PopularMoviesCubit>();

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: Resources.verticalDims.$16,
      ),
      child: CustomPaginatedList<MovieSummaryResponseModel>(
        fetchPage: (pageKey) => popularMoviesCubit.retrievePopularMovies(
          requestModel: PaginationRequestModel(paging: pageKey),
        ),

        separatorBuilder: (_, __) =>
            SizedBox(height: Resources.verticalDims.$18),

        itemBuilder: (context, movieSummary, index, total) {
          return AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 250),
            child: MovieListItem(movieSummary: movieSummary),
          );
        },

        firstPageErrorBuilder: (context, retry) =>
            _ErrorView(message: localization.retryTap, onRetry: () => retry),
        nextPageErrorBuilder: (context, retry) => _ErrorView(
          message: localization.failedToLoadMoreMovies,
          onRetry: () => retry,
        ),

        noItemsFoundBuilder: (context) => Center(
          child: Text(
            localization.noContentAvailable,
            style: TextStyle(fontSize: Resources.fontSizes.$16),
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red.shade400,
              fontSize: Resources.fontSizes.$15,
              fontWeight: Resources.fontWeights.medium,
            ),
          ),
          SizedBox(height: Resources.verticalDims.$12),
          FilledButton(
            onPressed: onRetry,
            style: FilledButton.styleFrom(
              backgroundColor: Resources.colors.red,
              minimumSize: Size(
                Resources.horizontalDims.$100,
                Resources.verticalDims.$40,
              ),
            ),
            child: Text(context.localization.retry),
          ),
        ],
      ),
    );
  }
}
