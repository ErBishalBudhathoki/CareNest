import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/workforce_optimization/models/workforce_models.dart';

class WorkforceRepository {
  final ApiMethod _apiMethod;

  WorkforceRepository(this._apiMethod);

  // ============================================================================
  // Workforce Planning Methods
  // ============================================================================

  Future<Map<String, dynamic>> forecastDemand({
    required String organizationId,
    required String startDate,
    required String endDate,
    int horizon = 30,
  }) async {
    try {
      final response = await _apiMethod.forecastDemand({
        'organizationId': organizationId,
        'startDate': startDate,
        'endDate': endDate,
        'horizon': horizon,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'forecast': (data['forecast'] as List)
              .map((f) => DemandForecast.fromJson(f))
              .toList(),
          'seasonality': data['seasonality'],
          'confidence': ForecastConfidence.fromJson(data['confidence']),
          'historicalData': data['historicalData'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to forecast demand',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> optimizeStaffing({
    required String organizationId,
    required List<Map<String, dynamic>> forecastData,
    required Map<String, dynamic> constraints,
  }) async {
    try {
      final response = await _apiMethod.optimizeStaffing({
        'organizationId': organizationId,
        'forecastData': forecastData,
        'constraints': constraints,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'requirements': data['requirements'],
          'optimization': WorkforcePlan.fromJson(data['optimization']),
          'skillGaps': (data['skillGaps'] as List)
              .map((g) => SkillGap.fromJson(g))
              .toList(),
          'costProjection': data['costProjection'],
          'recommendedActions': data['recommendedActions'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to optimize staffing',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictTurnover({
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.predictTurnover({
        'organizationId': organizationId,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'predictions': (data['predictions'] as List)
              .map((p) => TurnoverPrediction.fromJson(p))
              .toList(),
          'summary': data['summary'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to predict turnover',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzeScenarios({
    required String organizationId,
    required List<Map<String, dynamic>> scenarios,
  }) async {
    try {
      final response = await _apiMethod.analyzeScenarios({
        'organizationId': organizationId,
        'scenarios': scenarios,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'scenarios': (data['scenarios'] as List)
              .map((s) => ScenarioAnalysis.fromJson(s))
              .toList(),
          'comparison': data['comparison'],
          'recommendation': data['recommendation'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze scenarios',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Resource Allocation Methods
  // ============================================================================

  Future<Map<String, dynamic>> optimizeAllocation({
    required String organizationId,
    required String date,
    List<Map<String, dynamic>>? appointments,
    Map<String, dynamic>? constraints,
  }) async {
    try {
      final response = await _apiMethod.optimizeAllocation({
        'organizationId': organizationId,
        'date': date,
        'appointments': ?appointments,
        'constraints': ?constraints,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'allocations': (data['allocations'] as List)
              .map((a) => ResourceAllocation.fromJson(a))
              .toList(),
          'metrics': AllocationMetrics.fromJson(data['metrics']),
          'unassigned': data['unassigned'],
          'conflicts': data['conflicts'],
          'recommendations': data['recommendations'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to optimize allocation',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> reallocateResources({
    required String organizationId,
    required String triggerId,
    required String reason,
  }) async {
    try {
      final response = await _apiMethod.reallocateResources({
        'organizationId': organizationId,
        'triggerId': triggerId,
        'reason': reason,
      });

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'affected': response['data']['affected'],
          'reallocated': response['data']['reallocated'],
          'failed': response['data']['failed'],
          'details': response['data']['details'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to reallocate resources',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getAllocationRecommendations({
    required String appointmentId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.getAllocationRecommendations(
        appointmentId: appointmentId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'recommendations': (data['recommendations'] as List)
              .map((r) => WorkerRecommendation.fromJson(r))
              .toList(),
          'appointment': data['appointment'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to get recommendations',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzeWorkloadBalance({
    required String organizationId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _apiMethod.analyzeWorkloadBalance(
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'workloads': (data['workloads'] as List)
              .map((w) => WorkloadAnalysis.fromJson(w))
              .toList(),
          'metrics': data['metrics'],
          'recommendations': data['recommendations'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze workload',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Performance Analytics Methods
  // ============================================================================

  Future<Map<String, dynamic>> getPerformanceAnalytics({
    required String organizationId,
    String? employeeId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _apiMethod.getPerformanceAnalytics(
        organizationId: organizationId,
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'analytics': (data['analytics'] as List)
              .map((a) => PerformanceAnalytics.fromJson(a))
              .toList(),
          'summary': data['summary'],
          'insights': data['insights'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to get analytics',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzePerformanceTrends({
    required String employeeId,
    required String organizationId,
    String period = 'monthly',
  }) async {
    try {
      final response = await _apiMethod.analyzePerformanceTrends(
        employeeId: employeeId,
        organizationId: organizationId,
        period: period,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'historical': data['historical'],
          'trends': data['trends'],
          'anomalies': data['anomalies'],
          'forecast': data['forecast'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze trends',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictPerformance({
    required String employeeId,
    required Map<String, dynamic> features,
  }) async {
    try {
      final response = await _apiMethod.predictPerformance({
        'employeeId': employeeId,
        'features': features,
      });

      if (response['success'] == true && response['data'] != null) {
        return {'success': true, 'prediction': response['data']};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to predict performance',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> trackSkillProficiency({
    required String employeeId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.trackSkillProficiency(
        employeeId: employeeId,
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'proficiency': (data['proficiency'] as List)
              .map((p) => SkillProficiency.fromJson(p))
              .toList(),
          'overallScore': data['overallScore'],
          'gaps': data['gaps'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to track skills',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Quality Assurance Methods
  // ============================================================================

  Future<Map<String, dynamic>> scoreServiceQuality({
    required String appointmentId,
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.scoreServiceQuality({
        'appointmentId': appointmentId,
        'organizationId': organizationId,
      });

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'qualityScore': QualityScore.fromJson(response['data']),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to score quality',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> performComplianceCheck({
    required String organizationId,
    String? employeeId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _apiMethod.performComplianceCheck({
        'organizationId': organizationId,
        'employeeId': ?employeeId,
        'startDate': ?startDate,
        'endDate': ?endDate,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'checks': (data['checks'] as List)
              .map((c) => ComplianceCheck.fromJson(c))
              .toList(),
          'summary': data['summary'],
          'recommendations': data['recommendations'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to check compliance',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzeFeedbackSentiment({
    required String organizationId,
    String? employeeId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _apiMethod.analyzeFeedbackSentiment({
        'organizationId': organizationId,
        'employeeId': ?employeeId,
        'startDate': ?startDate,
        'endDate': ?endDate,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'sentiments': (data['sentiments'] as List)
              .map((s) => SentimentAnalysis.fromJson(s))
              .toList(),
          'summary': data['summary'],
          'insights': data['insights'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze sentiment',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> assessRisk({
    required String organizationId,
    String? appointmentId,
  }) async {
    try {
      final response = await _apiMethod.assessRisk({
        'organizationId': organizationId,
        'appointmentId': ?appointmentId,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'assessments': (data['assessments'] as List)
              .map((a) => RiskAssessment.fromJson(a))
              .toList(),
          'summary': data['summary'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to assess risk',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> detectIncidentPatterns({
    required String organizationId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _apiMethod.detectIncidentPatterns(
        organizationId: organizationId,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'patterns': IncidentPattern.fromJson(response['data']),
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

  Future<Map<String, dynamic>> generateAuditTrail({
    required String organizationId,
    required String entityType,
    required String entityId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _apiMethod.generateAuditTrail(
        organizationId: organizationId,
        entityType: entityType,
        entityId: entityId,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        return {'success': true, 'auditTrail': response['data']};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to generate audit trail',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // Business Intelligence Methods
  // ============================================================================

  Future<Map<String, dynamic>> getExecutiveDashboard({
    required String organizationId,
    String period = 'month',
  }) async {
    try {
      final response = await _apiMethod.getExecutiveDashboard(
        organizationId: organizationId,
        period: period,
      );

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'dashboard': ExecutiveDashboard.fromJson(response['data']),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to get dashboard',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> forecastRevenue({
    required String organizationId,
    int horizon = 12,
  }) async {
    try {
      final response = await _apiMethod.forecastRevenue({
        'organizationId': organizationId,
        'horizon': horizon,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'historical': data['historical'],
          'forecast': (data['forecast'] as List)
              .map((f) => RevenueForecast.fromJson(f))
              .toList(),
          'confidence': data['confidence'],
          'opportunities': data['opportunities'],
          'projectedGrowth': data['projectedGrowth'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to forecast revenue',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> predictChurn({
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.predictChurn({
        'organizationId': organizationId,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'predictions': (data['predictions'] as List)
              .map((p) => ChurnPrediction.fromJson(p))
              .toList(),
          'summary': data['summary'],
          'recommendations': data['recommendations'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to predict churn',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzeProfitability({
    required String organizationId,
    String dimension = 'service',
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _apiMethod.analyzeProfitability(
        organizationId: organizationId,
        dimension: dimension,
        startDate: startDate,
        endDate: endDate,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'analysis': (data['analysis'] as List)
              .map((a) => ProfitabilityAnalysis.fromJson(a))
              .toList(),
          'opportunities': data['opportunities'],
          'summary': data['summary'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze profitability',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> analyzeWhatIfScenario({
    required String organizationId,
    required Map<String, dynamic> scenario,
  }) async {
    try {
      final response = await _apiMethod.analyzeWhatIfScenario({
        'organizationId': organizationId,
        'scenario': scenario,
      });

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'scenario': WhatIfScenario.fromJson(response['data']),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to analyze scenario',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> calculateCustomerLifetimeValue({
    required String organizationId,
    String? clientId,
  }) async {
    try {
      final response = await _apiMethod.calculateCustomerLifetimeValue(
        organizationId: organizationId,
        clientId: clientId,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'clvAnalysis': (data['clvAnalysis'] as List)
              .map((c) => CustomerLifetimeValue.fromJson(c))
              .toList(),
          'summary': data['summary'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to calculate CLV',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ============================================================================
  // ML Model Methods
  // ============================================================================

  Future<Map<String, dynamic>> trainModel({
    required String modelType,
    required List<Map<String, dynamic>> trainingData,
    required Map<String, dynamic> hyperparameters,
  }) async {
    try {
      final response = await _apiMethod.trainModel({
        'modelType': modelType,
        'trainingData': trainingData,
        'hyperparameters': hyperparameters,
      });

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'model': MLModel.fromJson(data['model']),
          'trainingLog': data['trainingLog'],
          'message': data['message'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to train model',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> evaluateModel({
    required String modelId,
    required List<Map<String, dynamic>> testData,
  }) async {
    try {
      final response = await _apiMethod.evaluateModel({
        'modelId': modelId,
        'testData': testData,
      });

      if (response['success'] == true && response['data'] != null) {
        return {'success': true, 'evaluation': response['data']};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to evaluate model',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> mlPredict({
    required String modelId,
    required Map<String, dynamic> features,
  }) async {
    try {
      final response = await _apiMethod.mlPredict({
        'modelId': modelId,
        'features': features,
      });

      if (response['success'] == true && response['data'] != null) {
        return {
          'success': true,
          'prediction': MLPrediction.fromJson(response['data']),
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to make prediction',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> listMLModels({
    required String organizationId,
  }) async {
    try {
      final response = await _apiMethod.listMLModels(
        organizationId: organizationId,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        return {
          'success': true,
          'models': (data['models'] as List)
              .map((m) => MLModel.fromJson(m))
              .toList(),
          'total': data['total'],
        };
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to list models',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getMLModelInfo({required String modelId}) async {
    try {
      final response = await _apiMethod.getMLModelInfo(modelId: modelId);

      if (response['success'] == true && response['data'] != null) {
        return {'success': true, 'model': MLModel.fromJson(response['data'])};
      }

      return {
        'success': false,
        'message': response['message'] ?? 'Failed to get model info',
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
