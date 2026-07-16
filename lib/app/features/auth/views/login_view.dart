import 'package:carenest/app/core/providers/app_providers.dart';

import 'package:carenest/app/features/auth/widgets/auth_loading_indicator.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_liquid_animation.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

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
    ref.watch(loginViewModelProvider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.height < 700;

    // Enhanced status bar styling for professional SaaS look
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: BauhausDesign.backgroundLight,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: AuthLoadingOverlay(
        isLoading: loginViewModel.isLoading,
        loadingMessage: AppLocalizations.of(context)!.signingIn,
        child: Stack(
          children: [
            // Bauhaus background
            Container(
              color: BauhausDesign.backgroundLight,
            ),

            // Bauhaus liquid animation at the top (Header Background)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: BauhausLiquidAnimation(
                height: isSmallScreen ? size.height * 0.28 : size.height * 0.32,
                yOffset: isSmallScreen
                    ? size.height * 0.28
                    : size.height * 0.32, // Wave line between header and form
              ),
            ),

            // Bauhaus header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildEnhancedHeader(isSmallScreen, size),
            ),

            // Main content with form positioned over the header
            Positioned(
              top: isSmallScreen ? size.height * 0.30 : size.height * 0.35,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
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
    return Container(
      width: size.width,
      height: isSmallScreen ? size.height * 0.28 : size.height * 0.32,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
      child: Center(
        child: Container(
          width: size.width * 0.85,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.loginWelcome,
                style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                      color: BauhausDesign.neutral,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.loginTitle,
                style:
                    BauhausDesign.getTextTheme(context).displayMedium?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                        ),
              ),
            ],
          ),
        ),
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
      decoration: BauhausDesign.cardDecoration,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Enhanced email field
            BauhausTextField(
              controller: loginViewModel.model.emailController,
              label: AppLocalizations.of(context)!.emailLabel,
              hintText: AppLocalizations.of(context)!.emailHint,
              prefixIcon:
                  Icon(Iconsax.sms, color: BauhausDesign.textMuted, size: 20),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return AppLocalizations.of(context)!.emailRequired;
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return AppLocalizations.of(context)!.emailInvalid;
                }
                return null;
              },
              onChanged: (value) {
                loginViewModel.model.validateEmail(value);
              },
            ),

            SizedBox(height: isSmallScreen ? 12 : 16),

            // Enhanced password field
            Consumer(
              builder: (context, ref, child) {
                ref.watch(loginViewModelProvider);
              final viewModel = ref.read(loginViewModelProvider.notifier);
                return BauhausTextField(
                  controller: viewModel.model.passwordController,
                  label: AppLocalizations.of(context)!.passwordLabel,
                  hintText: AppLocalizations.of(context)!.passwordHint,
                  prefixIcon: Icon(Iconsax.lock,
                      color: BauhausDesign.textMuted, size: 20),
                  obscureText: !viewModel.model.isVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.model.isVisible
                          ? Iconsax.eye
                          : Iconsax.eye_slash,
                      color: BauhausDesign.textMuted,
                      size: 20,
                    ),
                    onPressed: () {
                      viewModel.togglePasswordVisibility();
                    },
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return AppLocalizations.of(context)!.passwordRequired;
                    }
                    return null;
                  },
                );
              },
            ),

            SizedBox(height: isSmallScreen ? 8 : 12),

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
                  AppLocalizations.of(context)!.forgotPassword,
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(
                        color: BauhausDesign.primary,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: BauhausDesign.primary.withOpacity(0.6),
                      ),
                ),
              ),
            ),

            SizedBox(height: isSmallScreen ? 12 : 16),

            // Enhanced login button
            BauhausActionButton(
              text: AppLocalizations.of(context)!.signInButton,
              variant: BauhausActionVariant.primary,
              isLoading: loginViewModel.isLoading,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await loginViewModel.login(context);
                }
              },
              icon: Iconsax.login,
              backgroundColor: BauhausDesign.accent,
              textColor: BauhausDesign.neutral,
            ),

            SizedBox(height: isSmallScreen ? 12 : 16),

            // Bauhaus divider with bold design
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: BauhausDesign.neutral,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    border: Border.all(
                      color: BauhausDesign.neutral,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.or,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.neutral,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: BauhausDesign.neutral,
                  ),
                ),
              ],
            ),

            SizedBox(height: isSmallScreen ? 12 : 16),

            // Enhanced create account button
            BauhausActionButton(
              text: AppLocalizations.of(context)!.createAccount,
              variant: BauhausActionVariant.secondary,
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              icon: Iconsax.user_add,
              backgroundColor: BauhausDesign.backgroundLight,
              textColor: BauhausDesign.neutral,
              isOutlined: false, // Custom style
            ),

            SizedBox(height: isSmallScreen ? 12 : 16),

            // Trust footer
            _buildTrustFooter(isSmallScreen),
          ],
        ),
      ),
    );
  }

  // Bauhaus trust footer with geometric design
  Widget _buildTrustFooter(bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bauhaus geometric icon container
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BauhausDesign.success,
                  border: Border.all(
                    color: BauhausDesign.neutral,
                    width: 2,
                  ),
                  boxShadow: const [BauhausDesign.shadowHardSm],
                ),
                child: Icon(
                  Iconsax.shield_tick,
                  size: 16,
                  color: BauhausDesign.surfaceWhite,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  AppLocalizations.of(context)!.securedWith256Bit,
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: BauhausDesign.fontXxs,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Bauhaus copyright container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: BauhausDesign.backgroundLight,
              border: Border.all(
                color: BauhausDesign.neutral,
                width: 2,
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.copyright,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: BauhausDesign.fontXxs,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
