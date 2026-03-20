import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
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
  static const Color _screenGray = Color(0xFFE3E3E3);
  static const Color _inkBlack = Color(0xFF171717);
  static const Color _accentRed = Color(0xFFE21F26);
  static const Color _panelWhite = Color(0xFFF8F8F8);
  static const Color _accentBlue = Color(0xFF0D62B3);
  static const Color _accentYellow = Color(0xFFF5D000);

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
  String? _organizationState;
  double? _fallbackBaseRate;
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
    _loadOrganizationState();
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
    final normalized = _normalizeStateCode(state) ?? 'NSW';
    setState(() {
      _userState = normalized;
    });
  }

  String? _normalizeStateCode(String? rawState) {
    if (rawState == null) return null;
    final normalized = rawState.trim().toUpperCase();
    if (normalized.isEmpty || normalized == 'ALL') return null;

    const aliases = <String, String>{
      'AU-NSW': 'NSW',
      'AU-VIC': 'VIC',
      'AU-QLD': 'QLD',
      'AU-WA': 'WA',
      'AU-SA': 'SA',
      'AU-TAS': 'TAS',
      'AU-ACT': 'ACT',
      'AU-NT': 'NT',
      'NEW SOUTH WALES': 'NSW',
      'VICTORIA': 'VIC',
      'QUEENSLAND': 'QLD',
      'WESTERN AUSTRALIA': 'WA',
      'SOUTH AUSTRALIA': 'SA',
      'TASMANIA': 'TAS',
      'AUSTRALIAN CAPITAL TERRITORY': 'ACT',
      'NORTHERN TERRITORY': 'NT',
    };

    final resolved = aliases[normalized] ?? normalized;
    const supportedStates = {
      'ACT',
      'NSW',
      'NT',
      'QLD',
      'SA',
      'TAS',
      'VIC',
      'WA',
    };
    return supportedStates.contains(resolved) ? resolved : null;
  }

  String _getTargetPricingState() {
    return _normalizeStateCode(
          _selectedStateFilter != 'All' ? _selectedStateFilter : null,
        ) ??
        _normalizeStateCode(_organizationState) ??
        _normalizeStateCode(_userState) ??
        'NSW';
  }

  String? _extractOrganizationState(Map<String, dynamic>? response) {
    if (response == null || response.isEmpty) return null;

    final candidateMaps = <Map<String, dynamic>>[];

    void addCandidate(dynamic value) {
      if (value is Map<String, dynamic>) {
        candidateMaps.add(value);
      } else if (value is Map) {
        candidateMaps.add(Map<String, dynamic>.from(value));
      }
    }

    addCandidate(response);
    addCandidate(response['data']);
    addCandidate(response['organization']);

    final dataMap = response['data'];
    if (dataMap is Map) {
      addCandidate(dataMap['organization']);
    }

    for (final candidate in candidateMaps) {
      final address = candidate['address'];
      if (address is Map) {
        final addressState = _normalizeStateCode(address['state']?.toString());
        if (addressState != null) return addressState;
      }

      final directState = _normalizeStateCode(candidate['state']?.toString());
      if (directState != null) return directState;

      final businessState =
          _normalizeStateCode(candidate['businessState']?.toString());
      if (businessState != null) return businessState;
    }

    return null;
  }

  Future<void> _loadOrganizationState() async {
    final organizationId = widget.organizationId;
    if (organizationId == null || organizationId.trim().isEmpty) return;

    try {
      final response = await _apiMethod.getOrganizationDetails(organizationId);
      final resolvedState = _extractOrganizationState(response);
      if (!mounted || resolvedState == null) return;

      if (_organizationState != resolvedState) {
        setState(() {
          _organizationState = resolvedState;
        });
        if (_allNdisItems.isNotEmpty) {
          _applyFilters();
        }
      }
    } catch (e) {
      log.warning('Failed to resolve organization state for pricing: $e');
    }
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
      // Load organization fallback base rate once for display when item-level
      // custom pricing does not exist.
      final fallbackRate =
          await _apiMethod.getFallbackBaseRate(widget.organizationId!);
      if (mounted) {
        setState(() {
          _fallbackBaseRate =
              (fallbackRate != null && fallbackRate > 0) ? fallbackRate : null;
        });
      }

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

  bool _isFallbackSource(String? source) {
    if (source == null) return false;
    final normalized = source.toLowerCase().trim();
    return normalized == 'base-rate' ||
        normalized == 'fallback-base-rate' ||
        normalized == 'fallback' ||
        normalized == 'ndis_default';
  }

  bool _isClientSpecificSource(String? source) {
    if (source == null) return false;
    final normalized = source.toLowerCase().trim();
    return normalized == 'client_specific' || normalized == 'client-specific';
  }

  double? _toPositiveDouble(dynamic value) {
    if (value is num && value > 0) return value.toDouble();
    if (value is String) {
      final parsed =
          double.tryParse(value.replaceAll(RegExp(r'[^0-9.\-]'), ''));
      if (parsed != null && parsed > 0) return parsed;
    }
    return null;
  }

  bool _hasItemLevelCustomPricing(Map<String, dynamic>? pricingData) {
    final customPricing = pricingData?['customPricing'];
    if (customPricing is! Map<String, dynamic>) return false;
    return !_isFallbackSource(customPricing['source']?.toString());
  }

  double? _extractResolvedPrice(Map<String, dynamic>? pricing) {
    if (pricing == null) return null;
    final candidates = [
      pricing['customPrice'],
      pricing['price'],
      pricing['fixedPrice'],
      pricing['fallbackBaseRate'],
      pricing['baseRate'],
    ];
    for (final candidate in candidates) {
      if (candidate is num && candidate > 0) {
        return candidate.toDouble();
      }
      if (candidate is String) {
        final parsed = double.tryParse(candidate);
        if (parsed != null && parsed > 0) return parsed;
      }
    }
    return null;
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
        final hasCustomPricing = _hasItemLevelCustomPricing(pricingData);

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

        // Check if item has actual custom pricing (not fallback base rate)
        final hasActualCustomPricing = _hasItemLevelCustomPricing(pricingData);

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
    final capInfo = _getNdisMaxCapInfo(item);
    final price = _toPositiveDouble(capInfo?['price']);
    if (price != null && price > 0) return price;

    // No standard price for selected state or missing support item details
    // Return 0.0 to avoid silent use of a dummy $30 rate
    return 0.0;
  }

  /// Get current billable price (custom only) for an item
  double _getCurrentPrice(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    final customPricing =
        pricingData?['customPricing'] as Map<String, dynamic>?;
    if (customPricing != null) {
      final resolved = _extractResolvedPrice(customPricing);
      if (resolved != null && resolved > 0) {
        return resolved;
      }
    }

    // Fallback to organization-level base rate when configured.
    if (_fallbackBaseRate != null && _fallbackBaseRate! > 0) {
      return _fallbackBaseRate!;
    }

    // No configured billable rate.
    return 0.0;
  }

  /// Get pricing source description for display
  String _getPricingSource(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    final customPricing =
        pricingData?['customPricing'] as Map<String, dynamic>?;
    if (customPricing != null) {
      final source = customPricing['source']?.toString();

      if (_isFallbackSource(source)) {
        return AppLocalizations.of(context)!.sourceFallbackBaseRate;
      }

      if (_extractResolvedPrice(customPricing) != null) {
        final isClientSpecific = customPricing['clientId'] != null ||
            _isClientSpecificSource(source);
        return isClientSpecific
            ? AppLocalizations.of(context)!.clientSpecificRate
            : AppLocalizations.of(context)!.organizationRate;
      }
    }

    if (_fallbackBaseRate != null && _fallbackBaseRate! > 0) {
      return AppLocalizations.of(context)!.sourceFallbackBaseRate;
    }

    // No configured pricing source found.
    return AppLocalizations.of(context)!.missingBaseRate;
  }

  double? _resolveStatePrice(dynamic capValue, String targetState) {
    if (capValue is Map) {
      final direct = _toPositiveDouble(capValue[targetState]);
      if (direct != null) return direct;

      for (final entry in capValue.entries) {
        final keyState = _normalizeStateCode(entry.key.toString());
        if (keyState == targetState) {
          final parsed = _toPositiveDouble(entry.value);
          if (parsed != null) return parsed;
        }
      }
    }

    return _toPositiveDouble(capValue);
  }

  Map<String, double> _resolveLabelledCaps(
      dynamic labelledCaps, String targetState) {
    final resolved = <String, double>{};
    if (labelledCaps is! Map) return resolved;

    for (final entry in labelledCaps.entries) {
      final label = entry.key.toString().trim().toUpperCase();
      if (label.isEmpty) continue;
      final price = _resolveStatePrice(entry.value, targetState);
      if (price != null) {
        resolved[label] = price;
      }
    }

    return resolved;
  }

  Map<PriceRegion, double?> _getRegionalPrices(NDISItem item) {
    return item.regionalPrices;
  }

  PriceRegion? _stateToPriceRegion(String stateCode) {
    switch (_normalizeStateCode(stateCode)) {
      case 'ACT':
        return PriceRegion.act;
      case 'NSW':
        return PriceRegion.nsw;
      case 'NT':
        return PriceRegion.nt;
      case 'QLD':
        return PriceRegion.qld;
      case 'SA':
        return PriceRegion.sa;
      case 'TAS':
        return PriceRegion.tas;
      case 'VIC':
        return PriceRegion.vic;
      case 'WA':
        return PriceRegion.wa;
      default:
        return null;
    }
  }

  double? _normalizeRegionalValue(double? value) {
    if (value == null || value <= 0) return null;
    return value;
  }

  Map<String, dynamic>? _resolveCapInfoFromRegionalPrices(
      NDISItem item, String targetState, bool isHighIntensity) {
    final regionalPrices = _getRegionalPrices(item);
    final stateRegion = _stateToPriceRegion(targetState);
    final statePrice = stateRegion == null
        ? null
        : _normalizeRegionalValue(regionalPrices[stateRegion]);
    final nationalPrice = _normalizeRegionalValue(
      regionalPrices[PriceRegion.national],
    );
    final p01Price = _normalizeRegionalValue(
      regionalPrices[PriceRegion.remote],
    );
    final p02Price = _normalizeRegionalValue(
      regionalPrices[PriceRegion.veryRemote],
    );

    double? selectedPrice;
    String selectedLabel;
    if (statePrice != null) {
      selectedPrice = statePrice;
      selectedLabel = isHighIntensity ? 'H' : 'STD';
    } else if (p02Price != null) {
      selectedPrice = p02Price;
      selectedLabel = 'P02';
    } else if (p01Price != null) {
      selectedPrice = p01Price;
      selectedLabel = 'P01';
    } else {
      selectedPrice = nationalPrice;
      selectedLabel = isHighIntensity ? 'H' : 'STD';
    }
    if (selectedPrice == null) return null;

    return {
      'price': selectedPrice,
      'state': targetState,
      'label': selectedLabel,
      'standardPrice': statePrice ?? nationalPrice,
      'highIntensityPrice': isHighIntensity ? selectedPrice : null,
      'p01Price': p01Price,
      'p02Price': p02Price,
      'isHighIntensity': isHighIntensity,
      'labelledCaps': <String, double>{
        if (p01Price != null) 'P01': p01Price,
        if (p02Price != null) 'P02': p02Price,
      },
      'source': 'regional_prices',
    };
  }

  Map<String, dynamic>? _extractPriceCapsContainer(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    if (pricingData == null) return null;

    bool hasUsableCapData(Map<String, dynamic> caps) {
      final targetState = _getTargetPricingState();
      if (_resolveStatePrice(caps['standard'], targetState) != null) {
        return true;
      }
      if (_resolveStatePrice(
            caps['highIntensity'] ?? caps['high_intensity'],
            targetState,
          ) !=
          null) {
        return true;
      }
      if (_resolveStatePrice(caps['maxByState'], targetState) != null) {
        return true;
      }
      if (_resolveStatePrice(caps['P01'], targetState) != null) {
        return true;
      }
      if (_resolveStatePrice(caps['P02'], targetState) != null) {
        return true;
      }
      return _resolveLabelledCaps(caps['labelled'], targetState).isNotEmpty;
    }

    final supportItem = pricingData['supportItem'];
    if (supportItem is Map) {
      final priceCaps = supportItem['priceCaps'];
      if (priceCaps is Map) {
        final mappedCaps = Map<String, dynamic>.from(priceCaps);
        if (mappedCaps.isNotEmpty && hasUsableCapData(mappedCaps)) {
          return mappedCaps;
        }
      }
    }

    final customPricing = pricingData['customPricing'];
    if (customPricing is Map) {
      final priceCaps = customPricing['priceCaps'];
      if (priceCaps is Map) {
        final mappedCaps = Map<String, dynamic>.from(priceCaps);
        if (mappedCaps.isNotEmpty && hasUsableCapData(mappedCaps)) {
          return mappedCaps;
        }
      }
    }

    return null;
  }

  /// Resolve the primary NDIS cap for the selected state.
  ///
  /// Selection priority:
  /// - high intensity map when item is high intensity
  /// - standard map otherwise
  /// - maxByState fallback
  /// - labelled remote loadings (P01/P02)
  Map<String, dynamic>? _getNdisMaxCapInfo(NDISItem item) {
    final targetState = _getTargetPricingState();
    final isHighIntensity = _isHighIntensityItem(item);
    final priceCaps = _extractPriceCapsContainer(item);

    if (priceCaps == null) {
      return _resolveCapInfoFromRegionalPrices(
        item,
        targetState,
        isHighIntensity,
      );
    }

    final standardPrice =
        _resolveStatePrice(priceCaps['standard'], targetState);
    final highIntensityPrice = _resolveStatePrice(
      priceCaps['highIntensity'] ?? priceCaps['high_intensity'],
      targetState,
    );
    final labelledCaps =
        _resolveLabelledCaps(priceCaps['labelled'], targetState);
    final p01Price = labelledCaps['P01'] ??
        _resolveStatePrice(priceCaps['P01'], targetState);
    final p02Price = labelledCaps['P02'] ??
        _resolveStatePrice(priceCaps['P02'], targetState);
    final regionalFallback =
        _resolveCapInfoFromRegionalPrices(item, targetState, isHighIntensity);
    final fallbackP01 = regionalFallback?['p01Price'] as double?;
    final fallbackP02 = regionalFallback?['p02Price'] as double?;

    double? selectedPrice;
    String? selectedLabel;

    if (isHighIntensity && highIntensityPrice != null) {
      selectedPrice = highIntensityPrice;
      selectedLabel = 'H';
    } else if (standardPrice != null) {
      selectedPrice = standardPrice;
      selectedLabel = 'STD';
    } else if (highIntensityPrice != null) {
      selectedPrice = highIntensityPrice;
      selectedLabel = 'H';
    }

    if (selectedPrice == null) {
      final maxByStatePrice =
          _resolveStatePrice(priceCaps['maxByState'], targetState);
      if (maxByStatePrice != null) {
        selectedPrice = maxByStatePrice;
        selectedLabel = 'MAX';
      }
    }

    if (selectedPrice == null) {
      if (p02Price != null || fallbackP02 != null) {
        selectedPrice = p02Price ?? fallbackP02;
        selectedLabel = 'P02';
      } else if (p01Price != null || fallbackP01 != null) {
        selectedPrice = p01Price ?? fallbackP01;
        selectedLabel = 'P01';
      }
    }

    if (selectedPrice == null) {
      return regionalFallback;
    }

    final resolvedP01 = p01Price ?? fallbackP01;
    final resolvedP02 = p02Price ?? fallbackP02;
    final mergedLabelledCaps = <String, double>{
      ...labelledCaps,
      if (resolvedP01 != null) 'P01': resolvedP01,
      if (resolvedP02 != null) 'P02': resolvedP02,
    };

    return {
      'price': selectedPrice,
      'state': targetState,
      'label': selectedLabel,
      'standardPrice': standardPrice,
      'highIntensityPrice': highIntensityPrice,
      'p01Price': resolvedP01,
      'p02Price': resolvedP02,
      'isHighIntensity': isHighIntensity,
      'labelledCaps': mergedLabelledCaps,
    };
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

    final registrationGroupName = item.registrationGroupName.toLowerCase();
    if (registrationGroupName.contains('high intensity')) {
      return true;
    }

    return false;
  }

  bool _isTtpItem(NDISItem item) {
    final number = item.itemNumber.trim().toUpperCase();
    final name = item.itemName.trim().toUpperCase();
    return number.endsWith('_T') || name.contains('TTP');
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
            _hasItemLevelCustomPricing(_pricingData[itemNumber]);
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
      backgroundColor: _screenGray,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildModernHeader()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchAndFilters(),
                  const SizedBox(height: 10),
                  _buildInfoBanner(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          _buildItemsList(),
        ],
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      color: _screenGray,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
            color: _screenGray,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _panelWhite,
                          border: Border.all(color: _inkBlack, width: 2),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: _inkBlack,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'NDIS PRICING',
                        style: BauhausDesign.getTextTheme(context)
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: _inkBlack,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                    InkWell(
                      onTap: _openPricingSettings,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _accentBlue,
                          border: Border.all(color: _inkBlack, width: 2),
                        ),
                        child: const Icon(
                          Icons.settings,
                          size: 18,
                          color: BauhausDesign.surfaceWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'PRICING ENGINE V2.1',
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _accentRed,
                        border: Border.all(color: _inkBlack, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.stop_circle_outlined,
                            size: 10,
                            color: BauhausDesign.surfaceWhite,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'SYSTEM ACTIVE',
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  color: BauhausDesign.surfaceWhite,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.6,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: _inkBlack,
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel('SEARCH ITEM CODE'),
        const SizedBox(height: 6),
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: _panelWhite,
            border: Border.all(color: _inkBlack, width: 2),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 18, color: Colors.black54),
              const SizedBox(width: 6),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterNdisItems,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: '01_002_0107_1_1',
                  ),
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildPricingFilter()),
            const SizedBox(width: 10),
            Expanded(child: _buildStateFilter()),
          ],
        ),
      ],
    );
  }

  Widget _buildPricingFilter() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedFilter,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        filled: true,
        fillColor: _panelWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _inkBlack, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _inkBlack, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _inkBlack, width: 2),
        ),
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
                      ? 'Custom Rates'
                      : filter == 'Standard'
                          ? 'Standard Rates'
                          : filter == 'High Intensity'
                              ? 'High Intensity'
                              : 'All Cats',
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w700,
                          ),
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedFilter = value ?? 'All';
          _applyFilters();
        });
      },
      icon: const Icon(Icons.keyboard_arrow_down, color: _inkBlack),
      dropdownColor: _panelWhite,
    );
  }

  Widget _buildStateFilter() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedStateFilter,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        filled: true,
        fillColor: _panelWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _inkBlack, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _inkBlack, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _inkBlack, width: 2),
        ),
      ),
      items: ['All', 'NSW', 'VIC', 'QLD', 'WA', 'SA', 'TAS', 'ACT', 'NT']
          .map((state) => DropdownMenuItem(
                value: state,
                child: Text(
                  state == 'All' ? 'All States' : state,
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w700,
                          ),
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedStateFilter = value ?? 'All';
          _applyFilters();
        });
      },
      icon: const Icon(Icons.keyboard_arrow_down, color: _inkBlack),
      dropdownColor: _panelWhite,
    );
  }

  /// Build information banner
  Widget _buildInfoBanner() {
    return Container(
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 82,
            color: _accentRed,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: _accentRed,
                    ),
                    child: const Icon(
                      Icons.info,
                      color: BauhausDesign.surfaceWhite,
                      size: 12,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Notice: Pricing shown for Standard rates in ${_getTargetPricingState()}. '
                      'Custom pricing overrides standard rates.',
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
            color: _inkBlack,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
    );
  }

  /// Build NDIS items list
  Widget _buildItemsList() {
    if (_isLoading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(
            color: _inkBlack,
            semanticsLabel: AppLocalizations.of(context)!.loadingNdisItems,
          ),
        ),
      );
    }

    if (_filteredNdisItems.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
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

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = _filteredNdisItems[index];
            return Semantics(
              label: 'NDIS item ${item.itemNumber}',
              child: _buildNdisItemCard(item, index),
            );
          },
          childCount: _filteredNdisItems.length,
        ),
      ),
    );
  }

  /// Build individual NDIS item card
  Widget _buildNdisItemCard(NDISItem item, int index) {
    final currentPrice = _getCurrentPrice(item);
    final ndisCapInfo = _getNdisMaxCapInfo(item);
    final ndisCapPrice = ndisCapInfo?['price'] as double?;
    final ndisCapState = (ndisCapInfo?['state'] as String?) ?? _userState;
    final p01Price = ndisCapInfo?['p01Price'] as double?;
    final showOverride = _showPriceOverride[item.itemNumber] ?? false;
    final updatedText = _formatLastUpdated(item.itemNumber);
    final subtitle = _extractSubtitle(item.itemName);
    final capText =
        ndisCapPrice != null ? '\$${ndisCapPrice.toStringAsFixed(2)}' : 'N/A';
    final p01Text =
        p01Price != null ? '\$${p01Price.toStringAsFixed(2)}' : 'N/A';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: _inkBlack,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: [
                Text(
                  'PRICING ITEM',
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.surfaceWhite,
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.w800,
                          ),
                ),
                const Spacer(),
                Text(
                  '\$',
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            color: BauhausDesign.surfaceWhite,
                            fontWeight: FontWeight.w700,
                          ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.itemName.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: BauhausDesign.getTextTheme(context)
                                .headlineMedium
                                ?.copyWith(
                                  color: _inkBlack,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            subtitle,
                            style: BauhausDesign.getTextTheme(context)
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                      icon: Icon(
                        showOverride
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: _inkBlack,
                        size: 22,
                      ),
                      onPressed: () => _togglePriceOverride(item.itemNumber),
                      tooltip:
                          AppLocalizations.of(context)!.setCustomPriceTooltip,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    border: Border.all(color: _accentRed, width: 2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.qr_code_2, size: 15, color: _accentRed),
                      const SizedBox(width: 8),
                      Text(
                        item.itemNumber,
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              color: _accentRed,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTagChip('FALLBACK BASE'),
                    _buildTagChip('NDIS CAP: $ndisCapState'),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  decoration: BoxDecoration(
                    color: _accentYellow,
                    border: Border.all(color: _inkBlack, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: _inkBlack,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Text(
                          'BILLABLE RATE',
                          style: BauhausDesign.getTextTheme(context)
                              .labelSmall
                              ?.copyWith(
                                color: BauhausDesign.surfaceWhite,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                              ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            currentPrice > 0
                                ? '\$${currentPrice.toStringAsFixed(2)}'
                                : '\$0.00',
                            style: BauhausDesign.getTextTheme(context)
                                .displaySmall
                                ?.copyWith(
                                  color: _inkBlack,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 40,
                                ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              '/ hr',
                              style: BauhausDesign.getTextTheme(context)
                                  .labelLarge
                                  ?.copyWith(
                                    color: _inkBlack,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricBlock(
                        title: 'NDIS MAX CAP',
                        value: capText,
                        valueColor: _accentBlue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildMetricBlock(
                        title: 'REMOTE P01',
                        value: p01Text,
                      ),
                    ),
                  ],
                ),
                if (showOverride) ...[
                  const SizedBox(height: 10),
                  _buildPriceOverrideSection(item),
                ],
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5E5),
              border: Border(
                top: BorderSide(color: _inkBlack, width: 2),
              ),
            ),
            child: Text(
              updatedText,
              textAlign: TextAlign.center,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
            ),
          ),
        ],
      ),
    )
        .animate(delay: (index * 40).ms)
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildTagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8E8),
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Text(
        label,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: _inkBlack,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
      ),
    );
  }

  Widget _buildMetricBlock({
    required String title,
    required String value,
    Color valueColor = _inkBlack,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 7, 8, 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }

  String _extractSubtitle(String itemName) {
    final parts = itemName.split(' - ');
    if (parts.length <= 1) return itemName;
    return parts.skip(1).join(' - ');
  }

  String _formatLastUpdated(String itemNumber) {
    final pricing = _pricingData[itemNumber];
    final customPricing = pricing?['customPricing'];
    final supportItem = pricing?['supportItem'];
    final raw = customPricing?['updatedAt'] ??
        customPricing?['createdAt'] ??
        supportItem?['updatedAt'];
    if (raw == null) return 'LAST UPDATED: JUST NOW';

    DateTime? updatedAt;
    if (raw is DateTime) {
      updatedAt = raw;
    } else if (raw is String) {
      updatedAt = DateTime.tryParse(raw);
    } else if (raw is Map && raw['\$date'] != null) {
      updatedAt = DateTime.tryParse(raw['\$date'].toString());
    }
    if (updatedAt == null) return 'LAST UPDATED: JUST NOW';

    final diff = DateTime.now().difference(updatedAt.toLocal());
    if (diff.inMinutes < 1) return 'LAST UPDATED: JUST NOW';
    if (diff.inMinutes < 60) return 'LAST UPDATED: ${diff.inMinutes} MINS AGO';
    if (diff.inHours < 24) return 'LAST UPDATED: ${diff.inHours} HRS AGO';
    return 'LAST UPDATED: ${diff.inDays} DAYS AGO';
  }

  /// Build modern price override section for an item
  Widget _buildPriceOverrideSection(NDISItem item) {
    final standardPrice = _getStandardPrice(item);
    final fallbackRate = _fallbackBaseRate ?? 0.0;
    final hasFallbackRate = fallbackRate > 0;
    final controller = _priceControllers[item.itemNumber];
    final isCustomEnabled = _isCustomPriceEnabled[item.itemNumber] ?? false;
    final isSaving = _isSavingPrice[item.itemNumber] ?? false;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: _inkBlack,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              'CUSTOM PRICING OVERRIDE',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    border: Border.all(color: _inkBlack, width: 2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 62,
                        color: _accentRed,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                standardPrice > 0
                                    ? 'STANDARD NDIS RATE'
                                    : (hasFallbackRate
                                        ? 'FALLBACK BASE RATE'
                                        : 'NO BASE RATE FOUND'),
                                style: BauhausDesign.getTextTheme(context)
                                    .labelSmall
                                    ?.copyWith(
                                      color: _inkBlack,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                standardPrice > 0
                                    ? '\$${standardPrice.toStringAsFixed(2)} / hr'
                                    : (hasFallbackRate
                                        ? '\$${fallbackRate.toStringAsFixed(2)} / hr'
                                        : AppLocalizations.of(context)!
                                            .pleaseEnterCustomPrice),
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyLarge
                                    ?.copyWith(
                                      color:
                                          standardPrice > 0 || hasFallbackRate
                                              ? _accentBlue
                                              : _accentRed,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildOverrideQuickButton(
                        label: 'USE STANDARD',
                        onTap: standardPrice > 0
                            ? () {
                                setState(() {
                                  _isCustomPriceEnabled[item.itemNumber] = true;
                                  controller?.text =
                                      standardPrice.toStringAsFixed(2);
                                });
                              }
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildOverrideQuickButton(
                        label: 'USE FALLBACK',
                        onTap: hasFallbackRate
                            ? () {
                                setState(() {
                                  _isCustomPriceEnabled[item.itemNumber] = true;
                                  controller?.text =
                                      fallbackRate.toStringAsFixed(2);
                                });
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
                if (standardPrice <= 0 && !hasFallbackRate) ...[
                  const SizedBox(height: 10),
                  _buildOverrideQuickButton(
                    label: AppLocalizations.of(context)!
                        .enterPriceAction
                        .toUpperCase(),
                    isPrimary: true,
                    onTap: () async {
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
                  ),
                ],
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isCustomPriceEnabled[item.itemNumber] = !isCustomEnabled;
                      if (!isCustomEnabled) {
                        controller?.text = standardPrice > 0
                            ? standardPrice.toStringAsFixed(2)
                            : (hasFallbackRate
                                ? fallbackRate.toStringAsFixed(2)
                                : '');
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      border: Border.all(color: _inkBlack, width: 2),
                    ),
                    child: Row(
                      children: [
                        BauhausCheckbox(
                          value: isCustomEnabled,
                          onChanged: (val) {
                            setState(() {
                              _isCustomPriceEnabled[item.itemNumber] =
                                  val ?? false;
                              if (val == true) {
                                controller?.text = standardPrice > 0
                                    ? standardPrice.toStringAsFixed(2)
                                    : (hasFallbackRate
                                        ? fallbackRate.toStringAsFixed(2)
                                        : '');
                              }
                            });
                          },
                          activeColor: _accentRed,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!
                                .setCustomPriceOrgLabel,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: _inkBlack,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isCustomEnabled) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: _panelWhite,
                      border: Border.all(color: _inkBlack, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .customPriceHourlyLabel
                              .toUpperCase(),
                          style: BauhausDesign.getTextTheme(context)
                              .labelSmall
                              ?.copyWith(
                                color: _inkBlack,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: controller,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                          style: BauhausDesign.getTextTheme(context)
                              .headlineMedium
                              ?.copyWith(
                                color: _inkBlack,
                                fontWeight: FontWeight.w900,
                              ),
                          decoration: const InputDecoration(
                            isDense: true,
                            prefixText: '\$ ',
                            hintText: '0.00',
                            filled: true,
                            fillColor: Color(0xFFF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                                  BorderSide(color: _inkBlack, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                                  BorderSide(color: _inkBlack, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                                  BorderSide(color: _inkBlack, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOverrideQuickButton(
                          label: isSaving
                              ? 'SAVING...'
                              : AppLocalizations.of(context)!
                                  .saveCustomPriceAction
                                  .toUpperCase(),
                          isPrimary: true,
                          onTap:
                              isSaving ? null : () => _saveCustomPricing(item),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildOverrideQuickButton(
                          label: AppLocalizations.of(context)!
                              .cancelAction
                              .toUpperCase(),
                          onTap: () {
                            setState(() {
                              _showPriceOverride[item.itemNumber] = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3CC),
                      border: Border.all(color: _inkBlack, width: 2),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.customPricingAppliedOrgWide,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverrideQuickButton({
    required String label,
    required VoidCallback? onTap,
    bool isPrimary = false,
  }) {
    final backgroundColor = onTap == null
        ? const Color(0xFFCCCCCC)
        : (isPrimary ? _accentRed : _panelWhite);
    final textColor = onTap == null
        ? Colors.black45
        : (isPrimary ? BauhausDesign.surfaceWhite : _inkBlack);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: _inkBlack, width: 2),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
        ),
      ),
    );
  }
}
