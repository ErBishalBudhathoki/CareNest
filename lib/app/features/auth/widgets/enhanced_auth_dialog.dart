import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dialog type enumeration for semantic styling
enum _DialogType { error, warning, info, success, question }

/// Action style enumeration for button styling
enum _ActionStyle { primary, secondary, text, destructive }

/// Dialog action model for consistent button handling
class _DialogAction {
  final String label;
  final VoidCallback onPressed;
  final _ActionStyle style;
  final IconData? icon;

  const _DialogAction({
    required this.label,
    required this.onPressed,
    required this.style,
    this.icon,
  });
}

/// Professional UX-focused authentication dialog system for SaaS applications
/// Features: Semantic design, micro-interactions, accessibility, progressive disclosure
class EnhancedAuthDialog {
  // Animation durations for consistent timing
  static const Duration _dialogAnimationDuration = Duration(milliseconds: 400);
  static const Duration _iconAnimationDuration = Duration(milliseconds: 600);
  static const Duration _buttonHoverDuration = Duration(milliseconds: 200);

  /// Build progressive message with contextual hints
  static String _buildProgressiveMessage({
    required String baseMessage,
    int? attemptCount,
    List<String>? hints,
  }) {
    final buffer = StringBuffer(baseMessage);

    if (attemptCount != null && attemptCount > 1) {
      buffer.write('\n\nAttempt $attemptCount of 5');
    }

    if (hints != null && hints.isNotEmpty) {
      buffer.write('\n\nHelpful tips:');
      for (final hint in hints) {
        buffer.write('\n• $hint');
      }
    }

    return buffer.toString();
  }

  /// Core semantic dialog builder with modern UX patterns
  static Future<void> _showSemanticDialog({
    required BuildContext context,
    required _DialogType type,
    required IconData icon,
    required String title,
    required String message,
    required _DialogAction primaryAction,
    _DialogAction? secondaryAction,
    _DialogAction? helpAction,
    bool barrierDismissible = false,
  }) async {
    // Haptic feedback for better UX
    HapticFeedback.lightImpact();

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: BauhausDesign.neutral.withValues(alpha: 0.6),
      builder: (BuildContext context) {
        return _ModernDialog(
          type: type,
          icon: icon,
          title: title,
          message: message,
          primaryAction: primaryAction,
          secondaryAction: secondaryAction,
          helpAction: helpAction,
        );
      },
    );
  }

  /// Show password help dialog with detailed guidance
  static Future<void> _showPasswordHelpDialog(
    BuildContext context, {
    VoidCallback? onResetPassword,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Icons.info_outline,
      title: 'Password Help',
      message:
          'Having trouble with your password?\n\n• Passwords are case-sensitive\n• Check if Caps Lock is enabled\n• Ensure you\'re using the correct email\n• Try resetting your password if you\'re still having issues',
      primaryAction: _DialogAction(
        label: 'Reset Password',
        onPressed: () {
          Navigator.of(context).pop();
          if (onResetPassword != null) {
            onResetPassword();
          } else {
            Navigator.pushNamed(context, '/forgotPassword');
          }
        },
        style: _ActionStyle.primary,
      ),
      secondaryAction: _DialogAction(
        label: 'Back',
        onPressed: () => Navigator.of(context).pop(),
        style: _ActionStyle.secondary,
      ),
    );
  }

  /// Show dialog for incorrect password with progressive assistance
  static Future<void> showIncorrectPasswordDialog(
    BuildContext context, {
    int? attemptCount,
    bool showPasswordHints = false,
    VoidCallback? onResetPassword,
    VoidCallback? onContactSupport,
  }) async {
    final String enhancedMessage = _buildProgressiveMessage(
      baseMessage: 'The password you entered is incorrect.',
      attemptCount: attemptCount,
      hints: showPasswordHints
          ? [
              'Password is case-sensitive',
              'Check if Caps Lock is on',
              'Try typing it in a text editor first',
            ]
          : null,
    );

    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.lock_outline,
      title: 'Wrong Password',
      message: enhancedMessage,
      primaryAction: _DialogAction(
        label: 'Check Password',
        onPressed: () => Navigator.of(context).pop(),
        style: _ActionStyle.primary,
      ),
      secondaryAction: _DialogAction(
        label: 'Reset Password',
        onPressed: () {
          Navigator.of(context).pop();
          if (onResetPassword != null) {
            onResetPassword();
          } else {
            Navigator.pushNamed(context, '/forgotPassword');
          }
        },
        style: _ActionStyle.secondary,
        icon: Icons.key_outlined,
      ),
      helpAction:
          onContactSupport != null && attemptCount != null && attemptCount >= 2
          ? _DialogAction(
              label: 'Get Support',
              onPressed: () {
                Navigator.of(context).pop();
                onContactSupport();
              },
              style: _ActionStyle.text,
              icon: Icons.support_agent_outlined,
            )
          : attemptCount != null && attemptCount >= 2
          ? _DialogAction(
              label: 'Need Help?',
              onPressed: () => _showPasswordHelpDialog(
                context,
                onResetPassword: onResetPassword,
              ),
              style: _ActionStyle.text,
            )
          : null,
    );
  }

  /// Shows a dialog when the user account is not found
  static Future<void> showAccountNotFoundDialog(
    BuildContext context, {
    String? email,
    VoidCallback? onCreateAccount,
    VoidCallback? onContactSupport,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.person_search_outlined,
      title: 'Account Not Found',
      message: _buildAccountNotFoundMessage(email),
      primaryAction: _DialogAction(
        label: 'Check Email',
        style: _ActionStyle.primary,
        icon: Icons.edit_outlined,
        onPressed: () => Navigator.of(context).pop(),
      ),
      secondaryAction: _DialogAction(
        label: 'Create Account',
        style: _ActionStyle.secondary,
        icon: Icons.person_add_alt_1,
        onPressed: () {
          Navigator.of(context).pop();
          if (onCreateAccount != null) {
            onCreateAccount();
          } else {
            Navigator.pushNamed(context, '/signup');
          }
        },
      ),
      helpAction: _DialogAction(
        label: 'Need Help?',
        style: _ActionStyle.text,
        icon: Icons.support_agent_outlined,
        onPressed: () => _showEmailRecoveryDialog(
          context,
          onContactSupport: onContactSupport,
        ),
      ),
    );
  }

  static String _buildAccountNotFoundMessage(String? email) {
    if (email != null && email.isNotEmpty) {
      return 'We couldn\'t find an account associated with $email. '
          'This email might not be registered yet, or there might be a typo.';
    }
    return 'We couldn\'t find an account with that email address. '
        'Please check your email or create a new account.';
  }

  static Future<void> _showEmailRecoveryDialog(
    BuildContext context, {
    VoidCallback? onContactSupport,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Icons.help_outline,
      title: 'Need Help Finding Your Email?',
      message:
          'Try checking:\n'
          '• Your most commonly used email addresses\n'
          '• Work or school email accounts\n'
          '• Email accounts linked to other services\n\n'
          'Still can\'t find it? '
          '${onContactSupport != null ? 'Report this sign-in issue and our team will help.' : 'Try another email and sign in again.'}',
      primaryAction: _DialogAction(
        label: onContactSupport != null
            ? 'Report Sign-In Issue'
            : 'Back to Login',
        style: _ActionStyle.primary,
        icon: onContactSupport != null
            ? Icons.support_agent_outlined
            : Icons.arrow_back_outlined,
        onPressed: () {
          Navigator.of(context).pop();
          onContactSupport?.call();
        },
      ),
      secondaryAction: _DialogAction(
        label: 'Back',
        style: _ActionStyle.secondary,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Shows a dialog for network connectivity issues
  static Future<void> showNetworkErrorDialog(
    BuildContext context, {
    VoidCallback? onRetry,
    bool showOfflineMode = false,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.error,
      icon: Icons.wifi_off_outlined,
      title: 'Connection Problem',
      message:
          'Unable to connect to our servers. Please check your '
          'internet connection and try again.',
      primaryAction: _DialogAction(
        label: 'Retry Connection',
        style: _ActionStyle.primary,
        icon: Icons.refresh,
        onPressed: () {
          Navigator.of(context).pop();
          onRetry?.call();
        },
      ),
      secondaryAction: _DialogAction(
        label: 'Cancel',
        style: _ActionStyle.secondary,
        onPressed: () => Navigator.of(context).pop(),
      ),
      helpAction: showOfflineMode
          ? _DialogAction(
              label: 'Work Offline',
              style: _ActionStyle.text,
              icon: Icons.cloud_off_outlined,
              onPressed: () {
                Navigator.of(context).pop();
                // Enable offline mode
              },
            )
          : _DialogAction(
              label: 'Check Connection',
              style: _ActionStyle.text,
              icon: Icons.settings_outlined,
              onPressed: () => _showConnectionTroubleshootDialog(context),
            ),
    );
  }

  static Future<void> _showConnectionTroubleshootDialog(
    BuildContext context,
  ) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Icons.info_outline,
      title: 'Connection Troubleshooting',
      message:
          'Try these steps to fix connection issues:\n\n'
          '1. Check your WiFi or mobile data\n'
          '2. Move closer to your router\n'
          '3. Restart your internet connection\n'
          '4. Check if other apps work\n\n'
          'If the problem persists, it might be a temporary server issue.',
      primaryAction: _DialogAction(
        label: 'Try Again',
        style: _ActionStyle.primary,
        icon: Icons.refresh,
        onPressed: () => Navigator.of(context).pop(),
      ),
      secondaryAction: _DialogAction(
        label: 'Back',
        style: _ActionStyle.secondary,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Show dialog for server errors
  static Future<void> showServerErrorDialog(
    BuildContext context, {
    String? errorCode,
    VoidCallback? onRetry,
    VoidCallback? onReportIssue,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.error,
      icon: Icons.warning_amber_outlined,
      title: 'Server Error',
      message: _buildServerErrorMessage(errorCode),
      primaryAction: _DialogAction(
        label: 'Try Again',
        style: _ActionStyle.primary,
        icon: Icons.refresh,
        onPressed: () {
          Navigator.of(context).pop();
          onRetry?.call();
        },
      ),
      secondaryAction: _DialogAction(
        label: 'Cancel',
        style: _ActionStyle.secondary,
        onPressed: () => Navigator.of(context).pop(),
      ),
      helpAction: _DialogAction(
        label: 'Report Issue',
        style: _ActionStyle.text,
        icon: Icons.help_outline,
        onPressed: () {
          if (onReportIssue != null) {
            Navigator.of(context).pop();
            onReportIssue();
            return;
          }
          _showErrorReportDialog(context, errorCode);
        },
      ),
    );
  }

  static String _buildServerErrorMessage(String? errorCode) {
    if (errorCode != null) {
      return 'Our servers are experiencing issues (Error: $errorCode). '
          'Our team has been notified. Please try again in a few moments.';
    }
    return 'Our servers are experiencing issues. '
        'Please try again in a few moments.';
  }

  static Future<void> _showErrorReportDialog(
    BuildContext context,
    String? errorCode,
  ) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Icons.help_outline,
      title: 'Report This Issue',
      message:
          'Help us improve by reporting this error. '
          'Your feedback helps us fix issues faster.\n\n'
          '${errorCode != null ? "Error Code: $errorCode\n\n" : ""}'
          'What were you trying to do when this happened?',
      primaryAction: _DialogAction(
        label: 'Send Report',
        style: _ActionStyle.primary,
        icon: Icons.send_outlined,
        onPressed: () {
          Navigator.of(context).pop();
          // Send error report
        },
      ),
      secondaryAction: _DialogAction(
        label: 'Skip',
        style: _ActionStyle.secondary,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Show dialog for account lockout
  static Future<void> showAccountLockedDialog(
    BuildContext context, {
    Duration? lockoutDuration,
    VoidCallback? onResetPassword,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.lock_outline,
      title: 'Account Temporarily Locked',
      message: _buildAccountLockedMessage(lockoutDuration),
      primaryAction: _DialogAction(
        label: 'Reset Password',
        style: _ActionStyle.primary,
        icon: Icons.key_outlined,
        onPressed: () {
          Navigator.of(context).pop();
          onResetPassword?.call();
        },
      ),
      secondaryAction: _DialogAction(
        label: 'Wait and Try Later',
        style: _ActionStyle.secondary,
        icon: Icons.timer_outlined,
        onPressed: () => Navigator.of(context).pop(),
      ),
      helpAction: _DialogAction(
        label: 'Why is this happening?',
        style: _ActionStyle.text,
        icon: Icons.security_outlined,
        onPressed: () => _showSecurityInfoDialog(context),
      ),
    );
  }

  static String _buildAccountLockedMessage(Duration? lockoutDuration) {
    final baseMessage =
        'Your account has been temporarily locked due to '
        'multiple failed login attempts. This is a security measure to '
        'protect your account.';

    if (lockoutDuration != null) {
      final minutes = lockoutDuration.inMinutes;
      if (minutes < 60) {
        return '$baseMessage\n\nYou can try again in $minutes minutes.';
      } else {
        final hours = (minutes / 60).ceil();
        return '$baseMessage\n\nYou can try again in $hours hours.';
      }
    }

    return '$baseMessage\n\nPlease try again later or reset your password.';
  }

  static Future<void> _showSecurityInfoDialog(BuildContext context) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Icons.security_outlined,
      title: 'Account Security',
      message:
          'We lock accounts temporarily after several failed login '
          'attempts to protect against unauthorized access.\n\n'
          'This helps keep your account safe from:\n'
          '• Brute force attacks\n'
          '• Unauthorized access attempts\n'
          '• Password guessing\n\n'
          'You can unlock your account by resetting your password or '
          'waiting for the lockout period to expire.',
      primaryAction: _DialogAction(
        label: 'Got It',
        style: _ActionStyle.primary,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Show dialog for session timeout
  static Future<void> showSessionTimeoutDialog(
    BuildContext context, {
    VoidCallback? onLogin,
    bool showAutoSave = false,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.timer_outlined,
      title: 'Session Expired',
      message: _buildSessionTimeoutMessage(showAutoSave),
      primaryAction: _DialogAction(
        label: 'Log In Again',
        style: _ActionStyle.primary,
        icon: Icons.login,
        onPressed: () {
          Navigator.of(context).pop();
          onLogin?.call();
        },
      ),
      secondaryAction: _DialogAction(
        label: 'Cancel',
        style: _ActionStyle.secondary,
        onPressed: () => Navigator.of(context).pop(),
      ),
      helpAction: _DialogAction(
        label: 'Why did this happen?',
        style: _ActionStyle.text,
        icon: Icons.info_outline,
        onPressed: () => _showSessionInfoDialog(context),
      ),
    );
  }

  static String _buildSessionTimeoutMessage(bool showAutoSave) {
    final baseMessage =
        'Your session has expired for security reasons. '
        'Please log in again to continue.';

    if (showAutoSave) {
      return '$baseMessage\n\nDon\'t worry - your work has been automatically saved.';
    }

    return baseMessage;
  }

  static Future<void> _showSessionInfoDialog(BuildContext context) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Icons.schedule_outlined,
      title: 'About Session Timeouts',
      message:
          'Sessions expire automatically for your security after a '
          'period of inactivity.\n\n'
          'This helps protect your account by:\n'
          '• Preventing unauthorized access on shared devices\n'
          '• Reducing security risks if you forget to log out\n'
          '• Ensuring your data stays private\n\n'
          'You can extend your session by staying active or '
          'adjust timeout settings in your account preferences.',
      primaryAction: _DialogAction(
        label: 'Understood',
        style: _ActionStyle.primary,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Show dialog for invalid input format
  static Future<void> showInvalidInputDialog(
    BuildContext context, {
    String? fieldName,
    String? customMessage,
    List<String>? validationErrors,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.warning_amber_outlined,
      title: 'Input Validation Error',
      message: _buildValidationMessage(
        fieldName,
        customMessage,
        validationErrors,
      ),
      primaryAction: _DialogAction(
        label: 'Fix Input',
        style: _ActionStyle.primary,
        icon: Icons.edit_outlined,
        onPressed: () => Navigator.of(context).pop(),
      ),
      helpAction: validationErrors != null && validationErrors.isNotEmpty
          ? _DialogAction(
              label: 'Show Requirements',
              style: _ActionStyle.text,
              icon: Icons.info_outline,
              onPressed: () =>
                  _showValidationHelpDialog(context, validationErrors),
            )
          : null,
    );
  }

  static String _buildValidationMessage(
    String? fieldName,
    String? customMessage,
    List<String>? validationErrors,
  ) {
    if (customMessage != null) {
      return customMessage;
    }

    if (fieldName != null) {
      return 'Please check your $fieldName and make sure it meets all requirements.';
    }

    if (validationErrors != null && validationErrors.isNotEmpty) {
      return 'Please fix the following issues:\n\n${validationErrors.map((e) => '• $e').join('\n')}';
    }

    return 'Please check your input and make sure all required fields are filled correctly.';
  }

  static Future<void> _showValidationHelpDialog(
    BuildContext context,
    List<String> requirements,
  ) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Icons.check_box_outlined,
      title: 'Input Requirements',
      message:
          'Please ensure your input meets these requirements:\n\n'
          '${requirements.map((req) => '✓ $req').join('\n')}',
      primaryAction: _DialogAction(
        label: 'Got It',
        style: _ActionStyle.primary,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Show dialog when sign-in credentials are invalid and exact cause is unknown
  static Future<void> showInvalidCredentialsDialog(
    BuildContext context, {
    VoidCallback? onResetPassword,
    VoidCallback? onContactSupport,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.vpn_key_outlined,
      title: 'Couldn\'t Sign You In',
      message:
          'The email or password you entered is incorrect. '
          'Please check your details and try again.',
      primaryAction: _DialogAction(
        label: 'Edit Details',
        style: _ActionStyle.primary,
        icon: Icons.edit_outlined,
        onPressed: () => Navigator.of(context).pop(),
      ),
      secondaryAction: _DialogAction(
        label: 'Reset Password',
        style: _ActionStyle.secondary,
        icon: Icons.key_outlined,
        onPressed: () {
          Navigator.of(context).pop();
          if (onResetPassword != null) {
            onResetPassword();
          } else {
            Navigator.pushNamed(context, '/forgotPassword');
          }
        },
      ),
      helpAction: onContactSupport != null
          ? _DialogAction(
              label: 'Get Support',
              style: _ActionStyle.text,
              icon: Icons.support_agent_outlined,
              onPressed: () {
                Navigator.of(context).pop();
                onContactSupport();
              },
            )
          : null,
    );
  }

  /// Show dialog for temporary lock due to too many attempts
  static Future<void> showTooManyAttemptsDialog(
    BuildContext context, {
    Duration lockoutDuration = const Duration(minutes: 15),
    VoidCallback? onResetPassword,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.timer_outlined,
      title: 'Too Many Attempts',
      message:
          'For your security, sign-in is temporarily locked after '
          'multiple failed attempts.\n\n'
          'Please try again in ${lockoutDuration.inMinutes} minutes.',
      primaryAction: _DialogAction(
        label: 'I Understand',
        style: _ActionStyle.primary,
        onPressed: () => Navigator.of(context).pop(),
      ),
      secondaryAction: onResetPassword != null
          ? _DialogAction(
              label: 'Reset Password',
              style: _ActionStyle.secondary,
              icon: Icons.key_outlined,
              onPressed: () {
                Navigator.of(context).pop();
                onResetPassword();
              },
            )
          : null,
    );
  }

  /// Show dialog for unverified email addresses during login
  static Future<void> showEmailNotVerifiedDialog(
    BuildContext context, {
    String? email,
    VoidCallback? onResendEmail,
    VoidCallback? onContactSupport,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.mark_email_unread_outlined,
      title: 'Email Verification Required',
      message: email != null && email.isNotEmpty
          ? 'We sent a verification link to $email. '
                'Please open your inbox and verify your account before signing in.'
          : 'Please verify your email address before signing in. '
                'Check your inbox for a verification link.',
      primaryAction: _DialogAction(
        label: 'Got It',
        style: _ActionStyle.primary,
        onPressed: () => Navigator.of(context).pop(),
      ),
      secondaryAction: onResendEmail != null
          ? _DialogAction(
              label: 'Resend Email',
              style: _ActionStyle.secondary,
              icon: Icons.refresh_outlined,
              onPressed: () {
                Navigator.of(context).pop();
                onResendEmail();
              },
            )
          : null,
      helpAction: onContactSupport != null
          ? _DialogAction(
              label: 'Get Support',
              style: _ActionStyle.text,
              icon: Icons.support_agent_outlined,
              onPressed: () {
                Navigator.of(context).pop();
                onContactSupport();
              },
            )
          : null,
    );
  }

  /// Show dialog for suspended or disabled accounts
  static Future<void> showAccountDisabledDialog(
    BuildContext context, {
    VoidCallback? onContactSupport,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.error,
      icon: Icons.person_off_outlined,
      title: 'Account Suspended',
      message:
          'Your account has been temporarily suspended. '
          'This may be due to a security concern or policy violation.',
      primaryAction: _DialogAction(
        label: onContactSupport != null ? 'Contact Support' : 'Got It',
        style: _ActionStyle.primary,
        icon: onContactSupport != null
            ? Icons.support_agent_outlined
            : Icons.check,
        onPressed: () {
          Navigator.of(context).pop();
          onContactSupport?.call();
        },
      ),
      secondaryAction: onContactSupport != null
          ? _DialogAction(
              label: 'Later',
              style: _ActionStyle.secondary,
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  /// Show dialog for weak password validation errors
  static Future<void> showWeakPasswordDialog(
    BuildContext context, {
    VoidCallback? onFixPassword,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Icons.gpp_bad_outlined,
      title: 'Strengthen Your Password',
      message:
          'Your password needs to be stronger for better security.\n\n'
          '• At least 8 characters\n'
          '• Uppercase and lowercase letters\n'
          '• Numbers and special characters',
      primaryAction: _DialogAction(
        label: 'Create Stronger Password',
        style: _ActionStyle.primary,
        onPressed: () {
          Navigator.of(context).pop();
          onFixPassword?.call();
        },
      ),
    );
  }

  /// Show dialog for existing account conflicts
  static Future<void> showEmailAlreadyInUseDialog(
    BuildContext context, {
    String? email,
    VoidCallback? onSignIn,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Icons.person_outline,
      title: 'Account Already Exists',
      message: email != null && email.isNotEmpty
          ? 'An account with "$email" already exists. Would you like to sign in?'
          : 'This email address is already registered. Would you like to sign in?',
      primaryAction: _DialogAction(
        label: 'Try Different Email',
        style: _ActionStyle.primary,
        onPressed: () => Navigator.of(context).pop(),
      ),
      secondaryAction: _DialogAction(
        label: 'Sign In',
        style: _ActionStyle.secondary,
        icon: Icons.login_outlined,
        onPressed: () {
          Navigator.of(context).pop();
          onSignIn?.call();
        },
      ),
    );
  }

  /// Show generic catch-all auth error dialog
  static Future<void> showGenericErrorDialog(
    BuildContext context, {
    required String message,
    VoidCallback? onRetry,
    VoidCallback? onContactSupport,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.error,
      icon: Icons.error_outline,
      title: 'Something Went Wrong',
      message: message,
      primaryAction: _DialogAction(
        label: onRetry != null ? 'Try Again' : 'OK',
        style: _ActionStyle.primary,
        icon: onRetry != null ? Icons.refresh : Icons.check,
        onPressed: () {
          Navigator.of(context).pop();
          onRetry?.call();
        },
      ),
      secondaryAction: onContactSupport != null
          ? _DialogAction(
              label: 'Contact Support',
              style: _ActionStyle.secondary,
              icon: Icons.support_agent_outlined,
              onPressed: () {
                Navigator.of(context).pop();
                onContactSupport();
              },
            )
          : null,
    );
  }

  /// Show success dialog for successful login
  static Future<void> showSuccessDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
    bool autoClose = false,
    Duration autoCloseDuration = const Duration(seconds: 3),
  }) async {
    final dialog = _showSemanticDialog(
      context: context,
      type: _DialogType.success,
      icon: Icons.check_circle_outline,
      title: title ?? 'Success!',
      message: message ?? 'Operation completed successfully!',
      primaryAction: _DialogAction(
        label: actionLabel ?? 'Continue',
        style: _ActionStyle.primary,
        icon: Icons.arrow_forward_ios,
        onPressed: () {
          Navigator.of(context).pop();
          onAction?.call();
        },
      ),
    );

    if (autoClose) {
      Future.delayed(autoCloseDuration, () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          onAction?.call();
        }
      });
    }

    return dialog;
  }

  /// Show generic error dialog
  static Future<void> showErrorDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.error,
      icon: Icons.error_outline,
      title: title ?? 'Error',
      message: message ?? 'An error occurred.',
      primaryAction: _DialogAction(
        label: actionLabel ?? 'OK',
        style: _ActionStyle.primary,
        onPressed: () {
          Navigator.of(context).pop();
          onAction?.call();
        },
      ),
    );
  }
}

/// Modern dialog widget with enhanced UX patterns
class _ModernDialog extends StatefulWidget {
  final _DialogType type;
  final IconData icon;
  final String title;
  final String message;
  final _DialogAction primaryAction;
  final _DialogAction? secondaryAction;
  final _DialogAction? helpAction;

  const _ModernDialog({
    required this.type,
    required this.icon,
    required this.title,
    required this.message,
    required this.primaryAction,
    this.secondaryAction,
    this.helpAction,
  });

  @override
  State<_ModernDialog> createState() => _ModernDialogState();
}

class _ModernDialogState extends State<_ModernDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _iconController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _scaleController = AnimationController(
      duration: EnhancedAuthDialog._dialogAnimationDuration,
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: EnhancedAuthDialog._dialogAnimationDuration,
      vsync: this,
    );
    _iconController = AnimationController(
      duration: EnhancedAuthDialog._iconAnimationDuration,
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _iconAnimation = CurvedAnimation(
      parent: _iconController,
      curve: Curves.bounceOut,
    );
  }

  void _startAnimations() {
    _fadeController.forward();
    _scaleController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _iconController.forward();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Color _getSemanticColor() {
    switch (widget.type) {
      case _DialogType.error:
        return BauhausDesign.error;
      case _DialogType.warning:
        return BauhausDesign.warning;
      case _DialogType.info:
        return BauhausDesign.secondary;
      case _DialogType.success:
        return BauhausDesign.success;
      case _DialogType.question:
        return BauhausDesign.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final semanticColor = _getSemanticColor();
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final surfaceBrightness = ThemeData.estimateBrightnessForColor(
      surfaceColor,
    );
    final effectiveOnSurface = surfaceBrightness == Brightness.dark
        ? BauhausDesign.surfaceLight
        : BauhausDesign.neutral;

    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _fadeAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: 0.7 + (0.3 * _scaleAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.95,
                  minWidth: 340,
                ),
                decoration: BauhausDesign.cardDecoration.copyWith(
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(semanticColor, effectiveOnSurface),
                    _buildContent(effectiveOnSurface),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Color semanticColor, Color effectiveOnSurface) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _iconAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _iconAnimation.value,
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: semanticColor,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 40,
                      color: BauhausDesign.backgroundLight,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: effectiveOnSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(Color effectiveOnSurface) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              color: BauhausDesign.neutral.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildActionButton(widget.primaryAction),
          if (widget.secondaryAction != null) ...[
            const SizedBox(height: 12),
            _buildActionButton(widget.secondaryAction!),
          ],
          if (widget.helpAction != null) ...[
            const SizedBox(height: 8),
            _buildActionButton(widget.helpAction!),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(_DialogAction action) {
    final semanticColor = _getSemanticColor();
    return SizedBox(
      width: double.infinity,
      child: BauhausActionButton(
        text: action.label,
        onPressed: action.onPressed,
        backgroundColor: action.style == _ActionStyle.primary
            ? semanticColor
            : (action.style == _ActionStyle.destructive
                  ? BauhausDesign.error
                  : BauhausDesign.backgroundLight),
        textColor:
            action.style == _ActionStyle.primary ||
                action.style == _ActionStyle.destructive
            ? BauhausDesign.surfaceWhite
            : BauhausDesign.neutral,
        icon: action.icon,
      ),
    );
  }
}
