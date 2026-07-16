import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:flutter/material.dart';
import '../../../shared/constants/bauhaus_design.dart';
import '../viewmodels/mileage_view_model.dart';

class ManualEntryForm extends StatelessWidget {
  final MileageViewState state;
  final MileageViewModel notifier;

  const ManualEntryForm({
    super.key,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manual Entry',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space6),
          BauhausTextField(
            label: 'Start Location',
            controller: notifier.startLocationController,
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            label: 'End Location',
            controller: notifier.endLocationController,
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            label: 'Distance (km)',
            controller: notifier.distanceController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: BauhausDesign.space6),
          _buildClientToggle(context),
          if (state.isWithClient) ...[
            const SizedBox(height: BauhausDesign.space4),
            _buildClientDropdown(context),
          ],
          const SizedBox(height: BauhausDesign.space6),
          SizedBox(
            width: double.infinity,
            child: BauhausActionButton(
              text: 'Log Trip',
              onPressed: () => notifier.saveManualTrip(),
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientToggle(BuildContext context) {
    return Row(
      children: [
        Text(
          'With Client?',
          style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const Spacer(),
        BauhausSwitch(
          value: state.isWithClient,
          onChanged: (val) => notifier.toggleWithClient(val),
          variant: BauhausSwitchVariant.primary,
        ),
      ],
    );
  }

  Widget _buildClientDropdown(BuildContext context) {
    final clients = state.assignableClients;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (clients.isEmpty)
          Text(
            'No assigned clients found for this account.',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          )
        else
          DropdownButtonFormField<String>(
            value: state.selectedClientId,
            decoration: BauhausDesign.inputDecoration('Select Client').copyWith(
              filled: true,
              fillColor: BauhausDesign.surfaceLight,
            ),
            dropdownColor: BauhausDesign.surfaceWhite,
            items: clients.map((client) {
              return DropdownMenuItem<String>(
                value: client['id'],
                child: Text(
                  client['name'] ?? client['id'] ?? 'Unknown Client',
                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                ),
              );
            }).toList(),
            onChanged: notifier.selectClient,
          ),
      ],
    );
  }
}
