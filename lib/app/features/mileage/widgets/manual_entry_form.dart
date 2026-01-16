import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/design_system/bauhaus_design_system.dart';
import '../viewmodels/mileage_view_model.dart';

class ManualEntryForm extends StatelessWidget {
  final MileageViewModel viewModel;

  const ManualEntryForm({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space6),
      decoration: BoxDecoration(
        color: BauhausDesign.backgroundLight,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MANUAL ENTRY',
            style: GoogleFonts.oswald(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: BauhausDesign.neutral,
            ),
          ),
          const SizedBox(height: BauhausDesign.space6),
          
          _buildBauhausInput(
            label: 'START LOCATION',
            controller: viewModel.startLocationController,
          ),
          const SizedBox(height: BauhausDesign.space4),
          
          _buildBauhausInput(
            label: 'END LOCATION',
            controller: viewModel.endLocationController,
          ),
          const SizedBox(height: BauhausDesign.space4),
          
          _buildBauhausInput(
            label: 'DISTANCE (KM)',
            controller: viewModel.distanceController,
            isNumeric: true,
          ),
          const SizedBox(height: BauhausDesign.space6),
          
          _buildClientToggle(),
          
          if (viewModel.isWithClient) ...[
            const SizedBox(height: BauhausDesign.space4),
            _buildClientDropdown(),
          ],
          
          const SizedBox(height: BauhausDesign.space6),
          
          SizedBox(
            width: double.infinity,
            child: _buildSaveButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildBauhausInput({
    required String label,
    required TextEditingController controller,
    bool isNumeric = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: BauhausDesign.neutral,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        TextField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: BauhausDesign.neutral,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            // Heavy bottom border as requested
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.neutral, width: 2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.primary, width: 3),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.neutral, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClientToggle() {
    return Row(
      children: [
        Text(
          'WITH CLIENT?',
          style: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: BauhausDesign.neutral,
          ),
        ),
        const Spacer(),
        Switch(
          value: viewModel.isWithClient,
          onChanged: (val) => viewModel.toggleWithClient(val),
          activeColor: BauhausDesign.secondary,
          activeTrackColor: BauhausDesign.neutral,
          inactiveThumbColor: BauhausDesign.neutral,
          inactiveTrackColor: BauhausDesign.backgroundLight,
          // Customizing switch to look more geometric if possible, standard switch is somewhat rounded
          // but Material 3 switches are pill-shaped. We stick to standard with Bauhaus colors.
        ),
      ],
    );
  }

  Widget _buildClientDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT CLIENT',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: BauhausDesign.neutral,
          ),
        ),
        const SizedBox(height: BauhausDesign.space2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: null, // Placeholder
              hint: Text(
                'Choose a client...',
                style: GoogleFonts.inter(color: BauhausDesign.neutral.withOpacity(0.5)),
              ),
              icon: const Icon(Icons.arrow_drop_down_sharp, color: BauhausDesign.neutral),
              items: ['John Doe', 'Jane Smith', 'Bob Brown'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return InkWell(
      onTap: () => viewModel.saveManualTrip(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space4),
        decoration: BoxDecoration(
          color: BauhausDesign.neutral,
          // Radius 0
          borderRadius: BorderRadius.zero,
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Center(
          child: Text(
            'LOG TRIP',
            style: GoogleFonts.oswald(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
