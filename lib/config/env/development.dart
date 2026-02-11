import 'package:flutter_dotenv/flutter_dotenv.dart';

class Development {
  static String get baseUrl =>
      dotenv.env['DEVELOPMENT_URL'] ??
      const String.fromEnvironment(
        'DEVELOPMENT_URL',
        defaultValue: 'http://localhost:3000/',
      );
  static const bool enableLogging = true;
}
