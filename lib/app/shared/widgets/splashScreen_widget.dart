import 'dart:async';
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
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for a minimum splash duration to show your branding.
    await Future.delayed(const Duration(seconds: 2));

    // The manual call to load background notifications has been removed.
    // The NotificationNotifier now handles its own loading in its constructor,
    // which is more robust and simplifies the startup logic here.

    // Check if a deep link was handled to prevent double navigation.
    await Future.delayed(const Duration(milliseconds: 500));

    if (!main.isDeepLinkHandled() && mounted) {
      // Check if user is already logged in.
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();

      final userEmail = await sharedPrefs.getUserEmailFromSharedPreferences();

      if (userEmail != null && userEmail.isNotEmpty) {
        // User is logged in, but we need to verify they have a proper session.
        // Instead of auto-navigating to home, redirect to login for proper authentication.
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        // User not logged in, navigate to login.
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
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
