import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart' as models;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BauhausBankingSection extends ConsumerStatefulWidget {
  final models.Organization organization;
  final Function(String, Map<String, dynamic>) onSave;

  const BauhausBankingSection({
    super.key,
    required this.organization,
    required this.onSave,
  });

  @override
  ConsumerState<BauhausBankingSection> createState() => _BauhausBankingSectionState();
}

class _BauhausBankingSectionState extends ConsumerState<BauhausBankingSection> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _bankNameController;
  late TextEditingController _accountNameController;
  late TextEditingController _bsbController;
  late TextEditingController _accountNumberController;
  
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _bankNameController = TextEditingController(text: widget.organization.bankDetails?.bankName ?? '');
    _accountNameController = TextEditingController(text: widget.organization.bankDetails?.accountName ?? '');
    _bsbController = TextEditingController(text: widget.organization.bankDetails?.bsb ?? '');
    _accountNumberController = TextEditingController(text: widget.organization.bankDetails?.accountNumber ?? '');
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNameController.dispose();
    _bsbController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  String? _validateBSB(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    final bsbRegex = RegExp(r'^\d{3}-\d{3}$');
    if (!bsbRegex.hasMatch(value)) {
      return 'Please enter a valid BSB (XXX-XXX)';
    }
    return null;
  }

  String? _validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    final accountRegex = RegExp(r'^\d{6,10}$');
    if (!accountRegex.hasMatch(value)) {
      return 'Please enter a valid account number (6-10 digits)';
    }
    return null;
  }

  Future<void> _saveBankingDetails() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saving banking details...'),
          backgroundColor: BauhausDesign.info,
        ),
      );

      final updates = {
        'bankDetails': {
          'bankName': _bankNameController.text.trim().isEmpty ? null : _bankNameController.text.trim(),
          'accountName': _accountNameController.text.trim().isEmpty ? null : _accountNameController.text.trim(),
          'bsb': _bsbController.text.trim().isEmpty ? null : _bsbController.text.trim(),
          'accountNumber': _accountNumberController.text.trim().isEmpty ? null : _accountNumberController.text.trim(),
        }
      };

      await widget.onSave(widget.organization.id, updates);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Banking details saved successfully!'),
            backgroundColor: BauhausDesign.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to save banking details: ${e.toString()}';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          padding: isMobile ? EdgeInsets.zero : const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceOffWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: [BauhausDesign.shadowHard],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  decoration: BoxDecoration(
                    color: BauhausDesign.primary,
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        color: BauhausDesign.surfaceWhite,
                        child: Icon(Icons.account_balance, color: BauhausDesign.primary, size: 24),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BANKING DETAILS',
                              style: GoogleFonts.inter(
                                fontSize: BauhausDesign.fontLg,
                                fontWeight: FontWeight.w700,
                                color: BauhausDesign.textDark,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Manage your organization\'s banking information',
                              style: GoogleFonts.inter(
                                fontSize: BauhausDesign.fontSm,
                                fontWeight: FontWeight.w400,
                                color: BauhausDesign.textDark.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: BauhausDesign.space6),

                // Banking Form Fields
                if (isMobile) ...[
                  // Mobile Layout (Stacked)
                  _BauhausTextField(
                    controller: _bankNameController,
                    label: 'BANK NAME',
                    hint: 'Enter bank name',
                    validator: (value) => value == null || value.isEmpty ? 'Bank name is required' : null,
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _BauhausTextField(
                    controller: _accountNameController,
                    label: 'ACCOUNT NAME',
                    hint: 'Enter account holder name',
                    validator: (value) => value == null || value.isEmpty ? 'Account name is required' : null,
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _BauhausTextField(
                    controller: _bsbController,
                    label: 'BSB',
                    hint: 'XXX-XXX',
                    validator: _validateBSB,
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _BauhausTextField(
                    controller: _accountNumberController,
                    label: 'ACCOUNT NUMBER',
                    hint: 'Enter account number',
                    validator: _validateAccountNumber,
                  ),
                ] else ...[
                  // Desktop Layout (Row)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _BauhausTextField(
                              controller: _bankNameController,
                              label: 'BANK NAME',
                              hint: 'Enter bank name',
                              validator: (value) => value == null || value.isEmpty ? 'Bank name is required' : null,
                            ),
                            const SizedBox(height: BauhausDesign.space4),
                            _BauhausTextField(
                              controller: _accountNameController,
                              label: 'ACCOUNT NAME',
                              hint: 'Enter account holder name',
                              validator: (value) => value == null || value.isEmpty ? 'Account name is required' : null,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: BauhausDesign.space6),

                      // Right Column
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _BauhausTextField(
                              controller: _bsbController,
                              label: 'BSB',
                              hint: 'XXX-XXX',
                              validator: _validateBSB,
                            ),
                            const SizedBox(height: BauhausDesign.space4),
                            _BauhausTextField(
                              controller: _accountNumberController,
                              label: 'ACCOUNT NUMBER',
                              hint: 'Enter account number',
                              validator: _validateAccountNumber,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: BauhausDesign.space6),

                // Banking Status Card
                _BauhausBankingStatusCard(organization: widget.organization),

                const SizedBox(height: BauhausDesign.space6),

                // Action Buttons
                if (isMobile) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _BauhausPrimaryButton(
                        text: 'SAVE BANKING DETAILS',
                        onPressed: _isSaving ? null : _saveBankingDetails,
                        isLoading: _isSaving,
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      _BauhausSecondaryButton(
                        text: 'RESET',
                        onPressed: _isSaving 
                            ? null 
                            : () {
                                setState(() {
                                  _errorMessage = null;
                                });
                                // Reset controllers to original values
                                _bankNameController.text = widget.organization.bankDetails?.bankName ?? '';
                                _accountNameController.text = widget.organization.bankDetails?.accountName ?? '';
                                _bsbController.text = widget.organization.bankDetails?.bsb ?? '';
                                _accountNumberController.text = widget.organization.bankDetails?.accountNumber ?? '';
                              },
                      ),
                    ],
                  ),
                ] else ...[
                  Row(
                    children: [
                      _BauhausPrimaryButton(
                        text: 'SAVE BANKING DETAILS',
                        onPressed: _isSaving ? null : _saveBankingDetails,
                        isLoading: _isSaving,
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      _BauhausSecondaryButton(
                        text: 'RESET',
                        onPressed: _isSaving 
                            ? null 
                            : () {
                                setState(() {
                                  _errorMessage = null;
                                });
                                // Reset controllers to original values
                                _bankNameController.text = widget.organization.bankDetails?.bankName ?? '';
                                _accountNameController.text = widget.organization.bankDetails?.accountName ?? '';
                                _bsbController.text = widget.organization.bankDetails?.bsb ?? '';
                                _accountNumberController.text = widget.organization.bankDetails?.accountNumber ?? '';
                              },
                      ),
                    ],
                  ),
                ],

                if (_errorMessage != null) ...[
                  const SizedBox(height: BauhausDesign.space3),
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.error.withOpacity(0.1),
                      border: Border.all(color: BauhausDesign.error, width: 2),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: GoogleFonts.inter(
                        fontSize: BauhausDesign.fontSm,
                        fontWeight: FontWeight.w500,
                        color: BauhausDesign.error,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BauhausTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;

  const _BauhausTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontXs,
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        TextFormField(
          controller: controller,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontMd,
            fontWeight: FontWeight.w500,
            color: BauhausDesign.textDark,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: BauhausDesign.fontMd,
              fontWeight: FontWeight.w400,
              color: BauhausDesign.textDark.withOpacity(0.5),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.neutral, width: 2),
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.neutral, width: 2),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.primary, width: 2),
              borderRadius: BorderRadius.zero,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: BauhausDesign.error, width: 2),
              borderRadius: BorderRadius.zero,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space3,
            ),
          ),
        ),
      ],
    );
  }
}

// Common Button Components
class _BauhausPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _BauhausPrimaryButton({
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return Container(
      decoration: BoxDecoration(
        color: isEnabled ? BauhausDesign.primary : BauhausDesign.neutral.withOpacity(0.1),
        border: Border.all(
          color: isEnabled ? BauhausDesign.neutral : BauhausDesign.neutral.withOpacity(0.3), 
          width: 2
        ),
        boxShadow: isEnabled ? [BauhausDesign.shadowHard] : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space6,
              vertical: BauhausDesign.space3,
            ),
            child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      text,
                      style: GoogleFonts.inter(
                        fontSize: BauhausDesign.fontMd,
                        fontWeight: FontWeight.w600,
                        color: isEnabled ? Colors.white : BauhausDesign.textDark.withOpacity(0.3),
                      ),
                      textAlign: TextAlign.center,
                    ),
          ),
        ),
      ),
    );
  }
}

class _BauhausSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const _BauhausSecondaryButton({
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: isEnabled ? BauhausDesign.neutral : BauhausDesign.neutral.withOpacity(0.3), 
          width: 2
        ),
        boxShadow: isEnabled ? [BauhausDesign.shadowHardSm] : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space6,
              vertical: BauhausDesign.space3,
            ),
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontMd,
                fontWeight: FontWeight.w600,
                color: isEnabled ? BauhausDesign.textDark : BauhausDesign.textDark.withOpacity(0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _BauhausBankingStatusCard extends StatelessWidget {
  final models.Organization organization;

  const _BauhausBankingStatusCard({required this.organization});

  @override
  Widget build(BuildContext context) {
    final hasBankName = organization.bankDetails?.bankName?.isNotEmpty ?? false;
    final hasAccountName = organization.bankDetails?.accountName?.isNotEmpty ?? false;
    final hasBSB = organization.bankDetails?.bsb?.isNotEmpty ?? false;
    final hasAccountNumber = organization.bankDetails?.accountNumber?.isNotEmpty ?? false;
    
    final completedFields = [hasBankName, hasAccountName, hasBSB, hasAccountNumber].where((e) => e).length;
    final totalFields = 4;
    final completionPercentage = (completedFields / totalFields * 100).round();

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: completionPercentage == 100 ? BauhausDesign.success : BauhausDesign.warning,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  completionPercentage == 100 ? Icons.check_circle : Icons.info,
                  color: BauhausDesign.textDark,
                  size: 20,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    completionPercentage == 100 
                        ? 'BANKING DETAILS COMPLETE' 
                        : 'BANKING DETAILS $completionPercentage% COMPLETE',
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontSm,
                      fontWeight: FontWeight.w600,
                      color: BauhausDesign.textDark,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Banking Information Status',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontMd,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                _BauhausStatusItem(
                  label: 'Bank Name',
                  isComplete: hasBankName,
                  value: organization.bankDetails?.bankName ?? 'Not provided',
                ),
                const SizedBox(height: BauhausDesign.space2),
                _BauhausStatusItem(
                  label: 'Account Name',
                  isComplete: hasAccountName,
                  value: organization.bankDetails?.accountName ?? 'Not provided',
                ),
                const SizedBox(height: BauhausDesign.space2),
                _BauhausStatusItem(
                  label: 'BSB',
                  isComplete: hasBSB,
                  value: organization.bankDetails?.bsb ?? 'Not provided',
                ),
                const SizedBox(height: BauhausDesign.space2),
                _BauhausStatusItem(
                  label: 'Account Number',
                  isComplete: hasAccountNumber,
                  value: organization.bankDetails?.accountNumber ?? 'Not provided',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausStatusItem extends StatelessWidget {
  final String label;
  final bool isComplete;
  final String value;

  const _BauhausStatusItem({
    required this.label,
    required this.isComplete,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isComplete ? BauhausDesign.success : BauhausDesign.neutral,
            border: Border.all(color: BauhausDesign.neutral, width: 1),
          ),
          child: isComplete
              ? Icon(Icons.check, size: 12, color: BauhausDesign.textDark)
              : null,
        ),
        const SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontXs,
                  fontWeight: FontWeight.w600,
                  color: BauhausDesign.textDark.withOpacity(0.7),
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontSm,
                  fontWeight: FontWeight.w500,
                  color: BauhausDesign.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}