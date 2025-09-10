import 'package:carenest/config/env/development.dart';
import 'package:carenest/config/env/production.dart';

enum Flavor {
  development,
  production,
}

class AppConfig {
  static Flavor appFlavor = Flavor.development;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return Development.baseUrl;
      case Flavor.production:
        return Production.baseUrl;
      default:
        return Development.baseUrl;
    }
  }

  static bool get enableLogging {
    switch (appFlavor) {
      case Flavor.development:
        return Development.enableLogging;
      case Flavor.production:
        return Production.enableLogging;
      default:
        return Development.enableLogging;
    }
  }

  static String get flavorName {
    switch (appFlavor) {
      case Flavor.development:
        return 'development';
      case Flavor.production:
        return 'production';
      default:
        return 'development';
    }
  }

  static String get ownerEmail {
    switch (appFlavor) {
      case Flavor.development:
        return Development.ownerEmail;
      case Flavor.production:
        return Production.ownerEmail;
      default:
        return Development.ownerEmail;
    }
  }
}
