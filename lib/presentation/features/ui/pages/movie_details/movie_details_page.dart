import 'package:bevlioon/core/di/dependency_injector.dart';
import 'package:bevlioon/presentation/features/ui/pages/movie_details/widgets/movie_details_content.dart';
import 'package:bevlioon/utils/helpers/system_ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/movie_details_cubit.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  static const String routeName = 'MovieDetailsPage';
  static const String routePath = '/MovieDetailsPage';

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocatorInstance<MovieDetailsCubit>()
            ..retrieveMovieDetails(movieId: movieId),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUIHelper.lightSystemUiOverlayStyle(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: const MovieDetailsContent(),
        ),
      ),
    );
  }
}
