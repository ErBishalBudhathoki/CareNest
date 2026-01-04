import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carenest/app/core/services/file_upload_service.dart';

/// Organization Edit View
/// Allows users to edit organization details with a modern dark theme UI
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
  final _tradingNameController = TextEditingController(); // Placeholder for UI
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
  final _expiryDateController = TextEditingController(); // Placeholder for UI

  bool _isRegistered = false;
  bool _loading = false;
  Map<String, dynamic>? _organization;
  final _api = ApiMethod();
  final _fileUploadService = FileUploadService();

  File? _logoFile;
  String? _logoUrl;

  // Theme Colors
  static const _backgroundColor = Color(0xFF0F172A);
  static const _cardColor = Color(0xFF1E293B);
  static const _inputColor = Color(
      0xFFFFFFFF); // White background for inputs as per typical form designs or dark?
  // Reference usually implies readable inputs. Let's use White background inputs with dark text based on "Edit Details" reference image often having high contrast.
  // actually, looking at the user request "Color schemes and styling details", if the previous Details view was dark, and this is "Edit Details", it might be dark too.
  // BUT, the screenshot provided in the prompt (which I can't see) might show white inputs on dark background.
  // Let's assume white inputs for high contrast if the background is dark, OR dark inputs.
  // Re-reading my thought process: "Cards/Sections for different groups... Input fields with dark backgrounds or specific styling."
  // Let's stick to a dark theme consistent with the Details view.
  // Inputs: White background is safest for accessibility and "standard" form look unless specified otherwise.
  // Let's use White inputs.

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
          SnackBar(content: Text('Error picking image: $e')),
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
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              onPrimary: Colors.white,
              surface: Color(0xFF1E293B),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF0F172A),
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
        'expiryDate': _expiryDateController.text.trim(), // Save both to be safe
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
              SnackBar(content: Text('Failed to upload logo: $e')),
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
                content:
                    Text(resp['message'] ?? 'Failed to update organization')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error saving organization: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving organization: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text(
          'EDIT DETAILS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: _backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // actions: [
        //   TextButton(
        //     onPressed: _loading ? null : _saveOrganization,
        //     child: Text(
        //       'Save',
        //       style: TextStyle(
        //         color: const Color(0xFF3B82F6),
        //         fontWeight: FontWeight.bold,
        //         fontSize: 16,
        //         decoration: _loading ? TextDecoration.none : null,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Logo Section
                  Center(
                    child: GestureDetector(
                      onTap: _pickLogo,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _cardColor,
                                  border: Border.all(
                                    color: const Color(0xFF3B82F6)
                                        .withOpacity(0.5),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF3B82F6)
                                          .withOpacity(0.2),
                                      blurRadius: 20,
                                      spreadRadius: 0,
                                    ),
                                  ],
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
                                        color: Color(0xFF3B82F6),
                                      )
                                    : null,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3B82F6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Tap to change logo',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // General Information
                  _buildSection(
                    title: 'General Information',
                    icon: Icons.folder,
                    children: [
                      _buildTextField('ORGANIZATION NAME', _nameController),
                      _buildTextField('TRADING NAME', _tradingNameController),
                      _buildTextField('TAX ID (ABN)', _abnController,
                          suffix: _buildValidBadge()),
                    ],
                  ),

                  // Contact Details
                  _buildSection(
                    title: 'Contact Details',
                    icon: Icons.contact_mail,
                    children: [
                      _buildTextField('EMAIL ADDRESS', _emailController,
                          icon: Icons.email_outlined),
                      _buildTextField('PHONE NUMBER', _phoneController,
                          icon: Icons.phone_outlined),
                      _buildTextField('ADDRESS LINE 1', _streetController),
                      Row(
                        children: [
                          Expanded(
                              child: _buildTextField('CITY', _cityController)),
                          const SizedBox(width: 16),
                          Expanded(
                              child: _buildTextField(
                                  'POSTCODE', _postcodeController)),
                        ],
                      ),
                      _buildDropdownField('STATE / REGION', _stateController),
                    ],
                  ),

                  // Banking
                  _buildSection(
                    title: 'Banking',
                    icon: Icons.account_balance,
                    children: [
                      _buildTextField('BANK NAME', _bankNameController),
                      Row(
                        children: [
                          Expanded(
                              child: _buildTextField('BSB', _bsbController)),
                          const SizedBox(width: 16),
                          Expanded(
                              child: _buildTextField(
                                  'ACCOUNT NO.', _accountNumberController)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF451A03).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color(0xFFD97706).withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                color: Color(0xFFD97706), size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Updating banking details may require re-verification. Payments might be delayed by 24 hours.',
                                style: TextStyle(
                                    color: const Color(0xFFD97706),
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // NDIS Registration
                  _buildSection(
                    title: 'NDIS Registration',
                    icon: Icons.medical_services,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Registered Provider',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Is this organization NDIS registered?',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            value: _isRegistered,
                            onChanged: (val) =>
                                setState(() => _isRegistered = val),
                            activeColor: const Color(0xFF3B82F6),
                          ),
                        ],
                      ),
                      if (_isRegistered) ...[
                        const SizedBox(height: 16),
                        _buildTextField('REGISTRATION NUMBER',
                            _registrationNumberController),
                        _buildTextField(
                          'EXPIRY DATE',
                          _expiryDateController,
                          icon: Icons.calendar_today,
                          readOnly: true,
                          onTap: () =>
                              _selectDate(context, _expiryDateController),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Bottom Actions
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _saveOrganization,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...children
              .expand((element) => [element, const SizedBox(height: 16)])
              .toList()
            ..removeLast(),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    Widget? suffix,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: icon != null
                  ? Icon(icon, color: const Color(0xFF64748B), size: 20)
                  : null,
              suffixIcon: suffix,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, TextEditingController controller) {
    // Simple mock dropdown using TextField with icon for now
    return _buildTextField(
      label,
      controller,
      suffix: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
    );
  }

  Widget _buildValidBadge() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 12),
          SizedBox(width: 4),
          Text(
            'VALID',
            style: TextStyle(
              color: Color(0xFF16A34A),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
