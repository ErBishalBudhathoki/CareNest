import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/care_intelligence/models/care_intelligence_models.dart';

class CareIntelligenceRepository {
  final ApiMethod _apiMethod;

  CareIntelligenceRepository(this._apiMethod);

  // ============================================================================
  // Care Intelligence Methods
  // ============================================================================

  Future<Map<String, dynamic>> generateIntelligenceReport({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.generateIntelligenceReport(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'report': IntelligenceReport.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to generate intelligence report'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzeCarePatterns({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _apiMethod.analyzeCarePatterns(
        clientId: clientId,
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'patterns': CarePatterns.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to analyze care patterns'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictCareNeeds({
    required String clientId,
    required String organizationId,
    int horizon = 30,
  }) async {
    try {
      final response = await _apiMethod.predictCareNeeds(
        clientId: clientId,
        organizationId: organizationId,
        horizon: horizon,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'predictions': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to predict care needs'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> optimizeCareDelivery({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.optimizeCareDelivery(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'optimization': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to optimize care delivery'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> generatePersonalizedInsights({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.generatePersonalizedInsights(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'insights': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to generate insights'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Risk Prediction Methods
  // ============================================================================

  Future<Map<String, dynamic>> predictAllRisks({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.predictAllRisks(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'assessment': RiskAssessment.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to predict risks'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictFallsRisk({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.predictFallsRisk(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'fallsRisk': FallsRiskAssessment.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to predict falls risk'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictBehaviorEscalation({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.predictBehaviorEscalation(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'behaviorPrediction': BehaviorEscalationPrediction.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to predict behavior escalation'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictHealthDeterioration({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.predictHealthDeterioration(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'healthPrediction': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to predict health deterioration'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictMedicationRisk({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.predictMedicationRisk(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'medicationRisk': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to predict medication risk'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzeRiskTrends({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _apiMethod.analyzeRiskTrends(
        clientId: clientId,
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'trends': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to analyze risk trends'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Care Planning Methods
  // ============================================================================

  Future<Map<String, dynamic>> generateCarePlan({
    required String clientId,
    required String organizationId,
    Map<String, dynamic>? preferences,
  }) async {
    try {
      final response = await _apiMethod.generateCarePlan(
        clientId: clientId,
        organizationId: organizationId,
        preferences: preferences,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'carePlan': CarePlan.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to generate care plan'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> generateSmartGoals({
    required String clientId,
    required String organizationId,
    List<String>? outcomeAreas,
  }) async {
    try {
      final response = await _apiMethod.generateSmartGoals(
        clientId: clientId,
        organizationId: organizationId,
        outcomeAreas: outcomeAreas,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'goals': (data['goals'] as List)
              .map((g) => SmartGoal.fromJson(g))
              .toList(),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to generate goals'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> recommendServices({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.recommendServices(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'recommendations': (data['recommendations'] as List)
              .map((r) => ServiceRecommendation.fromJson(r))
              .toList(),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to recommend services'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> adaptCarePlan({
    required String planId,
    required String organizationId,
    required Map<String, dynamic> progressData,
  }) async {
    try {
      final response = await _apiMethod.adaptCarePlan(
        planId: planId,
        organizationId: organizationId,
        progressData: progressData,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'adaptedPlan': CarePlan.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to adapt care plan'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> trackGoalProgress({
    required String goalId,
    required String organizationId,
    required Map<String, dynamic> progressUpdate,
  }) async {
    try {
      final response = await _apiMethod.trackGoalProgress(
        goalId: goalId,
        organizationId: organizationId,
        progressUpdate: progressUpdate,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'progress': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to track goal progress'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> generateEvidenceBasedRecommendations({
    required String clientId,
    required String organizationId,
    String? condition,
  }) async {
    try {
      final response = await _apiMethod.generateEvidenceBasedRecommendations(
        clientId: clientId,
        organizationId: organizationId,
        condition: condition,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'recommendations': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to generate recommendations'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Incident Management Methods
  // ============================================================================

  Future<Map<String, dynamic>> reportIncident({
    required String clientId,
    required String organizationId,
    required Map<String, dynamic> incidentData,
  }) async {
    try {
      final response = await _apiMethod.reportIncident(
        clientId: clientId,
        organizationId: organizationId,
        incidentData: incidentData,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'incident': Incident.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to report incident'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzeRootCause({
    required String incidentId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.analyzeRootCause(
        incidentId: incidentId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'analysis': RootCauseAnalysis.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to analyze root cause'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> detectIncidentPatterns({
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _apiMethod.detectCareIncidentPatterns(
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'patterns': IncidentPatterns.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to detect patterns'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictIncidentRecurrence({
    required String incidentId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.predictIncidentRecurrence(
        incidentId: incidentId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'prediction': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to predict recurrence'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> generateCorrectiveActions({
    required String incidentId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.generateCorrectiveActions(
        incidentId: incidentId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'actions': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to generate corrective actions'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Medication Management Methods
  // ============================================================================

  Future<Map<String, dynamic>> checkMedicationInteractions({
    required String clientId,
    required String organizationId,
    required List<String> medications,
  }) async {
    try {
      final response = await _apiMethod.checkMedicationInteractions(
        clientId: clientId,
        organizationId: organizationId,
        medications: medications,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'interactions': (data['interactions'] as List)
              .map((i) => DrugInteraction.fromJson(i))
              .toList(),
          'safetyScore': data['safetyScore'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to check interactions'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> trackMedicationCompliance({
    required String clientId,
    required String organizationId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _apiMethod.trackMedicationCompliance(
        clientId: clientId,
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'compliance': MedicationCompliance.fromJson(response['data']),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to track compliance'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getMedicationAlerts({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.getMedicationAlerts(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'alerts': (data['alerts'] as List)
              .map((a) => MedicationAlert.fromJson(a))
              .toList(),
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to get alerts'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> optimizeMedicationSchedule({
    required String clientId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.optimizeMedicationSchedule(
        clientId: clientId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'schedule': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to optimize schedule'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> monitorMedicationSideEffects({
    required String clientId,
    required String organizationId,
    required Map<String, dynamic> sideEffectData,
  }) async {
    try {
      final response = await _apiMethod.monitorMedicationSideEffects(
        clientId: clientId,
        organizationId: organizationId,
        sideEffectData: sideEffectData,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'monitoring': response['data'],
        };
      }

      return {'success': false, 'message': response['message'] ?? 'Failed to monitor side effects'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
