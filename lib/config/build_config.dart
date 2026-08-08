/// Compile-time build configuration.
///
/// Values are injected at build time via `--dart-define`, so no `.env` file
/// (or the secrets in it) is ever bundled into the app binary.
///
/// Only non-secret, app-facing values live here. Anything secret belongs on
/// the backend only.
class BuildConfig {
  const BuildConfig._();

  /// Backend base URL used by the production flavor.
  static const String productionBaseUrl = String.fromEnvironment(
    'PRODUCTION_URL',
    defaultValue:
        'https://backend-prod-282505998598.australia-southeast1.run.app/api/',
  );

  /// Backend base URL used by the development flavor.
  static const String developmentBaseUrl = String.fromEnvironment(
    'DEVELOPMENT_URL',
    defaultValue: 'https://backend-dev-6kwh434jbq-ts.a.run.app/api/',
  );

  /// Universal link host used for deep links.
  static const String universalLinkHost = String.fromEnvironment(
    'UNIVERSAL_LINK_HOST',
    defaultValue: 'bishalbudhathoki.com',
  );

  /// reCAPTCHA site key (web only; empty on mobile).
  static const String recaptchaSiteKey = String.fromEnvironment(
    'RECAPTCHA_SITE_KEY',
  );
}
