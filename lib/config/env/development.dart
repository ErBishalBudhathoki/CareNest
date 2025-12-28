import 'package:flutter_dotenv/flutter_dotenv.dart';

class Development {
  static String get baseUrl => dotenv.env['DEBUG_URL']!;
  static const bool enableLogging = true;
}
