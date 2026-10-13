import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/core/providers/theme_providers.dart';
import 'package:carenest/app/services/notificationservice/firebase_messaging_service.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'dart:io' show Platform;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/config/build_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:carenest/app/services/app_check/app_check_provider_resolver.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:app_links/app_links.dart';
import 'package:carenest/app/di/service_locator.dart';
import 'package:carenest/app/core/services/device_security.dart';
import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/features/auth/utils/deep_link_state.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/themes/app_themes.dart';
import 'package:carenest/app/features/auth/utils/deep_link_handler.dart';
import 'package:carenest/app/shared/constants/values/strings/app_strings.dart';
import 'package:carenest/app/shared/widgets/notification_handler_widget.dart';
import 'package:carenest/config/environment.dart';

// Views


// ... rest of imports

import 'package:carenest/generated/l10n/app_localizations.dart';
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

  // Set the app flavor to development
  AppConfig.appFlavor = Flavor.development;
  await SharedPreferencesUtils().init();
  final resolvedBaseUrl = AppConfig.assertBaseUrlConfigured();

  debugPrint('=== Environment Configuration (Development) ===');
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
  await _initializeAppCheck();
  await _initializeDeepLinks();
  await _initializeTimerService();
  setupLogger();
  runApp(const ProviderScope(child: MyApp()));
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _processPendingInitialDeepLink();
    // Root/jailbreak warning (warn-only, no-ops on healthy devices).
    DeviceSecurity.runStartupCheck();
  });
}

// _requestPermissions removed

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
  } catch (e) {
    // The native iOS SDK auto-initializes Firebase via GoogleService-Info.plist before
    // Dart runs, so calling initializeApp() again throws a PlatformException (not a
    // FirebaseException) with the code 'duplicate-app'. We check the message string
    // because the exception type varies across firebase_core versions.
    if (e.toString().contains('duplicate-app')) {
      debugPrint(
        'ℹ️ Firebase already initialized (native), reusing existing app.',
      );
    } else {
      debugPrint('❌ Firebase initialization failed: $e');
      debugPrint('=== END FIREBASE INITIALIZATION (WITH ERROR) ===\n');
      rethrow;
    }
  }

  // FCM token & permissions — these run regardless of whether initializeApp was called now or previously.
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

Future<void> _initializeAppCheck() async {
  debugPrint('\n=== APP CHECK INITIALIZATION STARTED ===');
  debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');
  debugPrint('Environment: ${AppConfig.flavorName}');

  if (!kIsWeb && Platform.isIOS) {
    debugPrint('⚠️ Running on iOS - App Check handled natively (App Attest)');
    debugPrint('=== END APP CHECK INITIALIZATION ===\n');
    return;
  }

  try {
    // Development entry point always uses Debug provider for Android/Apple
    await AppCheckProviderResolver.seedFixedDebugToken();

    await FirebaseAppCheck.instance.activate(
      providerWeb: ReCaptchaV3Provider(BuildConfig.recaptchaSiteKey),
      providerAndroid: const AndroidDebugProvider(),
      providerApple: const AppleDebugProvider(),
    );

    debugPrint('✅ App Check activated successfully');
    debugPrint('Android Provider: Debug');
    debugPrint('Apple Provider: Debug');

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
      debugPrint(
        '   → Register debug secret printed earlier by DebugAppCheckProvider in Firebase Console',
      );
    } catch (e) {
      debugPrint('❌ Error getting App Check token: $e');
    }

    debugPrint('=== END APP CHECK INITIALIZATION ===\n');
  } catch (e) {
    debugPrint('❌ App Check initialization failed: $e');
    debugPrint('=== END APP CHECK INITIALIZATION (WITH ERROR) ===\n');
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
