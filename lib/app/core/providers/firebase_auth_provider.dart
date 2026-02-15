import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/services/firebase_auth_service.dart';

/// Provider for Firebase Auth Service
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

/// Provider for current Firebase user
final firebaseUserProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return authService.authStateChanges;
});

/// Provider for Firebase ID token
final firebaseIdTokenProvider = FutureProvider<String?>((ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return await authService.getIdToken();
});

/// Provider for App Check token
final appCheckTokenProvider = FutureProvider<String?>((ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return await authService.getAppCheckToken();
});

/// Provider to check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final userAsync = ref.watch(firebaseUserProvider);
  return userAsync.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});
