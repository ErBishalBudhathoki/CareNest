import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/widgets/enhanced_auth_dialog.dart';
import 'package:carenest/app/features/feedback/views/feedback_form_view.dart';
import 'package:carenest/backend/api_method.dart';

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
        await _showServerErrorDialog(context, onRetry, userEmail);
        break;
      case AuthErrorType.accountLocked:
        await _showAccountLockedDialog(context, userEmail, onForgotPassword);
        break;
      case AuthErrorType.sessionTimeout:
        await _showSessionTimeoutDialog(context, onRetry);
        break;
      case AuthErrorType.invalidCredentials:
        await _showInvalidCredentialsDialog(
            context, userEmail, onForgotPassword);
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
        await _showAccountDisabledDialog(context, userEmail);
        break;
      case AuthErrorType.weakPassword:
        await _showWeakPasswordDialog(context);
        break;
      case AuthErrorType.emailAlreadyInUse:
        await _showEmailAlreadyInUseDialog(context, userEmail);
        break;
      case AuthErrorType.unknown:
      default:
        await _showGenericErrorDialog(
            context, errorMessage, onRetry, userEmail);
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
        case 'INVALID_CREDENTIAL':
        case 'INVALID_CREDENTIALS':
        case 'INVALID_LOGIN_CREDENTIALS':
          return AuthErrorType.invalidCredentials;
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
        lowerMessage.contains('incorrect password')) {
      return AuthErrorType.incorrectPassword;
    }

    if (lowerMessage.contains('user-not-found') ||
        lowerMessage.contains('account not found') ||
        lowerMessage.contains('no user record') ||
        lowerMessage.contains('no account found') ||
        lowerMessage.contains('user does not exist')) {
      return AuthErrorType.userNotFound;
    }

    if (lowerMessage.contains('invalid-credential') ||
        lowerMessage.contains('invalid credential') ||
        lowerMessage.contains('invalid email or password')) {
      return AuthErrorType.invalidCredentials;
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
    await EnhancedAuthDialog.showIncorrectPasswordDialog(
      context,
      onResetPassword: onForgotPassword,
      onContactSupport: () => _launchSupport(
        context,
        userEmail: email,
        supportReason: 'I could not sign in because my password was rejected.',
      ),
    );
  }

  /// Show user not found dialog
  static Future<void> _showUserNotFoundDialog(
    BuildContext context,
    String? email,
    VoidCallback? onCreateAccount,
  ) async {
    await EnhancedAuthDialog.showAccountNotFoundDialog(
      context,
      email: email,
      onCreateAccount: onCreateAccount,
      onContactSupport: () => _launchSupport(
        context,
        userEmail: email,
        supportReason:
            'I could not sign in because my account email was not found.',
      ),
    );
  }

  /// Show network error dialog
  static Future<void> _showNetworkErrorDialog(
    BuildContext context,
    VoidCallback? onRetry,
  ) async {
    await EnhancedAuthDialog.showNetworkErrorDialog(
      context,
      onRetry: onRetry,
    );
  }

  /// Show server error dialog
  static Future<void> _showServerErrorDialog(
    BuildContext context,
    VoidCallback? onRetry,
    String? email,
  ) async {
    await EnhancedAuthDialog.showServerErrorDialog(
      context,
      onRetry: onRetry,
      onReportIssue: () => _launchSupport(
        context,
        userEmail: email,
        supportReason:
            'I could not sign in due to a server error while authenticating.',
      ),
    );
  }

  /// Show account locked dialog
  static Future<void> _showAccountLockedDialog(
    BuildContext context,
    String? email,
    VoidCallback? onResetPassword,
  ) async {
    await EnhancedAuthDialog.showAccountLockedDialog(
      context,
      lockoutDuration: const Duration(minutes: 15), // Default lockout time
      onResetPassword: onResetPassword,
    );
  }

  /// Show session timeout dialog
  static Future<void> _showSessionTimeoutDialog(
    BuildContext context,
    VoidCallback? onRetry,
  ) async {
    await EnhancedAuthDialog.showSessionTimeoutDialog(
      context,
      onLogin: onRetry,
    );
  }

  /// Show dialog when sign-in credentials are invalid but exact field is unknown
  static Future<void> _showInvalidCredentialsDialog(
    BuildContext context,
    String? email,
    VoidCallback? onForgotPassword,
  ) async {
    await EnhancedAuthDialog.showInvalidCredentialsDialog(
      context,
      onResetPassword: onForgotPassword,
      onContactSupport: () => _launchSupport(
        context,
        userEmail: email,
        supportReason:
            'I could not sign in because my credentials were rejected.',
      ),
    );
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
    await EnhancedAuthDialog.showTooManyAttemptsDialog(
      context,
      lockoutDuration: const Duration(minutes: 15),
    );
  }

  /// Show email not verified dialog
  static Future<void> _showEmailNotVerifiedDialog(
    BuildContext context,
    String? email,
  ) async {
    await EnhancedAuthDialog.showEmailNotVerifiedDialog(
      context,
      email: email,
      onResendEmail: () => _resendVerificationEmail(context, email),
      onContactSupport: () => _launchSupport(
        context,
        userEmail: email,
        supportReason:
            'I cannot sign in because my email verification is not working.',
      ),
    );
  }

  /// Show account disabled dialog
  static Future<void> _showAccountDisabledDialog(
    BuildContext context,
    String? userEmail,
  ) async {
    await EnhancedAuthDialog.showAccountDisabledDialog(
      context,
      onContactSupport: () => _launchSupport(
        context,
        userEmail: userEmail,
        supportReason:
            'My account appears to be disabled and I need support to restore access.',
      ),
    );
  }

  /// Show weak password dialog
  static Future<void> _showWeakPasswordDialog(BuildContext context) async {
    await EnhancedAuthDialog.showWeakPasswordDialog(context);
  }

  /// Show email already in use dialog
  static Future<void> _showEmailAlreadyInUseDialog(
    BuildContext context,
    String? email,
  ) async {
    await EnhancedAuthDialog.showEmailAlreadyInUseDialog(
      context,
      email: email,
    );
  }

  /// Show generic error dialog
  static Future<void> _showGenericErrorDialog(
    BuildContext context,
    String errorMessage,
    VoidCallback? onRetry,
    String? userEmail,
  ) async {
    await EnhancedAuthDialog.showGenericErrorDialog(
      context,
      message: errorMessage.isNotEmpty
          ? errorMessage
          : 'An unexpected error occurred. Please try again or contact support if the problem persists.',
      onRetry: onRetry,
      onContactSupport: () => _launchSupport(
        context,
        userEmail: userEmail,
        supportReason:
            'I encountered an unexpected sign-in error and need help.',
      ),
    );
  }

  /// Launch support contact
  static Future<void> _launchSupport(
    BuildContext context, {
    String? userEmail,
    String? supportReason,
  }) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => FeedbackFormView(
          userEmail: userEmail,
          initialTitle: 'Sign-in issue',
          initialDescription: supportReason ?? 'I need help signing in.',
        ),
      ),
    );
  }

  /// Resend verification email
  static Future<void> _resendVerificationEmail(
    BuildContext context,
    String? email,
  ) async {
    final targetEmail = email?.trim().toLowerCase();

    try {
      if (targetEmail == null || targetEmail.isEmpty) {
        throw Exception('Please enter a valid email and try again.');
      }

      final response =
          await ApiMethod().resendEmailVerificationOtp(targetEmail);
      final isSuccess =
          response['success'] == true || response['statusCode'] == 200;

      if (!isSuccess) {
        throw Exception(
          response['message']?.toString() ??
              'Failed to send verification link.',
        );
      }
      final successMessage =
          response['message']?.toString() ??
              'Verification link sent to $targetEmail.';

      if (context.mounted) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            content: Text(successMessage),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      await EnhancedAuthDialog.showErrorDialog(
        context,
        title: 'Resend Failed',
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
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
  invalidCredentials,
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
