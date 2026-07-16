import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carenest/app/features/invoice/repositories/fallback_pricing_repository.dart';
import 'package:carenest/app/features/invoice/providers/fallback_pricing_providers.dart';

part 'fallback_pricing_view_model.freezed.dart';

@freezed
abstract class FallbackPricingState with _$FallbackPricingState {
  const factory FallbackPricingState({
    double? fallbackRate,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool saveSucceeded,
  }) = _FallbackPricingState;
}

class FallbackPricingViewModel extends Notifier<FallbackPricingState> {
  late final FallbackPricingRepository _repository;

  @override
  FallbackPricingState build() {
    _repository = ref.watch(fallbackPricingRepositoryProvider);
    return const FallbackPricingState();
  }

  void resetSaveState() {
    state = state.copyWith(saveSucceeded: false);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void setFallbackRateLocally(double? rate) {
    state = state.copyWith(fallbackRate: rate, errorMessage: null);
  }

  Future<void> loadOrganizationFallbackRate({required String organizationId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final rate = await _repository.getFallbackBaseRate(organizationId: organizationId);
      state = state.copyWith(fallbackRate: rate);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> saveFallbackRate({
    required String organizationId,
    required double fallbackRate,
    required String userEmail,
  }) async {
    if (fallbackRate <= 0) {
      state = state.copyWith(errorMessage: 'Rate must be greater than zero.');
      return;
    }
    
    state = state.copyWith(isLoading: true, errorMessage: null, saveSucceeded: false);
    
    try {
      final persisted = await _repository.setFallbackBaseRate(
        organizationId: organizationId,
        fallbackBaseRate: fallbackRate,
        userEmail: userEmail,
      );
      state = state.copyWith(fallbackRate: persisted, saveSucceeded: true);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), saveSucceeded: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
