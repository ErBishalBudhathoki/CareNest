import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/features/invoice/presentation/widgets/price_prompt_dialog.dart';
import 'package:carenest/app/features/pricing/views/pricing_configuration_view.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// NDIS Pricing Management View for the Pricing Management Dashboard
/// Allows users to view, search, and manage custom pricing for NDIS items
class NdisPricingManagementView extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? adminEmail;
  final String? organizationName;

  /// Optional client ID. When provided, saving custom pricing will be
  /// applied specifically to this client rather than organization-wide.
  final String? clientId;

  const NdisPricingManagementView({
    super.key,
    this.organizationId,
    this.adminEmail,
    this.organizationName,
    this.clientId,
  });

  @override
  ConsumerState<NdisPricingManagementView> createState() =>
      _NdisPricingManagementViewState();
}

class _NdisPricingManagementViewState
    extends ConsumerState<NdisPricingManagementView> {
  late final NDISMatcher _ndisMatcher;
  late final ApiMethod _apiMethod;
  final SharedPreferencesUtils _sharedPrefs = SharedPreferencesUtils();
  final TextEditingController _searchController = TextEditingController();

  List<NDISItem> _allNdisItems = [];
  List<NDISItem> _filteredNdisItems = [];
  final Map<String, Map<String, dynamic>> _pricingData = {};
  bool _isLoading = true;
  String _searchQuery = '';
  String _userState = 'NSW'; // Default state
  String _selectedFilter =
      'All'; // Filter options: All, Custom Pricing, Standard Pricing, High Intensity
  String _selectedStateFilter =
      'All'; // State filter options: All, NSW, VIC, QLD, WA, SA, TAS, ACT, NT

  // Price override controls
  final Map<String, TextEditingController> _priceControllers = {};
  final Map<String, bool> _showPriceOverride = {};
  final Map<String, bool> _isCustomPriceEnabled = {};
  final Map<String, bool> _isSavingPrice = {};

  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(app_providers.apiMethodProvider);
    _ndisMatcher = NDISMatcher(apiMethod: _apiMethod);
    _initializeUserState();
    _loadNdisItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    // Dispose all price controllers
    for (final controller in _priceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Initialize user state from preferences
  Future<void> _initializeUserState() async {
    await _sharedPrefs.init();
    final state = _sharedPrefs.getString('userState') ?? 'NSW';
    setState(() {
      _userState = state;
    });
  }

  /// Load NDIS items and their pricing data
  Future<void> _loadNdisItems() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await _ndisMatcher.loadItems();
      setState(() {
        _allNdisItems = _ndisMatcher.items;
        _filteredNdisItems = _allNdisItems;
      });

      // Load pricing data for all items
      await _loadPricingData();

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e, s) {
      log.severe(
          "Failed to load NDIS items in NdisPricingManagementView", e, s);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showSnackBar(AppLocalizations.of(context)!.failedToLoadNdisItems,
            isError: true);
      }
    }
  }

  /// Load pricing data for all NDIS items using bulk lookup
  Future<void> _loadPricingData() async {
    if (widget.organizationId == null) return;

    try {
      // Get all item numbers for bulk lookup
      final allItemNumbers =
          _allNdisItems.map((item) => item.itemNumber).toList();
      log.info("Loading pricing data for ${allItemNumbers.length} items");

      // Use bulk pricing lookup to get all custom pricing data at once
      final bulkPricingData = await _apiMethod.getBulkPricingLookup(
        widget.organizationId!,
        allItemNumbers,
      );

      log.info(
          "Bulk pricing data received: ${bulkPricingData?.keys.length ?? 0} items with custom pricing");

      // Initialize pricing data with custom pricing for all items
      if (bulkPricingData != null && bulkPricingData.isNotEmpty) {
        for (final itemNumber in bulkPricingData.keys) {
          final customPricingData = bulkPricingData[itemNumber];
          if (customPricingData != null && mounted) {
            setState(() {
              _pricingData[itemNumber] = {
                'customPricing': customPricingData,
                'supportItem': null, // Will be loaded when needed
              };
            });
            log.fine(
                "Loaded custom pricing for item $itemNumber: ${customPricingData['price']}");
          }
        }
      } else {
        log.info(
            "No custom pricing data found for organization ${widget.organizationId}");
      }

      // Load support item details for the first 50 items to start with
      for (final item in _allNdisItems.take(50)) {
        if (!mounted) break; // Exit early if widget is disposed

        final supportItemDetails =
            await _apiMethod.getSupportItemDetails(item.itemNumber);

        if (mounted) {
          setState(() {
            _pricingData[item.itemNumber] = {
              ...(_pricingData[item.itemNumber] ?? {}),
              'supportItem': supportItemDetails,
            };
          });
        }
      }
    } catch (e) {
      log.warning("Failed to load pricing data: $e");
    }
  }

  /// Filter NDIS items based on search query and filter type
  void _filterNdisItems(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  /// Apply search and filter criteria
  void _applyFilters() {
    List<NDISItem> filtered = _allNdisItems;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final lowerQuery = _searchQuery.toLowerCase();
      filtered = filtered.where((item) {
        return item.itemNumber.toLowerCase().contains(lowerQuery) ||
            item.itemName.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    // Apply pricing filter
    if (_selectedFilter != 'All') {
      log.info("Applying pricing filter: $_selectedFilter");

      filtered = filtered.where((item) {
        // Handle High Intensity filter
        if (_selectedFilter == 'High Intensity') {
          return _isHighIntensityItem(item);
        }

        final pricingData = _pricingData[item.itemNumber];

        // Check if item has actual custom pricing (not just base rate pricing)
        // Custom pricing should have a 'source' field that is NOT 'base-rate'
        bool hasCustomPricing = false;
        if (pricingData?['customPricing'] != null) {
          final customPricing = pricingData!['customPricing'];
          final source = customPricing['source'];
          hasCustomPricing = source != null && source != 'base-rate';
        }

        // Debug logging for first few items
        if (filtered.indexOf(item) < 5) {
          log.info(
              "Item ${item.itemNumber}: hasCustomPricing=$hasCustomPricing, pricingData=${pricingData != null ? 'exists' : 'null'}");
          if (pricingData != null && pricingData['customPricing'] != null) {
            final customPricing = pricingData['customPricing'];
            log.info(
                "  customPricing source: ${customPricing['source']}, price: ${customPricing['price']}, shouldInclude: ${_selectedFilter == 'Custom Pricing' ? hasCustomPricing : !hasCustomPricing}");
          }
        }

        final shouldInclude = _selectedFilter == 'Custom Pricing'
            ? hasCustomPricing
            : !hasCustomPricing;
        return shouldInclude;
      }).toList();

      log.info(
          "After pricing filter: ${filtered.length} items (filter: $_selectedFilter)");
    }

    // Apply state filter - only filter if we have support item data or if filtering for custom pricing
    if (_selectedStateFilter != 'All') {
      filtered = filtered.where((item) {
        final pricingData = _pricingData[item.itemNumber];

        // Check if item has actual custom pricing (not base rate)
        bool hasActualCustomPricing = false;
        if (pricingData?['customPricing'] != null) {
          final customPricing = pricingData!['customPricing'];
          final source = customPricing['source'];
          hasActualCustomPricing = source != null && source != 'base-rate';
        }

        // If filtering for custom pricing and item has actual custom pricing, don't apply state filter (custom pricing is organization-wide)
        if (_selectedFilter == 'Custom Pricing' && hasActualCustomPricing) {
          return true;
        }

        // For standard pricing, check if item has pricing for the selected state
        if (pricingData?['supportItem'] != null) {
          final supportItem = pricingData!['supportItem'];
          final priceCaps = supportItem['priceCaps'];
          if (priceCaps != null) {
            final statePrices = priceCaps['standard'];
            return statePrices != null &&
                statePrices[_selectedStateFilter] != null;
          }
        }

        // If no support item data available yet, include the item (will be loaded on demand)
        return true;
      }).toList();
    }

    setState(() {
      _filteredNdisItems = filtered;
    });

    // Load support item details for newly filtered items if needed
    _loadSupportItemDetailsForFilteredItems();
  }

  /// Load support item details for filtered items that don't have them yet
  Future<void> _loadSupportItemDetailsForFilteredItems() async {
    if (widget.organizationId == null) return;

    try {
      for (final item in _filteredNdisItems.take(50)) {
        if (!mounted) break; // Exit early if widget is disposed

        // Only load if we don't already have support item details
        if (_pricingData[item.itemNumber]?['supportItem'] == null) {
          final supportItemDetails =
              await _apiMethod.getSupportItemDetails(item.itemNumber);

          if (mounted) {
            setState(() {
              _pricingData[item.itemNumber] = {
                ..._pricingData[item.itemNumber] ?? {},
                'supportItem': supportItemDetails,
              };
            });
          }
        }
      }
    } catch (e) {
      log.warning("Failed to load support item details: $e");
    }
  }

  /// Get standard NDIS cap for an item (metadata only; not used as rate)
  double _getStandardPrice(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    if (pricingData?['supportItem'] != null) {
      final supportItem = pricingData!['supportItem'];
      final priceCaps = supportItem['priceCaps'];
      if (priceCaps != null) {
        final statePrices = priceCaps['standard'];
        // Use selected state filter if not 'All', otherwise use user's default state
        final targetState =
            _selectedStateFilter != 'All' ? _selectedStateFilter : _userState;
        if (statePrices != null && statePrices[targetState] != null) {
          return (statePrices[targetState] as num).toDouble();
        }
      }
    }
    // No standard price for selected state or missing support item details
    // Return 0.0 to avoid silent use of a dummy $30 rate
    return 0.0;
  }

  /// Get current billable price (custom only) for an item
  double _getCurrentPrice(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    if (pricingData?['customPricing'] != null) {
      final customPricing = pricingData!['customPricing'];
      final source = customPricing['source'];

      // Only use custom pricing if it's not base rate
      if (source != null && source != 'base-rate') {
        return (customPricing['price'] as num?)?.toDouble() ?? 0.0;
      }
    }
    // No custom pricing set; do not use NDIS cap as rate
    return 0.0;
  }

  /// Get pricing source description for display
  String _getPricingSource(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    if (pricingData?['customPricing'] != null) {
      final customPricing = pricingData!['customPricing'];
      final source = customPricing['source'];

      // Check if this is actual custom pricing or just base rate
      if (source != null && source != 'base-rate') {
        final isClientSpecific =
            customPricing['clientId'] != null || source == 'client_specific';
        return isClientSpecific
            ? AppLocalizations.of(context)!.clientSpecificRate
            : AppLocalizations.of(context)!.organizationRate;
      }
    }
    // No custom pricing; indicate missing base rate (NDIS cap is metadata only)
    return AppLocalizations.of(context)!.missingBaseRate;
  }

  /// Check if an NDIS item is high intensity
  bool _isHighIntensityItem(NDISItem item) {
    // Check registration group number for high intensity (0104)
    if (item.registrationGroupNumber == '0104') {
      return true;
    }

    // Check item name for "high intensity" text
    final itemNameLower = item.itemName.toLowerCase();
    if (itemNameLower.contains('high intensity')) {
      return true;
    }

    return false;
  }

  /// Toggle price override section for an item
  void _togglePriceOverride(String itemNumber) {
    setState(() {
      _showPriceOverride[itemNumber] =
          !(_showPriceOverride[itemNumber] ?? false);
      if (_showPriceOverride[itemNumber] == true) {
        // Initialize controller with current price
        final item = _filteredNdisItems
            .firstWhere((item) => item.itemNumber == itemNumber);
        final current = _getCurrentPrice(item);
        _priceControllers[itemNumber] = TextEditingController(
          text: current > 0 ? current.toStringAsFixed(2) : '',
        );
        _isCustomPriceEnabled[itemNumber] =
            _pricingData[itemNumber]?['customPricing'] != null;
      } else {
        // Dispose controller
        _priceControllers[itemNumber]?.dispose();
        _priceControllers.remove(itemNumber);
        _isCustomPriceEnabled[itemNumber] = false;
      }
    });
  }

  /// Save custom pricing for an NDIS item
  Future<void> _saveCustomPricing(NDISItem item) async {
    if (widget.organizationId == null) return;

    final controller = _priceControllers[item.itemNumber];
    if (controller == null) return;

    final priceText = controller.text.trim();
    final price = double.tryParse(priceText);

    if (price == null || price <= 0) {
      _showSnackBar(AppLocalizations.of(context)!.enterValidPrice,
          isError: true);
      return;
    }

    setState(() {
      _isSavingPrice[item.itemNumber] = true;
    });

    try {
      // Resolve user email: prefer adminEmail, fallback to stored user email
      final userEmail =
          (widget.adminEmail != null && widget.adminEmail!.trim().isNotEmpty)
              ? widget.adminEmail!
              : (_sharedPrefs.getUserEmail() ?? '');

      if (userEmail.isEmpty) {
        _showSnackBar(AppLocalizations.of(context)!.missingUserEmail,
            isError: true);
        setState(() {
          _isSavingPrice[item.itemNumber] = false;
        });
        return;
      }

      Map<String, dynamic> result;
      if (widget.clientId != null && widget.clientId!.trim().isNotEmpty) {
        // Save as client-specific pricing when clientId is present
        result = await _apiMethod.saveClientCustomPricing(
          widget.organizationId!,
          widget.clientId!,
          item.itemNumber,
          price,
          'fixed',
          userEmail,
          supportItemName: item.itemName,
        );
      } else {
        // Fallback to organization-wide custom pricing
        result = await _apiMethod.saveAsCustomPricing(
          widget.organizationId!,
          item.itemNumber,
          price,
          'fixed', // Valid pricing type expected by backend
          userEmail,
          supportItemName: item.itemName,
        );
      }

      if (result['success'] == true) {
        // Update local pricing data
        setState(() {
          final isClientSpecific =
              widget.clientId != null && widget.clientId!.trim().isNotEmpty;
          _pricingData[item.itemNumber] = {
            ..._pricingData[item.itemNumber] ?? {},
            'customPricing': {
              'price': price,
              'source': isClientSpecific
                  ? 'Client-Specific Rate'
                  : 'Organization Rate',
              if (isClientSpecific) 'clientId': widget.clientId,
              'createdAt': DateTime.now().toIso8601String(),
            },
            'supportItem': _pricingData[item.itemNumber]?['supportItem'],
          };
          _showPriceOverride[item.itemNumber] = false;
        });

        _showSnackBar(AppLocalizations.of(context)!.customPricingSaved);
      } else {
        _showSnackBar(
            result['message'] ?? AppLocalizations.of(context)!.errorOccurred,
            isError: true);
      }
    } catch (e) {
      log.severe("Failed to save custom pricing: $e");
      _showSnackBar(AppLocalizations.of(context)!.errorOccurred, isError: true);
    } finally {
      setState(() {
        _isSavingPrice[item.itemNumber] = false;
      });
    }
  }

  /// Remove custom pricing for an NDIS item
  Future<void> _removeCustomPricing(NDISItem item) async {
    if (widget.organizationId == null) return;

    try {
      final result = await _apiMethod.removeCustomPricing(
        widget.organizationId!,
        item.itemNumber,
      );

      if (result['success'] == true) {
        // Update local pricing data
        setState(() {
          _pricingData[item.itemNumber] = {
            ..._pricingData[item.itemNumber] ?? {},
            'customPricing': null,
          };
          _showPriceOverride[item.itemNumber] = false;
        });

        _showSnackBar(AppLocalizations.of(context)!.customPricingRemoved);
      } else {
        _showSnackBar(
            result['message'] ?? AppLocalizations.of(context)!.errorOccurred,
            isError: true);
      }
    } catch (e) {
      log.severe("Failed to remove custom pricing: $e");
      _showSnackBar(AppLocalizations.of(context)!.errorOccurred, isError: true);
    }
  }

  /// Show snackbar message
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: BauhausDesign.getTextTheme(context)
              .bodyMedium
              ?.copyWith(color: BauhausDesign.surfaceWhite),
        ),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        ),
        margin: const EdgeInsets.all(BauhausDesign.space4),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildModernHeader(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchAndFilters(),
                  const SizedBox(height: 20),
                  _buildInfoBanner(),
                  const SizedBox(height: 20),
                  _buildItemsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      color: BauhausDesign.surfaceWhite,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            return Padding(
              padding: EdgeInsets.all(
                  isSmallScreen ? BauhausDesign.space4 : BauhausDesign.space6),
              child: Column(
                children: [
                  Row(
                    children: [
                      BauhausActionButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icons.arrow_back_ios_new,
                        isSmall: true,
                        variant: BauhausActionVariant.secondary,
                      ),
                      const SizedBox(width: BauhausDesign.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .ndisPricingManagementTitle,
                              style: BauhausDesign.getTextTheme(context)
                                  .headlineMedium
                                  ?.copyWith(
                                    fontSize: isSmallScreen ? 24 : 28,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!isSmallScreen) ...[
                              const SizedBox(height: BauhausDesign.space2),
                              Text(
                                AppLocalizations.of(context)!
                                    .ndisPricingManagementSubtitle,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      color: BauhausDesign.textLight,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]
                          ],
                        ),
                      ),
                      if (!isSmallScreen)
                        BauhausChip(
                          text: AppLocalizations.of(context)!.systemActive,
                          variant: BauhausChipVariant.success,
                          size: BauhausChipSize.small,
                        ),
                      const SizedBox(width: BauhausDesign.space3),
                      BauhausIconButton(
                        onPressed: _openPricingSettings,
                        icon: Icons.settings,
                        isSmall: true,
                        variant: BauhausActionVariant.secondary,
                        tooltip: AppLocalizations.of(context)!
                            .pricingSettingsTooltip,
                      ),
                    ],
                  ),
                  if (isSmallScreen) ...[
                    const SizedBox(height: BauhausDesign.space3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!
                                .enableBulkOperationsDesc,
                            style: BauhausDesign.getTextTheme(context)
                                .bodySmall
                                ?.copyWith(
                                  color: BauhausDesign.textLight,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        BauhausChip(
                          text: AppLocalizations.of(context)!.systemActive,
                          variant: BauhausChipVariant.success,
                          size: BauhausChipSize.small,
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build modern header section with title and status

  /// Opens the PricingConfigurationView for managing organization pricing settings.
  ///
  /// Validates that `organizationId`, `adminEmail`, and `organizationName` are
  /// available before navigating. Shows an error snackbar if any are missing.
  void _openPricingSettings() {
    final orgId = widget.organizationId;
    final admin = widget.adminEmail;
    final orgName = widget.organizationName;

    if (orgId == null || admin == null || orgName == null || orgName.isEmpty) {
      _showSnackBar(
        AppLocalizations.of(context)!.orgContextMissingError,
        isError: true,
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PricingConfigurationView(
          adminEmail: admin,
          organizationId: orgId,
          organizationName: orgName,
        ),
      ),
    );
  }

  /// Build search and filter section
  Widget _buildSearchAndFilters() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        return Column(
          children: [
            BauhausTextField(
              controller: _searchController,
              onChanged: _filterNdisItems,
              label: AppLocalizations.of(context)!.searchItems,
              hintText: AppLocalizations.of(context)!.searchItemsHint,
              prefixIcon: const Icon(Icons.search),
            ),
            const SizedBox(height: 12),
            isSmallScreen
                ? Column(
                    children: [
                      _buildPricingFilter(),
                      const SizedBox(height: 12),
                      _buildStateFilter(),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _buildPricingFilter()),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStateFilter()),
                    ],
                  ),
          ],
        );
      },
    );
  }

  Widget _buildPricingFilter() {
    final l10n = AppLocalizations.of(context)!;
    return DropdownButtonFormField<String>(
      initialValue: _selectedFilter,
      decoration: BauhausDesign.inputDecoration(l10n.filterByPricing).copyWith(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space3, vertical: BauhausDesign.space2),
      ),
      items: ['All', 'Custom', 'Standard', 'High Intensity']
          .map((filter) => DropdownMenuItem(
                value: filter == 'Custom'
                    ? 'Custom Pricing' // Keeping values as strings for logic match
                    : filter == 'Standard'
                        ? 'Standard Pricing'
                        : filter == 'High Intensity'
                            ? 'High Intensity'
                            : filter,
                child: Text(
                  filter == 'Custom'
                      ? l10n.pricingFilterCustom
                      : filter == 'Standard'
                          ? l10n.pricingFilterStandard
                          : filter == 'High Intensity'
                              ? l10n.pricingFilterHighIntensity
                              : l10n.pricingFilterAll,
                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedFilter = value ?? 'All';
          _applyFilters();
        });
      },
      dropdownColor: BauhausDesign.surfaceWhite,
    );
  }

  Widget _buildStateFilter() {
    final l10n = AppLocalizations.of(context)!;
    return DropdownButtonFormField<String>(
      initialValue: _selectedStateFilter,
      decoration: BauhausDesign.inputDecoration(l10n.filterByState).copyWith(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space3, vertical: BauhausDesign.space2),
      ),
      items: ['All', 'NSW', 'VIC', 'QLD', 'WA', 'SA', 'TAS', 'ACT', 'NT']
          .map((state) => DropdownMenuItem(
                value: state,
                child: Text(
                  state == 'All' ? l10n.pricingFilterAll : state,
                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedStateFilter = value ?? 'All';
          _applyFilters();
        });
      },
      dropdownColor: BauhausDesign.surfaceWhite,
    );
  }

  /// Build information banner
  Widget _buildInfoBanner() {
    final displayState =
        _selectedStateFilter != 'All' ? _selectedStateFilter : _userState;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space3, vertical: BauhausDesign.space2),
      decoration: BoxDecoration(
        color: BauhausDesign.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: BauhausDesign.info, size: 20),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.pricingInfoBanner(displayState),
              style: TextStyle(color: BauhausDesign.info, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  /// Build NDIS items list
  Widget _buildItemsList() {
    if (_isLoading) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(
            semanticsLabel: AppLocalizations.of(context)!.loadingNdisItems,
          ),
        ),
      );
    }

    if (_filteredNdisItems.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text(
                _searchQuery.isNotEmpty
                    ? AppLocalizations.of(context)!
                        .noNdisItemsFoundMatch(_searchQuery)
                    : AppLocalizations.of(context)!.noNdisItemsFound,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                    _selectedFilter = 'All';
                    _selectedStateFilter = 'All';
                    _applyFilters();
                  });
                },
                child: Text(AppLocalizations.of(context)!.clearFiltersAction),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        itemCount: _filteredNdisItems.length,
        itemBuilder: (context, index) {
          final item = _filteredNdisItems[index];
          return Semantics(
            label: 'NDIS item ${item.itemNumber}',
            child: _buildNdisItemCard(item, index),
          );
        },
      ),
    );
  }

  /// Build individual NDIS item card
  Widget _buildNdisItemCard(NDISItem item, int index) {
    final currentPrice = _getCurrentPrice(item);
    final standardPrice = _getStandardPrice(item);
    final pricingSource = _getPricingSource(item);
    final showOverride = _showPriceOverride[item.itemNumber] ?? false;
    final hasCustomPricing =
        _pricingData[item.itemNumber]?['customPricing'] != null;
    final isMissingStandard = !hasCustomPricing && (standardPrice <= 0);

    return BauhausCard(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
      borderColor: hasCustomPricing
          ? BauhausDesign.warning
          : (isMissingStandard ? BauhausDesign.error : null),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.itemName,
                      style: BauhausDesign.getTextTheme(context)
                          .bodyLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      item.itemNumber,
                      style: BauhausDesign.getTextTheme(context)
                          .labelMedium
                          ?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: BauhausDesign.space2, vertical: 2),
                          decoration: BoxDecoration(
                            color: hasCustomPricing
                                ? BauhausDesign.warning.withOpacity(0.1)
                                : (isMissingStandard
                                    ? BauhausDesign.error.withOpacity(0.1)
                                    : BauhausDesign.success.withOpacity(0.1)),
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusSm),
                          ),
                          child: Text(
                            '\$${currentPrice.toStringAsFixed(2)}/hr',
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  color: hasCustomPricing
                                      ? BauhausDesign.warning
                                      : (isMissingStandard
                                          ? BauhausDesign.error
                                          : BauhausDesign.success),
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space2),
                        Text(
                          pricingSource,
                          style: BauhausDesign.getTextTheme(context)
                              .bodySmall
                              ?.copyWith(
                                color: isMissingStandard
                                    ? BauhausDesign.error
                                    : BauhausDesign.textMuted,
                                fontSize: 11,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasCustomPricing)
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      onPressed: () => _removeCustomPricing(item),
                      tooltip: AppLocalizations.of(context)!
                          .removeCustomPricingTooltip,
                      color: BauhausDesign.error,
                    ),
                  IconButton(
                    icon: Icon(
                      showOverride ? Icons.expand_less : Icons.attach_money,
                      color: showOverride
                          ? BauhausDesign.primary
                          : (isMissingStandard
                              ? BauhausDesign.error
                              : BauhausDesign.textMuted),
                      size: 20,
                    ),
                    onPressed: () => _togglePriceOverride(item.itemNumber),
                    tooltip:
                        AppLocalizations.of(context)!.setCustomPriceTooltip,
                  ),
                ],
              ),
            ],
          ),
          if (showOverride) ...[
            const SizedBox(height: BauhausDesign.space4),
            _buildPriceOverrideSection(item),
          ],
        ],
      ),
    )
        .animate(delay: (index * 50).ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.2, end: 0);
  }

  /// Build modern price override section for an item
  Widget _buildPriceOverrideSection(NDISItem item) {
    final standardPrice = _getStandardPrice(item);
    final controller = _priceControllers[item.itemNumber];
    final isCustomEnabled = _isCustomPriceEnabled[item.itemNumber] ?? false;
    final isSaving = _isSavingPrice[item.itemNumber] ?? false;

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.neutral.withOpacity(0.05),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with standard rate info
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              color: BauhausDesign.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.info.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(
                  standardPrice > 0 ? Icons.info_outline : Icons.error_outline,
                  color: standardPrice > 0
                      ? BauhausDesign.info
                      : BauhausDesign.error,
                  size: 20,
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (standardPrice > 0) ...[
                        Text(
                          AppLocalizations.of(context)!.standardNdisRateLabel,
                          style: BauhausDesign.getTextTheme(context)
                              .labelSmall
                              ?.copyWith(
                                color: BauhausDesign.info,
                              ),
                        ),
                        Text(
                          '\$${standardPrice.toStringAsFixed(2)} per hour',
                          style: BauhausDesign.getTextTheme(context)
                              .bodyLarge
                              ?.copyWith(
                                color: BauhausDesign.info,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ] else ...[
                        Text(
                          AppLocalizations.of(context)!.standardRateUnavailable,
                          style: BauhausDesign.getTextTheme(context)
                              .labelSmall
                              ?.copyWith(
                                color: BauhausDesign.error,
                              ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.pleaseEnterCustomPrice,
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.error,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (standardPrice <= 0) ...[
            const SizedBox(height: BauhausDesign.space3),
            BauhausActionButton(
              onPressed: () async {
                final resolution = await showPricePromptDialog(
                  context: context,
                  promptData: {
                    'ndisItemNumber': item.itemNumber,
                    'itemDescription': item.itemName,
                    'quantity': 1.0,
                    'unit': 'hour',
                    'priceCap': null,
                    'suggestedPrice': null,
                  },
                );
                if (resolution != null) {
                  final providedPrice =
                      (resolution['providedPrice'] as num?)?.toDouble();
                  if (providedPrice != null && providedPrice > 0) {
                    setState(() {
                      _isCustomPriceEnabled[item.itemNumber] = true;
                      controller?.text = providedPrice.toStringAsFixed(2);
                    });
                    if (resolution['applyToOrganization'] == true) {
                      await _saveCustomPricing(item);
                    }
                  }
                }
              },
              icon: Icons.attach_money,
              text: AppLocalizations.of(context)!.enterPriceAction,
              isSmall: true,
              variant: BauhausActionVariant.primary,
            ),
          ],

          const SizedBox(height: BauhausDesign.space4),

          // Custom pricing toggle
          GestureDetector(
            onTap: () {
              setState(() {
                _isCustomPriceEnabled[item.itemNumber] = !isCustomEnabled;
                if (!isCustomEnabled) {
                  controller?.text =
                      standardPrice > 0 ? standardPrice.toStringAsFixed(2) : '';
                }
              });
            },
            child: Row(
              children: [
                BauhausCheckbox(
                  value: isCustomEnabled,
                  onChanged: (val) {
                    setState(() {
                      _isCustomPriceEnabled[item.itemNumber] = val ?? false;
                      if (val == true) {
                        controller?.text = standardPrice > 0
                            ? standardPrice.toStringAsFixed(2)
                            : '';
                      }
                    });
                  },
                  activeColor: BauhausDesign.primary,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!.setCustomPriceOrgLabel,
                  style: BauhausDesign.getTextTheme(context).bodyMedium,
                ),
              ],
            ),
          ),

          if (isCustomEnabled) ...[
            const SizedBox(height: BauhausDesign.space3),
            BauhausTextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              label: AppLocalizations.of(context)!.customPriceHourlyLabel,
              prefixIcon: const Icon(Icons.attach_money),
              hintText: AppLocalizations.of(context)!.enterHourlyRateHint,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty)
                  return AppLocalizations.of(context)!.pleaseEnterPrice;
                final price = double.tryParse(value);
                if (price == null || price <= 0)
                  return AppLocalizations.of(context)!.invalidPrice;
                if (standardPrice > 0 && price > standardPrice * 2) {
                  return AppLocalizations.of(context)!.priceUnusuallyHigh;
                }
                return null;
              },
            ),
            const SizedBox(height: BauhausDesign.space4),
            Row(
              children: [
                BauhausActionButton(
                  onPressed: isSaving ? null : () => _saveCustomPricing(item),
                  text: AppLocalizations.of(context)!.saveCustomPriceAction,
                  icon: Icons.save,
                  isLoading: isSaving,
                  variant: BauhausActionVariant.primary,
                ),
                const SizedBox(width: BauhausDesign.space3),
                BauhausActionButton(
                  onPressed: () {
                    setState(() {
                      _showPriceOverride[item.itemNumber] = false;
                    });
                  },
                  text: AppLocalizations.of(context)!.cancelAction,
                  variant: BauhausActionVariant.secondary,
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space3),
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      size: 16, color: BauhausDesign.warning),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.customPricingAppliedOrgWide,
                      style:
                          TextStyle(color: BauhausDesign.warning, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
