import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/payment_repository.dart';

Map<String, dynamic> _dashboardData(Map<String, dynamic> result, String what) {
  if (result['success'] == true && result['data'] is Map) {
    return Map<String, dynamic>.from(result['data'] as Map);
  }
  throw Exception(result['message'] ?? 'Failed to load $what');
}

List<Map<String, dynamic>> _dashboardList(
  Map<String, dynamic> result,
  String what,
) {
  if (result['success'] == true && result['data'] is List) {
    return (result['data'] as List)
        .whereType<Map>()
        .map(Map<String, dynamic>.from)
        .toList();
  }
  throw Exception(result['message'] ?? 'Failed to load $what');
}

final stripeDashboardOverviewProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, organizationId) async {
      final result = await ref
          .watch(paymentRepositoryProvider)
          .getDashboardOverview(organizationId);
      return _dashboardData(result, 'account overview');
    });

final stripeDashboardBalanceProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, organizationId) async {
      final result = await ref
          .watch(paymentRepositoryProvider)
          .getDashboardBalance(organizationId);
      return _dashboardData(result, 'balance');
    });

final stripeDashboardPayoutsProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, organizationId) async {
      final result = await ref
          .watch(paymentRepositoryProvider)
          .getDashboardPayouts(organizationId);
      return _dashboardData(result, 'payouts');
    });

final stripeDashboardRevenueProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, organizationId) async {
      final result = await ref
          .watch(paymentRepositoryProvider)
          .getDashboardRevenue(organizationId);
      return _dashboardData(result, 'revenue');
    });

final stripeDashboardPaymentsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, String>((ref, organizationId) async {
      final result = await ref
          .watch(paymentRepositoryProvider)
          .getDashboardPayments(organizationId);
      return _dashboardList(result, 'payments');
    });

final stripeDashboardRiskProvider = FutureProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, organizationId) async {
      final result = await ref
          .watch(paymentRepositoryProvider)
          .getDashboardRisk(organizationId);
      return _dashboardData(result, 'refunds and disputes');
    });

/// Actions on the dashboard (dev-gated refund). Read providers above refresh
/// automatically via invalidation on success.
class StripeDashboardViewModel extends AsyncNotifier<void> {
  late final PaymentRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.watch(paymentRepositoryProvider);
    return null;
  }

  Future<Map<String, dynamic>> issueRefund({
    required String organizationId,
    required String invoiceId,
    double? amount,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await _repository.issueDashboardRefund(
        organizationId: organizationId,
        invoiceId: invoiceId,
        amount: amount,
      );
      if (result['success'] != true) {
        throw Exception(result['message'] ?? 'Failed to issue refund');
      }
      ref.invalidate(stripeDashboardPaymentsProvider(organizationId));
      ref.invalidate(stripeDashboardRevenueProvider(organizationId));
      ref.invalidate(stripeDashboardRiskProvider(organizationId));
      ref.invalidate(stripeDashboardBalanceProvider(organizationId));
      state = const AsyncData(null);
      return Map<String, dynamic>.from(result['data'] as Map? ?? {});
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

final stripeDashboardViewModelProvider =
    AsyncNotifierProvider<StripeDashboardViewModel, void>(
      StripeDashboardViewModel.new,
    );
