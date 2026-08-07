import 'package:flutter/material.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../constants/onboarding_app_constants.dart';

class OnboardingAppSignup extends StatefulWidget {
  final VoidCallback onNext;

  const OnboardingAppSignup({super.key, required this.onNext});

  @override
  State<OnboardingAppSignup> createState() => _OnboardingAppSignupState();
}

class _OnboardingAppSignupState extends State<OnboardingAppSignup>
    with SingleTickerProviderStateMixin {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  String? _emailError;
  String? _passwordError;

  late final AnimationController _entryCtrl;
  late final Animation<double> _headlineOp;
  late final Animation<Offset> _headlineSlide;
  late final Animation<double> _formOp;
  late final Animation<double> _ctaOp;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: OnboardingDurations.entryFadeSlide,
    );
    _headlineOp = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _headlineSlide =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entryCtrl,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
          ),
        );
    _formOp = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.25, 0.8, curve: Curves.easeOut),
      ),
    );
    _ctaOp = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryCtrl,
        curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
      ),
    );
    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (email.isEmpty) {
      setState(() => _emailError = 'Email is required');
      return;
    }
    if (!email.contains('@')) {
      setState(() => _emailError = 'Enter a valid email');
      return;
    }
    if (password.length < 8) {
      setState(() => _passwordError = 'At least 8 characters');
      return;
    }
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            BauhausDesign.space6,
            BauhausDesign.space6,
            BauhausDesign.space6,
            BauhausDesign.space6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SlideTransition(
                position: _headlineSlide,
                child: FadeTransition(
                  opacity: _headlineOp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        OnboardingContent.signupHeadline,
                        style: theme.displayMedium?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      Text(
                        OnboardingContent.signupSubtext,
                        style: theme.bodyLarge?.copyWith(
                          color: BauhausDesign.textMuted,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space10),
              FadeTransition(
                opacity: _formOp,
                child: Column(
                  children: [
                    _Field(
                      controller: _emailCtrl,
                      focusNode: _emailFocus,
                      label: 'Email',
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      error: _emailError,
                      onChanged: (_) {
                        if (_emailError != null) {
                          setState(() => _emailError = null);
                        }
                      },
                      onSubmitted: (_) => _passwordFocus.requestFocus(),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    _Field(
                      controller: _passwordCtrl,
                      focusNode: _passwordFocus,
                      label: 'Password',
                      hint: 'Min. 8 characters',
                      obscureText: true,
                      error: _passwordError,
                      onChanged: (_) {
                        if (_passwordError != null) {
                          setState(() => _passwordError = null);
                        }
                      },
                      onSubmitted: (_) => _submit(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BauhausDesign.space8),
              FadeTransition(
                opacity: _ctaOp,
                child: Column(
                  children: [
                    _BrutalistButton(label: 'Create Account', onTap: _submit),
                    const SizedBox(height: BauhausDesign.space6),
                    Row(
                      children: [
                        Expanded(
                          child: _SocialButton(
                            label: 'Google',
                            icon: Icons.g_mobiledata,
                            onTap: widget.onNext,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Expanded(
                          child: _SocialButton(
                            label: 'Apple',
                            icon: Icons.apple,
                            onTap: widget.onNext,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? error;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  const _Field({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.error,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = error != null
        ? BauhausDesign.error
        : BauhausDesign.neoInk;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BauhausDesign.neoMonoStyle(
            context,
            color: borderColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: borderColor, width: 2),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            style: BauhausDesign.getTextTheme(
              context,
            ).bodyLarge?.copyWith(color: BauhausDesign.textDark),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: BauhausDesign.getTextTheme(
                context,
              ).bodyLarge?.copyWith(color: BauhausDesign.textMuted),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space4,
                vertical: BauhausDesign.space4,
              ),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: BauhausDesign.space1),
          Text(
            error!,
            style: BauhausDesign.neoMonoStyle(
              context,
              color: BauhausDesign.error,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space3,
        ),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: BauhausDesign.neoInk, width: 2),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: BauhausDesign.neoInk),
            const SizedBox(width: BauhausDesign.space2),
            Text(
              label,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrutalistButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _BrutalistButton({required this.label, required this.onTap});

  @override
  State<_BrutalistButton> createState() => _BrutalistButtonState();
}

class _BrutalistButtonState extends State<_BrutalistButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: OnboardingDurations.buttonPress,
    );
    _scale = Tween<double>(begin: 1.0, end: OnboardingButtonPress.scaleTarget)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: OnboardingCurves.buttonPressEase,
          ),
        );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    setState(() => _pressed = true);
    _ctrl.forward();
  }

  void _onTapUp(TapUpDetails _) {
    setState(() => _pressed = false);
    _ctrl.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _pressed = false);
    _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final shadowOffset = _pressed
        ? OnboardingButtonPress.shadowOffsetPressed
        : 4.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: OnboardingDurations.buttonPress,
          curve: OnboardingCurves.buttonPressEase,
          padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: BauhausDesign.neoInk,
            border: Border.all(color: BauhausDesign.neoInk, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000),
                offset: Offset(shadowOffset, shadowOffset),
                blurRadius: 0,
              ),
            ],
          ),
          child: Text(
            widget.label,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.surfaceWhite,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
