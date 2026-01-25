import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import '../../../shared/constants/bauhaus_design.dart';
import '../viewmodels/mileage_view_model.dart';

class ManualEntryForm extends StatelessWidget {
  final MileageViewModel viewModel;

  const ManualEntryForm({
    super.key,
    required this.viewModel,
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
            controller: viewModel.startLocationController,
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            label: 'End Location',
            controller: viewModel.endLocationController,
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            label: 'Distance (km)',
            controller: viewModel.distanceController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: BauhausDesign.space6),
          _buildClientToggle(context),
          if (viewModel.isWithClient) ...[
            const SizedBox(height: BauhausDesign.space4),
            _buildClientDropdown(context),
          ],
          const SizedBox(height: BauhausDesign.space6),
          SizedBox(
            width: double.infinity,
            child: BauhausActionButton(
              text: 'Log Trip',
              onPressed: () => viewModel.saveManualTrip(),
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
        Switch(
          value: viewModel.isWithClient,
          onChanged: (val) => viewModel.toggleWithClient(val),
          activeColor: BauhausDesign.primary,
        ),
      ],
    );
  }

  Widget _buildClientDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: null,
          decoration: BauhausDesign.inputDecoration('Select Client'),
          dropdownColor: BauhausDesign.surfaceWhite,
          items: ['John Doe', 'Jane Smith', 'Bob Brown'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ],
    );
  }
}
