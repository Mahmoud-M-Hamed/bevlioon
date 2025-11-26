import 'package:bevlioon/core/di/dependency_injector.dart';
import 'package:bevlioon/data/models/request/pagination/pagination_request_model.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/custom_app_bar.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/cubit/popular_movies_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/home/widgets/home_content.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:bevlioon/utils/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = 'HomePage';
  static const String routePath = '/HomePage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<PopularMoviesCubit>()..retrievePopularMovies(
            requestModel: PaginationRequestModel(
              paging: AppConstants.initialPagingPageNumber,
            ),
          ),
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          showActionButton: true,
          showBackButton: false,
          titleText: context.localization.popularMovies,
        ),
        body: const HomeContent(),
      ),
    );
  }
}
