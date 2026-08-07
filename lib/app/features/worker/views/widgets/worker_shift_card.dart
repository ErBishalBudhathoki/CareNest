import 'package:flutter/material.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/app/features/schedule/models/shift_model.dart';

class WorkerShiftCard extends StatelessWidget {
  final ShiftModel shift;

  const WorkerShiftCard({super.key, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BauhausTheme.blockDecoration.copyWith(
        border: Border.all(color: BauhausTheme.black, width: 2),
      ),
      child: Column(
        children: [
          // Header: Date & Time (Blue Background)
          Container(
            padding: const EdgeInsets.all(12),
            color: BauhausTheme.blue,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(shift.startTime),
                  style: BauhausTheme.labelStyle.copyWith(
                    color: BauhausTheme.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_formatTime(shift.startTime)} - ${_formatTime(shift.endTime)}',
                      style: BauhausTheme.subHeaderStyle.copyWith(
                        color: BauhausTheme.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: const BoxDecoration(
                        color: BauhausTheme.white,
                      ),
                      child: Text(
                        shift.status.value.toUpperCase(),
                        style: BauhausTheme.labelStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Body: Client & Location
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: BauhausTheme.black,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      shift.clientName ?? 'Unknown Client',
                      style: BauhausTheme.subHeaderStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: BauhausTheme.black,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Location details unavailable', // Location string parsing needed if complex
                        style: BauhausTheme.bodyStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
