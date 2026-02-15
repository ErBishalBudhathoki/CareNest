import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/auth/providers/auth_provider.dart';

class BauhausSignupView extends ConsumerStatefulWidget {
  const BauhausSignupView({super.key});

  @override
  ConsumerState<BauhausSignupView> createState() => _BauhausSignupViewState();
}

class _BauhausSignupViewState extends ConsumerState<BauhausSignupView> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Real-time validation state
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

  void _onRegister() async {
    if (_formKey.currentState!.validate()) {
      if (!(_hasMinLength && _hasUppercase && _hasNumber && _hasSpecial)) {
        return; // Visual validation fallback
      }

      try {
        await ref.read(authStateProvider.notifier).register(
              _emailController.text.trim(),
              _passwordController.text.trim(),
              _firstNameController.text.trim(),
              _lastNameController.text.trim(),
            );
        if (mounted) {
          Navigator.of(context).pop(); // Go back to login
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registration successful! Please login.')),
          );
        }
      } catch (e) {
        // Error handled in state?
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const colorRed = Color(0xFFD62D24);
    const colorBlue = Color(0xFF1E5AA8);
    const colorYellow = Color(0xFFFFD100);
    const colorBlack = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
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
                Text(
                  'JOIN US',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorBlack,
                      ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _buildBauhausTextField(
                        controller: _firstNameController,
                        label: 'FIRST NAME',
                        icon: Icons.person_outline,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildBauhausTextField(
                        controller: _lastNameController,
                        label: 'LAST NAME',
                        icon: Icons.person_outline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildBauhausTextField(
                    controller: _emailController,
                    label: 'EMAIL',
                    icon: Icons.email_outlined,
                    inputType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                _buildBauhausTextField(
                  controller: _passwordController,
                  label: 'PASSWORD',
                  icon: Icons.lock_outline,
                  isObscure: true,
                  onChanged: _updatePasswordStrength,
                ),
                const SizedBox(height: 8),
                _buildPasswordValidationIndicators(),
                const SizedBox(height: 16),
                _buildBauhausTextField(
                    controller: _confirmPasswordController,
                    label: 'CONFIRM PASSWORD',
                    icon: Icons.lock_outline,
                    isObscure: true,
                    validator: (val) {
                      if (val != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    }),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorBlue,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        Icon(
          met ? Icons.check_circle : Icons.cancel_outlined,
          color: met ? colorGreen : colorRed,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: met ? colorGreen : colorRed,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildBauhausTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    TextInputType? inputType,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          keyboardType: inputType,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black),
            filled: true,
            fillColor: Colors.grey[100],
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.zero,
            ),
          ),
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return '$label is required';
                }
                return null;
              },
        ),
      ],
    );
  }
}
