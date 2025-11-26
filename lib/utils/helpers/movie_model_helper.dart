import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:bevlioon/utils/extensions/non_null_extension.dart';

class MovieModelHelper {
  static String getPosterUrl(String? posterPath) {
    if (posterPath.isNotNullOrEmpty) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
    return AppConstants.emptyString;
  }

  static String getReleaseYear(String? releaseYear) {
    if (releaseYear.isNotNullOrEmpty) {
      final parts = releaseYear?.split('-');
      if (parts?.isNotEmpty == true && parts?[0].isNotEmpty == true) {
        return parts?[0] ?? 'N/A';
      }
    }
    return 'N/A';
  }

  static String getRating(double? rating, {int fractionDigits = 1}) {
    if (rating != null) {
      return rating.toStringAsFixed(fractionDigits);
    }
    return '0';
  }
}
