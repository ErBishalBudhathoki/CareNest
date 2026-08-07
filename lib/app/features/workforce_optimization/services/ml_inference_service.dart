import 'package:carenest/app/features/workforce_optimization/repositories/workforce_repository.dart';
import 'package:carenest/app/features/workforce_optimization/models/workforce_models.dart';

/// ML Inference Service
/// Provides on-device and server-side ML inference capabilities
class MLInferenceService {
  final WorkforceRepository _repository;

  MLInferenceService(this._repository);

  /// Train a new ML model
  Future<Map<String, dynamic>> trainModel({
    required String modelType,
    required List<Map<String, dynamic>> trainingData,
    Map<String, dynamic>? hyperparameters,
  }) async {
    try {
      return await _repository.trainModel(
        modelType: modelType,
        trainingData: trainingData,
        hyperparameters:
            hyperparameters ?? _getDefaultHyperparameters(modelType),
      );
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Evaluate model performance
  Future<Map<String, dynamic>> evaluateModel({
    required String modelId,
    required List<Map<String, dynamic>> testData,
  }) async {
    try {
      return await _repository.evaluateModel(
        modelId: modelId,
        testData: testData,
      );
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  /// Make a single prediction
  Future<MLPrediction?> predict({
    required String modelId,
    required Map<String, dynamic> features,
  }) async {
    try {
      final result = await _repository.mlPredict(
        modelId: modelId,
        features: features,
      );

      if (result['success'] == true) {
        return result['prediction'] as MLPrediction?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Make batch predictions
  Future<List<MLPrediction>> batchPredict({
    required String modelId,
    required List<Map<String, dynamic>> batchFeatures,
  }) async {
    try {
      final predictions = <MLPrediction>[];

      for (final features in batchFeatures) {
        final prediction = await predict(modelId: modelId, features: features);
        if (prediction != null) {
          predictions.add(prediction);
        }
      }

      return predictions;
    } catch (e) {
      return [];
    }
  }

  /// List available models
  Future<List<MLModel>> listModels({required String organizationId}) async {
    try {
      final result = await _repository.listMLModels(
        organizationId: organizationId,
      );

      if (result['success'] == true) {
        return result['models'] as List<MLModel>;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get model information
  Future<MLModel?> getModelInfo({required String modelId}) async {
    try {
      final result = await _repository.getMLModelInfo(modelId: modelId);

      if (result['success'] == true) {
        return result['model'] as MLModel?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Predict worker performance
  Future<Map<String, dynamic>> predictWorkerPerformance({
    required String workerId,
    required int experienceYears,
    required int completedAppointments,
    required double averageRating,
    required int trainingHours,
    required double skillScore,
  }) async {
    final features = {
      'workerId': workerId,
      'experienceYears': experienceYears,
      'completedAppointments': completedAppointments,
      'averageRating': averageRating,
      'trainingHours': trainingHours,
      'skillScore': skillScore,
    };

    final prediction = await predict(
      modelId: 'performance_predictor',
      features: features,
    );

    if (prediction != null) {
      return {
        'success': true,
        'prediction': prediction,
        'performanceClass': prediction.prediction.predictedClass,
        'confidence': prediction.confidence,
      };
    }

    return {'success': false, 'message': 'Prediction failed'};
  }

  /// Predict client churn risk
  Future<Map<String, dynamic>> predictClientChurn({
    required String clientId,
    required int daysSinceLastAppointment,
    required int totalAppointments,
    required double totalSpent,
    required double avgRating,
  }) async {
    final features = {
      'clientId': clientId,
      'recency': daysSinceLastAppointment,
      'frequency': totalAppointments,
      'monetary': totalSpent,
      'satisfaction': avgRating,
    };

    final prediction = await predict(
      modelId: 'churn_predictor',
      features: features,
    );

    if (prediction != null) {
      return {
        'success': true,
        'prediction': prediction,
        'churnRisk': prediction.prediction.predictedClass,
        'confidence': prediction.confidence,
      };
    }

    return {'success': false, 'message': 'Prediction failed'};
  }

  /// Predict service quality score
  Future<Map<String, dynamic>> predictQualityScore({
    required String appointmentId,
    required double punctuality,
    required double completion,
    required double documentation,
    required double compliance,
  }) async {
    final features = {
      'appointmentId': appointmentId,
      'punctuality': punctuality,
      'completion': completion,
      'documentation': documentation,
      'compliance': compliance,
    };

    final prediction = await predict(
      modelId: 'quality_scorer',
      features: features,
    );

    if (prediction != null) {
      return {
        'success': true,
        'prediction': prediction,
        'qualityScore': prediction.prediction.score,
        'confidence': prediction.confidence,
      };
    }

    return {'success': false, 'message': 'Prediction failed'};
  }

  /// Calculate feature importance
  Map<String, double> calculateFeatureImportance(
    List<Map<String, dynamic>> predictions,
  ) {
    // Simplified feature importance calculation
    final importance = <String, double>{};

    for (final prediction in predictions) {
      final features = prediction['features'] as Map<String, dynamic>?;
      if (features != null) {
        for (final entry in features.entries) {
          importance[entry.key] = (importance[entry.key] ?? 0.0) + 1.0;
        }
      }
    }

    // Normalize
    final total = importance.values.fold<double>(0.0, (sum, val) => sum + val);
    if (total > 0) {
      importance.updateAll((key, value) => value / total);
    }

    return importance;
  }

  /// Get default hyperparameters for model type
  Map<String, dynamic> _getDefaultHyperparameters(String modelType) {
    switch (modelType) {
      case 'classification':
        return {
          'learningRate': 0.001,
          'epochs': 100,
          'batchSize': 32,
          'optimizer': 'adam',
        };
      case 'regression':
        return {
          'learningRate': 0.001,
          'epochs': 100,
          'batchSize': 32,
          'optimizer': 'adam',
        };
      default:
        return {'learningRate': 0.001, 'epochs': 100, 'batchSize': 32};
    }
  }

  /// Validate model performance
  bool validateModelPerformance(MLMetrics metrics, {double threshold = 0.8}) {
    return metrics.accuracy >= threshold &&
        metrics.precision >= threshold &&
        metrics.recall >= threshold;
  }

  /// Compare two models
  Map<String, dynamic> compareModels(MLModel modelA, MLModel modelB) {
    final accuracyDiff = modelA.metrics.accuracy - modelB.metrics.accuracy;
    final precisionDiff = modelA.metrics.precision - modelB.metrics.precision;
    final recallDiff = modelA.metrics.recall - modelB.metrics.recall;

    return {
      'winner': accuracyDiff > 0 ? modelA.id : modelB.id,
      'accuracyDifference': accuracyDiff.abs(),
      'precisionDifference': precisionDiff.abs(),
      'recallDifference': recallDiff.abs(),
      'recommendation': accuracyDiff.abs() > 0.05
          ? 'Significant difference - deploy winner'
          : 'Minimal difference - consider other factors',
    };
  }
}
