import 'dart:math';

/// Optimization Service
/// Provides optimization algorithms for workforce management
class OptimizationService {
  /// Optimize worker allocation using greedy algorithm
  List<Map<String, dynamic>> optimizeWorkerAllocation({
    required List<Map<String, dynamic>> workers,
    required List<Map<String, dynamic>> appointments,
    Map<String, dynamic>? constraints,
  }) {
    final allocations = <Map<String, dynamic>>[];
    final assignedWorkers = <String>{};

    // Sort appointments by priority
    appointments.sort((a, b) {
      final priorityA = a['priority'] as int? ?? 0;
      final priorityB = b['priority'] as int? ?? 0;
      return priorityB.compareTo(priorityA);
    });

    for (final appointment in appointments) {
      final availableWorkers = workers
          .where((w) => !assignedWorkers.contains(w['id']))
          .toList();

      if (availableWorkers.isEmpty) break;

      // Score each worker for this appointment
      final scores = availableWorkers.map((worker) {
        return {
          'worker': worker,
          'score': _calculateAllocationScore(worker, appointment),
        };
      }).toList();

      // Sort by score
      scores.sort(
        (a, b) => (b['score'] as double).compareTo(a['score'] as double),
      );

      // Assign best worker
      final bestMatch = scores.first;
      final bestWorker = bestMatch['worker'] as Map<String, dynamic>;
      allocations.add({
        'appointmentId': appointment['id'],
        'workerId': bestWorker['id'],
        'score': bestMatch['score'],
        'cost': _calculateCost(bestWorker, appointment),
      });

      assignedWorkers.add(bestWorker['id'] as String);
    }

    return allocations;
  }

  /// Calculate allocation score
  double _calculateAllocationScore(
    Map<String, dynamic> worker,
    Map<String, dynamic> appointment,
  ) {
    double score = 0.0;

    // Skill match (40%)
    final workerSkills = worker['skills'] as List? ?? [];
    final requiredSkills = appointment['requiredSkills'] as List? ?? [];
    final skillMatch = _calculateSkillMatch(workerSkills, requiredSkills);
    score += skillMatch * 0.4;

    // Distance (30%)
    final distance = _calculateDistance(
      worker['location'] as Map<String, dynamic>?,
      appointment['location'] as Map<String, dynamic>?,
    );
    final distanceScore = max(0.0, 1.0 - (distance / 50.0)); // 50km max
    score += distanceScore * 0.3;

    // Performance (20%)
    final performance = worker['performanceScore'] as double? ?? 3.0;
    score += (performance / 5.0) * 0.2;

    // Availability (10%)
    final available = worker['available'] as bool? ?? true;
    score += available ? 0.1 : 0.0;

    return score;
  }

  /// Calculate skill match percentage
  double _calculateSkillMatch(List workerSkills, List requiredSkills) {
    if (requiredSkills.isEmpty) return 1.0;

    int matches = 0;
    for (final required in requiredSkills) {
      if (workerSkills.contains(required)) {
        matches++;
      }
    }

    return matches / requiredSkills.length;
  }

  /// Calculate distance between two locations (simplified)
  double _calculateDistance(
    Map<String, dynamic>? loc1,
    Map<String, dynamic>? loc2,
  ) {
    if (loc1 == null || loc2 == null) return 25.0; // Default 25km

    final lat1 = loc1['lat'] as double? ?? 0.0;
    final lon1 = loc1['lng'] as double? ?? 0.0;
    final lat2 = loc2['lat'] as double? ?? 0.0;
    final lon2 = loc2['lng'] as double? ?? 0.0;

    // Haversine formula
    const R = 6371.0; // Earth radius in km
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  /// Convert degrees to radians
  double _toRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  /// Calculate cost
  double _calculateCost(
    Map<String, dynamic> worker,
    Map<String, dynamic> appointment,
  ) {
    final hourlyRate = worker['hourlyRate'] as double? ?? 25.0;
    final duration = appointment['duration'] as double? ?? 1.0;
    return hourlyRate * duration;
  }

  /// Optimize schedule using constraint satisfaction
  List<Map<String, dynamic>> optimizeSchedule({
    required List<Map<String, dynamic>> appointments,
    required Map<String, dynamic> constraints,
  }) {
    final optimized = <Map<String, dynamic>>[];

    // Sort by start time
    appointments.sort((a, b) {
      final timeA = DateTime.parse(a['startTime'] as String);
      final timeB = DateTime.parse(b['startTime'] as String);
      return timeA.compareTo(timeB);
    });

    // Check for conflicts and optimize
    for (final appointment in appointments) {
      final hasConflict = _hasScheduleConflict(appointment, optimized);

      if (!hasConflict) {
        optimized.add(appointment);
      } else {
        // Try to reschedule
        final rescheduled = _rescheduleAppointment(appointment, optimized);
        if (rescheduled != null) {
          optimized.add(rescheduled);
        }
      }
    }

    return optimized;
  }

  /// Check for schedule conflicts
  bool _hasScheduleConflict(
    Map<String, dynamic> appointment,
    List<Map<String, dynamic>> scheduled,
  ) {
    final start = DateTime.parse(appointment['startTime'] as String);
    final end = DateTime.parse(appointment['endTime'] as String);
    final workerId = appointment['workerId'] as String;

    for (final existing in scheduled) {
      if (existing['workerId'] != workerId) continue;

      final existingStart = DateTime.parse(existing['startTime'] as String);
      final existingEnd = DateTime.parse(existing['endTime'] as String);

      if ((start.isBefore(existingEnd) && end.isAfter(existingStart))) {
        return true;
      }
    }

    return false;
  }

  /// Reschedule appointment
  Map<String, dynamic>? _rescheduleAppointment(
    Map<String, dynamic> appointment,
    List<Map<String, dynamic>> scheduled,
  ) {
    // Try to find next available slot
    final duration = appointment['duration'] as double? ?? 1.0;
    final durationMinutes = (duration * 60).toInt();

    for (int offset = 30; offset <= 480; offset += 30) {
      final newStart = DateTime.parse(
        appointment['startTime'] as String,
      ).add(Duration(minutes: offset));
      final newEnd = newStart.add(Duration(minutes: durationMinutes));

      final testAppointment = Map<String, dynamic>.from(appointment);
      testAppointment['startTime'] = newStart.toIso8601String();
      testAppointment['endTime'] = newEnd.toIso8601String();

      if (!_hasScheduleConflict(testAppointment, scheduled)) {
        return testAppointment;
      }
    }

    return null;
  }

  /// Calculate workload balance score
  double calculateWorkloadBalance(List<Map<String, dynamic>> workloads) {
    if (workloads.isEmpty) return 1.0;

    final utilizations = workloads
        .map((w) => w['utilization'] as double? ?? 0.0)
        .toList();

    final mean = utilizations.reduce((a, b) => a + b) / utilizations.length;
    final variance =
        utilizations.map((u) => pow(u - mean, 2)).reduce((a, b) => a + b) /
        utilizations.length;
    final stdDev = sqrt(variance);

    // Balance score: 1.0 = perfect balance, 0.0 = very unbalanced
    return max(0.0, 1.0 - (stdDev / mean));
  }

  /// Optimize resource utilization
  Map<String, dynamic> optimizeResourceUtilization({
    required List<Map<String, dynamic>> resources,
    required double targetUtilization,
  }) {
    final underutilized = <Map<String, dynamic>>[];
    final overutilized = <Map<String, dynamic>>[];
    final balanced = <Map<String, dynamic>>[];

    for (final resource in resources) {
      final utilization = resource['utilization'] as double? ?? 0.0;

      if (utilization < targetUtilization * 0.8) {
        underutilized.add(resource);
      } else if (utilization > targetUtilization * 1.2) {
        overutilized.add(resource);
      } else {
        balanced.add(resource);
      }
    }

    return {
      'underutilized': underutilized,
      'overutilized': overutilized,
      'balanced': balanced,
      'recommendations': _generateUtilizationRecommendations(
        underutilized,
        overutilized,
        targetUtilization,
      ),
    };
  }

  /// Generate utilization recommendations
  List<Map<String, dynamic>> _generateUtilizationRecommendations(
    List<Map<String, dynamic>> underutilized,
    List<Map<String, dynamic>> overutilized,
    double target,
  ) {
    final recommendations = <Map<String, dynamic>>[];

    if (overutilized.isNotEmpty) {
      recommendations.add({
        'type': 'rebalance',
        'priority': 'high',
        'message':
            'Redistribute work from ${overutilized.length} overutilized workers',
        'action':
            'Reduce workload by ${((overutilized.length * 0.2) * 100).toInt()}%',
      });
    }

    if (underutilized.isNotEmpty) {
      recommendations.add({
        'type': 'optimize',
        'priority': 'medium',
        'message':
            'Increase assignments for ${underutilized.length} underutilized workers',
        'action':
            'Increase workload by ${((underutilized.length * 0.3) * 100).toInt()}%',
      });
    }

    return recommendations;
  }

  /// Calculate ROI for optimization
  Map<String, dynamic> calculateOptimizationROI({
    required double currentCost,
    required double optimizedCost,
    required double implementationCost,
    required int timeHorizonMonths,
  }) {
    final monthlySavings = currentCost - optimizedCost;
    final totalSavings = monthlySavings * timeHorizonMonths;
    final netBenefit = totalSavings - implementationCost;
    final roi = (netBenefit / implementationCost) * 100;
    final paybackMonths = implementationCost / monthlySavings;

    return {
      'monthlySavings': monthlySavings,
      'totalSavings': totalSavings,
      'netBenefit': netBenefit,
      'roi': roi,
      'paybackMonths': paybackMonths,
      'recommendation': roi > 100
          ? 'Highly recommended - ROI > 100%'
          : roi > 50
          ? 'Recommended - Positive ROI'
          : 'Consider alternatives - Low ROI',
    };
  }

  /// Find optimal staff size
  int findOptimalStaffSize({
    required int currentStaff,
    required double currentUtilization,
    required double targetUtilization,
  }) {
    final requiredCapacity = currentStaff * currentUtilization;
    final optimalStaff = (requiredCapacity / targetUtilization).ceil();
    return optimalStaff;
  }

  /// Calculate efficiency score
  double calculateEfficiencyScore({
    required int completedTasks,
    required int totalTasks,
    required double avgCompletionTime,
    required double targetCompletionTime,
  }) {
    final completionRate = completedTasks / totalTasks;
    final timeEfficiency = min(1.0, targetCompletionTime / avgCompletionTime);

    return (completionRate * 0.6) + (timeEfficiency * 0.4);
  }
}
