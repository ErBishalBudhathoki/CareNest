import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/business/views/add_business_details_view.dart';
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
import 'package:carenest/app/di/service_locator.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/themes/app_themes.dart';
import 'package:carenest/app/features/auth/utils/deep_link_handler.dart';
import 'package:carenest/app/shared/constants/values/strings/app_strings.dart';
import 'package:carenest/app/shared/widgets/notification_handler_widget.dart';

// Views
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/features/auth/views/signup_view.dart';
import 'package:carenest/app/features/auth/views/forgot_password_view.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/home/views/home_view.dart';
import 'package:carenest/app/features/client/views/add_client_details_view.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/notes/views/add_notes_view.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/assignment_list/views/assignment_list_view.dart';
import 'package:carenest/app/features/invoice/views/enhanced_invoice_generation_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_list_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_detail_view.dart';


final mediaStorePlugin = MediaStore();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
bool _deepLinkHandled = false;

bool isDeepLinkHandled() {
  return _deepLinkHandled;
}

// Background handler is now defined in firebase_messaging_service.dart
// This import will be used to register the handler

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

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

    // Note: FirebaseMessagingService initialization removed to avoid conflicts
    // NotificationHandler widget will handle all foreground notification setup

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

Future<void> _initializeAppCheck() async {
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
}

Future<void> _initializeDeepLinks() async {
  try {
    final appLinks = AppLinks();

    // Handle initial link when app is launched
    final initialLink = await appLinks.getInitialLink();
    if (initialLink != null) {
      debugPrint('Initial link: $initialLink');
      // Don't handle immediately, wait for app to be ready
    }

    // Listen for incoming links when app is already running
    appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint('Received link: $uri');
        if (!_deepLinkHandled) {
          _handleDeepLink(uri);
          _deepLinkHandled = true;
        }
      },
      onError: (err) {
        debugPrint('Deep link error: $err');
      },
    );
  } catch (e) {
    debugPrint('Error initializing deep links: $e');
  }
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
          Routes.addBusinessDetails: (context) => const AddBusinessDetails(),
          Routes.assignC2E: (context) => const AssignC2E(),
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
            return BottomNavBarWidget(
              key: ValueKey('bottom_nav_${email}_${role.toString()}'),
              email: email,
              role: role,
              organizationId: organizationId,
              organizationName: organizationName,
              organizationCode: organizationCode,
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
          '/shiftDetails': (context) {
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
            return AutomaticInvoiceGenerationView(
              organizationId: organizationId,
              organizationName: organizationName,
              email: email,
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
            return InvoiceDetailView(
              invoiceId: invoiceId,
              organizationId: organizationId,
            );
          },
        },
      ),
    );
  }
}
