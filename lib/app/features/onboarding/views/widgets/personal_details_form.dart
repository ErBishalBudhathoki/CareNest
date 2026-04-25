import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/bauhaus_design.dart';
import '../../../../shared/widgets/bauhaus_widgets.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../providers/onboarding_providers.dart';

class PersonalDetailsForm extends ConsumerStatefulWidget {
  final String initialStatus;
  final VoidCallback onComplete;

  const PersonalDetailsForm({
    super.key,
    required this.initialStatus,
    required this.onComplete,
  });

  @override
  ConsumerState<PersonalDetailsForm> createState() =>
      _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends ConsumerState<PersonalDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausTextField(
            controller: _addressController,
            label: 'Home Address',
            hintText: 'Enter Home Address',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: BauhausDesign.space3),
          Text(
            'Emergency Contact (Optional)',
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          BauhausTextField(
            controller: _emergencyNameController,
            label: 'Contact Name',
            hintText: 'Enter Contact Name',
          ),
          const SizedBox(height: BauhausDesign.space3),
          BauhausTextField(
            controller: _emergencyPhoneController,
            label: 'Contact Phone',
            hintText: 'Enter Contact Phone',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: BauhausDesign.space4),
          ButtonWidget(
            buttonText: 'Save & Continue',
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(onboardingViewModelProvider.notifier).updateStep(
        'personalDetails',
        {
          'address': _addressController.text,
          'emergencyContact': {
            'name': _emergencyNameController.text,
            'phone': _emergencyPhoneController.text,
          },
          'currentStep': 2,
        },
      );
      widget.onComplete();
    }
  }
}
