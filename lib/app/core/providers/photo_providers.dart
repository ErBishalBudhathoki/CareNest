// Photo Providers - User photo and image management
//
// Contains providers for user profile photos with caching support.

import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/core/providers/auth_providers.dart';

// ==================== PHOTO DATA STATE ====================

// State for user photo data with loading and error tracking
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

// Notifier for photo data state management with caching
class PhotoDataNotifier extends StateNotifier<PhotoDataState> {
  final ApiMethod _apiMethod;

  PhotoDataNotifier(this._apiMethod) : super(const PhotoDataState());

  /// Fetch photo data with optional cache-first strategy
  Future<void> fetchPhotoData(String email, {bool forceRefresh = false}) async {
    // Try cache first if not forcing refresh
    if (!forceRefresh) {
      final cachedPhoto = await SharedPreferencesUtils().getPhoto(email);
      if (cachedPhoto != null) {
        state = state.copyWith(photoData: cachedPhoto, isLoading: false);
      } else {
        state = state.copyWith(isLoading: true);
      }
    } else {
      state = state.copyWith(isLoading: true);
    }

    try {
      // Fetch from network
      final photoData = await _apiMethod.getUserPhoto(email);
      state = state.copyWith(photoData: photoData, isLoading: false);

      // Update cache
      if (photoData != null) {
        await SharedPreferencesUtils().setPhoto(photoData, email);
      }
    } catch (e) {
      if (state.photoData == null) {
        state = state.copyWith(error: e.toString(), isLoading: false);
      } else {
        state = state.copyWith(isLoading: false); // Keep cached data
      }
    }
  }

  /// Update photo data locally (typically after upload)
  Future<void> updatePhotoData(Uint8List photoData) async {
    state = state.copyWith(photoData: photoData);
  }

  /// Clear photo data (typically on logout)
  void clearPhotoData() {
    state = const PhotoDataState();
  }
}

// Photo data provider
final photoDataProvider = StateNotifierProvider<PhotoDataNotifier, PhotoDataState>((ref) {
  return PhotoDataNotifier(ref.read(apiMethodProvider));
});

// Auto-disposing user photo provider that watches auth state
final userPhotoProvider = FutureProvider.autoDispose<Uint8List?>((ref) async {
  final email = ref.watch(authProvider.select((state) => state.email));
  if (email == null) return null;
  return ref.read(apiMethodProvider).getUserPhoto(email);
});

// ==================== PHOTO SERVICE ====================

// Service for user photo operations with in-memory caching
class UserPhotoService {
  final Map<String, Uint8List> _photoCache = {};
  final ApiMethod _api = ApiMethod();

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
