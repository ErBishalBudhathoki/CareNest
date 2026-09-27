import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/bauhaus_design.dart';
import '../../../../shared/widgets/bauhaus_widgets.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../providers/onboarding_providers.dart';
import '../../utils/australian_validators.dart';

class TaxDetailsForm extends ConsumerStatefulWidget {
  final String taxStatus;
  final String? tfn;
  final String? taxScale;
  final VoidCallback onComplete;

  const TaxDetailsForm({
    super.key,
    required this.taxStatus,
    required this.onComplete,
    this.tfn,
    this.taxScale,
  });

  @override
  ConsumerState<TaxDetailsForm> createState() => _TaxDetailsFormState();
}

class _TaxDetailsFormState extends ConsumerState<TaxDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tfnController;
  late String _taxScale;

  @override
  void initState() {
    super.initState();
    _tfnController = TextEditingController(text: widget.tfn ?? '');
    _taxScale = widget.taxScale ?? 'tax-free-threshold';
  }

  @override
  void dispose() {
    _tfnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausTextField(
            controller: _tfnController,
            label: 'Tax File Number (TFN)',
            hintText: 'Enter 9 digit TFN',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9),
            ],
            validator: _validateTfn,
          ),
          const SizedBox(height: 16),
          Text(
            'Tax Scale',
            style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: _taxScale,
            dropdownColor: colorScheme.surface,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: colorScheme.surface,
              labelText: 'Select tax scale',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.primary, width: 2),
              ),
            ),
            items: [
              DropdownMenuItem(
                value: 'tax-free-threshold',
                child: Text(
                  'Claim Tax-Free Threshold',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
              ),
              DropdownMenuItem(
                value: 'no-tax-free-threshold',
                child: Text(
                  'No Tax-Free Threshold',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _taxScale = value;
              });
            },
          ),
          const SizedBox(height: 24),
          ButtonWidget(buttonText: 'Save & Continue', onPressed: _submit),
        ],
      ),
    );
  }

  String? _validateTfn(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return 'Required — without a TFN, super is taxed at 47%';
    }
    if (digits.length != 9) return 'TFN must be exactly 9 digits';
    if (!isValidTfn(digits)) return 'Invalid TFN (checksum failed)';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(onboardingViewModelProvider.notifier).updateStep(
      'taxDetails',
      {'tfn': _tfnController.text.trim(), 'taxScale': _taxScale},
    );

    widget.onComplete();
  }
}
