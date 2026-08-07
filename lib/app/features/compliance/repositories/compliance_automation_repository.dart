import 'package:flutter/foundation.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Repository for compliance automation operations
class ComplianceAutomationRepository {
  final Ref ref;

  ComplianceAutomationRepository(this.ref);

  /// Run compliance scan for organization
  Future<Map<String, dynamic>> runComplianceScan({
    required String organizationId,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.runComplianceScan(organizationId: organizationId);
    } catch (e) {
      debugPrint('Error running compliance scan: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get compliance score for worker
  Future<Map<String, dynamic>> getComplianceScore({
    required String workerId,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getComplianceScore(workerId: workerId);
    } catch (e) {
      debugPrint('Error getting compliance score: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get expiring documents
  Future<Map<String, dynamic>> getExpiringDocuments({
    required String organizationId,
    int? daysAhead,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getExpiringDocuments(
        organizationId: organizationId,
        daysAhead: daysAhead,
      );
    } catch (e) {
      debugPrint('Error getting expiring documents: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Generate compliance report
  Future<Map<String, dynamic>> generateComplianceReport({
    required String organizationId,
    required String reportType,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.generateComplianceReport(
        organizationId: organizationId,
        reportType: reportType,
      );
    } catch (e) {
      debugPrint('Error generating compliance report: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Get compliance trends
  Future<Map<String, dynamic>> getComplianceTrends({
    required String organizationId,
    int? months,
  }) async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      return await apiMethod.getComplianceTrends(
        organizationId: organizationId,
        months: months,
      );
    } catch (e) {
      debugPrint('Error getting compliance trends: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}

/// Provider for compliance automation repository
final complianceAutomationRepositoryProvider =
    Provider<ComplianceAutomationRepository>((ref) {
      return ComplianceAutomationRepository(ref);
    });
