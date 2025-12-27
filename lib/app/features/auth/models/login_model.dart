import 'dart:core';
import 'package:carenest/app/core/base/base_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginModel extends ChangeNotifier implements VisibilityToggleModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isVisible = false;
  bool _isValid = false;
  final bool _isPasswordValid = false;
  IconData? suffixIconData;

  // Security enhancements
  int _loginAttempts = 0;
  DateTime? _lastFailedAttempt;
  bool _isAccountLocked = false;
  static const int maxLoginAttempts = 5;
  static const int lockoutDurationMinutes = 15;

  // Input sanitization flags
  bool _hasValidEmail = false;
  bool _hasSecurePassword = false;
  String? _emailError;
  String? _passwordError;

  @override
  bool get isVisible => _isVisible;

  @override
  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  bool get isValid =>
      _isValid && _hasValidEmail && _hasSecurePassword && !_isAccountLocked;
  bool get isPasswordValid => _isPasswordValid;
  bool get hasValidEmail => _hasValidEmail;
  bool get hasSecurePassword => _hasSecurePassword;
  bool get isAccountLocked => _isAccountLocked;
  int get loginAttempts => _loginAttempts;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  DateTime? get lockoutEndTime {
    if (_lastFailedAttempt == null) return null;
    return _lastFailedAttempt!
        .add(const Duration(minutes: lockoutDurationMinutes));
  }

  bool get isLockoutExpired {
    if (_lastFailedAttempt == null) return true;
    return DateTime.now().isAfter(_lastFailedAttempt!
        .add(const Duration(minutes: lockoutDurationMinutes)));
  }

  /// Enhanced email validation with security checks
  void validateEmail(String input) {
    _emailError = null;

    // Sanitize input
    final sanitizedInput = _sanitizeInput(input.trim().toLowerCase());

    // Check for suspicious patterns
    if (_containsSuspiciousPatterns(sanitizedInput)) {
      _emailError = 'Invalid email format';
      _hasValidEmail = false;
      _updateValidationState();
      return;
    }

    // Enhanced email regex with stricter validation
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // Additional checks
    final isValidFormat = emailRegex.hasMatch(sanitizedInput);
    final isValidLength =
        sanitizedInput.length >= 5 && sanitizedInput.length <= 254;
    final hasValidDomain = _hasValidDomain(sanitizedInput);

    _hasValidEmail = isValidFormat && isValidLength && hasValidDomain;

    if (!_hasValidEmail) {
      if (!isValidFormat) {
        _emailError = 'Please enter a valid email address';
      } else if (!isValidLength) {
        _emailError = 'Email must be between 5 and 254 characters';
      } else if (!hasValidDomain) {
        _emailError = 'Invalid email domain';
      }
    }

    _updateValidationState();
  }

  /// Simple password validation for login (not signup)
  void validatePassword(String input) {
    _passwordError = null;

    // For login, we only need basic validation
    // Complex password requirements should only be enforced during signup
    final hasMinLength = input.isNotEmpty; // Just check it's not empty
    final hasMaxLength = input.length <= 128; // Reasonable max length

    // Check for suspicious patterns (security measure)
    if (_containsSuspiciousPatterns(input)) {
      _passwordError = 'Invalid password format';
      _hasSecurePassword = false;
      _updateValidationState();
      return;
    }

    _hasSecurePassword = hasMinLength && hasMaxLength;

    if (!_hasSecurePassword) {
      if (!hasMinLength) {
        _passwordError = 'Password is required';
      } else if (!hasMaxLength) {
        _passwordError = 'Password is too long';
      }
    }

    _updateValidationState();
  }

  /// Record failed login attempt
  void recordFailedAttempt() {
    _loginAttempts++;
    _lastFailedAttempt = DateTime.now();

    if (_loginAttempts >= maxLoginAttempts) {
      _isAccountLocked = true;
    }

    notifyListeners();
  }

  /// Reset login attempts on successful login
  void resetLoginAttempts() {
    _loginAttempts = 0;
    _lastFailedAttempt = null;
    _isAccountLocked = false;
    notifyListeners();
  }

  /// Check if account lockout has expired
  void checkLockoutStatus() {
    if (_isAccountLocked && isLockoutExpired) {
      _isAccountLocked = false;
      _loginAttempts = 0;
      _lastFailedAttempt = null;
      notifyListeners();
    }
  }

  /// Get remaining lockout time in minutes
  int getRemainingLockoutMinutes() {
    if (!_isAccountLocked || _lastFailedAttempt == null) return 0;

    final lockoutEnd = _lastFailedAttempt!
        .add(const Duration(minutes: lockoutDurationMinutes));
    final remaining = lockoutEnd.difference(DateTime.now());

    return remaining.inMinutes.clamp(0, lockoutDurationMinutes);
  }

  /// Sanitize input to prevent injection attacks
  String _sanitizeInput(String input) {
    // Remove potentially dangerous characters
    return input
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('"', '')
        .replaceAll("'", '')
        .replaceAll('/', '')
        .replaceAll('\\', '');
  }

  /// Check for suspicious patterns that might indicate attacks
  bool _containsSuspiciousPatterns(String input) {
    final suspiciousPatterns = [
      RegExp(r'<script', caseSensitive: false),
      RegExp(r'javascript:', caseSensitive: false),
      RegExp(r'on\w+\s*=', caseSensitive: false),
      RegExp(r'\bselect\b.*\bfrom\b', caseSensitive: false),
      RegExp(r'\bunion\b.*\bselect\b', caseSensitive: false),
      RegExp(r'\bdrop\b.*\btable\b', caseSensitive: false),
      RegExp(r'\binsert\b.*\binto\b', caseSensitive: false),
      RegExp(r'\bupdate\b.*\bset\b', caseSensitive: false),
      RegExp(r'\bdelete\b.*\bfrom\b', caseSensitive: false),
    ];

    return suspiciousPatterns.any((pattern) => pattern.hasMatch(input));
  }

  /// Validate email domain
  bool _hasValidDomain(String email) {
    if (!email.contains('@')) return false;

    final domain = email.split('@').last;

    // Basic domain validation
    final domainRegex = RegExp(r'^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!domainRegex.hasMatch(domain)) return false;

    // Check for suspicious domains
    final suspiciousDomains = [
      'tempmail.org',
      '10minutemail.com',
      'guerrillamail.com',
      'mailinator.com',
      'throwaway.email',
    ];

    return !suspiciousDomains.contains(domain.toLowerCase());
  }

  /// Check if password is commonly used
  bool _isCommonPassword(String password) {
    final commonPasswords = [
      'password',
      '123456',
      '123456789',
      'qwerty',
      'abc123',
      'password123',
      'admin',
      'letmein',
      'welcome',
      'monkey',
      '1234567890',
      'password1',
      '123123',
      'admin123',
      'root',
      'user',
      'test',
      'guest',
      'demo',
      'sample'
    ];

    return commonPasswords.contains(password.toLowerCase());
  }

  /// Update overall validation state
  void _updateValidationState() {
    _isValid = _hasValidEmail && _hasSecurePassword;
    suffixIconData = _hasValidEmail ? Icons.check : null;
    notifyListeners();
  }

  /// Clear all form data securely
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    _hasValidEmail = false;
    _hasSecurePassword = false;
    _isValid = false;
    _emailError = null;
    _passwordError = null;
    suffixIconData = null;
    notifyListeners();
  }

  /// Hash password for secure transmission
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Get sanitized email for API calls
  String getSanitizedEmail() {
    return _sanitizeInput(emailController.text.trim().toLowerCase());
  }

  /// Validate form before submission
  bool validateForm() {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    checkLockoutStatus();

    return isValid;
  }

  @override
  void dispose() {
    // Securely clear sensitive data
    emailController.clear();
    passwordController.clear();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
