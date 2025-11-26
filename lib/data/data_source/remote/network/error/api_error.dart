import 'package:bevlioon/core/error/error_codes_enum.dart';
import 'package:dio/dio.dart';

class ApiError implements Exception {
  /// Factory that builds an [ApiError] from a [DioException].
  ///
  /// ### Mapping rules
  /// - [DioExceptionType.connectionTimeout], [DioExceptionType.receiveTimeout],
  ///   [DioExceptionType.sendTimeout] → [ErrorCodesEnum.timeout]
  /// - [DioExceptionType.connectionError] → [ErrorCodesEnum.network]
  /// - [DioExceptionType.cancel] → `Request Cancelled` with [ErrorCodesEnum.unknown]
  /// - Otherwise:
  ///   - If response body has a structured `error` map → [fromBackendMap]
  ///   - Else if only `statusCode` exists → map to [ErrorCodesEnum.fromCode]
  ///   - Else → [ErrorCodesEnum.unknown]
  factory ApiError.fromDioException(DioException e, {StackTrace? stackTrace}) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiError(code: ErrorCodesEnum.timeout, stackTrace: stackTrace);

      case DioExceptionType.connectionError:
        return ApiError(code: ErrorCodesEnum.network, stackTrace: stackTrace);

      case DioExceptionType.cancel:
        return ApiError(code: ErrorCodesEnum.unknown, stackTrace: stackTrace);
      default:
        {
          final status = e.response?.statusCode;
          if (status != null) {
            return ApiError(
              code: ErrorCodesEnum.fromCode(status),
              stackTrace: stackTrace,
            );
          }
          return ApiError(code: ErrorCodesEnum.unknown, stackTrace: stackTrace);
        }
    }
  }

  factory ApiError.fromJson(Map<String, dynamic>? errorJson) {
    if (errorJson?.isEmpty ?? true) {
      return ApiError(code: ErrorCodesEnum.unknown);
    }
    return ApiError(
      code: ErrorCodesEnum.fromCode(errorJson?['code']),
      title: null,
      message: errorJson?['message'],
    );
  }

  /// Creates an [ApiError] directly.
  ///
  /// If [title] or [message] are not provided, the defaults from [code] will be used.
  ApiError({required this.code, this.title, this.message, this.stackTrace});

  /// The categorized error code, mapped from backend or HTTP/Dio context.
  final ErrorCodesEnum code;

  /// Short, user-friendly error title.
  ///
  /// Example: `"Network Error"`, `"Timeout"`, `"Unauthorized"`.
  final String? title;

  /// Longer, user-friendly message (safe to show in UI).
  ///
  /// Example: `"Please check your internet connection and try again."`
  final String? message;

  final StackTrace? stackTrace;
}
