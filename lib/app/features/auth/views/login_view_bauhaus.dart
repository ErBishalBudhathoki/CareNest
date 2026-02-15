import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/auth/providers/auth_provider.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

import 'package:carenest/app/features/auth/views/change_password_view_bauhaus.dart';

class BauhausLoginView extends ConsumerStatefulWidget {
  const BauhausLoginView({super.key});

  @override
  ConsumerState<BauhausLoginView> createState() => _BauhausLoginViewState();
}

class _BauhausLoginViewState extends ConsumerState<BauhausLoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      ref.read(authStateProvider.notifier).login(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    // Redirection Logic
    if (authState.requiresPasswordChange) {
      // Use Future.microtask to avoid build-phase navigation
      Future.microtask(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => const BauhausChangePasswordView(isForced: true)));
      });
    }

    // Bauhaus Palette
    const colorRed = BauhausDesign.primary;
    const colorBlue = BauhausDesign.secondary;
    const colorYellow = BauhausDesign.accent;
    const colorBlack = BauhausDesign.neutral;
    const colorWhite = BauhausDesign.backgroundLight;

    return Scaffold(
      backgroundColor: colorWhite,
      body: authState.status == AuthStatus.loading
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
                        color: colorBlue.withOpacity(0.16),
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
                            )
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: colorBlack,
                                      letterSpacing: 2,
                                    ),
                              ),
                              const SizedBox(height: 32),
                              if (authState.errorMessage != null)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 24),
                                  decoration: BoxDecoration(
                                    color: colorRed.withOpacity(0.1),
                                    border: Border.all(color: colorRed),
                                  ),
                                  child: Text(
                                    authState.errorMessage!,
                                    style: const TextStyle(
                                        color: colorRed,
                                        fontWeight: FontWeight.bold),
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
              borderSide:
                  const BorderSide(color: BauhausDesign.neutral, width: 1),
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
