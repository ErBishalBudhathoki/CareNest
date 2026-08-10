import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart'
    as models;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BauhausContactSection extends ConsumerStatefulWidget {
  final models.Organization organization;
  final Function(String, Map<String, dynamic>) onSave;

  const BauhausContactSection({
    super.key,
    required this.organization,
    required this.onSave,
  });

  @override
  ConsumerState<BauhausContactSection> createState() =>
      _BauhausContactSectionState();
}

class _BauhausContactSectionState extends ConsumerState<BauhausContactSection> {
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _websiteController;

  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(
      text: widget.organization.contactDetails?.phone ?? '',
    );
    _emailController = TextEditingController(
      text: widget.organization.contactDetails?.email ?? '',
    );
    _websiteController = TextEditingController(
      text: widget.organization.contactDetails?.website ?? '',
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Email is optional
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateWebsite(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Website is optional
    }
    final websiteRegex = RegExp(r"^https?://[\w\-._~:/?#\[\]@!$&'()*+,;=]+$");
    if (!websiteRegex.hasMatch(value.trim())) {
      return 'Please enter a valid website URL (include http:// or https://)';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone is optional
    }
    final phoneRegex = RegExp(r"^\+?[\d\s\-\(\)]+$");
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  Future<void> _saveContactDetails() async {
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
          content: Text('Saving contact details...'),
          backgroundColor: BauhausDesign.info,
        ),
      );

      final updates = {
        'contactDetails': {
          'phone': _phoneController.text.trim().isEmpty
              ? null
              : _phoneController.text.trim(),
          'email': _emailController.text.trim().isEmpty
              ? null
              : _emailController.text.trim(),
          'website': _websiteController.text.trim().isEmpty
              ? null
              : _websiteController.text.trim(),
        },
      };

      await widget.onSave(widget.organization.id, updates);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contact details saved successfully!'),
            backgroundColor: BauhausDesign.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to save contact details: ${e.toString()}';
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
                // Header with Bauhaus Typography
                _BauhausSectionHeader(
                  title: 'Contact Information',
                  subtitle: 'Communication channels and primary contacts',
                  icon: Icons.contact_mail_outlined,
                ),

                const SizedBox(height: BauhausDesign.space8),

                if (isMobile) ...[
                  // Mobile Layout (Stacked)
                  Column(
                    children: [
                      _BauhausInfoCard(
                        title: 'General Contact',
                        children: [
                          _BauhausTextField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            hint: '+61 2 1234 5678',
                            icon: Icons.phone_outlined,
                            isRequired: false,
                            keyboardType: TextInputType.phone,
                            validator: _validatePhone,
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          _BauhausTextField(
                            controller: _emailController,
                            label: 'General Email',
                            hint: 'info@company.com',
                            icon: Icons.email_outlined,
                            isRequired: false,
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          _BauhausTextField(
                            controller: _websiteController,
                            label: 'Website',
                            hint: 'https://www.company.com',
                            icon: Icons.language_outlined,
                            isRequired: false,
                            keyboardType: TextInputType.url,
                            validator: _validateWebsite,
                          ),
                        ],
                      ),

                      const SizedBox(height: BauhausDesign.space6),

                      // Contact Statistics Visualization
                      _BauhausContactStatsCard(
                        organization: widget.organization,
                      ),

                      const SizedBox(height: BauhausDesign.space6),

                      // Communication Preferences
                      _BauhausCommunicationCard(
                        organization: widget.organization,
                      ),
                    ],
                  ),
                ] else ...[
                  // Desktop Layout (Row)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column - General Contact
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _BauhausInfoCard(
                              title: 'General Contact',
                              children: [
                                _BauhausTextField(
                                  controller: _phoneController,
                                  label: 'Phone Number',
                                  hint: '+61 2 1234 5678',
                                  icon: Icons.phone_outlined,
                                  isRequired: false,
                                  keyboardType: TextInputType.phone,
                                  validator: _validatePhone,
                                ),
                                const SizedBox(height: BauhausDesign.space4),
                                _BauhausTextField(
                                  controller: _emailController,
                                  label: 'General Email',
                                  hint: 'info@company.com',
                                  icon: Icons.email_outlined,
                                  isRequired: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _validateEmail,
                                ),
                                const SizedBox(height: BauhausDesign.space4),
                                _BauhausTextField(
                                  controller: _websiteController,
                                  label: 'Website',
                                  hint: 'https://www.company.com',
                                  icon: Icons.language_outlined,
                                  isRequired: false,
                                  keyboardType: TextInputType.url,
                                  validator: _validateWebsite,
                                ),
                              ],
                            ),

                            const SizedBox(height: BauhausDesign.space6),

                            // Contact Statistics Visualization
                            _BauhausContactStatsCard(
                              organization: widget.organization,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: BauhausDesign.space6),

                      // Right Column - Contact Statistics & Communication
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            // Contact Statistics Visualization
                            _BauhausContactStatsCard(
                              organization: widget.organization,
                            ),

                            const SizedBox(height: BauhausDesign.space6),

                            // Communication Preferences
                            _BauhausCommunicationCard(
                              organization: widget.organization,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: BauhausDesign.space8),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _BauhausSecondaryButton(
                      text: 'Reset',
                      onPressed: () {
                        // Reset controllers to original values
                        _phoneController.text =
                            widget.organization.contactDetails?.phone ?? '';
                        _emailController.text =
                            widget.organization.contactDetails?.email ?? '';
                        _websiteController.text =
                            widget.organization.contactDetails?.website ?? '';
                      },
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    _BauhausPrimaryButton(
                      text: 'Save Contact Details',
                      onPressed: _isSaving ? null : _saveContactDetails,
                      isLoading: _isSaving,
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

// Reusable components from BauhausDetailsSection
class _BauhausSectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _BauhausSectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space6),
      decoration: BoxDecoration(
        color: BauhausDesign.primary,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            color: BauhausDesign.surfaceWhite,
            child: Icon(icon, color: BauhausDesign.primary, size: 24),
          ),
          const SizedBox(width: BauhausDesign.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontXl,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontMd,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.8),
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
                  color: BauhausDesign.surfaceWhite,
                  child: Icon(
                    Icons.info_outline,
                    color: BauhausDesign.secondary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontLg,
                      fontWeight: FontWeight.w600,
                      color: BauhausDesign.textDark,
                    ),
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
        color: Colors.transparent,
        border: Border.all(
          color: isEnabled
              ? BauhausDesign.neutral
              : BauhausDesign.neutral.withValues(alpha: 0.3),
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

// Contact-specific visualization components
class _BauhausContactStatsCard extends StatelessWidget {
  final models.Organization organization;

  const _BauhausContactStatsCard({required this.organization});

  @override
  Widget build(BuildContext context) {
    final hasPhone = organization.contactDetails?.phone?.isNotEmpty ?? false;
    final hasEmail = organization.contactDetails?.email?.isNotEmpty ?? false;
    final hasWebsite =
        organization.contactDetails?.website?.isNotEmpty ?? false;
    final hasContactPerson = false; // No contactPerson field in ContactDetails

    final totalChannels = [
      hasPhone,
      hasEmail,
      hasWebsite,
      hasContactPerson,
    ].where((e) => e).length;

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.accent,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: BauhausDesign.textDark,
                  size: 20,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    'Contact Channels',
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
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _BauhausContactChannelIndicator(
                        label: 'Phone',
                        isActive: hasPhone,
                        icon: Icons.phone_outlined,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: _BauhausContactChannelIndicator(
                        label: 'Email',
                        isActive: hasEmail,
                        icon: Icons.email_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Row(
                  children: [
                    Expanded(
                      child: _BauhausContactChannelIndicator(
                        label: 'Website',
                        isActive: hasWebsite,
                        icon: Icons.language_outlined,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: _BauhausContactChannelIndicator(
                        label: 'Contact Person',
                        isActive: hasContactPerson,
                        icon: Icons.person_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space3),
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$totalChannels/4',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.w700,
                          color: BauhausDesign.primary,
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Text(
                        'Channels Active',
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

class _BauhausContactChannelIndicator extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData icon;

  const _BauhausContactChannelIndicator({
    required this.label,
    required this.isActive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space2),
      decoration: BoxDecoration(
        color: isActive
            ? BauhausDesign.success.withValues(alpha: 0.1)
            : BauhausDesign.surfaceWhite,
        border: Border.all(
          color: isActive ? BauhausDesign.success : BauhausDesign.neutral,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: isActive ? BauhausDesign.success : BauhausDesign.textMuted,
          ),
          const SizedBox(width: BauhausDesign.space1),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: BauhausDesign.fontXs,
              fontWeight: FontWeight.w500,
              color: isActive ? BauhausDesign.success : BauhausDesign.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausCommunicationCard extends StatelessWidget {
  final models.Organization organization;

  const _BauhausCommunicationCard({required this.organization});

  @override
  Widget build(BuildContext context) {
    final preferredMethod = _getPreferredContactMethod();

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
              color: BauhausDesign.warning.withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.settings_phone_outlined,
                  color: BauhausDesign.warning,
                  size: 20,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    'Communication Preferences',
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
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preferred Contact Method',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getContactIcon(preferredMethod),
                        color: BauhausDesign.primary,
                        size: 20,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          preferredMethod,
                          style: GoogleFonts.inter(
                            fontSize: BauhausDesign.fontMd,
                            fontWeight: FontWeight.w500,
                            color: BauhausDesign.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: BauhausDesign.space3),
                Text(
                  'Available Methods',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                _BauhausMethodList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPreferredContactMethod() {
    if (organization.contactDetails?.email?.isNotEmpty ?? false) {
      return 'Email';
    } else if (organization.contactDetails?.phone?.isNotEmpty ?? false) {
      return 'Phone';
    }
    return 'Not specified';
  }

  IconData _getContactIcon(String method) {
    switch (method) {
      case 'Email':
      case 'General Email':
        return Icons.email_outlined;
      case 'Phone':
      case 'General Phone':
        return Icons.phone_outlined;
      default:
        return Icons.help_outline;
    }
  }

  Widget _BauhausMethodList() {
    final methods = [
      if (organization.contactDetails?.email?.isNotEmpty ?? false) 'Email',
      if (organization.contactDetails?.phone?.isNotEmpty ?? false) 'Phone',
    ];

    if (methods.isEmpty) {
      return Text(
        'No contact methods configured',
        style: GoogleFonts.inter(
          fontSize: BauhausDesign.fontSm,
          color: BauhausDesign.textMuted,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Column(
      children: methods.map((method) {
        return Container(
          margin: const EdgeInsets.only(bottom: BauhausDesign.space1),
          padding: const EdgeInsets.all(BauhausDesign.space2),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(
              color: BauhausDesign.neutral.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getContactIcon(method),
                size: 16,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  method,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ),
              Icon(
                Icons.check_circle_outline,
                size: 16,
                color: BauhausDesign.success,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
