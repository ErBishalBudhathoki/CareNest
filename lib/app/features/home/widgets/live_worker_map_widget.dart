import 'package:flutter/material.dart';
import 'package:carenest/app/shared/theme/bauhaus_colors.dart';
import '../models/dashboard_models.dart';

class LiveWorkerMapWidget extends StatelessWidget {
  final List<WorkerLocation>? workerLocations;
  final bool isLoading;
  final Function(WorkerLocation)? onWorkerTap;

  const LiveWorkerMapWidget({
    super.key,
    this.workerLocations,
    this.isLoading = false,
    this.onWorkerTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingState();
    }

    if (workerLocations == null || workerLocations!.isEmpty) {
      return _buildEmptyState();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BauhausColors.primaryYellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.map,
                    color: BauhausColors.primaryYellow,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Live Worker Locations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BauhausColors.textDark,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: BauhausColors.accentGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        '${workerLocations!.length} active',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Map placeholder - in production, integrate Google Maps or similar
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Map View',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Integrate Google Maps here',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status legend
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem(
                            'Available',
                            BauhausColors.accentGreen,
                          ),
                          _buildLegendItem(
                            'En Route',
                            BauhausColors.primaryBlue,
                          ),
                          _buildLegendItem(
                            'At Appointment',
                            BauhausColors.primaryYellow,
                          ),
                          _buildLegendItem(
                            'On Break',
                            BauhausColors.accentOrange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Worker Status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: BauhausColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            ...workerLocations!.map((worker) => _buildWorkerTile(worker)),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: BauhausColors.textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerTile(WorkerLocation worker) {
    final statusColor = _getStatusColor(worker.status);
    final statusLabel = _getStatusLabel(worker.status);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onWorkerTap?.call(worker),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: statusColor.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker.workerName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: BauhausColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        statusLabel,
                        style: TextStyle(fontSize: 11, color: statusColor),
                      ),
                      if (worker.currentClientName != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Client: ${worker.currentClientName}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: BauhausColors.textMedium,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: statusColor.withOpacity(0.5),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.location_off, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No active workers',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Worker locations will appear here',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(WorkerStatus status) {
    switch (status) {
      case WorkerStatus.available:
        return BauhausColors.accentGreen;
      case WorkerStatus.enRoute:
        return BauhausColors.primaryBlue;
      case WorkerStatus.atAppointment:
        return BauhausColors.primaryYellow;
      case WorkerStatus.onBreak:
        return BauhausColors.accentOrange;
      case WorkerStatus.offline:
        return Colors.grey;
    }
  }

  String _getStatusLabel(WorkerStatus status) {
    switch (status) {
      case WorkerStatus.available:
        return 'Available';
      case WorkerStatus.enRoute:
        return 'En Route';
      case WorkerStatus.atAppointment:
        return 'At Appointment';
      case WorkerStatus.onBreak:
        return 'On Break';
      case WorkerStatus.offline:
        return 'Offline';
    }
  }
}
