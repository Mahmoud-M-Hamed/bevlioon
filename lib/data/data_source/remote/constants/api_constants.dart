import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 35);
  static final Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${dotenv.env['ACCESS_TOKEN']}',
    'Content-Type': 'application/json',
  };
}
