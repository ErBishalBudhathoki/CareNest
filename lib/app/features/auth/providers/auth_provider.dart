import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/auth/services/auth_service_new.dart';

enum AuthStatus { unauthenticated, authenticated, loading }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;
  final bool requiresPasswordChange;

  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
    this.requiresPasswordChange = false,
  });

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);

  factory AuthState.loading() => const AuthState(status: AuthStatus.loading);

  factory AuthState.authenticated(User user) =>
      AuthState(status: AuthStatus.authenticated, user: user);

  factory AuthState.requiresPasswordChange(User user) => AuthState(
    status: AuthStatus.authenticated,
    user: user,
    requiresPasswordChange: true,
  );

  factory AuthState.error(String message) =>
      AuthState(status: AuthStatus.unauthenticated, errorMessage: message);
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthService _authService;

  @override
  AuthState build() {
    _authService = ref.watch(authServiceProvider);
    return AuthState.unauthenticated();
  }

  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    try {
      final result = await _authService.login(email, password);
      final user = result['user'] as User;
      final requiresChange = result['requiresPasswordChange'] as bool;

      if (requiresChange) {
        state = AuthState.requiresPasswordChange(user);
      } else {
        state = AuthState.authenticated(user);
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    await _authService.register(email, password, firstName, lastName);
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    state = AuthState.loading();
    try {
      await _authService.changePassword(currentPassword, newPassword);
      if (state.user != null) {
        state = AuthState.authenticated(state.user!);
      } else {
        // Should not happen if strictly following flow
        state = AuthState.unauthenticated();
      }
    } catch (e) {
      if (state.user != null) {
        state = AuthState.requiresPasswordChange(
          state.user!,
        ); // Remain in this state if error
        // Or handle error message better
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    state = AuthState.loading();
    await _authService.logout();
    state = AuthState.unauthenticated();
  }
}
