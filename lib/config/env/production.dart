import 'package:flutter_dotenv/flutter_dotenv.dart';

class Production {
  static String get baseUrl => dotenv.env['PRODUCTION_URL']!;
  static const bool enableLogging = false;
}
