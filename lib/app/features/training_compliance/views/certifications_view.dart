import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(certificationsViewModelProvider);

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showUploadDialog(context),
        backgroundColor: BauhausDesign.primary,
        label: Text(AppLocalizations.of(context)!.uploadButton,
            style: BauhausDesign.getTextTheme(context)
                .labelLarge
                ?.copyWith(color: Colors.white)),
        icon: const Icon(Icons.upload, color: Colors.white),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : state.certifications.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noCertificationsMessage,
                    textAlign: TextAlign.center,
                    style: BauhausDesign.getTextTheme(context).bodyLarge,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: state.certifications.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: BauhausDesign.space3),
                  itemBuilder: (context, index) {
                    final cert = state.certifications[index];
                    return Container(
                      padding: const EdgeInsets.all(BauhausDesign.space4),
                      decoration: BauhausDesign.cardDecoration,
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
                                      .headlineLarge,
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
                                    .format(cert.expiryDate)),
                            style:
                                BauhausDesign.getTextTheme(context).bodyMedium,
                          ),
                          if (cert.notes != null && cert.notes!.isNotEmpty) ...[
                            const SizedBox(height: BauhausDesign.space2),
                            Text(
                              AppLocalizations.of(context)!
                                  .notesDetailLabel(cert.notes!),
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    Color color;
    switch (status.toLowerCase()) {
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
        borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
      child: Text(
        status.toUpperCase(),
        style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: Colors.white,
              fontSize: 10,
            ),
      ),
    );
  }

  void _showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const UploadCertificationDialog(),
    );
  }
}

class UploadCertificationDialog extends ConsumerStatefulWidget {
  const UploadCertificationDialog({super.key});

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
  DateTime? _expiryDate;
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: BauhausDesign.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        side: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      title: Text(AppLocalizations.of(context)!.uploadCertificationTitle,
          style: BauhausDesign.getTextTheme(context).headlineLarge),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
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
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
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
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancelButton,
              style: BauhausDesign.getTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: BauhausDesign.textDark)),
        ),
        BauhausButton(
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
                  );
              Navigator.pop(context);
            } else if (_expiryDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      AppLocalizations.of(context)!.selectExpiryDateError)));
            } else if (_selectedFile == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text(AppLocalizations.of(context)!.selectFileError)));
            }
          },
        ),
      ],
    );
  }
}
