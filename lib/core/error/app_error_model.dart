import 'package:bevlioon/core/error/error_codes_enum.dart';
import 'package:bevlioon/data/data_source/remote/network/error/api_error.dart';
import 'package:flutter/foundation.dart';

/// Standard wrapper for application errors.
///
/// Provides a unified way to represent errors from APIs, exceptions,
/// or in-app issues with optional attached data.
class AppErrorModel<T> {
  const AppErrorModel({
    required this.code,
    required this.title,
    required this.message,
    this.stackTrace,
    this.error,
    this.data,
  });

  /// Map from [ApiError].
  factory AppErrorModel.fromApiError(ApiError apiError, {T? data}) {
    return AppErrorModel(
      code: apiError.code,
      title: apiError.title,
      message: apiError.message,
      stackTrace: apiError.stackTrace,
      error: apiError,
      data: data,
    );
  }

  /// Create from any exception.
  factory AppErrorModel.fromException(
    Object e, {
    StackTrace? stackTrace,
    T? data,
  }) {
    if (e is ApiError) {
      return AppErrorModel.fromApiError(e, data: data);
    }
    return AppErrorModel(
      code: ErrorCodesEnum.inAppErrorCode,
      title: null,
      message: kDebugMode ? e.toString() : null,
      stackTrace: stackTrace,
      error: e,
      data: data,
    );
  }
  final ErrorCodesEnum code;
  final String? title;
  final String? message;
  final StackTrace? stackTrace;
  final Object? error;
  final T? data;
}
