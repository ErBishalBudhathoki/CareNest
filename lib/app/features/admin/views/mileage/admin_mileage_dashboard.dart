import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/admin/viewmodels/admin_mileage_view_model.dart';
import 'package:carenest/app/features/admin/widgets/bauhaus_filter_dropdown.dart';
import 'package:carenest/app/features/admin/views/mileage/trip_review_screen.dart';

import 'package:carenest/app/features/admin/views/mileage/mileage_settings_view.dart';
import 'package:carenest/app/features/admin/viewmodels/mileage_settings_view_model.dart';

class AdminMileageDashboard extends ConsumerWidget {
  const AdminMileageDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(adminMileageViewModelProvider);
    final settingsState = ref.watch(mileageSettingsViewModelProvider);
    final textTheme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'MILEAGE ADMIN',
          style:
              textTheme.displaySmall?.copyWith(color: BauhausDesign.textDark),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.neutral),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MileageSettingsView()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(
              BauhausDesign.space4,
              BauhausDesign.space4,
              BauhausDesign.space4,
              0,
            ),
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Row(
              children: [
                const Icon(Icons.local_shipping,
                    color: BauhausDesign.secondary),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Text(
                    'Trips to review',
                    style: textTheme.bodyMedium?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space2,
                    vertical: BauhausDesign.space1,
                  ),
                  decoration: BoxDecoration(
                    color: BauhausDesign.warning,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Text(
                    '${viewModel.pendingTripsCount}',
                    style: textTheme.labelSmall?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          // Header / Stats / Filters
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: BauhausFilterDropdown(
                    value: viewModel.filterStatus,
                    items: const ['ALL', 'PENDING', 'APPROVED', 'REJECTED'],
                    onChanged: (val) {
                      if (val != null) {
                        ref.read(adminMileageViewModelProvider).setFilter(val);
                      }
                    },
                    label: 'Status',
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                // Rate Display
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MileageSettingsView()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: BauhausDesign.accent,
                            border: Border.all(
                                color: BauhausDesign.neutral, width: 2),
                            boxShadow: const [BauhausDesign.shadowHardSm],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${settingsState.reimbursementRate.toStringAsFixed(2)} / mi',
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.textDark,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.edit,
                                  size: 14, color: BauhausDesign.textDark),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          // Trip List
          Expanded(
            child: viewModel.isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(color: BauhausDesign.primary))
                : viewModel.error != null
                    ? Center(
                        child: Text(
                          viewModel.error!,
                          style: textTheme.bodyMedium?.copyWith(
                            color: BauhausDesign.error,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : viewModel.filteredTrips.isEmpty
                        ? Center(
                            child: Text(
                              'NO TRIPS FOUND',
                              style: textTheme.headlineLarge
                                  ?.copyWith(color: BauhausDesign.neutral),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                              BauhausDesign.space4,
                              0,
                              BauhausDesign.space4,
                              BauhausDesign.space4,
                            ),
                            itemCount: viewModel.filteredTrips.length,
                            itemBuilder: (context, index) {
                              final trip = viewModel.filteredTrips[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: BauhausDesign.space3),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            TripReviewScreen(tripId: trip.id),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: BauhausDesign.surfaceLight,
                                      borderRadius: BorderRadius.circular(
                                          BauhausDesign.radiusSm),
                                      border: Border.all(
                                          color: BauhausDesign.neutral,
                                          width: 2),
                                      boxShadow: const [
                                        BauhausDesign.shadowHardSm
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          BauhausDesign.space4),
                                      child: Row(
                                        children: [
                                          // Status Indicator
                                          Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              shape:
                                                  BoxShape.rectangle, // Square
                                              color:
                                                  _getStatusColor(trip.status),
                                              border: Border.all(
                                                  color: BauhausDesign.neutral,
                                                  width: 1.5),
                                            ),
                                          ),
                                          const SizedBox(
                                              width: BauhausDesign.space4),
                                          // Details
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${trip.employee?.firstName ?? 'Unknown'} ${trip.employee?.lastName ?? ''}',
                                                  style: textTheme.bodyLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: BauhausDesign
                                                              .textDark),
                                                ),
                                                Text(
                                                  '${trip.distance} mi • ${trip.tripType.replaceAll('_', ' ')}',
                                                  style: textTheme.bodyMedium
                                                      ?.copyWith(
                                                    color:
                                                        BauhausDesign.textMuted,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    height:
                                                        BauhausDesign.space2),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal:
                                                            BauhausDesign
                                                                .space2,
                                                        vertical: BauhausDesign
                                                            .space1,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: _getStatusColor(
                                                                trip.status)
                                                            .withOpacity(0.18),
                                                        border: Border.all(
                                                          color: BauhausDesign
                                                              .neutral,
                                                          width: 1.2,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        trip.status,
                                                        style: textTheme
                                                            .labelSmall
                                                            ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: BauhausDesign
                                                              .textDark,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Action Icon
                                          const Icon(Icons.chevron_right,
                                              color: BauhausDesign.neutral,
                                              size: 28),
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
