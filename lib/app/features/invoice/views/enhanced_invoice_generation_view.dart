import 'package:carenest/app/features/invoice/views/price_override_view.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/features/invoice/models/employee_selection_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/enhanced_invoice_viewmodel.dart';

import 'package:carenest/app/features/invoice/widgets/invoice_photo_attachment_widget.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_components.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

/// Enhanced Invoice Generation View
/// Task 5.6: Update invoice service with enhanced pricing integration
class EnhancedInvoiceGenerationView extends ConsumerStatefulWidget {
  final String email;
  final String genKey;
  final String? organizationName;
  final List<Map<String, dynamic>>? selectedEmployeesAndClients;

  const EnhancedInvoiceGenerationView({
    Key? key,
    required this.email,
    required this.genKey,
    this.organizationName,
    this.selectedEmployeesAndClients,
  }) : super(key: key);

  @override
  ConsumerState<EnhancedInvoiceGenerationView> createState() =>
      _EnhancedInvoiceGenerationViewState();
}

class _EnhancedInvoiceGenerationViewState
    extends ConsumerState<EnhancedInvoiceGenerationView> {
  bool _showTax = true;
  bool _includeExpenses = true;
  bool _allowPriceOverride = true;
  double _taxRate = 0.00; // Default 0% GST
  final TextEditingController _taxRateController = TextEditingController();

  // Photo attachment state
  List<File> _attachedPhotos = [];
  String? _photoDescription;

  // Additional file attachments state
  List<File> _additionalAttachments = [];

  // Price override state
  Map<String, Map<String, dynamic>> _priceOverrides = {};

  @override
  void initState() {
    super.initState();
    _taxRateController.text = (_taxRate * 100).toStringAsFixed(1);
  }

  @override
  void dispose() {
    _taxRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceState = ref.watch(invoiceGenerationStateProvider);
    final errorMessage = ref.watch(invoiceGenerationErrorProvider);
    final generatedPdfs = ref.watch(generatedInvoicePathsProvider);

    return Scaffold(
      backgroundColor: ModernSaasDesign.background,
      appBar: _buildAppBar(),
      body: _buildBody(invoiceState, errorMessage, generatedPdfs),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ModernSaasDesign.primary,
      foregroundColor: ModernSaasDesign.textOnPrimary,
      elevation: 0,
      title: Text(
        'Generate Invoice',
        style: ModernSaasDesign.headlineSmall.copyWith(
          color: ModernSaasDesign.textOnPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        if (_priceOverrides.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: ModernSaasDesign.success,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.price_change,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_priceOverrides.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBody(
    InvoiceGenerationState invoiceState,
    String errorMessage,
    List<String> generatedPdfs,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ModernSaasDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(),
          const SizedBox(height: ModernSaasDesign.space6),
          _buildConfigurationSection(),
          const SizedBox(height: ModernSaasDesign.space6),
          _buildAttachmentsSection(),
          const SizedBox(height: ModernSaasDesign.space6),
          _buildPriceOverrideSection(),
          const SizedBox(height: ModernSaasDesign.space6),
          _buildGenerateSection(invoiceState, errorMessage),
          if (generatedPdfs.isNotEmpty) ...[
            const SizedBox(height: ModernSaasDesign.space6),
            _buildGeneratedPdfsSection(generatedPdfs),
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Card(
      elevation: 0,
      color: ModernSaasDesign.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
        side: BorderSide(
          color: ModernSaasDesign.border,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(ModernSaasDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(ModernSaasDesign.space2),
                  decoration: BoxDecoration(
                    color: ModernSaasDesign.primaryLight.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusMd),
                  ),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    color: ModernSaasDesign.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: ModernSaasDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enhanced Invoice Generation',
                        style: ModernSaasDesign.headlineSmall.copyWith(
                          color: ModernSaasDesign.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: ModernSaasDesign.space1),
                      Text(
                        'Generate professional invoices with enhanced pricing validation',
                        style: ModernSaasDesign.bodyMedium.copyWith(
                          color: ModernSaasDesign.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.selectedEmployeesAndClients == null ||
                widget.selectedEmployeesAndClients!.isEmpty) ...[
              const SizedBox(height: ModernSaasDesign.space4),
              ModernInvoiceStatusBadge(
                status: 'No employees selected',
                backgroundColor: ModernSaasDesign.error.withValues(alpha: 0.1),
                textColor: ModernSaasDesign.error,
                icon: Icons.warning,
              ),
            ],
            if (widget.selectedEmployeesAndClients != null &&
                widget.selectedEmployeesAndClients!.isNotEmpty) ...[
              const SizedBox(height: ModernSaasDesign.space4),
              _buildSelectedEmployeesInfo(),
            ],
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.2, end: 0, duration: 600.ms);
  }

  Widget _buildSelectedEmployeesInfo() {
    int totalEmployees = widget.selectedEmployeesAndClients?.length ?? 0;
    int totalClients = 0;

    for (var employee in widget.selectedEmployeesAndClients ?? []) {
      totalClients += (employee['clients'] as List<dynamic>).length;
    }

    return Card(
      elevation: 0,
      color: ModernSaasDesign.surfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
        side: BorderSide(
          color: ModernSaasDesign.border,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.people, size: 18, color: ModernSaasDesign.primary),
                const SizedBox(width: ModernSaasDesign.space2),
                Expanded(
                  child: Text(
                    'Selected: $totalEmployees ${totalEmployees == 1 ? 'employee' : 'employees'} with $totalClients ${totalClients == 1 ? 'client' : 'clients'}',
                    style: ModernSaasDesign.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigurationSection() {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings_rounded,
                color: ModernSaasDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernSaasDesign.space3),
              Text(
                'Invoice Configuration',
                style: ModernSaasDesign.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space4),
          _buildTaxConfiguration(),
          const SizedBox(height: ModernSaasDesign.space4),
          _buildExpenseConfiguration(),
          const SizedBox(height: ModernSaasDesign.space4),
          _buildPriceOverrideConfiguration(),
        ],
      ),
    );
  }

  Widget _buildTaxConfiguration() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.calculate_rounded,
              color: ModernSaasDesign.primary,
              size: 20,
            ),
            const SizedBox(width: ModernSaasDesign.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Include Tax (GST)',
                    style: ModernSaasDesign.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Add tax calculations to the invoice',
                    style: ModernSaasDesign.bodySmall.copyWith(
                      color: ModernSaasDesign.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _showTax,
              onChanged: (value) {
                setState(() {
                  _showTax = value;
                });
              },
              activeColor: ModernSaasDesign.primary,
              activeTrackColor: ModernSaasDesign.primary.withValues(alpha: 0.3),
              inactiveThumbColor: ModernSaasDesign.neutral400,
              inactiveTrackColor: ModernSaasDesign.neutral200,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
        if (_showTax) ...[
          const SizedBox(height: ModernSaasDesign.space3),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tax Rate (%)',
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: TextFormField(
                  controller: _taxRateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '10.0',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(ModernSaasDesign.radiusMd),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (value) {
                    final rate = double.tryParse(value);
                    if (rate != null && rate >= 0 && rate <= 100) {
                      setState(() {
                        _taxRate = rate / 100;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildExpenseConfiguration() {
    return Row(
      children: [
        Icon(
          Icons.receipt_rounded,
          color: ModernSaasDesign.primary,
          size: 20,
        ),
        const SizedBox(width: ModernSaasDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Include Expenses',
                style: ModernSaasDesign.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Add expense items to the invoice',
                style: ModernSaasDesign.bodySmall.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _includeExpenses,
          onChanged: (value) {
            setState(() {
              _includeExpenses = value;
            });
          },
          activeColor: ModernSaasDesign.primary,
          activeTrackColor: ModernSaasDesign.primary.withValues(alpha: 0.3),
          inactiveThumbColor: ModernSaasDesign.neutral400,
          inactiveTrackColor: ModernSaasDesign.neutral200,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  Widget _buildPriceOverrideConfiguration() {
    return Row(
      children: [
        Icon(
          Icons.price_change_rounded,
          color: ModernSaasDesign.primary,
          size: 20,
        ),
        const SizedBox(width: ModernSaasDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Allow Price Cap Override',
                style: ModernSaasDesign.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Enable price adjustments beyond standard caps',
                style: ModernSaasDesign.bodySmall.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _allowPriceOverride,
          onChanged: (value) {
            setState(() {
              _allowPriceOverride = value;
            });
          },
          activeColor: ModernSaasDesign.primary,
          activeTrackColor: ModernSaasDesign.primary.withValues(alpha: 0.3),
          inactiveThumbColor: ModernSaasDesign.neutral400,
          inactiveTrackColor: ModernSaasDesign.neutral200,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  Widget _buildAttachmentsSection() {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_file_rounded,
                color: ModernSaasDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernSaasDesign.space3),
              Text(
                'Attachments',
                style: ModernSaasDesign.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space4),
          InvoicePhotoAttachmentWidget(
            onPhotosSelected: (photos) {
              setState(() {
                _attachedPhotos = photos;
              });
            },
            initialPhotos: _attachedPhotos,
            photoDescription: _photoDescription,
            onDescriptionChanged: (description) {
              setState(() {
                _photoDescription = description;
              });
            },
          ),
          const SizedBox(height: ModernSaasDesign.space4),
          _buildAdditionalAttachments(),
        ],
      ),
    );
  }

  Widget _buildAdditionalAttachments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(ModernSaasDesign.space2),
              decoration: BoxDecoration(
                color: ModernSaasDesign.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              ),
              child: Icon(
                Icons.file_present_rounded,
                size: 20,
                color: ModernSaasDesign.primary,
              ),
            ),
            const SizedBox(width: ModernSaasDesign.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Files',
                    style: ModernSaasDesign.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ModernSaasDesign.textPrimary,
                    ),
                  ),
                  Text(
                    'Attach documents, receipts, or other files',
                    style: ModernSaasDesign.bodySmall.copyWith(
                      color: ModernSaasDesign.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: ModernSaasDesign.space4),
        // Modern Add Files Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: ModernSaasDesign.primary.withValues(alpha: 0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
            color: ModernSaasDesign.primary.withValues(alpha: 0.02),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _pickAdditionalFiles,
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
              child: Padding(
                padding: const EdgeInsets.all(ModernSaasDesign.space6),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(ModernSaasDesign.space4),
                      decoration: BoxDecoration(
                        color: ModernSaasDesign.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: ModernSaasDesign.primary,
                      ),
                    ),
                    const SizedBox(height: ModernSaasDesign.space3),
                    Text(
                      'Add Files',
                      style: ModernSaasDesign.headlineSmall.copyWith(
                        color: ModernSaasDesign.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: ModernSaasDesign.space1),
                    Text(
                      'Tap to select files or drag and drop',
                      style: ModernSaasDesign.bodySmall.copyWith(
                        color: ModernSaasDesign.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: ModernSaasDesign.space2),
                    Wrap(
                      spacing: ModernSaasDesign.space2,
                      children: [
                        _buildFileTypeChip('PDF'),
                        _buildFileTypeChip('DOC'),
                        _buildFileTypeChip('IMG'),
                        _buildFileTypeChip('TXT'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_additionalAttachments.isNotEmpty) ...[
          const SizedBox(height: ModernSaasDesign.space4),
          Container(
            padding: const EdgeInsets.all(ModernSaasDesign.space4),
            decoration: BoxDecoration(
              color: ModernSaasDesign.surfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
              border: Border.all(
                color: ModernSaasDesign.border.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.attach_file_rounded,
                      size: 16,
                      color: ModernSaasDesign.textSecondary,
                    ),
                    const SizedBox(width: ModernSaasDesign.space2),
                    Text(
                      'Attached Files (${_additionalAttachments.length})',
                      style: ModernSaasDesign.bodySmall.copyWith(
                        color: ModernSaasDesign.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ModernSaasDesign.space3),
                ...(_additionalAttachments.asMap().entries.map((entry) {
                  final index = entry.key;
                  final file = entry.value;
                  final fileName = file.path.split('/').last;
                  final fileExtension = fileName.split('.').last.toLowerCase();

                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: ModernSaasDesign.space2),
                    padding: const EdgeInsets.all(ModernSaasDesign.space3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ModernSaasDesign.radiusMd),
                      border: Border.all(
                        color: ModernSaasDesign.border,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.all(ModernSaasDesign.space2),
                          decoration: BoxDecoration(
                            color: _getFileTypeColor(fileExtension)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                                ModernSaasDesign.radiusSm),
                          ),
                          child: Icon(
                            _getFileTypeIcon(fileExtension),
                            color: _getFileTypeColor(fileExtension),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: ModernSaasDesign.space3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fileName,
                                style: ModernSaasDesign.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                fileExtension.toUpperCase(),
                                style: ModernSaasDesign.bodySmall.copyWith(
                                  color: ModernSaasDesign.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                ModernSaasDesign.error.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _additionalAttachments.removeAt(index);
                              });
                            },
                            icon: Icon(
                              Icons.close_rounded,
                              color: ModernSaasDesign.error,
                              size: 16,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPriceOverrideSection() {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.price_change_rounded,
                color: ModernSaasDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernSaasDesign.space3),
              Text(
                'Price Override',
                style: ModernSaasDesign.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space4),
          Text(
            'Review and adjust pricing for NDIS items before generating invoices.',
            style: ModernSaasDesign.bodyMedium.copyWith(
              color: ModernSaasDesign.textSecondary,
            ),
          ),
          const SizedBox(height: ModernSaasDesign.space4),
          if (_priceOverrides.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(ModernSaasDesign.space3),
              decoration: BoxDecoration(
                color: ModernSaasDesign.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
                border: Border.all(
                  color: ModernSaasDesign.success.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: ModernSaasDesign.success,
                    size: 20,
                  ),
                  const SizedBox(width: ModernSaasDesign.space2),
                  Expanded(
                    child: Text(
                      '${_priceOverrides.length} price override(s) applied',
                      style: ModernSaasDesign.bodyMedium.copyWith(
                        color: ModernSaasDesign.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ModernSaasDesign.space3),
          ],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.selectedEmployeesAndClients?.isNotEmpty == true
                  ? _openPriceOverrideView
                  : null,
              icon: const Icon(Icons.price_change_rounded, size: 20),
              label: Text(
                _priceOverrides.isEmpty
                    ? 'Set Price Overrides'
                    : 'Update Price Overrides',
                style: ModernSaasDesign.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ModernSaasDesign.textOnPrimary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ModernSaasDesign.primary,
                foregroundColor: ModernSaasDesign.textOnPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space4,
                  vertical: ModernSaasDesign.space3,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusMd),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateSection(
      InvoiceGenerationState invoiceState, String errorMessage) {
    final bool canGenerate =
        widget.selectedEmployeesAndClients?.isNotEmpty == true;
    final bool isLoading = invoiceState == InvoiceGenerationState.loading;

    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                color: ModernSaasDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernSaasDesign.space3),
              Text(
                'Generate Invoice',
                style: ModernSaasDesign.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space4),
          if (errorMessage.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(ModernSaasDesign.space3),
              decoration: BoxDecoration(
                color: ModernSaasDesign.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
                border: Border.all(
                  color: ModernSaasDesign.error.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_rounded,
                    color: ModernSaasDesign.error,
                    size: 20,
                  ),
                  const SizedBox(width: ModernSaasDesign.space2),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: ModernSaasDesign.bodyMedium.copyWith(
                        color: ModernSaasDesign.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ModernSaasDesign.space4),
          ],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: canGenerate && !isLoading ? _generateInvoices : null,
              icon: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ModernSaasDesign.textOnPrimary),
                      ),
                    )
                  : const Icon(Icons.receipt_long_rounded, size: 20),
              label: Text(
                isLoading ? 'Generating...' : 'Generate Invoices',
                style: ModernSaasDesign.labelLarge.copyWith(
                  color: ModernSaasDesign.textOnPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: canGenerate
                    ? ModernSaasDesign.primary
                    : ModernSaasDesign.neutral300,
                foregroundColor: canGenerate
                    ? ModernSaasDesign.textOnPrimary
                    : ModernSaasDesign.textTertiary,
                padding: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space4,
                  vertical: ModernSaasDesign.space4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusMd),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedPdfsSection(List<String> generatedPdfs) {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.file_present_rounded,
                color: ModernSaasDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernSaasDesign.space3),
              Text(
                'Generated Invoices',
                style: ModernSaasDesign.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space4),
          ...generatedPdfs.asMap().entries.map((entry) {
            final index = entry.key;
            final pdfPath = entry.value;
            final fileName = pdfPath.split('/').last;

            return Container(
              margin: index < generatedPdfs.length - 1
                  ? const EdgeInsets.only(bottom: ModernSaasDesign.space2)
                  : EdgeInsets.zero,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(ModernSaasDesign.space2),
                  decoration: BoxDecoration(
                    color: ModernSaasDesign.success.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusMd),
                  ),
                  child: Icon(
                    Icons.picture_as_pdf_rounded,
                    color: ModernSaasDesign.success,
                    size: 20,
                  ),
                ),
                title: Text(
                  fileName,
                  style: ModernSaasDesign.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Tap to view PDF',
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _viewPdf(pdfPath),
                      icon: Icon(
                        Icons.visibility_rounded,
                        color: ModernSaasDesign.primary,
                        size: 20,
                      ),
                      tooltip: 'View PDF',
                    ),
                    IconButton(
                      onPressed: () => _sendInvoices(pdfPath),
                      icon: Icon(
                        Icons.send_rounded,
                        color: ModernSaasDesign.primary,
                        size: 20,
                      ),
                      tooltip: 'Send Invoice',
                    ),
                  ],
                ),
                onTap: () => _viewPdf(pdfPath),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFileTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ModernSaasDesign.space2,
        vertical: ModernSaasDesign.space1,
      ),
      decoration: BoxDecoration(
        color: ModernSaasDesign.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusSm),
        border: Border.all(
          color: ModernSaasDesign.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        type,
        style: ModernSaasDesign.bodySmall.copyWith(
          color: ModernSaasDesign.primary,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }

  IconData _getFileTypeIcon(String extension) {
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'doc':
      case 'docx':
        return Icons.description_rounded;
      case 'txt':
        return Icons.text_snippet_rounded;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _getFileTypeColor(String extension) {
    switch (extension) {
      case 'pdf':
        return const Color(0xFFE53E3E);
      case 'doc':
      case 'docx':
        return const Color(0xFF2B6CB0);
      case 'txt':
        return const Color(0xFF38A169);
      case 'jpg':
      case 'jpeg':
      case 'png':
        return const Color(0xFF805AD5);
      default:
        return ModernSaasDesign.textSecondary;
    }
  }

  Future<void> _pickAdditionalFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        setState(() {
          _additionalAttachments.addAll(
            result.paths.map((path) => File(path!)).toList(),
          );
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking files: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _generateInvoices() async {
    // The invoice service will handle updating the global state
    // through the providers, so we don't need to set it here

    // Generate invoices with enhanced pricing integration
    final viewModel = ref.read(enhancedInvoiceViewModelProvider.notifier);
    try {
      // Extract organizationId from selectedEmployeesAndClients
      String? organizationId;
      if (widget.selectedEmployeesAndClients?.isNotEmpty == true) {
        // Get organizationId from the employee data structure
        final firstEmployee = widget.selectedEmployeesAndClients!.first;
        organizationId =
            firstEmployee['employee']?['organizationId'] as String? ??
                firstEmployee['organizationId'] as String?;
      }
      // Fallback to genKey if organizationId is not found
      organizationId ??= widget.genKey;

      await viewModel.generateInvoices(
        context,
        selectedEmployeesAndClients: widget.selectedEmployeesAndClients,
        organizationId: organizationId,
        validatePrices: true,
        allowPriceCapOverride: _allowPriceOverride,
        includeDetailedPricingInfo: true,
        applyTax: _showTax,
        taxRate: _taxRate,
        includeExpenses: _includeExpenses,
        attachedPhotos: _attachedPhotos,
        photoDescription: _photoDescription,
        additionalAttachments: _additionalAttachments,
        priceOverrides: _priceOverrides.isNotEmpty ? _priceOverrides : null,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating invoices: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _openPriceOverrideView() async {
    try {
      // Fetch actual client assignments with schedule data
      List<Map<String, dynamic>> clientAssignments = [];

      if (widget.selectedEmployeesAndClients != null) {
        for (var employee in widget.selectedEmployeesAndClients!) {
          final employeeEmail = employee['employee']?['email'] as String? ?? '';
          final selectedClients = employee['clients'] as List<dynamic>? ?? [];

          if (employeeEmail.isNotEmpty) {
            // Get user assignments for this employee
            final apiMethod = ApiMethod();
            final assignments =
                await apiMethod.getUserAssignments(employeeEmail);

            if (assignments['success'] == true &&
                assignments['assignments'] != null) {
              final assignmentsList =
                  assignments['assignments'] as List<dynamic>;

              // For each selected client, find their assignment
              for (var client in selectedClients) {
                final clientEmail = client['email'] as String? ?? '';

                // Find matching assignment
                for (var assignment in assignmentsList) {
                  if (assignment is Map<String, dynamic>) {
                    final assignmentClientEmail =
                        assignment['clientEmail'] as String? ?? '';
                    if (assignmentClientEmail == clientEmail) {
                      clientAssignments.add(assignment);
                      break;
                    }
                  }
                }
              }
            }
          }
        }
      }

      // Navigate to PriceOverrideView with actual assignment data
      final result = await Navigator.push<Map<String, Map<String, dynamic>>>(
        context,
        MaterialPageRoute(
          builder: (context) => PriceOverrideView(
            clientId: clientAssignments.isNotEmpty
                ? clientAssignments.first['clientId'] ?? ''
                : '',
            organizationId: clientAssignments.isNotEmpty
                ? clientAssignments.first['organizationId'] ?? widget.genKey
                : widget.genKey,
            clientAssignments: clientAssignments,
          ),
        ),
      );

      if (result != null && result.isNotEmpty) {
        setState(() {
          _priceOverrides = result;
        });

        // Show confirmation message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Price overrides applied for ${result.length} item(s)'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading client assignments: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _sendInvoices(String pdfPath) async {
    final viewModel = ref.read(enhancedInvoiceViewModelProvider.notifier);

    try {
      // The invoice service will handle updating the global state
      // through the providers, so we don't need to set it here

      final result = await viewModel.sendInvoiceEmails(
        pdfPath,
        widget.email,
        widget.genKey,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result
                ? 'Invoices sent successfully!'
                : 'Failed to send invoices'),
            backgroundColor: result ? Colors.green : Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending invoices: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _viewPdf(String pdfPath) async {
    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewPage(
            pdfPath: pdfPath,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error viewing PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
