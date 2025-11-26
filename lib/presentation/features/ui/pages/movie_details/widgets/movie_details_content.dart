import 'package:bevlioon/presentation/features/common_widgets/common_error_handler_page.dart';
import 'package:bevlioon/presentation/features/common_widgets/custom_loading_widget.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/index.dart';
import 'package:bevlioon/presentation/features/ui/pages/movie_details/cubit/movie_details_cubit.dart';
import 'package:bevlioon/utils/extensions/api_error_l10n_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_overview.dart';

class MovieDetailsContent extends StatelessWidget {
  const MovieDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final movieDetailsCubit = context.read<MovieDetailsCubit>();
    final movieDetailsState = context.watch<MovieDetailsCubit>().state;

    final String? errorMessage =
        movieDetailsState.appErrorModel?.message ??
        movieDetailsState.appErrorModel?.code.messageOf(context);

    return CommonErrorHandlerWrapperPage(
      isLoading: movieDetailsState.isLoading,
      hasError: movieDetailsState.isError,
      onRetry: () => movieDetailsCubit.retrieveMovieDetails(
        movieId: movieDetailsState.movieId ?? 0,
      ),
      loadingWidget: const CustomLoadingWidget(),
      errorMessage: errorMessage,
      onSuccessBuilder: (context) => const MovieOverview(),
    );
  }
}
