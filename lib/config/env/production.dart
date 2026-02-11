import 'package:flutter_dotenv/flutter_dotenv.dart';

class Production {
  static String get baseUrl =>
      dotenv.env['PRODUCTION_URL'] ??
      const String.fromEnvironment(
        'PRODUCTION_URL',
        defaultValue: 'https://api.example.com/',
      );
  static const bool enableLogging = false;
}
