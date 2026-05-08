import 'dart:async';

import 'package:carenest/app/features/invoice/viewmodels/invoice_email_viewmodel.dart';
import 'package:carenest/app/features/business/viewmodels/add_business_viewmodel.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'dart:typed_data';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/viewmodels/login_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/signup_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/forgot_password_viewmodel.dart';
import 'package:carenest/app/features/auth/viewmodels/verify_otp_viewmodel.dart';
import 'package:carenest/app/features/invoice/viewmodels/line_items_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';

import 'package:carenest/app/services/notificationservice/fcm_token_manager.dart';

import 'package:carenest/app/features/admin/viewmodels/bank_details_viewmodel.dart';

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

final fcmTokenManagerProvider = Provider<FcmTokenManager>((ref) {
  return FcmTokenManager(apiMethod: ref.read(apiMethodProvider));
});

final userPhotoProvider = FutureProvider.autoDispose<Uint8List?>((ref) async {
  final email = ref.watch(authProvider.select((state) => state.email));
  if (email == null) return null;

  return ref.read(apiMethodProvider).getUserPhoto(email);
});

class UserPhotoService {
  final Map<String, Uint8List> _photoCache = {};
  final ApiMethod _api;

  UserPhotoService({required ApiMethod api}) : _api = api;

  Future<Uint8List?> getUserPhoto(String email) async {
    if (_photoCache.containsKey(email)) {
      return _photoCache[email];
    }

    try {
      final photo = await _api.getUserPhoto(email);
      if (photo != null) {
        _photoCache[email] = photo;
      }
      return photo;
    } catch (_) {
      return null;
    }
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

  Future<void> fetchPhotoData(String email, {bool forceRefresh = false}) async {
    debugPrint(
        "\n=== PhotoDataNotifier.fetchPhotoData called for email: $email (force: $forceRefresh) ===");

    // If not forcing refresh, try to load from cache first for immediate display
    if (!forceRefresh) {
      debugPrint("Checking cache for photo data...");
      final cachedPhoto = await SharedPreferencesUtils().getPhoto(email);
      if (cachedPhoto != null) {
        debugPrint("Found cached photo data, length: ${cachedPhoto.length}");
        // Update state with cached data, set isLoading to false so we show the image immediately
        // We will still fetch from network in background to ensure freshness
        state = state.copyWith(photoData: cachedPhoto, isLoading: false);
      } else {
        state = state.copyWith(isLoading: true);
      }
    } else {
      state = state.copyWith(isLoading: true);
    }

    try {
      debugPrint("Fetching fresh photo data from network...");

      // Always fetch from network to ensure synchronization
      final photoData = await _apiMethod.getUserPhoto(email);
      debugPrint(
          "Network response received, photoData: ${photoData != null ? 'length ${photoData.length}' : 'null'}");

      // Update state with fresh data
      state = state.copyWith(photoData: photoData, isLoading: false);

      // Update cache
      if (photoData != null) {
        debugPrint("Updating cache with fresh photo data...");
        await SharedPreferencesUtils().setPhoto(photoData, email);
        debugPrint("Photo data cache updated successfully");
      } else {
        // If network returns null (e.g. photo removed), clear cache?
        // For now, keep existing behavior or clear if needed.
        debugPrint("No photo data from network");
      }
    } catch (e) {
      debugPrint("Error in fetchPhotoData: $e");
      // Never overwrite existing valid photo data on a failed network fetch.
      // Just stop loading and keep whatever we already have (cached/local).
      state = state.copyWith(isLoading: false);
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

// User Role Provider
final userRoleProvider =
    StateNotifierProvider<UserRoleNotifier, UserRole>((ref) {
  return UserRoleNotifier(
    ref.read(sharedPreferencesProvider),
    ref.read(apiMethodProvider),
  );
});

class UserRoleNotifier extends StateNotifier<UserRole> {
  final SharedPreferencesUtils _sharedPrefs;
  final ApiMethod _apiMethod;

  UserRoleNotifier(this._sharedPrefs, this._apiMethod)
      : super(UserRole.employee) {
    _loadRole();
  }

  Future<void> _loadRole() async {
    final role = _sharedPrefs.getRole();
    debugPrint('👤 UserRoleNotifier: Loaded role from SharedPrefs: $role');
    state = role ?? UserRole.employee;
  }

  Future<void> updateRole(UserRole newRole) async {
    await _sharedPrefs.setRole(newRole);
    state = newRole;
  }

  /// Re-syncs the user's role from the backend to ensure local state is fresh.
  /// Useful for handling role regressions or updates without forcing logout.
  Future<void> refreshRole() async {
    final email = _sharedPrefs.getUserEmail();
    final firebaseUid = _sharedPrefs.getString('firebaseUid');
    final authToken = _sharedPrefs.getAuthToken();

    if (email == null ||
        email.isEmpty ||
        firebaseUid == null ||
        authToken == null) return;

    try {
      // API expects the raw token, not the 'Bearer ' prefixed one
      final idToken = authToken.replaceFirst('Bearer ', '').trim();

      debugPrint('🔄 Refreshing user role from backend for: $email');
      final response = await _apiMethod.syncFirebaseUser(
        firebaseUid: firebaseUid,
        email: email,
        idToken: idToken,
      );

      debugPrint('📥 syncFirebaseUser response: $response');

      if (response['success'] == true) {
        final userData = response['data'] ?? response;
        final newRole = UserRoleResolver.resolve(
          role: userData['role'],
          roles: userData['roles'],
          organizationRole: userData['organizationRole'],
          clientId: userData['clientId']?.toString(),
        );

        debugPrint('✅ Role refreshed: $newRole (was: $state)');
        if (state != newRole) {
          state = newRole;
          await _sharedPrefs.setRole(newRole);
          debugPrint('💾 Local role updated to: $newRole');
        }
      } else {
        debugPrint('❌ refreshRole failed: ${response['message']}');
      }
    } catch (e) {
      debugPrint('❌ Error in refreshRole: $e');
    }
  }
}

final bankDetailsViewModelProvider =
    ChangeNotifierProvider.autoDispose<BankDetailsViewModel>((ref) {
  return BankDetailsViewModel(
    apiMethod: ref.read(apiMethodProvider),
    scope: BankDetailsScope.personal,
  );
});

final scopedBankDetailsViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<BankDetailsViewModel, BankDetailsScope>((ref, scope) {
  return BankDetailsViewModel(
    apiMethod: ref.read(apiMethodProvider),
    scope: scope,
  );
});

final loginViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
  return LoginViewModel(
    ref.read(apiMethodProvider),
    ref.read(sharedPreferencesProvider),
    ref.read(fcmTokenManagerProvider),
  );
});

final signupViewModelProvider =
    ChangeNotifierProvider.autoDispose<SignupViewModel>((ref) {
  return SignupViewModel(ref.read(apiMethodProvider));
});

final forgotPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<ForgotPasswordViewModel>((ref) {
  return ForgotPasswordViewModel(
    ref.read(sharedPreferencesProvider),
    ref.read(apiMethodProvider),
  );
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

// User ID provider - retrieves the current user's unique ID from SharedPreferences
final userIdProvider = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final userId = prefs.getUserId();
  debugPrint('🔍 DEBUG Provider: userIdProvider returning: $userId');
  return userId;
});

// Organization ID provider - retrieves the current organization ID from SharedPreferences
final organizationIdProvider = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final orgId = prefs.getOrganizationId();
  debugPrint('🔍 DEBUG Provider: organizationIdProvider returning: $orgId');
  return orgId;
});

// Business Stats Provider
final businessStatsProvider =
    StateNotifierProvider<BusinessStatsNotifier, BusinessStatsState>((ref) {
  return BusinessStatsNotifier(ref.read(apiMethodProvider));
});

class BusinessStatsState {
  final Map<String, dynamic> stats;
  final bool isLoading;
  final String? error;

  const BusinessStatsState({
    required this.stats,
    this.isLoading = false,
    this.error,
  });

  BusinessStatsState copyWith({
    Map<String, dynamic>? stats,
    bool? isLoading,
    String? error,
  }) {
    return BusinessStatsState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class BusinessStatsNotifier extends StateNotifier<BusinessStatsState> {
  final ApiMethod _apiMethod;

  BusinessStatsNotifier(this._apiMethod)
      : super(BusinessStatsState(
          stats: _defaultBusinessStats(),
        ));

  static Map<String, dynamic> _defaultBusinessStats() {
    return {
      'activeBusinesses': 0,
      'totalClients': 0,
      'totalInvoices': 0,
      'totalRevenue': '\$0.00',
      'rawRevenue': 0
    };
  }

  Future<void> loadBusinessStats(String? organizationId) async {
    if (organizationId == null || organizationId.isEmpty) {
      state = state.copyWith(
          error: 'Organization ID not available', isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiMethod.getInvoiceStats(organizationId);
      Map<String, dynamic> stats = _normalizeBusinessStats(response);

      try {
        final businesses = await _apiMethod.getBusinesses(organizationId);
        if (businesses.isNotEmpty || _toInt(stats['activeBusinesses']) == 0) {
          stats['activeBusinesses'] = businesses.length;
        }
      } catch (_) {}

      try {
        final clients =
            await _apiMethod.getClientsByOrganizationId(organizationId);
        if (clients.isNotEmpty || _toInt(stats['totalClients']) == 0) {
          stats['totalClients'] = clients.length;
        }
      } catch (_) {}

      stats['activeBusinesses'] = _toInt(stats['activeBusinesses']);
      stats['totalClients'] = _toInt(stats['totalClients']);
      stats['totalInvoices'] = _toInt(stats['totalInvoices']);
      stats['totalRevenue'] = _formatRevenueDisplay(stats);

      state = state.copyWith(stats: stats, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Map<String, dynamic> _normalizeBusinessStats(Map<String, dynamic> response) {
    final defaults = _defaultBusinessStats();
    if (response.isEmpty) return defaults;

    dynamic stats = response['data'];
    if (stats is Map<String, dynamic> &&
        stats['data'] is Map<String, dynamic>) {
      stats = stats['data'];
    }
    if (stats is! Map<String, dynamic>) return defaults;

    final normalized = <String, dynamic>{...defaults, ...stats};

    if (!normalized.containsKey('totalRevenue') &&
        normalized['totalAmount'] != null) {
      normalized['totalRevenue'] = normalized['totalAmount'];
    }
    if (!normalized.containsKey('rawRevenue') &&
        normalized['totalAmount'] != null) {
      normalized['rawRevenue'] = normalized['totalAmount'];
    }

    return normalized;
  }

  int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  String _formatRevenueDisplay(Map<String, dynamic> stats) {
    final revenue = stats['totalRevenue'];
    if (revenue is String && revenue.trim().isNotEmpty) return revenue;
    final raw = stats['rawRevenue'];
    final numValue = raw is num
        ? raw.toDouble()
        : (revenue is num ? revenue.toDouble() : 0.0);
    return '\$${numValue.toStringAsFixed(2)}';
  }
}
