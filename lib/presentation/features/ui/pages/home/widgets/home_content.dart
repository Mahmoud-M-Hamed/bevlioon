import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/presentation/features/common_widgets/common_error_handler_page.dart';
import 'package:bevlioon/presentation/features/common_widgets/custom_loading_widget.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/cubit/popular_movies_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/widgets/popular_movies_list.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:bevlioon/utils/extensions/api_error_l10n_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/reusable_components/index.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final popularMoviesCubit = context.read<PopularMoviesCubit>();
    final popularMoviesState = context.watch<PopularMoviesCubit>().state;

    final String? errorMessage =
        popularMoviesState.appErrorModel?.message ??
        popularMoviesState.appErrorModel?.code.messageOf(context);

    return CommonErrorHandlerWrapperPage(
      isLoading: popularMoviesState.isLoading,
      hasError: popularMoviesState.isError,
      onRetry: () => popularMoviesCubit.retrievePopularMovies(
        requestModel: PaginationRequestModel(
          paging: AppConstants.initialPagingPageNumber,
        ),
      ),
      loadingWidget: const CustomLoadingWidget(),
      errorMessage: errorMessage,
      onSuccessBuilder: (context) => const PopularMoviesList(),
    );
  }
}
