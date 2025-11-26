import 'package:equatable/equatable.dart';

class Endpoint extends Equatable {
  const Endpoint({required this.path, this.query, this.headers, this.data});
  final String path;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? data;
  @override
  List<Object?> get props => [path, query, headers, data];
}
