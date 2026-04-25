import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/bauhaus_widgets.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../providers/onboarding_providers.dart';

class SuperannuationForm extends ConsumerStatefulWidget {
  final String superStatus;
  final String? fundName;
  final String? memberNumber;
  final String? usi;
  final VoidCallback onComplete;

  const SuperannuationForm({
    super.key,
    required this.superStatus,
    required this.onComplete,
    this.fundName,
    this.memberNumber,
    this.usi,
  });

  @override
  ConsumerState<SuperannuationForm> createState() => _SuperannuationFormState();
}

class _SuperannuationFormState extends ConsumerState<SuperannuationForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fundNameController;
  late final TextEditingController _memberNumberController;
  late final TextEditingController _usiController;

  @override
  void initState() {
    super.initState();
    _fundNameController = TextEditingController(text: widget.fundName ?? '');
    _memberNumberController =
        TextEditingController(text: widget.memberNumber ?? '');
    _usiController = TextEditingController(text: widget.usi ?? '');
  }

  @override
  void dispose() {
    _fundNameController.dispose();
    _memberNumberController.dispose();
    _usiController.dispose();
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
            controller: _fundNameController,
            label: 'Fund Name',
            hintText: 'Enter super fund name',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 16),
          BauhausTextField(
            controller: _memberNumberController,
            label: 'Member Number',
            hintText: 'Enter member number',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 16),
          BauhausTextField(
            controller: _usiController,
            label: 'USI',
            hintText: 'Enter unique superannuation identifier',
            validator: _requiredValidator,
          ),
          const SizedBox(height: 24),
          ButtonWidget(
            buttonText: 'Save & Continue',
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(onboardingViewModelProvider.notifier).updateStep(
      'superannuation',
      {
        'fundName': _fundNameController.text.trim(),
        'memberNumber': _memberNumberController.text.trim(),
        'usi': _usiController.text.trim(),
        'currentStep': 4,
      },
    );

    widget.onComplete();
  }
}
