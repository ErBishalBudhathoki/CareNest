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
// needed for ChangeNotifier viewmodels (migrated in Phase 3)

import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';

import 'package:carenest/app/services/notificationservice/fcm_token_manager.dart';

// Global providers
final sharedPreferencesProvider = Provider<SharedPreferencesUtils>((ref) {
  final prefs = SharedPreferencesUtils();
  prefs.init();
  return prefs;
});

final invoiceEmailViewModelProvider =
    NotifierProvider<InvoiceEmailViewModel, int>(InvoiceEmailViewModel.new);

// Navigation providers
final navigationKeyProvider = Provider(
  (ref) => GlobalKey<NavigatorState>(debugLabel: 'navigation_key_provider'),
);

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
  late final ApiMethod _api;

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
final photoDataProvider = NotifierProvider<PhotoDataNotifier, PhotoDataState>(
  PhotoDataNotifier.new,
);

class PhotoDataState {
  final Uint8List? photoData;
  final bool isLoading;
  final String? error;

  const PhotoDataState({this.photoData, this.isLoading = false, this.error});

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

class PhotoDataNotifier extends Notifier<PhotoDataState> {
  late final ApiMethod _apiMethod;
  Future<void>? _fetchInFlight;
  DateTime? _lastFetchAt;
  static const Duration _fetchCooldown = Duration(seconds: 30);

  @override
  PhotoDataState build() {
    _apiMethod = ref.watch(apiMethodProvider);
    return const PhotoDataState();
  }

  Future<void> fetchPhotoData(String email, {bool forceRefresh = false}) async {
    debugPrint(
      "\n=== PhotoDataNotifier.fetchPhotoData called for email: $email (force: $forceRefresh) ===",
    );

    if (_fetchInFlight != null) {
      debugPrint("fetchPhotoData: already in-flight, reusing");
      return _fetchInFlight;
    }
    final now = DateTime.now();
    if (!forceRefresh &&
        _lastFetchAt != null &&
        now.difference(_lastFetchAt!) < _fetchCooldown) {
      debugPrint("fetchPhotoData: skipping (fetched "
          "${now.difference(_lastFetchAt!).inSeconds}s ago)");
      return;
    }
    _lastFetchAt = now;
    _fetchInFlight = _fetchPhotoDataImpl(email, forceRefresh: forceRefresh);
    try {
      await _fetchInFlight;
    } finally {
      _fetchInFlight = null;
    }
  }

  Future<void> _fetchPhotoDataImpl(String email,
      {bool forceRefresh = false}) async {

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
        "Network response received, photoData: ${photoData != null ? 'length ${photoData.length}' : 'null'}",
      );

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
    NotifierProvider<AppointmentNotifier, AppointmentState>(
      AppointmentNotifier.new,
    );

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

class AppointmentNotifier extends Notifier<AppointmentState> {
  late final ApiMethod _apiMethod;

  @override
  AppointmentState build() {
    _apiMethod = ref.watch(apiMethodProvider);
    return const AppointmentState();
  }

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
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

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

final timerServiceProvider =
    NotifierProvider<TimerServiceNotifier, TimerService>(
      TimerServiceNotifier.new,
    );

class TimerState {
  //final bool isRunning;
  final Duration elapsedTime;
  Timer? timer; // Timer for the client
  int elapsedSeconds = 0; // Elapsed time in seconds
  bool isRunning = false; // Whether the timer is running
  DateTime startTime = DateTime.now(); // Start time of the timer

  TimerState({this.isRunning = false, this.elapsedTime = Duration.zero});

  TimerState copyWith({bool? isRunning, Duration? elapsedTime}) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      elapsedTime: elapsedTime ?? this.elapsedTime,
    );
  }
}

class TimerServiceNotifier extends Notifier<TimerService> {
  @override
  TimerService build() => TimerService();
}

final shiftDataProvider = NotifierProvider<ShiftDataNotifier, List<dynamic>>(
  ShiftDataNotifier.new,
);

class ShiftDataNotifier extends Notifier<List<dynamic>> {
  @override
  List<dynamic> build() => [];

  void updateShifts(List<dynamic> newShifts) {
    state = newShifts;
  }

  void markShiftCompleted(int index) {
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) {...state[i], 'isCompleted': true} else state[i],
    ];
  }
}

// User Role Provider
final userRoleProvider = NotifierProvider<UserRoleNotifier, UserRole>(
  UserRoleNotifier.new,
);

class UserRoleNotifier extends Notifier<UserRole> {
  late final SharedPreferencesUtils _sharedPrefs;
  late final ApiMethod _apiMethod;
  Future<void>? _refreshInFlight;
  DateTime? _lastRefreshAt;
  static const Duration _refreshCooldown = Duration(seconds: 30);

  @override
  UserRole build() {
    _sharedPrefs = ref.watch(sharedPreferencesProvider);
    _apiMethod = ref.watch(apiMethodProvider);
    final role = _sharedPrefs.getRole();
    debugPrint('👤 UserRoleNotifier: Loaded role from SharedPrefs: $role');
    return role ?? UserRole.employee;
  }

  Future<void> updateRole(UserRole newRole) async {
    await _sharedPrefs.setRole(newRole);
    state = newRole;
  }

  /// Re-syncs the user's role from the backend to ensure local state is fresh.
  /// Useful for handling role regressions or updates without forcing logout.
  Future<void> refreshRole() async {
    if (_refreshInFlight != null) {
      debugPrint('refreshRole: already in-flight, reusing');
      return _refreshInFlight;
    }
    final now = DateTime.now();
    if (_lastRefreshAt != null &&
        now.difference(_lastRefreshAt!) < _refreshCooldown) {
      debugPrint(
        'refreshRole: skipping (refreshed '
        '${now.difference(_lastRefreshAt!).inSeconds}s ago)',
      );
      return;
    }
    _lastRefreshAt = now;
    _refreshInFlight = _doRefreshRole();
    try {
      await _refreshInFlight;
    } finally {
      _refreshInFlight = null;
    }
  }

  Future<void> _doRefreshRole() async {
    final email = _sharedPrefs.getUserEmail();
    final firebaseUid = _sharedPrefs.getString('firebaseUid');
    final authToken = _sharedPrefs.getAuthToken();

    if (email == null ||
        email.isEmpty ||
        firebaseUid == null ||
        authToken == null)
      return;

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

final loginViewModelProvider =
    NotifierProvider.autoDispose<LoginViewModel, int>(LoginViewModel.new);

final signupViewModelProvider =
    NotifierProvider.autoDispose<SignupViewModel, int>(SignupViewModel.new);

final forgotPasswordViewModelProvider =
    NotifierProvider.autoDispose<ForgotPasswordViewModel, bool>(
      ForgotPasswordViewModel.new,
    );

final verifyOTPViewModelProvider =
    NotifierProvider.autoDispose<VerifyOTPViewModel, void>(
      VerifyOTPViewModel.new,
    );

final addBusinessViewModelProvider =
    NotifierProvider<AddBusinessViewModel, int>(() => AddBusinessViewModel());

final sharedPreferencesUtilsProvider = Provider<SharedPreferencesUtils>(
  (ref) => SharedPreferencesUtils(),
);

/// Provider for line item view model that handles support items
final lineItemViewModelProvider =
    // ignore: deprecated_member_use
    NotifierProvider<LineItemViewModel, List<Map<String, dynamic>>>(
      LineItemViewModel.new,
    );

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
    NotifierProvider<BusinessStatsNotifier, BusinessStatsState>(
      BusinessStatsNotifier.new,
    );

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

class BusinessStatsNotifier extends Notifier<BusinessStatsState> {
  late final ApiMethod _apiMethod;

  @override
  BusinessStatsState build() {
    _apiMethod = ref.watch(apiMethodProvider);
    return BusinessStatsState(stats: _defaultBusinessStats());
  }

  static Map<String, dynamic> _defaultBusinessStats() {
    return {
      'activeBusinesses': 0,
      'totalClients': 0,
      'totalInvoices': 0,
      'totalRevenue': '\$0.00',
      'rawRevenue': 0,
    };
  }

  Future<void> loadBusinessStats(String? organizationId) async {
    if (organizationId == null || organizationId.isEmpty) {
      state = state.copyWith(
        error: 'Organization ID not available',
        isLoading: false,
      );
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
        final clients = await _apiMethod.getClientsByOrganizationId(
          organizationId,
        );
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
