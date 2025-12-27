import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/alert_dialog_widget.dart';
import 'package:carenest/app/shared/widgets/flushbar_widget.dart';
import 'package:carenest/app/shared/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:iconsax/iconsax.dart';

class SignUpView extends ConsumerStatefulWidget {
  final String? prefilledOrgCode;

  const SignUpView({super.key, this.prefilledOrgCode});

  @override
  @override
  ConsumerState<SignUpView> createState() {
    return _SignupUserNameControllerState();
  }
}

class _SignupUserNameControllerState extends ConsumerState<SignUpView>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'signup_scaffold_key');
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'signup_form_key');
  final _signUpUserFirstNameController = TextEditingController();
  final _signUpUserLastNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmPasswordController = TextEditingController();
  final _signupABNController = TextEditingController();

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  var ins;
  dynamic result;

  @override
  void initState() {
    super.initState();

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
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
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();

    // Pre-fill organization code if provided
    if (widget.prefilledOrgCode != null &&
        widget.prefilledOrgCode!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final signupViewModel = ref.read(signupViewModelProvider);
        signupViewModel.prefillOrganizationCode(widget.prefilledOrgCode!);
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _signUpUserFirstNameController.dispose();
    _signUpUserLastNameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmPasswordController.dispose();
    _signupABNController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 400;
    FlushBarWidget flushBarWidget = FlushBarWidget();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Iconsax.arrow_left,
              color: AppColors.colorBlack87,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.colorPrimary.withValues(alpha: 0.08),
              AppColors.colorSecondary.withValues(alpha: 0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: size.width > 600 ? 80 : 24,
              vertical: 20,
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Consumer(
                  builder: (context, ref, child) {
                    final signupViewModel = ref.watch(signupViewModelProvider);
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildHeader(),
                        const SizedBox(height: 40),
                        _buildSignupForm(signupViewModel, flushBarWidget),
                        const SizedBox(height: 24),
                        _buildLoginLink(),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.colorPrimary,
                AppColors.colorSecondary,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.colorPrimary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Iconsax.user_add,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Create Account',
          style: TextStyle(
            color: AppColors.colorBlack87,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join us and start managing your invoices efficiently',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.colorBlack54,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSignupForm(
      dynamic signupViewModel, FlushBarWidget flushBarWidget) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: const Offset(0, 15),
            spreadRadius: 0,
          ),
        ],
      ),
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
          'Personal Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorBlack87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                suffixIconClickable: false,
                hintText: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
                obscureTextNotifier: ValueNotifier<bool>(false),
                prefixIconData: Iconsax.user,
                suffixIconData: null,
                controller: signupViewModel.model.firstNameController,
                onChanged: (value) {
                  signupViewModel.model.firstNameController.text = value;
                },
                onSaved: (value) {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFieldWidget(
                suffixIconClickable: false,
                hintText: 'Last Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
                obscureTextNotifier: ValueNotifier<bool>(false),
                prefixIconData: Iconsax.user,
                suffixIconData: null,
                controller: signupViewModel.model.lastNameController,
                onChanged: (value) {
                  signupViewModel.model.lastNameController.text = value;
                },
                onSaved: (value) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextFieldWidget(
          hintText: 'Email Address',
          validator: (value) {
            if (value!.isEmpty ||
                !value.contains('@') ||
                !value.contains('.')) {
              return 'Please enter a valid email';
            }
            return null;
          },
          onChanged: (value) {
            signupViewModel.model.isValidEmail(value);
          },
          onSaved: (value) {
            signupViewModel.model.emailController.text = value!;
          },
          obscureTextNotifier: ValueNotifier<bool>(false),
          suffixIconClickable: false,
          controller: signupViewModel.model.emailController,
          prefixIconData: Iconsax.sms,
        ),
        const SizedBox(height: 20),
        TextFieldWidget(
          suffixIconClickable: false,
          hintText: 'ABN (11 digits)',
          validator: (value) {
            if (value!.isEmpty || value.length != 11) {
              return 'Please enter a valid 11-digit ABN';
            }
            return null;
          },
          obscureTextNotifier: ValueNotifier<bool>(false),
          prefixIconData: Iconsax.building_4,
          suffixIconData: null,
          controller: signupViewModel.model.abnController,
          onChanged: (value) {
            signupViewModel.model.abnController.text = value;
          },
          onSaved: (value) {},
        ),
      ],
    );
  }

  Widget _buildRoleSelection(dynamic signupViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Type',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorBlack87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.colorPrimary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildRoleOption(
                signupViewModel,
                'normal',
                'Normal User',
                'Access basic invoice features',
                Iconsax.user,
              ),
              Container(
                height: 1,
                color: Colors.grey[200],
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              _buildRoleOption(
                signupViewModel,
                'admin',
                'Administrator',
                'Full access and organization management',
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
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.colorPrimary.withValues(alpha: 0.1)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.colorPrimary : Colors.grey[600],
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorBlack87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.colorBlack54,
                    ),
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
              activeColor: AppColors.colorPrimary,
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
          'Organization Setup',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorBlack87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.colorSecondary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.colorSecondary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.building,
                    color: AppColors.colorSecondary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create New Organization',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorBlack87,
                          ),
                        ),
                        Text(
                          'Set up your own organization',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.colorBlack54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: signupViewModel.model.isCreatingOrganization,
                    onChanged: (value) {
                      signupViewModel.model.isCreatingOrganization = value;
                      signupViewModel.notifyListeners();
                    },
                    activeColor: AppColors.colorSecondary,
                  ),
                ],
              ),
              if (signupViewModel.model.isCreatingOrganization) ...[
                const SizedBox(height: 16),
                TextFieldWidget(
                  suffixIconClickable: false,
                  hintText: 'Organization Name',
                  validator: (value) {
                    if (signupViewModel.model.isCreatingOrganization &&
                        (value == null || value.isEmpty)) {
                      return 'Please enter organization name';
                    }
                    return null;
                  },
                  obscureTextNotifier: ValueNotifier<bool>(false),
                  prefixIconData: Iconsax.building_4,
                  suffixIconData: null,
                  controller: signupViewModel.model.organizationNameController,
                  onChanged: (value) {
                    signupViewModel.model.organizationNameController.text =
                        value;
                  },
                  onSaved: (value) {},
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
          'Join Organization',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorBlack87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.colorAccent.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.colorAccent.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.people,
                    color: AppColors.colorAccent,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join Existing Organization',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorBlack87,
                          ),
                        ),
                        Text(
                          'Enter organization code to join',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.colorBlack54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: signupViewModel.model.isJoiningOrganization,
                    onChanged: (value) {
                      signupViewModel.model.isJoiningOrganization =
                          value ?? false;
                      signupViewModel.notifyListeners();
                    },
                    activeColor: AppColors.colorAccent,
                  ),
                ],
              ),
              if (signupViewModel.model.isJoiningOrganization) ...[
                const SizedBox(height: 16),
                TextFieldWidget(
                  suffixIconClickable: false,
                  hintText: 'Organization Code',
                  validator: (value) {
                    if (signupViewModel.model.isJoiningOrganization &&
                        (value == null || value.isEmpty)) {
                      return 'Please enter organization code';
                    }
                    return null;
                  },
                  obscureTextNotifier: ValueNotifier<bool>(false),
                  prefixIconData: Iconsax.key,
                  suffixIconData: null,
                  controller: signupViewModel.model.organizationCodeController,
                  onChanged: (value) {
                    signupViewModel.model.organizationCodeController.text =
                        value;
                  },
                  onSaved: (value) {},
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
          'Security',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.colorBlack87,
          ),
        ),
        const SizedBox(height: 16),
        TextFieldWidget(
          hintText: 'Password',
          controller: signupViewModel.model.passwordController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          onChanged: (value) {},
          onSaved: (value) {
            signupViewModel.model.passwordController.text = value!;
          },
          obscureTextNotifier: ValueNotifier<bool>(true),
          suffixIconClickable: true,
          prefixIconData: Iconsax.lock,
        ),
        const SizedBox(height: 20),
        TextFieldWidget(
          hintText: 'Confirm Password',
          controller: signupViewModel.model.confirmPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != signupViewModel.model.passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          onChanged: (value) {},
          onSaved: (value) {
            signupViewModel.model.confirmPasswordController.text = value!;
          },
          obscureTextNotifier: ValueNotifier<bool>(true),
          suffixIconClickable: true,
          prefixIconData: Iconsax.lock,
        ),
      ],
    );
  }

  Widget _buildSignupButton(
      dynamic signupViewModel, FlushBarWidget flushBarWidget) {
    return Consumer(
      builder: (context, ref, child) {
        final isLoading = signupViewModel.isLoading ?? false;
        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.colorPrimary,
                AppColors.colorSecondary,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.colorPrimary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: isLoading
                  ? null
                  : () => _handleSignup(signupViewModel, flushBarWidget),
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.user_add,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleSignup(
      dynamic signupViewModel, FlushBarWidget flushBarWidget) async {
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
              backgroundColor: response.backgroundColor,
              context: context,
            );

            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(
                context,
                Routes.bottomNavBar,
                arguments: {
                  'email': signupViewModel.model.emailController.text,
                  'role': signupViewModel.model.selectedRole == 'admin'
                      ? UserRole.admin
                      : UserRole.normal,
                  'organizationId': signupViewModel.organizationId,
                  'organizationName': signupViewModel.organizationName,
                  'organizationCode': signupViewModel.organizationCode,
                },
              );
            });
          } else {
            flushBarWidget
                .flushBar(
                  title: response.title,
                  message: response.message,
                  backgroundColor: response.backgroundColor,
                  context: context,
                )
                .show(context);
          }
        } catch (e) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An error occurred. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all fields correctly.'),
            backgroundColor: Colors.orange,
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
          'Already have an account? ',
          style: TextStyle(
            color: AppColors.colorBlack54,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Sign In',
            style: TextStyle(
              color: AppColors.colorPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
