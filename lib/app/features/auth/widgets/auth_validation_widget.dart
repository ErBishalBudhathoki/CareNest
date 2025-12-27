import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

/// Real-time validation widget for authentication forms
/// Provides immediate feedback on input errors before submission
class AuthValidationWidget extends StatefulWidget {
  final TextEditingController controller;
  final String fieldType; // 'email' or 'password'
  final Function(bool isValid, String? errorMessage)? onValidationChanged;
  final bool showValidation;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final bool showObscureToggle;

  const AuthValidationWidget({
    super.key,
    required this.controller,
    required this.fieldType,
    this.onValidationChanged,
    this.showValidation = true,
    this.label,
    this.hint,
    this.prefixIcon,
    this.obscureText = false,
    this.onToggleObscure,
    this.showObscureToggle = false,
  });

  @override
  State<AuthValidationWidget> createState() => _AuthValidationWidgetState();
}

class _AuthValidationWidgetState extends State<AuthValidationWidget>
    with TickerProviderStateMixin {
  late AnimationController _validationController;
  late Animation<double> _validationAnimation;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  bool _isValid = false;
  String? _errorMessage;
  bool _hasBeenTouched = false;
  List<ValidationRule> _validationRules = [];

  @override
  void initState() {
    super.initState();

    _validationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _validationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _validationController,
      curve: Curves.easeInOut,
    ));

    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));

    _initializeValidationRules();
    widget.controller.addListener(_onTextChanged);
  }

  void _initializeValidationRules() {
    switch (widget.fieldType.toLowerCase()) {
      case 'email':
        _validationRules = [
          ValidationRule(
            check: (value) => value.isNotEmpty,
            message: 'Email is required',
            type: ValidationRuleType.required,
          ),
          ValidationRule(
            check: (value) =>
                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value),
            message: 'Please enter a valid email address',
            type: ValidationRuleType.format,
          ),
          ValidationRule(
            check: (value) => value.length <= 254,
            message: 'Email address is too long',
            type: ValidationRuleType.length,
          ),
        ];
        break;
      case 'password':
        _validationRules = [
          ValidationRule(
            check: (value) => value.isNotEmpty,
            message: 'Password is required',
            type: ValidationRuleType.required,
          ),
          ValidationRule(
            check: (value) => value.length >= 8,
            message: 'Password must be at least 8 characters',
            type: ValidationRuleType.length,
          ),
          ValidationRule(
            check: (value) => RegExp(r'[A-Z]').hasMatch(value),
            message: 'Password must contain at least one uppercase letter',
            type: ValidationRuleType.strength,
          ),
          ValidationRule(
            check: (value) => RegExp(r'[a-z]').hasMatch(value),
            message: 'Password must contain at least one lowercase letter',
            type: ValidationRuleType.strength,
          ),
          ValidationRule(
            check: (value) => RegExp(r'[0-9]').hasMatch(value),
            message: 'Password must contain at least one number',
            type: ValidationRuleType.strength,
          ),
          ValidationRule(
            check: (value) => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value),
            message: 'Password must contain at least one special character',
            type: ValidationRuleType.strength,
          ),
        ];
        break;
    }
  }

  void _onTextChanged() {
    if (!_hasBeenTouched) {
      setState(() {
        _hasBeenTouched = true;
      });
    }

    _validateInput();
  }

  void _validateInput() {
    final value = widget.controller.text;
    bool isValid = true;
    String? errorMessage;

    for (final rule in _validationRules) {
      if (!rule.check(value)) {
        isValid = false;
        errorMessage = rule.message;
        break;
      }
    }

    if (_isValid != isValid || _errorMessage != errorMessage) {
      setState(() {
        _isValid = isValid;
        _errorMessage = errorMessage;
      });

      if (widget.showValidation && _hasBeenTouched) {
        if (isValid) {
          _validationController.forward();
        } else {
          _validationController.reverse();
          _shakeController.forward().then((_) {
            _shakeController.reset();
          });
        }
      }

      widget.onValidationChanged?.call(isValid, errorMessage);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _validationController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              _shakeAnimation.value * 10 * (1 - _shakeAnimation.value), 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _getBorderColor(),
                    width: 2,
                  ),
                  color: AppColors.colorBackground,
                ),
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.obscureText,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.colorFontPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    labelText: widget.label,
                    hintText: widget.hint,
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(
                            widget.prefixIcon,
                            color: _getIconColor(),
                          )
                        : null,
                    suffixIcon: _buildSuffixIcon(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.colorFontSecondary,
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(
                      color:
                          AppColors.colorFontSecondary.withOpacity(0.1),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Validation feedback
              if (widget.showValidation && _hasBeenTouched)
                AnimatedBuilder(
                  animation: _validationAnimation,
                  builder: (context, child) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _isValid ? 0 : null,
                      child: _isValid
                          ? const SizedBox.shrink()
                          : Container(
                              margin: const EdgeInsets.only(top: 8, left: 4),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber_outlined,
                                    size: 16,
                                    color: AppColors.error,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _errorMessage ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.error,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    );
                  },
                ),

              // Password strength indicator
              if (widget.fieldType == 'password' && _hasBeenTouched)
                _buildPasswordStrengthIndicator(),
            ],
          ),
        );
      },
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.showObscureToggle) {
      return IconButton(
        onPressed: widget.onToggleObscure,
        icon: Icon(
          widget.obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.colorFontSecondary,
        ),
      );
    }

    if (widget.showValidation && _hasBeenTouched) {
      return AnimatedBuilder(
        animation: _validationAnimation,
        builder: (context, child) {
          return Icon(
            _isValid ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: _isValid ? AppColors.colorSuccess : AppColors.error,
          );
        },
      );
    }

    return null;
  }

  Color _getBorderColor() {
    if (!widget.showValidation || !_hasBeenTouched) {
      return AppColors.colorBorder;
    }
    return _isValid ? AppColors.colorSuccess : AppColors.error;
  }

  Color _getIconColor() {
    if (!widget.showValidation || !_hasBeenTouched) {
      return AppColors.colorFontSecondary;
    }
    return _isValid ? AppColors.colorSuccess : AppColors.error;
  }

  Widget _buildPasswordStrengthIndicator() {
    if (widget.fieldType != 'password') return const SizedBox.shrink();

    final strength = _calculatePasswordStrength();
    final strengthText = _getStrengthText(strength);
    final strengthColor = _getStrengthColor(strength);

    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Password strength: ',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.colorFontSecondary,
                ),
              ),
              Text(
                strengthText,
                style: TextStyle(
                  fontSize: 12,
                  color: strengthColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: strength / 4,
            valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
            minHeight: 3,
          ),
        ],
      ),
    );
  }

  int _calculatePasswordStrength() {
    final value = widget.controller.text;
    int strength = 0;

    if (value.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(value)) strength++;
    if (RegExp(r'[a-z]').hasMatch(value)) strength++;
    if (RegExp(r'[0-9]').hasMatch(value)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) strength++;

    return strength;
  }

  String _getStrengthText(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
      case 5:
        return 'Strong';
      default:
        return 'Weak';
    }
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return AppColors.error;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow.shade700;
      case 4:
      case 5:
        return AppColors.colorSuccess;
      default:
        return AppColors.error;
    }
  }
}

/// Validation rule class for defining input validation logic
class ValidationRule {
  final bool Function(String) check;
  final String message;
  final ValidationRuleType type;

  ValidationRule({
    required this.check,
    required this.message,
    required this.type,
  });
}

/// Types of validation rules
enum ValidationRuleType {
  required,
  format,
  length,
  strength,
}

/// Validation result class
class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  final List<String> warnings;

  ValidationResult({
    required this.isValid,
    this.errorMessage,
    this.warnings = const [],
  });
}
