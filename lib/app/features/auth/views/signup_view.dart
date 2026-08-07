import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/alert_dialog_widget.dart';
import 'package:carenest/app/shared/widgets/bauhaus_liquid_animation.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/flushbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class SignUpView extends ConsumerStatefulWidget {
  final String? prefilledOrgCode;

  const SignUpView({super.key, this.prefilledOrgCode});

  @override
  ConsumerState<SignUpView> createState() {
    return _SignUpViewState();
  }
}

class _SignUpViewState extends ConsumerState<SignUpView>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(
    debugLabel: 'signup_scaffold_key',
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(
    debugLabel: 'signup_form_key',
  );

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Password visibility state
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: BauhausDesign.surfaceLight,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _fadeController.forward();
    _slideController.forward();

    // Pre-fill organization code if provided
    if (widget.prefilledOrgCode != null &&
        widget.prefilledOrgCode!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(signupViewModelProvider.notifier)
            .prefillOrganizationCode(widget.prefilledOrgCode!);
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topInset = MediaQuery.of(context).padding.top;
    final horizontalPadding = size.width > 600 ? 80.0 : 24.0;
    FlushBarWidget flushBarWidget = FlushBarWidget();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BauhausDesign.backgroundLight,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              pinned: true,
              stretch: true,
              expandedHeight: 300,
              elevation: 0,
              scrolledUnderElevation: 0,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              backgroundColor: BauhausDesign.backgroundLight,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BauhausIconButton(
                  icon: Iconsax.arrow_left,
                  onPressed: () => Navigator.pop(context),
                  variant: BauhausActionVariant.neutral,
                  isSmall: true,
                ),
              ),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final minHeight = kToolbarHeight + topInset;
                  final maxHeight = 300 + topInset;
                  final currentHeight = constraints.maxHeight;
                  final bool isCollapsed = currentHeight <= minHeight + 2;

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(color: BauhausDesign.backgroundLight),
                      if (!isCollapsed)
                        IgnorePointer(
                          child: BauhausLiquidAnimation(
                            height: maxHeight + 24,
                            yOffset: maxHeight * 0.58,
                          ),
                        ),
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 20,
                        child: Visibility(
                          visible: !isCollapsed,
                          child: _buildHeader(),
                        ),
                      ),
                      if (isCollapsed)
                        Positioned(
                          top: topInset + 12,
                          left: 72,
                          right: 72,
                          child: IgnorePointer(
                            child: Container(
                              color: BauhausDesign.backgroundLight,
                              child: Text(
                                AppLocalizations.of(context)!.signupTitle,
                                textAlign: TextAlign.center,
                                style: BauhausDesign.getTextTheme(context)
                                    .titleMedium
                                    ?.copyWith(
                                      color: BauhausDesign.textDark,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final signupViewModel = ref.watch(
                          signupViewModelProvider,
                        );
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            _buildSignupForm(signupViewModel, flushBarWidget),
                            const SizedBox(height: 24),
                            _buildLoginLink(),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom + 20,
                            ),
                          ],
                        );
                      },
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

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: BauhausDesign.secondary,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Icon(
            Iconsax.user_add,
            color: BauhausDesign.surfaceLight,
            size: 36,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          AppLocalizations.of(context)!.signupTitle,
          style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.signupSubtitle,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
            color: BauhausDesign.neutral,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSignupForm(
    dynamic signupViewModel,
    FlushBarWidget flushBarWidget,
  ) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BauhausDesign.cardDecoration,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPersonalInfo(signupViewModel),
            const SizedBox(height: 24),
            _buildRoleSelection(signupViewModel),
            const SizedBox(height: 24),
            if (signupViewModel.model.selectedRole == 'admin') ...[
              _buildOrganizationCreation(signupViewModel),
              const SizedBox(height: 20),
            ],
            _buildOrganizationJoin(signupViewModel),
            const SizedBox(height: 24),
            _buildPasswordSection(signupViewModel),
            const SizedBox(height: 32),
            _buildSignupButton(signupViewModel, flushBarWidget),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(dynamic signupViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.personalInfoSection,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: BauhausTextField(
                controller: signupViewModel.model.firstNameController,
                label: AppLocalizations.of(context)!.firstNameHint,
                hintText: 'John',
                prefixIcon: Icon(Iconsax.user, color: BauhausDesign.textMuted),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.firstNameRequired;
                  }
                  return null;
                },
                onChanged: (value) {
                  signupViewModel.model.firstNameController.text = value;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BauhausTextField(
                controller: signupViewModel.model.lastNameController,
                label: AppLocalizations.of(context)!.lastNameHint,
                hintText: 'Doe',
                prefixIcon: Icon(Iconsax.user, color: BauhausDesign.textMuted),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.lastNameRequired;
                  }
                  return null;
                },
                onChanged: (value) {
                  signupViewModel.model.lastNameController.text = value;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        BauhausTextField(
          controller: signupViewModel.model.emailController,
          label: AppLocalizations.of(context)!.emailLabel,
          hintText: 'john@example.com',
          prefixIcon: Icon(Iconsax.sms, color: BauhausDesign.textMuted),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                !value.contains('@') ||
                !value.contains('.')) {
              return AppLocalizations.of(context)!.emailInvalid;
            }
            return null;
          },
          onChanged: (value) {
            signupViewModel.model.isValidEmail(value);
          },
        ),
        const SizedBox(height: 20),
        BauhausTextField(
          controller: signupViewModel.model.abnController,
          label: AppLocalizations.of(context)!.abnHint,
          hintText: '11 digits (numbers only)',
          prefixIcon: Icon(Iconsax.building_4, color: BauhausDesign.textMuted),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.abnInvalid;
            }
            if (value.length != 11) {
              return 'ABN must be exactly 11 digits';
            }
            if (!RegExp(r'^\d{11}$').hasMatch(value)) {
              return 'ABN must contain only numbers';
            }
            return null;
          },
          onChanged: (value) {
            signupViewModel.model.abnController.text = value;
          },
        ),
      ],
    );
  }

  Widget _buildRoleSelection(dynamic signupViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.accountTypeSection,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),
        const SizedBox(height: 16),
        BauhausCard(
          backgroundColor: BauhausDesign.backgroundLight,
          borderColor: BauhausDesign.primary.withOpacity(0.2),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildRoleOption(
                signupViewModel,
                'normal',
                AppLocalizations.of(context)!.normalUser,
                AppLocalizations.of(context)!.normalUserDesc,
                Iconsax.user,
              ),
              Container(
                height: 1,
                color: BauhausDesign.neutral.withOpacity(0.1),
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              _buildRoleOption(
                signupViewModel,
                'admin',
                AppLocalizations.of(context)!.administrator,
                AppLocalizations.of(context)!.administratorDesc,
                Iconsax.crown,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleOption(
    dynamic signupViewModel,
    String value,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = signupViewModel.model.selectedRole == value;
    return InkWell(
      onTap: () {
        signupViewModel.model.selectedRole = value;
        signupViewModel.notifyListeners();
      },
      borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? BauhausDesign.primary.withOpacity(0.1)
                    : BauhausDesign.neutral.withOpacity(0.05),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? BauhausDesign.primary
                    : BauhausDesign.neutral.withOpacity(0.5),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: BauhausDesign.getTextTheme(context).bodyLarge
                        ?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: BauhausDesign.textDark,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodySmall?.copyWith(color: BauhausDesign.neutral),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: signupViewModel.model.selectedRole,
              onChanged: (newValue) {
                signupViewModel.model.selectedRole = newValue!;
                signupViewModel.notifyListeners();
              },
              activeColor: BauhausDesign.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizationCreation(dynamic signupViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.organizationSetupSection,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),
        const SizedBox(height: 16),
        BauhausCard(
          backgroundColor: BauhausDesign.surfaceWhite,
          borderColor: BauhausDesign.secondary.withOpacity(0.2),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.building,
                    color: BauhausDesign.secondary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.createNewOrg,
                          style: BauhausDesign.getTextTheme(context).bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: BauhausDesign.textDark,
                              ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.createNewOrgDesc,
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).bodySmall?.copyWith(color: BauhausDesign.neutral),
                        ),
                      ],
                    ),
                  ),
                  BauhausSwitch(
                    value: signupViewModel.model.isCreatingOrganization,
                    onChanged: (value) {
                      signupViewModel.model.isCreatingOrganization = value;
                      signupViewModel.notifyListeners();
                    },
                    variant: BauhausSwitchVariant.secondary,
                  ),
                ],
              ),
              if (signupViewModel.model.isCreatingOrganization) ...[
                const SizedBox(height: 16),
                BauhausTextField(
                  controller: signupViewModel.model.organizationNameController,
                  label: AppLocalizations.of(context)!.organizationNameHint,
                  hintText: AppLocalizations.of(context)!.organizationNameHint,
                  prefixIcon: Icon(
                    Iconsax.building_4,
                    color: BauhausDesign.textMuted,
                  ),
                  validator: (value) {
                    if (signupViewModel.model.isCreatingOrganization &&
                        (value == null || value.isEmpty)) {
                      return AppLocalizations.of(
                        context,
                      )!.organizationNameRequired;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    signupViewModel.model.organizationNameController.text =
                        value;
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrganizationJoin(dynamic signupViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.joinOrgSection,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),
        const SizedBox(height: 16),
        BauhausCard(
          backgroundColor: BauhausDesign.surfaceWhite,
          borderColor: BauhausDesign.neutral.withOpacity(0.2),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Iconsax.people, color: BauhausDesign.neutral, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.joinExistingOrg,
                          style: BauhausDesign.getTextTheme(context).bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: BauhausDesign.textDark,
                              ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.joinExistingOrgDesc,
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).bodySmall?.copyWith(color: BauhausDesign.neutral),
                        ),
                      ],
                    ),
                  ),
                  BauhausSwitch(
                    value: signupViewModel.model.isJoiningOrganization,
                    onChanged: (value) {
                      signupViewModel.model.isJoiningOrganization = value;
                      signupViewModel.notifyListeners();
                    },
                    variant: BauhausSwitchVariant.neutral,
                  ),
                ],
              ),
              if (signupViewModel.model.isJoiningOrganization) ...[
                const SizedBox(height: 16),
                BauhausTextField(
                  controller: signupViewModel.model.organizationCodeController,
                  label: AppLocalizations.of(context)!.organizationCodeHint,
                  hintText: 'Enter code',
                  prefixIcon: Icon(Iconsax.key, color: BauhausDesign.textMuted),
                  validator: (value) {
                    if (signupViewModel.model.isJoiningOrganization &&
                        (value == null || value.isEmpty)) {
                      return AppLocalizations.of(
                        context,
                      )!.organizationCodeRequired;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    signupViewModel.model.organizationCodeController.text =
                        value;
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordSection(dynamic signupViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.securitySection,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),
        const SizedBox(height: 16),
        BauhausTextField(
          controller: signupViewModel.model.passwordController,
          label: AppLocalizations.of(context)!.passwordLabel,
          hintText: AppLocalizations.of(context)!.passwordMinLength,
          prefixIcon: Icon(Iconsax.lock, color: BauhausDesign.textMuted),
          obscureText: !_isPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
              color: BauhausDesign.textMuted,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.passwordRequired;
            }
            if (value.length < 6) {
              return AppLocalizations.of(context)!.passwordMinLength;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        BauhausTextField(
          controller: signupViewModel.model.confirmPasswordController,
          label: AppLocalizations.of(context)!.confirmPasswordHint,
          hintText: 'Re-enter password',
          prefixIcon: Icon(Iconsax.lock, color: BauhausDesign.textMuted),
          obscureText: !_isConfirmPasswordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
              color: BauhausDesign.textMuted,
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.confirmPasswordRequired;
            }
            if (value != signupViewModel.model.passwordController.text) {
              return AppLocalizations.of(context)!.passwordsDoNotMatch;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignupButton(
    dynamic signupViewModel,
    FlushBarWidget flushBarWidget,
  ) {
    return Center(
      child: Consumer(
        builder: (context, ref, child) {
          final isLoading = signupViewModel.isLoading ?? false;
          return BauhausActionButton(
            text: AppLocalizations.of(context)!.signupTitle,
            variant:
                BauhausActionVariant.secondary, // Uses secondary color (purple)
            isLoading: isLoading,
            icon: Iconsax.user_add,
            backgroundColor: BauhausDesign.secondary,
            textColor: Colors.white,
            onPressed: () => _handleSignup(signupViewModel, flushBarWidget),
          );
        },
      ),
    );
  }

  Future<void> _handleSignup(
    dynamic signupViewModel,
    FlushBarWidget flushBarWidget,
  ) async {
    if (_formKey.currentState!.validate()) {
      signupViewModel.model.validateFields();
      if (signupViewModel.model.isValid) {
        try {
          showAlertDialog(context);
          final response = await signupViewModel.signup(context, _formKey);
          Navigator.pop(context);

          if (response.success) {
            flushBarWidget.flushBar(
              title: response.title,
              message: response.message,
              backgroundColor: response.surfaceColor,
              context: context,
            );

            Future.delayed(const Duration(milliseconds: 1200), () {
              if (!mounted) return;
              Navigator.of(context).pop();
            });
          } else {
            flushBarWidget.flushBar(
              title: response.title,
              message: response.message,
              backgroundColor: response.surfaceColor,
              context: context,
            );
          }
        } catch (e, stackTrace) {
          debugPrint("Exception caught in _handleSignup: $e");
          debugPrint("Stack trace: $stackTrace");
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('An error occurred. Please try again.'),
              backgroundColor: BauhausDesign.error,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please fill in all fields correctly.'),
            backgroundColor: BauhausDesign.warning,
          ),
        );
      }
    }
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.alreadyHaveAccount,
          style: BauhausDesign.getTextTheme(
            context,
          ).bodyMedium?.copyWith(color: BauhausDesign.neutral),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            AppLocalizations.of(context)!.loginLink,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              color: BauhausDesign.primary,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
