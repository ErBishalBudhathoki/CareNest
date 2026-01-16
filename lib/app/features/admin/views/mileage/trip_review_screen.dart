import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/app/features/admin/viewmodels/admin_mileage_view_model.dart';

class TripReviewScreen extends ConsumerStatefulWidget {
  final String tripId;

  const TripReviewScreen({super.key, required this.tripId});

  @override
  ConsumerState<TripReviewScreen> createState() => _TripReviewScreenState();
}

class _TripReviewScreenState extends ConsumerState<TripReviewScreen> {
  late TextEditingController _distanceController;
  late TextEditingController _clientIdController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _distanceController = TextEditingController();
    _clientIdController = TextEditingController();
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _clientIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(adminMileageViewModelProvider);
    final textTheme = BauhausDesign.getTextTheme(context);
    
    // Find trip in list (assuming it's loaded)
    final trip = viewModel.trips.firstWhere(
      (t) => t.id == widget.tripId,
      orElse: () => throw Exception('Trip not found'),
    );

    // Initialize controllers if not editing and values differ (simple sync)
    if (!_isEditing) {
      if (_distanceController.text.isEmpty) _distanceController.text = trip.distance.toString();
      if (_clientIdController.text.isEmpty) _clientIdController.text = trip.clientId ?? '';
    }

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'REVIEW TRIP',
          style: textTheme.displaySmall?.copyWith(color: BauhausDesign.textDark),
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
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
                // Reset values on cancel
                if (!_isEditing) {
                   _distanceController.text = trip.distance.toString();
                   _clientIdController.text = trip.clientId ?? '';
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Placeholder (Geometric)
            Container(
              height: 200,
              decoration: BauhausDesign.cardDecoration.copyWith(
                color: BauhausDesign.neutral.withOpacity(0.1),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.map, size: 48, color: BauhausDesign.neutral),
                  const SizedBox(height: 8),
                  Text('MAP VISUALIZATION', style: textTheme.labelLarge),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space6),
            
            // Details Form
            _buildLabel(context, 'EMPLOYEE'),
            Text(
              '${trip.employee?.firstName} ${trip.employee?.lastName}',
              style: textTheme.headlineLarge,
            ),
            const SizedBox(height: BauhausDesign.space4),

            _buildLabel(context, 'DATE'),
            Text(
              trip.date.toString().split(' ')[0],
              style: textTheme.headlineLarge,
            ),
            const SizedBox(height: BauhausDesign.space4),

            _buildLabel(context, 'DISTANCE (MILES)'),
            if (_isEditing)
              TextField(
                controller: _distanceController,
                decoration: BauhausDesign.inputDecoration,
                keyboardType: TextInputType.number,
                style: textTheme.bodyLarge,
              )
            else
              Text('${trip.distance} mi', style: textTheme.headlineLarge),
            
            const SizedBox(height: BauhausDesign.space4),

            _buildLabel(context, 'CLIENT ID'),
            if (_isEditing)
              TextField(
                controller: _clientIdController,
                decoration: BauhausDesign.inputDecoration,
                style: textTheme.bodyLarge,
              )
            else
              Text(trip.clientId ?? 'N/A', style: textTheme.headlineLarge),

            const SizedBox(height: BauhausDesign.space6),
            
            // Actions
            if (_isEditing)
              BauhausButton(
                text: 'SAVE CHANGES',
                backgroundColor: BauhausDesign.accent,
                textColor: BauhausDesign.textDark,
                onPressed: () async {
                   final success = await ref.read(adminMileageViewModelProvider).updateTripDetails(
                     trip.id,
                     double.tryParse(_distanceController.text) ?? trip.distance,
                     _clientIdController.text.isEmpty ? null : _clientIdController.text,
                   );
                   if (success) {
                     setState(() => _isEditing = false);
                   }
                },
              )
            else
              Row(
                children: [
                  Expanded(
                    child: BauhausButton(
                      text: 'REJECT',
                      backgroundColor: BauhausDesign.primary, // Red
                      onPressed: () {
                         ref.read(adminMileageViewModelProvider).updateTripStatus(trip.id, 'REJECTED');
                         Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    child: BauhausButton(
                      text: 'APPROVE',
                      backgroundColor: BauhausDesign.secondary, // Blue
                      onPressed: () {
                         ref.read(adminMileageViewModelProvider).updateTripStatus(trip.id, 'APPROVED');
                         Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
          color: BauhausDesign.neutral.withOpacity(0.6),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
