import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/care_intelligence/models/care_intelligence_models.dart';

class CareIntelligenceRepository {
  final ApiMethod _apiMethod;

  CareIntelligenceRepository(this._apiMethod);

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  Map<String, dynamic>? _extractMapPayload(
    Map<String, dynamic> response, {
    List<String> keys = const [],
  }) {
    final fromData = _asMap(response['data']);
    if (fromData != null) return fromData;

    for (final key in keys) {
      final fromKey = _asMap(response[key]);
      if (fromKey != null) return fromKey;
    }

    return null;
  }

  List<dynamic>? _extractListPayload(
    Map<String, dynamic> response, {
    List<String> keys = const [],
  }) {
    final fromData = response['data'];
    if (fromData is List) return fromData;

    for (final key in keys) {
      final value = response[key];
      if (value is List) return value;
    }

    return null;
  }

  double? _asDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is num) return value.toDouble();
    return null;
  }

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

      final reportData = _extractMapPayload(response, keys: ['report']);
      if (response['success'] == true && reportData != null) {
        return {
          'success': true,
          'report': IntelligenceReport.fromJson(reportData),
        };
      }

      return {
        'success': false,
        'message':
            response['message'] ?? 'Failed to generate intelligence report',
      };
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

      final patternData = _extractMapPayload(response, keys: ['patterns']);
      if (response['success'] == true && patternData != null) {
        return {
          'success': true,
          'patterns': CarePatterns.fromJson(patternData),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze care patterns',
      };
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

      Map<String, dynamic>? predictionData = _extractMapPayload(
        response,
        keys: ['predictions'],
      );
      if (predictionData == null) {
        final predictions = response['predictions'];
        if (predictions is List || response['summary'] != null) {
          predictionData = {
            if (predictions is List) 'predictions': predictions,
            if (response['summary'] != null) 'summary': response['summary'],
          };
        }
      }

      if (response['success'] == true &&
          predictionData != null &&
          predictionData.isNotEmpty) {
        return {'success': true, 'predictions': predictionData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to predict care needs',
      };
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

      final optimizationData = _extractMapPayload(
        response,
        keys: ['optimization'],
      );
      if (response['success'] == true && optimizationData != null) {
        return {'success': true, 'optimization': optimizationData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to optimize care delivery',
      };
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

      final insightsData = _extractMapPayload(response, keys: ['insights']);
      if (response['success'] == true && insightsData != null) {
        return {'success': true, 'insights': insightsData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to generate insights',
      };
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

      final assessmentData = _extractMapPayload(
        response,
        keys: ['assessment', 'risks'],
      );
      if (response['success'] == true && assessmentData != null) {
        return {
          'success': true,
          'assessment': RiskAssessment.fromJson(assessmentData),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to predict risks',
      };
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

      final fallsData = _extractMapPayload(
        response,
        keys: ['fallsRisk', 'assessment'],
      );
      if (response['success'] == true && fallsData != null) {
        return {
          'success': true,
          'fallsRisk': FallsRiskAssessment.fromJson(fallsData),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to predict falls risk',
      };
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

      final behaviorData = _extractMapPayload(
        response,
        keys: ['behaviorPrediction', 'prediction'],
      );
      if (response['success'] == true && behaviorData != null) {
        return {
          'success': true,
          'behaviorPrediction': BehaviorEscalationPrediction.fromJson(
            behaviorData,
          ),
        };
      }

      return {
        'success': false,
        'message':
            response['message'] ?? 'Failed to predict behavior escalation',
      };
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

      final healthData = _extractMapPayload(
        response,
        keys: ['healthPrediction', 'prediction'],
      );
      if (response['success'] == true && healthData != null) {
        return {'success': true, 'healthPrediction': healthData};
      }

      return {
        'success': false,
        'message':
            response['message'] ?? 'Failed to predict health deterioration',
      };
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

      final medicationRiskData = _extractMapPayload(
        response,
        keys: ['medicationRisk', 'risk'],
      );
      if (response['success'] == true && medicationRiskData != null) {
        return {'success': true, 'medicationRisk': medicationRiskData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to predict medication risk',
      };
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

      final trendData = _extractMapPayload(response, keys: ['trends']);
      if (response['success'] == true && trendData != null) {
        return {'success': true, 'trends': trendData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze risk trends',
      };
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

      final carePlanData = _extractMapPayload(
        response,
        keys: ['carePlan', 'plan'],
      );
      if (response['success'] == true && carePlanData != null) {
        return {'success': true, 'carePlan': CarePlan.fromJson(carePlanData)};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to generate care plan',
      };
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

      List<dynamic>? goals = _extractListPayload(response, keys: ['goals']);
      if (goals == null) {
        final data = _extractMapPayload(response, keys: []);
        goals = data?['goals'] as List?;
      }

      if (response['success'] == true && goals != null) {
        return {
          'success': true,
          'goals': goals
              .map((goal) => SmartGoal.fromJson(_asMap(goal)!))
              .toList(),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to generate goals',
      };
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

      List<dynamic>? recommendations = _extractListPayload(
        response,
        keys: ['recommendations'],
      );
      if (recommendations == null) {
        final data = _extractMapPayload(response, keys: []);
        recommendations = data?['recommendations'] as List?;
      }

      if (response['success'] == true && recommendations != null) {
        return {
          'success': true,
          'recommendations': recommendations
              .map((item) => ServiceRecommendation.fromJson(_asMap(item)!))
              .toList(),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to recommend services',
      };
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

      final adaptedPlanData = _extractMapPayload(
        response,
        keys: ['adaptedPlan', 'carePlan', 'plan'],
      );
      if (response['success'] == true && adaptedPlanData != null) {
        return {
          'success': true,
          'adaptedPlan': CarePlan.fromJson(adaptedPlanData),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to adapt care plan',
      };
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

      final progressData = _extractMapPayload(response, keys: ['progress']);
      if (response['success'] == true && progressData != null) {
        return {'success': true, 'progress': progressData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to track goal progress',
      };
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

      final recommendationData = _extractMapPayload(
        response,
        keys: ['recommendations'],
      );
      if (response['success'] == true && recommendationData != null) {
        return {'success': true, 'recommendations': recommendationData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to generate recommendations',
      };
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

      final incidentPayload = _extractMapPayload(response, keys: ['incident']);
      if (response['success'] == true && incidentPayload != null) {
        return {
          'success': true,
          'incident': Incident.fromJson(incidentPayload),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to report incident',
      };
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

      final analysisData = _extractMapPayload(response, keys: ['analysis']);
      if (response['success'] == true && analysisData != null) {
        return {
          'success': true,
          'analysis': RootCauseAnalysis.fromJson(analysisData),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze root cause',
      };
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

      final patternData = _extractMapPayload(response, keys: ['patterns']);
      if (response['success'] == true && patternData != null) {
        final normalized = Map<String, dynamic>.from(patternData);
        normalized['timeframe'] =
            normalized['timeframe'] ??
            ((startDate != null && endDate != null)
                ? '$startDate to $endDate'
                : 'last_30_days');

        return {
          'success': true,
          'patterns': IncidentPatternData.fromJson(normalized),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to detect patterns',
      };
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

      final predictionData = _extractMapPayload(response, keys: ['prediction']);
      if (response['success'] == true && predictionData != null) {
        return {'success': true, 'prediction': predictionData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to predict recurrence',
      };
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

      final actionsData = _extractMapPayload(
        response,
        keys: ['actions', 'actionPlan'],
      );
      if (response['success'] == true && actionsData != null) {
        return {'success': true, 'actions': actionsData};
      }

      return {
        'success': false,
        'message':
            response['message'] ?? 'Failed to generate corrective actions',
      };
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

      final interactionData = _extractMapPayload(response, keys: []);
      final interactionsList =
          _extractListPayload(response, keys: ['interactions']) ??
          interactionData?['interactions'] as List?;

      if (response['success'] == true && interactionsList != null) {
        final source = interactionData ?? response;
        return {
          'success': true,
          'interactions': interactionsList
              .map((item) => DrugInteraction.fromJson(_asMap(item)!))
              .toList(),
          'safetyScore': _asDouble(source['safetyScore']),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to check interactions',
      };
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

      final complianceData = _extractMapPayload(response, keys: ['compliance']);
      if (response['success'] == true && complianceData != null) {
        return {
          'success': true,
          'compliance': MedicationCompliance.fromJson(complianceData),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to track compliance',
      };
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

      final data = _extractMapPayload(response, keys: []);
      final alerts =
          _extractListPayload(response, keys: ['alerts']) ??
          (data?['alerts'] as List?);

      if (response['success'] == true && alerts != null) {
        return {
          'success': true,
          'alerts': alerts
              .map((item) => MedicationAlert.fromJson(_asMap(item)!))
              .toList(),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to get alerts',
      };
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

      final scheduleData = _extractMapPayload(
        response,
        keys: ['schedule', 'optimization'],
      );
      if (response['success'] == true && scheduleData != null) {
        return {'success': true, 'schedule': scheduleData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to optimize schedule',
      };
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

      final monitoringData = _extractMapPayload(response, keys: ['monitoring']);
      if (response['success'] == true && monitoringData != null) {
        return {'success': true, 'monitoring': monitoringData};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to monitor side effects',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
