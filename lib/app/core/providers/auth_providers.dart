// Auth Providers - Authentication state management
//
// Contains providers for user authentication, login state, and role management.

import 'package:flutter_riverpod/flutter_riverpod.dart';
// needed for ChangeNotifier auth viewmodels
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/viewmodels/login_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/signup_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/forgot_password_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/verify_otp_viewmodel.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

// ==================== AUTH STATE ====================

// Authentication state for the current user session
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final String? email;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
    this.email,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
    String? email,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      email: email ?? this.email,
    );
  }
}

// Notifier for authentication state changes
class AuthNotifier extends Notifier<AuthState> {
  late final ApiMethod _apiMethod;

  @override
  AuthState build() {
    _apiMethod = ref.watch(apiMethodProvider);
    return const AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _apiMethod.login(email, password);
      if (response is! Map || response['success'] != true) {
        final message = response is Map && response['message'] != null
            ? response['message'].toString()
            : 'Login failed';
        throw Exception(message);
      }
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        email: email,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void logout() {
    state = const AuthState();
  }
}

// Main auth state provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

// ==================== USER ROLE ====================

// Notifier for user role management
class UserRoleNotifier extends Notifier<UserRole> {
  late final SharedPreferencesUtils _sharedPrefs;

  @override
  UserRole build() {
    _sharedPrefs = ref.watch(sharedPreferencesProvider);
    final role = _sharedPrefs.getRole();
    return role ?? UserRole.employee;
  }

  Future<void> updateRole(UserRole newRole) async {
    await _sharedPrefs.setRole(newRole);
    state = newRole;
  }
}

// User role provider
final userRoleProvider = NotifierProvider<UserRoleNotifier, UserRole>(
  UserRoleNotifier.new,
);

// ==================== AUTH VIEW MODEL PROVIDERS ====================

// Login view model provider with autoDispose for proper cleanup
final loginViewModelProvider =
    NotifierProvider.autoDispose<LoginViewModel, int>(LoginViewModel.new);

// Signup view model provider with autoDispose
final signupViewModelProvider =
    NotifierProvider.autoDispose<SignupViewModel, int>(SignupViewModel.new);

// Forgot password view model provider with autoDispose
final forgotPasswordViewModelProvider =
    NotifierProvider.autoDispose<ForgotPasswordViewModel, bool>(
      ForgotPasswordViewModel.new,
    );

// OTP verification view model provider with autoDispose
final verifyOTPViewModelProvider =
    NotifierProvider.autoDispose<VerifyOTPViewModel, void>(
      VerifyOTPViewModel.new,
    );
