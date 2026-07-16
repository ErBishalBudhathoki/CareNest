import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class VerifyOTPView extends ConsumerStatefulWidget {
  final String email;

  const VerifyOTPView({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<VerifyOTPView> createState() => _VerifyOTPViewState();
}

class _VerifyOTPViewState extends ConsumerState<VerifyOTPView> {
  final _pinController = TextEditingController();
  bool _isResending = false;
  bool _isVerifying = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: BauhausDesign.backgroundLight,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildHeader(context),
              const SizedBox(height: 60),
              _buildOTPSection(context),
              const SizedBox(height: 40),
              _buildVerifyButton(context),
              const SizedBox(height: 24),
              _buildResendSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: BauhausDesign.accent.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: BauhausDesign.accent.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: BauhausDesign.accent.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Iconsax.shield_tick,
            size: 60,
            color: BauhausDesign.accent,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Enter reset code',
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          'We sent a 6-digit code to ${widget.email}.',
          style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                color: BauhausDesign.textMuted,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOTPSection(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
          ),
      decoration: BoxDecoration(
        color: BauhausDesign.backgroundLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 1,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(
          color: BauhausDesign.primary,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: BauhausDesign.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: BauhausDesign.surfaceWhite,
          ),
      decoration: defaultPinTheme.decoration!.copyWith(
        color: BauhausDesign.primary,
        border: Border.all(
          color: BauhausDesign.primary,
          width: 2,
        ),
      ),
    );

    return BauhausCard(
      child: Column(
        children: [
          Pinput(
            length: 6,
            controller: _pinController,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return BauhausActionButton(
      text: AppLocalizations.of(context)!.verifyCode,
      icon: Iconsax.tick_circle,
      isLoading: _isVerifying,
      isFullWidth: true,
      onPressed: _isVerifying ? null : _continueToResetPassword,
    );
  }

  Widget _buildResendSection(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.didntReceiveCode,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _isResending ? null : _resendOtp,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            AppLocalizations.of(context)!.resend,
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.primary,
                ),
          ),
        ),
      ],
    );
  }

  Future<void> _continueToResetPassword() async {
    final enteredOtp = _pinController.text.trim();
    if (enteredOtp.length != 6) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the 6-digit code.'),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    setState(() => _isVerifying = true);
    try {
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChangePasswordView(
            resetEmail: widget.email.trim(),
            resetOtp: enteredOtp,
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  Future<void> _resendOtp() async {
    setState(() => _isResending = true);
    try {
      final response =
          await ref.read(apiMethodProvider).sendOTP(widget.email.trim());
      if (!mounted) return;

      final success =
          response['success'] == true || response['statusCode'] == 200;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Password reset code sent.'
                : (response['message']?.toString() ??
                    AppLocalizations.of(context)!.somethingWentWrong),
          ),
          backgroundColor:
              success ? BauhausDesign.success : BauhausDesign.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }
}
