import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:carenest/app/features/training_compliance/models/certification.dart';
import 'package:carenest/app/features/training_compliance/models/certification_requirement.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class CertificationsView extends ConsumerStatefulWidget {
  const CertificationsView({super.key});

  @override
  ConsumerState<CertificationsView> createState() => _CertificationsViewState();
}

class _CertificationsViewState extends ConsumerState<CertificationsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(certificationsViewModelProvider.notifier).loadCertifications();
      ref
          .read(certificationRequirementsViewModelProvider.notifier)
          .loadRequirements();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(certificationsViewModelProvider);
    final requirementsState =
        ref.watch(certificationRequirementsViewModelProvider);
    final requirements = requirementsState.requirements
        .where((req) => req.isActive)
        .toList();

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.certificationsTitle,
            style: BauhausDesign.getTextTheme(context).headlineLarge),
        backgroundColor: BauhausDesign.surfaceLight,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : ListView(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              children: [
                if (requirements.isNotEmpty)
                  _buildRequirementsSection(
                    context,
                    requirements,
                    state.certifications,
                  ),
                if (requirements.isNotEmpty)
                  const SizedBox(height: BauhausDesign.space4),
                if (state.certifications.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.noCertificationsMessage,
                          textAlign: TextAlign.center,
                          style: BauhausDesign.getTextTheme(context).bodyLarge,
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        BauhausActionButton(
                          text: AppLocalizations.of(context)!.uploadButtonAction,
                          icon: Icons.upload_file,
                          onPressed: () => _showUploadDialog(context),
                        ),
                      ],
                    ),
                  )
                else ...[
                  ...state.certifications.map((cert) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: BauhausDesign.space3),
                      child: BauhausCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    cert.name,
                                    style: BauhausDesign.getTextTheme(context)
                                        .headlineLarge
                                        ?.copyWith(
                                          color: BauhausDesign.textDark,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                _buildStatusBadge(context, cert.status),
                              ],
                            ),
                            const SizedBox(height: BauhausDesign.space2),
                            Text(
                              AppLocalizations.of(context)!
                                  .issuerLabel(cert.issuer),
                              style:
                                  BauhausDesign.getTextTheme(context).bodyMedium,
                            ),
                            Text(
                              AppLocalizations.of(context)!.expiresLabel(
                                DateFormat('dd MMM yyyy')
                                    .format(cert.expiryDate),
                              ),
                              style:
                                  BauhausDesign.getTextTheme(context).bodyMedium,
                            ),
                            if (cert.certificationNumber != null &&
                                cert.certificationNumber!.isNotEmpty) ...[
                              const SizedBox(height: BauhausDesign.space2),
                              Text(
                                'Certification No: ${cert.certificationNumber}',
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium,
                              ),
                            ],
                            if (cert.notes != null && cert.notes!.isNotEmpty) ...[
                              const SizedBox(height: BauhausDesign.space2),
                              Text(
                                AppLocalizations.of(context)!
                                    .notesDetailLabel(cert.notes!),
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                            ],
                            const SizedBox(height: BauhausDesign.space3),
                            Row(
                              children: [
                                if (cert.fileUrl.isNotEmpty) ...[
                                  TextButton.icon(
                                    onPressed: () =>
                                        _openCertificationFile(cert.fileUrl),
                                    icon: const Icon(Icons.visibility, size: 18),
                                    label: const Text('View File'),
                                  ),
                                  const SizedBox(width: BauhausDesign.space2),
                                ],
                                TextButton.icon(
                                  onPressed: () =>
                                      _showEditDialog(context, cert),
                                  icon: const Icon(Icons.edit, size: 18),
                                  label: const Text('Edit'),
                                ),
                                const SizedBox(width: BauhausDesign.space2),
                                TextButton.icon(
                                  onPressed: () => _confirmDelete(context, cert),
                                  icon: const Icon(Icons.delete, size: 18),
                                  label: const Text('Delete'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: BauhausDesign.error,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  BauhausActionButton(
                    text: AppLocalizations.of(context)!.uploadButtonAction,
                    icon: Icons.upload_file,
                    isFullWidth: true,
                    onPressed: () => _showUploadDialog(context),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'missing':
        color = BauhausDesign.error;
        break;
      case 'approved':
        color = BauhausDesign.success;
        break;
      case 'rejected':
        color = BauhausDesign.error;
        break;
      case 'expired':
        color = BauhausDesign.neutral;
        break;
      default:
        color = BauhausDesign.warning;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space3, vertical: BauhausDesign.space1),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Text(
        status.toUpperCase(),
        style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.surfaceWhite,
              fontSize: 10,
            ),
      ),
    );
  }

  Certification? _findMatchingCertification(
    CertificationRequirement requirement,
    List<Certification> certifications,
  ) {
    for (final cert in certifications) {
      if (cert.requirementId != null &&
          cert.requirementId == requirement.id) {
        return cert;
      }
      if (cert.name.toLowerCase() == requirement.name.toLowerCase()) {
        return cert;
      }
    }
    return null;
  }

  Widget _buildRequirementsSection(
    BuildContext context,
    List<CertificationRequirement> requirements,
    List<Certification> certifications,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Required Certifications',
          style: BauhausDesign.getTextTheme(context)
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: BauhausDesign.space3),
        ...requirements.map((requirement) {
          final cert = _findMatchingCertification(requirement, certifications);
          final statusLabel =
              cert == null ? 'Missing' : cert.status.toUpperCase();
          return Padding(
            padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
            child: BauhausCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          requirement.name,
                          style: BauhausDesign.getTextTheme(context)
                              .headlineLarge
                              ?.copyWith(
                                color: BauhausDesign.textDark,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      _buildStatusBadge(
                        context,
                        cert == null ? 'missing' : cert.status,
                      ),
                    ],
                  ),
                  if (requirement.description.isNotEmpty) ...[
                    const SizedBox(height: BauhausDesign.space2),
                    Text(
                      requirement.description,
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                    ),
                  ],
                  if (cert != null &&
                      cert.certificationNumber != null &&
                      cert.certificationNumber!.isNotEmpty) ...[
                    const SizedBox(height: BauhausDesign.space2),
                    Text(
                      'Certification No: ${cert.certificationNumber}',
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                    ),
                  ],
                  const SizedBox(height: BauhausDesign.space3),
                  Row(
                    children: [
                      if (cert == null)
                        BauhausActionButton(
                          text: 'Upload',
                          icon: Icons.upload_file,
                          onPressed: () => _showUploadDialog(
                            context,
                            requirement: requirement,
                          ),
                        )
                      else
                        Text(
                          statusLabel,
                          style: BauhausDesign.getTextTheme(context)
                              .labelLarge
                              ?.copyWith(color: BauhausDesign.textMuted),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showUploadDialog(BuildContext context,
      {CertificationRequirement? requirement}) {
    showDialog(
      context: context,
      builder: (context) => UploadCertificationDialog(requirement: requirement),
    );
  }

  Future<void> _openCertificationFile(String fileUrl) async {
    final uri = Uri.tryParse(fileUrl);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showEditDialog(BuildContext context, Certification cert) {
    showDialog(
      context: context,
      builder: (context) => EditCertificationDialog(certification: cert),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Certification cert) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Certification'),
        content: const Text('Are you sure you want to delete this certification?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true && cert.id != null) {
      await ref
          .read(certificationsViewModelProvider.notifier)
          .deleteCertification(cert.id!);
    }
  }
}

class EditCertificationDialog extends ConsumerStatefulWidget {
  final Certification certification;

  const EditCertificationDialog({
    super.key,
    required this.certification,
  });

  @override
  ConsumerState<EditCertificationDialog> createState() =>
      _EditCertificationDialogState();
}

class _EditCertificationDialogState
    extends ConsumerState<EditCertificationDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _issuerController;
  late final TextEditingController _notesController;
  late final TextEditingController _numberController;
  DateTime? _expiryDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.certification.name);
    _issuerController = TextEditingController(text: widget.certification.issuer);
    _notesController = TextEditingController(text: widget.certification.notes ?? '');
    _numberController = TextEditingController(
        text: widget.certification.certificationNumber ?? '');
    _expiryDate = widget.certification.expiryDate;
  }

  @override
  Widget build(BuildContext context) {
    final requirementsState =
        ref.watch(certificationRequirementsViewModelProvider);
    final requirements = requirementsState.requirements
        .where((req) => req.isActive)
        .toList();

    return Dialog(
      insetPadding: const EdgeInsets.all(BauhausDesign.space4),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update Certification',
                style: BauhausDesign.getTextTheme(context)
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: BauhausDesign.space4),
              TextFormField(
                controller: _nameController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                  labelText: AppLocalizations.of(context)!.certificationNameLabel,
                ),
                validator: (v) => v?.isEmpty == true
                    ? AppLocalizations.of(context)!.requiredValidation
                    : null,
              ),
              const SizedBox(height: BauhausDesign.space3),
              TextFormField(
                controller: _issuerController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                  labelText: AppLocalizations.of(context)!.issuerFieldLabel,
                ),
                validator: (v) => v?.isEmpty == true
                    ? AppLocalizations.of(context)!.requiredValidation
                    : null,
              ),
              const SizedBox(height: BauhausDesign.space3),
              TextFormField(
                controller: _numberController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                  labelText: 'Certification / NDIS Check Number (Optional)',
                ),
              ),
              const SizedBox(height: BauhausDesign.space3),
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _expiryDate ?? DateTime.now().add(const Duration(days: 365)),
                    firstDate: DateTime.now().subtract(const Duration(days: 3650)),
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                  );
                  if (date != null) setState(() => _expiryDate = date);
                },
                child: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    border: Border.all(color: BauhausDesign.neutral),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: BauhausDesign.space2),
                      Text(
                        _expiryDate == null
                            ? AppLocalizations.of(context)!.selectExpiryDate
                            : DateFormat('dd MMM yyyy').format(_expiryDate!),
                        style: BauhausDesign.getTextTheme(context).bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space3),
              TextFormField(
                controller: _notesController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                  labelText: AppLocalizations.of(context)!.notesOptionalLabel,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: BauhausDesign.space4),
              Row(
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      text: AppLocalizations.of(context)!.cancelButton,
                      variant: BauhausActionVariant.neutral,
                      isOutlined: true,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: BauhausActionButton(
                      text: 'Save',
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        if (widget.certification.id == null) return;
                        await ref
                            .read(certificationsViewModelProvider.notifier)
                            .updateCertification(
                              id: widget.certification.id!,
                              name: _nameController.text,
                              issuer: _issuerController.text,
                              expiryDate: _expiryDate,
                              notes: _notesController.text,
                              certificationNumber:
                                  _numberController.text.trim().isEmpty
                                      ? null
                                      : _numberController.text.trim(),
                            );
                        if (mounted) Navigator.pop(context);
                      },
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
}

class UploadCertificationDialog extends ConsumerStatefulWidget {
  final CertificationRequirement? requirement;

  const UploadCertificationDialog({super.key, this.requirement});

  @override
  ConsumerState<UploadCertificationDialog> createState() =>
      _UploadCertificationDialogState();
}

class _UploadCertificationDialogState
    extends ConsumerState<UploadCertificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _issuerController = TextEditingController();
  final _notesController = TextEditingController();
  final _numberController = TextEditingController();
  DateTime? _expiryDate;
  File? _selectedFile;
  String? _selectedRequirementId;

  @override
  void initState() {
    super.initState();
    if (widget.requirement != null) {
      _selectedRequirementId = widget.requirement!.id;
      _nameController.text = widget.requirement!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final requirementsState =
        ref.watch(certificationRequirementsViewModelProvider);
    final requirements = requirementsState.requirements
        .where((req) => req.isActive)
        .toList();

    return Dialog(
      insetPadding: const EdgeInsets.all(BauhausDesign.space4),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.uploadCertificationTitle,
                  style: BauhausDesign.getTextTheme(context)
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: BauhausDesign.space4),
                if (requirements.isNotEmpty) ...[
                  DropdownButtonFormField<String>(
                    value: _selectedRequirementId,
                    decoration: BauhausDesign.inputDecoration('').copyWith(
                        labelText: 'Certification Requirement (Optional)'),
                    items: requirements
                        .map((req) => DropdownMenuItem(
                              value: req.id,
                              child: Text(req.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      final selected = requirements.firstWhere(
                        (req) => req.id == value,
                        orElse: () => requirements.first,
                      );
                      setState(() {
                        _selectedRequirementId = value;
                        _nameController.text = selected.name;
                      });
                    },
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                ],
                TextFormField(
                controller: _nameController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText:
                        AppLocalizations.of(context)!.certificationNameLabel),
                validator: (v) => v?.isEmpty == true
                    ? AppLocalizations.of(context)!.requiredValidation
                    : null,
              ),
              const SizedBox(height: BauhausDesign.space3),
              TextFormField(
                controller: _issuerController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: AppLocalizations.of(context)!.issuerFieldLabel),
                validator: (v) => v?.isEmpty == true
                    ? AppLocalizations.of(context)!.requiredValidation
                    : null,
              ),
              const SizedBox(height: BauhausDesign.space3),
              TextFormField(
                controller: _numberController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText: 'Certification / NDIS Check Number (Optional)'),
              ),
              const SizedBox(height: BauhausDesign.space3),
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 365)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                  );
                  if (date != null) setState(() => _expiryDate = date);
                },
                child: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    border: Border.all(color: BauhausDesign.neutral),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: BauhausDesign.space2),
                      Text(
                        _expiryDate == null
                            ? AppLocalizations.of(context)!.selectExpiryDate
                            : DateFormat('dd MMM yyyy').format(_expiryDate!),
                        style: BauhausDesign.getTextTheme(context).bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space3),
              GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'jpg', 'png']);
                  if (result != null) {
                    setState(
                        () => _selectedFile = File(result.files.single.path!));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: _selectedFile != null
                        ? BauhausDesign.primary.withOpacity(0.1)
                        : BauhausDesign.backgroundLight,
                    border: Border.all(color: BauhausDesign.neutral),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file, size: 20),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          _selectedFile == null
                              ? AppLocalizations.of(context)!.selectFile
                              : _selectedFile!.path.split('/').last,
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: BauhausDesign.space3),
              TextFormField(
                controller: _notesController,
                decoration: BauhausDesign.inputDecoration('').copyWith(
                    labelText:
                        AppLocalizations.of(context)!.notesOptionalLabel),
                maxLines: 2,
              ),
                const SizedBox(height: BauhausDesign.space4),
                Row(
                  children: [
                    Expanded(
                      child: BauhausActionButton(
                        text: AppLocalizations.of(context)!.cancelButton,
                        variant: BauhausActionVariant.neutral,
                        isOutlined: true,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: BauhausActionButton(
                        text: AppLocalizations.of(context)!.uploadButtonAction,
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _expiryDate != null &&
                              _selectedFile != null) {
                            ref
                                .read(certificationsViewModelProvider.notifier)
                                .uploadCertification(
                                  _selectedFile!,
                                  _nameController.text,
                                  _issuerController.text,
                                  _expiryDate!,
                                  _notesController.text,
                                  certificationNumber:
                                      _numberController.text.trim().isEmpty
                                          ? null
                                          : _numberController.text.trim(),
                                  requirementId: _selectedRequirementId,
                                );
                            Navigator.pop(context);
                          } else if (_expiryDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .selectExpiryDateError)));
                          } else if (_selectedFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    AppLocalizations.of(context)!.selectFileError)));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
