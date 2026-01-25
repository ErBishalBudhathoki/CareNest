import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carenest/app/core/services/file_upload_service.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Organization Edit View
/// Allows users to edit organization details with the Bauhaus Design System
class OrganizationEditView extends StatefulWidget {
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;
  final String userEmail;

  const OrganizationEditView({
    super.key,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    required this.userEmail,
  });

  @override
  State<OrganizationEditView> createState() => _OrganizationEditViewState();
}

class _OrganizationEditViewState extends State<OrganizationEditView> {
  // Controllers
  final _nameController = TextEditingController();
  final _tradingNameController = TextEditingController();
  final _abnController = TextEditingController();

  // Contact
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _countryController = TextEditingController();

  // Banking
  final _bankNameController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _bsbController = TextEditingController();
  final _accountNumberController = TextEditingController();

  // NDIS
  final _registrationNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();

  bool _isRegistered = false;
  bool _loading = false;
  Map<String, dynamic>? _organization;
  final _api = ApiMethod();
  final _fileUploadService = FileUploadService();

  File? _logoFile;
  String? _logoUrl;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.organizationName ?? '';
    if ((widget.organizationId ?? '').isNotEmpty) {
      _loadOrganization();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tradingNameController.dispose();
    _abnController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    _bankNameController.dispose();
    _accountNameController.dispose();
    _bsbController.dispose();
    _accountNumberController.dispose();
    _registrationNumberController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _logoFile = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                AppLocalizations.of(context)!.errorPickingImage(e.toString())),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: BauhausDesign.primary,
              onPrimary: Colors.white,
              surface: BauhausDesign.surfaceWhite,
              onSurface: BauhausDesign.textDark,
            ),
            dialogBackgroundColor: BauhausDesign.surfaceWhite,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  Future<void> _loadOrganization() async {
    if (widget.organizationId == null) return;
    setState(() => _loading = true);
    try {
      final resp = await _api.getOrganizationDetails(widget.organizationId!);
      final org =
          (resp['organization'] ?? resp['data']) as Map<String, dynamic>?;
      if (org != null) {
        _organization = org;
        _logoUrl = (org['logoUrl'] ?? org['logo'] ?? '').toString();
        if (_logoUrl == 'null') _logoUrl = null;
        if (_logoUrl?.isEmpty == true) _logoUrl = null;

        _nameController.text =
            (org['name'] ?? org['organizationName'] ?? '').toString();
        _abnController.text = (org['abn'] ?? '').toString();

        final addr = org['address'] as Map<String, dynamic>? ?? {};
        _streetController.text = (addr['street'] ?? '').toString();
        _cityController.text = (addr['city'] ?? '').toString();
        _stateController.text = (addr['state'] ?? '').toString();
        _postcodeController.text = (addr['postcode'] ?? '').toString();
        _countryController.text = (addr['country'] ?? '').toString();

        final contact = org['contactDetails'] as Map<String, dynamic>? ?? {};
        _phoneController.text = (contact['phone'] ?? '').toString();
        _emailController.text = (contact['email'] ?? '').toString();

        final bank = org['bankDetails'] as Map<String, dynamic>? ?? {};
        _bankNameController.text = (bank['bankName'] ?? '').toString();
        _accountNameController.text = (bank['accountName'] ?? '').toString();
        _bsbController.text = (bank['bsb'] ?? '').toString();
        _accountNumberController.text =
            (bank['accountNumber'] ?? '').toString();

        final ndis = org['ndisRegistration'] as Map<String, dynamic>? ?? {};
        _isRegistered = (ndis['isRegistered'] ?? false) == true;
        _registrationNumberController.text =
            (ndis['registrationNumber'] ?? '').toString();
        _expiryDateController.text =
            (ndis['expiryDate'] ?? ndis['renewalDate'] ?? '')
                .toString()
                .split('T')[0];

        _tradingNameController.text =
            (org['tradingName'] ?? org['name'] ?? '').toString();
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Map<String, dynamic> _buildUpdatePayload() {
    return {
      'name': _nameController.text.trim(),
      'tradingName': _tradingNameController.text.trim(),
      'abn': _abnController.text.trim(),
      'address': {
        'street': _streetController.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'postcode': _postcodeController.text.trim(),
        'country': _countryController.text.trim(),
      },
      'contactDetails': {
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
      },
      'bankDetails': {
        'bankName': _bankNameController.text.trim(),
        'accountName': _accountNameController.text.trim(),
        'bsb': _bsbController.text.trim(),
        'accountNumber': _accountNumberController.text.trim(),
      },
      'ndisRegistration': {
        'isRegistered': _isRegistered,
        'registrationNumber': _registrationNumberController.text.trim(),
        'renewalDate': _expiryDateController.text.trim(),
        'expiryDate': _expiryDateController.text.trim(),
      },
    };
  }

  Future<void> _saveOrganization() async {
    if ((widget.organizationId ?? '').isEmpty) return;
    setState(() => _loading = true);
    try {
      String? uploadedLogoUrl = _logoUrl;

      if (_logoFile != null) {
        try {
          uploadedLogoUrl = await _fileUploadService.uploadLogoFile(_logoFile!);
        } catch (e) {
          debugPrint('Failed to upload logo: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!
                    .errorUploadingLogo(e.toString())),
                backgroundColor: BauhausDesign.error,
              ),
            );
          }
          setState(() => _loading = false);
          return;
        }
      }

      final updates = _buildUpdatePayload();
      if (uploadedLogoUrl != null) {
        updates['logoUrl'] = uploadedLogoUrl;
      }

      final resp =
          await _api.updateOrganizationDetails(widget.organizationId!, updates);
      final ok = resp['success'] == true || resp['statusCode'] == 200;
      if (ok) {
        if (mounted) Navigator.pop(context, true);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resp['message'] ??
                  AppLocalizations.of(context)!.failedToUpdateOrganization),
              backgroundColor: BauhausDesign.error,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error saving organization: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!
                .errorSavingOrganization(e.toString())),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.editDetailsTitle,
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.neutral,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: BauhausDesign.surfaceWhite),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _loading
          ? const Center(child: BauhausLoadingState())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                children: [
                  // Logo Section
                  Center(
                    child: GestureDetector(
                      onTap: _pickLogo,
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: BauhausDesign.surfaceWhite,
                              border: Border.all(
                                color: BauhausDesign.primary,
                                width: 2,
                              ),
                              boxShadow: const [BauhausDesign.shadowHard],
                              image: _logoFile != null
                                  ? DecorationImage(
                                      image: FileImage(_logoFile!),
                                      fit: BoxFit.cover,
                                    )
                                  : (_logoUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(_logoUrl!),
                                          fit: BoxFit.cover,
                                        )
                                      : null),
                            ),
                            child: (_logoFile == null && _logoUrl == null)
                                ? const Icon(
                                    Icons.business,
                                    size: 40,
                                    color: BauhausDesign.primary,
                                  )
                                : null,
                          ),
                          const SizedBox(height: BauhausDesign.space3),
                          Text(
                            AppLocalizations.of(context)!.tapToChangeLogo,
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(color: BauhausDesign.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space6),

                  // General Information
                  _buildSectionCard(
                    context,
                    title: AppLocalizations.of(context)!.generalInformation,
                    icon: Icons.folder_outlined,
                    children: [
                      BauhausTextField(
                        label: AppLocalizations.of(context)!
                            .organizationNameHint
                            .toUpperCase(),
                        controller: _nameController,
                        hintText:
                            AppLocalizations.of(context)!.organizationNameHint,
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      BauhausTextField(
                        label: AppLocalizations.of(context)!.tradingNameLabel,
                        controller: _tradingNameController,
                        hintText:
                            AppLocalizations.of(context)!.enterTradingName,
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      BauhausTextField(
                        label: AppLocalizations.of(context)!
                            .taxIdAbn
                            .toUpperCase(),
                        controller: _abnController,
                        hintText: AppLocalizations.of(context)!.enterAbn,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: _buildValidBadge(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),

                  // Contact Details
                  _buildSectionCard(
                    context,
                    title: AppLocalizations.of(context)!.contactDetails,
                    icon: Icons.contact_mail_outlined,
                    children: [
                      BauhausTextField(
                        label: AppLocalizations.of(context)!
                            .emailAddressLabel
                            .toUpperCase(),
                        controller: _emailController,
                        hintText: AppLocalizations.of(context)!.emailHint,
                        prefixIcon: const Icon(Icons.email_outlined, size: 20),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      BauhausTextField(
                        label: AppLocalizations.of(context)!
                            .phoneNumber
                            .toUpperCase(),
                        controller: _phoneController,
                        hintText: AppLocalizations.of(context)!.phoneNumber,
                        prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      BauhausTextField(
                        label: AppLocalizations.of(context)!.addressLine1,
                        controller: _streetController,
                        hintText:
                            AppLocalizations.of(context)!.enterStreetAddress,
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Row(
                        children: [
                          Expanded(
                            child: BauhausTextField(
                              label: AppLocalizations.of(context)!
                                  .city
                                  .toUpperCase(),
                              controller: _cityController,
                              hintText: AppLocalizations.of(context)!.city,
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space4),
                          Expanded(
                            child: BauhausTextField(
                              label:
                                  AppLocalizations.of(context)!.postcodeLabel,
                              controller: _postcodeController,
                              hintText:
                                  AppLocalizations.of(context)!.enterPostcode,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      BauhausTextField(
                        label: AppLocalizations.of(context)!.stateRegion,
                        controller: _stateController,
                        hintText: AppLocalizations.of(context)!.state,
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),

                  // Banking
                  _buildSectionCard(
                    context,
                    title: AppLocalizations.of(context)!.banking,
                    icon: Icons.account_balance_outlined,
                    children: [
                      BauhausTextField(
                        label: AppLocalizations.of(context)!.bankNameLabel,
                        controller: _bankNameController,
                        hintText: AppLocalizations.of(context)!.enterBankName,
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Row(
                        children: [
                          Expanded(
                            child: BauhausTextField(
                              label: AppLocalizations.of(context)!.bsbLabel,
                              controller: _bsbController,
                              hintText: AppLocalizations.of(context)!.enterBsb,
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space4),
                          Expanded(
                            child: BauhausTextField(
                              label:
                                  AppLocalizations.of(context)!.accountNoLabel,
                              controller: _accountNumberController,
                              hintText: AppLocalizations.of(context)!
                                  .enterAccountNumber,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Container(
                        padding: const EdgeInsets.all(BauhausDesign.space3),
                        decoration: BoxDecoration(
                          color: BauhausDesign.warning.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(color: BauhausDesign.warning),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                color: BauhausDesign.warning, size: 20),
                            const SizedBox(width: BauhausDesign.space3),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.bankingWarning,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: BauhausDesign.warning),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),

                  // NDIS Registration
                  _buildSectionCard(
                    context,
                    title: AppLocalizations.of(context)!.ndisRegistration,
                    icon: Icons.medical_services_outlined,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .registeredProvider,
                                style: BauhausDesign.getTextTheme(context)
                                    .labelLarge,
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              Text(
                                AppLocalizations.of(context)!.isNdisRegistered,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: BauhausDesign.textMuted),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: _isRegistered,
                            onChanged: (val) =>
                                setState(() => _isRegistered = val),
                            activeColor: BauhausDesign.primary,
                          ),
                        ],
                      ),
                      if (_isRegistered) ...[
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausTextField(
                          label: AppLocalizations.of(context)!
                              .registrationNumberLabel,
                          controller: _registrationNumberController,
                          hintText: AppLocalizations.of(context)!
                              .registrationNumberEnter,
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        InkWell(
                          onTap: () =>
                              _selectDate(context, _expiryDateController),
                          child: IgnorePointer(
                            child: BauhausTextField(
                              label:
                                  AppLocalizations.of(context)!.expiryDateLabel,
                              controller: _expiryDateController,
                              hintText:
                                  AppLocalizations.of(context)!.expiryDateHint,
                              suffixIcon: const Icon(Icons.calendar_today,
                                  color: BauhausDesign.textMuted),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: BauhausDesign.space8),

                  // Bottom Actions
                  BauhausActionButton(
                    text: AppLocalizations.of(context)!.saveChanges,
                    onPressed: _loading ? null : _saveOrganization,
                    isFullWidth: true,
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppLocalizations.of(context)!.cancelButton,
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(color: BauhausDesign.textMuted),
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space8),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
                child: Icon(icon, color: BauhausDesign.primary, size: 20),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Text(
                title.toUpperCase(),
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, TextEditingController controller) {
    // Simple mock dropdown using TextField with icon for now
    return BauhausTextField(
      label: label,
      controller: controller,
      suffixIcon:
          const Icon(Icons.keyboard_arrow_down, color: BauhausDesign.textMuted),
    );
  }

  Widget _buildValidBadge() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: BauhausDesign.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle,
              color: BauhausDesign.success, size: 12),
          const SizedBox(width: 4),
          Text(
            AppLocalizations.of(context)!.validBadge,
            style: TextStyle(
              color: BauhausDesign.success,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
