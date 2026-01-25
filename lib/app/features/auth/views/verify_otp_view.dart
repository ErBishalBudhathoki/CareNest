import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/auth/widgets/enhanced_auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class VerifyOTPView extends ConsumerWidget {
  final String otpGenerated;
  final String encryptVerificationKey;

  const VerifyOTPView({
    super.key,
    required this.otpGenerated,
    required this.encryptVerificationKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(verifyOTPViewModelProvider);

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
              _buildOTPSection(context, viewModel),
              const SizedBox(height: 40),
              _buildVerifyButton(context, viewModel),
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
          AppLocalizations.of(context)!.verifyOtpTitle,
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          AppLocalizations.of(context)!.weSentCode,
          style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                color: BauhausDesign.textMuted,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOTPSection(BuildContext context, dynamic viewModel) {
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
            controller: viewModel.pinController,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context, dynamic viewModel) {
    return BauhausActionButton(
      text: AppLocalizations.of(context)!.verifyCode,
      icon: Iconsax.tick_circle,
      isLoading: viewModel.isLoading,
      isFullWidth: true,
      onPressed: () async {
        debugPrint('Verify button pressed');
        await viewModel.verifyOTP(
          viewModel.pinController.text,
          otpGenerated,
          encryptVerificationKey,
          context,
          (message) => EnhancedAuthDialog.showErrorDialog(
            context,
            title: AppLocalizations.of(context)!.warning,
            message: message,
          ),
        );

        if (viewModel.response?['statusCode'] == 200) {
          viewModel.dispose();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (newContext) => const ChangePasswordView(),
            ),
            (route) => false,
          );
        }
      },
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
          onPressed: () {
            // Add resend logic here
          },
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
}
