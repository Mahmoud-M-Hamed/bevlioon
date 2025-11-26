enum ErrorCodesEnum {
  unauthorized(401),
  forbidden(403),
  notFound(404),
  timeout(408),
  serverError(500),
  network(1001),
  unknown(9999),
  invalidResponseFormat(10002),
  inAppErrorCode(-1);

  /// Customs can be added here
  const ErrorCodesEnum(this.code);
  final int code;

  static ErrorCodesEnum fromCode(int? code) {
    return ErrorCodesEnum.values.firstWhere(
      (e) => e.code == code,
      orElse: () => ErrorCodesEnum.unknown,
    );
  }
}
