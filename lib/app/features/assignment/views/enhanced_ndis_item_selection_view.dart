import 'dart:async';

import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/backend/api_method.dart';

class EnhancedNdisItemSelectionResult {
  final NDISItem ndisItem;
  final double? customPrice;
  final String pricingType; // 'standard', 'high_intensity', 'custom'
  final bool isCustomPriceSet;
  final Map<String, dynamic>? customPricing;

  EnhancedNdisItemSelectionResult({
    required this.ndisItem,
    this.customPrice,
    required this.pricingType,
    required this.isCustomPriceSet,
    this.customPricing,
  });
}

class EnhancedNdisItemSelectionView extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? clientId;
  final bool highIntensity;
  final String? userState; // Australian state for pricing

  const EnhancedNdisItemSelectionView({
    super.key,
    this.organizationId,
    this.clientId,
    this.highIntensity = false,
    this.userState,
  });

  @override
  ConsumerState<EnhancedNdisItemSelectionView> createState() =>
      _EnhancedNdisItemSelectionViewState();
}

class _EnhancedNdisItemSelectionViewState
    extends ConsumerState<EnhancedNdisItemSelectionView> {
  static const int _pricingChunkSize = 160;
  static const double _prefetchTriggerPx = 600;
  static const Duration _searchDebounceDelay = Duration(milliseconds: 250);
  static const String _scopeOrganization = 'organization';
  static const String _scopeClient = 'client';

  late final NDISMatcher _ndisMatcher;
  late final ApiMethod _apiMethod;
  final SharedPreferencesUtils _sharedPrefs = SharedPreferencesUtils();
  final ScrollController _listScrollController = ScrollController();

  List<NDISItem> _allNdisItems = [];
  List<NDISItem> _filteredNdisItems = [];
  final Map<String, Map<String, dynamic>> _pricingData = {};
  final Set<String> _loadedPricingItems = <String>{};
  final Set<String> _pricingItemsInFlight = <String>{};
  bool _isLoading = true;
  bool _isLoadingCustomPrices = false; // Track loading of custom prices
  bool _queueAnotherPricingPass = false;
  String _searchQuery = '';
  String _userState = 'NSW'; // Default state
  String? _resolvedOrganizationId;
  double? _fallbackBaseRate; // Cached organization fallback base rate
  Timer? _searchDebounce;

  // Price override controls
  final Map<String, TextEditingController> _priceControllers = {};
  final Map<String, bool> _showPriceOverride = {};
  final Map<String, bool> _isCustomPriceEnabled = {};
  final Map<String, String> _selectedPricingScope = {};
  final Map<String, bool> _isSavingCustomPrice = {}; // Track saving status

  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(app_providers.apiMethodProvider);
    _ndisMatcher = NDISMatcher(apiMethod: _apiMethod);
    _listScrollController.addListener(_onListScroll);
    _initializeUserState();
    _loadNdisItems();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _listScrollController.dispose();

    // Dispose all price controllers
    for (final controller in _priceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onListScroll() {
    if (_isLoading ||
        _isLoadingCustomPrices ||
        !_listScrollController.hasClients) {
      return;
    }

    final position = _listScrollController.position;
    if (position.maxScrollExtent - position.pixels <= _prefetchTriggerPx) {
      unawaited(_loadPricingData());
    }
  }

  void _applyFilters() {
    final lowerQuery = _searchQuery.trim().toLowerCase();
    final searchFiltered = lowerQuery.isEmpty
        ? _allNdisItems
        : _allNdisItems.where((item) {
            return item.itemNumber.toLowerCase().contains(lowerQuery) ||
                item.itemName.toLowerCase().contains(lowerQuery);
          }).toList();

    if (widget.highIntensity) {
      _filteredNdisItems = searchFiltered.where((item) {
        final itemData = _pricingData[item.itemNumber];
        return itemData != null && itemData['hasHighIntensityPricing'] == true;
      }).toList();
      return;
    }

    _filteredNdisItems = searchFiltered;
  }

  Future<String?> _resolveOrganizationId() async {
    if (widget.organizationId != null) return widget.organizationId;
    if (_resolvedOrganizationId != null) return _resolvedOrganizationId;

    await _sharedPrefs.init();
    _resolvedOrganizationId = _sharedPrefs.getString('organizationId');
    return _resolvedOrganizationId;
  }

  List<NDISItem> _getItemsForPricingLoad() {
    final sourceItems = widget.highIntensity
        ? _allNdisItems
        : (_searchQuery.trim().isNotEmpty ? _filteredNdisItems : _allNdisItems);

    final itemsToLoad = <NDISItem>[];
    for (final item in sourceItems) {
      final itemNumber = item.itemNumber;
      if (_loadedPricingItems.contains(itemNumber) ||
          _pricingItemsInFlight.contains(itemNumber)) {
        continue;
      }
      itemsToLoad.add(item);
      if (itemsToLoad.length >= _pricingChunkSize) break;
    }
    return itemsToLoad;
  }

  bool _hasPendingPricingItems() {
    final sourceItems = widget.highIntensity
        ? _allNdisItems
        : (_searchQuery.trim().isNotEmpty ? _filteredNdisItems : _allNdisItems);
    for (final item in sourceItems) {
      final itemNumber = item.itemNumber;
      if (!_loadedPricingItems.contains(itemNumber) &&
          !_pricingItemsInFlight.contains(itemNumber)) {
        return true;
      }
    }
    return false;
  }

  bool get _hasClientScope =>
      widget.clientId != null && widget.clientId!.trim().isNotEmpty;

  String _getSelectedScope(String itemNumber) {
    final selected = _selectedPricingScope[itemNumber];
    if (selected == _scopeClient && _hasClientScope) return _scopeClient;
    if (selected == _scopeOrganization) return _scopeOrganization;

    final existingData = _pricingData[itemNumber];
    final existingCustomPricing =
        existingData?['customPricing'] as Map<String, dynamic>?;
    if (existingCustomPricing != null) {
      if (existingCustomPricing['clientSpecific'] == true && _hasClientScope) {
        return _scopeClient;
      }
      if (existingCustomPricing['clientSpecific'] == false) {
        return _scopeOrganization;
      }
    }

    return _hasClientScope ? _scopeClient : _scopeOrganization;
  }

  bool _isClientScopeSelected(String itemNumber) {
    return _getSelectedScope(itemNumber) == _scopeClient;
  }

  Map<String, dynamic>? _getCustomPricingForScope(
    String itemNumber, {
    String? scope,
    Map<String, dynamic>? itemData,
  }) {
    final data = itemData ?? _pricingData[itemNumber];
    if (data == null) return null;

    final selectedScope = scope ?? _getSelectedScope(itemNumber);
    final clientCustom = data['clientCustomPricing'] as Map<String, dynamic>?;
    final orgCustom = data['orgCustomPricing'] as Map<String, dynamic>?;
    final fallbackCustom = data['customPricing'] as Map<String, dynamic>?;

    if (selectedScope == _scopeClient) {
      return clientCustom ?? orgCustom ?? fallbackCustom;
    }
    return orgCustom ?? clientCustom ?? fallbackCustom;
  }

  double? _getSavedCustomPriceForScope(String itemNumber, {String? scope}) {
    final customPricing = _getCustomPricingForScope(itemNumber, scope: scope);
    return _toPositiveDouble(customPricing?['customPrice']) ??
        _toPositiveDouble(customPricing?['price']) ??
        _toPositiveDouble(customPricing?['fixedPrice']);
  }

  Map<String, dynamic>? _resolveScopedCustomPricingForItem(
    String itemNumber, {
    Map<String, dynamic>? clientCustomPricing,
    Map<String, dynamic>? orgCustomPricing,
    Map<String, dynamic>? fallbackCustomPricing,
  }) {
    final selectedScope = _getSelectedScope(itemNumber);
    if (selectedScope == _scopeClient) {
      return clientCustomPricing ?? orgCustomPricing ?? fallbackCustomPricing;
    }
    return orgCustomPricing ?? clientCustomPricing ?? fallbackCustomPricing;
  }

  void _setSelectedScope(String itemNumber, String scope, {NDISItem? item}) {
    if (scope == _scopeClient && !_hasClientScope) return;
    if (scope != _scopeClient && scope != _scopeOrganization) return;
    setState(() {
      _selectedPricingScope[itemNumber] = scope;
      final controller = _priceControllers[itemNumber];
      if (controller != null) {
        final scopedPrice = _getSavedCustomPriceForScope(
          itemNumber,
          scope: scope,
        );
        final cappedPrice = item != null ? _getCappedPrice(item) : null;
        final nextPrice = scopedPrice ?? cappedPrice;
        if (nextPrice != null) {
          controller.text = nextPrice.toStringAsFixed(2);
        }
      }
    });
  }

  double? _toPositiveDouble(dynamic value) {
    if (value is num && value > 0) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value.trim());
      if (parsed != null && parsed > 0) return parsed;
    }
    return null;
  }

  Map<String, dynamic> _buildStandardPriceCapsFromItem(NDISItem item) {
    final standard = <String, double>{};

    void addState(String code, PriceRegion region) {
      final value = item.regionalPrices[region];
      if (value != null && value > 0) {
        standard[code] = value;
      }
    }

    addState('ACT', PriceRegion.act);
    addState('NSW', PriceRegion.nsw);
    addState('NT', PriceRegion.nt);
    addState('QLD', PriceRegion.qld);
    addState('SA', PriceRegion.sa);
    addState('TAS', PriceRegion.tas);
    addState('VIC', PriceRegion.vic);
    addState('WA', PriceRegion.wa);

    if (standard.isEmpty) return const <String, dynamic>{};
    return <String, dynamic>{'standard': standard};
  }

  Map<String, dynamic>? _buildSupportItemFromLookup(
    NDISItem item,
    Map<String, dynamic>? pricingLookup,
  ) {
    final rawPriceCaps = pricingLookup?['priceCaps'];
    Map<String, dynamic>? normalizedPriceCaps;

    if (rawPriceCaps is Map<String, dynamic>) {
      normalizedPriceCaps = Map<String, dynamic>.from(rawPriceCaps);
    } else if (rawPriceCaps is Map) {
      normalizedPriceCaps = Map<String, dynamic>.from(rawPriceCaps);
    }

    normalizedPriceCaps ??= _buildStandardPriceCapsFromItem(item);
    if (normalizedPriceCaps.isEmpty) return null;

    return <String, dynamic>{
      'supportItemNumber': item.itemNumber,
      'supportItemName': pricingLookup?['supportItemName'] ?? item.itemName,
      'priceCaps': normalizedPriceCaps,
    };
  }

  Map<String, dynamic>? _buildCustomPricingFromLookup(
    Map<String, dynamic>? pricingLookup,
  ) {
    if (pricingLookup == null) return null;

    final source = pricingLookup['source']?.toString().toLowerCase().trim();
    final isCustomSource =
        source == 'client_specific' ||
        source == 'client-specific' ||
        source == 'organization' ||
        source == 'organization_specific' ||
        source == 'organization-specific';
    if (!isCustomSource) return null;

    final resolvedPrice =
        _toPositiveDouble(pricingLookup['customPrice']) ??
        _toPositiveDouble(pricingLookup['price']) ??
        _toPositiveDouble(pricingLookup['fixedPrice']);
    if (resolvedPrice == null) return null;

    final isClientSpecific =
        pricingLookup['clientSpecific'] == true ||
        source == 'client_specific' ||
        source == 'client-specific';
    final pricingClientId = pricingLookup['clientId'];

    return <String, dynamic>{
      'price': resolvedPrice,
      'customPrice': resolvedPrice,
      'fixedPrice': resolvedPrice,
      'clientSpecific': isClientSpecific,
      'clientId': pricingClientId,
      'source': isClientSpecific
          ? 'Client Custom Price'
          : 'Organization Custom Price',
    };
  }

  Map<String, dynamic> _buildPricingEntry(
    NDISItem item, {
    Map<String, dynamic>? clientAwareLookup,
    Map<String, dynamic>? organizationLookup,
  }) {
    final clientAwareCustom = _buildCustomPricingFromLookup(clientAwareLookup);
    final organizationCustom = _buildCustomPricingFromLookup(
      organizationLookup,
    );

    Map<String, dynamic>? clientCustomPricing;
    if (clientAwareCustom != null &&
        clientAwareCustom['clientSpecific'] == true) {
      clientCustomPricing = clientAwareCustom;
    }

    Map<String, dynamic>? orgCustomPricing;
    if (organizationCustom != null &&
        organizationCustom['clientSpecific'] == false) {
      orgCustomPricing = organizationCustom;
    } else if (clientAwareCustom != null &&
        clientAwareCustom['clientSpecific'] == false) {
      orgCustomPricing = clientAwareCustom;
    }

    final customPricingData = _resolveScopedCustomPricingForItem(
      item.itemNumber,
      clientCustomPricing: clientCustomPricing,
      orgCustomPricing: orgCustomPricing,
      fallbackCustomPricing: clientAwareCustom ?? organizationCustom,
    );
    final supportItem =
        _buildSupportItemFromLookup(item, clientAwareLookup) ??
        _buildSupportItemFromLookup(item, organizationLookup);

    final priceCaps = supportItem?['priceCaps'];
    final hasHighIntensityPricing =
        priceCaps is Map<String, dynamic> && priceCaps['highIntensity'] != null;

    return <String, dynamic>{
      'clientCustomPricing': clientCustomPricing,
      'orgCustomPricing': orgCustomPricing,
      'customPricing': customPricingData,
      'supportItem': supportItem,
      'hasHighIntensityPricing': hasHighIntensityPricing,
    };
  }

  Future<void> _initializeUserState() async {
    await _sharedPrefs.init();

    // Get client state from SharedPreferences if client ID is provided
    String? clientState;
    if (widget.clientId != null) {
      clientState = _sharedPrefs.getString('clientState');
    }

    final state =
        widget.userState ??
        clientState ??
        _sharedPrefs.getString('userState') ??
        'NSW';
    if (!mounted) return;
    setState(() {
      _userState = state;
    });
  }

  Future<void> _loadNdisItems() async {
    try {
      await _ndisMatcher.loadItems();
      if (!mounted) return;
      setState(() {
        _allNdisItems = _ndisMatcher.items;
        _applyFilters();
        _isLoading = false;
      });
      unawaited(_loadPricingData());
    } catch (e, s) {
      log.severe(
        "Failed to load NDIS items in EnhancedNdisItemSelectionView",
        e,
        s,
      );
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load NDIS items. Please try again.'),
          ),
        );
      }
    }
  }

  /// Load pricing data for all currently filtered NDIS items.
  ///
  /// - Fetches custom pricing and support item details in batches.
  /// - Caches organization fallback base rate and uses it in `_getCappedPrice`
  ///   when no cap/state price exists.
  /// - Applies high-intensity filtering after pricing data loads.
  Future<void> _loadPricingData() async {
    if (_isLoading || _isLoadingCustomPrices) {
      _queueAnotherPricingPass = true;
      return;
    }

    final organizationId = await _resolveOrganizationId();
    if (organizationId == null) return;

    final itemsToLoad = _getItemsForPricingLoad();
    if (itemsToLoad.isEmpty) return;

    if (!mounted) return;
    setState(() {
      _isLoadingCustomPrices = true;
      _pricingItemsInFlight.addAll(
        itemsToLoad.map((item) => item.itemNumber).toList(),
      );
    });

    final loadedItemNumbers = <String>{};
    try {
      final itemNumbers = itemsToLoad.map((item) => item.itemNumber).toList();

      final responses = await Future.wait<Map<String, dynamic>?>([
        _apiMethod.getBulkPricingLookupResponse(
          organizationId,
          itemNumbers,
          clientId: widget.clientId,
        ),
        if (_hasClientScope)
          _apiMethod.getBulkPricingLookupResponse(organizationId, itemNumbers),
      ]);
      final bulkResponse = responses.first;
      final organizationOnlyResponse = _hasClientScope && responses.length > 1
          ? responses[1]
          : null;

      final bulkPricingData = bulkResponse?['data'] is Map
          ? Map<String, dynamic>.from(bulkResponse!['data'] as Map)
          : <String, dynamic>{};
      final organizationOnlyPricingData =
          organizationOnlyResponse?['data'] is Map
          ? Map<String, dynamic>.from(organizationOnlyResponse!['data'] as Map)
          : <String, dynamic>{};
      final metadata = bulkResponse?['metadata'] is Map
          ? Map<String, dynamic>.from(bulkResponse!['metadata'] as Map)
          : <String, dynamic>{};

      if (_fallbackBaseRate == null) {
        final fallbackFromMetadata = _toPositiveDouble(
          metadata['fallbackBaseRate'],
        );
        if (fallbackFromMetadata != null) {
          _fallbackBaseRate = double.parse(
            fallbackFromMetadata.toStringAsFixed(2),
          );
        } else {
          final fallbackFromApi = await _apiMethod.getFallbackBaseRate(
            organizationId,
          );
          if (fallbackFromApi != null && fallbackFromApi > 0) {
            _fallbackBaseRate = double.parse(
              fallbackFromApi.toStringAsFixed(2),
            );
          }
        }
      }

      final updates = <String, Map<String, dynamic>>{};
      for (final item in itemsToLoad) {
        final lookup = bulkPricingData[item.itemNumber];
        final lookupMap = lookup is Map<String, dynamic>
            ? lookup
            : (lookup is Map ? Map<String, dynamic>.from(lookup) : null);
        final orgLookup = organizationOnlyPricingData[item.itemNumber];
        final orgLookupMap = orgLookup is Map<String, dynamic>
            ? orgLookup
            : (orgLookup is Map ? Map<String, dynamic>.from(orgLookup) : null);
        updates[item.itemNumber] = _buildPricingEntry(
          item,
          clientAwareLookup: lookupMap,
          organizationLookup: orgLookupMap,
        );
        loadedItemNumbers.add(item.itemNumber);
      }

      if (mounted) {
        setState(() {
          updates.forEach((itemNumber, newData) {
            _pricingData[itemNumber] = newData;
          });
          _applyFilters();
          if (_fallbackBaseRate != null && _fallbackBaseRate! > 0) {
            _fallbackBaseRate = double.parse(
              _fallbackBaseRate!.toStringAsFixed(2),
            );
          }
        });
      } else {
        if (_fallbackBaseRate != null && _fallbackBaseRate! > 0) {
          _fallbackBaseRate = double.parse(
            _fallbackBaseRate!.toStringAsFixed(2),
          );
        }
      }
    } catch (e) {
      log.warning('Failed to load pricing data: $e');
    } finally {
      final itemNumbers = itemsToLoad.map((item) => item.itemNumber).toList();
      _pricingItemsInFlight.removeAll(itemNumbers);
      _loadedPricingItems.addAll(loadedItemNumbers);

      if (mounted) {
        setState(() {
          _isLoadingCustomPrices = false;
          _applyFilters();
        });
      } else {
        _isLoadingCustomPrices = false;
      }
    }

    final shouldContinue =
        _queueAnotherPricingPass ||
        (widget.highIntensity && _hasPendingPricingItems());
    _queueAnotherPricingPass = false;
    if (shouldContinue) {
      unawaited(_loadPricingData());
    }
  }

  Future<void> _refreshPricingForItem(String itemNumber) async {
    final organizationId = await _resolveOrganizationId();
    if (organizationId == null) return;

    try {
      final item = _allNdisItems.firstWhere(
        (entry) => entry.itemNumber == itemNumber,
        orElse: () => NDISItem(
          itemNumber: itemNumber,
          itemName: '',
          supportCategoryNumber: '',
          supportCategoryName: '',
          registrationGroupNumber: '',
          registrationGroupName: '',
          unit: '',
          type: 'Unknown',
          isQuotable: false,
          regionalPrices: const <PriceRegion, double?>{},
          supportPurposeId: '0',
          generalCategory: 'Unknown',
        ),
      );

      final responses = await Future.wait<Map<String, dynamic>?>([
        _apiMethod.getBulkPricingLookupResponse(organizationId, [
          itemNumber,
        ], clientId: widget.clientId),
        if (_hasClientScope)
          _apiMethod.getBulkPricingLookupResponse(organizationId, [itemNumber]),
      ]);
      final response = responses.first;
      final organizationOnlyResponse = _hasClientScope && responses.length > 1
          ? responses[1]
          : null;

      final data = response?['data'] is Map
          ? Map<String, dynamic>.from(response!['data'] as Map)
          : const <String, dynamic>{};
      final organizationOnlyData = organizationOnlyResponse?['data'] is Map
          ? Map<String, dynamic>.from(organizationOnlyResponse!['data'] as Map)
          : const <String, dynamic>{};
      final lookup = data[itemNumber];
      final lookupMap = lookup is Map<String, dynamic>
          ? lookup
          : (lookup is Map ? Map<String, dynamic>.from(lookup) : null);
      final orgLookup = organizationOnlyData[itemNumber];
      final orgLookupMap = orgLookup is Map<String, dynamic>
          ? orgLookup
          : (orgLookup is Map ? Map<String, dynamic>.from(orgLookup) : null);

      final newData = _buildPricingEntry(
        item,
        clientAwareLookup: lookupMap,
        organizationLookup: orgLookupMap,
      );

      if (!mounted) return;
      setState(() {
        _pricingData[itemNumber] = newData;
        _loadedPricingItems.add(itemNumber);
        _applyFilters();
      });
    } catch (e) {
      log.warning('Failed to refresh pricing for item $itemNumber: $e');
    }
  }

  void _filterNdisItems(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDelay, () {
      if (!mounted) return;
      setState(() {
        _searchQuery = query;
        _applyFilters();
      });
      unawaited(_loadPricingData());
    });
  }

  /// Resolve the capped price for an NDIS item.
  ///
  /// Priority:
  /// 1) State-specific cap (client or user state)
  /// 2) Standard caps when high-intensity is unavailable
  /// 3) Organization fallback base rate when no caps are available
  ///
  /// Always returns a rounded 2-decimal price.
  double _getCappedPrice(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    final clientState = _sharedPrefs.getString('clientState')?.toUpperCase();

    double? resolveStatePrice(Map<String, dynamic>? statePrices) {
      if (statePrices == null) return null;
      if (clientState != null && statePrices.containsKey(clientState)) {
        return _toPositiveDouble(statePrices[clientState]);
      }
      final userState = _userState.toUpperCase();
      if (statePrices.containsKey(userState)) {
        return _toPositiveDouble(statePrices[userState]);
      }
      return null;
    }

    if (pricingData?['supportItem'] != null) {
      final supportItem = pricingData!['supportItem'] as Map<String, dynamic>;
      final priceCaps = supportItem['priceCaps'];

      if (priceCaps is Map<String, dynamic>) {
        final intensityType = widget.highIntensity
            ? 'highIntensity'
            : 'standard';
        final statePrices = priceCaps[intensityType];

        if (statePrices is Map<String, dynamic>) {
          final direct = resolveStatePrice(statePrices);
          if (direct != null) return direct;
        } else if (statePrices is Map) {
          final direct = resolveStatePrice(
            Map<String, dynamic>.from(statePrices),
          );
          if (direct != null) return direct;
        } else if (widget.highIntensity) {
          final standardPrices = priceCaps['standard'];
          if (standardPrices is Map<String, dynamic>) {
            final fallbackStandard = resolveStatePrice(standardPrices);
            if (fallbackStandard != null) return fallbackStandard;
          } else if (standardPrices is Map) {
            final fallbackStandard = resolveStatePrice(
              Map<String, dynamic>.from(standardPrices),
            );
            if (fallbackStandard != null) return fallbackStandard;
          }
        }
      }
    }

    final regionalState = clientState ?? _userState;
    final regionalMap = <String, PriceRegion>{
      'ACT': PriceRegion.act,
      'NSW': PriceRegion.nsw,
      'NT': PriceRegion.nt,
      'QLD': PriceRegion.qld,
      'SA': PriceRegion.sa,
      'TAS': PriceRegion.tas,
      'VIC': PriceRegion.vic,
      'WA': PriceRegion.wa,
    };
    final fallbackRegion = regionalMap[regionalState];
    if (fallbackRegion != null) {
      final fromItem = item.regionalPrices[fallbackRegion];
      if (fromItem != null && fromItem > 0) {
        return double.parse(fromItem.toStringAsFixed(2));
      }
    }

    return double.parse((_fallbackBaseRate ?? 30.00).toStringAsFixed(2));
  }

  double _getCurrentPrice(NDISItem item) {
    final customPricing = _getCustomPricingForScope(item.itemNumber);

    if (customPricing != null) {
      final customPrice =
          customPricing['customPrice'] ??
          customPricing['price'] ??
          customPricing['fixedPrice'];

      if (customPrice is num) {
        return customPrice.toDouble();
      }
    }

    return _getCappedPrice(item);
  }

  String _getPricingSource(NDISItem item) {
    final itemPricing = _pricingData[item.itemNumber];
    final customPricing = _getCustomPricingForScope(item.itemNumber);

    if (customPricing != null) {
      final hasCustomPrice =
          customPricing['customPrice'] != null ||
          customPricing['price'] != null ||
          customPricing['fixedPrice'] != null;

      if (hasCustomPrice) {
        final isClientSpecific = customPricing['clientSpecific'] == true;
        return customPricing['source'] as String? ??
            (isClientSpecific
                ? 'Client Custom Price'
                : 'Organization Custom Price');
      }
    }

    final supportItem = itemPricing?['supportItem'];
    if (supportItem is Map &&
        supportItem['priceCaps'] is Map &&
        (supportItem['priceCaps'] as Map).isNotEmpty) {
      return 'Standard NDIS Rate';
    }

    if ((_fallbackBaseRate ?? 0) > 0) {
      return 'Organization Base Rate';
    }

    return 'Standard NDIS Rate';
  }

  void _togglePriceOverride(String itemNumber) {
    setState(() {
      _showPriceOverride[itemNumber] =
          !(_showPriceOverride[itemNumber] ?? false);
      if (_showPriceOverride[itemNumber] == true) {
        // Initialize controller with current price
        final item = _filteredNdisItems.firstWhere(
          (item) => item.itemNumber == itemNumber,
        );
        _priceControllers[itemNumber] = TextEditingController(
          text: _getCurrentPrice(item).toStringAsFixed(2),
        );
        _selectedPricingScope[itemNumber] = _getSelectedScope(itemNumber);
      } else {
        // Dispose controller
        _priceControllers[itemNumber]?.dispose();
        _priceControllers.remove(itemNumber);
        _isCustomPriceEnabled[itemNumber] = false;
      }
    });
  }

  void _selectItem(NDISItem item) {
    final isCustomPriceSet = _isCustomPriceEnabled[item.itemNumber] ?? false;
    final isClientSpecificScope = _isClientScopeSelected(item.itemNumber);
    double? customPrice;
    String pricingType = widget.highIntensity ? 'high_intensity' : 'standard';
    Map<String, dynamic>? customPricingData;

    if (isCustomPriceSet && _priceControllers[item.itemNumber] != null) {
      customPrice = double.tryParse(_priceControllers[item.itemNumber]!.text);
      pricingType = 'custom';

      // Create custom pricing data structure that matches backend expectations
      if (customPrice != null) {
        customPricingData = {
          'price': customPrice,
          'pricingType': 'fixed', // Backend expects 'fixed' for custom prices
          'isCustom': true, // This is the key field the backend checks
          'clientSpecific': isClientSpecificScope,
          'clientId': isClientSpecificScope ? widget.clientId?.trim() : null,
        };
      }
    }

    final result = EnhancedNdisItemSelectionResult(
      ndisItem: item,
      customPrice: customPrice,
      pricingType: pricingType,
      isCustomPriceSet: isCustomPriceSet,
      customPricing: customPricingData,
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        title: Text(
          'Select NDIS Item',
          style: BauhausDesign.getTextTheme(
            context,
          ).titleLarge?.copyWith(color: BauhausDesign.textDark),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: _filterNdisItems,
                  decoration: BauhausDesign.defaultInputDecoration.copyWith(
                    labelText: 'Search by Item Number or Description',
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  decoration: BoxDecoration(
                    color: BauhausDesign.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(
                      color: BauhausDesign.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: BauhausDesign.primary,
                        size: 20,
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Text(
                          'Pricing shown for ${widget.highIntensity ? "High Intensity" : "Standard"} rates in $_userState. Tap the price icon to set custom pricing.',
                          style: BauhausDesign.getTextTheme(context).labelSmall
                              ?.copyWith(color: BauhausDesign.textMuted),
                        ),
                      ),
                      if (_isLoadingCustomPrices) ...[
                        const SizedBox(width: BauhausDesign.space3),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              BauhausDesign.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space2),
                        Text(
                          'Loading...',
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).labelSmall?.copyWith(color: BauhausDesign.primary),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : Expanded(
                  child: _filteredNdisItems.isEmpty && _searchQuery.isNotEmpty
                      ? const Center(
                          child: Text('No matching NDIS items found.'),
                        )
                      : ListView.builder(
                          controller: _listScrollController,
                          cacheExtent: 1200,
                          itemCount: _filteredNdisItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredNdisItems[index];
                            return _buildNdisItemCard(item);
                          },
                        ),
                ),
        ],
      ),
    );
  }

  Widget _buildNdisItemCard(NDISItem item) {
    final currentPrice = _getCurrentPrice(item);
    final cappedPrice = _getCappedPrice(item);
    final pricingSource = _getPricingSource(item);
    final showOverride = _showPriceOverride[item.itemNumber] ?? false;

    return BauhausCard(
      margin: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space2,
      ),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _selectItem(item),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              child: Padding(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.itemName,
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: BauhausDesign.space1),
                          Text(
                            item.itemNumber,
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(color: BauhausDesign.textMuted),
                          ),
                          const SizedBox(height: BauhausDesign.space2),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: BauhausDesign.space2,
                                  vertical: BauhausDesign.space1,
                                ),
                                decoration: BoxDecoration(
                                  color: currentPrice != cappedPrice
                                      ? BauhausDesign.warning.withOpacity(0.1)
                                      : BauhausDesign.success.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(
                                    BauhausDesign.radiusPill,
                                  ),
                                ),
                                child: Text(
                                  '\$${currentPrice.toStringAsFixed(2)}/hr',
                                  style: BauhausDesign.getTextTheme(context)
                                      .labelSmall
                                      ?.copyWith(
                                        color: currentPrice != cappedPrice
                                            ? BauhausDesign.warning
                                            : BauhausDesign.success,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              const SizedBox(width: BauhausDesign.space2),
                              Text(
                                pricingSource,
                                style: BauhausDesign.getTextTheme(context)
                                    .labelSmall
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                      fontSize: 10,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            showOverride
                                ? Icons.expand_less
                                : Icons.attach_money,
                            color: showOverride
                                ? BauhausDesign.primary
                                : BauhausDesign.textMuted,
                          ),
                          onPressed: () =>
                              _togglePriceOverride(item.itemNumber),
                          tooltip: 'Set custom price',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: BauhausDesign.textMuted,
                          ),
                          onPressed: () => _selectItem(item),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          style: IconButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showOverride) _buildPriceOverrideSection(item),
        ],
      ),
    );
  }

  Widget _buildPriceOverrideSection(NDISItem item) {
    final cappedPrice = _getCappedPrice(item);
    final currentPrice = _getCurrentPrice(item);
    final controller = _priceControllers[item.itemNumber];
    final isCustomEnabled = _isCustomPriceEnabled[item.itemNumber] ?? false;
    final bool isSaving = _isSavingCustomPrice[item.itemNumber] ?? false;
    final hasClientScope = _hasClientScope;
    final isClientScopeSelected = _isClientScopeSelected(item.itemNumber);
    final scopeLabel = isClientScopeSelected ? 'CLIENT-SPECIFIC' : 'ORG-WIDE';
    final scopeColor = isClientScopeSelected
        ? BauhausDesign.secondary
        : BauhausDesign.warning;
    final scopeTextColor = isClientScopeSelected
        ? BauhausDesign.surfaceWhite
        : BauhausDesign.textDark;
    final toggleBackground = isCustomEnabled
        ? BauhausDesign.textDark
        : BauhausDesign.surfaceLight;
    final toggleTextColor = isCustomEnabled
        ? BauhausDesign.surfaceWhite
        : BauhausDesign.textDark;
    final toggleIconColor = isCustomEnabled
        ? BauhausDesign.surfaceWhite
        : BauhausDesign.textMuted;
    final orgSavedPrice = _getSavedCustomPriceForScope(
      item.itemNumber,
      scope: _scopeOrganization,
    );
    final clientSavedPrice = _getSavedCustomPriceForScope(
      item.itemNumber,
      scope: _scopeClient,
    );

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border(top: BorderSide(color: BauhausDesign.neutral, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: scopeColor,
                  border: Border.all(color: BauhausDesign.textDark, width: 2),
                ),
                child: Text(
                  scopeLabel,
                  style: BauhausDesign.neoMonoStyle(
                    context,
                    fontSize: 11,
                    color: scopeTextColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  'CUSTOM PRICE OVERRIDE',
                  style: BauhausDesign.neoMonoStyle(
                    context,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space2),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceLight,
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CAP RATE',
                        style: BauhausDesign.neoMonoStyle(
                          context,
                          fontSize: 10,
                          color: BauhausDesign.textMuted,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        '\$${cappedPrice.toStringAsFixed(2)}/hr',
                        style: BauhausDesign.getTextTheme(context).labelLarge
                            ?.copyWith(
                              color: BauhausDesign.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space2),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceLight,
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CURRENT',
                        style: BauhausDesign.neoMonoStyle(
                          context,
                          fontSize: 10,
                          color: BauhausDesign.textMuted,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        '\$${currentPrice.toStringAsFixed(2)}/hr',
                        style: BauhausDesign.getTextTheme(context).labelLarge
                            ?.copyWith(
                              color: BauhausDesign.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (hasClientScope) ...[
            const SizedBox(height: BauhausDesign.space3),
            Row(
              children: [
                Expanded(
                  child: _buildScopeButton(
                    label: 'ORG PRICE',
                    scope: _scopeOrganization,
                    selectedScope: _getSelectedScope(item.itemNumber),
                    onTap: () => _setSelectedScope(
                      item.itemNumber,
                      _scopeOrganization,
                      item: item,
                    ),
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: _buildScopeButton(
                    label: 'CLIENT PRICE',
                    scope: _scopeClient,
                    selectedScope: _getSelectedScope(item.itemNumber),
                    onTap: () => _setSelectedScope(
                      item.itemNumber,
                      _scopeClient,
                      item: item,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space2),
            Row(
              children: [
                Expanded(
                  child: _buildSavedPriceTile(
                    label: 'ORG SAVED',
                    price: orgSavedPrice,
                    accent: BauhausDesign.warning,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: _buildSavedPriceTile(
                    label: 'CLIENT SAVED',
                    price: clientSavedPrice,
                    accent: BauhausDesign.secondary,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: BauhausDesign.space3),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  final nextValue = !(isCustomEnabled);
                  _isCustomPriceEnabled[item.itemNumber] = nextValue;
                  if (!nextValue) {
                    controller?.text = cappedPrice.toStringAsFixed(2);
                  }
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: toggleBackground,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(
                      isCustomEnabled
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: toggleIconColor,
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: Text(
                        'Enable custom price for this support item',
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: toggleTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isCustomEnabled) ...[
            const SizedBox(height: BauhausDesign.space3),
            TextFormField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              decoration: BauhausDesign.defaultInputDecoration.copyWith(
                labelText: 'Custom Price (\$/hour)',
                helperText: isClientScopeSelected
                    ? 'This will override pricing only for this client.'
                    : 'This will apply across the organization.',
                prefixIcon: const Icon(Icons.attach_money),
                filled: true,
                fillColor: BauhausDesign.surfaceWhite,
                labelStyle: BauhausDesign.getTextTheme(context).bodyMedium
                    ?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                floatingLabelStyle: BauhausDesign.getTextTheme(context)
                    .bodyMedium
                    ?.copyWith(
                      color: BauhausDesign.primary,
                      fontWeight: FontWeight.w700,
                    ),
                hintStyle: BauhausDesign.getTextTheme(context).bodyMedium
                    ?.copyWith(color: BauhausDesign.textDark.withOpacity(0.96)),
                helperStyle: BauhausDesign.getTextTheme(context).labelMedium
                    ?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                prefixIconColor: BauhausDesign.textDark,
              ),
              style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(BauhausDesign.space2),
              decoration: BoxDecoration(
                color: BauhausDesign.warning.withOpacity(0.12),
                border: Border.all(color: BauhausDesign.warning, width: 2),
              ),
              child: Text(
                isClientScopeSelected
                    ? 'Saved as CLIENT-SPECIFIC pricing for this organization.'
                    : 'Saved as ORGANIZATION-WIDE pricing.',
                style: BauhausDesign.getTextTheme(context).labelMedium
                    ?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space3),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        final price = double.tryParse(controller?.text ?? '');
                        if (price == null || price <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a valid price'),
                            ),
                          );
                          return;
                        }

                        if (price > cappedPrice) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Price cannot exceed the max capped price',
                              ),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          _isSavingCustomPrice[item.itemNumber] = true;
                        });

                        try {
                          await _sharedPrefs.init();
                          final userEmail = _sharedPrefs.getString('userEmail');
                          final orgId = await _resolveOrganizationId();

                          if (orgId == null ||
                              orgId.trim().isEmpty ||
                              userEmail == null ||
                              userEmail.trim().isEmpty) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Missing organization ID or user email',
                                  ),
                                ),
                              );
                            }
                            return;
                          }

                          Map<String, dynamic> result;
                          if (isClientScopeSelected && hasClientScope) {
                            result = await _apiMethod.saveClientCustomPricing(
                              orgId,
                              widget.clientId!.trim(),
                              item.itemNumber,
                              price,
                              'fixed',
                              userEmail.trim(),
                              supportItemName: item.itemName,
                            );
                          } else {
                            result = await _apiMethod.saveAsCustomPricing(
                              orgId,
                              item.itemNumber,
                              price,
                              'fixed',
                              userEmail.trim(),
                              supportItemName: item.itemName,
                            );
                          }

                          if (result['success'] == true) {
                            if (mounted) {
                              setState(() {
                                final customPricingData = {
                                  'price': price,
                                  'customPrice': price,
                                  'fixedPrice': price,
                                  'clientSpecific': isClientScopeSelected,
                                  'clientId': isClientScopeSelected
                                      ? widget.clientId?.trim()
                                      : null,
                                  'source': isClientScopeSelected
                                      ? 'Client Custom Price'
                                      : 'Organization Custom Price',
                                  'updatedAt': DateTime.now().toIso8601String(),
                                };
                                final existingEntry =
                                    _pricingData[item.itemNumber] ??
                                    <String, dynamic>{};
                                final existingClientCustom =
                                    existingEntry['clientCustomPricing']
                                        as Map<String, dynamic>?;
                                final existingOrgCustom =
                                    existingEntry['orgCustomPricing']
                                        as Map<String, dynamic>?;
                                final updatedClientCustom =
                                    isClientScopeSelected
                                    ? customPricingData
                                    : existingClientCustom;
                                final updatedOrgCustom = isClientScopeSelected
                                    ? existingOrgCustom
                                    : customPricingData;
                                final scopedCustom =
                                    _resolveScopedCustomPricingForItem(
                                      item.itemNumber,
                                      clientCustomPricing: updatedClientCustom,
                                      orgCustomPricing: updatedOrgCustom,
                                      fallbackCustomPricing: customPricingData,
                                    );

                                _pricingData[item.itemNumber] = {
                                  ...existingEntry,
                                  'clientCustomPricing': updatedClientCustom,
                                  'orgCustomPricing': updatedOrgCustom,
                                  'customPricing': scopedCustom,
                                };
                                _showPriceOverride[item.itemNumber] = false;
                                _isCustomPriceEnabled[item.itemNumber] = true;
                              });
                            }

                            await _refreshPricingForItem(item.itemNumber);

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isClientScopeSelected
                                        ? 'Client-specific custom price saved'
                                        : 'Organization custom price saved',
                                  ),
                                ),
                              );
                            }
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to save custom price: ${result['message']}',
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error saving custom price: $e'),
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isSavingCustomPrice[item.itemNumber] = false;
                            });
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: BauhausDesign.primary,
                  foregroundColor: BauhausDesign.surfaceWhite,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    vertical: BauhausDesign.space3,
                  ),
                  side: const BorderSide(
                    color: BauhausDesign.neutral,
                    width: 2,
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: BauhausDesign.surfaceWhite,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        isClientScopeSelected
                            ? 'SAVE CLIENT PRICE'
                            : 'SAVE ORG PRICE',
                        style: BauhausDesign.neoMonoStyle(context).copyWith(
                          color: BauhausDesign.surfaceWhite,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScopeButton({
    required String label,
    required String scope,
    required String selectedScope,
    required VoidCallback onTap,
  }) {
    final isSelected = scope == selectedScope;
    final selectedColor = scope == _scopeClient
        ? BauhausDesign.secondary
        : BauhausDesign.warning;
    final backgroundColor = isSelected
        ? selectedColor
        : BauhausDesign.surfaceLight;
    final textColor = isSelected
        ? (scope == _scopeClient
              ? BauhausDesign.surfaceWhite
              : BauhausDesign.textDark)
        : BauhausDesign.textDark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: BauhausDesign.textDark, width: 2),
          ),
          child: Text(
            label,
            style: BauhausDesign.neoMonoStyle(context).copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSavedPriceTile({
    required String label,
    required double? price,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.12),
        border: Border.all(color: accent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: BauhausDesign.neoMonoStyle(
              context,
              fontSize: 10,
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            price != null ? '\$${price.toStringAsFixed(2)}/hr' : 'Not set',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
