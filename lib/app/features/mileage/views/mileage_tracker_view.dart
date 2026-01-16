import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/design_system/bauhaus_design_system.dart';
import '../viewmodels/mileage_view_model.dart';
import '../widgets/manual_entry_form.dart';
import '../widgets/tracker_card.dart';
import '../widgets/trip_list_item.dart';

class MileageTrackerView extends ConsumerWidget {
  const MileageTrackerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mileageViewModelProvider);

    // Show error snackbar if error exists
    if (viewModel.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(viewModel.error!),
            backgroundColor: BauhausDesign.error,
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'MILEAGE TRACKER',
          style: GoogleFonts.oswald(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: BauhausDesign.neutral,
            letterSpacing: 1.0,
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
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Tracker Card
            TrackerCard(
              isTracking: viewModel.isTracking,
              onToggle: () => _handleToggle(context, viewModel),
            ),
            
            const SizedBox(height: BauhausDesign.space8),
            
            // 2. Manual Entry Form
            ManualEntryForm(viewModel: viewModel),
            
            const SizedBox(height: BauhausDesign.space8),
            
            // 3. Recent Trips Header
            Row(
              children: [
                Container(
                  width: 8,
                  height: 24,
                  color: BauhausDesign.primary,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  'RECENT TRIPS',
                  style: GoogleFonts.oswald(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: BauhausDesign.neutral,
                  ),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            
            // 4. Trip List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.recentTrips.length,
              itemBuilder: (context, index) {
                return TripListItem(trip: viewModel.recentTrips[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleToggle(BuildContext context, MileageViewModel viewModel) async {
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

  void _showEndTripDialog(BuildContext context, MileageViewModel viewModel, double distance) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _EndTripDialog(
        distance: distance,
        onSubmit: (withClient, clientId) async {
          final success = await viewModel.submitTrip('Start', 'End'); // Locations would ideally come from controller
          if (context.mounted) {
            Navigator.pop(context);
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Trip saved successfully!')),
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
  final Function(bool, String?) onSubmit;

  const _EndTripDialog({
    required this.distance,
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
      backgroundColor: BauhausDesign.surfaceLight,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        decoration: BoxDecoration(
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TRIP COMPLETE',
              style: GoogleFonts.oswald(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: BauhausDesign.neutral,
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'Total Distance: ${widget.distance.toStringAsFixed(2)} km',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BauhausDesign.space6),
            
            // Client Toggle
            Row(
              children: [
                Text(
                  'WITH CLIENT?',
                  style: GoogleFonts.oswald(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: _isWithClient,
                  onChanged: (val) => setState(() => _isWithClient = val),
                  activeColor: BauhausDesign.secondary,
                ),
              ],
            ),
            
            if (_isWithClient) ...[
              const SizedBox(height: BauhausDesign.space4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedClientId,
                    hint: const Text('Select Client'),
                    items: ['John Doe', 'Jane Smith'].map((e) => 
                      DropdownMenuItem(value: e, child: Text(e))
                    ).toList(),
                    onChanged: (val) => setState(() => _selectedClientId = val),
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: BauhausDesign.space8),
            
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => widget.onSubmit(_isWithClient, _selectedClientId),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: BauhausDesign.neutral,
                        boxShadow: const [BauhausDesign.shadowHardSm],
                      ),
                      child: Center(
                        child: Text(
                          'SUBMIT TRIP',
                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
