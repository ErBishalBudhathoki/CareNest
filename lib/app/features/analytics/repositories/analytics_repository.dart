import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/analytics_models.dart';

// Stub repository
class AnalyticsRepository {
  Future<List<FinancialMetric>> fetchFinancials(String orgId, DateTime start, DateTime end) async => [];
  Future<List<UtilizationMetric>> fetchUtilization(String orgId, DateTime start, DateTime end) async => [];
  Future<List<OvertimeMetric>> fetchOvertime(String orgId, DateTime start, DateTime end) async => [];
  Future<List<ReliabilityMetric>> fetchReliability(String orgId, DateTime start, DateTime end) async => [];
}

final analyticsRepositoryProvider = Provider((ref) => AnalyticsRepository());
