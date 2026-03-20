import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:image_picker/image_picker.dart';
import 'package:carenest/app/core/services/file_upload_service.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Organization Edit View
/// Allows users to edit organization details with the Bauhaus Design System
class OrganizationEditView extends ConsumerStatefulWidget {
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
  ConsumerState<OrganizationEditView> createState() =>
      _OrganizationEditViewState();
}

class _OrganizationEditViewState extends ConsumerState<OrganizationEditView> {
  // Controllers
  final _nameController = TextEditingController();
  final _tradingNameController = TextEditingController();
  final _abnController = TextEditingController();

  // Contact
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postcodeController = TextEditingController();

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
  late final ApiMethod _api;
  late final FileUploadService _fileUploadService;

  File? _logoFile;
  String? _logoUrl;

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    _fileUploadService = FileUploadService(api: _api);
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
    _websiteController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postcodeController.dispose();
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

        final contact = org['contactDetails'] as Map<String, dynamic>? ?? {};
        _phoneController.text = (contact['phone'] ?? '').toString();
        _emailController.text = (contact['email'] ?? '').toString();
        _websiteController.text = (contact['website'] ?? '').toString();

        final bank = org['bankDetails'] as Map<String, dynamic>? ?? {};
        _bankNameController.text = (bank['bankName'] ?? '').toString();
        _accountNameController.text = (bank['accountName'] ?? '').toString();
        _bsbController.text = _formatBsb((bank['bsb'] ?? '').toString());
        _accountNumberController.text =
            _formatAccountNumber((bank['accountNumber'] ?? '').toString());

        final ndis = org['ndisRegistration'] as Map<String, dynamic>? ?? {};
        _isRegistered = (ndis['isRegistered'] ?? false) == true;
        _registrationNumberController.text =
            (ndis['registrationNumber'] ?? '').toString().replaceAll(
                  RegExp(r'\D'),
                  '',
                );
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
    final normalizedWebsite = _normalizeWebsiteForSave(_websiteController.text);
    final normalizedNdisRegistrationNumber =
        _registrationNumberController.text.replaceAll(RegExp(r'\D'), '');
    return {
      'name': _nameController.text.trim(),
      'tradingName': _tradingNameController.text.trim(),
      'abn': _abnController.text.trim(),
      'address': {
        'street': _streetController.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'postcode': _postcodeController.text.trim(),
        'country': 'Australia',
      },
      'contactDetails': {
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'website': normalizedWebsite,
      },
      'bankDetails': {
        'bankName': _bankNameController.text.trim(),
        'accountName': _accountNameController.text.trim(),
        'bsb': _bsbController.text.trim(),
        'accountNumber': _accountNumberController.text.trim(),
      },
      'ndisRegistration': {
        'isRegistered': _isRegistered,
        'registrationNumber':
            _isRegistered ? normalizedNdisRegistrationNumber : '',
        'renewalDate': _expiryDateController.text.trim(),
        'expiryDate': _expiryDateController.text.trim(),
      },
    };
  }

  Map<String, dynamic> _toStringDynamicMap(dynamic value) {
    if (value is Map<String, dynamic>) return Map<String, dynamic>.from(value);
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  Map<String, dynamic> _mergeOrganizationData(
    Map<String, dynamic>? base,
    Map<String, dynamic> updates,
  ) {
    final merged = Map<String, dynamic>.from(base ?? const <String, dynamic>{});
    updates.forEach((key, value) {
      if (value is Map) {
        final existing = _toStringDynamicMap(merged[key]);
        merged[key] = {
          ...existing,
          ..._toStringDynamicMap(value),
        };
      } else {
        merged[key] = value;
      }
    });
    return merged;
  }

  String _normalizeWebsiteForSave(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return '';
    final hasScheme = RegExp(r'^[a-zA-Z][a-zA-Z0-9+\-.]*://').hasMatch(trimmed);
    return hasScheme ? trimmed : 'https://$trimmed';
  }

  String _formatBsb(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 3) return digits;
    final first = digits.substring(0, 3);
    final second = digits.substring(3, digits.length.clamp(3, 6));
    return '$first-$second';
  }

  String _formatAccountNumber(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 4) return digits;
    final first = digits.substring(0, 4);
    final second = digits.substring(4, digits.length.clamp(4, 8));
    return '$first $second';
  }

  bool _isValidBsb(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    return digits.length == 6;
  }

  bool _isValidAccountNumber(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    return digits.length == 8;
  }

  bool _isValidNdisRegistrationNumber(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    return digits.length == 8;
  }

  String? _validateAbnValue(String value) {
    final abn = value.trim();
    if (abn.isEmpty) {
      return AppLocalizations.of(context)!.abnInvalid;
    }
    if (abn.length != 11) {
      return 'ABN must be exactly 11 digits';
    }
    if (!RegExp(r'^\d{11}$').hasMatch(abn)) {
      return 'ABN must contain only numbers';
    }
    return null;
  }

  Future<void> _saveOrganization() async {
    if ((widget.organizationId ?? '').isEmpty) return;
    FocusScope.of(context).unfocus();

    final normalizedWebsite = _normalizeWebsiteForSave(_websiteController.text);
    if (normalizedWebsite != _websiteController.text.trim()) {
      _websiteController.text = normalizedWebsite;
    }

    final abnError = _validateAbnValue(_abnController.text);
    if (abnError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(abnError),
          backgroundColor: BauhausDesign.warning,
        ),
      );
      return;
    }

    if (!_isValidBsb(_bsbController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('BSB must be exactly 6 digits (format: XXX-XXX).'),
          backgroundColor: BauhausDesign.warning,
        ),
      );
      return;
    }

    if (!_isValidAccountNumber(_accountNumberController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Account number must be exactly 8 digits (format: XXXX XXXX).'),
          backgroundColor: BauhausDesign.warning,
        ),
      );
      return;
    }

    if (_isRegistered &&
        !_isValidNdisRegistrationNumber(_registrationNumberController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'NDIS registration number must be exactly 8 digits (numbers only).'),
          backgroundColor: BauhausDesign.warning,
        ),
      );
      return;
    }

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
      debugPrint('updateOrganizationDetails response: $resp');
      final ok = resp['success'] == true || resp['statusCode'] == 200;
      if (ok) {
        final updatedOrganization =
            _mergeOrganizationData(_organization, updates);
        _organization = updatedOrganization;
        if (mounted) {
          Navigator.pop(context, {
            'updated': true,
            'organization': updatedOrganization,
          });
        }
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: BauhausDesign.surfaceWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.editDetailsTitle.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: _loading ? null : _saveOrganization,
            icon: const Icon(
              Icons.check_circle_outline,
              color: BauhausDesign.surfaceWhite,
              size: 18,
            ),
            label: Text(
              l10n.saveChanges.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space1),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: BauhausDesign.neutral,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: BauhausLoadingState())
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(
                  BauhausDesign.space4,
                  BauhausDesign.space4,
                  BauhausDesign.space4,
                  BauhausDesign.space10,
                ),
                child: Column(
                  children: [
                    _buildEditHeader(context),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildSectionCard(
                      context,
                      title: l10n.generalInformation,
                      icon: Icons.folder_outlined,
                      accentColor: BauhausDesign.primary,
                      badge: _buildSectionBadge('01'),
                      children: [
                        BauhausTextField(
                          label: l10n.organizationNameHint.toUpperCase(),
                          controller: _nameController,
                          hintText: l10n.organizationNameHint,
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausTextField(
                          label: l10n.tradingNameLabel.toUpperCase(),
                          controller: _tradingNameController,
                          hintText: l10n.enterTradingName,
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausTextField(
                          label: l10n.taxIdAbn.toUpperCase(),
                          controller: _abnController,
                          hintText: l10n.enterAbn,
                          onChanged: (_) => setState(() {}),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: _buildAbnBadge(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildSectionCard(
                      context,
                      title: l10n.contactDetails,
                      icon: Icons.contact_mail_outlined,
                      accentColor: BauhausDesign.secondary,
                      badge: _buildSectionBadge('02'),
                      children: [
                        BauhausTextField(
                          label: l10n.emailAddressLabel.toUpperCase(),
                          controller: _emailController,
                          hintText: l10n.emailHint,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon:
                              const Icon(Icons.email_outlined, size: 20),
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausTextField(
                          label: l10n.phoneNumber.toUpperCase(),
                          controller: _phoneController,
                          hintText: l10n.phoneNumber,
                          keyboardType: TextInputType.phone,
                          prefixIcon:
                              const Icon(Icons.phone_outlined, size: 20),
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausTextField(
                          label: l10n.websiteLabel.toUpperCase(),
                          controller: _websiteController,
                          hintText: 'example.com',
                          keyboardType: TextInputType.url,
                          prefixIcon:
                              const Icon(Icons.public_outlined, size: 20),
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausTextField(
                          label: l10n.addressLine1.toUpperCase(),
                          controller: _streetController,
                          hintText: l10n.enterStreetAddress,
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        Row(
                          children: [
                            Expanded(
                              child: BauhausTextField(
                                label: l10n.city.toUpperCase(),
                                controller: _cityController,
                                hintText: l10n.city,
                              ),
                            ),
                            const SizedBox(width: BauhausDesign.space4),
                            Expanded(
                              child: BauhausTextField(
                                label: l10n.postcodeLabel.toUpperCase(),
                                controller: _postcodeController,
                                hintText: l10n.enterPostcode,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausTextField(
                          label: l10n.stateRegion.toUpperCase(),
                          controller: _stateController,
                          hintText: l10n.state,
                        ),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildSectionCard(
                      context,
                      title: l10n.banking,
                      icon: Icons.account_balance_outlined,
                      accentColor: BauhausDesign.accent,
                      badge: _buildSectionBadge('03'),
                      children: [
                        BauhausTextField(
                          label: l10n.bankNameLabel.toUpperCase(),
                          controller: _bankNameController,
                          hintText: l10n.enterBankName,
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausTextField(
                          label: 'ACCOUNT NAME',
                          controller: _accountNameController,
                          hintText: 'Enter account name',
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        Row(
                          children: [
                            Expanded(
                              child: BauhausTextField(
                                label: l10n.bsbLabel.toUpperCase(),
                                controller: _bsbController,
                                hintText: l10n.enterBsb,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: false,
                                ),
                                inputFormatters: [
                                  _BsbInputFormatter(),
                                ],
                              ),
                            ),
                            const SizedBox(width: BauhausDesign.space4),
                            Expanded(
                              child: BauhausTextField(
                                label: l10n.accountNoLabel.toUpperCase(),
                                controller: _accountNumberController,
                                hintText: l10n.enterAccountNumber,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: false,
                                ),
                                inputFormatters: [
                                  _AccountNumberInputFormatter(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        Container(
                          padding: const EdgeInsets.all(BauhausDesign.space3),
                          decoration: BoxDecoration(
                            color: BauhausDesign.warning.withOpacity(0.12),
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusSm),
                            border: Border.all(
                                color: BauhausDesign.neutral, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                color: BauhausDesign.warning,
                                size: 20,
                              ),
                              const SizedBox(width: BauhausDesign.space3),
                              Expanded(
                                child: Text(
                                  l10n.bankingWarning,
                                  style: BauhausDesign.getTextTheme(context)
                                      .bodySmall
                                      ?.copyWith(
                                        color: BauhausDesign.textDark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildSectionCard(
                      context,
                      title: l10n.ndisRegistration,
                      icon: Icons.medical_services_outlined,
                      accentColor: BauhausDesign.info,
                      badge: _buildSectionBadge('04'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(BauhausDesign.space3),
                          decoration: BoxDecoration(
                            color: BauhausDesign.surfaceOffWhite,
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusMd),
                            border: Border.all(color: BauhausDesign.neutral),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.registeredProvider.toUpperCase(),
                                      style: BauhausDesign.getTextTheme(context)
                                          .labelSmall
                                          ?.copyWith(
                                            color: BauhausDesign.secondary,
                                            letterSpacing: 0.8,
                                          ),
                                    ),
                                    const SizedBox(
                                        height: BauhausDesign.space1),
                                    Text(
                                      l10n.isNdisRegistered,
                                      style: BauhausDesign.getTextTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                            color: BauhausDesign.textMuted,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch.adaptive(
                                value: _isRegistered,
                                onChanged: (val) =>
                                    setState(() => _isRegistered = val),
                                activeColor: BauhausDesign.primary,
                              ),
                            ],
                          ),
                        ),
                        if (_isRegistered) ...[
                          const SizedBox(height: BauhausDesign.space4),
                          BauhausTextField(
                            label: l10n.registrationNumberLabel.toUpperCase(),
                            controller: _registrationNumberController,
                            hintText: l10n.registrationNumberEnter,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: false,
                              signed: false,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(8),
                            ],
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          InkWell(
                            onTap: () =>
                                _selectDate(context, _expiryDateController),
                            child: IgnorePointer(
                              child: BauhausTextField(
                                label: l10n.expiryDateLabel.toUpperCase(),
                                controller: _expiryDateController,
                                hintText: l10n.expiryDateHint,
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: BauhausDesign.textMuted,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space8),
                    Row(
                      children: [
                        Expanded(
                          child: BauhausActionButton(
                            text: l10n.cancelButton.toUpperCase(),
                            onPressed: () => Navigator.pop(context),
                            isOutlined: true,
                            backgroundColor: BauhausDesign.neutral,
                            textColor: BauhausDesign.neutral,
                            isFullWidth: true,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Expanded(
                          child: BauhausActionButton(
                            text: l10n.saveChanges.toUpperCase(),
                            onPressed: _loading ? null : _saveOrganization,
                            isFullWidth: true,
                            backgroundColor: BauhausDesign.primary,
                            textColor: BauhausDesign.surfaceWhite,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildEditHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final organizationName =
        (_organization?['name'] ?? widget.organizationName ?? l10n.organization)
            .toString();
    final organizationCode =
        (_organization?['code'] ?? widget.organizationCode ?? '...').toString();
    final id = (_organization?['id'] ?? '').toString();
    final shortId = id.isEmpty
        ? '------'
        : id.substring(0, id.length >= 6 ? 6 : id.length).toUpperCase();

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: BauhausDesign.secondary,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: _pickLogo,
                      child: Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: BauhausDesign.surfaceWhite,
                          border: Border.all(
                              color: BauhausDesign.neutral, width: 2),
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
                                Icons.business_rounded,
                                size: 36,
                                color: BauhausDesign.primary,
                              )
                            : null,
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: BauhausDesign.accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: BauhausDesign.neutral),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 14,
                        color: BauhausDesign.neutral,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        organizationName,
                        style: BauhausDesign.getTextTheme(context)
                            .headlineMedium
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        l10n.tapToChangeLogo,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color:
                                  BauhausDesign.surfaceWhite.withOpacity(0.85),
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: BauhausDesign.space2,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: BauhausDesign.surfaceWhite,
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(color: BauhausDesign.neutral),
                        ),
                        child: Text(
                          'ID: $shortId',
                          style: BauhausDesign.getTextTheme(context)
                              .labelSmall
                              ?.copyWith(
                                color: BauhausDesign.secondary,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(BauhausDesign.radiusLg - 2),
              ),
              border: Border(
                top: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.qr_code_2_outlined,
                  color: BauhausDesign.neutral,
                  size: 18,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  '${l10n.organizationCode.toUpperCase()}: ',
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.primary,
                            letterSpacing: 0.9,
                          ),
                ),
                Expanded(
                  child: Text(
                    organizationCode,
                    style: BauhausDesign.getTextTheme(context)
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.4,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral),
      ),
      child: Text(
        label,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.neutral,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
    required Color accentColor,
    Widget? badge,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 9,
            color: accentColor,
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.12),
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusSm),
                        border: Border.all(color: BauhausDesign.neutral),
                      ),
                      child: Icon(icon, color: accentColor, size: 20),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                            ),
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(width: BauhausDesign.space2),
                      badge,
                    ],
                  ],
                ),
                const SizedBox(height: BauhausDesign.space4),
                ...children,
              ],
            ),
          ),
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

  bool get _isAbnLikelyValid {
    final digitsOnly = _abnController.text.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length == 11;
  }

  Widget _buildAbnBadge() {
    final isValid = _isAbnLikelyValid;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isValid ? BauhausDesign.success : BauhausDesign.warning)
            .withOpacity(0.12),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.info_outline,
            color: isValid ? BauhausDesign.success : BauhausDesign.warning,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            isValid ? AppLocalizations.of(context)!.validBadge : 'CHECK',
            style: TextStyle(
              color: BauhausDesign.neutral,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _BsbInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitedDigits = digits.length > 6 ? digits.substring(0, 6) : digits;

    final buffer = StringBuffer();
    for (var i = 0; i < limitedDigits.length; i++) {
      if (i == 3) buffer.write('-');
      buffer.write(limitedDigits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _AccountNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limitedDigits = digits.length > 8 ? digits.substring(0, 8) : digits;

    final buffer = StringBuffer();
    for (var i = 0; i < limitedDigits.length; i++) {
      if (i == 4) buffer.write(' ');
      buffer.write(limitedDigits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
