// Auth Providers - Authentication state management
//
// Contains providers for user authentication, login state, and role management.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/viewmodels/login_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/signup_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/forgot_password_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/verify_otp_viewmodel.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

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
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(apiMethodProvider));
});

// ==================== USER ROLE ====================

// Notifier for user role management
class UserRoleNotifier extends StateNotifier<UserRole> {
  final SharedPreferencesUtils _sharedPrefs;

  UserRoleNotifier(this._sharedPrefs) : super(UserRole.employee) {
    _loadRole();
  }

  Future<void> _loadRole() async {
    final role = _sharedPrefs.getRole();
    state = role ?? UserRole.employee;
  }

  Future<void> updateRole(UserRole newRole) async {
    await _sharedPrefs.setRole(newRole);
    state = newRole;
  }
}

// User role provider
final userRoleProvider =
    StateNotifierProvider<UserRoleNotifier, UserRole>((ref) {
  return UserRoleNotifier(ref.read(sharedPreferencesProvider));
});

// ==================== AUTH VIEW MODEL PROVIDERS ====================

// Login view model provider with autoDispose for proper cleanup
final loginViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
  return LoginViewModel(
    ref.read(apiMethodProvider),
    ref.read(sharedPreferencesProvider),
    ref.read(app_providers.fcmTokenManagerProvider),
  );
});

// Signup view model provider with autoDispose
final signupViewModelProvider =
    ChangeNotifierProvider.autoDispose<SignupViewModel>((ref) {
  return SignupViewModel(ref.read(apiMethodProvider));
});

// Forgot password view model provider with autoDispose
final forgotPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<ForgotPasswordViewModel>((ref) {
  return ForgotPasswordViewModel(
    ref.read(sharedPreferencesProvider),
    ref.read(apiMethodProvider),
  );
});

// OTP verification view model provider with autoDispose
final verifyOTPViewModelProvider =
    ChangeNotifierProvider.autoDispose<VerifyOTPViewModel>((ref) {
  return VerifyOTPViewModel();
});
