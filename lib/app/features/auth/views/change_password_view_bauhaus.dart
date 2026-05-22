import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/auth/providers/auth_provider.dart';

class BauhausChangePasswordView extends ConsumerStatefulWidget {
  final bool isForced; // If true, hide back button

  const BauhausChangePasswordView({super.key, this.isForced = false});

  @override
  ConsumerState<BauhausChangePasswordView> createState() =>
      _BauhausChangePasswordViewState();
}

class _BauhausChangePasswordViewState
    extends ConsumerState<BauhausChangePasswordView> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecial = false;

  void _updatePasswordStrength(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecial = password.contains(RegExp(r'[^A-Za-z0-9]'));
    });
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (!(_hasMinLength && _hasUppercase && _hasNumber && _hasSpecial)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please meet all password requirements')),
        );
        return;
      }

      try {
        await ref.read(authStateProvider.notifier).changePassword(
              _currentPasswordController.text.trim(),
              _newPasswordController.text.trim(),
            );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password changed successfully')),
          );
          if (widget.isForced) {
            // Usually we might navigate to dashboard, but here we just pop or stay
            // Since AuthState should be updated to authenticated (if we were previously authenticated)
            // We might need to refresh user or similar
          } else {
            Navigator.of(context).pop();
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const colorRed = Color(0xFFD62D24);
    const colorBlack = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('CHANGE PASSWORD',
            style: TextStyle(color: colorBlack, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: !widget.isForced,
        leading: widget.isForced
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: colorBlack),
                onPressed: () => Navigator.of(context).pop(),
              ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isForced)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: colorRed.withOpacity(0.1),
                      border: Border.all(color: colorRed),
                    ),
                    child: const Text(
                      'Security Alert: Your password is weak or compromised. You must change it to continue.',
                      style: TextStyle(
                          color: colorRed, fontWeight: FontWeight.bold),
                    ),
                  ),
                _buildBauhausTextField(
                  controller: _currentPasswordController,
                  label: 'CURRENT PASSWORD',
                  icon: Icons.lock_outline,
                  isObscure: true,
                ),
                const SizedBox(height: 16),
                _buildBauhausTextField(
                  controller: _newPasswordController,
                  label: 'NEW PASSWORD',
                  icon: Icons.lock_reset,
                  isObscure: true,
                  onChanged: _updatePasswordStrength,
                ),
                const SizedBox(height: 8),
                _buildPasswordValidationIndicators(),
                const SizedBox(height: 16),
                _buildBauhausTextField(
                    controller: _confirmPasswordController,
                    label: 'CONFIRM NEW PASSWORD',
                    icon: Icons.lock_reset,
                    isObscure: true,
                    validator: (val) {
                      if (val != _newPasswordController.text)
                        return 'Passwords do not match';
                      return null;
                    }),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorBlack,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    child: const Text('UPDATE PASSWORD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reuse validation widget logic if possible, simplified here
  Widget _buildPasswordValidationIndicators() {
    return Column(
      children: [
        _buildIndicator('At least 8 characters', _hasMinLength),
        _buildIndicator('Contains uppercase letter', _hasUppercase),
        _buildIndicator('Contains number', _hasNumber),
        _buildIndicator('Contains special character', _hasSpecial),
      ],
    );
  }

  Widget _buildIndicator(String text, bool met) {
    const colorGreen = Color(0xFF008f39);
    const colorRed = Color(0xFFD62D24);
    return Row(
      children: [
        Icon(met ? Icons.check_circle : Icons.cancel_outlined,
            color: met ? colorGreen : colorRed, size: 16),
        const SizedBox(width: 8),
        Text(text,
            style: TextStyle(color: met ? colorGreen : colorRed, fontSize: 12)),
      ],
    );
  }

  Widget _buildBauhausTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black),
            filled: true,
            fillColor: Colors.grey[100],
            border: const OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: BorderRadius.zero),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.zero),
          ),
          validator: validator ??
              (value) => value!.isEmpty ? '$label is required' : null,
        ),
      ],
    );
  }
}
