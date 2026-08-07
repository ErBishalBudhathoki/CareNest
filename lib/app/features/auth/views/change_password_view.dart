import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/core/providers/firebase_auth_provider.dart';
import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  final String? resetEmail;
  final String? resetOtp;
  final String? firebaseOobCode;

  const ChangePasswordView({
    super.key,
    this.resetEmail,
    this.resetOtp,
    this.firebaseOobCode,
  });

  bool get isOtpResetFlow =>
      resetEmail != null &&
      resetEmail!.isNotEmpty &&
      resetOtp != null &&
      resetOtp!.isNotEmpty;
  bool get isFirebaseResetFlow =>
      firebaseOobCode != null && firebaseOobCode!.isNotEmpty;
  bool get isResetFlow => isOtpResetFlow || isFirebaseResetFlow;

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isLoading = false;
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Map<String, bool> _passwordRuleState(String password) {
    final normalized = password.trim();
    return {
      'minLength': normalized.length >= 8,
      'uppercase': RegExp(r'[A-Z]').hasMatch(normalized),
      'number': RegExp(r'[0-9]').hasMatch(normalized),
      'special': RegExp(r'[^A-Za-z0-9]').hasMatch(normalized),
    };
  }

  bool _meetsAllPasswordRules(String password) {
    final rules = _passwordRuleState(password);
    return rules.values.every((isMet) => isMet);
  }

  String? _validateCurrentPassword(String? value) {
    if (widget.isResetFlow) return null;
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.required;
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    final password = value?.trim() ?? '';
    if (password.isEmpty) {
      return AppLocalizations.of(context)!.required;
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must include an uppercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must include a number.';
    }
    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(password)) {
      return 'Password must include a special character.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final confirm = value?.trim() ?? '';
    if (confirm.isEmpty) {
      return AppLocalizations.of(context)!.required;
    }
    if (confirm != _newController.text.trim()) {
      return AppLocalizations.of(context)!.passwordsDoNotMatch;
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final newPassword = _newController.text.trim();
    if (!_meetsAllPasswordRules(newPassword)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please satisfy all password requirements.'),
          backgroundColor: BauhausDesign.warning,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final l10n = AppLocalizations.of(context)!;
      final api = ref.read(apiMethodProvider);
      late final Map<String, dynamic> response;

      if (widget.isOtpResetFlow) {
        response = await api.resetForgotPassword(
          email: widget.resetEmail!.trim(),
          otp: widget.resetOtp!.trim(),
          newPassword: newPassword,
          confirmPassword: _confirmController.text.trim(),
        );
      } else if (widget.isFirebaseResetFlow) {
        final authService = ref.read(firebaseAuthServiceProvider);
        final code = widget.firebaseOobCode!.trim();

        await authService.verifyPasswordResetCode(code: code);
        await authService.confirmPasswordReset(
          code: code,
          newPassword: newPassword,
        );

        response = {
          'success': true,
          'statusCode': 200,
          'message': l10n.passwordUpdatedSuccess,
        };
      } else {
        response = await api.changeAuthenticatedPassword(
          currentPassword: _currentController.text.trim(),
          newPassword: newPassword,
        );
      }

      final isSuccess =
          response['success'] == true || response['statusCode'] == 200;
      if (isSuccess) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.passwordUpdatedSuccess),
            backgroundColor: BauhausDesign.success,
          ),
        );

        // Authenticated password change revokes Firebase refresh tokens on backend.
        // Force clean sign-out so user re-authenticates with the new password.
        if (!widget.isResetFlow) {
          await SessionTimeoutService().logoutAndClearSession(
            reason: 'password_changed',
          );
          if (!mounted) return;
        }

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                response['message']?.toString() ?? l10n.somethingWentWrong,
              ),
              backgroundColor: BauhausDesign.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pageTitle = widget.isResetFlow
        ? l10n.resetPassword
        : l10n.changePassword;
    final pageSubtitle = widget.isResetFlow
        ? l10n.resetPasswordDesc
        : l10n.changePasswordSubtitle;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: BauhausDesign.surfaceWhite,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(
          pageTitle.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
            color: BauhausDesign.surfaceWhite,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: BauhausDesign.neutral),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              BauhausDesign.space4,
              BauhausDesign.space4,
              BauhausDesign.space4,
              BauhausDesign.space8,
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeaderCard(title: pageTitle, subtitle: pageSubtitle),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildSectionCard(
                    title: 'PASSWORD DETAILS',
                    accentColor: BauhausDesign.primary,
                    children: [
                      if (!widget.isResetFlow) ...[
                        BauhausTextField(
                          controller: _currentController,
                          label: 'CURRENT PASSWORD',
                          hintText: 'Enter current password',
                          obscureText: !_showCurrentPassword,
                          validator: _validateCurrentPassword,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showCurrentPassword = !_showCurrentPassword;
                              });
                            },
                            icon: Icon(
                              _showCurrentPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                      ],
                      BauhausTextField(
                        controller: _newController,
                        label: 'NEW PASSWORD',
                        hintText: 'Enter new password',
                        obscureText: !_showNewPassword,
                        validator: _validateNewPassword,
                        prefixIcon: const Icon(Icons.key_outlined, size: 20),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showNewPassword = !_showNewPassword;
                            });
                          },
                          icon: Icon(
                            _showNewPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      BauhausTextField(
                        controller: _confirmController,
                        label: 'CONFIRM PASSWORD',
                        hintText: 'Re-enter new password',
                        obscureText: !_showConfirmPassword,
                        validator: _validateConfirmPassword,
                        prefixIcon: const Icon(
                          Icons.verified_user_outlined,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showConfirmPassword = !_showConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _showConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildSectionCard(
                    title: 'PASSWORD RULES',
                    accentColor: BauhausDesign.secondary,
                    children: [
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _newController,
                        builder: (context, value, _) {
                          final rules = _passwordRuleState(value.text);
                          return Column(
                            children: [
                              _buildRuleRow(
                                text: 'At least 8 characters',
                                isMet: rules['minLength'] ?? false,
                              ),
                              const SizedBox(height: BauhausDesign.space2),
                              _buildRuleRow(
                                text: 'At least one uppercase letter',
                                isMet: rules['uppercase'] ?? false,
                              ),
                              const SizedBox(height: BauhausDesign.space2),
                              _buildRuleRow(
                                text: 'At least one number',
                                isMet: rules['number'] ?? false,
                              ),
                              const SizedBox(height: BauhausDesign.space2),
                              _buildRuleRow(
                                text: 'At least one special character',
                                isMet: rules['special'] ?? false,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BauhausActionButton(
                        text: pageTitle.toUpperCase(),
                        isLoading: _isLoading,
                        onPressed: _isLoading ? null : _submit,
                        isFullWidth: true,
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      BauhausActionButton(
                        text: l10n.cancelButton.toUpperCase(),
                        isOutlined: true,
                        onPressed: _isLoading
                            ? null
                            : () => Navigator.of(context).maybePop(),
                        isFullWidth: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard({required String title, required String subtitle}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: BauhausDesign.secondary,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.security_rounded,
                    color: BauhausDesign.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).titleLarge
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        subtitle,
                        style: BauhausDesign.getTextTheme(context).bodySmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite.withOpacity(
                                0.92,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
              vertical: BauhausDesign.space3,
            ),
            decoration: const BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border(
                top: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Text(
              'SECURE PASSWORD UPDATE',
              style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                color: BauhausDesign.secondary,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Color accentColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 9,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(BauhausDesign.radiusLg - 2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: BauhausDesign.getTextTheme(context).labelLarge
                      ?.copyWith(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleRow({required String text, required bool isMet}) {
    final color = isMet ? BauhausDesign.success : BauhausDesign.textMuted;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral),
      ),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: color,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              text,
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
