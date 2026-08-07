import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/onboarding_providers.dart';
import '../../../../shared/constants/bauhaus_design.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/bauhaus_widgets.dart';

class TaxSuperForm extends ConsumerStatefulWidget {
  final String taxStatus;
  final String superStatus;
  final VoidCallback onComplete;

  const TaxSuperForm({
    super.key,
    required this.taxStatus,
    required this.superStatus,
    required this.onComplete,
  });

  @override
  ConsumerState<TaxSuperForm> createState() => _TaxSuperFormState();
}

class _TaxSuperFormState extends ConsumerState<TaxSuperForm> {
  final _formKey = GlobalKey<FormState>();
  final _tfnController = TextEditingController();
  final _fundNameController = TextEditingController();
  final _memberNumberController = TextEditingController();
  final _usiController = TextEditingController();

  String _taxScale = 'tax-free-threshold';

  @override
  void dispose() {
    _tfnController.dispose();
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
          Text(
            'Tax Declaration',
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            controller: _tfnController,
            label: 'Tax File Number (TFN)',
            hintText: 'Enter TFN',
            keyboardType: TextInputType.number,
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: BauhausDesign.space4),
          DropdownButtonFormField<String>(
            value: _taxScale,
            decoration: InputDecoration(
              labelText: 'Tax Scale',
              labelStyle: const TextStyle(color: BauhausDesign.textDark),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.space2),
                borderSide: const BorderSide(color: BauhausDesign.textDark),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.space2),
                borderSide: const BorderSide(color: BauhausDesign.textDark),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.space2),
                borderSide: const BorderSide(
                  color: BauhausDesign.primary,
                  width: 2,
                ),
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'tax-free-threshold',
                child: Text('Claim Tax-Free Threshold'),
              ),
              DropdownMenuItem(
                value: 'no-tax-free-threshold',
                child: Text('No Tax-Free Threshold'),
              ),
            ],
            onChanged: (val) => setState(() => _taxScale = val!),
          ),
          const SizedBox(height: 32),
          Text(
            'Superannuation',
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            controller: _fundNameController,
            label: 'Fund Name',
            hintText: 'Enter Fund Name',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            controller: _memberNumberController,
            label: 'Member Number',
            hintText: 'Enter Member Number',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausTextField(
            controller: _usiController,
            label: 'USI (Unique Superannuation Identifier)',
            hintText: 'Enter USI',
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          const SizedBox(height: 24),
          ButtonWidget(buttonText: 'Save & Continue', onPressed: _submit),
        ],
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Save Tax
      await ref.read(onboardingViewModelProvider.notifier).updateStep(
        'taxDetails',
        {'tfn': _tfnController.text, 'taxScale': _taxScale},
      );

      // Save Super
      await ref
          .read(onboardingViewModelProvider.notifier)
          .updateStep('superannuation', {
            'fundName': _fundNameController.text,
            'memberNumber': _memberNumberController.text,
            'usi': _usiController.text,
            'currentStep': 4,
          });

      widget.onComplete();
    }
  }
}
