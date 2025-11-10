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
import 'package:carenest/app/features/pricing/views/ndis_pricing_management_view.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

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
  bool _useAdminBankDetails = false; // Default to employee bank details
  double _taxRate = 0.00; // Default 0% GST
  final TextEditingController _taxRateController = TextEditingController();

  // Shared preferences helper for persisting user choices
  final SharedPreferencesUtils _prefs = SharedPreferencesUtils();

  // Photo attachment state
  List<File> _attachedPhotos = [];
  String? _photoDescription;

  // Additional file attachments state
  List<File> _additionalAttachments = [];

  // Price override state
  Map<String, Map<String, dynamic>> _priceOverrides = {};

  // Base service rate preflight check state
  bool _isCheckingRates = false;
  bool _hasMissingBaseRates = false;
  List<String> _missingRateItems = [];
  String _ratesCheckMessage = '';
  bool _strictClientGating = false; // Require client-specific base rates
  Map<String, List<Map<String, String>>> _missingClientRatesByItem = {};
  Map<String, List<Map<String, String>>> _clientsPerItem = {};
  // Track pricing source per item number for UI annotations
  Map<String, String> _itemPricingSource = {};
  // Track support item names per item number for clearer UI display
  Map<String, String> _supportItemNames = {};

  @override
  void initState() {
    super.initState();
    _taxRateController.text = (_taxRate * 100).toStringAsFixed(1);
    _loadUseAdminPreference();

    // Trigger a preflight base rate check after first frame if we have a selection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.selectedEmployeesAndClients?.isNotEmpty == true) {
        _preflightRateCheck();
      }
    });
  }

  @override
  void dispose() {
    _taxRateController.dispose();
    super.dispose();
  }

  /// Loads the persisted preference for using admin bank details.
  /// If no value is stored, defaults to false (use employee bank details).
  Future<void> _loadUseAdminPreference() async {
    try {
      await _prefs.init();
      final stored = _prefs.getBool(SharedPreferencesUtils.kUseAdminBankDetailsKey);
      if (stored != null) {
        setState(() => _useAdminBankDetails = stored);
      }
    } catch (e) {
      // Non-fatal: fall back to default
      debugPrint('Failed to load useAdminBankDetails preference: $e');
    }
  }

  /// Persists the current selection for admin vs employee bank details.
  Future<void> _persistUseAdminPreference(bool value) async {
    try {
      await _prefs.setBool(SharedPreferencesUtils.kUseAdminBankDetailsKey, value);
    } catch (e) {
      debugPrint('Failed to persist useAdminBankDetails preference: $e');
    }
  }

  /// Resolve the organization ID from the current selection or fallback to genKey.
  /// Returns a non-empty string organization identifier used for pricing lookups.
  String _resolveOrganizationId() {
    String? organizationId;
    if (widget.selectedEmployeesAndClients?.isNotEmpty == true) {
      final firstEmployee = widget.selectedEmployeesAndClients!.first;
      organizationId =
          firstEmployee['employee']?['organizationId'] as String? ??
              firstEmployee['organizationId'] as String?;
    }
    organizationId ??= widget.genKey;
    return organizationId ?? widget.genKey;
  }

  /// Preflight check for missing base service rates.
  ///
  /// Collects NDIS support item numbers from selected client assignments and
  /// runs a bulk pricing lookup.
  ///
  /// Rules:
  /// - Items with `source` of `base-rate`, `ndis_default`, or `fallback` are
  ///   treated as missing base rates regardless of numeric `price` values.
  /// - Only `client_specific` and `organization` sources count as having base
  ///   service rates.
  /// - Local price overrides satisfy gating for the overridden item.
  /// - When `_strictClientGating` is true, a per-client lookup is performed
  ///   and any client items returning fallback sources are flagged missing.
  /// Preflight check for missing base service rates.
  ///
  /// The optional `preserveExisting` parameter allows the UI to retain the
  /// current missing items list while a refresh is in progress (used after
  /// saving prices) to prevent the modal from appearing empty. When false,
  /// the method clears previous results at the start.
  Future<void> _preflightRateCheck({bool preserveExisting = false}) async {
    if (widget.selectedEmployeesAndClients?.isNotEmpty != true) {
      if (!mounted) return;
      setState(() {
        _isCheckingRates = false;
        _hasMissingBaseRates = false;
        _missingRateItems = [];
        _ratesCheckMessage = '';
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _isCheckingRates = true;
      if (!preserveExisting) {
        _hasMissingBaseRates = false;
        _missingRateItems = [];
        _missingClientRatesByItem = {};
        _ratesCheckMessage = '';
      } else {
        // Keep existing visible items while refreshing pricing in background.
        _ratesCheckMessage = _ratesCheckMessage.isNotEmpty
            ? _ratesCheckMessage
            : 'Refreshing pricing…';
      }
    });

    try {
      final apiMethod = ApiMethod();
      final organizationId = _resolveOrganizationId();
      final Set<String> supportItemNumbers = {};
      final Map<String, List<Map<String, String>>> clientsPerItem = {};

      // Collect actual assignments for selected employees and clients
      for (final employee in widget.selectedEmployeesAndClients!) {
        final employeeEmail = employee['employee']?['email'] as String? ?? '';
        final selectedClients = employee['clients'] as List<dynamic>? ?? [];

        if (employeeEmail.isEmpty) continue;

        final assignmentsResponse = await apiMethod.getUserAssignments(employeeEmail);
        if (assignmentsResponse['success'] == true && assignmentsResponse['assignments'] is List) {
          final assignmentsList = assignmentsResponse['assignments'] as List<dynamic>;

          for (final client in selectedClients) {
            final clientEmail = client['email'] as String? ?? '';
            if (clientEmail.isEmpty) continue;

            // Find matching assignment and extract schedule items
            for (final assignment in assignmentsList) {
              if (assignment is! Map<String, dynamic>) continue;
              final assignmentClientEmail = assignment['clientEmail'] as String? ?? '';
              if (assignmentClientEmail != clientEmail) continue;

              final schedule = assignment['schedule'] as List<dynamic>? ?? [];
              for (final scheduleItem in schedule) {
                if (scheduleItem is! Map<String, dynamic>) continue;
                final ndisItem = scheduleItem['ndisItem'] as Map<String, dynamic>?;
                final itemNumber = ndisItem?['itemNumber'] as String?;
                if (itemNumber != null && itemNumber.isNotEmpty) {
                  supportItemNumbers.add(itemNumber);
                  final clientId = assignment['clientId']?.toString() ?? '';
                  final clientEmail = assignment['clientEmail']?.toString() ?? '';
                  final clientName = assignment['clientName']?.toString() ?? clientEmail;
                  final entry = {
                    'clientId': clientId,
                    'clientEmail': clientEmail,
                    'clientName': clientName,
                  };
                  final list = clientsPerItem[itemNumber] ?? <Map<String, String>>[];
                  // Avoid duplicate client entries
                  if (!list.any((e) => e['clientId'] == clientId)) {
                    list.add(entry);
                    clientsPerItem[itemNumber] = list;
                  }
                }
              }
            }
          }
        }
      }

      if (supportItemNumbers.isEmpty) {
        // No NDIS items found from assignments; allow generation and inform user
        setState(() {
          _isCheckingRates = false;
          _hasMissingBaseRates = false;
          _missingRateItems = [];
          _missingClientRatesByItem = {};
          _ratesCheckMessage = 'No NDIS items found in selected assignments.';
        });
        return;
      }

      // Bulk pricing lookup for unique support item numbers
      final pricingMap = await apiMethod.getBulkPricingLookup(
        organizationId,
        supportItemNumbers.toList(),
      );

      final List<String> missingItems = [];
      if (pricingMap != null) {
        for (final itemNumber in supportItemNumbers) {
          final data = pricingMap[itemNumber];
          try {
            // Treat fallback sources as missing regardless of price.
            final String? src = (data is Map<String, dynamic>)
                ? data['source']?.toString()
                : null;
            // Track per-item pricing source for UI annotations
            _itemPricingSource[itemNumber] = src ?? 'missing';
            final bool isFallbackSource = src == 'base-rate' || src == 'ndis_default' || src == 'fallback';

            if (isFallbackSource) {
              missingItems.add(itemNumber);
            } else {
              // Otherwise, consider a base rate present if 'price' or 'customPrice' is a positive number.
              double effectivePrice = 0.0;
              if (data is Map<String, dynamic>) {
                final cp = data['customPrice'];
                final p = data['price'];
                if (cp != null && cp.toString().isNotEmpty && cp.toString() != 'null') {
                  effectivePrice = double.tryParse(cp.toString()) ?? 0.0;
                } else if (p != null && p.toString().isNotEmpty && p.toString() != 'null') {
                  effectivePrice = double.tryParse(p.toString()) ?? 0.0;
                }
              }

              if (effectivePrice <= 0) {
                missingItems.add(itemNumber);
              }
            }
          } catch (e) {
            debugPrint('Error evaluating pricing for $itemNumber: $e');
            missingItems.add(itemNumber);
          }
        }
      } else {
        // Unable to retrieve pricing; treat all as missing
        missingItems.addAll(supportItemNumbers);
      }

      // If user has set price overrides locally, consider those items as satisfied.
      if (_priceOverrides.isNotEmpty && missingItems.isNotEmpty) {
        final overriddenItemNumbers = <String>{};
        _priceOverrides.forEach((id, payload) {
          try {
            final overridePrice = (payload['unitPrice'] as num?)?.toDouble() ?? 0.0;
            if (overridePrice > 0) {
              final parts = id.split('_');
              if (parts.length >= 2) {
                final itemNum = parts[1];
                if (itemNum.isNotEmpty) overriddenItemNumbers.add(itemNum);
              }
            }
          } catch (_) {}
        });
        if (overriddenItemNumbers.isNotEmpty) {
          missingItems.removeWhere((item) => overriddenItemNumbers.contains(item));
        }
      }

      // Optional stricter gating: check client-specific pricing for each item-client combo
      final Map<String, List<Map<String, String>>> missingClientByItem = {};
      if (_strictClientGating) {
        for (final itemNumber in supportItemNumbers) {
          final clients = clientsPerItem[itemNumber] ?? const [];
          for (final client in clients) {
            final clientId = client['clientId'] ?? '';
            if (clientId.isEmpty) continue;
            try {
              final data = await apiMethod.getPricingLookup(
                organizationId,
                itemNumber,
                clientId: clientId,
              );
              // Flag fallback sources as missing regardless of price.
              final String? src = data != null ? data['source']?.toString() : null;
              final bool isFallbackSource = src == 'ndis_default' || src == 'base-rate' || src == 'fallback';
              double clientPrice = 0.0;
              if (!isFallbackSource && data != null) {
                final cp = data['customPrice'];
                final p = data['price'];
                if (cp != null && cp.toString().isNotEmpty && cp.toString() != 'null') {
                  clientPrice = double.tryParse(cp.toString()) ?? 0.0;
                } else if (p != null && p.toString().isNotEmpty && p.toString() != 'null') {
                  clientPrice = double.tryParse(p.toString()) ?? 0.0;
                }
              }
              if (isFallbackSource || clientPrice <= 0) {
                final list = missingClientByItem[itemNumber] ?? <Map<String, String>>[];
                list.add(client);
                missingClientByItem[itemNumber] = list;
              }
            } catch (e) {
              debugPrint('Client-specific pricing check failed for $itemNumber (${client['clientEmail']}) : $e');
              final list = missingClientByItem[itemNumber] ?? <Map<String, String>>[];
              list.add(client);
              missingClientByItem[itemNumber] = list;
            }
          }
        }
      }

      // Resolve human-readable support item names for UI display
      final Map<String, String> namesMap = {};
      try {
        final Set<String> nameLookupItems = {
          ...missingItems,
          ...missingClientByItem.keys,
        };
        if (nameLookupItems.isNotEmpty) {
          final lookups = nameLookupItems.map((item) async {
            try {
              final details = await apiMethod.getSupportItemDetails(item);
              final name = details?['supportItemName']?.toString() ??
                  details?['itemName']?.toString() ??
                  details?['description']?.toString();
              if (name != null && name.trim().isNotEmpty) {
                namesMap[item] = name.trim();
              }
            } catch (e) {
              debugPrint('Support item name lookup failed for $item: $e');
            }
          });
          await Future.wait(lookups);
        }
      } catch (e) {
        debugPrint('Support item names preflight lookup error: $e');
      }

      if (!mounted) return;
      setState(() {
        _isCheckingRates = false;
        _hasMissingBaseRates = missingItems.isNotEmpty;
        _missingRateItems = missingItems;
        _missingClientRatesByItem = missingClientByItem;
        _clientsPerItem = clientsPerItem;
        _supportItemNames.addAll(namesMap);
        if (_hasMissingBaseRates) {
          final previewItems = missingItems.take(3).join(', ');
          _ratesCheckMessage =
              'Base service rates are missing or using fallback for ${missingItems.length} NDIS item(s): $previewItems${missingItems.length > 3 ? '…' : ''}. Please add custom pricing or set price overrides.';
        } else {
          _ratesCheckMessage = 'All selected NDIS items have configured base service rates.';
        }
      });
    } catch (e) {
      debugPrint('Preflight rate check error: $e');
      if (!mounted) return;
      setState(() {
        _isCheckingRates = false;
        // Preserve current list if we were refreshing; do not clear modal.
        if (!preserveExisting) {
          _hasMissingBaseRates = false; // Do not block on unexpected error
          _missingRateItems = [];
          _missingClientRatesByItem = {};
        }
        _ratesCheckMessage = 'Error during rate check: $e';
      });
    }
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
          _buildBankDetailsConfiguration(),
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
  
  Widget _buildBankDetailsConfiguration() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.account_balance_rounded,
              color: ModernSaasDesign.primary,
              size: 20,
            ),
            const SizedBox(width: ModernSaasDesign.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Details',
                    style: ModernSaasDesign.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Select which bank details to use on the invoice',
                    style: ModernSaasDesign.bodySmall.copyWith(
                      color: ModernSaasDesign.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: ModernSaasDesign.space3),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: Text(
                  'Employee Bank Details',
                  style: ModernSaasDesign.bodyMedium,
                ),
                value: false,
                groupValue: _useAdminBankDetails,
                onChanged: (value) {
                  setState(() {
                    _useAdminBankDetails = value!;
                  });
                  _persistUseAdminPreference(_useAdminBankDetails);
                },
                activeColor: ModernSaasDesign.primary,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: Text(
                  'Admin Bank Details',
                  style: ModernSaasDesign.bodyMedium,
                ),
                value: true,
                groupValue: _useAdminBankDetails,
                onChanged: (value) {
                  setState(() {
                    _useAdminBankDetails = value!;
                  });
                  _persistUseAdminPreference(_useAdminBankDetails);
                },
                activeColor: ModernSaasDesign.primary,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ],
        ),
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
    final bool selectionPresent =
        widget.selectedEmployeesAndClients?.isNotEmpty == true;
    final bool hasClientGatingIssues = _strictClientGating && _missingClientRatesByItem.isNotEmpty;
    final bool canGenerate = selectionPresent && !_hasMissingBaseRates && !hasClientGatingIssues;
    final bool isLoading = invoiceState == InvoiceGenerationState.loading;
    // Selected invoice period state
    // Defaults: null -> service will use its fallback
    DateTime? startDateLocal = _selectedStartDate;
    DateTime? endDateLocal = _selectedEndDate;

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
          // Base rate preflight summary and actions
          Container(
            padding: const EdgeInsets.all(ModernSaasDesign.space3),
            decoration: BoxDecoration(
              color: _hasMissingBaseRates
                  ? ModernSaasDesign.error.withValues(alpha: 0.08)
                  : ModernSaasDesign.success.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              border: Border.all(
                color: _hasMissingBaseRates
                    ? ModernSaasDesign.error.withValues(alpha: 0.3)
                    : ModernSaasDesign.success.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _hasMissingBaseRates
                      ? Icons.error_outline
                      : Icons.check_circle_outline,
                  color: _hasMissingBaseRates
                      ? ModernSaasDesign.error
                      : ModernSaasDesign.success,
                  size: 20,
                ),
                const SizedBox(width: ModernSaasDesign.space2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _hasMissingBaseRates
                            ? 'Missing Base Rates Detected'
                            : 'Base Rates Verified',
                        style: ModernSaasDesign.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: _hasMissingBaseRates
                              ? ModernSaasDesign.error
                              : ModernSaasDesign.success,
                        ),
                      ),
                      const SizedBox(height: ModernSaasDesign.space1),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Tooltip(
                            message:
                                'We treat fallback sources (base-rate, ndis_default, fallback) as missing\nso you can configure organization/client-specific base rates.\nUse the View Missing Items list to add custom pricing.',
                            child: Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: ModernSaasDesign.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: ModernSaasDesign.space1),
                      Text(
                        _ratesCheckMessage,
                        style: ModernSaasDesign.bodySmall.copyWith(
                          color: ModernSaasDesign.textSecondary,
                        ),
                      ),
                      const SizedBox(height: ModernSaasDesign.space2),
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: ModernSaasDesign.space2,
                        runSpacing: ModernSaasDesign.space1,
                        children: [
                          TextButton.icon(
                            onPressed: _isCheckingRates ? null : _preflightRateCheck,
                            icon: _isCheckingRates
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          _hasMissingBaseRates
                                              ? ModernSaasDesign.error
                                              : ModernSaasDesign.success),
                                    ),
                                  )
                                : const Icon(Icons.refresh),
                            label: const Text('Re-check Rates'),
                          ),
                          TextButton.icon(
                            onPressed: (_hasMissingBaseRates || hasClientGatingIssues)
                                ? _showMissingRatesModal
                                : null,
                            icon: const Icon(Icons.list_alt_rounded),
                            label: const Text('View Missing Items'),
                          ),
                          if (selectionPresent)
                            TextButton.icon(
                              onPressed: _isCheckingRates ? null : _openPriceOverrideView,
                              icon: const Icon(Icons.price_change_rounded),
                              label: const Text('Set Price Overrides'),
                            ),
                          TextButton.icon(
                            onPressed: () {
                              _openOrganizationPricingManagement();
                            },
                            icon: const Icon(Icons.settings_suggest_rounded),
                            label: const Text('Open Pricing Management'),
                          ),
                        ],
                      ),
                      const SizedBox(height: ModernSaasDesign.space2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Switch(
                            value: _strictClientGating,
                            onChanged: _isCheckingRates
                                ? null
                                : (val) {
                                    setState(() {
                                      _strictClientGating = val;
                                    });
                                    _preflightRateCheck();
                                  },
                          ),
                          const SizedBox(width: ModernSaasDesign.space1),
                          Expanded(
                            child: Text(
                              'Require client-specific base rates',
                              style: ModernSaasDesign.bodySmall.copyWith(
                                color: ModernSaasDesign.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: ModernSaasDesign.space4),
          // Period selection UI
          Container(
            padding: const EdgeInsets.all(ModernSaasDesign.space3),
            decoration: BoxDecoration(
              color: ModernSaasDesign.neutral100,
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              border: Border.all(
                color: ModernSaasDesign.neutral300,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invoice Period',
                      style: ModernSaasDesign.headlineSmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: isLoading
                          ? null
                          : () async {
                              final picked = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                initialDateRange: (startDateLocal != null &&
                                        endDateLocal != null)
                                    ? DateTimeRange(
                                        start: startDateLocal!,
                                        end: endDateLocal!,
                                      )
                                    : null,
                              );
                              if (picked != null) {
                                setState(() {
                                  _selectedStartDate = picked.start;
                                  _selectedEndDate = picked.end;
                                });
                              }
                            },
                      icon: const Icon(Icons.date_range_rounded),
                      label: const Text('Select Period'),
                    ),
                  ],
                ),
                const SizedBox(height: ModernSaasDesign.space2),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 18,
                      color: ModernSaasDesign.textSecondary,
                    ),
                    const SizedBox(width: ModernSaasDesign.space2),
                    Expanded(
                      child: Text(
                        (startDateLocal != null && endDateLocal != null)
                            ? '${_formatDate(startDateLocal!)}  —  ${_formatDate(endDateLocal!)}'
                            : 'No period selected (using default)',
                        style: ModernSaasDesign.bodyMedium.copyWith(
                          color: ModernSaasDesign.textSecondary,
                        ),
                      ),
                    ),
                    if (startDateLocal != null && endDateLocal != null)
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                setState(() {
                                  _selectedStartDate = null;
                                  _selectedEndDate = null;
                                });
                              },
                        child: const Text('Clear'),
                      ),
                  ],
                ),
              ],
            ),
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
      debugPrint("Tax rate in UI: $_taxRate");
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
        useAdminBankDetails: _useAdminBankDetails,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
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

  // Local state for date range selection
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  String _formatDate(DateTime dt) {
    // Simple local formatter: YYYY-MM-DD
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
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

  /// Open organization-level NDIS Pricing Management.
  void _openOrganizationPricingManagement() {
    final orgId = _resolveOrganizationId();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NdisPricingManagementView(
          organizationId: orgId,
          adminEmail: widget.email,
          organizationName: widget.organizationName,
        ),
      ),
    );
  }

  /// Show modal listing missing base rates and provide quick add actions.
  void _showMissingRatesModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ModernSaasDesign.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(ModernSaasDesign.radiusLg)),
      ),
      builder: (context) {
        final hasClientIssues = _strictClientGating && _missingClientRatesByItem.isNotEmpty;
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) {
            return ListView(
              controller: controller,
              padding: const EdgeInsets.all(ModernSaasDesign.space4),
              children: [
                Row(
                  children: [
                    Icon(Icons.list_alt_rounded, color: ModernSaasDesign.error, size: 22),
                    const SizedBox(width: ModernSaasDesign.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Missing Base Rates',
                            style: ModernSaasDesign.headlineSmall.copyWith(fontWeight: FontWeight.w600),
                          ),
                          // Compact refreshing indicator shown while a preserved refresh is running
                          if (_isCheckingRates)
                            Padding(
                              padding: const EdgeInsets.only(top: ModernSaasDesign.space1),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(ModernSaasDesign.primary),
                                    ),
                                  ),
                                  const SizedBox(width: ModernSaasDesign.space1),
                                  Text(
                                    _ratesCheckMessage.isNotEmpty ? _ratesCheckMessage : 'Refreshing pricing…',
                                    style: ModernSaasDesign.bodyMedium.copyWith(color: ModernSaasDesign.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _openOrganizationPricingManagement,
                      icon: const Icon(Icons.settings_suggest_rounded),
                      label: const Text('Open Pricing Management'),
                    ),
                  ],
                ),
                const SizedBox(height: ModernSaasDesign.space3),
                if (_missingRateItems.isNotEmpty) ...[
                  Text(
                    'Items missing organization base rate (${_missingRateItems.length}):',
                    style: ModernSaasDesign.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: ModernSaasDesign.space2),
                  ..._missingRateItems.map((itemNumber) => Card(
                        elevation: 0,
                        color: ModernSaasDesign.surfaceVariant,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
                          side: BorderSide(color: ModernSaasDesign.border, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(ModernSaasDesign.space3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      spacing: ModernSaasDesign.space2,
                                      runSpacing: ModernSaasDesign.space1,
                                      children: [
                                        Text(
                                          itemNumber,
                                          softWrap: true,
                                          style: ModernSaasDesign.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        SourceBadge(
                                          source: _itemPricingSource[itemNumber] ?? 'fallback',
                                          isSmall: true,
                                          tooltip: 'Pricing source for this item',
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: ModernSaasDesign.space3),
                                  Semantics(
                                    button: true,
                                    label: 'Add organization base rate for ${_supportItemNames[itemNumber] ?? itemNumber}',
                                    child: TextButton(
                                      onPressed: () => _promptAddOrgBaseRate(itemNumber),
                                      child: const Text('Add Org Base Rate'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: ModernSaasDesign.space2),
                              Text(
                                _supportItemNames[itemNumber] ?? 'Support item name unavailable',
                                softWrap: true,
                                style: ModernSaasDesign.bodyMedium.copyWith(
                                  color: ModernSaasDesign.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: ModernSaasDesign.space4),
                ],
                if (hasClientIssues) ...[
                  Text(
                    'Items missing client-specific base rate:',
                    style: ModernSaasDesign.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: ModernSaasDesign.space2),
                  ..._missingClientRatesByItem.entries.map((entry) {
                    final itemNumber = entry.key;
                    final clients = entry.value;
                    return Card(
                      elevation: 0,
                      color: ModernSaasDesign.surfaceVariant,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
                        side: BorderSide(color: ModernSaasDesign.border, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(ModernSaasDesign.space3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    itemNumber,
                                    softWrap: true,
                                    style: ModernSaasDesign.bodyLarge.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Semantics(
                                  button: true,
                                  label: 'Add organization base rate for ${_supportItemNames[itemNumber] ?? itemNumber}',
                                  child: TextButton(
                                    onPressed: () => _promptAddOrgBaseRate(itemNumber),
                                    child: const Text('Add Org Base Rate'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: ModernSaasDesign.space2),
                            Text(
                              _supportItemNames[itemNumber] ?? 'Support item name unavailable',
                              softWrap: true,
                              style: ModernSaasDesign.bodyMedium.copyWith(
                                color: ModernSaasDesign.textSecondary,
                              ),
                            ),
                            const SizedBox(height: ModernSaasDesign.space2),
                            ...clients.map((client) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: ModernSaasDesign.space1),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          client['clientName'] ?? client['clientEmail'] ?? 'Unknown Client',
                                          style: ModernSaasDesign.bodyMedium,
                                        ),
                                      ),
                                      Semantics(
                                        button: true,
                                        label:
                                            'Add client base rate for ${client['clientName'] ?? client['clientEmail'] ?? 'client'} on ${_supportItemNames[itemNumber] ?? itemNumber}',
                                        child: TextButton(
                                          onPressed: () => _promptAddClientBaseRate(itemNumber, client),
                                          child: const Text('Add Client Rate'),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
                const SizedBox(height: ModernSaasDesign.space4),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Prompt for entering an organization-wide base rate for an item and save it.
  Future<void> _promptAddOrgBaseRate(String itemNumber) async {
    final controller = TextEditingController();
    final orgId = _resolveOrganizationId();
    final prefs = SharedPreferencesUtils();
    await prefs.init();
    final userEmail = prefs.getUserEmail() ?? widget.email;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Organization Base Rate'),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Price (e.g., 65.17)'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final price = double.tryParse(controller.text.trim());
                if (price == null || price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid price'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                try {
                  final api = ApiMethod();
                  final result = await api.saveAsCustomPricing(
                    orgId,
                    itemNumber,
                    price,
                    'fixed',
                    userEmail,
                  );
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Base rate saved successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Optimistically update local state to keep remaining items visible
                    setState(() {
                      _itemPricingSource[itemNumber] = 'organization';
                      _missingRateItems.removeWhere((i) => i == itemNumber);
                      _missingClientRatesByItem.remove(itemNumber);
                      _hasMissingBaseRates =
                          _missingRateItems.isNotEmpty || _missingClientRatesByItem.isNotEmpty;
                    });
                    // Refresh pricing without clearing the existing list
                    _preflightRateCheck(preserveExisting: true);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to save base rate: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  /// Prompt for entering a client-specific base rate and save it.
  Future<void> _promptAddClientBaseRate(String itemNumber, Map<String, String> client) async {
    final controller = TextEditingController();
    final orgId = _resolveOrganizationId();
    final clientId = client['clientId'] ?? '';
    final clientName = client['clientName'] ?? client['clientEmail'] ?? '';
    final prefs = SharedPreferencesUtils();
    await prefs.init();
    final userEmail = prefs.getUserEmail() ?? widget.email;

    if (clientId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Missing client ID for saving pricing'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Client Base Rate – $clientName'),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Price (e.g., 65.17)'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final price = double.tryParse(controller.text.trim());
                if (price == null || price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid price'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                try {
                  final api = ApiMethod();
                  final result = await api.saveClientCustomPricing(
                    orgId,
                    clientId,
                    itemNumber,
                    price,
                    'fixed',
                    userEmail,
                  );
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Client base rate saved successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Optimistically update local state to keep remaining items visible
                    setState(() {
                      _itemPricingSource[itemNumber] = 'client_specific';
                      final list = _missingClientRatesByItem[itemNumber];
                      if (list != null) {
                        list.removeWhere((e) => (e['clientId'] ?? '') == clientId);
                        if (list.isEmpty) {
                          _missingClientRatesByItem.remove(itemNumber);
                        } else {
                          _missingClientRatesByItem[itemNumber] = list;
                        }
                      }
                      _hasMissingBaseRates =
                          _missingRateItems.isNotEmpty || _missingClientRatesByItem.isNotEmpty;
                    });
                    // Refresh pricing without clearing the existing list
                    _preflightRateCheck(preserveExisting: true);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to save client base rate: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
