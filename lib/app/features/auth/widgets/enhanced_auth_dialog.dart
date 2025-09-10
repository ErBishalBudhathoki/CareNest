import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:iconsax/iconsax.dart';

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
  final bool isLoading;

  const _DialogAction({
    required this.label,
    required this.onPressed,
    required this.style,
    this.icon,
    this.isLoading = false,
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
      barrierColor: Colors.black.withValues(alpha: 0.6),
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
  static Future<void> _showPasswordHelpDialog(BuildContext context) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Iconsax.info_circle,
      title: 'Password Help',
      message:
          'Having trouble with your password?\n\n• Passwords are case-sensitive\n• Check if Caps Lock is enabled\n• Ensure you\'re using the correct email\n• Try resetting your password if you\'re still having issues',
      primaryAction: _DialogAction(
        label: 'Reset Password',
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/forgotPassword');
        },
        style: _ActionStyle.primary,
      ),
      secondaryAction: _DialogAction(
        label: 'Try Again',
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
  }) async {
    final String enhancedMessage = _buildProgressiveMessage(
      baseMessage: 'The password you entered is incorrect.',
      attemptCount: attemptCount,
      hints: showPasswordHints
          ? [
              'Password is case-sensitive',
              'Check if Caps Lock is on',
              'Try typing it in a text editor first'
            ]
          : null,
    );

    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Iconsax.lock_slash,
      title: 'Authentication Failed',
      message: enhancedMessage,
      primaryAction: _DialogAction(
        label: 'Try Again',
        onPressed: () => Navigator.of(context).pop(),
        style: _ActionStyle.primary,
      ),
      secondaryAction: _DialogAction(
        label: 'Reset Password',
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/forgotPassword');
        },
        style: _ActionStyle.secondary,
        icon: Iconsax.key,
      ),
      helpAction: attemptCount != null && attemptCount >= 2
          ? _DialogAction(
              label: 'Need Help?',
              onPressed: () => _showPasswordHelpDialog(context),
              style: _ActionStyle.text,
            )
          : null,
    );
  }

  /// Shows a dialog when the user account is not found
  static Future<void> showAccountNotFoundDialog(
    BuildContext context, {
    String? email,
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.warning,
      icon: Iconsax.user_search,
      title: 'Account Not Found',
      message: _buildAccountNotFoundMessage(email),
      primaryAction: _DialogAction(
        label: 'Create Account',
        style: _ActionStyle.primary,
        icon: Iconsax.user_add,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/signup');
        },
      ),
      secondaryAction: _DialogAction(
        label: 'Try Different Email',
        style: _ActionStyle.secondary,
        icon: Iconsax.edit,
        onPressed: () => Navigator.of(context).pop(),
      ),
      helpAction: _DialogAction(
        label: 'Forgot Email?',
        style: _ActionStyle.text,
        icon: Iconsax.message_question,
        onPressed: () => _showEmailRecoveryDialog(context),
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

  static Future<void> _showEmailRecoveryDialog(BuildContext context) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Iconsax.message_question,
      title: 'Need Help Finding Your Email?',
      message: 'Try checking:\n'
          '• Your most commonly used email addresses\n'
          '• Work or school email accounts\n'
          '• Email accounts linked to other services\n\n'
          'Still can\'t find it? Contact our support team.',
      primaryAction: _DialogAction(
        label: 'Contact Support',
        style: _ActionStyle.primary,
        icon: Iconsax.support,
        onPressed: () {
          Navigator.of(context).pop();
          // Open support contact
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
      icon: Iconsax.wifi_square,
      title: 'Connection Problem',
      message: 'Unable to connect to our servers. Please check your '
          'internet connection and try again.',
      primaryAction: _DialogAction(
        label: 'Retry Connection',
        style: _ActionStyle.primary,
        icon: Iconsax.refresh,
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
              icon: Iconsax.cloud_minus,
              onPressed: () {
                Navigator.of(context).pop();
                // Enable offline mode
              },
            )
          : _DialogAction(
              label: 'Check Connection',
              style: _ActionStyle.text,
              icon: Iconsax.setting_2,
              onPressed: () => _showConnectionTroubleshootDialog(context),
            ),
    );
  }

  static Future<void> _showConnectionTroubleshootDialog(
      BuildContext context) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.info,
      icon: Iconsax.info_circle,
      title: 'Connection Troubleshooting',
      message: 'Try these steps to fix connection issues:\n\n'
          '1. Check your WiFi or mobile data\n'
          '2. Move closer to your router\n'
          '3. Restart your internet connection\n'
          '4. Check if other apps work\n\n'
          'If the problem persists, it might be a temporary server issue.',
      primaryAction: _DialogAction(
        label: 'Try Again',
        style: _ActionStyle.primary,
        icon: Iconsax.refresh,
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
  }) async {
    return _showSemanticDialog(
      context: context,
      type: _DialogType.error,
      icon: Iconsax.warning_2,
      title: 'Server Error',
      message: _buildServerErrorMessage(errorCode),
      primaryAction: _DialogAction(
        label: 'Try Again',
        style: _ActionStyle.primary,
        icon: Iconsax.refresh,
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
        icon: Iconsax.message_question,
        onPressed: () => _showErrorReportDialog(context, errorCode),
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
      icon: Iconsax.message_question,
      title: 'Report This Issue',
      message: 'Help us improve by reporting this error. '
          'Your feedback helps us fix issues faster.\n\n'
          '${errorCode != null ? "Error Code: $errorCode\n\n" : ""}'
          'What were you trying to do when this happened?',
      primaryAction: _DialogAction(
        label: 'Send Report',
        style: _ActionStyle.primary,
        icon: Iconsax.send_1,
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
      icon: Iconsax.lock,
      title: 'Account Temporarily Locked',
      message: _buildAccountLockedMessage(lockoutDuration),
      primaryAction: _DialogAction(
        label: 'Reset Password',
        style: _ActionStyle.primary,
        icon: Iconsax.key,
        onPressed: () {
          Navigator.of(context).pop();
          onResetPassword?.call();
        },
      ),
      secondaryAction: _DialogAction(
        label: 'Wait and Try Later',
        style: _ActionStyle.secondary,
        icon: Iconsax.timer,
        onPressed: () => Navigator.of(context).pop(),
      ),
      helpAction: _DialogAction(
        label: 'Why is this happening?',
        style: _ActionStyle.text,
        icon: Iconsax.shield_security,
        onPressed: () => _showSecurityInfoDialog(context),
      ),
    );
  }

  static String _buildAccountLockedMessage(Duration? lockoutDuration) {
    final baseMessage = 'Your account has been temporarily locked due to '
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
      icon: Iconsax.shield_security,
      title: 'Account Security',
      message: 'We lock accounts temporarily after several failed login '
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
      icon: Iconsax.timer,
      title: 'Session Expired',
      message: _buildSessionTimeoutMessage(showAutoSave),
      primaryAction: _DialogAction(
        label: 'Log In Again',
        style: _ActionStyle.primary,
        icon: Iconsax.login,
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
        icon: Iconsax.info_circle,
        onPressed: () => _showSessionInfoDialog(context),
      ),
    );
  }

  static String _buildSessionTimeoutMessage(bool showAutoSave) {
    final baseMessage = 'Your session has expired for security reasons. '
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
      icon: Iconsax.clock,
      title: 'About Session Timeouts',
      message: 'Sessions expire automatically for your security after a '
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
      icon: Iconsax.warning_2,
      title: 'Input Validation Error',
      message:
          _buildValidationMessage(fieldName, customMessage, validationErrors),
      primaryAction: _DialogAction(
        label: 'Fix Input',
        style: _ActionStyle.primary,
        icon: Iconsax.edit,
        onPressed: () => Navigator.of(context).pop(),
      ),
      helpAction: validationErrors != null && validationErrors.isNotEmpty
          ? _DialogAction(
              label: 'Show Requirements',
              style: _ActionStyle.text,
              icon: Iconsax.info_circle,
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
      icon: Iconsax.tick_square,
      title: 'Input Requirements',
      message: 'Please ensure your input meets these requirements:\n\n'
          '${requirements.map((req) => '✓ $req').join('\n')}',
      primaryAction: _DialogAction(
        label: 'Got It',
        style: _ActionStyle.primary,
        onPressed: () => Navigator.of(context).pop(),
      ),
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
      icon: Iconsax.tick_circle,
      title: title ?? 'Success!',
      message: message ?? 'Operation completed successfully!',
      primaryAction: _DialogAction(
        label: actionLabel ?? 'Continue',
        style: _ActionStyle.primary,
        icon: Iconsax.arrow_right_3,
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
        return const Color(0xFFE53E3E);
      case _DialogType.warning:
        return const Color(0xFFED8936);
      case _DialogType.info:
        return const Color(0xFF3182CE);
      case _DialogType.success:
        return const Color(0xFF38A169);
      case _DialogType.question:
        return const Color(0xFF805AD5);
    }
  }

  @override
  Widget build(BuildContext context) {
    final semanticColor = _getSemanticColor();

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
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: semanticColor.withValues(alpha: 0.1),
                      blurRadius: 40,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(semanticColor),
                    _buildContent(),
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

  Widget _buildHeader(Color semanticColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _iconAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _iconAnimation.value,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: semanticColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: semanticColor.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 32,
                    color: semanticColor,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        widget.message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.8),
              height: 1.5,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Check if we should stack buttons vertically for better text display
          _shouldStackButtons()
              ? Column(
                  children: [
                    if (widget.secondaryAction != null) ...[
                      SizedBox(
                        width: double.infinity,
                        child: _buildActionButton(widget.secondaryAction!),
                      ),
                      const SizedBox(height: 12),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: _buildActionButton(widget.primaryAction),
                    ),
                  ],
                )
              : Row(
                  children: [
                    if (widget.secondaryAction != null) ...[
                      Expanded(
                        child: _buildActionButton(widget.secondaryAction!),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: _buildActionButton(widget.primaryAction),
                    ),
                  ],
                ),
          if (widget.helpAction != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: _buildActionButton(widget.helpAction!),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(_DialogAction action) {
    final semanticColor = _getSemanticColor();

    return AnimatedContainer(
      duration: EnhancedAuthDialog._buttonHoverDuration,
      height: 48,
      child: _buildButtonByStyle(action, semanticColor),
    );
  }

  Widget _buildButtonByStyle(_DialogAction action, Color semanticColor) {
    final buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (action.icon != null) ...[
          Icon(action.icon, size: 18),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            action.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );

    switch (action.style) {
      case _ActionStyle.text:
        return TextButton(
          onPressed: action.onPressed,
          style: _getTextButtonStyle(semanticColor),
          child: buttonContent,
        );
      case _ActionStyle.primary:
      case _ActionStyle.secondary:
      case _ActionStyle.destructive:
        return ElevatedButton(
          onPressed: action.onPressed,
          style: _getButtonStyle(action.style, semanticColor),
          child: buttonContent,
        );
    }
  }

  // Helper method to determine if buttons should be stacked vertically
  bool _shouldStackButtons() {
    if (widget.secondaryAction == null) return false;

    // Calculate approximate text width for both buttons
    final primaryTextLength = widget.primaryAction.label.length;
    final secondaryTextLength = widget.secondaryAction!.label.length;

    // Stack vertically if either button text is long or combined length is too much
    return primaryTextLength > 12 ||
        secondaryTextLength > 12 ||
        (primaryTextLength + secondaryTextLength) > 20;
  }

  ButtonStyle _getButtonStyle(_ActionStyle style, Color semanticColor) {
    switch (style) {
      case _ActionStyle.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: semanticColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: semanticColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      case _ActionStyle.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: semanticColor,
          elevation: 0,
          side: BorderSide(color: semanticColor.withValues(alpha: 0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      case _ActionStyle.destructive:
        return ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53E3E),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      case _ActionStyle.text:
        // This case should not be reached as text buttons use _getTextButtonStyle
        return TextButton.styleFrom(
          foregroundColor: semanticColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
    }
  }

  ButtonStyle _getTextButtonStyle(Color semanticColor) {
    return TextButton.styleFrom(
      foregroundColor: semanticColor,
      backgroundColor: semanticColor.withValues(alpha: 0.08),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      overlayColor: semanticColor.withValues(alpha: 0.12),
    );
  }
}
