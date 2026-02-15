import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  final String? resetEmail;
  final String? resetOtp;

  const ChangePasswordView({
    super.key,
    this.resetEmail,
    this.resetOtp,
  });

  bool get isResetFlow =>
      resetEmail != null &&
      resetEmail!.isNotEmpty &&
      resetOtp != null &&
      resetOtp!.isNotEmpty;

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final l10n = AppLocalizations.of(context)!;

    try {
      final api = ref.read(apiMethodProvider);
      late final Map<String, dynamic> response;

      if (widget.isResetFlow) {
        response = await api.resetForgotPassword(
          email: widget.resetEmail!.trim(),
          otp: widget.resetOtp!.trim(),
          newPassword: _newController.text.trim(),
          confirmPassword: _confirmController.text.trim(),
        );
      } else {
        // Logged-in password change flow.
        response = await api.post('api/client-portal/auth/change-password', body: {
          'currentPassword': _currentController.text,
          'newPassword': _newController.text,
        });
      }

      final isSuccess = response['success'] == true || response['statusCode'] == 200;
      if (isSuccess) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.passwordUpdatedSuccess)),
          );
          final destination = widget.isResetFlow ? Routes.login : Routes.clientDashboard;
          Navigator.pushNamedAndRemoveUntil(
            context,
            destination,
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                response['message']?.toString() ?? l10n.somethingWentWrong,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        title: Text(widget.isResetFlow ? l10n.resetPassword : l10n.changePassword),
        automaticallyImplyLeading: false, // Force change
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.isResetFlow
                    ? l10n.resetPassword
                    : l10n.changePasswordTitle,
                style: BauhausDesign.getTextTheme(context).headlineMedium,
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                widget.isResetFlow
                    ? l10n.resetPasswordDesc
                    : l10n.changePasswordSubtitle,
              ),
              const SizedBox(height: BauhausDesign.space6),

              if (!widget.isResetFlow) ...[
                BauhausTextField(
                  controller: _currentController,
                  label: l10n.passwordLabel,
                  obscureText: true,
                  validator: (v) => v?.isEmpty == true ? l10n.required : null,
                ),
                const SizedBox(height: BauhausDesign.space4),
              ],

              BauhausTextField(
                controller: _newController,
                label: l10n.newPasswordHint,
                obscureText: true,
                validator: (v) => (v?.length ?? 0) < 8 ? l10n.passwordMinLength : null,
              ),
              const SizedBox(height: BauhausDesign.space4),
              
              BauhausTextField(
                controller: _confirmController,
                label: l10n.confirmPasswordHint,
                obscureText: true,
                validator: (v) {
                  if (v != _newController.text) return l10n.passwordsDoNotMatch;
                  return null;
                },
              ),
              const SizedBox(height: BauhausDesign.space6),
              
              BauhausActionButton(
                text: widget.isResetFlow ? l10n.resetPassword : l10n.changePassword,
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
