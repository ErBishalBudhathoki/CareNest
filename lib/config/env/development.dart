import 'package:flutter_dotenv/flutter_dotenv.dart';

class Development {
  static String get baseUrl {
    return _readRequiredDotEnv('DEVELOPMENT_URL');
  }

  static const bool enableLogging = true;

  static String _readRequiredDotEnv(String key) {
    if (!dotenv.isInitialized) {
      throw StateError(
        '.env is not initialized. Call dotenv.load(fileName: ".env") before reading $key.',
      );
    }

    final value = dotenv.env[key];
    if (value == null) {
      throw StateError('Missing required key "$key" in .env.');
    }

    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      throw StateError('Key "$key" in .env is empty.');
    }

    return trimmed;
  }
}
