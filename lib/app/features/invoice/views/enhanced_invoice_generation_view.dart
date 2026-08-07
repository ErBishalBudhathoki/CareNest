import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 // StateProvider
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/viewmodels/enhanced_invoice_viewmodel.dart';
import 'package:carenest/app/features/invoice/views/price_override_view.dart'
    hide SourceBadge;
import 'package:carenest/app/features/invoice/widgets/invoice_photo_attachment_widget.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer.dart';
import 'package:carenest/app/features/pricing/views/ndis_pricing_management_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_configuration_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/invoice/widgets/source_badge.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

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
  String? _invoiceType; // 'client' or 'employee' (mandatory)

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

  // Recurring Billing State
  bool _isRecurring = false;
  String _recurrenceFrequency = 'monthly'; // Default

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
  /// - When strict client gating is OFF:
  ///   `client_specific`, `organization`, positive item pricing, or a positive
  ///   organization fallback base rate will satisfy base-rate checks.
  /// - When strict client gating is ON:
  ///   each item/client combination must resolve to a client-specific price.
  /// - Local price overrides satisfy gating for the overridden item.
  /// - In strict mode, a per-client lookup is performed and non-client-specific
  ///   results are flagged missing.
  /// Preflight check for missing base service rates.
  ///
  /// The optional `preserveExisting` parameter allows the UI to retain the
  /// current missing items list while a refresh is in progress (used after
  /// saving prices) to prevent the modal from appearing empty. When false,
  /// the method clears previous results at the start.
  Future<void> _preflightRateCheck({bool preserveExisting = false}) async {
    final l10n = AppLocalizations.of(context)!;
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
            : l10n.preflightRefreshing;
      }
    });

    try {
      final apiMethod = ref.read(app_providers.apiMethodProvider);
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
          _ratesCheckMessage = l10n.preflightNoNdisItems;
        });
        return;
      }

      // Bulk pricing lookup for unique support item numbers
      final pricingMap = await apiMethod.getBulkPricingLookup(
        organizationId,
        supportItemNumbers.toList(),
      );
      final fallbackBaseRate = await apiMethod.getFallbackBaseRate(
        organizationId,
      );
      final hasOrgFallbackBaseRate = (fallbackBaseRate ?? 0) > 0;

      double extractResolvedPrice(Map<String, dynamic>? data) {
        if (data == null) return 0.0;
        final cp = data['customPrice'];
        final p = data['price'];
        if (cp != null && cp.toString().isNotEmpty && cp.toString() != 'null') {
          return double.tryParse(cp.toString()) ?? 0.0;
        }
        if (p != null && p.toString().isNotEmpty && p.toString() != 'null') {
          return double.tryParse(p.toString()) ?? 0.0;
        }
        return 0.0;
      }

      bool isClientSpecificSource(String? source) {
        final s = source?.toLowerCase().trim() ?? '';
        return s == 'client_specific' ||
            s == 'client-specific' ||
            s == 'client';
      }

      final List<String> missingItems = [];
      if (pricingMap != null) {
        for (final itemNumber in supportItemNumbers) {
          final data = pricingMap[itemNumber];
          try {
            final String? src = (data is Map<String, dynamic>)
                ? data['source']?.toString().toLowerCase().trim()
                : null;
            final resolvedPrice = extractResolvedPrice(
                data is Map<String, dynamic> ? data : null);
            final hasConfiguredItemRateSource = src == 'organization' ||
                src == 'client_specific' ||
                src == 'client-specific' ||
                src == 'fallback-base-rate';
            final hasResolvedRate = resolvedPrice > 0;
            final hasUsableRate = hasConfiguredItemRateSource ||
                hasResolvedRate ||
                hasOrgFallbackBaseRate;

            if (!hasUsableRate) {
              missingItems.add(itemNumber);
            }

            // For UI badges, treat configured org fallback as a concrete source.
            _itemPricingSource[itemNumber] = hasOrgFallbackBaseRate &&
                    (src == null || src == 'ndis_default' || src == 'fallback')
                ? 'fallback-base-rate'
                : (src ?? 'missing');
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
              final String? src = data != null
                  ? data['source']?.toString().toLowerCase().trim()
                  : null;
              final clientPrice = extractResolvedPrice(data);
              final hasClientSpecific = isClientSpecificSource(src);
              if (!hasClientSpecific || clientPrice <= 0) {
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
        if (_strictClientGating && missingClientByItem.isNotEmpty) {
          _ratesCheckMessage =
              'Client-specific base rates missing for ${missingClientByItem.length} support item(s).';
        } else if (_hasMissingBaseRates) {
          final previewItems = missingItems.take(3).join(', ');
          _ratesCheckMessage = l10n.missingBaseRatesMessage(
            missingItems.length,
            '$previewItems${missingItems.length > 3 ? '…' : ''}',
          );
        } else {
          _ratesCheckMessage = l10n.preflightSuccess;
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
        _ratesCheckMessage = l10n.preflightError(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final invoiceState = ref.watch(invoiceGenerationStateProvider);
    final errorMessage = ref.watch(invoiceGenerationErrorProvider);
    final generatedPdfs = _dedupePdfPaths(
      ref.watch(generatedInvoicePathsProvider),
    );
    final l10n = AppLocalizations.of(context)!;

    return Theme(
      data: _buildNeoViewTheme(context),
      child: Scaffold(
        appBar: _buildAppBar(l10n),
        body: _buildBody(invoiceState, errorMessage, generatedPdfs, l10n),
      ),
    );
  }

  ThemeData _buildNeoViewTheme(BuildContext context) {
    final base = Theme.of(context);
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
      borderSide: const BorderSide(
        color: BauhausDesign.neoInk,
        width: BauhausDesign.neoInnerBorderWidth,
      ),
    );
    final focusedBorder = defaultBorder.copyWith(
      borderSide: const BorderSide(
        color: BauhausDesign.neoSignal,
        width: BauhausDesign.neoBorderWidth,
      ),
    );
    final errorBorder = defaultBorder.copyWith(
      borderSide: const BorderSide(
        color: BauhausDesign.neoDanger,
        width: BauhausDesign.neoBorderWidth,
      ),
    );

    return base.copyWith(
      iconTheme: base.iconTheme.copyWith(
        color: BauhausDesign.neoSignal,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BauhausDesign.neoPaper,
        labelStyle: BauhausDesign.neoMonoStyle(
          context,
          color: BauhausDesign.neoInk.withOpacity(0.85),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        hintStyle: BauhausDesign.neoMonoStyle(
          context,
          color: BauhausDesign.neoInk.withOpacity(0.55),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        border: defaultBorder,
        enabledBorder: defaultBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return BauhausDesign.neoPaper.withOpacity(0.65);
          }
          return BauhausDesign.neoPaper;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return BauhausDesign.neoInk.withOpacity(0.2);
          }
          if (states.contains(MaterialState.selected)) {
            return BauhausDesign.neoSignal;
          }
          return BauhausDesign.neoPaper;
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return BauhausDesign.neoInk.withOpacity(0.3);
          }
          return BauhausDesign.neoInk;
        }),
        trackOutlineWidth: MaterialStateProperty.all(2.0),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return BauhausDesign.neoInk.withOpacity(0.35);
          }
          if (states.contains(MaterialState.selected)) {
            return BauhausDesign.neoSignal;
          }
          return BauhausDesign.neoInk;
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: BauhausDesign.neoSignal,
          textStyle: BauhausDesign.neoMonoStyle(
            context,
            color: BauhausDesign.neoSignal,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(AppLocalizations l10n) {
    return AppBar(
      foregroundColor: BauhausDesign.textDark,
      backgroundColor: BauhausDesign.surfaceWhite,
      elevation: 0,
      title: Text(
        l10n.generateInvoiceTitle,
        style: BauhausDesign.getTextTheme(context).headlineMedium,
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
              color: BauhausDesign.success,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.price_change,
                  size: 16,
                  color: BauhausDesign.surfaceWhite,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_priceOverrides.length}',
                  style: const TextStyle(
                    color: BauhausDesign.surfaceWhite,
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
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(l10n),
          const SizedBox(height: 24.0),
          _buildConfigurationSection(l10n),
          const SizedBox(height: 24.0),
          _buildAttachmentsSection(l10n),
          const SizedBox(height: 24.0),
          _buildPriceOverrideSection(l10n),
          const SizedBox(height: 24.0),
          _buildRecurringBillingSection(l10n),
          const SizedBox(height: 24.0),
          _buildGenerateSection(invoiceState, errorMessage, l10n),
          if (generatedPdfs.isNotEmpty) ...[
            const SizedBox(height: 24.0),
            _buildGeneratedPdfsSection(generatedPdfs),
          ],
        ],
      ),
    );
  }

  Widget _buildNeoCardShell({required Widget child}) {
    return Container(
      decoration: BauhausDesign.neoCardDecoration(),
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }

  Widget _buildNeoSectionHeading({
    required String title,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BauhausDesign.neoSectionHeaderDecoration(lightShadow: true),
      child: Row(
        children: [
          Icon(icon, color: BauhausDesign.neoPaper, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: BauhausDesign.neoHeadingStyle(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeoSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return _buildNeoCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNeoSectionHeading(title: title, icon: icon),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  TextStyle _neoLabelStyle({
    double fontSize = 12,
    bool muted = false,
    FontWeight weight = FontWeight.w700,
  }) {
    return BauhausDesign.neoMonoStyle(
      context,
      color:
          muted ? BauhausDesign.neoInk.withOpacity(0.65) : BauhausDesign.neoInk,
      fontSize: fontSize,
      fontWeight: weight,
    );
  }

  Widget _buildNeoChoiceTile({
    required String label,
    required bool selected,
    required VoidCallback? onTap,
    double? fixedHeight,
  }) {
    final bool enabled = onTap != null;
    final Color fillColor = selected
        ? BauhausDesign.neoSignal
        : (enabled
            ? BauhausDesign.neoPaper
            : BauhausDesign.neoPaper.withOpacity(0.9));
    final Color borderColor =
        selected ? BauhausDesign.neoInk : BauhausDesign.neoInk.withOpacity(0.6);
    final Color labelColor = selected
        ? BauhausDesign.neoPaper
        : (enabled
            ? BauhausDesign.neoInk
            : BauhausDesign.neoInk.withOpacity(0.65));

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          height: fixedHeight,
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(
              color: borderColor,
              width: BauhausDesign.neoInnerBorderWidth,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: selected ? BauhausDesign.neoPaper : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? BauhausDesign.neoPaper
                        : BauhausDesign.neoInk,
                    width: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: _neoLabelStyle(
                    fontSize: 11,
                    weight: FontWeight.w700,
                  ).copyWith(color: labelColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(AppLocalizations l10n) {
    return _buildNeoCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNeoSectionHeading(
            title: l10n.enhancedInvoiceTitle,
            icon: Icons.receipt_long_rounded,
          ),
          const SizedBox(height: 20),
          Text(
            l10n.enhancedInvoiceSubtitle,
            style: BauhausDesign.neoMonoStyle(
              context,
              color: BauhausDesign.neoInk.withOpacity(0.72),
            ),
          ),
          if (widget.selectedEmployeesAndClients == null ||
              widget.selectedEmployeesAndClients!.isEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BauhausDesign.neoDanger.withOpacity(0.1),
                border: Border.all(
                    color: BauhausDesign.neoInk,
                    width: BauhausDesign.neoInnerBorderWidth),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: BauhausDesign.neoDanger,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.noEmployeesSelected,
                      style: BauhausDesign.neoMonoStyle(
                        context,
                        color: BauhausDesign.neoInk,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (widget.selectedEmployeesAndClients != null &&
              widget.selectedEmployeesAndClients!.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildSelectedEmployeesInfo(l10n),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedEmployeesInfo(AppLocalizations l10n) {
    int totalEmployees = widget.selectedEmployeesAndClients?.length ?? 0;
    int totalClients = 0;

    for (var employee in widget.selectedEmployeesAndClients ?? []) {
      totalClients += (employee['clients'] as List<dynamic>).length;
    }

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BauhausDesign.neoPanelDecoration(),
      child: Row(
        children: [
          const Icon(
            Icons.people_rounded,
            size: 18,
            color: BauhausDesign.primary,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              l10n.selectedEmployeesInfo(
                  totalEmployees,
                  totalEmployees == 1 ? 'employee' : 'employees',
                  totalClients,
                  totalClients == 1 ? 'client' : 'clients'),
              style: BauhausDesign.neoMonoStyle(
                context,
                fontSize: 12,
                color: BauhausDesign.neoInk,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationSection(AppLocalizations l10n) {
    return _buildNeoSectionCard(
      title: l10n.invoiceConfigurationTitle,
      icon: Icons.settings_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInvoiceTypeConfiguration(l10n),
          const SizedBox(height: BauhausDesign.space4),
          _buildTaxConfiguration(l10n),
          const SizedBox(height: BauhausDesign.space4),
          _buildBankDetailsConfiguration(l10n),
          const SizedBox(height: BauhausDesign.space4),
          _buildExpenseConfiguration(l10n),
          const SizedBox(height: BauhausDesign.space4),
          _buildPriceOverrideConfiguration(l10n),
        ],
      ),
    );
  }

  Widget _buildInvoiceTypeConfiguration(AppLocalizations l10n) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.switch_left_rounded,
              color: BauhausDesign.accent,
              size: 20,
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.invoiceTypeTitle,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: BauhausDesign.neoInk,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.invoiceTypeSubtitle,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: BauhausDesign.neoInk.withOpacity(0.65),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space2),
        Row(
          children: [
            _buildNeoChoiceTile(
              label: l10n.invoiceTypeClient,
              selected: _invoiceType == 'client',
              onTap: () {
                setState(() {
                  _invoiceType = 'client';
                  // Client invoices are billed to the organization,
                  // so always use admin bank details.
                  _useAdminBankDetails = true;
                });
                _persistUseAdminPreference(true);
              },
            ),
            _buildNeoChoiceTile(
              label: l10n.invoiceTypeEmployee,
              selected: _invoiceType == 'employee',
              onTap: () {
                setState(() => _invoiceType = 'employee');
              },
            ),
          ],
        ),
        if (_invoiceType == null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: BauhausDesign.error,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    l10n.invoiceTypeWarning,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.error,
                            ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTaxConfiguration(AppLocalizations l10n) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.calculate_rounded,
              color: BauhausDesign.secondary,
              size: 20,
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.includeTaxTitle,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: BauhausDesign.neoInk,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.includeTaxSubtitle,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: BauhausDesign.neoInk.withOpacity(0.65),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            BauhausSwitch(
              value: _showTax,
              variant: BauhausSwitchVariant.secondary,
              onChanged: (value) {
                setState(() {
                  _showTax = value;
                });
              },
            ),
          ],
        ),
        if (_showTax) ...[
          const SizedBox(height: BauhausDesign.space2),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.taxRateLabel,
                  style: _neoLabelStyle(
                    fontSize: 12,
                    weight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: BauhausTextField(
                  controller: _taxRateController,
                  keyboardType: TextInputType.number,
                  hintText: l10n.taxRateHint,
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

  Widget _buildBankDetailsConfiguration(AppLocalizations l10n) {
    final bool lockToAdmin = _invoiceType == 'client';
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.account_balance_rounded,
              color: BauhausDesign.info,
              size: 20,
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.bankDetailsTitle,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: BauhausDesign.neoInk,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.bankDetailsSubtitle,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: BauhausDesign.neoInk.withOpacity(0.65),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space2),
        Row(
          children: [
            _buildNeoChoiceTile(
              label: l10n.bankDetailsEmployee,
              selected: _useAdminBankDetails == false,
              fixedHeight: 62,
              onTap: lockToAdmin
                  ? null
                  : () {
                      setState(() {
                        _useAdminBankDetails = false;
                      });
                      _persistUseAdminPreference(_useAdminBankDetails);
                    },
            ),
            _buildNeoChoiceTile(
              label: "Organization's Bank Account",
              selected: _useAdminBankDetails == true,
              fixedHeight: 62,
              onTap: lockToAdmin
                  ? null
                  : () {
                      setState(() {
                        _useAdminBankDetails = true;
                      });
                      _persistUseAdminPreference(_useAdminBankDetails);
                    },
            ),
          ],
        ),
        if (lockToAdmin) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 14,
                color: BauhausDesign.info,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Client invoices always use Organization Bank Details.',
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildExpenseConfiguration(AppLocalizations l10n) {
    return Row(
      children: [
        const Icon(
          Icons.receipt_rounded,
          color: BauhausDesign.success,
          size: 20,
        ),
        const SizedBox(width: BauhausDesign.space4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.includeExpensesTitle,
                style: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.neoInk,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                l10n.includeExpensesSubtitle,
                style: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.neoInk.withOpacity(0.65),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        BauhausSwitch(
          value: _includeExpenses,
          variant: BauhausSwitchVariant.secondary,
          onChanged: (value) {
            setState(() {
              _includeExpenses = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPriceOverrideConfiguration(AppLocalizations l10n) {
    return Row(
      children: [
        const Icon(
          Icons.price_change_rounded,
          color: BauhausDesign.warning,
          size: 20,
        ),
        const SizedBox(width: BauhausDesign.space4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.allowPriceOverrideTitle,
                style: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.neoInk,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                l10n.allowPriceOverrideSubtitle,
                style: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.neoInk.withOpacity(0.65),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        BauhausSwitch(
          value: _allowPriceOverride,
          variant: BauhausSwitchVariant.secondary,
          onChanged: (value) {
            setState(() {
              _allowPriceOverride = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAttachmentsSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_includeExpenses) ...[
          _buildNeoSectionCard(
            title: l10n.expenseAttachmentsTitle,
            icon: Icons.receipt_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InvoicePhotoAttachmentWidget(
                  onPhotosSelected: (photos) {
                    setState(() {
                      _attachedPhotos = photos;
                    });
                  },
                  initialPhotos: _attachedPhotos,
                  photoDescription: _photoDescription,
                  onDescriptionChanged: (desc) {
                    setState(() {
                      _photoDescription = desc;
                    });
                  },
                  maxPhotos: 5,
                ),
                const SizedBox(height: BauhausDesign.space4),
                _buildAdditionalAttachments(l10n),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
        ],
        if (!_includeExpenses) ...[
          _buildNeoSectionCard(
            title: l10n.attachmentsTitle,
            icon: Icons.attach_file_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: BauhausDesign.space4),
                _buildAdditionalAttachments(l10n),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAdditionalAttachments(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space2),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
              child: const Icon(
                Icons.file_present_rounded,
                size: 20,
                color: BauhausDesign.secondary,
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.additionalFilesTitle,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: BauhausDesign.neoInk,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.additionalFilesSubtitle,
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: BauhausDesign.neoInk.withOpacity(0.65),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space4),
        // Modern Add Files Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: BauhausDesign.accent.withOpacity(0.45),
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            color: BauhausDesign.accent.withOpacity(0.1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _pickAdditionalFiles,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              child: Padding(
                padding: const EdgeInsets.all(BauhausDesign.space6),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space4),
                      decoration: BoxDecoration(
                        color: BauhausDesign.accent.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: BauhausDesign.accent,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    Text(
                      l10n.addFilesButton,
                      style: BauhausDesign.neoHeadingStyle(
                        context,
                        color: BauhausDesign.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      l10n.addFilesSubtitle,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Wrap(
                      spacing: BauhausDesign.space2,
                      children: [
                        _buildFileTypeChip(l10n.fileTypePdf),
                        _buildFileTypeChip(l10n.fileTypeDoc),
                        _buildFileTypeChip(l10n.fileTypeImg),
                        _buildFileTypeChip(l10n.fileTypeTxt),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_additionalAttachments.isNotEmpty) ...[
          const SizedBox(height: BauhausDesign.space4),
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite.withOpacity(0.1),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(
                color: BauhausDesign.neutral.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.attach_file_rounded,
                      size: 16,
                      color: BauhausDesign.info,
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Text(
                      l10n.attachedFilesCountLabel(
                          _additionalAttachments.length),
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space4),
                ...(_additionalAttachments.asMap().entries.map((entry) {
                  final index = entry.key;
                  final file = entry.value;
                  final fileName = file.path.split('/').last;
                  final fileExtension = fileName.split('.').last.toLowerCase();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceWhite,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: BauhausDesign.textDark.withOpacity(0.05),
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
                                .withOpacity(0.1),
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
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                fileExtension.toUpperCase(),
                                style: BauhausDesign.getTextTheme(context)
                                    .bodySmall
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: BauhausDesign.error.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _additionalAttachments.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              color: BauhausDesign.error,
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

  Widget _buildPriceOverrideSection(AppLocalizations l10n) {
    return _buildNeoSectionCard(
      title: l10n.priceOverrideTitle,
      icon: Icons.price_change_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.priceOverrideSubtitle,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          if (_priceOverrides.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(
                  color: BauhausDesign.success.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: BauhausDesign.success,
                    size: 20,
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: Text(
                      l10n.priceOverrideApplied(_priceOverrides.length),
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.success,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
          ],
          SizedBox(
            width: double.infinity,
            child: BauhausActionButton(
              onPressed: widget.selectedEmployeesAndClients?.isNotEmpty == true
                  ? _openPriceOverrideView
                  : null,
              icon: Icons.price_change_rounded,
              text: _priceOverrides.isEmpty
                  ? l10n.setPriceOverridesButton
                  : l10n.updatePriceOverridesButton,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringBillingSection(AppLocalizations l10n) {
    return _buildNeoSectionCard(
      title: 'Recurring Billing',
      icon: Icons.update_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Enable Recurring Billing', // TODO: Add to l10n
                  style: _neoLabelStyle(
                    fontSize: 12,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
              BauhausSwitch(
                value: _isRecurring,
                variant: BauhausSwitchVariant.secondary,
                onChanged: (val) => setState(() => _isRecurring = val),
              ),
            ],
          ),
          if (_isRecurring) ...[
            const SizedBox(height: BauhausDesign.space4),
            DropdownButtonFormField<String>(
              value: _recurrenceFrequency,
              decoration: InputDecoration(
                labelText: 'Frequency', // TODO: Add to l10n
              ),
              items: const [
                DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                DropdownMenuItem(
                    value: 'fortnightly', child: Text('Fortnightly')),
                DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                DropdownMenuItem(value: 'quarterly', child: Text('Quarterly')),
                DropdownMenuItem(value: 'annually', child: Text('Annually')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _recurrenceFrequency = val);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGenerateSection(InvoiceGenerationState invoiceState,
      String errorMessage, AppLocalizations l10n) {
    final bool selectionPresent =
        widget.selectedEmployeesAndClients?.isNotEmpty == true;
    final bool invoiceTypeSelected = _invoiceType != null;
    final bool hasClientGatingIssues =
        _strictClientGating && _missingClientRatesByItem.isNotEmpty;
    final bool canGenerate = selectionPresent &&
        invoiceTypeSelected &&
        !_hasMissingBaseRates;
    final bool isLoading = invoiceState == InvoiceGenerationState.loading ||
        _isValidatingPriceCaps;
    // Selected invoice period state
    // Defaults: null -> service will use its fallback
    DateTime? startDateLocal = _selectedStartDate;
    DateTime? endDateLocal = _selectedEndDate;

    return Container(
      decoration: BauhausDesign.neoCardDecoration(),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BauhausDesign.neoSectionHeaderDecoration(
              backgroundColor: BauhausDesign.neoHighlight,
            ),
            child: Text(
              '3) ${l10n.generateInvoiceTitle.toUpperCase()}',
              style: BauhausDesign.neoHeadingStyle(
                context,
                color: BauhausDesign.neoInk,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Base rate preflight summary and actions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _hasMissingBaseRates
                  ? BauhausDesign.neoDanger.withOpacity(0.08)
                  : BauhausDesign.neoSignal.withOpacity(0.08),
              border: Border.all(
                color: BauhausDesign.neoInk,
                width: BauhausDesign.neoInnerBorderWidth,
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
                      ? BauhausDesign.neoDanger
                      : BauhausDesign.neoSignal,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _hasMissingBaseRates
                            ? l10n.missingItemsDetected
                            : l10n.baseRatesVerified,
                        style: BauhausDesign.neoHeadingStyle(
                          context,
                          fontSize: 14,
                          color: BauhausDesign.neoInk,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Tooltip(
                            message: _strictClientGating
                                ? 'Client-specific rates are required when this switch is ON.'
                                : 'Rate order: client-specific > organization-specific > organization fallback base rate.',
                            child: Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: BauhausDesign.warning,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        _ratesCheckMessage,
                        style: BauhausDesign.neoMonoStyle(
                          context,
                          fontSize: 11,
                          color: BauhausDesign.neoInk.withOpacity(0.75),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
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
                                              ? BauhausDesign.error
                                              : BauhausDesign.success),
                                    ),
                                  )
                                : const Icon(Icons.refresh),
                            label: Text(l10n.recheckRates),
                            style: TextButton.styleFrom(
                              foregroundColor: BauhausDesign.neoSignal,
                              disabledForegroundColor:
                                  BauhausDesign.neoInk.withOpacity(0.35),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: selectionPresent
                                ? _showMissingRatesModal
                                : null,
                            icon: const Icon(Icons.list_alt_rounded),
                            label: Text(l10n.viewMissingItems),
                            style: TextButton.styleFrom(
                              foregroundColor: BauhausDesign.neoSignal,
                              disabledForegroundColor:
                                  BauhausDesign.neoInk.withOpacity(0.35),
                            ),
                          ),
                          if (selectionPresent)
                            TextButton.icon(
                              onPressed: _isCheckingRates
                                  ? null
                                  : _openPriceOverrideView,
                              icon: const Icon(Icons.price_change_rounded),
                              label: Text(l10n.setPriceOverridesButton),
                              style: TextButton.styleFrom(
                                foregroundColor: BauhausDesign.neoSignal,
                                disabledForegroundColor:
                                    BauhausDesign.neoInk.withOpacity(0.35),
                              ),
                            ),
                          TextButton.icon(
                            onPressed: () {
                              _openOrganizationPricingManagement();
                            },
                            icon: const Icon(Icons.settings_suggest_rounded),
                            label: Text(l10n.openPricingManagement),
                            style: TextButton.styleFrom(
                              foregroundColor: BauhausDesign.neoSignal,
                              disabledForegroundColor:
                                  BauhausDesign.neoInk.withOpacity(0.35),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              _openPricingConfiguration();
                            },
                            icon: const Icon(Icons.tune_rounded),
                            label: Text(l10n.setFallbackRate),
                            style: TextButton.styleFrom(
                              foregroundColor: BauhausDesign.neoSignal,
                              disabledForegroundColor:
                                  BauhausDesign.neoInk.withOpacity(0.35),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BauhausSwitch(
                            value: _strictClientGating,
                            variant: BauhausSwitchVariant.secondary,
                            enabled: !_isCheckingRates,
                            onChanged: (val) {
                              setState(() {
                                _strictClientGating = val;
                              });
                              _preflightRateCheck();
                            },
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              l10n.useClientBaseRates,
                              style: BauhausDesign.neoMonoStyle(
                                context,
                                fontSize: 11,
                                color: BauhausDesign.neoInk.withOpacity(0.75),
                                fontWeight: FontWeight.w500,
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
          const SizedBox(height: 16),
          // Period selection UI
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BauhausDesign.neoPanelDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.invoicePeriodTitle,
                      style: BauhausDesign.neoHeadingStyle(
                        context,
                        fontSize: 16,
                        color: BauhausDesign.neoInk,
                        letterSpacing: 0.8,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: isLoading
                          ? null
                          : () async {
                              final picked =
                                  await showBauhausDateRangePicker(
                                context: context,
                                initialStart: startDateLocal,
                                initialEnd: endDateLocal,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() {
                                  _selectedStartDate = picked.start;
                                  _selectedEndDate = picked.end;
                                });
                              }
                            },
                      icon: const Icon(Icons.date_range_rounded),
                      label: Text(l10n.selectPeriodButton),
                      style: TextButton.styleFrom(
                        foregroundColor: BauhausDesign.neoSignal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 18,
                      color: BauhausDesign.neoInk.withOpacity(0.6),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        (startDateLocal != null && endDateLocal != null)
                            ? '${_formatDate(startDateLocal)}  —  ${_formatDate(endDateLocal)}'
                            : l10n.noPeriodSelected,
                        style: BauhausDesign.neoMonoStyle(
                          context,
                          fontSize: 12,
                          color: BauhausDesign.neoInk.withOpacity(0.72),
                          fontWeight: FontWeight.w600,
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
                          foregroundColor: BauhausDesign.neoSignal,
                        ),
                        child: Text(l10n.clearButton),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (errorMessage.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BauhausDesign.neoDanger,
                border: Border.all(
                  color: BauhausDesign.neoInk,
                  width: BauhausDesign.neoBorderWidth,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_rounded,
                    color: BauhausDesign.neoPaper,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: BauhausDesign.neoMonoStyle(
                        context,
                        color: BauhausDesign.neoPaper,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          InkWell(
            onTap: canGenerate && !isLoading ? _generateInvoices : null,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: canGenerate
                    ? BauhausDesign.neoDanger
                    : BauhausDesign.neoInk.withOpacity(0.35),
                border: Border.all(
                  color: BauhausDesign.neoInk,
                  width: BauhausDesign.neoBorderWidth,
                ),
                boxShadow: const [
                  BauhausDesign.shadowNeoButton,
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading) ...[
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: BauhausDesign.neoPaper,
                        strokeWidth: 2.2,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    isLoading ? 'GENERATING PDF...' : 'GENERATE PDF',
                    textAlign: TextAlign.center,
                    style: BauhausDesign.neoHeadingStyle(
                      context,
                      color: BauhausDesign.neoPaper,
                      fontSize: 16,
                    ),
                  ),
                  if (!isLoading) ...[
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.arrow_forward,
                      color: BauhausDesign.neoPaper,
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isLoading) ...[
            const SizedBox(height: 10),
            Text(
              'Generating invoices and PDFs. Please wait...',
              style: BauhausDesign.neoMonoStyle(
                context,
                color: BauhausDesign.neoInk.withOpacity(0.7),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGeneratedPdfsSection(List<String> generatedPdfs) {
    final l10n = AppLocalizations.of(context)!;
    return _buildNeoSectionCard(
      title: l10n.generatedInvoicesTitle,
      icon: Icons.file_present_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (generatedPdfs.isEmpty)
            Text(
              l10n.noInvoicesGenerated,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textMuted,
                  ),
            )
          else
            ...generatedPdfs.asMap().entries.map((entry) {
              final index = entry.key;
              final pdfPath = entry.value;
              final fileName = pdfPath.split('/').last;

              return Container(
                margin: index < generatedPdfs.length - 1
                    ? const EdgeInsets.only(bottom: 8.0)
                    : EdgeInsets.zero,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: BauhausDesign.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.picture_as_pdf_rounded,
                      color: BauhausDesign.success,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    fileName,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  subtitle: Text(
                    l10n.tapToViewPdf,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.textMuted,
                            ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _viewPdf(pdfPath),
                        icon: const Icon(
                          Icons.visibility_rounded,
                          color: BauhausDesign.info,
                          size: 20,
                        ),
                        tooltip: l10n.viewPdfTooltip,
                      ),
                      IconButton(
                        onPressed: () => _sendInvoices(pdfPath),
                        icon: const Icon(
                          Icons.send_rounded,
                          color: BauhausDesign.primary,
                          size: 20,
                        ),
                        tooltip: l10n.sendInvoiceTooltip,
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
        color: BauhausDesign.neutral.withOpacity(0.1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 1,
        ),
      ),
      child: Text(
        type,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: BauhausDesign.textMuted,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  InputDecoration _neoPriceFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: const Icon(
        Icons.attach_money_rounded,
        color: BauhausDesign.accent,
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
        return BauhausDesign.error;
      case 'doc':
      case 'docx':
        return BauhausDesign.primary;
      case 'txt':
        return BauhausDesign.success;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return BauhausDesign.secondary;
      default:
        return BauhausDesign.textMuted;
    }
  }

  Future<void> _pickAdditionalFiles() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
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
            content: Text(l10n.errorPickingFiles(e.toString())),
          ),
        );
      }
    }
  }

  /// Validates all invoice line items against NDIS price caps
  /// Returns a list of items that exceed their NDIS price cap
  Future<List<Map<String, dynamic>>> _validateNdisPriceCaps() async {
    final l10n = AppLocalizations.of(context)!;
    final List<Map<String, dynamic>> itemsExceedingCap = [];
    final apiMethod = ref.read(app_providers.apiMethodProvider);

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
            assignment['clientEmail'] as String? ?? l10n.unknownClient;
        final clientName = assignment['clientName'] as String? ?? clientEmail;

        // Get client state from assignment or fetch client details
        String clientState = assignment['clientState'] as String? ?? '';
        if (clientState.isEmpty &&
            clientEmail.isNotEmpty &&
            clientEmail != l10n.unknownClient) {
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
          clientState =
              'NSW'; // NSW is a data key, but we might want to localize its display elsewhere
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
        final l10n = AppLocalizations.of(context)!;
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
                        color: BauhausDesign.error.withOpacity(0.1),
                        border: Border(
                          bottom: BorderSide(
                            color: BauhausDesign.error.withOpacity(0.1),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: BauhausDesign.error.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.warning_rounded,
                              color: BauhausDesign.error,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              l10n.ndisCapExceededTitle,
                              style: BauhausDesign.getTextTheme(context)
                                  .headlineSmall
                                  ?.copyWith(
                                    color: BauhausDesign.error,
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
                              l10n.ndisCapExceededMessage,
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            // Items List
                            ...itemsExceedingCap.asMap().entries.map((entry) {
                              return _buildExceedingCapItem(
                                  entry.value, entry.key);
                            }),
                            const SizedBox(height: 24),
                            // Action Guide Box
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                    BauhausDesign.neoSignal.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      BauhausDesign.neoSignal.withOpacity(0.25),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.ndisCapActionTitle,
                                    style: BauhausDesign.neoMonoStyle(
                                      context,
                                      color: BauhausDesign.neoSignal,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildActionOption(
                                    l10n.ndisCapActionGoBack,
                                    Icons.arrow_back_rounded,
                                  ),
                                  const SizedBox(height: 4),
                                  _buildActionOption(
                                    l10n.ndisCapActionProceed,
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
                            child: Text(l10n.goBackButton),
                          ),
                          const SizedBox(width: 12),
                          BauhausActionButton(
                            onPressed: () {
                              shouldProceed = true;
                              Navigator.of(dialogContext).pop();
                            },
                            text: l10n.proceedButton,
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
          color: BauhausDesign.textMuted,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
        ),
      ],
    );
  }

  /// Helper widget to build each item that exceeds NDIS cap
  Widget _buildExceedingCapItem(Map<String, dynamic> item, int index) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (index > 0) Divider(color: BauhausDesign.error.withOpacity(0.1)),
          if (index > 0) const SizedBox(height: 8),
          Text(
            l10n.itemInfoTemplate(
              item['itemName'] ?? '',
              item['itemNumber'] ?? '',
            ),
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.clientInfoTemplate(
              item['clientName'] ?? l10n.unknownClient,
              item['clientState'] ?? '',
            ),
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
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
                    l10n.currentPriceLabel,
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                        ),
                  ),
                  Text(
                    l10n.priceDisplay(
                      l10n.currencySymbol,
                      (item['currentPrice'] as num).toStringAsFixed(2),
                    ),
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.error,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.ndisCapLabel,
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                        ),
                  ),
                  Text(
                    l10n.priceDisplay(
                      l10n.currencySymbol,
                      (item['ndisCapPrice'] as num).toStringAsFixed(2),
                    ),
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.success,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.excessLabel,
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                        ),
                  ),
                  Text(
                    l10n.priceDisplay(
                      l10n.currencySymbol,
                      (item['excessAmount'] as num).toStringAsFixed(2),
                    ),
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.warning,
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
    HapticFeedback.selectionClick();

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
      final effectiveUseAdminBankDetails =
          _invoiceType == 'client' ? true : _useAdminBankDetails;
      debugPrint("Tax rate in UI: $_taxRate");
      final l10n = AppLocalizations.of(context)!;
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.generatingInvoices),
          duration: const Duration(seconds: 10),
        ),
      );

      final generatedPaths = await viewModel.generateInvoices(
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
        useAdminBankDetails: effectiveUseAdminBankDetails,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
        invoiceType: _invoiceType,
        recurrence: _isRecurring
            ? {
                'isRecurring': true,
                'frequency': _recurrenceFrequency,
              }
            : null,
      );

      if (!mounted) return;
      messenger.hideCurrentSnackBar();
      if (generatedPaths.isNotEmpty) {
        HapticFeedback.lightImpact();
        messenger.showSnackBar(
          SnackBar(
            content: Text('Generated ${generatedPaths.length} invoice PDF(s).'),
          ),
        );
      } else {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.noInvoicesGenerated),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      final errorMsg = e.toString();
      if (errorMsg.contains('BANK_DETAILS_NOT_FOUND')) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.bankDetailsMissingTitle),
            content: Text(l10n.bankDetailsMissingMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.okButton),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorGeneratingInvoices(e.toString())),
          ),
        );
      }
    }
  }

  List<String> _dedupePdfPaths(List<String> paths) {
    final seen = <String>{};
    final deduped = <String>[];
    for (final path in paths) {
      final normalized = path.trim();
      if (normalized.isEmpty) continue;
      if (seen.add(normalized)) {
        deduped.add(normalized);
      }
    }
    return deduped;
  }

  // Local state for date range selection
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  String _formatDate(DateTime dt) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null)
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    return DateFormat.yMd(Localizations.localeOf(context).toString())
        .format(dt);
  }

  Future<void> _openPriceOverrideView() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      // Fetch actual client assignments with schedule data
      List<Map<String, dynamic>> clientAssignments = [];

      if (widget.selectedEmployeesAndClients != null) {
        for (var employee in widget.selectedEmployeesAndClients!) {
          final employeeEmail = employee['employee']?['email'] as String? ?? '';
          final selectedClients = employee['clients'] as List<dynamic>? ?? [];

          if (employeeEmail.isNotEmpty) {
            // Get user assignments for this employee
            final apiMethod = ref.read(app_providers.apiMethodProvider);
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
              content: Text(l10n.priceOverrideApplied(result.length)),
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
            content: Text(l10n.errorLoadingAssignmentsError(e.toString())),
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
    final l10n = AppLocalizations.of(context)!;
    final orgId = _resolveOrganizationId();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PricingConfigurationView(
          organizationId: orgId,
          adminEmail: widget.email,
          organizationName:
              widget.organizationName ?? l10n.organizationFallback,
        ),
      ),
    );
  }

  /// Show modal listing missing base rates and provide quick add actions.
  void _showMissingRatesModal() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final hasClientIssues =
            _strictClientGating && _missingClientRatesByItem.isNotEmpty;
        final hasAnyMissing = _missingRateItems.isNotEmpty || hasClientIssues;
        final int totalIssues =
            _missingRateItems.length + _missingClientRatesByItem.length;

        return DraggableScrollableSheet(
          initialChildSize: 0.78,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: BauhausDesign.neoPaper,
                border: Border(
                  top: BorderSide(
                    color: BauhausDesign.neoInk,
                    width: BauhausDesign.neoBorderWidth,
                  ),
                  left: BorderSide(
                    color: BauhausDesign.neoInk,
                    width: BauhausDesign.neoBorderWidth,
                  ),
                  right: BorderSide(
                    color: BauhausDesign.neoInk,
                    width: BauhausDesign.neoBorderWidth,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // ── Drag Handle ──
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    color: BauhausDesign.neoPaper,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: BauhausDesign.neoInk.withOpacity(0.3),
                          border: Border.all(
                            color: BauhausDesign.neoInk.withOpacity(0.15),
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ── Header Stripe ──
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    decoration: BauhausDesign.neoSectionHeaderDecoration(
                      backgroundColor: hasAnyMissing
                          ? BauhausDesign.neoHighlight
                          : BauhausDesign.neoSignal,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          hasAnyMissing
                              ? Icons.rule_folder_outlined
                              : Icons.verified_outlined,
                          color: hasAnyMissing
                              ? BauhausDesign.neoInk
                              : BauhausDesign.neoPaper,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            (hasAnyMissing
                                    ? l10n.missingBaseRatesTitle
                                    : l10n.missingItemsTitle)
                                .toUpperCase(),
                            style: BauhausDesign.neoHeadingStyle(
                              context,
                              color: hasAnyMissing
                                  ? BauhausDesign.neoInk
                                  : BauhausDesign.neoPaper,
                              fontSize: 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        // Refreshing indicator
                        if (_isCheckingRates)
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                hasAnyMissing
                                    ? BauhausDesign.neoInk
                                    : BauhausDesign.neoPaper,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // ── Status Bar ──
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: BauhausDesign.neoInk,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: hasAnyMissing
                                ? BauhausDesign.neoDanger
                                : BauhausDesign.success,
                            border: Border.all(
                              color: BauhausDesign.neoPaper.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            hasAnyMissing
                                ? '$totalIssues MISSING'
                                : 'ALL CLEAR',
                            style: BauhausDesign.neoMonoStyle(
                              context,
                              color: BauhausDesign.neoPaper,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (_isCheckingRates && _ratesCheckMessage.isNotEmpty)
                          Expanded(
                            child: Text(
                              _ratesCheckMessage,
                              style: BauhausDesign.neoMonoStyle(
                                context,
                                color: BauhausDesign.neoPaper.withOpacity(0.7),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        else
                          Expanded(
                            child: Text(
                              hasAnyMissing
                                  ? 'Items need base rate configuration'
                                  : 'All items have valid pricing',
                              style: BauhausDesign.neoMonoStyle(
                                context,
                                color: BauhausDesign.neoPaper.withOpacity(0.7),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // ── Scrollable Content ──
                  Expanded(
                    child: ListView(
                      controller: controller,
                      padding: const EdgeInsets.all(20),
                      children: [
                        // ── Quick Actions Row ──
                        Row(
                          children: [
                            Expanded(
                              child: _neoModalActionTile(
                                icon: Icons.settings_suggest_rounded,
                                label: l10n.pricingManagement,
                                onTap: _openOrganizationPricingManagement,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _neoModalActionTile(
                                icon: Icons.tune_rounded,
                                label: l10n.setFallbackRate,
                                onTap: () {
                                  Navigator.pop(context);
                                  _openPricingConfiguration();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // ── All Clear State ──
                        if (!hasAnyMissing) ...[
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: BauhausDesign.success.withOpacity(0.08),
                              border: Border.all(
                                color: BauhausDesign.neoInk,
                                width: BauhausDesign.neoInnerBorderWidth,
                              ),
                              boxShadow: const [
                                BauhausDesign.shadowHardSm,
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: BauhausDesign.success,
                                    border: Border.all(
                                      color: BauhausDesign.neoInk,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: BauhausDesign.neoPaper,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.preflightSuccess,
                                        style: BauhausDesign.neoMonoStyle(
                                          context,
                                          color: BauhausDesign.textDark,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Ready to generate invoices',
                                        style: BauhausDesign.neoMonoStyle(
                                          context,
                                          color: BauhausDesign.textMuted,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // ── Organization Missing Rates Section ──
                        if (_missingRateItems.isNotEmpty) ...[
                          _neoSectionDivider(
                            label:
                                'ORG RATES — ${_missingRateItems.length} MISSING',
                            color: BauhausDesign.neoDanger,
                          ),
                          const SizedBox(height: 12),
                          ..._missingRateItems.map(
                            (itemNumber) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: BauhausDesign.neoPaper,
                                  border: Border.all(
                                    color: BauhausDesign.neoInk,
                                    width: BauhausDesign.neoInnerBorderWidth,
                                  ),
                                  boxShadow: const [
                                    BauhausDesign.shadowHardXs,
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Red accent bar
                                        Container(
                                          width: 4,
                                          height: 32,
                                          color: BauhausDesign.neoDanger,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      itemNumber,
                                                      style: BauhausDesign
                                                          .neoMonoStyle(
                                                        context,
                                                        color: BauhausDesign
                                                            .textDark,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  SourceBadge(
                                                    source:
                                                        _itemPricingSource[
                                                                itemNumber] ??
                                                            'fallback',
                                                    isSmall: true,
                                                    tooltip: l10n
                                                        .pricingSourceTooltip,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                _supportItemNames[itemNumber] ??
                                                    l10n
                                                        .supportItemNameUnavailable,
                                                style: BauhausDesign
                                                    .neoMonoStyle(
                                                  context,
                                                  color:
                                                      BauhausDesign.textMuted,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        _neoSmallActionButton(
                                          label: l10n.addOrgRateButton,
                                          onTap: () => _promptAddOrgBaseRate(
                                              itemNumber),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // ── Client-Specific Missing Rates Section ──
                        if (hasClientIssues) ...[
                          _neoSectionDivider(
                            label:
                                'CLIENT RATES — ${_missingClientRatesByItem.length} ITEMS',
                            color: BauhausDesign.warning,
                          ),
                          const SizedBox(height: 12),
                          ..._missingClientRatesByItem.entries.map((entry) {
                            final itemNumber = entry.key;
                            final clients = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: BauhausDesign.neoPaper,
                                  border: Border.all(
                                    color: BauhausDesign.neoInk,
                                    width: BauhausDesign.neoInnerBorderWidth,
                                  ),
                                  boxShadow: const [
                                    BauhausDesign.shadowHardXs,
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Item header
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: BauhausDesign.neoHighlight
                                            .withOpacity(0.12),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: BauhausDesign.neoInk
                                                .withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 4,
                                            height: 28,
                                            color: BauhausDesign.neoHighlight,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  itemNumber,
                                                  style: BauhausDesign
                                                      .neoMonoStyle(
                                                    context,
                                                    color: BauhausDesign
                                                        .textDark,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  _supportItemNames[
                                                          itemNumber] ??
                                                      l10n
                                                          .supportItemNameUnavailable,
                                                  style: BauhausDesign
                                                      .neoMonoStyle(
                                                    context,
                                                    color: BauhausDesign
                                                        .textMuted,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          _neoSmallActionButton(
                                            label: l10n.addOrgRateButton,
                                            onTap: () =>
                                                _promptAddOrgBaseRate(
                                                    itemNumber),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Client rows
                                    ...clients.map(
                                      (client) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: BauhausDesign.neoInk
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person_outline,
                                              size: 16,
                                              color: BauhausDesign.textMuted,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                client['clientName'] ??
                                                    client['clientEmail'] ??
                                                    l10n.unknownClient,
                                                style: BauhausDesign
                                                    .neoMonoStyle(
                                                  context,
                                                  color:
                                                      BauhausDesign.textDark,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            _neoSmallActionButton(
                                              label:
                                                  l10n.addClientRateButton,
                                              onTap: () =>
                                                  _promptAddClientBaseRate(
                                                      itemNumber, client),
                                              compact: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],

                        const SizedBox(height: 20),

                        // ── Close Button ──
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: BauhausDesign.neoInk,
                            boxShadow: const [BauhausDesign.shadowHardSm],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: Center(
                                  child: Text(
                                    l10n.closeButton.toUpperCase(),
                                    style: BauhausDesign.neoMonoStyle(
                                      context,
                                      color: BauhausDesign.neoPaper,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  /// Neo-brutalism section divider with accent color and label
  Widget _neoSectionDivider({required String label, required Color color}) {
    return Row(
      children: [
        Container(width: 24, height: 3, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: BauhausDesign.neoMonoStyle(
            context,
            color: BauhausDesign.textDark,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1.5,
            color: BauhausDesign.neoInk.withOpacity(0.15),
          ),
        ),
      ],
    );
  }

  /// Neo-brutalism action tile for modal quick actions
  Widget _neoModalActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: BauhausDesign.neoPaper,
            border: Border.all(
              color: BauhausDesign.neoInk,
              width: BauhausDesign.neoInnerBorderWidth,
            ),
            boxShadow: const [BauhausDesign.shadowHardXs],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: BauhausDesign.neoSignal),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: BauhausDesign.neoMonoStyle(
                    context,
                    color: BauhausDesign.textDark,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Neo-brutalism compact action button for item rows
  Widget _neoSmallActionButton({
    required String label,
    required VoidCallback onTap,
    bool compact = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 8 : 10,
            vertical: compact ? 4 : 6,
          ),
          decoration: BoxDecoration(
            color: BauhausDesign.neoSignal,
            border: Border.all(
              color: BauhausDesign.neoInk,
              width: 1.5,
            ),
          ),
          child: Text(
            label,
            style: BauhausDesign.neoMonoStyle(
              context,
              color: BauhausDesign.neoPaper,
              fontSize: compact ? 9 : 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  /// Prompt for entering an organization-wide base rate for an item and save it.
  Future<void> _promptAddOrgBaseRate(String itemNumber) async {
    final l10n = AppLocalizations.of(context)!;
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
          title: Text(l10n.addOrgBaseRateTitle),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            cursorColor: BauhausDesign.neoSignal,
            style: BauhausDesign.neoMonoStyle(
              context,
              color: BauhausDesign.neoInk,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            decoration: _neoPriceFieldDecoration(l10n.priceFieldLabel),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () async {
                final price = double.tryParse(controller.text.trim());
                if (price == null || price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.invalidPriceError),
                    ),
                  );
                  return;
                }
                try {
                  final api = ref.read(app_providers.apiMethodProvider);
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
                      SnackBar(
                        content: Text(l10n.baseRateSaveSuccess),
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
                        content: Text(l10n.baseRateSaveError(e.toString())),
                      ),
                    );
                  }
                }
              },
              child: Text(l10n.saveButton),
            ),
          ],
        );
      },
    );
  }

  /// Prompt for entering a client-specific base rate and save it.
  Future<void> _promptAddClientBaseRate(
      String itemNumber, Map<String, String> client) async {
    final l10n = AppLocalizations.of(context)!;
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
        SnackBar(
          content: Text(l10n.missingClientIdError),
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.addClientBaseRateTitle(clientName)),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            cursorColor: BauhausDesign.neoSignal,
            style: BauhausDesign.neoMonoStyle(
              context,
              color: BauhausDesign.neoInk,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            decoration: _neoPriceFieldDecoration(l10n.priceFieldLabel),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () async {
                final price = double.tryParse(controller.text.trim());
                if (price == null || price <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.invalidPriceError),
                    ),
                  );
                  return;
                }
                try {
                  final api = ref.read(app_providers.apiMethodProvider);
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
                      SnackBar(
                        content: Text(l10n.clientBaseRateSaveSuccess),
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
                        content:
                            Text(l10n.clientBaseRateSaveError(e.toString())),
                      ),
                    );
                  }
                }
              },
              child: Text(l10n.saveButton),
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
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                result ? l10n.invoicesSentSuccess : l10n.invoicesSentError),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorSendingInvoices(e.toString())),
          ),
        );
      }
    }
  }

  Future<void> _viewPdf(String pdfPath) async {
    try {
      // Find the corresponding invoice data to extract receipt URLs
      final state = ref.read(enhancedInvoiceViewModelProvider);
      List<String> receiptUrls = [];

      // Try to find the invoice that matches this PDF path
      // The paths in state.generatedPdfPaths should align with state.invoices
      final index = state.generatedPdfPaths.indexOf(pdfPath);
      if (index != -1 && index < state.invoices.length) {
        final invoiceData = state.invoices[index];
        debugPrint(
            'Found invoice data for PDF $pdfPath at index $index. Extracting receipts...');

        // Extract receipts logic (similar to InvoiceListModel)
        try {
          final expenses = invoiceData['expenses'] as List<dynamic>?;
          if (expenses != null) {
            for (var expense in expenses) {
              if (expense is Map<String, dynamic>) {
                final receiptFiles = expense['receiptFiles'] as List?;
                final receiptPhotos = expense['receiptPhotos'] as List?;
                final receiptUrl = expense['receiptUrl'] as String?;

                String? resolveToDownloadUrl(String value) {
                  final resolved = AppConfig.resolveResourceUrl(value);
                  if (!(resolved.startsWith('http://') ||
                      resolved.startsWith('https://'))) {
                    return null;
                  }
                  try {
                    if (AppConfig.isPrivateR2StorageUrl(resolved)) {
                      return AppConfig.buildFilesProxyUrl(resolved);
                    }
                    return AppConfig.buildFilesDownloadUrl(resolved);
                  } catch (_) {
                    return resolved;
                  }
                }

                if (receiptFiles != null) {
                  for (var file in receiptFiles) {
                    if (file is String && file.trim().isNotEmpty) {
                      final fullUrl = resolveToDownloadUrl(file.trim());
                      if (fullUrl != null) receiptUrls.add(fullUrl);
                    }
                  }
                }

                if (receiptPhotos != null) {
                  for (var photo in receiptPhotos) {
                    if (photo is String && photo.trim().isNotEmpty) {
                      final fullUrl = resolveToDownloadUrl(photo.trim());
                      if (fullUrl != null) receiptUrls.add(fullUrl);
                    }
                  }
                }

                if (receiptUrl != null && receiptUrl.trim().isNotEmpty) {
                  final fullUrl = resolveToDownloadUrl(receiptUrl.trim());
                  if (fullUrl != null) receiptUrls.add(fullUrl);
                }
              }
            }
          }
        } catch (e) {
          debugPrint('Error extracting receipts in _viewPdf: $e');
        }
      }

      // Remove duplicates
      receiptUrls = receiptUrls.toSet().toList();
      debugPrint(
          'Passing ${receiptUrls.length} receipt URLs to PDF Viewer: $receiptUrls');

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewPage(
            pdfPath: pdfPath,
            receiptUrls: receiptUrls,
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorViewingPdf(e.toString())),
          ),
        );
      }
    }
  }
}
