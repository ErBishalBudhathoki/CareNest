import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/core/providers/theme_providers.dart';
import 'package:carenest/app/features/business/views/add_business_details_view.dart';
import 'package:carenest/app/features/business/views/business_list_view.dart';
import 'package:carenest/app/features/invoice/views/employee_selection_view.dart';
import 'package:carenest/app/features/invoice/views/automatic_invoice_generation_view.dart';
import 'package:carenest/app/services/notificationservice/firebase_messaging_service.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/features/Appointment/widgets/shift_details_widget.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/app/shared/widgets/bottom_nav_bar_widget.dart';
import 'package:carenest/app/shared/widgets/nav_bar_widget.dart';
import 'package:carenest/app/shared/widgets/splash_screen_widget.dart';
import 'package:carenest/firebase_options.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:carenest/app/services/crashlytics/crashlytics_service.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:app_links/app_links.dart';
import 'package:carenest/app/di/service_locator.dart';
import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/themes/app_themes.dart';
import 'package:carenest/app/features/auth/utils/deep_link_handler.dart';
import 'package:carenest/app/shared/constants/values/strings/app_strings.dart';
import 'package:carenest/app/shared/widgets/notification_handler_widget.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

// Views
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/features/auth/views/signup_view.dart';
import 'package:carenest/app/features/auth/views/forgot_password_view.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/admin/views/employee_invoice_generation_view.dart';

import 'package:carenest/app/features/admin/views/bank_details_view.dart';
import 'package:carenest/app/features/home/views/home_view.dart';
import 'package:carenest/app/features/client/views/add_client_details_view.dart';
import 'package:carenest/app/features/client/views/client_list_view.dart';
import 'package:carenest/app/features/client_portal/views/client_dashboard_view.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/notes/views/add_notes_view.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/assignment_list/views/assignment_list_view.dart';
import 'package:carenest/app/features/invoice/views/enhanced_invoice_generation_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_list_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_detail_view.dart';
import 'package:carenest/app/features/requests/views/admin_requests_dashboard_view.dart';
import 'package:carenest/app/features/onboarding/views/onboarding_welcome_view.dart';

// Note: navigation.dart is exported or imported via other files, ensuring we use the same key?
import 'package:carenest/app/features/mileage/views/mileage_tracker_view.dart';
import 'package:carenest/app/features/care_intelligence/views/care_intelligence_dashboard.dart';
import 'package:carenest/app/features/care_intelligence/views/risk_assessment_view.dart';
import 'package:carenest/app/features/care_intelligence/views/care_plan_builder_view.dart';
import 'package:carenest/app/features/care_intelligence/views/incident_management_view.dart';
import 'package:carenest/app/features/care_intelligence/views/medication_management_view.dart';
import 'package:carenest/app/features/care_intelligence/views/behavior_support_view.dart';
import 'package:carenest/app/features/care_intelligence/views/health_monitoring_view.dart';
import 'package:carenest/app/features/care_intelligence/views/outcome_tracking_view.dart';
import 'package:carenest/app/features/worker/views/worker_dashboard_view.dart';
import 'package:carenest/app/features/worker/views/worker_shift_history_view.dart';
import 'package:carenest/app/features/teams/views/team_dashboard_view.dart';
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

Future<void> _loadEnvironmentConfig() async {
  await dotenv.load(fileName: ".env");
}

String _envValue(String key, {String fallback = ''}) {
  if (!dotenv.isInitialized) return fallback;
  final value = dotenv.env[key];
  if (value == null || value.trim().isEmpty) return fallback;
  return value;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadEnvironmentConfig();

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
      AppConfig.appFlavor =
          packageName.endsWith('.dev') ? Flavor.development : Flavor.production;
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
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
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
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _processPendingInitialDeepLink();
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
          'ℹ️ Firebase already initialized (native), reusing existing app.');
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
          '✅ FCM Token available at startup: ${token.substring(0, 20)}...');
      debugPrint('Full FCM Token: $token');
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
    debugPrint('⚠️ Running on iOS - Skipping App Check initialization');
    debugPrint(
        'Note: App Check requires physical iOS device and Apple Developer account');
    debugPrint(
        'Recommendation: Disable APP_CHECK_ENFORCEMENT in backend for iOS requests');
    debugPrint('=== END APP CHECK INITIALIZATION (SKIPPED FOR IOS) ===\n');
    return;
  }

  try {
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider(_envValue('RECAPTCHA_SITE_KEY')),
      androidProvider: isDevelopmentFlavor
          ? AndroidProvider.debug
          : AndroidProvider.playIntegrity,
      appleProvider:
          isDevelopmentFlavor ? AppleProvider.debug : AppleProvider.appAttest,
    );

    debugPrint('✅ App Check activated successfully');
    debugPrint(
        'Android Provider: ${isDevelopmentFlavor ? "Debug" : "Play Integrity"}');
    debugPrint('iOS Provider: ${isDevelopmentFlavor ? "Debug" : "App Attest"}');

    // Test App Check token generation
    try {
      final token = await FirebaseAppCheck.instance.getToken();
      if (token != null) {
        debugPrint('✅ App Check token generated successfully');
        debugPrint('Token preview: ${token.substring(0, 20)}...');
      } else {
        debugPrint('⚠️ App Check token is null');
      }
    } catch (e) {
      debugPrint('❌ Error getting App Check token: $e');
    }

    debugPrint('=== END APP CHECK INITIALIZATION ===\n');
  } catch (e) {
    debugPrint('❌ App Check initialization failed: $e');
    debugPrint('=== END APP CHECK INITIALIZATION (WITH ERROR) ===\n');
    // Don't rethrow - allow app to continue without App Check
    // Backend will handle missing App Check token based on APP_CHECK_ENFORCEMENT setting
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
  _handleDeepLink(uri);
  _deepLinkHandled = true;
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

void _handleDeepLink(Uri uri) {
  try {
    DeepLinkHandler.handleDeepLink(uri.toString());
  } catch (e) {
    debugPrint('Error handling deep link: $e');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches are kept to trigger rebuilds; values aren't directly used here
    ref.watch(sharedPreferencesProvider);
    ref.watch(userRoleProvider);

    // Watch theme mode for dynamic switching
    final themeMode = ref.watch(themeModeProvider);

    return NotificationHandler(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: AppStrings.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: {
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.admin: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?;
            final email = arguments?['email'] as String? ?? '';
            final organizationId = arguments?['organizationId'] as String?;
            final organizationName = arguments?['organizationName'] as String?;
            final organizationCode = arguments?['organizationCode'] as String?;

            // Debug prints to track organizationId flow
            debugPrint('=== ADMIN ROUTE DEBUG: email = $email ===');
            debugPrint(
                '=== ADMIN ROUTE DEBUG: organizationId = $organizationId ===');
            debugPrint(
                '=== ADMIN ROUTE DEBUG: organizationName = $organizationName ===');
            debugPrint(
                '=== ADMIN ROUTE DEBUG: organizationCode = $organizationCode ===');

            return AdminDashboardView(
              email: email,
              organizationId: organizationId,
              organizationName: organizationName,
              organizationCode: organizationCode,
            );
          },
          Routes.employeeSelection: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String email = arguments['email'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final String organizationName =
                arguments['organizationName'] as String? ?? '';
            return EmployeeSelectionView(
              email: email,
              organizationId: organizationId,
              organizationName: organizationName,
            );
          },
          Routes.login: (context) => LoginView(),
          Routes.home: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?;
            final email = arguments?['email'] as String? ?? '';
            return HomeView(email: email);
          },
          Routes.signup: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?;

            final prefilledOrgCode =
                arguments?['prefilledOrgCode'] as String? ?? '';

            return SignUpView(
              prefilledOrgCode: prefilledOrgCode,
            );
          },

          Routes.forgotPassword: (context) => ForgotPasswordView(),
          Routes.changePassword: (context) => const ChangePasswordView(),
          Routes.addClientDetails: (context) => const AddClientDetails(),
          Routes.clientList: (context) => const ClientListView(),
          Routes.addBusinessDetails: (context) => const AddBusinessDetails(),
          Routes.businessList: (context) => const BusinessListView(),
          '/client-portal': (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final clientId = arguments['clientId'] as String?;
            return ClientDashboardView(
              clientId:
                  (clientId != null && clientId.isNotEmpty) ? clientId : null,
            );
          },
          Routes.clientPortal: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final clientId = arguments['clientId'] as String?;
            return ClientDashboardView(
              clientId:
                  (clientId != null && clientId.isNotEmpty) ? clientId : null,
            );
          },
          Routes.clientDashboard: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final clientId = arguments['clientId'] as String?;
            return ClientDashboardView(
              clientId:
                  (clientId != null && clientId.isNotEmpty) ? clientId : null,
            );
          },
          Routes.assignC2E: (context) => const AssignC2E(),
          Routes.onboarding: (context) => const OnboardingWelcomeView(),
          Routes.navBar: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?;
            final email =
                arguments?['email'] as String? ?? 'defaultemail@default.com';
            final firstName = arguments?['firstName'] as String? ?? 'First';
            final lastName = arguments?['lastName'] as String? ?? 'Last';
            final role = arguments?['role'] as UserRole? ?? UserRole.normal;
            return NavBarWidget(
              context: context,
              email: email,
              firstName: firstName,
              lastName: lastName,
              role: role,
            );
          },
          Routes.bottomNavBar: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?;
            final email = arguments?['email'] as String? ?? '';
            final role = arguments?['role'] as UserRole? ?? UserRole.normal;
            final organizationId =
                arguments?['organizationId'] as String? ?? '';
            final organizationName =
                arguments?['organizationName'] as String? ?? '';
            final organizationCode =
                arguments?['organizationCode'] as String? ?? '';
            final initialIndex = arguments?['initialIndex'] as int?;
            return BottomNavBarWidget(
              key: ValueKey('bottom_nav_${email}_${role.toString()}'),
              email: email,
              role: role,
              organizationId: organizationId,
              organizationName: organizationName,
              organizationCode: organizationCode,
              initialIndex: initialIndex,
            );
          },
          Routes.clientAndAppointmentDetails: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?;
            final userEmail = arguments?['userEmail'] as String? ?? '';
            final clientEmail = arguments?['clientEmail'] as String? ?? '';
            return ClientAndAppointmentDetails(
              userEmail: userEmail,
              clientEmail: clientEmail,
            );
          },
          Routes.addNotes: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?;
            final userEmail = arguments?['userEmail'] as String? ?? '';
            final clientEmail = arguments?['clientEmail'] as String? ?? '';
            return AddNotesView(
              userEmail: userEmail,
              clientEmail: clientEmail,
            );
          },
          Routes.clockInAndOutView: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?;
            final userEmail = arguments?['userEmail'] as String? ?? '';
            return ClockInAndOutView(
              email: userEmail,
            );
          },
          // <<< --- THIS IS THE CORRECTED BLOCK --- >>>
          Routes.assignmentList: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String userEmail = arguments['userEmail'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            return AssignmentListView(
              userEmail: userEmail,
              organizationId: organizationId,
            );
          },
          Routes.shiftDetails: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final userEmail = arguments['userEmail'] as String? ?? '';
            final clientEmail = arguments['clientEmail'] as String? ?? '';
            final shiftData =
                arguments['shiftData'] as Map<String, dynamic>? ?? {};
            return Scaffold(
              appBar: AppBar(
                title: const Text('Shift Details'),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assignment Successful!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Employee: $userEmail',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Client: $clientEmail',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Assigned Shifts:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ShiftDetailsWidget(shiftData: shiftData),
                    ),
                  ],
                ),
              ),
            );
          },
          Routes.employeeInvoice: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String adminEmail = arguments['email'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final String? organizationName =
                arguments['organizationName'] as String?;

            return EmployeeInvoiceGenerationView(
              adminEmail: adminEmail,
              organizationId: organizationId,
              organizationName: organizationName,
            );
          },
          Routes.enhancedInvoiceGeneration: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String userEmail = arguments['userEmail'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final String organizationName =
                arguments['organizationName'] as String? ?? '';
            final List<Map<String, dynamic>>? selectedEmployeesAndClients =
                arguments['selectedEmployeesAndClients']
                    as List<Map<String, dynamic>>?;
            return EnhancedInvoiceGenerationView(
              email: userEmail,
              genKey: organizationId,
              organizationName: organizationName,
              selectedEmployeesAndClients: selectedEmployeesAndClients,
            );
          },

          Routes.automaticInvoiceGeneration: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String? organizationId =
                arguments['organizationId'] as String?;
            final String? organizationName =
                arguments['organizationName'] as String?;
            final String? email = arguments['email'] as String?;
            final bool autoMode = (arguments['autoMode'] as bool?) ?? false;
            final String? invoiceType = arguments['invoiceType'] as String?;

            return AutomaticInvoiceGenerationView(
              organizationId: organizationId,
              organizationName: organizationName,
              email: email,
              autoMode: autoMode,
              invoiceType: invoiceType,
            );
          },
          Routes.invoiceList: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final String userEmail = arguments['userEmail'] as String? ?? '';
            return InvoiceListView(
              organizationId: organizationId,
              userEmail: userEmail,
            );
          },
          Routes.invoiceDetails: (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String invoiceId = arguments['invoiceId'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final Map<String, dynamic>? invoiceData =
                arguments['invoiceData'] as Map<String, dynamic>?;
            return InvoiceDetailView(
              invoiceId: invoiceId,
              organizationId: organizationId,
              initialInvoiceData: invoiceData,
            );
          },
          Routes.bankDetails: (context) => const BankDetailsView(),
          Routes.adminRequests: (context) => const AdminRequestsDashboardView(),
          Routes.mileageTracker: (context) => const MileageTrackerView(),
          // Care Intelligence Routes
          Routes.careIntelligence: (context) =>
              const CareIntelligenceDashboard(),
          Routes.riskAssessment: (context) => const RiskAssessmentView(),
          Routes.carePlanBuilder: (context) => const CarePlanBuilderView(),
          Routes.incidentManagement: (context) =>
              const IncidentManagementView(),
          Routes.medicationManagement: (context) =>
              const MedicationManagementView(),
          Routes.behaviorSupport: (context) => const BehaviorSupportView(),
          Routes.healthMonitoring: (context) => const HealthMonitoringView(),
          Routes.outcomeTracking: (context) => const OutcomeTrackingView(),
          Routes.workerDashboard: (context) => const WorkerDashboardView(),
          Routes.workerShiftHistory: (context) => const WorkerShiftHistoryView(),
          Routes.teamDashboard: (context) => const TeamDashboardView(),
        },
      ),
    );
  }
}
