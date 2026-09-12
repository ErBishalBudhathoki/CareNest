/// Compile-time build configuration.
///
/// Values are injected at build time via `--dart-define`, so no `.env` file
/// (or the secrets in it) is ever bundled into the app binary.
///
/// IMPORTANT: `PRODUCTION_URL` and `DEVELOPMENT_URL` have NO hardcoded
/// defaults. They MUST be supplied via `--dart-define` at build time.
/// Deploy scripts (e.g. `android/deploy_internal_minor.sh`) read these
/// values directly from the project-root `.env` file.
///
/// Only non-secret, app-facing values live here. Anything secret belongs on
/// the backend only.
class BuildConfig {
  const BuildConfig._();

  /// Backend base URL used by the production flavor.
  /// Must be supplied at build time via --dart-define=PRODUCTION_URL=...
  /// (read from the project-root .env file by deploy scripts).
  static const String productionBaseUrl = String.fromEnvironment(
    'PRODUCTION_URL',
  );

  /// Backend base URL used by the development flavor.
  /// Must be supplied at build time via --dart-define=DEVELOPMENT_URL=...
  /// (read from the project-root .env file by deploy scripts).
  static const String developmentBaseUrl = String.fromEnvironment(
    'DEVELOPMENT_URL',
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

  /// Store subscription IDs are public identifiers, injected after products
  /// are created in App Store Connect and Google Play Console.
  static const String iosMonthlySubscriptionId = String.fromEnvironment(
    'IOS_MONTHLY_SUBSCRIPTION_ID',
  );
  static const String androidMonthlySubscriptionId = String.fromEnvironment(
    'ANDROID_MONTHLY_SUBSCRIPTION_ID',
  );
}
