import '../base_request_model.dart';

class PaginationRequestModel implements BaseRequestModel {
  final int? paging;

  PaginationRequestModel({required this.paging});

  @override
  Map<String, dynamic> toJson() => {'page': paging};
}
