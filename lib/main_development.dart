import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/services/notificationservice/firebase_messaging_service.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:app_links/app_links.dart';

import 'package:carenest/firebase_options.dart';
import 'package:carenest/app/di/service_locator.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/themes/app_themes.dart';
import 'package:carenest/app/features/auth/utils/deep_link_handler.dart';
import 'package:carenest/app/shared/constants/values/strings/app_strings.dart';
import 'package:carenest/app/shared/widgets/splashScreen_widget.dart';
import 'package:carenest/app/shared/widgets/notification_handler_widget.dart';
import 'package:carenest/config/environment.dart';

// Views
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/features/auth/views/signup_view.dart';
import 'package:carenest/app/features/auth/views/forgot_password_view.dart';
import 'package:carenest/app/shared/widgets/bottom_navBar_widget.dart';
import 'package:carenest/app/features/invoice/views/invoice_list_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_detail_view.dart';
import 'package:carenest/app/features/admin/views/bank_details_view.dart';

final mediaStorePlugin = MediaStore();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
bool _deepLinkHandled = false;

bool isDeepLinkHandled() {
  return _deepLinkHandled;
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches are kept to trigger rebuilds; values aren't directly used here
    ref.watch(sharedPreferencesProvider);
    ref.watch(userRoleProvider);

    return NotificationHandler(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: AppStrings.appName,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: {
          '/': (context) => const SplashScreen(), // Add root route
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.login: (context) => LoginView(),
          Routes.signup: (context) => SignUpView(),
          Routes.forgotPassword: (context) => ForgotPasswordView(),
          Routes.bottomNavBar: (context) => BottomNavBarWidget(
                email: ModalRoute.of(context)?.settings.arguments is Map
                    ? (ModalRoute.of(context)?.settings.arguments
                            as Map)['email'] ??
                        ''
                    : '',
                role: ModalRoute.of(context)?.settings.arguments is Map
                    ? (ModalRoute.of(context)?.settings.arguments
                            as Map)['role'] ??
                        UserRole.normal
                    : UserRole.normal,
                organizationId:
                    ModalRoute.of(context)?.settings.arguments is Map
                        ? (ModalRoute.of(context)?.settings.arguments
                                as Map)['organizationId'] ??
                            ''
                        : '',
                organizationName:
                    ModalRoute.of(context)?.settings.arguments is Map
                        ? (ModalRoute.of(context)?.settings.arguments
                                as Map)['organizationName'] ??
                            ''
                        : '',
                organizationCode:
                    ModalRoute.of(context)?.settings.arguments is Map
                        ? (ModalRoute.of(context)?.settings.arguments
                                as Map)['organizationCode'] ??
                            ''
                        : '',
              ),
          Routes.invoiceList: (context) => InvoiceListView(
                organizationId:
                    ModalRoute.of(context)?.settings.arguments is Map
                        ? (ModalRoute.of(context)?.settings.arguments
                                as Map)['organizationId'] ??
                            ''
                        : '',
                userEmail: ModalRoute.of(context)?.settings.arguments is Map
                    ? (ModalRoute.of(context)?.settings.arguments
                            as Map)['userEmail'] ??
                        ''
                    : '',
              ),
          Routes.invoiceDetails: (context) => InvoiceDetailView(
                invoiceId: ModalRoute.of(context)?.settings.arguments is Map
                    ? (ModalRoute.of(context)?.settings.arguments
                            as Map)['invoiceId'] ??
                        ''
                    : '',
                organizationId:
                    ModalRoute.of(context)?.settings.arguments is Map
                        ? (ModalRoute.of(context)?.settings.arguments
                                as Map)['organizationId'] ??
                            ''
                        : '',
              ),
          Routes.bankDetails: (context) => const BankDetailsView(),
          // Add other routes as needed
        },
      ),
    );
  }
}

// Background handler is now defined in firebase_messaging_service.dart
// This import will be used to register the handler

Future<void> _initializeAppCheck() async {
  try {
    await FirebaseAppCheck.instance.activate(
      // Use provider appropriate for the platform
      webProvider: ReCaptchaV3Provider(dotenv.env['RECAPTCHA_SITE_KEY'] ?? ''),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest,
    );
    debugPrint('✅ Firebase App Check initialized successfully');
  } catch (e) {
    debugPrint('❌ Firebase App Check initialization failed: $e');
    rethrow;
  }
}

Future<void> _initializeDeepLinks() async {
  try {
    final appLinks = AppLinks();
    // Handle app links while the app is already started
    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        debugPrint('Received deep link: $uri');
        _handleDeepLink(uri);
        _deepLinkHandled = true;
      }
    });

    // Get the initial link if the app was launched from a link
    final initialLink = await appLinks.getInitialLink();
    if (initialLink != null) {
      debugPrint('Initial deep link: $initialLink');
      _handleDeepLink(initialLink);
      _deepLinkHandled = true;
    }

    debugPrint('✅ Deep links initialized successfully');
  } catch (e) {
    debugPrint('❌ Deep links initialization failed: $e');
  }
}

void _handleDeepLink(Uri uri) {
  try {
    DeepLinkHandler.handleDeepLink(uri.toString());
  } catch (e) {
    debugPrint('Error handling deep link: $e');
  }
}

Future<void> _initializeTimerService() async {
  try {
    final timerService = TimerService.instance;
    await timerService.initialize();
    debugPrint('✅ Timer service initialized successfully');
  } catch (e) {
    debugPrint('❌ Error initializing timer service: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Set the app flavor to development
  AppConfig.appFlavor = Flavor.development;
  debugPrint('=== Environment Configuration ===');
  debugPrint('App Flavor: ${AppConfig.flavorName}');
  debugPrint('Base URL: ${AppConfig.baseUrl}');
  debugPrint('Logging Enabled: ${AppConfig.enableLogging}');
  debugPrint('================================');

  setupLocator();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Register the background message handler BEFORE Firebase initialization
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await _requestPermissions();
  await _initializeFirebase();
  await _initializeAppCheck();
  await _initializeDeepLinks();
  await _initializeTimerService();

  // Print environment configuration after initialization
  debugPrint('\n🔥 ENVIRONMENT CONFIGURATION 🔥');
  debugPrint('----------------------------------------');
  debugPrint('🔹 App Flavor: ${AppConfig.flavorName}');
  debugPrint('🔹 Base URL: ${AppConfig.baseUrl}');
  debugPrint('🔹 Logging Enabled: ${AppConfig.enableLogging}');
  debugPrint('----------------------------------------\n');
  setupLogger();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> _requestPermissions() async {
  final notificationPermissionStatus = await Permission.notification.request();
  debugPrint('Notification permission status: $notificationPermissionStatus');

  final storagePermissionStatus = await Permission.storage.request();
  if (storagePermissionStatus.isDenied) {
    debugPrint('Storage permission is denied.');
    await [Permission.storage, Permission.manageExternalStorage].request();
  }

  MediaStore.appFolder = "MediaStorePlugin";
}

Future<void> _initializeFirebase() async {
  debugPrint('\n=== FIREBASE INITIALIZATION STARTED ===');
  debugPrint('Timestamp: ${DateTime.now().toIso8601String()}');

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✅ Firebase Core initialized successfully');

    // Get initial FCM token for logging
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        debugPrint(
            '✅ FCM Token available at startup: ${token.substring(0, 20)}...');
        debugPrint('Full FCM Token: $token');
      } else {
        debugPrint('❌ No FCM Token available at startup');
      }
    } catch (e) {
      debugPrint('❌ Error getting initial FCM token: $e');
    }

    // Check notification permissions
    try {
      final settings =
          await FirebaseMessaging.instance.getNotificationSettings();
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
  } catch (e) {
    debugPrint('❌ Firebase initialization failed: $e');
    debugPrint('=== END FIREBASE INITIALIZATION (WITH ERROR) ===\n');
    rethrow;
  }
}
