import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/main.dart' as main;

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final SessionTimeoutService _sessionTimeoutService = SessionTimeoutService();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));

    await Future.delayed(const Duration(milliseconds: 500));

    if (!main.isDeepLinkHandled() && mounted) {
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();

      final userEmail = await sharedPrefs.getUserEmailFromSharedPreferences();
      final role = sharedPrefs.getRole();

      if (userEmail != null && userEmail.isNotEmpty && role != null) {
        final isValidSession = await _validateAuthSession();

        if (!isValidSession) {
          debugPrint('⚠️ Auth session invalid/expired, redirecting to login');
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
          return;
        }

        if (!mounted) return;

        if (role == UserRole.admin) {
          Navigator.of(context).pushReplacementNamed(
            Routes.bottomNavBar,
            arguments: {
              'email': userEmail,
              'role': UserRole.admin,
              'organizationId': sharedPrefs.getOrganizationId(),
              'organizationName': sharedPrefs.getString('organizationName'),
              'organizationCode': sharedPrefs.getOrganizationCode(),
            },
          );
        } else if (role == UserRole.client) {
          final clientId = sharedPrefs.getString('clientId') ?? '';
          if (clientId.isEmpty) {
            debugPrint(
                '⚠️ Missing clientId for client session, forcing re-login');
            await _sessionTimeoutService.logoutAndClearSession(
              reason: 'missing_client_id_on_splash',
            );
            if (!mounted) return;
            Navigator.of(context).pushReplacementNamed(Routes.login);
            return;
          }

          Navigator.of(context).pushReplacementNamed(
            Routes.clientDashboard,
            arguments: {'email': userEmail, 'clientId': clientId},
          );
        } else {
          Navigator.of(context).pushReplacementNamed(
            Routes.bottomNavBar,
            arguments: {
              'email': userEmail,
              'role': UserRole.normal,
              'organizationId': sharedPrefs.getOrganizationId(),
              'organizationName': sharedPrefs.getString('organizationName'),
              'organizationCode': sharedPrefs.getOrganizationCode(),
            },
          );
        }
      } else {
        await _sessionTimeoutService.logoutAndClearSession(
          reason: 'missing_local_session_state_on_splash',
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  Future<bool> _validateAuthSession() async {
    final isValid = await _sessionTimeoutService.isSessionValid();
    if (!isValid) {
      await _sessionTimeoutService.logoutAndClearSession(
        reason: 'startup_session_validation_failed_or_expired',
      );
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          'assets/images/splash_screen.gif',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
