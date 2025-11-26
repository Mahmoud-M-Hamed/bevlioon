import 'package:bevlioon/core/error/app_error_model.dart';
import 'package:bevlioon/utils/helpers/result.dart';

/// Executes an async [function] and wraps its outcome in a `Result<T>`.
///
/// - On success → returns `Success<T>(value)`.
/// - On error   → returns `Failure<T>(AppErrorModel<T>)`, optionally carrying
///   [defaultDataOnError] so callers still get fallback data with the error.
///
/// Useful to centralize try/catch and exception→error-model mapping.
///
/// Type params:
/// - `T`: the value type produced by [function].
///
/// Params:
/// - [function]: zero-arg async operation to execute.
/// - [defaultDataOnError]: optional fallback data attached to the failure.
///
/// Example:
/// ```dart
/// Future<Result<User>> fetchMe() => safeAsyncCall<User>(() async {
///   final res = await dio.get('/me');
///   return User.fromJson(res.data);
/// }, defaultDataOnError: User.empty());
/// ```
Future<Result<T>> safeAsyncCall<T>(
  Future<T> Function() function, {
  T? defaultDataOnError,
}) async {
  try {
    final result = await function();
    return Success(result);
  } catch (e, s) {
    return Failure(
      AppErrorModel<T>.fromException(
        e,
        stackTrace: s,
        data: defaultDataOnError,
      ),
    );
  }
}

/// For non async
Result<T> safeCall<T>(T Function() function, {T? defaultDataOnError}) {
  try {
    final result = function();
    return Success(result);
  } catch (e, s) {
    return Failure(
      AppErrorModel<T>.fromException(
        e,
        stackTrace: s,
        data: defaultDataOnError,
      ),
    );
  }
}
