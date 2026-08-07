import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/firebase_auth_provider.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

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
  final _orgCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

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

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!(_hasMinLength && _hasUppercase && _hasNumber && _hasSpecial)) {
      setState(() {
        _errorMessage = 'Password does not meet requirements';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = ref.read(firebaseAuthServiceProvider);
      final apiMethod = ref.read(apiMethodProvider);

      // 1. Create Firebase user
      final credential = await authService.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (credential.user == null) {
        throw Exception('Signup failed: No user returned');
      }

      // 2. Update display name
      await authService.updateDisplayName(
        '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
      );

      // 3. Send email verification
      await authService.sendEmailVerification();

      // 4. Sync with backend
      final response = await apiMethod.post(
        'firebase-auth/sync',
        body: {
          'firebaseUid': credential.user!.uid,
          'email': credential.user!.email,
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'organizationCode': _orgCodeController.text.trim(),
        },
      );

      if (response['success'] == true) {
        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Account created! Please verify your email and login.',
              ),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate back to login
          Navigator.pop(context);
        }
      } else {
        throw Exception(response['message'] ?? 'Backend sync failed');
      }
    } catch (e) {
      setState(() {
        _errorMessage = _getFriendlyErrorMessage(e.toString());
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getFriendlyErrorMessage(String error) {
    if (error.contains('email-already-in-use')) {
      return 'An account with this email already exists';
    } else if (error.contains('invalid-email')) {
      return 'Invalid email address';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak';
    } else if (error.contains('network')) {
      return 'Network error. Please check your connection';
    }
    return 'Signup failed. Please try again';
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: colorBlue))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'JOIN US',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colorBlack,
                            ),
                      ),
                      const SizedBox(height: 32),
                      if (_errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: colorRed.withOpacity(0.1),
                            border: Border.all(color: colorRed),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: colorRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      _buildBauhausTextField(
                        controller: _orgCodeController,
                        label: 'ORGANIZATION CODE',
                        icon: Icons.business_outlined,
                        inputType: TextInputType.text,
                      ),
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
                        },
                      ),
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
          style: TextStyle(color: met ? colorGreen : colorRed, fontSize: 12),
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
          validator:
              validator ??
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
