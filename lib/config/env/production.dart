import 'package:carenest/config/build_config.dart';

class Production {
  static String get baseUrl {
    return BuildConfig.productionBaseUrl;
  }

  static const bool enableLogging = false;
}
