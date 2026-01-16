import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/app/features/admin/viewmodels/admin_mileage_view_model.dart';
import 'package:carenest/app/features/admin/widgets/bauhaus_filter_dropdown.dart';
import 'package:carenest/app/features/admin/views/mileage/trip_review_screen.dart';

class AdminMileageDashboard extends ConsumerWidget {
  const AdminMileageDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(adminMileageViewModelProvider);
    final textTheme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'MILEAGE ADMIN',
          style: textTheme.displaySmall?.copyWith(color: BauhausDesign.textDark),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.neutral),
      ),
      body: Column(
        children: [
          // Header / Stats / Filters
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BauhausDesign.neutral, width: 2)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: BauhausFilterDropdown(
                    value: viewModel.filterStatus,
                    items: const ['ALL', 'PENDING', 'APPROVED', 'REJECTED'],
                    onChanged: (val) {
                      if (val != null) ref.read(adminMileageViewModelProvider).setFilter(val);
                    },
                    label: 'Status',
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                // Placeholder for Rate Edit Button or Display
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RATE',
                        style: textTheme.labelLarge?.copyWith(
                          color: BauhausDesign.neutral,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: BauhausDesign.accent,
                          border: Border.all(color: BauhausDesign.neutral, width: 2),
                          boxShadow: const [BauhausDesign.shadowHardSm],
                        ),
                        child: Text(
                          '\$0.58 / mi', // Mock value
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Trip List
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator(color: BauhausDesign.primary))
                : viewModel.filteredTrips.isEmpty
                    ? Center(
                        child: Text(
                          'NO TRIPS FOUND',
                          style: textTheme.headlineLarge?.copyWith(color: BauhausDesign.neutral),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(BauhausDesign.space4),
                        itemCount: viewModel.filteredTrips.length,
                        itemBuilder: (context, index) {
                          final trip = viewModel.filteredTrips[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TripReviewScreen(tripId: trip.id),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BauhausDesign.cardDecoration,
                                child: Padding(
                                  padding: const EdgeInsets.all(BauhausDesign.space4),
                                  child: Row(
                                    children: [
                                      // Status Indicator
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle, // Square for Bauhaus
                                          color: _getStatusColor(trip.status),
                                          border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                                        ),
                                      ),
                                      const SizedBox(width: BauhausDesign.space4),
                                      // Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${trip.employee?.firstName ?? 'Unknown'} ${trip.employee?.lastName ?? ''}',
                                              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${trip.distance} mi • ${trip.tripType.replaceAll('_', ' ')}',
                                              style: textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Action Icon
                                      const Icon(Icons.chevron_right, color: BauhausDesign.neutral, size: 28),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'APPROVED':
        return BauhausDesign.secondary; // Blue
      case 'REJECTED':
        return BauhausDesign.primary; // Red
      case 'PENDING':
      default:
        return BauhausDesign.accent; // Yellow
    }
  }
}
