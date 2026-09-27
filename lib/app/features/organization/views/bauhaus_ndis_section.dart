import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart'
    as models;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';

class BauhausNDISection extends ConsumerStatefulWidget {
  final models.Organization organization;
  final Function(String, Map<String, dynamic>) onSave;

  const BauhausNDISection({
    super.key,
    required this.organization,
    required this.onSave,
  });

  @override
  ConsumerState<BauhausNDISection> createState() => _BauhausNDISectionState();
}

class _BauhausNDISectionState extends ConsumerState<BauhausNDISection> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _registrationNumberController;
  bool _isRegistered = false;

  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _isRegistered = widget.organization.ndisRegistration?.isRegistered ?? false;
    _registrationNumberController = TextEditingController(
      text: widget.organization.ndisRegistration?.registrationNumber ?? '',
    );
  }

  @override
  void dispose() {
    _registrationNumberController.dispose();
    super.dispose();
  }

  String? _validateRegistrationNumber(String? value) {
    if (!_isRegistered) {
      return null; // Not required if not registered
    }
    if (value == null || value.isEmpty) {
      return 'Registration number is required when NDIS registered';
    }
    final ndisRegex = RegExp(r'^\d{6,10}$');
    if (!ndisRegex.hasMatch(value)) {
      return 'Please enter a valid NDIS registration number (6-10 digits)';
    }
    return null;
  }

  Future<void> _saveNDISDetails() async {
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
          content: Text('Saving NDIS details...'),
          backgroundColor: BauhausDesign.info,
        ),
      );

      final updates = {
        'ndisRegistration': {
          'isRegistered': _isRegistered,
          'registrationNumber':
              _registrationNumberController.text.trim().isEmpty
              ? null
              : _registrationNumberController.text.trim(),
        },
      };

      await widget.onSave(widget.organization.id, updates);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('NDIS details saved successfully!'),
            backgroundColor: BauhausDesign.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to save NDIS details: ${e.toString()}';
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
          padding: isMobile
              ? EdgeInsets.zero
              : const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
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
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        color: Theme.of(context).colorScheme.surface,
                        child: Icon(
                          Icons.verified,
                          color: BauhausDesign.primary,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NDIS REGISTRATION',
                              style: GoogleFonts.inter(
                                fontSize: BauhausDesign.fontLg,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSurface,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Manage your NDIS registration status and details',
                              style: GoogleFonts.inter(
                                fontSize: BauhausDesign.fontSm,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: BauhausDesign.space6),

                // NDIS Registration Toggle
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        color: _isRegistered
                            ? BauhausDesign.success
                            : Theme.of(context).colorScheme.onSurface,
                        child: Icon(
                          _isRegistered
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: _isRegistered
                              ? BauhausDesign.readableOnColor(
                                  BauhausDesign.success,
                                )
                              : Theme.of(context).colorScheme.surface,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isRegistered
                                  ? 'NDIS REGISTERED'
                                  : 'NOT NDIS REGISTERED',
                              style: GoogleFonts.inter(
                                fontSize: BauhausDesign.fontMd,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              _isRegistered
                                  ? 'Your organization is registered with NDIS'
                                  : 'Your organization is not registered with NDIS',
                              style: GoogleFonts.inter(
                                fontSize: BauhausDesign.fontSm,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Bauhaus switch: zero radius, 2px borders, hard shadow,
                      // themed track/thumb — unlike Material's rounded
                      // `Switch`, which does not match DESIGN.md.
                      BauhausSwitch(
                        value: _isRegistered,
                        variant: BauhausSwitchVariant.secondary,
                        onChanged: (value) {
                          setState(() {
                            _isRegistered = value;
                            if (!_isRegistered) {
                              _registrationNumberController.clear();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: BauhausDesign.space4),

                // Registration Number Field (only show if registered)
                if (_isRegistered) ...[
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTRATION NUMBER',
                          style: GoogleFonts.inter(
                            fontSize: BauhausDesign.fontXs,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: BauhausDesign.space1),
                        TextFormField(
                          controller: _registrationNumberController,
                          validator: _validateRegistrationNumber,
                          enabled: _isRegistered,
                          style: GoogleFonts.inter(
                            fontSize: BauhausDesign.fontMd,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter NDIS registration number',
                            hintStyle: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontMd,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            filled: true,
                            fillColor: _isRegistered
                                ? Theme.of(context).colorScheme.onInverseSurface
                                : Theme.of(
                                    context,
                                  ).colorScheme.outline.withValues(alpha: 0.1),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.zero,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.zero,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BauhausDesign.primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.zero,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: BauhausDesign.error,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.zero,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: BauhausDesign.space3,
                              vertical: BauhausDesign.space3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: BauhausDesign.space6),

                // NDIS Status Card
                _BauhausNDISatusCard(organization: widget.organization),

                SizedBox(height: BauhausDesign.space6),

                // Action Buttons
                if (isMobile) ...[
                  // Stacked buttons for mobile
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _BauhausPrimaryButton(
                        text: 'SAVE NDIS DETAILS',
                        onPressed: _isSaving ? null : _saveNDISDetails,
                        isLoading: _isSaving,
                      ),
                      SizedBox(height: BauhausDesign.space3),
                      _BauhausSecondaryButton(
                        text: 'RESET',
                        onPressed: _isSaving
                            ? null
                            : () {
                                // Reset to original values
                                setState(() {
                                  _isRegistered =
                                      widget
                                          .organization
                                          .ndisRegistration
                                          ?.isRegistered ??
                                      false;
                                  _errorMessage = null;
                                });
                                _registrationNumberController.text =
                                    widget
                                        .organization
                                        .ndisRegistration
                                        ?.registrationNumber ??
                                    '';
                              },
                      ),
                    ],
                  ),
                ] else ...[
                  // Row buttons for desktop
                  Row(
                    children: [
                      _BauhausPrimaryButton(
                        text: 'SAVE NDIS DETAILS',
                        onPressed: _isSaving ? null : _saveNDISDetails,
                        isLoading: _isSaving,
                      ),
                      SizedBox(width: BauhausDesign.space3),
                      _BauhausSecondaryButton(
                        text: 'RESET',
                        onPressed: _isSaving
                            ? null
                            : () {
                                // Reset to original values
                                setState(() {
                                  _isRegistered =
                                      widget
                                          .organization
                                          .ndisRegistration
                                          ?.isRegistered ??
                                      false;
                                  _errorMessage = null;
                                });
                                _registrationNumberController.text =
                                    widget
                                        .organization
                                        .ndisRegistration
                                        ?.registrationNumber ??
                                    '';
                              },
                      ),
                    ],
                  ),
                ],

                if (_errorMessage != null) ...[
                  SizedBox(height: BauhausDesign.space3),
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.error.withValues(alpha: 0.1),
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
        color: isEnabled
            ? BauhausDesign.primary
            : Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
        border: Border.all(
          color: isEnabled
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          width: 2,
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
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onInverseSurface,
                      ),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontMd,
                      fontWeight: FontWeight.w600,
                      color: isEnabled
                          ? Theme.of(context).colorScheme.onInverseSurface
                          : Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.3),
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

  const _BauhausSecondaryButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: isEnabled
              ? Theme.of(context).colorScheme.outline
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          width: 2,
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
                color: isEnabled
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _BauhausNDISatusCard extends StatelessWidget {
  final models.Organization organization;

  const _BauhausNDISatusCard({required this.organization});

  @override
  Widget build(BuildContext context) {
    final isRegistered = organization.ndisRegistration?.isRegistered ?? false;
    final registrationNumber =
        organization.ndisRegistration?.registrationNumber;
    final hasRegistrationNumber = registrationNumber?.isNotEmpty ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
        boxShadow: [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: isRegistered
                  ? BauhausDesign.success
                  : Theme.of(context).colorScheme.outline,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isRegistered ? Icons.verified : Icons.pending,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 20,
                ),
                SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    isRegistered ? 'NDIS REGISTERED' : 'NOT NDIS REGISTERED',
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontSm,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
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
                  'NDIS Registration Status',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontMd,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: BauhausDesign.space3),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: isRegistered
                            ? BauhausDesign.success
                            : Theme.of(context).colorScheme.outline,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: isRegistered
                          ? Icon(
                              Icons.check,
                              size: 12,
                              color: Theme.of(context).colorScheme.onSurface,
                            )
                          : null,
                    ),
                    SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registration Status',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontXs,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.7),
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            isRegistered ? 'Registered' : 'Not Registered',
                            style: GoogleFonts.inter(
                              fontSize: BauhausDesign.fontSm,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isRegistered && hasRegistrationNumber) ...[
                  SizedBox(height: BauhausDesign.space3),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: hasRegistrationNumber
                              ? BauhausDesign.success
                              : Theme.of(context).colorScheme.outline,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        child: hasRegistrationNumber
                            ? Icon(
                                Icons.check,
                                size: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                              )
                            : null,
                      ),
                      SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Registration Number',
                              style: GoogleFonts.inter(
                                fontSize: BauhausDesign.fontXs,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              registrationNumber ?? 'Not provided',
                              style: GoogleFonts.inter(
                                fontSize: BauhausDesign.fontSm,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
