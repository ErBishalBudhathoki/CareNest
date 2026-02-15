import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/core/providers/firebase_auth_provider.dart';
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
    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: BauhausDesign.backgroundLight,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
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
              final viewModel = ref.watch(forgotPasswordViewModelProvider);
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
                    color: BauhausDesign.secondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: BauhausDesign.secondary.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: BauhausDesign.secondary.withOpacity(0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
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
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            AppLocalizations.of(context)!.forgotPasswordSubtitle,
            textAlign: TextAlign.center,
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, ForgotPasswordViewModel viewModel,
      bool isSmallScreen) {
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
            prefixIcon: Icon(Iconsax.sms, color: BauhausDesign.textMuted),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.emailRequired;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
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
    return Center(
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: RichText(
          text: TextSpan(
            text: '${AppLocalizations.of(context)!.rememberPassword} ',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
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
      BuildContext context, ForgotPasswordViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      // Use Firebase password reset instead of custom OTP
      final authService = ref.read(firebaseAuthServiceProvider);

      await authService.sendPasswordResetEmail(
        email: viewModel.model.emailController.text.trim(),
      );

      if (mounted) {
        // Show Bauhaus-styled success dialog
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(
                  color: BauhausDesign.success,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: BauhausDesign.neutral,
                    offset: const Offset(8, 8),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: BauhausDesign.success.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: BauhausDesign.success,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Iconsax.tick_circle,
                      color: BauhausDesign.success,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Password Reset Email Sent',
                    textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(context)
                        .headlineSmall
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Check your email for a link to reset your password. If it doesn\'t appear within a few minutes, check your spam folder.',
                    textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 32),
                  BauhausActionButton(
                    text: 'Back to Login',
                    icon: Iconsax.arrow_left,
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Go back to login
                    },
                    variant: BauhausActionVariant.primary,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        // Show Bauhaus-styled error dialog
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(
                  color: BauhausDesign.error,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: BauhausDesign.neutral,
                    offset: const Offset(8, 8),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: BauhausDesign.error.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: BauhausDesign.error,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Iconsax.close_circle,
                      color: BauhausDesign.error,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Failed to Send Email',
                    textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(context)
                        .headlineSmall
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getFriendlyErrorMessage(e.toString()),
                    textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 32),
                  BauhausActionButton(
                    text: 'Try Again',
                    icon: Iconsax.refresh,
                    onPressed: () => Navigator.of(context).pop(),
                    variant: BauhausActionVariant.primary,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
  }

  String _getFriendlyErrorMessage(String error) {
    if (error.contains('user-not-found')) {
      return 'No account found with this email address';
    } else if (error.contains('invalid-email')) {
      return 'Invalid email address';
    } else if (error.contains('network')) {
      return 'Network error. Please check your connection';
    }
    return 'An error occurred. Please try again';
  }
}
