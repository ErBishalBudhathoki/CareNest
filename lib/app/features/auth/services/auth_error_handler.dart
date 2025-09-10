import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/widgets/enhanced_auth_dialog.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:io';
import 'dart:async';

/// Comprehensive error handling service for authentication
/// Handles all possible edge cases with user-friendly feedback
class AuthErrorHandler {
  static const int _maxRetryAttempts = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  /// Handle authentication errors with appropriate user feedback
  static Future<void> handleAuthError({
    required BuildContext context,
    required dynamic error,
    String? userEmail,
    VoidCallback? onRetry,
    VoidCallback? onCreateAccount,
    VoidCallback? onForgotPassword,
  }) async {
    String errorMessage = '';
    String? errorCode;
    int? statusCode;

    // Handle both string and Map responses
    if (error is Map<String, dynamic>) {
      errorMessage = error['message'] ?? 'An error occurred';
      errorCode = error['errorCode'];
      statusCode = error['statusCode'];
    } else if (error is String) {
      errorMessage = error;
    } else {
      errorMessage = error.toString();
    }

    final errorType = _categorizeError(errorMessage, errorCode, statusCode);

    switch (errorType) {
      case AuthErrorType.incorrectPassword:
        await _showIncorrectPasswordDialog(
            context, userEmail, onForgotPassword);
        break;
      case AuthErrorType.userNotFound:
        await _showUserNotFoundDialog(context, userEmail, onCreateAccount);
        break;
      case AuthErrorType.networkError:
        await _showNetworkErrorDialog(context, onRetry);
        break;
      case AuthErrorType.serverError:
        await _showServerErrorDialog(context, onRetry);
        break;
      case AuthErrorType.accountLocked:
        await _showAccountLockedDialog(context, userEmail);
        break;
      case AuthErrorType.sessionTimeout:
        await _showSessionTimeoutDialog(context, onRetry);
        break;
      case AuthErrorType.invalidInput:
        await _showInvalidInputDialog(context, errorMessage);
        break;
      case AuthErrorType.tooManyAttempts:
        await _showTooManyAttemptsDialog(context);
        break;
      case AuthErrorType.emailNotVerified:
        await _showEmailNotVerifiedDialog(context, userEmail);
        break;
      case AuthErrorType.accountDisabled:
        await _showAccountDisabledDialog(context);
        break;
      case AuthErrorType.weakPassword:
        await _showWeakPasswordDialog(context);
        break;
      case AuthErrorType.emailAlreadyInUse:
        await _showEmailAlreadyInUseDialog(context, userEmail);
        break;
      case AuthErrorType.unknown:
      default:
        await _showGenericErrorDialog(context, errorMessage, onRetry);
        break;
    }
  }

  /// Categorize error based on error message, error code, and status code
  static AuthErrorType _categorizeError(String errorMessage,
      [String? errorCode, int? statusCode]) {
    // First check status code for HTTP-specific errors
    if (statusCode != null) {
      switch (statusCode) {
        case 401:
          return AuthErrorType.incorrectPassword;
        case 404:
          return AuthErrorType.userNotFound;
        case 423:
          return AuthErrorType.accountLocked;
        case 429:
          return AuthErrorType.tooManyAttempts;
        case 500:
        case 502:
        case 503:
          return AuthErrorType.serverError;
      }
    }

    // Then check error code for specific identification
    if (errorCode != null) {
      switch (errorCode.toUpperCase()) {
        case 'USER_NOT_FOUND':
          return AuthErrorType.userNotFound;
        case 'INCORRECT_PASSWORD':
          return AuthErrorType.incorrectPassword;
        case 'ACCOUNT_LOCKED':
          return AuthErrorType.accountLocked;
        case 'ACCOUNT_DISABLED':
          return AuthErrorType.accountDisabled;
        case 'TOO_MANY_ATTEMPTS':
        case 'RATE_LIMIT_EXCEEDED':
          return AuthErrorType.tooManyAttempts;
        case 'EMAIL_NOT_VERIFIED':
          return AuthErrorType.emailNotVerified;
        case 'WEAK_PASSWORD':
          return AuthErrorType.weakPassword;
        case 'EMAIL_ALREADY_IN_USE':
          return AuthErrorType.emailAlreadyInUse;
        case 'NETWORK_ERROR':
          return AuthErrorType.networkError;
        case 'SERVER_ERROR':
          return AuthErrorType.serverError;
        case 'SESSION_TIMEOUT':
          return AuthErrorType.sessionTimeout;
        case 'INVALID_INPUT':
          return AuthErrorType.invalidInput;
      }
    }

    // Fallback to message-based categorization
    final lowerMessage = errorMessage.toLowerCase();

    // Network-related errors
    if (lowerMessage.contains('network') ||
        lowerMessage.contains('connection') ||
        lowerMessage.contains('timeout') ||
        lowerMessage.contains('unreachable')) {
      return AuthErrorType.networkError;
    }

    // Server errors
    if (lowerMessage.contains('server') ||
        lowerMessage.contains('500') ||
        lowerMessage.contains('503') ||
        lowerMessage.contains('502') ||
        lowerMessage.contains('internal')) {
      return AuthErrorType.serverError;
    }

    // Authentication specific errors
    if (lowerMessage.contains('wrong-password') ||
        lowerMessage.contains('incorrect password') ||
        lowerMessage.contains('invalid-credential')) {
      return AuthErrorType.incorrectPassword;
    }

    if (lowerMessage.contains('user-not-found') ||
        lowerMessage.contains('account not found') ||
        lowerMessage.contains('no user record')) {
      return AuthErrorType.userNotFound;
    }

    if (lowerMessage.contains('too-many-requests') ||
        lowerMessage.contains('too many attempts') ||
        lowerMessage.contains('rate limit')) {
      return AuthErrorType.tooManyAttempts;
    }

    if (lowerMessage.contains('user-disabled') ||
        lowerMessage.contains('account disabled') ||
        lowerMessage.contains('account locked')) {
      return AuthErrorType.accountLocked;
    }

    if (lowerMessage.contains('email-not-verified') ||
        lowerMessage.contains('email not verified')) {
      return AuthErrorType.emailNotVerified;
    }

    if (lowerMessage.contains('weak-password') ||
        lowerMessage.contains('password too weak')) {
      return AuthErrorType.weakPassword;
    }

    if (lowerMessage.contains('email-already-in-use') ||
        lowerMessage.contains('email already exists')) {
      return AuthErrorType.emailAlreadyInUse;
    }

    if (lowerMessage.contains('session') ||
        lowerMessage.contains('token expired') ||
        lowerMessage.contains('unauthorized')) {
      return AuthErrorType.sessionTimeout;
    }

    if (lowerMessage.contains('invalid') ||
        lowerMessage.contains('malformed') ||
        lowerMessage.contains('format')) {
      return AuthErrorType.invalidInput;
    }

    return AuthErrorType.unknown;
  }

  /// Show incorrect password dialog
  static Future<void> _showIncorrectPasswordDialog(
    BuildContext context,
    String? email,
    VoidCallback? onForgotPassword,
  ) async {
    await EnhancedAuthDialog.showIncorrectPasswordDialog(context);
  }

  /// Show user not found dialog
  static Future<void> _showUserNotFoundDialog(
    BuildContext context,
    String? email,
    VoidCallback? onCreateAccount,
  ) async {
    await EnhancedAuthDialog.showAccountNotFoundDialog(context);
  }

  /// Show network error dialog
  static Future<void> _showNetworkErrorDialog(
    BuildContext context,
    VoidCallback? onRetry,
  ) async {
    await EnhancedAuthDialog.showNetworkErrorDialog(context);
  }

  /// Show server error dialog
  static Future<void> _showServerErrorDialog(
    BuildContext context,
    VoidCallback? onRetry,
  ) async {
    await EnhancedAuthDialog.showServerErrorDialog(context);
  }

  /// Show account locked dialog
  static Future<void> _showAccountLockedDialog(
    BuildContext context,
    String? email,
  ) async {
    await EnhancedAuthDialog.showAccountLockedDialog(
      context,
      lockoutDuration: const Duration(minutes: 15), // Default lockout time
    );
  }

  /// Show session timeout dialog
  static Future<void> _showSessionTimeoutDialog(
    BuildContext context,
    VoidCallback? onRetry,
  ) async {
    await EnhancedAuthDialog.showSessionTimeoutDialog(context);
  }

  /// Show invalid input dialog
  static Future<void> _showInvalidInputDialog(
    BuildContext context,
    String details,
  ) async {
    await EnhancedAuthDialog.showInvalidInputDialog(
      context,
      fieldName: 'Input',
      customMessage:
          'Please check your input and try again. Make sure your email and password are correctly formatted.',
    );
  }

  /// Show too many attempts dialog
  static Future<void> _showTooManyAttemptsDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.colorWarning.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.timer_1,
                    color: AppColors.colorWarning,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Too Many Attempts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'For your security, we\'ve temporarily locked your account after multiple failed attempts. Please wait 15 minutes before trying again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'I Understand',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show email not verified dialog
  static Future<void> _showEmailNotVerifiedDialog(
    BuildContext context,
    String? email,
  ) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.colorWarning.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.sms,
                    color: AppColors.colorWarning,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Email Verification Required',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  email != null
                      ? 'We sent a verification link to $email. Please check your inbox and click the link to verify your account.'
                      : 'Please verify your email address before signing in. Check your inbox for a verification link.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _resendVerificationEmail(email);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.colorPrimary,
                          side: BorderSide(color: AppColors.colorPrimary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Resend Email',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Got It',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show account disabled dialog
  static Future<void> _showAccountDisabledDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.user_remove,
                    color: AppColors.error,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Account Suspended',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your account has been temporarily suspended. This may be due to a security concern or policy violation. Our support team can help restore your access.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black54,
                          side: const BorderSide(color: Colors.black26),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Later',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _launchSupport();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Contact Support',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show weak password dialog
  static Future<void> _showWeakPasswordDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.colorWarning.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.shield_cross,
                    color: AppColors.colorWarning,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Strengthen Your Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your password needs to be stronger for better security. Please include:\n\n• At least 8 characters\n• Uppercase and lowercase letters\n• Numbers and special characters',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create Stronger Password',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show email already in use dialog
  static Future<void> _showEmailAlreadyInUseDialog(
    BuildContext context,
    String? email,
  ) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.colorInfo.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.user_tick,
                    color: AppColors.colorInfo,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Account Already Exists',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  email != null
                      ? 'An account with email "$email" already exists. Would you like to sign in instead?'
                      : 'This email address is already registered with us. Would you like to sign in instead?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.colorPrimary,
                          side: BorderSide(color: AppColors.colorPrimary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Try Different Email',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Navigate to login screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show generic error dialog
  static Future<void> _showGenericErrorDialog(
    BuildContext context,
    String errorMessage,
    VoidCallback? onRetry,
  ) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.warning_2,
                    color: AppColors.error,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Something Went Wrong',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  errorMessage.isNotEmpty
                      ? errorMessage
                      : 'An unexpected error occurred. Please try again or contact support if the problem persists.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                if (onRetry != null)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            onRetry();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.colorPrimary,
                            side: BorderSide(color: AppColors.colorPrimary),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Try Again',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _launchSupport();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.colorPrimary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Contact Support',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _launchSupport();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Contact Support',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Launch support contact
  static void _launchSupport() {
    // TODO: Implement support contact functionality
    // This could open email, phone, or in-app support
    print('Launching support contact...');
  }

  /// Resend verification email
  static void _resendVerificationEmail(String? email) {
    // TODO: Implement resend verification email functionality
    print('Resending verification email to: $email');
  }

  /// Check network connectivity
  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Retry operation with exponential backoff
  static Future<T> retryOperation<T>(
    Future<T> Function() operation, {
    int maxAttempts = _maxRetryAttempts,
    Duration delay = _retryDelay,
  }) async {
    int attempts = 0;

    while (attempts < maxAttempts) {
      try {
        return await operation();
      } catch (error) {
        attempts++;

        if (attempts >= maxAttempts) {
          rethrow;
        }

        // Exponential backoff
        await Future.delayed(delay * attempts);
      }
    }

    throw Exception('Max retry attempts exceeded');
  }

  /// Show success feedback
  static Future<void> showSuccessFeedback(
    BuildContext context, {
    String title = 'Success!',
    String message = 'Operation completed successfully.',
    VoidCallback? onContinue,
  }) async {
    await EnhancedAuthDialog.showSuccessDialog(
      context,
      title: title,
      message: message,
      onAction: onContinue,
    );
  }
}

/// Types of authentication errors
enum AuthErrorType {
  incorrectPassword,
  userNotFound,
  networkError,
  serverError,
  accountLocked,
  sessionTimeout,
  invalidInput,
  tooManyAttempts,
  emailNotVerified,
  accountDisabled,
  weakPassword,
  emailAlreadyInUse,
  unknown,
}

/// Error handling configuration
class AuthErrorConfig {
  final int maxRetryAttempts;
  final Duration retryDelay;
  final bool enableAutoRetry;
  final bool showDetailedErrors;

  const AuthErrorConfig({
    this.maxRetryAttempts = 3,
    this.retryDelay = const Duration(seconds: 2),
    this.enableAutoRetry = false,
    this.showDetailedErrors = false,
  });
}
