import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/core/providers/theme_providers.dart';
import 'package:carenest/app/services/app_check/app_check_provider_resolver.dart';
import 'package:carenest/app/services/notificationservice/firebase_messaging_service.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/firebase_options.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'dart:io' show Platform;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/config/build_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:carenest/app/services/crashlytics/crashlytics_service.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:app_links/app_links.dart';
import 'package:carenest/app/di/service_locator.dart';
import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/features/auth/utils/deep_link_state.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/themes/app_themes.dart';
import 'package:carenest/app/features/auth/utils/deep_link_handler.dart';
import 'package:carenest/app/shared/constants/values/strings/app_strings.dart';
import 'package:carenest/app/shared/widgets/notification_handler_widget.dart';
import 'package:carenest/app/core/services/offline/worked_time_queue_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

// Views

// ... existing imports

// Note: navigation.dart is exported or imported via other files, ensuring we use the same key?
// No, DeepLinkHandler imports it. main.dart imports DeepLinkHandler.
// But we need to IMPORT it explicitly here to use it in MaterialApp.

final mediaStorePlugin = MediaStore();
bool _deepLinkHandled = false;
Uri? _pendingInitialDeepLink;
String? _lastHandledDeepLink;
DateTime? _lastHandledDeepLinkAt;

bool isDeepLinkHandled() {
  return _deepLinkHandled;
}

// Background handler is now defined in firebase_messaging_service.dart
// This import will be used to register the handler

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  await SharedPreferencesUtils().init();

  const flutterFlavor = String.fromEnvironment('FLUTTER_APP_FLAVOR');
  if (flutterFlavor == 'development') {
    AppConfig.appFlavor = Flavor.development;
  } else if (flutterFlavor == 'production') {
    AppConfig.appFlavor = Flavor.production;
  } else {
    // Fallback for older builds: infer flavor from package name.
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final packageName = packageInfo.packageName;
      AppConfig.appFlavor = packageName.endsWith('.dev')
          ? Flavor.development
          : Flavor.production;
    } catch (e) {
      debugPrint('Error getting package info: $e');
      AppConfig.appFlavor = Flavor.development;
    }
  }

  final resolvedBaseUrl = AppConfig.assertBaseUrlConfigured();

  debugPrint('=== Environment Configuration (Auto-Detected) ===');
  debugPrint('App Flavor: ${AppConfig.flavorName}');
  debugPrint('Base URL: $resolvedBaseUrl');
  debugPrint('Logging Enabled: ${AppConfig.enableLogging}');
  debugPrint('=========================================');

  setupLocator();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Register the background message handler BEFORE Firebase initialization
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // await _requestPermissions();
  await _initializeFirebase();
  await CrashlyticsService.instance.initialize();
  await _initializeAppCheck();
  await _initializeDeepLinks();
  await _initializeTimerService();
  setupLogger();
  runApp(const ProviderScope(child: MyApp()));
  _startWorkedTimeQueue();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _processPendingInitialDeepLink();
  });
}

/// Replay end-of-shift worked-time saves captured while the device was offline,
/// and retry whenever connectivity returns.
void _startWorkedTimeQueue() {
  final api = ApiMethod();
  WorkedTimeQueueService.instance.flush(api);
  Connectivity().onConnectivityChanged.listen((results) {
    if (results.any((result) => result != ConnectivityResult.none)) {
      WorkedTimeQueueService.instance.flush(api);
    }
  });
}

// _requestPermissions removed - handled in app flow

Future<void> _initializeFirebase() async {
  debugPrint('\n=== FIREBASE INITIALIZATION STARTED ===');
  debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint('✅ Firebase initialized with explicit web options');
    } else {
      // On Android/iOS use native Firebase config files to avoid API-key flavor
      // mismatches from environment overrides.
      await Firebase.initializeApp();
      debugPrint('✅ Firebase initialized from native config');
    }
    debugPrint('✅ Firebase Core initialized successfully');
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      // Firebase was already initialized natively (e.g., GoogleService-Info.plist on iOS).
      // Safe to ignore — the existing [DEFAULT] app will be used.
      debugPrint(
        'ℹ️ Firebase already initialized (native), reusing existing app.',
      );
    } else {
      debugPrint('❌ Firebase initialization failed: $e');
      debugPrint('=== END FIREBASE INITIALIZATION (WITH ERROR) ===\n');
      rethrow;
    }
  } catch (e) {
    debugPrint('❌ Firebase initialization failed: $e');
    debugPrint('=== END FIREBASE INITIALIZATION (WITH ERROR) ===\n');
    rethrow;
  }

  // FCM token & permissions — run regardless of how Firebase was initialized.
  try {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      debugPrint(
        '✅ FCM Token available at startup: ${token.substring(0, 20)}...',
      );
    } else {
      debugPrint('❌ No FCM Token available at startup');
    }
  } catch (e) {
    debugPrint('❌ Error getting initial FCM token: $e');
  }

  try {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    debugPrint('\n--- NOTIFICATION PERMISSIONS STATUS ---');
    debugPrint('Authorization Status: ${settings.authorizationStatus}');
    debugPrint('Alert Setting: ${settings.alert}');
    debugPrint('Badge Setting: ${settings.badge}');
    debugPrint('Sound Setting: ${settings.sound}');
    debugPrint('Announcement Setting: ${settings.announcement}');
    debugPrint('Car Play Setting: ${settings.carPlay}');
    debugPrint('Critical Alert Setting: ${settings.criticalAlert}');
    debugPrint('Time Sensitive Setting: ${settings.timeSensitive}');
  } catch (e) {
    debugPrint('❌ Error checking notification settings: $e');
  }

  // Set up token refresh listener for debugging
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    debugPrint('\n=== FCM TOKEN REFRESHED ===');
    debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');
    debugPrint('New Token: ${newToken.substring(0, 20)}...');
    debugPrint('Full New Token: $newToken');
    debugPrint('=== END TOKEN REFRESH ===\n');
  });

  debugPrint('✅ Firebase initialization completed successfully');
  debugPrint('=== END FIREBASE INITIALIZATION ===\n');
}

Future<bool> _isIOSSimulator() async {
  if (kIsWeb) return false;
  if (!Platform.isIOS) return false;

  try {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    return !iosInfo.isPhysicalDevice;
  } catch (e) {
    debugPrint('Error checking if iOS simulator: $e');
    return false;
  }
}

Future<void> _initializeAppCheck() async {
  debugPrint('\n=== APP CHECK INITIALIZATION STARTED ===');
  debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');
  debugPrint('Environment: ${AppConfig.flavorName}');

  final isDevelopmentFlavor = AppConfig.appFlavor == Flavor.development;

  if (!kIsWeb && Platform.isIOS) {
    debugPrint('⚠️ Running on iOS - App Check handled natively (App Attest)');
    debugPrint('=== END APP CHECK INITIALIZATION ===\n');
    return;
  }

  try {
    final androidSelection =
        await AppCheckProviderResolver.resolveAndroidSelection();

    if (androidSelection.provider is AndroidDebugProvider) {
      // Pin a stable debug token so reinstalls never generate a new one.
      await AppCheckProviderResolver.seedFixedDebugToken();
    }

    await FirebaseAppCheck.instance.activate(
      providerWeb: ReCaptchaV3Provider(BuildConfig.recaptchaSiteKey),
      providerAndroid: androidSelection.provider,
      providerApple: isDevelopmentFlavor
          ? const AppleDebugProvider()
          : const AppleAppAttestProvider(),
    );

    debugPrint('✅ App Check activated successfully');
    debugPrint('Android Provider: ${androidSelection.label}');
    debugPrint('Android Provider Reason: ${androidSelection.reason}');
    debugPrint(
      'Android Installer Package: ${androidSelection.installerPackage ?? "unknown"}',
    );

    if (androidSelection.provider is AndroidDebugProvider) {
      final debugSecret = await AppCheckProviderResolver.getDebugSecret();
      debugPrint('');
      debugPrint(
        '╔════════════════════════════════════════════════════════════════════════╗',
      );
      debugPrint(
        '║             🔥 FIREBASE APP CHECK — DEBUG TOKEN INFO 🔥                ║',
      );
      debugPrint(
        '╠════════════════════════════════════════════════════════════════════════╣',
      );
      debugPrint(
        '║ Fixed debug token (already registered; stable across reinstalls):      ║',
      );
      debugPrint('║   $debugSecret');
      debugPrint(
        '║ If you ever change it, re-register at:                                 ║',
      );
      debugPrint(
        '║   Firebase Console → App Check → Apps → Android → Manage debug tokens ║',
      );
      debugPrint(
        '╚════════════════════════════════════════════════════════════════════════╝',
      );
      debugPrint('');
    }

    // Force-fetch token to verify Firebase Console registration worked.
    try {
      final token = await FirebaseAppCheck.instance.getToken(true);
      if (token != null && token.isNotEmpty) {
        debugPrint('✅ App Check token obtained successfully');
      } else {
        debugPrint('⚠️ App Check token was null or empty');
      }
    } on FirebaseException catch (e) {
      debugPrint('❌ Error getting App Check token: ${e.message}');
      if (androidSelection.provider is AndroidDebugProvider) {
        debugPrint(
          '   → Register debug secret printed earlier by DebugAppCheckProvider in Firebase Console',
        );
      }
    } catch (e) {
      debugPrint('❌ Error getting App Check token: $e');
    }

    debugPrint('=== END APP CHECK INITIALIZATION ===\n');
  } catch (e) {
    debugPrint('❌ App Check initialization failed: $e');
    debugPrint('=== END APP CHECK INITIALIZATION (WITH ERROR) ===\n');
    // Non-fatal — app continues without App Check.
    // Play Store installs use Play Integrity; sideloaded debug token must be registered.
  }
}

Future<void> _initializeDeepLinks() async {
  try {
    final appLinks = AppLinks();

    // Handle initial link when app is launched
    final initialLink = await appLinks.getInitialLink();
    if (initialLink != null) {
      debugPrint('Initial link: $initialLink');
      _pendingInitialDeepLink = initialLink;
    }

    // Listen for incoming links when app is already running
    appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint('Received link: $uri');
        _handleIncomingDeepLink(uri);
      },
      onError: (err) {
        debugPrint('Deep link error: $err');
      },
    );
  } catch (e) {
    debugPrint('Error initializing deep links: $e');
  }
}

void _processPendingInitialDeepLink() {
  if (_pendingInitialDeepLink == null) return;
  _handleIncomingDeepLink(_pendingInitialDeepLink!);
  _pendingInitialDeepLink = null;
}

void _handleIncomingDeepLink(Uri uri) {
  if (_isDuplicateDeepLink(uri)) return;

  if (!_handleDeepLink(uri)) {
    // The link was ignored, or we could not route it yet (typically the
    // navigator is not attached this early on a cold start). Do not claim
    // navigation: SplashScreen stands down as soon as DeepLinkState.handled is
    // true, and it never retries, so a false positive here leaves the user
    // stuck on the splash screen with no way forward.
    debugPrint('Deep link was not routed, leaving it to the app: $uri');
    return;
  }

  _deepLinkHandled = true;
  DeepLinkState.handled = true;
}

bool _isDuplicateDeepLink(Uri uri) {
  final now = DateTime.now();
  final asString = uri.toString();

  if (_lastHandledDeepLink == asString &&
      _lastHandledDeepLinkAt != null &&
      now.difference(_lastHandledDeepLinkAt!) < const Duration(seconds: 2)) {
    return true;
  }

  _lastHandledDeepLink = asString;
  _lastHandledDeepLinkAt = now;
  return false;
}

Future<void> _initializeTimerService() async {
  try {
    final timerService = TimerService.instance;
    await timerService.initialize();
    debugPrint('Timer service initialized successfully');
  } catch (e) {
    debugPrint('Error initializing timer service: $e');
  }
}

/// Routes a deep link. Returns true when navigation actually happened.
bool _handleDeepLink(Uri uri) {
  try {
    return DeepLinkHandler.handleDeepLink(uri.toString());
  } catch (e) {
    debugPrint('Error handling deep link: $e');
    return false;
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches are kept to trigger rebuilds; values aren't directly used here
    ref.watch(sharedPreferencesProvider);
    ref.watch(userRoleProvider);

    return NotificationHandler(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: AppStrings.appName,
        theme: ref.watch(themeProvider),
        darkTheme: AppTheme.darkTheme,
        themeMode: ref.watch(themeModeProvider),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: AppPages.buildRoutes(),
      ),
    );
  }
}
