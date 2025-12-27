import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/features/invoice/viewmodels/enhanced_invoice_viewmodel.dart';
import 'package:carenest/app/features/invoice/views/price_override_view.dart'
    hide SourceBadge;
import 'package:carenest/app/features/invoice/widgets/invoice_photo_attachment_widget.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/pricing/views/ndis_pricing_management_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_configuration_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/invoice/widgets/source_badge.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';

/// Enhanced Invoice Generation View
/// Task 5.6: Update invoice service with enhanced pricing integration
class EnhancedInvoiceGenerationView extends ConsumerStatefulWidget {
  final String email;
  final String genKey;
  final String? organizationName;
  final List<Map<String, dynamic>>? selectedEmployeesAndClients;

  const EnhancedInvoiceGenerationView({
    super.key,
    required this.email,
    required this.genKey,
    this.organizationName,
    this.selectedEmployeesAndClients,
  });

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
  final List<File> _additionalAttachments = [];

  // Price override state
  Map<String, Map<String, dynamic>> _priceOverrides = {};

  // Base service rate preflight check state
  bool _isCheckingRates = false;
  bool _isValidatingPriceCaps =
      false; // Loading state for NDIS price cap validation
  bool _hasMissingBaseRates = false;
  List<String> _missingRateItems = [];
  String _ratesCheckMessage = '';
  bool _strictClientGating = false; // Require client-specific base rates
  Map<String, List<Map<String, String>>> _missingClientRatesByItem = {};
  // Track pricing source per item number for UI annotations
  final Map<String, String> _itemPricingSource = {};
  // Track support item names per item number for clearer UI display
  final Map<String, String> _supportItemNames = {};

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
      final stored =
          _prefs.getBool(SharedPreferencesUtils.kUseAdminBankDetailsKey);
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
      await _prefs.setBool(
          SharedPreferencesUtils.kUseAdminBankDetailsKey, value);
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
    return organizationId;
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
        // Keep existing visible items while refreshing pricing in surface.
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

        final assignmentsResponse =
            await apiMethod.getUserAssignments(employeeEmail);
        if (assignmentsResponse['success'] == true &&
            assignmentsResponse['assignments'] is List) {
          final assignmentsList =
              assignmentsResponse['assignments'] as List<dynamic>;

          for (final client in selectedClients) {
            final clientEmail = client['email'] as String? ?? '';
            if (clientEmail.isEmpty) continue;

            // Find matching assignment and extract schedule items
            for (final assignment in assignmentsList) {
              if (assignment is! Map<String, dynamic>) continue;
              final assignmentClientEmail =
                  assignment['clientEmail'] as String? ?? '';
              if (assignmentClientEmail != clientEmail) continue;

              final schedule = assignment['schedule'] as List<dynamic>? ?? [];
              for (final scheduleItem in schedule) {
                if (scheduleItem is! Map<String, dynamic>) continue;
                final ndisItem =
                    scheduleItem['ndisItem'] as Map<String, dynamic>?;
                final itemNumber = ndisItem?['itemNumber'] as String?;
                if (itemNumber != null && itemNumber.isNotEmpty) {
                  supportItemNumbers.add(itemNumber);
                  final clientId = assignment['clientId']?.toString() ?? '';
                  final clientEmail =
                      assignment['clientEmail']?.toString() ?? '';
                  final clientName =
                      assignment['clientName']?.toString() ?? clientEmail;
                  final entry = {
                    'clientId': clientId,
                    'clientEmail': clientEmail,
                    'clientName': clientName,
                  };
                  final list =
                      clientsPerItem[itemNumber] ?? <Map<String, String>>[];
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
            // Note: 'fallback-base-rate' is a valid configured rate from Pricing Configuration
            final String? src = (data is Map<String, dynamic>)
                ? data['source']?.toString()
                : null;
            // Track per-item pricing source for UI annotations
            _itemPricingSource[itemNumber] = src ?? 'missing';
            // Only 'base-rate', 'ndis_default', and 'fallback' are considered missing
            // 'fallback-base-rate' is a valid configured rate from Pricing Configuration Dashboard
            // Note: 'base-rate' is the old source name, now replaced with 'fallback-base-rate'
            final bool isFallbackSource =
                src == 'ndis_default' || src == 'fallback';

            if (isFallbackSource) {
              missingItems.add(itemNumber);
            } else {
              // Otherwise, consider a base rate present if 'price' or 'customPrice' is a positive number.
              double effectivePrice = 0.0;
              if (data is Map<String, dynamic>) {
                final cp = data['customPrice'];
                final p = data['price'];
                if (cp != null &&
                    cp.toString().isNotEmpty &&
                    cp.toString() != 'null') {
                  effectivePrice = double.tryParse(cp.toString()) ?? 0.0;
                } else if (p != null &&
                    p.toString().isNotEmpty &&
                    p.toString() != 'null') {
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
            final overridePrice =
                (payload['unitPrice'] as num?)?.toDouble() ?? 0.0;
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
          missingItems
              .removeWhere((item) => overriddenItemNumbers.contains(item));
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
              // Note: 'fallback-base-rate' is a valid configured rate
              final String? src =
                  data != null ? data['source']?.toString() : null;
              final bool isFallbackSource =
                  src == 'ndis_default' || src == 'fallback';
              double clientPrice = 0.0;
              if (!isFallbackSource && data != null) {
                final cp = data['customPrice'];
                final p = data['price'];
                if (cp != null &&
                    cp.toString().isNotEmpty &&
                    cp.toString() != 'null') {
                  clientPrice = double.tryParse(cp.toString()) ?? 0.0;
                } else if (p != null &&
                    p.toString().isNotEmpty &&
                    p.toString() != 'null') {
                  clientPrice = double.tryParse(p.toString()) ?? 0.0;
                }
              }
              if (isFallbackSource || clientPrice <= 0) {
                final list =
                    missingClientByItem[itemNumber] ?? <Map<String, String>>[];
                list.add(client);
                missingClientByItem[itemNumber] = list;
              }
            } catch (e) {
              debugPrint(
                  'Client-specific pricing check failed for $itemNumber (${client['clientEmail']}) : $e');
              final list =
                  missingClientByItem[itemNumber] ?? <Map<String, String>>[];
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
        _supportItemNames.addAll(namesMap);
        if (_hasMissingBaseRates) {
          final previewItems = missingItems.take(3).join(', ');
          _ratesCheckMessage =
              'Base service rates are missing or using fallback for ${missingItems.length} NDIS item(s): $previewItems${missingItems.length > 3 ? '…' : ''}. Please add custom pricing or set price overrides.';
        } else {
          _ratesCheckMessage =
              'All selected NDIS items have configured base service rates.';
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
      appBar: _buildAppBar(),
      body: _buildBody(invoiceState, errorMessage, generatedPdfs),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      foregroundColor: ModernInvoiceDesign.textPrimary,
      backgroundColor: ModernInvoiceDesign.surface,
      elevation: 0,
      title: Text(
        'Generate Invoice',
        style: ModernInvoiceDesign.headlineMedium,
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
              color: ModernInvoiceDesign.success,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.price_change,
                  size: 16,
                  color: ModernInvoiceDesign.surface,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_priceOverrides.length}',
                  style: const TextStyle(
                    color: ModernInvoiceDesign.surface,
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(),
          const SizedBox(height: 24.0),
          _buildConfigurationSection(),
          const SizedBox(height: 24.0),
          _buildAttachmentsSection(),
          const SizedBox(height: 24.0),
          _buildPriceOverrideSection(),
          const SizedBox(height: 24.0),
          _buildGenerateSection(invoiceState, errorMessage),
          if (generatedPdfs.isNotEmpty) ...[
            const SizedBox(height: 24.0),
            _buildGeneratedPdfsSection(generatedPdfs),
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return ModernInvoiceCard(
      backgroundColor: ModernInvoiceDesign.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernInvoiceDesign.space2),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusSm),
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  color: ModernInvoiceDesign.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enhanced Invoice Generation',
                      style: ModernInvoiceDesign.headlineSmall.copyWith(
                        color: ModernInvoiceDesign.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Generate professional invoices with enhanced pricing validation',
                      style: ModernInvoiceDesign.bodyMedium.copyWith(
                        color: ModernInvoiceDesign.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.selectedEmployeesAndClients == null ||
              widget.selectedEmployeesAndClients!.isEmpty) ...[
            const SizedBox(height: ModernInvoiceDesign.space4),
            Container(
              padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.error.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusSm),
                border: Border.all(
                  color: ModernInvoiceDesign.error.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: ModernInvoiceDesign.error,
                    size: 20,
                  ),
                  const SizedBox(width: ModernInvoiceDesign.space2),
                  Expanded(
                    child: Text(
                      'No employees selected',
                      style: ModernInvoiceDesign.bodyMedium.copyWith(
                        color: ModernInvoiceDesign.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (widget.selectedEmployeesAndClients != null &&
              widget.selectedEmployeesAndClients!.isNotEmpty) ...[
            const SizedBox(height: ModernInvoiceDesign.space4),
            _buildSelectedEmployeesInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedEmployeesInfo() {
    int totalEmployees = widget.selectedEmployeesAndClients?.length ?? 0;
    int totalClients = 0;

    for (var employee in widget.selectedEmployeesAndClients ?? []) {
      totalClients += (employee['clients'] as List<dynamic>).length;
    }

    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.surface,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusSm),
        border: Border.all(
          color: ModernInvoiceDesign.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.people_rounded,
            size: 18,
            color: ModernInvoiceDesign.primary,
          ),
          const SizedBox(width: ModernInvoiceDesign.space2),
          Expanded(
            child: Text(
              'Selected: $totalEmployees ${totalEmployees == 1 ? 'employee' : 'employees'} with $totalClients ${totalClients == 1 ? 'client' : 'clients'}',
              style: ModernInvoiceDesign.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: ModernInvoiceDesign.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationSection() {
    return ModernInvoiceCard(
      backgroundColor: ModernInvoiceDesign.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings_rounded,
                color: ModernInvoiceDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Text(
                'Invoice Configuration',
                style: ModernInvoiceDesign.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildTaxConfiguration(),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildBankDetailsConfiguration(),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildExpenseConfiguration(),
          const SizedBox(height: ModernInvoiceDesign.space4),
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
              color: ModernInvoiceDesign.primary,
              size: 20,
            ),
            const SizedBox(width: ModernInvoiceDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Include Tax (GST)',
                    style: ModernInvoiceDesign.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Add tax calculations to the invoice',
                    style: ModernInvoiceDesign.bodySmall.copyWith(
                      color: ModernInvoiceDesign.textSecondary,
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
              activeThumbColor: ModernInvoiceDesign.primary,
              activeTrackColor:
                  ModernInvoiceDesign.primary.withValues(alpha: 0.1),
            ),
          ],
        ),
        if (_showTax) ...[
          const SizedBox(height: ModernInvoiceDesign.space2),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tax Rate (%)',
                  style: ModernInvoiceDesign.bodyMedium.copyWith(
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
                          BorderRadius.circular(ModernInvoiceDesign.radiusSm),
                      borderSide: BorderSide(
                        color: ModernInvoiceDesign.border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(ModernInvoiceDesign.radiusSm),
                      borderSide: BorderSide(
                        color: ModernInvoiceDesign.primary,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: ModernInvoiceDesign.space4,
                      vertical: ModernInvoiceDesign.space2,
                    ),
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
              color: ModernInvoiceDesign.primary,
              size: 20,
            ),
            const SizedBox(width: ModernInvoiceDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Details',
                    style: ModernInvoiceDesign.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Select which bank details to use on the invoice',
                    style: ModernInvoiceDesign.bodySmall.copyWith(
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: ModernInvoiceDesign.space2),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: Text(
                  'Employee Bank Details',
                  style: ModernInvoiceDesign.bodyMedium,
                ),
                value: false,
                groupValue: _useAdminBankDetails,
                onChanged: (value) {
                  setState(() {
                    _useAdminBankDetails = value!;
                  });
                  _persistUseAdminPreference(_useAdminBankDetails);
                },
                activeColor: ModernInvoiceDesign.primary,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: Text(
                  'Admin Bank Details',
                  style: ModernInvoiceDesign.bodyMedium,
                ),
                value: true,
                groupValue: _useAdminBankDetails,
                onChanged: (value) {
                  setState(() {
                    _useAdminBankDetails = value!;
                  });
                  _persistUseAdminPreference(_useAdminBankDetails);
                },
                activeColor: ModernInvoiceDesign.primary,
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
          color: ModernInvoiceDesign.primary,
          size: 20,
        ),
        const SizedBox(width: ModernInvoiceDesign.space4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Include Expenses',
                style: ModernInvoiceDesign.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Add expense items to the invoice',
                style: ModernInvoiceDesign.bodySmall.copyWith(
                  color: ModernInvoiceDesign.textSecondary,
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
          activeThumbColor: ModernInvoiceDesign.primary,
          activeTrackColor: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
        ),
      ],
    );
  }

  Widget _buildPriceOverrideConfiguration() {
    return Row(
      children: [
        Icon(
          Icons.price_change_rounded,
          color: ModernInvoiceDesign.primary,
          size: 20,
        ),
        const SizedBox(width: ModernInvoiceDesign.space4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Allow Price Cap Override',
                style: ModernInvoiceDesign.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Enable price adjustments beyond standard caps',
                style: ModernInvoiceDesign.bodySmall.copyWith(
                  color: ModernInvoiceDesign.textSecondary,
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
          activeThumbColor: ModernInvoiceDesign.primary,
          activeTrackColor: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
        ),
      ],
    );
  }

  Widget _buildAttachmentsSection() {
    return ModernInvoiceCard(
      backgroundColor: ModernInvoiceDesign.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.attach_file_rounded,
                color: ModernInvoiceDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Text(
                'Attachments',
                style: ModernInvoiceDesign.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
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
          const SizedBox(height: ModernInvoiceDesign.space4),
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
              padding: const EdgeInsets.all(ModernInvoiceDesign.space2),
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusSm),
              ),
              child: Icon(
                Icons.file_present_rounded,
                size: 20,
                color: ModernInvoiceDesign.primary,
              ),
            ),
            const SizedBox(width: ModernInvoiceDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Files',
                    style: ModernInvoiceDesign.headlineSmall.copyWith(
                      color: ModernInvoiceDesign.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Attach documents, receipts, or other files',
                    style: ModernInvoiceDesign.bodySmall.copyWith(
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: ModernInvoiceDesign.space4),
        // Modern Add Files Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
            color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _pickAdditionalFiles,
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
              child: Padding(
                padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
                      decoration: BoxDecoration(
                        color:
                            ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: ModernInvoiceDesign.primary,
                      ),
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space4),
                    Text(
                      'Add Files',
                      style: ModernInvoiceDesign.headlineSmall.copyWith(
                        color: ModernInvoiceDesign.primary,
                      ),
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space1),
                    Text(
                      'Tap to select files or drag and drop',
                      style: ModernInvoiceDesign.bodySmall.copyWith(
                        color: ModernInvoiceDesign.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space2),
                    Wrap(
                      spacing: ModernInvoiceDesign.space2,
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
          const SizedBox(height: ModernInvoiceDesign.space4),
          Container(
            padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.surface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
              border: Border.all(
                color: ModernInvoiceDesign.border.withValues(alpha: 0.1),
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
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                    const SizedBox(width: ModernInvoiceDesign.space2),
                    Text(
                      'Attached Files (${_additionalAttachments.length})',
                      style: ModernInvoiceDesign.bodySmall.copyWith(
                        color: ModernInvoiceDesign.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ModernInvoiceDesign.space4),
                ...(_additionalAttachments.asMap().entries.map((entry) {
                  final index = entry.key;
                  final file = entry.value;
                  final fileName = file.path.split('/').last;
                  final fileExtension = fileName.split('.').last.toLowerCase();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: ModernInvoiceDesign.surface,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: ModernInvoiceDesign.border,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ModernInvoiceDesign.textPrimary
                              .withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: _getFileTypeColor(fileExtension)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Icon(
                            _getFileTypeIcon(fileExtension),
                            color: _getFileTypeColor(fileExtension),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fileName,
                                style: ModernInvoiceDesign.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                fileExtension.toUpperCase(),
                                style: ModernInvoiceDesign.bodySmall.copyWith(
                                  color: ModernInvoiceDesign.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ModernInvoiceDesign.error
                                .withValues(alpha: 0.1),
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
                              color: ModernInvoiceDesign.error,
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
    return ModernInvoiceCard(
      backgroundColor: ModernInvoiceDesign.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.price_change_rounded,
                color: ModernInvoiceDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Text(
                'Price Override',
                style: ModernInvoiceDesign.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          Text(
            'Review and adjust pricing for NDIS items before generating invoices.',
            style: ModernInvoiceDesign.bodyMedium.copyWith(
              color: ModernInvoiceDesign.textSecondary,
            ),
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          if (_priceOverrides.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.success.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusSm),
                border: Border.all(
                  color: ModernInvoiceDesign.success.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: ModernInvoiceDesign.success,
                    size: 20,
                  ),
                  const SizedBox(width: ModernInvoiceDesign.space2),
                  Expanded(
                    child: Text(
                      '${_priceOverrides.length} price override(s) applied',
                      style: ModernInvoiceDesign.bodyMedium.copyWith(
                        color: ModernInvoiceDesign.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ModernInvoiceDesign.space4),
          ],
          SizedBox(
            width: double.infinity,
            child: ModernInvoiceButton(
              onPressed: widget.selectedEmployeesAndClients?.isNotEmpty == true
                  ? _openPriceOverrideView
                  : null,
              icon: Icons.price_change_rounded,
              text: _priceOverrides.isEmpty
                  ? 'Set Price Overrides'
                  : 'Update Price Overrides',
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
    final bool hasClientGatingIssues =
        _strictClientGating && _missingClientRatesByItem.isNotEmpty;
    final bool canGenerate =
        selectionPresent && !_hasMissingBaseRates && !hasClientGatingIssues;
    final bool isLoading = invoiceState == InvoiceGenerationState.loading ||
        _isValidatingPriceCaps;
    // Selected invoice period state
    // Defaults: null -> service will use its fallback
    DateTime? startDateLocal = _selectedStartDate;
    DateTime? endDateLocal = _selectedEndDate;

    return ModernInvoiceCard(
      backgroundColor: ModernInvoiceDesign.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                color: ModernInvoiceDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Text(
                'Generate Invoice',
                style: ModernInvoiceDesign.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          // Base rate preflight summary and actions
          Container(
            padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
            decoration: BoxDecoration(
              color: _hasMissingBaseRates
                  ? ModernInvoiceDesign.error.withValues(alpha: 0.1)
                  : ModernInvoiceDesign.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusSm),
              border: Border.all(
                color: _hasMissingBaseRates
                    ? ModernInvoiceDesign.error.withValues(alpha: 0.1)
                    : ModernInvoiceDesign.success.withValues(alpha: 0.1),
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
                      ? ModernInvoiceDesign.error
                      : ModernInvoiceDesign.success,
                  size: 20,
                ),
                const SizedBox(width: ModernInvoiceDesign.space2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _hasMissingBaseRates
                            ? 'Missing Base Rates Detected'
                            : 'Base Rates Verified',
                        style: ModernInvoiceDesign.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: _hasMissingBaseRates
                              ? ModernInvoiceDesign.error
                              : ModernInvoiceDesign.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Tooltip(
                            message:
                                'We treat fallback sources (base-rate, ndis_default, fallback) as missing\nso you can configure organization/client-specific base rates.\nUse the View Missing Items list to add custom pricing.',
                            child: Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: Color.fromARGB(255, 35, 68, 113),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        _ratesCheckMessage,
                        style: ModernInvoiceDesign.bodySmall.copyWith(
                          color: ModernInvoiceDesign.textSecondary,
                        ),
                      ),
                      const SizedBox(height: ModernInvoiceDesign.space2),
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: ModernInvoiceDesign.space2,
                        runSpacing: 4.0,
                        children: [
                          TextButton.icon(
                            onPressed:
                                _isCheckingRates ? null : _preflightRateCheck,
                            icon: _isCheckingRates
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          _hasMissingBaseRates
                                              ? ModernInvoiceDesign.error
                                              : ModernInvoiceDesign.success),
                                    ),
                                  )
                                : const Icon(Icons.refresh),
                            label: const Text('Re-check Rates'),
                            style: TextButton.styleFrom(
                              foregroundColor: ModernInvoiceDesign.primary,
                              disabledForegroundColor:
                                  ModernInvoiceDesign.textSecondary,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: selectionPresent
                                ? _showMissingRatesModal
                                : null,
                            icon: const Icon(Icons.list_alt_rounded),
                            label: const Text('View Missing Items'),
                            style: TextButton.styleFrom(
                              foregroundColor: ModernInvoiceDesign.primary,
                              disabledForegroundColor:
                                  ModernInvoiceDesign.textSecondary,
                            ),
                          ),
                          if (selectionPresent)
                            TextButton.icon(
                              onPressed: _isCheckingRates
                                  ? null
                                  : _openPriceOverrideView,
                              icon: const Icon(Icons.price_change_rounded),
                              label: const Text('Set Price Overrides'),
                              style: TextButton.styleFrom(
                                foregroundColor: ModernInvoiceDesign.primary,
                                disabledForegroundColor:
                                    ModernInvoiceDesign.textSecondary,
                              ),
                            ),
                          TextButton.icon(
                            onPressed: () {
                              _openOrganizationPricingManagement();
                            },
                            icon: const Icon(Icons.settings_suggest_rounded),
                            label: const Text('Open Pricing Management'),
                            style: TextButton.styleFrom(
                              foregroundColor: ModernInvoiceDesign.primary,
                              disabledForegroundColor:
                                  ModernInvoiceDesign.textSecondary,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              _openPricingConfiguration();
                            },
                            icon: const Icon(Icons.tune_rounded),
                            label: const Text('Set Fallback Rate'),
                            style: TextButton.styleFrom(
                              foregroundColor: ModernInvoiceDesign.primary,
                              disabledForegroundColor:
                                  ModernInvoiceDesign.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: ModernInvoiceDesign.space2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Switch(
                            value: _strictClientGating,
                            activeThumbColor: ModernInvoiceDesign.primary,
                            onChanged: _isCheckingRates
                                ? null
                                : (val) {
                                    setState(() {
                                      _strictClientGating = val;
                                    });
                                    _preflightRateCheck();
                                  },
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              'Require client-specific base rates',
                              style: ModernInvoiceDesign.bodySmall.copyWith(
                                color: ModernInvoiceDesign.textSecondary,
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
          const SizedBox(height: ModernInvoiceDesign.space4),
          // Period selection UI
          Container(
            padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.surface,
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusSm),
              border: Border.all(
                color: ModernInvoiceDesign.border,
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
                      style: ModernInvoiceDesign.headlineSmall,
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
                                        start: startDateLocal,
                                        end: endDateLocal,
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
                      style: TextButton.styleFrom(
                        foregroundColor: ModernInvoiceDesign.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ModernInvoiceDesign.space2),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 18,
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                    const SizedBox(width: ModernInvoiceDesign.space2),
                    Expanded(
                      child: Text(
                        (startDateLocal != null && endDateLocal != null)
                            ? '${_formatDate(startDateLocal)}  —  ${_formatDate(endDateLocal)}'
                            : 'No period selected (using default)',
                        style: ModernInvoiceDesign.bodyMedium.copyWith(
                          color: ModernInvoiceDesign.textSecondary,
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
                        style: TextButton.styleFrom(
                          foregroundColor: ModernInvoiceDesign.primary,
                        ),
                        child: const Text('Clear'),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          if (errorMessage.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.error.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusSm),
                border: Border.all(
                  color: ModernInvoiceDesign.error.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_rounded,
                    color: ModernInvoiceDesign.error,
                    size: 20,
                  ),
                  const SizedBox(width: ModernInvoiceDesign.space2),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: ModernInvoiceDesign.bodySmall.copyWith(
                        color: ModernInvoiceDesign.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ModernInvoiceDesign.space4),
          ],
          const SizedBox(height: ModernInvoiceDesign.space4),
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
                          ModernInvoiceDesign.textOnPrimary,
                        ),
                      ),
                    )
                  : const Icon(Icons.receipt_long_rounded, size: 20),
              label: Text(
                isLoading ? 'Generating...' : 'Generate Invoices',
                style: ModernInvoiceDesign.labelLarge.copyWith(
                  color: ModernInvoiceDesign.textOnPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: isLoading
                    ? ModernInvoiceDesign.primary
                    : ModernInvoiceDesign.neutral300,
                disabledForegroundColor: isLoading
                    ? ModernInvoiceDesign.textOnPrimary
                    : ModernInvoiceDesign.textTertiary,
                backgroundColor: canGenerate
                    ? ModernInvoiceDesign.primary
                    : ModernInvoiceDesign.neutral300,
                foregroundColor: canGenerate
                    ? ModernInvoiceDesign.textOnPrimary
                    : ModernInvoiceDesign.textTertiary,
                padding: const EdgeInsets.symmetric(
                  horizontal: ModernInvoiceDesign.space4,
                  vertical: ModernInvoiceDesign.space4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedPdfsSection(List<String> generatedPdfs) {
    return ModernInvoiceCard(
      backgroundColor: ModernInvoiceDesign.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.file_present_rounded,
                color: ModernInvoiceDesign.primary,
                size: 24,
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Text(
                'Generated Invoices',
                style: ModernInvoiceDesign.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          ...generatedPdfs.asMap().entries.map((entry) {
            final index = entry.key;
            final pdfPath = entry.value;
            final fileName = pdfPath.split('/').last;

            return Container(
              margin: index < generatedPdfs.length - 1
                  ? const EdgeInsets.only(bottom: 8.0)
                  : EdgeInsets.zero,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: ModernInvoiceDesign.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.picture_as_pdf_rounded,
                    color: ModernInvoiceDesign.success,
                    size: 20,
                  ),
                ),
                title: Text(
                  fileName,
                  style: ModernInvoiceDesign.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Tap to view PDF',
                  style: ModernInvoiceDesign.bodySmall.copyWith(
                    color: ModernInvoiceDesign.textSecondary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _viewPdf(pdfPath),
                      icon: Icon(
                        Icons.visibility_rounded,
                        color: ModernInvoiceDesign.primary,
                        size: 20,
                      ),
                      tooltip: 'View PDF',
                    ),
                    IconButton(
                      onPressed: () => _sendInvoices(pdfPath),
                      icon: Icon(
                        Icons.send_rounded,
                        color: ModernInvoiceDesign.primary,
                        size: 20,
                      ),
                      tooltip: 'Send Invoice',
                    ),
                  ],
                ),
                onTap: () => _viewPdf(pdfPath),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFileTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Text(
        type,
        style: ModernInvoiceDesign.bodySmall.copyWith(
          color: ModernInvoiceDesign.primary,
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
        return ModernInvoiceDesign.error;
      case 'doc':
      case 'docx':
        return ModernInvoiceDesign.primary;
      case 'txt':
        return ModernInvoiceDesign.success;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return ModernInvoiceDesign.secondary;
      default:
        return ModernInvoiceDesign.textSecondary;
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
          ),
        );
      }
    }
  }

  /// Validates all invoice line items against NDIS price caps
  /// Returns a list of items that exceed their NDIS price cap
  Future<List<Map<String, dynamic>>> _validateNdisPriceCaps() async {
    final List<Map<String, dynamic>> itemsExceedingCap = [];
    final ApiMethod apiMethod = ApiMethod();

    try {
      if (widget.selectedEmployeesAndClients?.isEmpty == true) {
        return itemsExceedingCap;
      }

      // First, fetch actual client assignments with schedule data
      List<Map<String, dynamic>> clientAssignments = [];

      for (var employee in widget.selectedEmployeesAndClients!) {
        final employeeEmail = employee['employee']?['email'] as String? ?? '';
        final selectedClients = employee['clients'] as List<dynamic>? ?? [];

        if (employeeEmail.isNotEmpty) {
          // Get user assignments for this employee
          final assignments = await apiMethod.getUserAssignments(employeeEmail);

          if (assignments['success'] == true &&
              assignments['assignments'] != null) {
            final assignmentsList = assignments['assignments'] as List<dynamic>;

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

      // Now validate each assignment
      for (final assignment in clientAssignments) {
        final clientEmail =
            assignment['clientEmail'] as String? ?? 'Unknown Client';
        final clientName = assignment['clientName'] as String? ?? clientEmail;

        // Get client state from assignment or fetch client details
        String clientState = assignment['clientState'] as String? ?? '';
        if (clientState.isEmpty &&
            clientEmail.isNotEmpty &&
            clientEmail != 'Unknown Client') {
          try {
            final clientDetails = await apiMethod.getClientDetails(clientEmail);
            if (clientDetails != null && clientDetails['success'] == true) {
              clientState = clientDetails['clientState'] as String? ?? '';
            }
          } catch (e) {
            debugPrint('Error fetching client details for state: $e');
          }
        }
        // Default to NSW if no state found
        if (clientState.isEmpty) {
          clientState = 'NSW';
        }

        final schedule = assignment['schedule'] as List<dynamic>? ?? [];

        // Process each scheduled item
        for (final scheduleItem in schedule) {
          final ndisItem = scheduleItem['ndisItem'] as Map<String, dynamic>?;
          if (ndisItem == null) continue;

          final itemNumber = ndisItem['itemNumber'] as String?;
          final itemName = ndisItem['itemName'] as String?;
          if (itemNumber == null || itemName == null) continue;

          // Get current pricing for this item
          final organizationId = _resolveOrganizationId();

          // Get client ID from assignment for proper pricing lookup
          final clientId = assignment['clientId']?.toString() ?? '';

          final pricingData = await apiMethod.getPricingLookup(
            organizationId,
            itemNumber,
            clientId: clientId.isNotEmpty ? clientId : null,
          );

          // Get NDIS price cap
          final supportItemDetails =
              await apiMethod.getSupportItemDetails(itemNumber);

          // Use same logic as price_override_view.dart:
          // Prefer `customPrice` when custom pricing exists; otherwise fallback to `price`
          double currentPrice = 0.0;
          if (pricingData != null) {
            final num? customPrice = pricingData['customPrice'] as num?;
            final num? price = pricingData['price'] as num?;
            final double? resolved = (customPrice ?? price)?.toDouble();
            if (resolved != null && resolved > 0) {
              currentPrice = double.parse(resolved.toStringAsFixed(2));
            }
          }

          debugPrint(
              'NDIS Cap Validation: Item $itemNumber - customPrice: ${pricingData?['customPrice']}, price: ${pricingData?['price']}, resolved currentPrice: $currentPrice');

          double? ndisCapPrice;
          if (supportItemDetails != null &&
              supportItemDetails['priceCaps'] != null) {
            final priceCaps =
                supportItemDetails['priceCaps'] as Map<String, dynamic>;

            // Try standard provider type first
            if (priceCaps['standard'] != null && priceCaps['standard'] is Map) {
              final standardCaps =
                  priceCaps['standard'] as Map<String, dynamic>;
              if (standardCaps[clientState] != null &&
                  standardCaps[clientState] is num) {
                ndisCapPrice = (standardCaps[clientState] as num).toDouble();
                debugPrint(
                    'NDIS Cap Validation: Found standard cap for $clientState: $ndisCapPrice');
              }
            }

            // If no standard cap, try high-intensity
            if (ndisCapPrice == null &&
                priceCaps['highIntensity'] != null &&
                priceCaps['highIntensity'] is Map) {
              final highIntensityCaps =
                  priceCaps['highIntensity'] as Map<String, dynamic>;
              if (highIntensityCaps[clientState] != null &&
                  highIntensityCaps[clientState] is num) {
                ndisCapPrice =
                    (highIntensityCaps[clientState] as num).toDouble();
                debugPrint(
                    'NDIS Cap Validation: Found highIntensity cap for $clientState: $ndisCapPrice');
              }
            }
          }

          debugPrint(
              'NDIS Cap Validation: Item $itemNumber - currentPrice: $currentPrice, ndisCapPrice: $ndisCapPrice, exceeds: ${ndisCapPrice != null && ndisCapPrice > 0 && currentPrice > ndisCapPrice}');

          // Check if current price exceeds NDIS cap
          if (ndisCapPrice != null &&
              ndisCapPrice > 0 &&
              currentPrice > ndisCapPrice) {
            debugPrint(
                'Item exceeds cap: $itemName - Current: $currentPrice, Cap: $ndisCapPrice');
            itemsExceedingCap.add({
              'itemNumber': itemNumber,
              'itemName': itemName,
              'clientName': clientName,
              'clientEmail': clientEmail,
              'clientState': clientState,
              'currentPrice': currentPrice,
              'ndisCapPrice': ndisCapPrice,
              'excessAmount': currentPrice - ndisCapPrice,
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error validating NDIS price caps: $e');
    }

    debugPrint('Total items exceeding cap: ${itemsExceedingCap.length}');
    return itemsExceedingCap;
  }

  /// Shows a dialog warning user about items exceeding NDIS price caps
  /// Allows user to go back to price override or proceed anyway
  Future<bool> _showNdisPriceCapWarningDialog(
    List<Map<String, dynamic>> itemsExceedingCap,
  ) async {
    bool shouldProceed = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Glassmorphic Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: ModernInvoiceDesign.error.withOpacity(0.1),
                        border: Border(
                          bottom: BorderSide(
                            color: ModernInvoiceDesign.error.withOpacity(0.1),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: ModernInvoiceDesign.error.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.warning_rounded,
                              color: ModernInvoiceDesign.error,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'NDIS Price Cap Exceeded',
                              style: ModernInvoiceDesign.headlineSmall.copyWith(
                                color: ModernInvoiceDesign.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content Area
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The following items exceed NDIS price caps:',
                              style: ModernInvoiceDesign.bodyMedium.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Items List
                            ...itemsExceedingCap.asMap().entries.map((entry) {
                              return _buildExceedingCapItem(
                                  entry.value, entry.key);
                            }).toList(),
                            const SizedBox(height: 24),
                            // Action Guide Box
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: ModernInvoiceDesign.primary
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: ModernInvoiceDesign.primary
                                      .withOpacity(0.1),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'What would you like to do?',
                                    style:
                                        ModernInvoiceDesign.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ModernInvoiceDesign.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildActionOption(
                                    'Go back to adjust prices',
                                    Icons.arrow_back_rounded,
                                  ),
                                  const SizedBox(height: 4),
                                  _buildActionOption(
                                    'Proceed with invoice generation anyway',
                                    Icons.arrow_forward_rounded,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Actions Footer
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black54,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            child: const Text('Go Back'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              shouldProceed = true;
                              Navigator.of(dialogContext).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ModernInvoiceDesign.primary,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Proceed'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return shouldProceed;
  }

  Widget _buildActionOption(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: ModernInvoiceDesign.textSecondary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: ModernInvoiceDesign.bodySmall.copyWith(
              color: ModernInvoiceDesign.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  /// Helper widget to build each item that exceeds NDIS cap
  Widget _buildExceedingCapItem(Map<String, dynamic> item, int index) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (index > 0)
            Divider(color: ModernInvoiceDesign.error.withValues(alpha: 0.1)),
          if (index > 0) const SizedBox(height: 8),
          Text(
            '${item['itemName']} (${item['itemNumber']})',
            style: ModernInvoiceDesign.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Client: ${item['clientName']} (${item['clientState']})',
            style: ModernInvoiceDesign.bodySmall.copyWith(
              color: ModernInvoiceDesign.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Price:',
                    style: ModernInvoiceDesign.labelSmall.copyWith(
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                  ),
                  Text(
                    '\$${(item['currentPrice'] as num).toStringAsFixed(2)}',
                    style: ModernInvoiceDesign.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ModernInvoiceDesign.error,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NDIS Cap:',
                    style: ModernInvoiceDesign.labelSmall.copyWith(
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                  ),
                  Text(
                    '\$${(item['ndisCapPrice'] as num).toStringAsFixed(2)}',
                    style: ModernInvoiceDesign.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ModernInvoiceDesign.success,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Excess:',
                    style: ModernInvoiceDesign.labelSmall.copyWith(
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                  ),
                  Text(
                    '\$${(item['excessAmount'] as num).toStringAsFixed(2)}',
                    style: ModernInvoiceDesign.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ModernInvoiceDesign.warning,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _generateInvoices() async {
    // Show loading state during validation
    setState(() {
      _isValidatingPriceCaps = true;
    });

    try {
      // First, validate NDIS price caps
      final itemsExceedingCap = await _validateNdisPriceCaps();

      // Hide validation loading state
      if (mounted) {
        setState(() {
          _isValidatingPriceCaps = false;
        });
      }

      // If items exceed cap, show warning dialog
      if (itemsExceedingCap.isNotEmpty) {
        final shouldProceed =
            await _showNdisPriceCapWarningDialog(itemsExceedingCap);
        if (!shouldProceed) {
          return; // User chose to go back to price override
        }
      }
    } catch (e) {
      // Hide validation loading state on error
      if (mounted) {
        setState(() {
          _isValidatingPriceCaps = false;
        });
      }
      debugPrint('Error during NDIS price cap validation: $e');
    }

    // The invoice service will handle updating the global state
    // through the providers, so we don't need to set it here

    if (!mounted) return;

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

      if (!mounted) return;

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

  /// Open Pricing Configuration Dashboard to set fallback base rate.
  void _openPricingConfiguration() {
    final orgId = _resolveOrganizationId();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PricingConfigurationView(
          organizationId: orgId,
          adminEmail: widget.email,
          organizationName: widget.organizationName ?? 'Organization',
        ),
      ),
    );
  }

  /// Show modal listing missing base rates and provide quick add actions.
  void _showMissingRatesModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final hasClientIssues =
            _strictClientGating && _missingClientRatesByItem.isNotEmpty;
        final hasAnyMissing = _missingRateItems.isNotEmpty || hasClientIssues;
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: ModernInvoiceDesign.surface,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(ModernInvoiceDesign.radiusLg)),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(ModernInvoiceDesign.space2),
                        decoration: BoxDecoration(
                          color: (hasAnyMissing
                                  ? ModernInvoiceDesign.error
                                  : ModernInvoiceDesign.success)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusSm),
                        ),
                        child: Icon(
                          hasAnyMissing
                              ? Icons.rule_folder_outlined
                              : Icons.check_circle_outline,
                          color: hasAnyMissing
                              ? ModernInvoiceDesign.error
                              : ModernInvoiceDesign.success,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: ModernInvoiceDesign.space2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasAnyMissing
                                  ? 'Missing Base Rates'
                                  : 'Missing Items',
                              style: ModernInvoiceDesign.headlineSmall,
                            ),
                            // Compact refreshing indicator shown while a preserved refresh is running
                            if (_isCheckingRates)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                ModernInvoiceDesign.primary),
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      _ratesCheckMessage.isNotEmpty
                                          ? _ratesCheckMessage
                                          : 'Refreshing pricing…',
                                      style: ModernInvoiceDesign.bodySmall
                                          .copyWith(
                                        color:
                                            ModernInvoiceDesign.textSecondary,
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
                  const SizedBox(height: ModernInvoiceDesign.space4),
                  Wrap(
                    spacing: ModernInvoiceDesign.space2,
                    runSpacing: ModernInvoiceDesign.space2,
                    children: [
                      ModernInvoiceButton(
                        onPressed: _openOrganizationPricingManagement,
                        icon: Icons.settings_suggest_rounded,
                        text: 'Pricing Mgmt',
                        isSecondary: true,
                        isOutlined: true,
                      ),
                      ModernInvoiceButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _openPricingConfiguration();
                        },
                        icon: Icons.tune_rounded,
                        text: 'Set Fallback',
                        isSecondary: true,
                        isOutlined: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: ModernInvoiceDesign.space6),
                  if (!hasAnyMissing) ...[
                    ModernInvoiceCard(
                      backgroundColor:
                          ModernInvoiceDesign.success.withValues(alpha: 0.08),
                      borderRadius:
                          BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: ModernInvoiceDesign.success,
                          ),
                          const SizedBox(width: ModernInvoiceDesign.space2),
                          Expanded(
                            child: Text(
                              'No missing items. All selected items have configured pricing for the current gating settings.',
                              style: ModernInvoiceDesign.bodyMedium.copyWith(
                                color: ModernInvoiceDesign.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space4),
                  ],
                  if (_missingRateItems.isNotEmpty) ...[
                    Text(
                      'Items missing organization base rate (${_missingRateItems.length}):',
                      style: ModernInvoiceDesign.bodyMedium
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space2),
                    ..._missingRateItems.map((itemNumber) => Padding(
                          padding: const EdgeInsets.only(
                              bottom: ModernInvoiceDesign.space2),
                          child: ModernInvoiceCard(
                            backgroundColor: ModernInvoiceDesign.surface,
                            borderRadius: BorderRadius.circular(
                                ModernInvoiceDesign.radiusMd),
                            padding: const EdgeInsets.all(
                                ModernInvoiceDesign.space4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: ModernInvoiceDesign.space2,
                                        runSpacing: 4.0,
                                        children: [
                                          Text(
                                            itemNumber,
                                            softWrap: true,
                                            style: ModernInvoiceDesign.bodyLarge
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          SourceBadge(
                                            source: _itemPricingSource[
                                                    itemNumber] ??
                                                'fallback',
                                            isSmall: true,
                                            tooltip:
                                                'Pricing source for this item',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    ModernInvoiceButton(
                                      onPressed: () =>
                                          _promptAddOrgBaseRate(itemNumber),
                                      text: 'Add Org Rate',
                                      isSmall: true,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height: ModernInvoiceDesign.space2),
                                Text(
                                  _supportItemNames[itemNumber] ??
                                      'Support item name unavailable',
                                  softWrap: true,
                                  style: ModernInvoiceDesign.bodySmall.copyWith(
                                    color: ModernInvoiceDesign.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    const SizedBox(height: ModernInvoiceDesign.space4),
                  ],
                  if (hasClientIssues) ...[
                    Text(
                      'Items missing client-specific base rate:',
                      style: ModernInvoiceDesign.bodyMedium
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space2),
                    ..._missingClientRatesByItem.entries.map((entry) {
                      final itemNumber = entry.key;
                      final clients = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: ModernInvoiceDesign.space2),
                        child: ModernInvoiceCard(
                          backgroundColor: ModernInvoiceDesign.surface,
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusMd),
                          padding:
                              const EdgeInsets.all(ModernInvoiceDesign.space4),
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
                                      style: ModernInvoiceDesign.bodyLarge
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  ModernInvoiceButton(
                                    onPressed: () =>
                                        _promptAddOrgBaseRate(itemNumber),
                                    text: 'Add Org Rate',
                                    isOutlined: true,
                                    isSecondary: true,
                                    isSmall: true,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: ModernInvoiceDesign.space2),
                              Text(
                                _supportItemNames[itemNumber] ??
                                    'Support item name unavailable',
                                softWrap: true,
                                style: ModernInvoiceDesign.bodySmall.copyWith(
                                  color: ModernInvoiceDesign.textSecondary,
                                ),
                              ),
                              const SizedBox(
                                  height: ModernInvoiceDesign.space2),
                              ...clients.map((client) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            client['clientName'] ??
                                                client['clientEmail'] ??
                                                'Unknown Client',
                                            style:
                                                ModernInvoiceDesign.bodySmall,
                                          ),
                                        ),
                                        ModernInvoiceButton(
                                          onPressed: () =>
                                              _promptAddClientBaseRate(
                                                  itemNumber, client),
                                          text: 'Add Client Rate',
                                          isSecondary: true,
                                          isSmall: true,
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
                  const SizedBox(height: ModernInvoiceDesign.space4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: ModernInvoiceDesign.textSecondary,
                      ),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
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

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Organization Base Rate'),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Price (e.g., 65.17)'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final price = double.tryParse(controller.text.trim());
                if (price == null || price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid price'),
                    ),
                  );
                  return;
                }
                try {
                  final api = ApiMethod();
                  await api.saveAsCustomPricing(
                    orgId,
                    itemNumber,
                    price,
                    'fixed',
                    userEmail,
                  );
                  if (mounted) {
                    if (dialogContext.mounted) Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Base rate saved successfully'),
                      ),
                    );
                    // Optimistically update local state to keep remaining items visible
                    setState(() {
                      _itemPricingSource[itemNumber] = 'organization';
                      _missingRateItems.removeWhere((i) => i == itemNumber);
                      _missingClientRatesByItem.remove(itemNumber);
                      _hasMissingBaseRates = _missingRateItems.isNotEmpty ||
                          _missingClientRatesByItem.isNotEmpty;
                    });
                    // Refresh pricing without clearing the existing list
                    _preflightRateCheck(preserveExisting: true);
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to save base rate: $e'),
                      ),
                    );
                  }
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
  Future<void> _promptAddClientBaseRate(
      String itemNumber, Map<String, String> client) async {
    final controller = TextEditingController();
    final orgId = _resolveOrganizationId();
    final clientId = client['clientId'] ?? '';
    final clientName = client['clientName'] ?? client['clientEmail'] ?? '';
    final prefs = SharedPreferencesUtils();
    await prefs.init();
    final userEmail = prefs.getUserEmail() ?? widget.email;

    if (!mounted) return;

    if (clientId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Missing client ID for saving pricing'),
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Add Client Base Rate – $clientName'),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Price (e.g., 65.17)'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final price = double.tryParse(controller.text.trim());
                if (price == null || price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid price'),
                    ),
                  );
                  return;
                }
                try {
                  final api = ApiMethod();
                  await api.saveClientCustomPricing(
                    orgId,
                    clientId,
                    itemNumber,
                    price,
                    'fixed',
                    userEmail,
                  );
                  if (mounted) {
                    if (dialogContext.mounted) Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Client base rate saved successfully'),
                      ),
                    );
                    // Optimistically update local state to keep remaining items visible
                    setState(() {
                      _itemPricingSource[itemNumber] = 'client_specific';
                      final list = _missingClientRatesByItem[itemNumber];
                      if (list != null) {
                        list.removeWhere(
                            (e) => (e['clientId'] ?? '') == clientId);
                        if (list.isEmpty) {
                          _missingClientRatesByItem.remove(itemNumber);
                        } else {
                          _missingClientRatesByItem[itemNumber] = list;
                        }
                      }
                      _hasMissingBaseRates = _missingRateItems.isNotEmpty ||
                          _missingClientRatesByItem.isNotEmpty;
                    });
                    // Refresh pricing without clearing the existing list
                    _preflightRateCheck(preserveExisting: true);
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to save client base rate: $e'),
                      ),
                    );
                  }
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
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending invoices: $e'),
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
          ),
        );
      }
    }
  }
}
