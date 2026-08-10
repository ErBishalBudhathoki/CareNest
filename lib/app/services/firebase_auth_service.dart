import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/config/environment.dart';

/// Firebase Authentication Service
/// Handles all Firebase Auth operations and App Check token management
class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAppCheck _appCheck = FirebaseAppCheck.instance;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current user
  User? get currentUser => _auth.currentUser;

  // Check if user is signed in
  bool get isSignedIn => _auth.currentUser != null;

  /// Initialize Firebase App Check
  Future<void> initializeAppCheck() async {
    try {
      await _appCheck.activate(
        providerAndroid: kDebugMode
            ? const AndroidDebugProvider()
            : const AndroidPlayIntegrityProvider(),
        providerApple: kDebugMode
            ? const AppleDebugProvider()
            : const AppleAppAttestProvider(),
      );
      debugPrint('✅ Firebase App Check initialized');
    } catch (e) {
      debugPrint('❌ Firebase App Check initialization failed: $e');
      rethrow;
    }
  }

  /// Get App Check token for API requests
  Future<String?> getAppCheckToken({bool forceRefresh = false}) async {
    try {
      final token = await _appCheck.getToken(forceRefresh);
      return token;
    } catch (e) {
      debugPrint('❌ Failed to get App Check token: $e');
      return null;
    }
  }

  /// Get Firebase ID token for authenticated API requests
  Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        debugPrint('❌ No user signed in');
        return null;
      }
      return await user.getIdToken(forceRefresh);
    } catch (e) {
      debugPrint('❌ Failed to get ID token: $e');
      return null;
    }
  }

  /// Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('✅ Firebase user created: ${credential.user?.uid}');
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Firebase signup error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('✅ Firebase user signed in: ${credential.user?.uid}');
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Firebase login error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint('✅ Password reset email sent to: $email');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Password reset error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Validate a Firebase password reset action code.
  Future<void> verifyPasswordResetCode({required String code}) async {
    try {
      await _auth.verifyPasswordResetCode(code);
      debugPrint('✅ Password reset code verified');
    } on FirebaseAuthException catch (e) {
      debugPrint(
        '❌ Password reset code verification error: ${e.code} - ${e.message}',
      );
      throw _handleAuthException(e);
    }
  }

  /// Complete password reset using Firebase action code.
  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    try {
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
      debugPrint('✅ Password reset confirmed');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Confirm password reset error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user signed in');

      if (!user.emailVerified) {
        final projectId = Firebase.app().options.projectId;
        final isDev = AppConfig.appFlavor == Flavor.development;
        final bundleId = isDev
            ? 'com.bishal.invoice.dev'
            : 'com.bishal.invoice';

        final actionCodeSettings = ActionCodeSettings(
          url: 'https://$projectId.firebaseapp.com/email-verified',
          handleCodeInApp: false,
          iOSBundleId: bundleId,
          androidPackageName: bundleId,
          androidInstallApp: true,
          androidMinimumVersion: '1',
        );
        await user.sendEmailVerification(actionCodeSettings);
        debugPrint('✅ Verification email sent to: ${user.email}');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Email verification error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Reload current user data
  Future<void> reloadUser() async {
    try {
      await _auth.currentUser?.reload();
      debugPrint('✅ User data reloaded');
    } catch (e) {
      debugPrint('❌ Failed to reload user: $e');
    }
  }

  /// Update user display name
  Future<void> updateDisplayName(String displayName) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      await reloadUser();
      debugPrint('✅ Display name updated: $displayName');
    } catch (e) {
      debugPrint('❌ Failed to update display name: $e');
      rethrow;
    }
  }

  /// Update user email
  Future<void> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      debugPrint('✅ Email update verification sent to: $newEmail');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Email update error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Update user password
  Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      debugPrint('✅ Password updated successfully');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Password update error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Re-authenticate user (required for sensitive operations)
  Future<void> reauthenticateWithPassword(String password) async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        throw Exception('No user signed in');
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      debugPrint('✅ User re-authenticated');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Re-authentication error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint('✅ User signed out');
    } catch (e) {
      debugPrint('❌ Sign out error: $e');
      rethrow;
    }
  }

  /// Delete user account
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
      debugPrint('✅ User account deleted');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Account deletion error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    }
  }

  /// Handle Firebase Auth exceptions and convert to user-friendly messages
  Exception _handleAuthException(FirebaseAuthException e) {
    final rawMessage = e.message ?? '';
    final lowerMessage = rawMessage.toLowerCase();
    String message;

    if (lowerMessage.contains(
          'requests from this android client application',
        ) &&
        lowerMessage.contains('are blocked')) {
      message =
          'This app build is blocked by Firebase/Google Cloud security settings. '
          'Ensure the signing SHA fingerprint for this build is added to '
          'the API key restrictions in Google Cloud Console, and the app '
          'is registered in Firebase App Check.';
      return Exception(message);
    }

    switch (e.code) {
      case 'weak-password':
        message = 'The password is too weak. Please use a stronger password.';
        break;
      case 'email-already-in-use':
        message = 'An account already exists with this email address.';
        break;
      case 'invalid-email':
        message = 'The email address is invalid.';
        break;
      case 'user-not-found':
        message = 'No account found with this email address.';
        break;
      case 'wrong-password':
        message = 'Incorrect password. Please try again.';
        break;
      case 'user-disabled':
        message = 'This account has been disabled. Please contact support.';
        break;
      case 'too-many-requests':
        message = 'Too many failed attempts. Please try again later.';
        break;
      case 'operation-not-allowed':
        message = 'This operation is not allowed. Please contact support.';
        break;
      case 'requires-recent-login':
        message = 'Please sign in again to complete this action.';
        break;
      case 'network-request-failed':
        message = 'Network error. Please check your internet connection.';
        break;
      case 'invalid-credential':
        message = 'Invalid credentials. Please check your email and password.';
        break;
      case 'invalid-action-code':
        message = 'This reset link is invalid or has already been used.';
        break;
      case 'expired-action-code':
        message = 'This reset link has expired. Please request a new one.';
        break;
      default:
        message = rawMessage.isNotEmpty
            ? rawMessage
            : 'Authentication failed. Please try again.';
    }

    return Exception(message);
  }
}
