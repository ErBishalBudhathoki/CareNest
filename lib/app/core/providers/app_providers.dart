import 'dart:async';
import 'dart:typed_data';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/features/assignment_list/viewmodels/assignment_list_viewmodel.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/viewmodels/change_password_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/login_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/signup_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/forgot_password_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/verify_otp_viewmodel.dart';
import 'package:carenest/app/features/invoice/viewmodels/line_items_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:http/http.dart' as http;
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/busineess/viewmodels/add_business_viewmodel.dart';
import 'package:carenest/app/features/invoice/viewmodels/invoice_email_viewmodel.dart';

// Global providers
final sharedPreferencesProvider = Provider<SharedPreferencesUtils>((ref) {
  final prefs = SharedPreferencesUtils();
  prefs.init();
  return prefs;
});

final invoiceEmailViewModelProvider = ChangeNotifierProvider((ref) {
  return InvoiceEmailViewModel(); // pass ref if needed
});

// Navigation providers
final navigationKeyProvider = Provider(
    (ref) => GlobalKey<NavigatorState>(debugLabel: 'navigation_key_provider'));

// API Service
final apiMethodProvider = Provider<ApiMethod>((ref) => ApiMethod());

final userPhotoProvider = FutureProvider.autoDispose<Uint8List?>((ref) async {
  final email = ref.watch(authProvider.select((state) => state.email));
  if (email == null) return null;

  return ref.read(apiMethodProvider).getUserPhoto(email);
});

class UserPhotoService {
  final Map<String, Uint8List> _photoCache = {};

  Future<Uint8List?> getUserPhoto(String email) async {
    if (_photoCache.containsKey(email)) {
      return _photoCache[email];
    }

    final response = await http
        .get(Uri.parse('http://192.168.20.2:8083/getUserPhoto/$email'));
    if (response.statusCode == 200) {
      _photoCache[email] = response.bodyBytes;
      return response.bodyBytes;
    }
    return null;
  }
}

// Photo Data Service
final photoDataProvider =
    StateNotifierProvider<PhotoDataNotifier, PhotoDataState>((ref) {
  return PhotoDataNotifier(ref.read(apiMethodProvider));
});

class PhotoDataState {
  final Uint8List? photoData;
  final bool isLoading;
  final String? error;

  const PhotoDataState({
    this.photoData,
    this.isLoading = false,
    this.error,
  });

  PhotoDataState copyWith({
    Uint8List? photoData,
    bool? isLoading,
    String? error,
  }) {
    return PhotoDataState(
      photoData: photoData ?? this.photoData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class PhotoDataNotifier extends StateNotifier<PhotoDataState> {
  final ApiMethod _apiMethod;

  PhotoDataNotifier(this._apiMethod) : super(const PhotoDataState());

  Future<void> fetchPhotoData(String email) async {
    debugPrint(
        "\n=== PhotoDataNotifier.fetchPhotoData called for email: $email ===");
    state = state.copyWith(isLoading: true);
    try {
      // Check cache first
      debugPrint("Checking cache for photo data...");
      final cachedPhoto = await SharedPreferencesUtils().getPhoto(email);
      if (cachedPhoto != null) {
        debugPrint("Found cached photo data, length: ${cachedPhoto.length}");
        state = state.copyWith(photoData: cachedPhoto, isLoading: false);
        return;
      }
      debugPrint("No cached photo found, fetching from network...");

      // If not in cache, fetch from network
      final photoData = await _apiMethod.getUserPhoto(email);
      debugPrint(
          "Network response received, photoData: ${photoData != null ? 'length ${photoData.length}' : 'null'}");
      state = state.copyWith(photoData: photoData, isLoading: false);

      // Save to cache
      if (photoData != null) {
        debugPrint("Saving photo data to cache...");
        await SharedPreferencesUtils().setPhoto(photoData, email);
        debugPrint("Photo data saved to cache successfully");
      } else {
        debugPrint("No photo data to save to cache");
      }
    } catch (e) {
      debugPrint("Error in fetchPhotoData: $e");
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
    debugPrint("=== PhotoDataNotifier.fetchPhotoData completed ===");
  }

  Future<void> updatePhotoData(Uint8List photoData) async {
    state = state.copyWith(photoData: photoData);
    // Also update the cache to keep it in sync
    try {
      // We need to get the email from somewhere - for now we'll update the cache in the upload method
      debugPrint("Photo data updated in provider");
    } catch (e) {
      debugPrint("Error updating photo cache: $e");
    }
  }

  void clearPhotoData() {
    state = const PhotoDataState();
  }
}

// Appointment Service
final appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, AppointmentState>((ref) {
  return AppointmentNotifier(ref.read(apiMethodProvider));
});

class AppointmentState {
  final List<dynamic> appointments;
  final bool isLoading;
  final String? error;

  const AppointmentState({
    this.appointments = const [],
    this.isLoading = false,
    this.error,
  });

  AppointmentState copyWith({
    List<dynamic>? appointments,
    bool? isLoading,
    String? error,
  }) {
    return AppointmentState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AppointmentNotifier extends StateNotifier<AppointmentState> {
  final ApiMethod _apiMethod;

  AppointmentNotifier(this._apiMethod) : super(const AppointmentState());

  Future<void> fetchAppointments(String email) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await _apiMethod.getAppointmentData(email);
      state = state.copyWith(appointments: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

// User Authentication Service
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(apiMethodProvider));
});

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

final timerServiceProviderWithNotifier =
    ChangeNotifierProvider<TimerService>((ref) {
  return TimerService();
});
// final timerServiceProviders = Provider.family<TimerService, String>((ref, clientEmail) {
//   return TimerService(clientEmail);
// });
final timerServiceProvider =
    StateNotifierProvider<TimerServiceNotifier, TimerService>((ref) {
  return TimerServiceNotifier();
});

class TimerState {
  //final bool isRunning;
  final Duration elapsedTime;
  Timer? timer; // Timer for the client
  int elapsedSeconds = 0; // Elapsed time in seconds
  bool isRunning = false; // Whether the timer is running
  DateTime startTime = DateTime.now(); // Start time of the timer

  TimerState({
    this.isRunning = false,
    this.elapsedTime = Duration.zero,
  });

  TimerState copyWith({
    bool? isRunning,
    Duration? elapsedTime,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}

class TimerServiceNotifier extends StateNotifier<TimerService> {
  TimerServiceNotifier() : super(TimerService());
}

final shiftDataProvider =
    StateNotifierProvider<ShiftDataNotifier, List<dynamic>>((ref) {
  return ShiftDataNotifier();
});

class ShiftDataNotifier extends StateNotifier<List<dynamic>> {
  ShiftDataNotifier() : super([]);

  void updateShifts(List<dynamic> newShifts) {
    state = newShifts;
  }

  void markShiftCompleted(int index) {
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) {...state[i], 'isCompleted': true} else state[i]
    ];
  }
}

// Theme Provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(_lightTheme);

  static final _lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.colorBlue,
    // Add your custom theme properties
  );

  static final _darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.colorBlueGrey,
    // Add your custom theme properties
  );

  void toggleTheme() {
    state = state.brightness == Brightness.dark ? _lightTheme : _darkTheme;
  }
}

// User Role Provider
final userRoleProvider =
    StateNotifierProvider<UserRoleNotifier, UserRole>((ref) {
  return UserRoleNotifier(ref.read(sharedPreferencesProvider));
});

class UserRoleNotifier extends StateNotifier<UserRole> {
  final SharedPreferencesUtils _sharedPrefs;

  UserRoleNotifier(this._sharedPrefs) : super(UserRole.normal) {
    _loadRole();
  }

  Future<void> _loadRole() async {
    final role = await _sharedPrefs.getRole();
    state = role ?? UserRole.normal;
  }

  Future<void> updateRole(UserRole newRole) async {
    await _sharedPrefs.setRole(newRole);
    state = newRole;
  }
}

final loginViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
  return LoginViewModel(
    ref.read(apiMethodProvider),
    ref.read(sharedPreferencesProvider),
  );
});

final signupViewModelProvider =
    ChangeNotifierProvider.autoDispose<SignupViewModel>((ref) {
  return SignupViewModel();
});

final forgotPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<ForgotPasswordViewModel>((ref) {
  return ForgotPasswordViewModel(
    ref.read(sharedPreferencesProvider),
  );
});

final changePasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<ChangePasswordViewModel>((ref) {
  return ChangePasswordViewModel(ref);
});

final verifyOTPViewModelProvider =
    ChangeNotifierProvider.autoDispose<VerifyOTPViewModel>((ref) {
  return VerifyOTPViewModel();
});

final addBusinessViewModelProvider =
    ChangeNotifierProvider<AddBusinessViewModel>((ref) {
  return AddBusinessViewModel(ref);
});

final sharedPreferencesUtilsProvider = Provider<SharedPreferencesUtils>((ref) {
  return SharedPreferencesUtils();
});

/// Provider for line item view model that handles support items
final lineItemViewModelProvider =
    StateNotifierProvider<LineItemViewModel, List<Map<String, dynamic>>>((ref) {
  return LineItemViewModel(ref.read(apiMethodProvider));
});

// User email provider - retrieves the current user's email from SharedPreferences
final userEmailProvider = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final email = prefs.getUserEmail();
  debugPrint('🔍 DEBUG Provider: userEmailProvider returning: $email');
  return email;
});

// Organization ID provider - retrieves the current organization ID from SharedPreferences
final organizationIdProvider = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final orgId = prefs.getOrganizationId();
  debugPrint('🔍 DEBUG Provider: organizationIdProvider returning: $orgId');
  return orgId;
});
