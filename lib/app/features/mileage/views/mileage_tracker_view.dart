import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/constants/bauhaus_design.dart';
import '../viewmodels/mileage_view_model.dart';
import '../widgets/manual_entry_form.dart';
import '../widgets/tracker_card.dart';
import '../widgets/trip_list_item.dart';

class MileageTrackerView extends ConsumerWidget {
  const MileageTrackerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mileageViewModelProvider);
    final textTheme = BauhausDesign.getTextTheme(context);

    // Show error snackbar if error exists
    ref.listen<String?>(mileageViewModelProvider.select((s) => s.error),
        (_, error) {
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error,
              style: textTheme.bodyMedium?.copyWith(
                color: BauhausDesign.surfaceWhite,
              ),
            ),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'MILEAGE TRACKER',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: BauhausDesign.neutral,
            height: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rate Info Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: BauhausDesign.space3,
                horizontal: BauhausDesign.space4,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.accent,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: BauhausDesign.textDark, size: 20),
                  const SizedBox(width: BauhausDesign.space3),
                  Text(
                    'Reimbursement Rate: \$0.99 / km', // Dynamic in future
                    style: textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space6),

            // 1. Tracker Card
            TrackerCard(
              isTracking: viewModel.isTracking,
              trackingStartTime: viewModel.trackingStartTime,
              onToggle: () => _handleToggle(context, viewModel),
            ),

            const SizedBox(height: BauhausDesign.space6),

            // 2. Manual Entry Form
            ManualEntryForm(viewModel: viewModel),

            const SizedBox(height: BauhausDesign.space6),

            // 3. Recent Trips Header
            BauhausSectionHeader(title: 'Recent Trips'),

            const SizedBox(height: BauhausDesign.space4),

            // 4. Trip List
            if (viewModel.recentTrips.isEmpty)
              BauhausEmptyState(
                title: 'No Trips Yet',
                message: 'Start insights or add a manual entry.',
                icon: Icons.directions_car,
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.recentTrips.length,
                itemBuilder: (context, index) {
                  final trip = viewModel.recentTrips[index];
                  String? clientName;
                  if (trip.tripType == 'WITH_CLIENT' && trip.clientId != null) {
                    final clientMap = viewModel.assignableClients.firstWhere(
                      (c) => c['id'] == trip.clientId,
                      orElse: () => <String, String>{},
                    );
                    clientName = clientMap['name'];
                  }
                  return TripListItem(
                    trip: trip,
                    clientName: clientName,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleToggle(
      BuildContext context, MileageViewModel viewModel) async {
    if (viewModel.isTracking) {
      // Stop tracking -> Confirm End Trip
      final distance = await viewModel.stopTracking();
      if (context.mounted) {
        _showEndTripDialog(context, viewModel, distance);
      }
    } else {
      // Start tracking
      await viewModel.startTracking();
    }
  }

  void _showEndTripDialog(
      BuildContext context, MileageViewModel viewModel, double distance) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _EndTripDialog(
        distance: distance,
        clients: viewModel.assignableClients,
        onSubmit: (withClient, clientId) async {
          final success = await viewModel.submitTrip(
            withClient: withClient,
            clientId: clientId,
          );
          if (context.mounted) {
            if (success) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Trip saved successfully!',
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.surfaceWhite,
                        ),
                  ),
                  backgroundColor: BauhausDesign.success,
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class _EndTripDialog extends StatefulWidget {
  final double distance;
  final List<Map<String, String>> clients;
  final Function(bool, String?) onSubmit;

  const _EndTripDialog({
    required this.distance,
    required this.clients,
    required this.onSubmit,
  });

  @override
  State<_EndTripDialog> createState() => _EndTripDialogState();
}

class _EndTripDialogState extends State<_EndTripDialog> {
  bool _isWithClient = false;
  String? _selectedClientId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(BauhausDesign.space4),
      child: BauhausCard(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Complete',
              style: BauhausDesign.getTextTheme(context)
                  .headlineSmall
                  ?.copyWith(color: BauhausDesign.textDark),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'Total Distance: ${widget.distance.toStringAsFixed(2)} km',
              style: BauhausDesign.getTextTheme(context).titleMedium,
            ),
            const SizedBox(height: BauhausDesign.space6),

            // Client Toggle
            Row(
              children: [
                Text(
                  'With Client?',
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                ),
                const Spacer(),
                BauhausSwitch(
                  value: _isWithClient,
                  onChanged: (val) => setState(() => _isWithClient = val),
                  variant: BauhausSwitchVariant.primary,
                ),
              ],
            ),

            if (_isWithClient) ...[
              const SizedBox(height: BauhausDesign.space4),
              if (widget.clients.isEmpty)
                Text(
                  'No assigned clients found for this account.',
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(color: BauhausDesign.textMuted),
                )
              else
                DropdownButtonFormField<String>(
                  value: _selectedClientId,
                  decoration: BauhausDesign.inputDecoration('Select Client'),
                  dropdownColor: BauhausDesign.surfaceWhite,
                  items: widget.clients
                      .map((client) => DropdownMenuItem(
                            value: client['id'],
                            child: Text(
                              client['name'] ??
                                  client['id'] ??
                                  'Unknown Client',
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium,
                            ),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedClientId = val),
                ),
            ],

            const SizedBox(height: BauhausDesign.space8),

            BauhausActionButton(
              text: 'Submit Trip',
              onPressed: () =>
                  widget.onSubmit(_isWithClient, _selectedClientId),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}
