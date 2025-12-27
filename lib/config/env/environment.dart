import 'package:carenest/config/env/development.dart';
import 'package:carenest/config/env/production.dart';

enum Flavor {
  development,
  production,
}

class AppConfig {
  static Flavor? appFlavor;

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return Development.baseUrl;
      case Flavor.production:
        return Production.baseUrl;
      default:
        return '';
    }
  }

  static bool get enableLogging {
    switch (appFlavor) {
      case Flavor.development:
        return Development.enableLogging;
      case Flavor.production:
        return Production.enableLogging;
      default:
        return false;
    }
  }

  static String get ownerEmail {
    switch (appFlavor) {
      case Flavor.development:
        return Development.ownerEmail;
      case Flavor.production:
        return Production.ownerEmail;
      default:
        return '';
    }
  }

  static String get flavorName {
    switch (appFlavor) {
      case Flavor.development:
        return 'Development';
      case Flavor.production:
        return 'Production';
      default:
        return 'Unknown';
    }
  }
}
