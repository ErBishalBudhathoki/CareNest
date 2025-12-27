import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/auth/viewmodels/login_viewmodel.dart';
import 'package:carenest/app/features/auth/widgets/auth_loading_indicator.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/app/shared/widgets/wave_animation_widget.dart';
import 'package:carenest/app/features/auth/widgets/debug_login_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = ref.watch(loginViewModelProvider);
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final isSmallScreen = size.height < 700;

    // Enhanced status bar styling for professional SaaS look
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.colorBackground,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: AuthLoadingOverlay(
        isLoading: loginViewModel.isLoading,
        loadingMessage: 'Signing you in...',
        child: Stack(
          children: [
            // Enhanced gradient background with subtle pattern
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.colorBackground,
                    AppColors.colorPrimary.withValues(alpha: 0.03),
                    AppColors.colorSecondary.withValues(alpha: 0.05),
                    AppColors.colorBackground,
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),

            // Subtle geometric patterns for SaaS aesthetic
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.colorPrimary.withValues(alpha: 0.06),
                      AppColors.colorPrimary.withValues(alpha: 0.02),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: -150,
              left: -100,
              child: Container(
                width: 250,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.colorSecondary.withValues(alpha: 0.04),
                      AppColors.colorSecondary.withValues(alpha: 0.01),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Full-screen animated header positioned absolutely
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildEnhancedHeader(isSmallScreen, size),
                ),
              ),
            ),

            // Main content with form positioned over the header
            Positioned(
              top: size.height * 0.32,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width > 600 ? 80 : 24,
                    right: size.width > 600 ? 80 : 24,
                    top: 0,
                    bottom: MediaQuery.of(context).padding.bottom + 24,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildEnhancedForm(
                          loginViewModel, isSmallScreen, size),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced header with animated flow design
  Widget _buildEnhancedHeader(bool isSmallScreen, Size size) {
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SizedBox(
      width: size.width,
      // MODIFICATION: Reduced header height to move the wave animation up
      height: size.height * 0.40,
      child: Stack(
        children: [
          // Gradient background with modern flow design
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.colorPrimary,
                    AppColors.colorSecondary,
                    AppColors.colorPrimary.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Decorative circles for modern UX
          Positioned(
            top: -50,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.colorWhite.withValues(alpha: 0.1),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.1,
            left: -40,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.colorWhite.withValues(alpha: 0.08),
              ),
            ),
          ),

          // Login text with better positioning and styling
          Positioned(
            top: size.height * 0.09,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: AppColors.colorWhite.withValues(alpha: 0.9),
                    fontSize: AppDimens.fontSizeLarge,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.colorWhite,
                    fontSize: isSmallScreen
                        ? AppDimens.fontSizeXLarge
                        : AppDimens.fontSizeXXMax,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Enhanced animated wave with better flow
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            bottom: keyboardOpen ? -size.height * 0.08 : 0.0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: size.height * 0.18,
              child: Stack(
                children: [
                  // Multiple wave layers for depth
                  WaveAnimation(
                    size: Size(size.width, size.height * 0.18),
                    yOffset: 40,
                    color: AppColors.colorWhite,
                  ),
                  Positioned(
                    top: 10,
                    child: WaveAnimation(
                      size: Size(size.width, size.height * 0.2),
                      yOffset: 30,
                      color: AppColors.colorWhite.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced form with modern glassmorphism design
  Widget _buildEnhancedForm(
      dynamic loginViewModel, bool isSmallScreen, Size size) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: size.width > 600 ? 420 : double.infinity,
      ),
      padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.colorWhite.withValues(alpha: 0.95),
            AppColors.colorWhite.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.colorPrimary.withValues(alpha: 0.12),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 32,
            offset: const Offset(0, 12),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: AppColors.colorPrimary.withValues(alpha: 0.08),
            blurRadius: 60,
            offset: const Offset(0, 24),
            spreadRadius: -12,
          ),
          BoxShadow(
            color: AppColors.colorSecondary.withValues(alpha: 0.04),
            blurRadius: 80,
            offset: const Offset(0, 32),
            spreadRadius: -16,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Enhanced email field
            _buildProfessionalTextField(
              controller: loginViewModel.model.emailController,
              label: 'Email address',
              hintText: 'Enter your email',
              icon: Iconsax.sms,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Email is required';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onChanged: (value) {
                loginViewModel.model.validateEmail(value);
              },
              isSmallScreen: isSmallScreen,
            ),

            SizedBox(height: 16),

            // Enhanced password field
            Consumer(
              builder: (context, ref, child) {
                final viewModel = ref.watch(loginViewModelProvider);
                return _buildProfessionalTextField(
                  controller: viewModel.model.passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  icon: Iconsax.lock,
                  isPassword: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  isSmallScreen: isSmallScreen,
                  loginViewModel: viewModel,
                );
              },
            ),

            SizedBox(height: 12),

            // Enhanced forgot password link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgotPassword');
                },
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.colorPrimary,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        AppColors.colorPrimary.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Enhanced login button
            _buildProfessionalButton(
              title: 'Sign in',
              isPrimary: true,
              isLoading: loginViewModel.isLoading,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await loginViewModel.login(context);
                }
              },
              isSmallScreen: isSmallScreen,
            ),

            SizedBox(height: 16),

            // Enhanced divider with modern design
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.colorFontSecondary.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.colorBackground.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.colorPrimary.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'or',
                    style: TextStyle(
                      color: AppColors.colorFontSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.colorFontSecondary.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Enhanced create account button
            _buildProfessionalButton(
              title: 'Create account',
              isPrimary: false,
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              isSmallScreen: isSmallScreen,
            ),

            SizedBox(height: 16),

            // Trust footer
            _buildTrustFooter(isSmallScreen),

            // Debug helper (only visible in debug mode)
            const DebugLoginHelper(),
          ],
        ),
      ),
    );
  }

  // Modern text field with enhanced design
  Widget _buildProfessionalTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    required String? Function(String?) validator,
    Function(String)? onChanged,
    bool isPassword = false,
    required bool isSmallScreen,
    ValueNotifier<bool>? obscureTextNotifier,
    TextInputType? keyboardType,
    LoginViewModel? loginViewModel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Enhanced label with icon
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.colorPrimary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                size: 14,
                color: AppColors.colorPrimary,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.colorFontPrimary,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        // Enhanced text field with glassmorphism
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.colorBackground.withValues(alpha: 0.6),
                AppColors.colorBackground.withValues(alpha: 0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.colorPrimary.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.colorPrimary.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: isPassword
                ? (loginViewModel != null
                    ? !loginViewModel.model.isVisible
                    : (obscureTextNotifier?.value ?? false))
                : false,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.colorFontPrimary,
              height: 1.4,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.colorFontSecondary.withValues(alpha: 0.6),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  icon,
                  color: AppColors.colorPrimary.withValues(alpha: 0.7),
                  size: 20,
                ),
              ),
              suffixIcon: isPassword
                  ? (loginViewModel != null
                      ? IconButton(
                          icon: Icon(
                            loginViewModel.model.isVisible
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                            color:
                                AppColors.colorPrimary.withValues(alpha: 0.7),
                            size: 20,
                          ),
                          onPressed: () {
                            loginViewModel.togglePasswordVisibility();
                          },
                        )
                      : (obscureTextNotifier != null
                          ? ValueListenableBuilder<bool>(
                              valueListenable: obscureTextNotifier,
                              builder: (context, isObscured, child) {
                                return IconButton(
                                  icon: Icon(
                                    isObscured
                                        ? Iconsax.eye_slash
                                        : Iconsax.eye,
                                    color: AppColors.colorPrimary
                                        .withValues(alpha: 0.7),
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    obscureTextNotifier.value =
                                        !obscureTextNotifier.value;
                                  },
                                );
                              },
                            )
                          : null))
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Modern button with enhanced design
  Widget _buildProfessionalButton({
    required String title,
    required bool isPrimary,
    required VoidCallback onPressed,
    required bool isSmallScreen,
    bool isLoading = false,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: isPrimary
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.colorPrimary,
                  AppColors.colorSecondary,
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.colorWhite.withValues(alpha: 0.8),
                  AppColors.colorBackground.withValues(alpha: 0.6),
                ],
              ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary
              ? AppColors.colorPrimary.withValues(alpha: 0.2)
              : AppColors.colorPrimary.withValues(alpha: 0.25),
          width: isPrimary ? 0 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? AppColors.colorPrimary.withValues(alpha: 0.3)
                : AppColors.colorPrimary.withValues(alpha: 0.08),
            blurRadius: isPrimary ? 20 : 12,
            offset: Offset(0, isPrimary ? 8 : 4),
            spreadRadius: isPrimary ? 0 : -2,
          ),
          if (isPrimary)
            BoxShadow(
              color: AppColors.colorSecondary.withValues(alpha: 0.2),
              blurRadius: 32,
              offset: const Offset(0, 12),
              spreadRadius: -8,
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: isLoading ? null : onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isPrimary
                            ? AppColors.colorWhite
                            : AppColors.colorPrimary,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isPrimary
                          ? AppColors.colorWhite.withValues(alpha: 0.15)
                          : AppColors.colorPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isPrimary ? Iconsax.login : Iconsax.user_add,
                      color: isPrimary
                          ? AppColors.colorWhite
                          : AppColors.colorPrimary,
                      size: 20,
                    ),
                  ),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: TextStyle(
                    color: isPrimary
                        ? AppColors.colorWhite
                        : AppColors.colorPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Enhanced trust footer with modern design
  Widget _buildTrustFooter(bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.colorBackground.withValues(alpha: 0.3),
            AppColors.colorBackground.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.colorPrimary.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.colorPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Iconsax.shield_tick,
                  size: 16,
                  color: AppColors.colorPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Secured with 256-bit SSL encryption',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.colorFontSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.colorPrimary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '© 2024 CareNest. All rights reserved.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.colorFontSecondary.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
