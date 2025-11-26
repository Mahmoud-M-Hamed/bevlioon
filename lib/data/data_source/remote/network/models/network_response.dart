import 'package:equatable/equatable.dart';

class NetworkResponse<T> extends Equatable {
  const NetworkResponse({
    required this.isSuccess,
    required this.data,
    this.raw,
    this.httpStatusCode,
    this.message,
  });

  final bool isSuccess;
  final dynamic raw;
  final T? data;
  final int? httpStatusCode;
  final String? message;

  @override
  List<Object?> get props => [isSuccess, raw, httpStatusCode, data, message];
}
