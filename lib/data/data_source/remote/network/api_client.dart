import 'package:bevlioon/core/error/error_codes_enum.dart';
import 'package:bevlioon/data/data_source/remote/network/enums/http_method_enum.dart';
import 'package:bevlioon/data/data_source/remote/network/error/api_error.dart';
import 'package:bevlioon/data/data_source/remote/network/models/endpoint.dart';
import 'package:bevlioon/data/data_source/remote/network/models/network_response.dart';
import 'package:bevlioon/data/data_source/remote/network/network_info/network_info.dart';
import 'package:bevlioon/utils/logging/app_logger.dart';
import 'package:dio/dio.dart';

typedef JsonMap = Map<String, dynamic>;

class ApiClient {
  const ApiClient(this._dio, {required this.networkInfo});

  final Dio _dio;
  final NetworkInfo networkInfo;

  Future<NetworkResponse<T>> get<T>(
    Endpoint endpoint, {
    T Function(JsonMap json)? onMap,
    T Function(List<JsonMap> list)? onList,
  }) {
    return _request<T>(
      path: endpoint.path,
      method: HttpMethodEnum.get,
      query: endpoint.query,
      headers: endpoint.headers,
      onMap: onMap,
      onList: onList,
    );
  }

  Future<NetworkResponse<T>> post<T>(
    Endpoint endpoint, {
    T Function(JsonMap json)? onMap,
    T Function(List<JsonMap> list)? onList,
    bool isDriverIdRequired = true,
  }) {
    AppLogger.instance.logDebug('📤 [REQUEST Body] ${endpoint.data}');

    return _request<T>(
      path: endpoint.path,
      method: HttpMethodEnum.post,
      body: endpoint.data,
      query: endpoint.query,
      headers: endpoint.headers,
      onList: onList,
      onMap: onMap,
    );
  }

  Future<NetworkResponse<T>> put<T>(
    Endpoint endpoint, {
    T Function(JsonMap json)? onMap,
    T Function(List<JsonMap> list)? onList,
  }) {
    return _request<T>(
      path: endpoint.path,
      method: HttpMethodEnum.put,
      body: endpoint.data,
      query: endpoint.query,
      headers: endpoint.headers,
      onList: onList,
      onMap: onMap,
    );
  }

  Future<NetworkResponse<T>> delete<T>(
    Endpoint endpoint, {
    T Function(JsonMap json)? onMap,
    T Function(List<JsonMap> list)? onList,
  }) {
    return _request<T>(
      path: endpoint.path,
      method: HttpMethodEnum.delete,
      body: endpoint.data,
      query: endpoint.query,
      headers: endpoint.headers,
      onList: onList,
      onMap: onMap,
    );
  }

  /// Perform a network request using [Dio].
  ///
  /// - [path]: request endpoint.
  /// - [method]: HTTP method (GET, POST, etc.).
  /// - [query]: query parameters.
  /// - [headers]: request-specific headers merged with Dio defaults.
  /// - [extras]: custom options merged with Dio defaults.
  /// - [body]: request payload (for POST/PUT/PATCH).
  ///
  /// Returns a [NetworkResponse] containing:
  /// - `httpStatusCode`
  /// - `isSuccess` flag (true if 2xx)
  /// - `raw` (raw response body)
  /// - data (T)
  /// Throws [ApiError] if:
  /// - response format is invalid,
  /// - Dio error occurs,
  /// - or any unknown exception is raised.
  Future<NetworkResponse<T>> _request<T>({
    required String path,
    required HttpMethodEnum method,
    required T? Function(JsonMap json)? onMap,
    required T? Function(List<JsonMap> list)? onList,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extras,
    Object? body,
  }) async {
    try {
      if (!(await networkInfo.hasInternet)) {
        throw ApiError(code: ErrorCodesEnum.network);
      }
      final response = await _dio.request(
        path,
        data: body,
        queryParameters: query,
        options: Options(
          method: method.value,
          headers: {
            if (_dio.options.headers.isNotEmpty) ..._dio.options.headers,
            if (headers != null) ...headers,
          },
          extra: {
            if (_dio.options.extra.isNotEmpty) ..._dio.options.extra,
            if (extras != null) ...extras,
          },
        ),
      );
      final responseStatusCode = response.statusCode ?? 0;
      final rawData = response.data;
      if (!_isCorrectResponseFormat(rawData)) {
        throw ApiError(code: ErrorCodesEnum.invalidResponseFormat);
      }

      final parsedResponse = _parse<T>(rawData, onMap: onMap, onList: onList);
      return NetworkResponse<T>(
        httpStatusCode: responseStatusCode,
        isSuccess: (responseStatusCode >= 200 && responseStatusCode < 300),
        raw: rawData,
        data: parsedResponse,
      );
    } on DioException catch (e, s) {
      final apiError = e.error is ApiError
          ? e.error as ApiError
          : ApiError.fromDioException(e, stackTrace: s);
      throw apiError;
    } catch (e, s) {
      final apiError = e is ApiError
          ? e
          : ApiError(code: ErrorCodesEnum.unknown, stackTrace: s);
      throw apiError;
    }
  }

  /// Check if [data] matches an expected API response format.
  ///
  /// Valid formats are:
  /// - `Map<String, dynamic>` (object/JSON map)
  /// - `List` (array of JSON objects)
  ///
  /// Returns `false` if [data] is `null` or of an unsupported type.
  bool _isCorrectResponseFormat(dynamic data) {
    if (data == null) return false;
    if (data is Map<String, dynamic> || data is List) return true;
    return false;
  }

  /// Parse [raw] into a strongly typed value using the provided callbacks.
  ///
  /// - If [raw] is a `Map<String, dynamic>`, [onMap] is invoked.
  /// - If [raw] is a `List`, [onList] is invoked after converting each item
  ///   to `Map<String, dynamic>`.
  ///
  /// Returns `null` if the respective callback is not provided.
  ///
  /// Throws [ApiError] if [raw] is neither a `Map` nor a `List`.

  T? _parse<T>(
    dynamic raw, {
    required T? Function(JsonMap json)? onMap,
    required T? Function(List<JsonMap> list)? onList,
  }) {
    if (raw is Map<String, dynamic>) {
      return onMap?.call(raw);
    }

    if (raw is List) {
      final list = raw
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList(growable: false);
      return onList?.call(list);
    }

    throw ApiError(code: ErrorCodesEnum.invalidResponseFormat);
  }
}
