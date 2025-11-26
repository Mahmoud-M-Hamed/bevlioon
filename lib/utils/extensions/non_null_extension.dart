extension NonNullStringExtension on String? {
  String get orEmpty => this ?? '';
  String orDefault(String val) => this ?? val;
  bool get isNullOrEmpty => this == null || this == '';
  bool get isNotNullOrEmpty => this != null && this?.trim() != '';
}

extension NonNullIntExtension on int? {
  int get orZero => this ?? 0;
  int orDefault(int val) => this ?? val;
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}

extension NonNullDoubleExtension on double? {
  double get orZero => this ?? 0;
  double orDefault(double val) => this ?? val;
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}

extension NonNullBooleanExtension on bool? {
  bool get orFalse => this ?? false;
  bool get orTrue => this ?? true;
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool equals(bool value) => this == value;
}
