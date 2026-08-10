import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/firebase_auth_provider.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class BauhausLoginView extends ConsumerStatefulWidget {
  const BauhausLoginView({super.key});

  @override
  ConsumerState<BauhausLoginView> createState() => _BauhausLoginViewState();
}

class _BauhausLoginViewState extends ConsumerState<BauhausLoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = ref.read(firebaseAuthServiceProvider);
      final apiMethod = ref.read(apiMethodProvider);

      // 1. Sign in with Firebase
      final credential = await authService.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (credential.user == null) {
        throw Exception('Login failed: No user returned');
      }

      // 2. Sync with backend
      final response = await apiMethod.post(
        'firebase-auth/sync',
        body: {
          'firebaseUid': credential.user!.uid,
          'email': credential.user!.email,
        },
      );

      if (response['success'] == true) {
        // 3. Save user data locally
        final userData = response['data'];
        final prefs = ref.read(sharedPreferencesProvider);
        await prefs.setString('userEmail', userData['email'] ?? '');
        await prefs.setString('userId', userData['_id'] ?? '');
        await prefs.setString('firebaseUid', userData['firebaseUid'] ?? '');
        await prefs.setString(
          'organizationId',
          userData['organizationId'] ?? '',
        );
        await prefs.setString('role', userData['role'] ?? 'user');

        // 4. Navigate based on role
        if (mounted) {
          final role = userData['role'] ?? 'user';
          if (role == 'admin' || role == 'superadmin') {
            Navigator.pushReplacementNamed(
              context,
              '/admin',
              arguments: {
                'email': userData['email'],
                'organizationId': userData['organizationId'],
                'organizationName': userData['organizationName'],
                'organizationCode': userData['organizationCode'],
              },
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              '/home',
              arguments: {'email': userData['email']},
            );
          }
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
    if (error.contains('user-not-found')) {
      return 'No account found with this email';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password';
    } else if (error.contains('invalid-email')) {
      return 'Invalid email address';
    } else if (error.contains('user-disabled')) {
      return 'This account has been disabled';
    } else if (error.contains('too-many-requests')) {
      return 'Too many attempts. Please try again later';
    } else if (error.contains('network')) {
      return 'Network error. Please check your connection';
    }
    return 'Login failed. Please try again';
  }

  @override
  Widget build(BuildContext context) {
    // Bauhaus Palette
    const colorRed = BauhausDesign.primary;
    const colorBlue = BauhausDesign.secondary;
    const colorYellow = BauhausDesign.accent;
    const colorBlack = BauhausDesign.neutral;
    const colorWhite = BauhausDesign.backgroundLight;

    return Scaffold(
      backgroundColor: colorWhite,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: colorBlue))
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    // Geometric Background Shapes
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          color: colorYellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: -50,
                      child: Transform.rotate(
                        angle: 0.5,
                        child: Container(
                          width: 300,
                          height: 100,
                          color: colorRed,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 150,
                        color: colorBlue.withValues(alpha: 0.16),
                      ),
                    ),

                    // Login Form
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        margin: const EdgeInsets.all(24),
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: colorBlack, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: colorBlack,
                              offset: Offset(8, 8),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LOGIN',
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: colorBlack,
                                      letterSpacing: 2,
                                    ),
                              ),
                              const SizedBox(height: 32),
                              if (_errorMessage != null)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 24),
                                  decoration: BoxDecoration(
                                    color: colorRed.withValues(alpha: 0.1),
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
                              _buildBauhausTextField(
                                controller: _emailController,
                                label: 'EMAIL',
                                icon: Icons.email_outlined,
                              ),
                              const SizedBox(height: 24),
                              _buildBauhausTextField(
                                controller: _passwordController,
                                label: 'PASSWORD',
                                icon: Icons.lock_outline,
                                isObscure: true,
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: _onLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorRed,
                                    foregroundColor: BauhausDesign.surfaceWhite,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.zero, // Sharp corners
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'AUTHENTICATE',
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
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildBauhausTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
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
            color: BauhausDesign.textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          style: const TextStyle(color: BauhausDesign.textDark),
          cursorColor: BauhausDesign.primary,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: BauhausDesign.textMuted),
            filled: true,
            fillColor: BauhausDesign.surfaceWhite,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.neutral, width: 1),
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: BauhausDesign.neutral,
                width: 1,
              ),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.primary, width: 2),
              borderRadius: BorderRadius.zero,
            ),
          ),
          validator: (value) {
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
