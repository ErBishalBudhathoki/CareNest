// Auth Providers - Authentication state management
//
// Contains providers for user authentication, login state, and role management.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/viewmodels/change_password_viewmodel.dart';
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
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiMethod _apiMethod;

  AuthNotifier(this._apiMethod) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      await _apiMethod.login(email, password);
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
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(apiMethodProvider));
});

// ==================== USER ROLE ====================

// Notifier for user role management
class UserRoleNotifier extends StateNotifier<UserRole> {
  final SharedPreferencesUtils _sharedPrefs;

  UserRoleNotifier(this._sharedPrefs) : super(UserRole.normal) {
    _loadRole();
  }

  Future<void> _loadRole() async {
    final role = _sharedPrefs.getRole();
    state = role ?? UserRole.normal;
  }

  Future<void> updateRole(UserRole newRole) async {
    await _sharedPrefs.setRole(newRole);
    state = newRole;
  }
}

// User role provider
final userRoleProvider = StateNotifierProvider<UserRoleNotifier, UserRole>((ref) {
  return UserRoleNotifier(ref.read(sharedPreferencesProvider));
});

// ==================== AUTH VIEW MODEL PROVIDERS ====================

// Login view model provider with autoDispose for proper cleanup
final loginViewModelProvider = ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
  return LoginViewModel(
    ref.read(apiMethodProvider),
    ref.read(sharedPreferencesProvider),
  );
});

// Signup view model provider with autoDispose
final signupViewModelProvider = ChangeNotifierProvider.autoDispose<SignupViewModel>((ref) {
  return SignupViewModel();
});

// Forgot password view model provider with autoDispose
final forgotPasswordViewModelProvider = ChangeNotifierProvider.autoDispose<ForgotPasswordViewModel>((ref) {
  return ForgotPasswordViewModel(
    ref.read(sharedPreferencesProvider),
  );
});

// Change password view model provider with autoDispose
final changePasswordViewModelProvider = ChangeNotifierProvider.autoDispose<ChangePasswordViewModel>((ref) {
  return ChangePasswordViewModel(ref);
});

// OTP verification view model provider with autoDispose
final verifyOTPViewModelProvider = ChangeNotifierProvider.autoDispose<VerifyOTPViewModel>((ref) {
  return VerifyOTPViewModel();
});
