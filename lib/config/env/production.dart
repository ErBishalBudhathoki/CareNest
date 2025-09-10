import 'package:flutter_dotenv/flutter_dotenv.dart';

class Production {
  static String get baseUrl => dotenv.env['RELEASE_URL']!;
  static const bool enableLogging = false;
  static String get ownerEmail => dotenv.env['OWNER_EMAIL'] ?? '';
}
