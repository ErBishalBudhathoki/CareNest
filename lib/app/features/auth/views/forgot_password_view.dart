import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/auth/views/verify_otp_view.dart';
import 'package:carenest/app/features/auth/widgets/enhanced_auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import 'package:carenest/app/features/auth/viewmodels/forgot_password_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize pulse animation
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: colorScheme.surface,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BauhausIconButton(
            icon: Iconsax.arrow_left,
            onPressed: () => Navigator.of(context).pop(),
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Consumer(
            builder: (context, ref, child) {
              // Keep the autoDispose view model alive for as long as this screen
              // is mounted. A bare ref.read() leaves it with no listeners, so it
              // is disposed straight away and rebuilt with a fresh, empty text
              // controller on the next rebuild — which happens whenever the
              // keyboard opens or closes (this build reads MediaQuery).
              ref.watch(forgotPasswordViewModelProvider);
              final viewModel = ref.read(
                forgotPasswordViewModelProvider.notifier,
              );
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    _buildHeader(context),

                    const SizedBox(height: 48),

                    // Form Section
                    _buildForm(context, viewModel, isSmallScreen),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Animated Icon - Centered and Bigger
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: BauhausDesign.secondary.withValues(alpha: 0.1),
                    border: Border.all(
                      color: BauhausDesign.secondary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: BauhausDesign.secondary.withValues(alpha: 0.15),
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Iconsax.key,
                    color: BauhausDesign.secondary,
                    size: 48,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),

          // Title
          Text(
            AppLocalizations.of(context)!.forgotPasswordHeader,
            textAlign: TextAlign.center,
            style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            AppLocalizations.of(context)!.forgotPasswordSubtitle,
            textAlign: TextAlign.center,
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    ForgotPasswordViewModel viewModel,
    bool isSmallScreen,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Field
          BauhausTextField(
            controller: viewModel.model.emailController,
            label: AppLocalizations.of(context)!.emailAddressLabel,
            hintText: AppLocalizations.of(context)!.enterEmailHint,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(Iconsax.sms, color: colorScheme.onSurfaceVariant),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.emailRequired;
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return AppLocalizations.of(context)!.emailInvalid;
              }
              return null;
            },
          ),

          const SizedBox(height: 32),

          // Send Button
          BauhausActionButton(
            text: AppLocalizations.of(context)!.sendVerificationCode,
            icon: Iconsax.send_1,
            isLoading: viewModel.isLoading,
            onPressed: () => _sendVerificationCode(context, viewModel),
            variant: BauhausActionVariant.primary,
            isFullWidth: true,
          ),

          const SizedBox(height: 24),

          // Back to Login
          _buildBackToLogin(context),
        ],
      ),
    );
  }

  Widget _buildBackToLogin(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: RichText(
          text: TextSpan(
            text: '${AppLocalizations.of(context)!.rememberPassword} ',
            style: BauhausDesign.getTextTheme(
              context,
            ).bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.loginLink,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendVerificationCode(
    BuildContext context,
    ForgotPasswordViewModel viewModel,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Drop the keyboard so the loading state in the button (and the dialog that
    // follows) is not hidden behind it.
    FocusScope.of(context).unfocus();

    await viewModel.resetPassword(context, (response) async {
      if (!mounted) return;

      final email = viewModel.model.emailController.text.trim();
      final message =
          response['message']?.toString() ??
          'If an account with this email exists, a password reset code has been sent.';

      // A dialog rather than a snackbar: the send takes a few seconds, and the
      // confirmation needs to stay on screen until the user has read it.
      await EnhancedAuthDialog.showSuccessDialog(
        context,
        title: 'Check your email',
        message: message,
        actionLabel: 'Enter code',
        onAction: () {
          if (!mounted) return;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => VerifyOTPView(email: email)),
          );
        },
      );
    });
  }
}
