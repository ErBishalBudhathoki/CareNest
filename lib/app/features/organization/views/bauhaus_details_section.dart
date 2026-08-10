import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart';

// Organization Details Section with Data Visualization
class BauhausDetailsSection extends ConsumerStatefulWidget {
  final Organization organization;
  final Function(String, Map<String, dynamic>) onSave;

  const BauhausDetailsSection({
    super.key,
    required this.organization,
    required this.onSave,
  });

  @override
  ConsumerState<BauhausDetailsSection> createState() =>
      _BauhausDetailsSectionState();
}

class _BauhausDetailsSectionState extends ConsumerState<BauhausDetailsSection> {
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _abnController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _postcodeController;
  late TextEditingController _countryController;

  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.organization.name);
    _codeController = TextEditingController(text: widget.organization.code);
    _abnController = TextEditingController(text: widget.organization.abn ?? '');
    _streetController = TextEditingController(
      text: widget.organization.address?.street ?? '',
    );
    _cityController = TextEditingController(
      text: widget.organization.address?.city ?? '',
    );
    _stateController = TextEditingController(
      text: widget.organization.address?.state ?? '',
    );
    _postcodeController = TextEditingController(
      text: widget.organization.address?.postcode ?? '',
    );
    _countryController = TextEditingController(
      text: widget.organization.address?.country ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _abnController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Organization name is required';
    }
    if (value.trim().length < 2) {
      return 'Organization name must be at least 2 characters';
    }
    return null;
  }

  String? _validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Organization code is required';
    }
    if (value.trim().length < 2) {
      return 'Organization code must be at least 2 characters';
    }
    if (!RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(value.trim())) {
      return 'Code can only contain letters, numbers, hyphens, and underscores';
    }
    return null;
  }

  String? _validateAbn(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // ABN is optional
    }
    final abn = value.trim().replaceAll(RegExp(r'\s+'), '');
    if (abn.length != 11) {
      return 'ABN must be exactly 11 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(abn)) {
      return 'ABN must contain only digits';
    }
    return null;
  }

  void _saveOrganizationDetails() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      // Show saving indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saving organization details...'),
          backgroundColor: BauhausDesign.info,
        ),
      );

      // Create updated organization object
      final updates = {
        'name': _nameController.text.trim(),
        'code': _codeController.text.trim(),
        'abn': _abnController.text.trim().isEmpty
            ? null
            : _abnController.text.trim(),
        'address': {
          'street': _streetController.text.trim(),
          'city': _cityController.text.trim(),
          'state': _stateController.text.trim(),
          'postcode': _postcodeController.text.trim(),
          'country': _countryController.text.trim(),
        },
      };

      await widget.onSave(widget.organization.id, updates);

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Organization details saved successfully!'),
            backgroundColor: BauhausDesign.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage =
              'Failed to save organization details: ${e.toString()}';
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

        return Form(
          key: _formKey,
          child: Container(
            padding: isMobile
                ? EdgeInsets.zero
                : const EdgeInsets.all(BauhausDesign.space8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: BauhausDesign.space8),

                if (isMobile) ...[
                  // Mobile Layout (Stacked)
                  Column(
                    children: [
                      _BauhausInfoCard(
                        title: 'Basic Information',
                        children: [
                          _BauhausTextField(
                            controller: _nameController,
                            label: 'Organization Name',
                            hint: 'Enter organization name',
                            icon: Icons.business,
                            isRequired: true,
                            validator: _validateName,
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          _BauhausTextField(
                            controller: _codeController,
                            label: 'Organization Code',
                            hint: 'Unique identifier',
                            icon: Icons.tag,
                            isRequired: true,
                            validator: _validateCode,
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          _BauhausTextField(
                            controller: _abnController,
                            label: 'ABN (Australian Business Number)',
                            hint: '11-digit ABN',
                            icon: Icons.confirmation_number,
                            isRequired: false,
                            validator: _validateAbn,
                          ),
                        ],
                      ),

                      const SizedBox(height: BauhausDesign.space6),

                      _BauhausLegalStatusCard(
                        organization: widget.organization,
                      ),

                      const SizedBox(height: BauhausDesign.space6),

                      _BauhausAddressCard(
                        streetController: _streetController,
                        cityController: _cityController,
                        stateController: _stateController,
                        postcodeController: _postcodeController,
                        countryController: _countryController,
                        isMobile: isMobile,
                      ),

                      const SizedBox(height: BauhausDesign.space6),

                      _BauhausLocationCard(
                        organization: widget.organization,
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                ] else ...[
                  // Desktop Layout (Side-by-Side)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column - Basic Information
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _BauhausInfoCard(
                              title: 'Basic Information',
                              children: [
                                _BauhausTextField(
                                  controller: _nameController,
                                  label: 'Organization Name',
                                  hint: 'Enter organization name',
                                  icon: Icons.business,
                                  isRequired: true,
                                  validator: _validateName,
                                ),
                                const SizedBox(height: BauhausDesign.space4),
                                _BauhausTextField(
                                  controller: _codeController,
                                  label: 'Organization Code',
                                  hint: 'Unique identifier',
                                  icon: Icons.tag,
                                  isRequired: true,
                                  validator: _validateCode,
                                ),
                                const SizedBox(height: BauhausDesign.space4),
                                _BauhausTextField(
                                  controller: _abnController,
                                  label: 'ABN (Australian Business Number)',
                                  hint: '11-digit ABN',
                                  icon: Icons.confirmation_number,
                                  isRequired: false,
                                  validator: _validateAbn,
                                ),
                              ],
                            ),

                            const SizedBox(height: BauhausDesign.space6),

                            // Legal Status Visualization
                            _BauhausLegalStatusCard(
                              organization: widget.organization,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: BauhausDesign.space6),

                      // Right Column - Address Information
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _BauhausAddressCard(
                              streetController: _streetController,
                              cityController: _cityController,
                              stateController: _stateController,
                              postcodeController: _postcodeController,
                              countryController: _countryController,
                              isMobile: isMobile,
                            ),

                            const SizedBox(height: BauhausDesign.space6),

                            // Geographic Visualization
                            _BauhausLocationCard(
                              organization: widget.organization,
                              isMobile: isMobile,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: BauhausDesign.space8),

                // Data Completeness Visualization
                _BauhausDataCompletenessCard(organization: widget.organization),

                const SizedBox(height: BauhausDesign.space8),

                // Action Buttons
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _BauhausSecondaryButton(
                            text: 'Cancel Changes',
                            onPressed: () {
                              // Reset controllers to original values
                              _nameController.text = widget.organization.name;
                              _codeController.text = widget.organization.code;
                              _abnController.text =
                                  widget.organization.abn ?? '';
                              _streetController.text =
                                  widget.organization.address?.street ?? '';
                              _cityController.text =
                                  widget.organization.address?.city ?? '';
                              _stateController.text =
                                  widget.organization.address?.state ?? '';
                              _postcodeController.text =
                                  widget.organization.address?.postcode ?? '';
                              _countryController.text =
                                  widget.organization.address?.country ?? '';
                            },
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          _BauhausPrimaryButton(
                            text: 'Save Details',
                            onPressed: _isSaving
                                ? null
                                : _saveOrganizationDetails,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _BauhausSecondaryButton(
                            text: 'Cancel Changes',
                            onPressed: () {
                              // Reset controllers to original values
                              _nameController.text = widget.organization.name;
                              _codeController.text = widget.organization.code;
                              _abnController.text =
                                  widget.organization.abn ?? '';
                              _streetController.text =
                                  widget.organization.address?.street ?? '';
                              _cityController.text =
                                  widget.organization.address?.city ?? '';
                              _stateController.text =
                                  widget.organization.address?.state ?? '';
                              _postcodeController.text =
                                  widget.organization.address?.postcode ?? '';
                              _countryController.text =
                                  widget.organization.address?.country ?? '';
                            },
                          ),
                          const SizedBox(width: BauhausDesign.space4),
                          _BauhausPrimaryButton(
                            text: 'Save Details',
                            onPressed: _isSaving
                                ? null
                                : _saveOrganizationDetails,
                          ),
                        ],
                      ),
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
  final IconData icon;
  final bool isRequired;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _BauhausTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.isRequired,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceOffWhite,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  color: BauhausDesign.primary,
                  child: Icon(icon, color: Colors.white, size: 16),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Text(
                    '$label${isRequired ? " *" : ""}',
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontMd,
                      fontWeight: FontWeight.w600,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontMd,
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontMd,
                  color: BauhausDesign.textMuted,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                errorStyle: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontSm,
                  color: BauhausDesign.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausInfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _BauhausInfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.primary,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: Colors.white.withValues(alpha: 0.2),
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Text(
                  title,
                  style: GoogleFonts.oswald(
                    fontSize: BauhausDesign.fontLg,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _BauhausAddressCard extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postcodeController;
  final TextEditingController countryController;
  final bool isMobile;

  const _BauhausAddressCard({
    required this.streetController,
    required this.cityController,
    required this.stateController,
    required this.postcodeController,
    required this.countryController,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.secondary,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: Colors.white.withValues(alpha: 0.2),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Text(
                  'Address Information',
                  style: GoogleFonts.oswald(
                    fontSize: BauhausDesign.fontLg,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                _BauhausTextField(
                  controller: streetController,
                  label: 'Street Address',
                  hint: '123 Main Street',
                  icon: Icons.home_outlined,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Street address is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: BauhausDesign.space4),
                if (isMobile) ...[
                  _BauhausTextField(
                    controller: cityController,
                    label: 'City',
                    hint: 'Sydney',
                    icon: Icons.location_city_outlined,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'City is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _BauhausTextField(
                    controller: stateController,
                    label: 'State',
                    hint: 'NSW',
                    icon: Icons.map_outlined,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'State is required';
                      }
                      return null;
                    },
                  ),
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: _BauhausTextField(
                          controller: cityController,
                          label: 'City',
                          hint: 'Sydney',
                          icon: Icons.location_city_outlined,
                          isRequired: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'City is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: _BauhausTextField(
                          controller: stateController,
                          label: 'State',
                          hint: 'NSW',
                          icon: Icons.map_outlined,
                          isRequired: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'State is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: BauhausDesign.space4),
                if (isMobile) ...[
                  _BauhausTextField(
                    controller: postcodeController,
                    label: 'Postcode',
                    hint: '2000',
                    icon: Icons.local_post_office_outlined,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Postcode is required';
                      }
                      if (value.trim().length < 4) {
                        return 'Postcode must be at least 4 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _BauhausTextField(
                    controller: countryController,
                    label: 'Country',
                    hint: 'Australia',
                    icon: Icons.public_outlined,
                    isRequired: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Country is required';
                      }
                      return null;
                    },
                  ),
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: _BauhausTextField(
                          controller: postcodeController,
                          label: 'Postcode',
                          hint: '2000',
                          icon: Icons.local_post_office_outlined,
                          isRequired: true,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Postcode is required';
                            }
                            if (value.trim().length < 4) {
                              return 'Postcode must be at least 4 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: _BauhausTextField(
                          controller: countryController,
                          label: 'Country',
                          hint: 'Australia',
                          icon: Icons.public_outlined,
                          isRequired: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Country is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausLegalStatusCard extends StatelessWidget {
  final Organization organization;

  const _BauhausLegalStatusCard({required this.organization});

  @override
  Widget build(BuildContext context) {
    bool hasAbn = organization.abn != null && organization.abn!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: hasAbn ? BauhausDesign.success : BauhausDesign.warning,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: Colors.white.withValues(alpha: 0.2),
                  child: Icon(
                    hasAbn
                        ? Icons.verified_outlined
                        : Icons.warning_amber_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasAbn ? 'ABN Registered' : 'ABN Not Provided',
                        style: GoogleFonts.oswald(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        hasAbn
                            ? 'Valid Australian Business Number'
                            : 'Required for invoicing',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                _BauhausStatusRow(
                  icon: Icons.business_outlined,
                  label: 'Business Name',
                  value: organization.name,
                  isComplete: organization.name.isNotEmpty,
                ),
                const SizedBox(height: BauhausDesign.space3),
                _BauhausStatusRow(
                  icon: Icons.tag_outlined,
                  label: 'Organization Code',
                  value: organization.code,
                  isComplete: organization.code.isNotEmpty,
                ),
                const SizedBox(height: BauhausDesign.space3),
                _BauhausStatusRow(
                  icon: Icons.confirmation_number_outlined,
                  label: 'ABN Status',
                  value: hasAbn
                      ? (organization.abn ?? 'Not provided')
                      : 'Not provided',
                  isComplete: hasAbn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausLocationCard extends StatelessWidget {
  final Organization organization;
  final bool isMobile;

  const _BauhausLocationCard({
    required this.organization,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    bool hasAddress = organization.address != null;
    bool isComplete =
        hasAddress &&
        organization.address!.street!.isNotEmpty &&
        organization.address!.city!.isNotEmpty &&
        organization.address!.state!.isNotEmpty &&
        organization.address!.postcode!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: isComplete ? BauhausDesign.success : BauhausDesign.info,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: Colors.white.withValues(alpha: 0.2),
                  child: Icon(
                    isComplete
                        ? Icons.location_on_outlined
                        : Icons.map_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isComplete ? 'Location Complete' : 'Location Pending',
                        style: GoogleFonts.oswald(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        hasAddress ? 'Address configured' : 'Address not set',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                if (hasAddress) ...[
                  _BauhausLocationInfo(
                    icon: Icons.home_outlined,
                    label: 'Street',
                    value: organization.address!.street!,
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  if (isMobile) ...[
                    _BauhausLocationInfo(
                      icon: Icons.location_city_outlined,
                      label: 'City',
                      value: organization.address!.city!,
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _BauhausLocationInfo(
                      icon: Icons.map_outlined,
                      label: 'State',
                      value: organization.address!.state!,
                    ),
                  ] else
                    Row(
                      children: [
                        Expanded(
                          child: _BauhausLocationInfo(
                            icon: Icons.location_city_outlined,
                            label: 'City',
                            value: organization.address!.city!,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Expanded(
                          child: _BauhausLocationInfo(
                            icon: Icons.map_outlined,
                            label: 'State',
                            value: organization.address!.state!,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: BauhausDesign.space3),
                  if (isMobile) ...[
                    _BauhausLocationInfo(
                      icon: Icons.local_post_office_outlined,
                      label: 'Postcode',
                      value: organization.address!.postcode!,
                    ),
                    const SizedBox(height: BauhausDesign.space3),
                    _BauhausLocationInfo(
                      icon: Icons.public_outlined,
                      label: 'Country',
                      value: organization.address!.country!,
                    ),
                  ] else
                    Row(
                      children: [
                        Expanded(
                          child: _BauhausLocationInfo(
                            icon: Icons.local_post_office_outlined,
                            label: 'Postcode',
                            value: organization.address!.postcode!,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Expanded(
                          child: _BauhausLocationInfo(
                            icon: Icons.public_outlined,
                            label: 'Country',
                            value: organization.address!.country!,
                          ),
                        ),
                      ],
                    ),
                ] else
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space6),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceOffWhite,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_off_outlined,
                          size: 48,
                          color: BauhausDesign.textMuted,
                        ),
                        const SizedBox(height: BauhausDesign.space3),
                        Text(
                          'No Address Configured',
                          style: GoogleFonts.inter(
                            fontSize: BauhausDesign.fontMd,
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textDark,
                          ),
                        ),
                        const SizedBox(height: BauhausDesign.space2),
                        Text(
                          'Add your business address above',
                          style: GoogleFonts.inter(
                            fontSize: BauhausDesign.fontSm,
                            color: BauhausDesign.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausStatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isComplete;

  const _BauhausStatusRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: isComplete
            ? BauhausDesign.success.withValues(alpha: 0.1)
            : BauhausDesign.warning.withValues(alpha: 0.1),
        border: Border.all(
          color: isComplete ? BauhausDesign.success : BauhausDesign.warning,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            color: isComplete ? BauhausDesign.success : BauhausDesign.warning,
            child: Icon(
              isComplete
                  ? Icons.check_circle_outline
                  : Icons.radio_button_unchecked,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  value.isNotEmpty ? value : 'Not provided',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    color: value.isNotEmpty
                        ? BauhausDesign.textDark
                        : BauhausDesign.textMuted,
                    fontStyle: value.isEmpty
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausLocationInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _BauhausLocationInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space2),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: BauhausDesign.textMuted),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontXs,
                    color: BauhausDesign.textMuted,
                  ),
                ),
                Text(
                  value.isNotEmpty ? value : '—',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausDataCompletenessCard extends StatelessWidget {
  final Organization organization;

  const _BauhausDataCompletenessCard({required this.organization});

  @override
  Widget build(BuildContext context) {
    int totalFields = 6; // name, code, abn, street, city, state
    int completedFields = 0;

    if (organization.name.isNotEmpty) completedFields++;
    if (organization.code.isNotEmpty) completedFields++;
    if (organization.abn != null && organization.abn!.isNotEmpty) {
      completedFields++;
    }
    if (organization.address?.street?.isNotEmpty == true) completedFields++;
    if (organization.address?.city?.isNotEmpty == true) completedFields++;
    if (organization.address?.state?.isNotEmpty == true) completedFields++;

    double completenessPercentage = (completedFields / totalFields) * 100;

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: completenessPercentage >= 80
                  ? BauhausDesign.success
                  : completenessPercentage >= 50
                  ? BauhausDesign.warning
                  : BauhausDesign.error,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: Colors.white.withValues(alpha: 0.2),
                  child: Icon(
                    completenessPercentage >= 80
                        ? Icons.check_circle_outline
                        : completenessPercentage >= 50
                        ? Icons.warning_amber_outlined
                        : Icons.error_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile Completeness',
                        style: GoogleFonts.oswald(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$completedFields of $totalFields fields completed',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                // Progress Bar
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: completedFields,
                        child: Container(
                          color: completenessPercentage >= 80
                              ? BauhausDesign.success
                              : completenessPercentage >= 50
                              ? BauhausDesign.warning
                              : BauhausDesign.error,
                        ),
                      ),
                      Expanded(
                        flex: totalFields - completedFields,
                        child: Container(color: BauhausDesign.surfaceOffWhite),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: BauhausDesign.space4),

                // Status Message
                Text(
                  completenessPercentage >= 80
                      ? 'Excellent! Your profile is complete.'
                      : completenessPercentage >= 50
                      ? 'Good progress. Complete remaining fields for full functionality.'
                      : 'Complete your profile to unlock all features.',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    color: BauhausDesign.textDark,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Common Button Components (same as branding section)
class _BauhausPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const _BauhausPrimaryButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    return Container(
      decoration: BoxDecoration(
        color: isEnabled
            ? BauhausDesign.primary
            : BauhausDesign.neutral.withValues(alpha: 0.1),
        border: Border.all(
          color: isEnabled
              ? BauhausDesign.neutral
              : BauhausDesign.neutral.withValues(alpha: 0.3),
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
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontMd,
                fontWeight: FontWeight.w600,
                color: isEnabled
                    ? Colors.white
                    : BauhausDesign.textDark.withValues(alpha: 0.3),
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
        color: BauhausDesign.surfaceWhite,
        border: Border.all(
          color: isEnabled
              ? BauhausDesign.neutral
              : BauhausDesign.neutral.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: BauhausDesign.secondary,
                  offset: const Offset(2, 2),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ]
            : [],
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
                    ? BauhausDesign.textDark
                    : BauhausDesign.textDark.withValues(alpha: 0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
