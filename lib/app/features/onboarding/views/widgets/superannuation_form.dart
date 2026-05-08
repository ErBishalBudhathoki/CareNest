import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/bauhaus_design.dart';
import '../../../../shared/widgets/bauhaus_widgets.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../providers/onboarding_providers.dart';
import '../../utils/australian_validators.dart';

enum _FundType { apra, smsf }

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
  ConsumerState<SuperannuationForm> createState() =>
      _SuperannuationFormState();
}

class _SuperannuationFormState
    extends ConsumerState<SuperannuationForm> {
  final _formKey = GlobalKey<FormState>();
  _FundType _fundType = _FundType.apra;

  late final TextEditingController _fundNameCtrl;
  late final TextEditingController _fundAbnCtrl;
  late final TextEditingController _usiCtrl;
  late final TextEditingController _memberNumberCtrl;
  late final TextEditingController _employeeNameCtrl;
  late final TextEditingController _smsfEsaCtrl;
  late final TextEditingController _smsfBsbCtrl;
  late final TextEditingController _smsfAccountCtrl;

  @override
  void initState() {
    super.initState();
    _fundNameCtrl =
        TextEditingController(text: widget.fundName ?? '');
    _fundAbnCtrl = TextEditingController();
    _usiCtrl = TextEditingController(text: widget.usi ?? '');
    _memberNumberCtrl =
        TextEditingController(text: widget.memberNumber ?? '');
    _employeeNameCtrl = TextEditingController();
    _smsfEsaCtrl = TextEditingController();
    _smsfBsbCtrl = TextEditingController();
    _smsfAccountCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _fundNameCtrl.dispose();
    _fundAbnCtrl.dispose();
    _usiCtrl.dispose();
    _memberNumberCtrl.dispose();
    _employeeNameCtrl.dispose();
    _smsfEsaCtrl.dispose();
    _smsfBsbCtrl.dispose();
    _smsfAccountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isApra = _fundType == _FundType.apra;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FundTypeToggle(
            selected: _fundType,
            onChanged: (v) => setState(() => _fundType = v),
          ),
          const SizedBox(height: 20),
          if (isApra) ..._apraFields() else ..._smsfFields(),
          const SizedBox(height: 24),
          ButtonWidget(
            buttonText: 'Save & Continue',
            onPressed: _submit,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _skip,
            child: Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(
                    color: BauhausDesign.neoInk.withOpacity(0.3),
                    width: 2),
              ),
              child: Text(
                'Skip for now',
                style: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _apraFields() {
    return [
      BauhausTextField(
        controller: _fundNameCtrl,
        label: 'Fund Name',
        hintText: 'e.g. AustralianSuper',
        validator: _required,
      ),
      const SizedBox(height: 16),
      BauhausTextField(
        controller: _fundAbnCtrl,
        label: 'Fund ABN',
        hintText: '12 345 678 901',
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        validator: _validateAbn,
      ),
      const SizedBox(height: 16),
      BauhausTextField(
        controller: _usiCtrl,
        label: 'USI',
        hintText: 'Usually ABN + 3 digits',
        validator: _validateUsi,
      ),
      const SizedBox(height: 16),
      BauhausTextField(
        controller: _memberNumberCtrl,
        label: 'Member / Account Number',
        hintText: 'Your fund member number',
        validator: _validateMemberNumber,
      ),
      const SizedBox(height: 16),
      BauhausTextField(
        controller: _employeeNameCtrl,
        label: 'Full Name (as on fund record)',
        hintText: 'Must match your fund record',
        validator: _required,
      ),
    ];
  }

  List<Widget> _smsfFields() {
    return [
      BauhausTextField(
        controller: _fundNameCtrl,
        label: 'SMSF Name',
        hintText: 'e.g. Smith Family Super Fund',
        validator: _required,
      ),
      const SizedBox(height: 16),
      BauhausTextField(
        controller: _fundAbnCtrl,
        label: 'SMSF ABN',
        hintText: '12 345 678 901',
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        validator: _validateAbn,
      ),
      const SizedBox(height: 16),
      BauhausTextField(
        controller: _smsfEsaCtrl,
        label: 'ESA (Electronic Service Address)',
        hintText: 'Alphanumeric, no spaces',
        validator: _validateEsa,
      ),
      const SizedBox(height: 16),
      BauhausTextField(
        controller: _smsfBsbCtrl,
        label: 'BSB',
        hintText: 'XXX-XXX',
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ],
        validator: _validateBsb,
      ),
      const SizedBox(height: 16),
      BauhausTextField(
        controller: _smsfAccountCtrl,
        label: 'Account Number',
        hintText: 'Up to 9 digits',
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(9),
        ],
        validator: _validateSmsfAccount,
      ),
    ];
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  String? _validateAbn(String? v) {
    final digits = (v ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return 'Required';
    if (digits.length != 11) return 'ABN must be 11 digits';
    if (!isValidAbn(digits)) return 'Invalid ABN (checksum failed)';
    return null;
  }

  String? _validateUsi(String? v) {
    final clean = stripNonAlphaNumeric(v ?? '');
    if (clean.isEmpty) return 'Required';
    if (clean.length < 9 || clean.length > 14) {
      return 'USI must be 9 to 14 characters';
    }
    return null;
  }

  String? _validateMemberNumber(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'Required';
    if (s.length < 5 || s.length > 20) {
      return 'Must be 5 to 20 characters';
    }
    return null;
  }

  String? _validateEsa(String? v) {
    final clean = stripNonAlphaNumeric(v ?? '');
    if (clean.isEmpty) return 'Required';
    if (clean.length > 16) {
      return 'ESA must be 16 characters or fewer';
    }
    if ((v ?? '').contains(' ')) {
      return 'ESA must not contain spaces';
    }
    return null;
  }

  String? _validateBsb(String? v) {
    final digits = (v ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return 'Required';
    if (digits.length != 6) return 'BSB must be 6 digits';
    return null;
  }

  String? _validateSmsfAccount(String? v) {
    final digits = (v ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return 'Required';
    if (digits.length > 9) {
      return 'Account number must be 9 digits or fewer';
    }
    return null;
  }

  Future<void> _skip() async {
    await ref
        .read(onboardingViewModelProvider.notifier)
        .updateStep('superannuation', {
      'fundType': 'apra',
      'fundName': '',
      'fundAbn': '',
      'currentStep': 4,
      'skipped': true,
    });
    widget.onComplete();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final isApra = _fundType == _FundType.apra;
    final data = <String, dynamic>{
      'fundType': isApra ? 'apra' : 'smsf',
      'fundName': _fundNameCtrl.text.trim(),
      'fundAbn':
          _fundAbnCtrl.text.replaceAll(RegExp(r'[^0-9]'), ''),
      'currentStep': 4,
    };

    if (isApra) {
      data['usi'] = _usiCtrl.text.trim().toUpperCase();
      data['memberNumber'] = _memberNumberCtrl.text.trim();
      data['employeeName'] = _employeeNameCtrl.text.trim();
    } else {
      data['smsfEsa'] = _smsfEsaCtrl.text.trim();
      data['smsfBsb'] = _smsfBsbCtrl.text.trim();
      data['smsfAccountNumber'] =
          _smsfAccountCtrl.text.trim();
    }

    await ref
        .read(onboardingViewModelProvider.notifier)
        .updateStep('superannuation', data);

    widget.onComplete();
  }
}

class _FundTypeToggle extends StatelessWidget {
  final _FundType selected;
  final ValueChanged<_FundType> onChanged;

  const _FundTypeToggle(
      {required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Option(
            label: 'Standard Fund\n(APRA)',
            isSelected: selected == _FundType.apra,
            onTap: () => onChanged(_FundType.apra),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _Option(
            label: 'SMSF',
            isSelected: selected == _FundType.smsf,
            onTap: () => onChanged(_FundType.smsf),
          ),
        ),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _Option({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? BauhausDesign.neoInk
              : BauhausDesign.surfaceWhite,
          border: Border.all(
            color: isSelected
                ? BauhausDesign.neoInk
                : BauhausDesign.neoInk.withOpacity(0.5),
            width: isSelected ? 2.5 : 2,
          ),
          boxShadow: isSelected
              ? const [BauhausDesign.shadowHardSm]
              : const [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: BauhausDesign.neoMonoStyle(
            context,
            color: isSelected
                ? BauhausDesign.surfaceWhite
                : BauhausDesign.textDark,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
