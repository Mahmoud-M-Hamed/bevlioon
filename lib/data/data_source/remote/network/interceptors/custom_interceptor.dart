import 'package:bevlioon/data/data_source/remote/network/error/api_error.dart';
import 'package:bevlioon/utils/logging/app_logger.dart';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.instance.logDebug(
      '📥 [RESPONSE] ${response.statusCode} ← ${response.requestOptions.uri}',
    );
    AppLogger.instance.logDebug('🔸 Headers: ${response.headers.map}');
    AppLogger.instance.logDebug('🔹 Body: ${response.data}');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final request = err.requestOptions;
    final response = err.response;

    AppLogger.instance.logError(
      '❌ [ERROR] ${response?.statusCode} ← ${request.uri}',
    );
    AppLogger.instance.logError('🔸 Method: ${request.method}');
    AppLogger.instance.logError('🔸 Headers: ${request.headers}');
    AppLogger.instance.logError('🔸 Body: ${request.data}');

    if (response != null) {
      AppLogger.instance.logError('🔹 Error Body: ${response.data}');
    }
    if (err.error is ApiError) {
      final apiError = err.error as ApiError;

      AppLogger.instance.logError(
        '🚨 ApiError → Code: ${apiError.code}, Message: ${apiError.message}',
      );

      return handler.next(err);
    }

    ApiError extractedError;

    try {
      if (response?.data is Map && response?.data != null) {
        extractedError = ApiError.fromJson(response?.data);
      } else {
        extractedError = ApiError.fromDioException(err);
      }
    } catch (_) {
      extractedError = ApiError.fromDioException(err);
    }

    AppLogger.instance.logError(
      '📛 Parsed ApiError → Code: ${extractedError.code}, Message: ${extractedError.message}',
    );

    final finalError = DioException(
      requestOptions: request,
      response: response,
      type: err.type,
      error: extractedError,
      message: err.message,
    );

    handler.next(finalError);
  }
}
