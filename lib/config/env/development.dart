import 'package:carenest/config/build_config.dart';

class Development {
  static String get baseUrl {
    return BuildConfig.developmentBaseUrl;
  }

  static const bool enableLogging = true;
}
