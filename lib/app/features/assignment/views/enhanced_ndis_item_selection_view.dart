import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

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
  final NDISMatcher _ndisMatcher = NDISMatcher();
  final ApiMethod _apiMethod = ApiMethod();
  final SharedPreferencesUtils _sharedPrefs = SharedPreferencesUtils();

  List<NDISItem> _allNdisItems = [];
  List<NDISItem> _filteredNdisItems = [];
  final Map<String, Map<String, dynamic>> _pricingData = {};
  bool _isLoading = true;
  bool _isLoadingCustomPrices = false; // Track loading of custom prices
  String _searchQuery = '';
  String _userState = 'NSW'; // Default state
  double? _fallbackBaseRate; // Cached organization fallback base rate

  // Price override controls
  final Map<String, TextEditingController> _priceControllers = {};
  final Map<String, bool> _showPriceOverride = {};
  final Map<String, bool> _isCustomPriceEnabled = {};
  final Map<String, bool> _isSavingCustomPrice = {}; // Track saving status

  @override
  void initState() {
    super.initState();
    _initializeUserState();
    _loadNdisItems();
  }

  @override
  void dispose() {
    // Dispose all price controllers
    for (final controller in _priceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _initializeUserState() async {
    await _sharedPrefs.init();
    String? orgID = _sharedPrefs.getString('organizationId');
    debugPrint('DEBUG: _initializeUserState orgID: $orgID');

    // Get client state from SharedPreferences if client ID is provided
    String? clientState;
    if (widget.clientId != null) {
      clientState = _sharedPrefs.getString('clientState');
      debugPrint('DEBUG: Client state from SharedPreferences: $clientState');
    }

    final state = widget.userState ??
        clientState ??
        _sharedPrefs.getString('userState') ??
        'NSW';
    setState(() {
      _userState = state;
    });
    debugPrint('DEBUG: Using state for pricing: $_userState');
  }

  Future<void> _loadNdisItems() async {
    debugPrint('DEBUG: _loadNdisItems called');
    debugPrint('  widget.organizationId: ${widget.organizationId}');
    debugPrint('  highIntensity: ${widget.highIntensity}');
    try {
      await _ndisMatcher.loadItems();
      setState(() {
        // Load all items first, then filter them after loading pricing data
        _allNdisItems = _ndisMatcher.items;
        _filteredNdisItems = _allNdisItems;
        _isLoading = false;
      });

      debugPrint('DEBUG: About to call _loadPricingData');
      // Load pricing data for visible items
      await _loadPricingData();
      debugPrint('DEBUG: _loadPricingData completed');

      // Filter items based on high intensity availability if needed
      if (widget.highIntensity) {
        debugPrint('DEBUG: Filtering items for high intensity');
        setState(() {
          _filteredNdisItems = _filteredNdisItems.where((item) {
            final itemData = _pricingData[item.itemNumber];
            return itemData != null &&
                itemData['hasHighIntensityPricing'] == true;
          }).toList();
          debugPrint(
              'DEBUG: Filtered high intensity items count: ${_filteredNdisItems.length}');
        });
      }
    } catch (e, s) {
      log.severe(
          "Failed to load NDIS items in EnhancedNdisItemSelectionView", e, s);
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
    debugPrint('DEBUG: _loadPricingData called');
    debugPrint('  organizationId: ${widget.organizationId}');
    debugPrint('  highIntensity: ${widget.highIntensity}');

    setState(() {
      _isLoadingCustomPrices = true; // Set loading flag to true
    });

    // Get organizationId from widget or SharedPreferences
    String? organizationId = widget.organizationId;
    if (organizationId == null) {
      await _sharedPrefs.init();
      organizationId = _sharedPrefs.getString('organizationId');
      debugPrint(
          '  Retrieved organizationId from SharedPreferences: $organizationId');
    }

    if (organizationId == null) {
      debugPrint(
          '  organizationId is null from both widget and SharedPreferences, returning early');
      return;
    }

    // Load organization fallback base rate once and cache
    try {
      final fb = await _apiMethod.getFallbackBaseRate(organizationId);
      if (fb != null && fb > 0) {
        setState(() {
          _fallbackBaseRate = double.parse(fb.toStringAsFixed(2));
        });
        debugPrint('  Cached fallback base rate: $_fallbackBaseRate');
      }
    } catch (e) {
      debugPrint('  Error fetching fallback base rate: $e');
    }

    try {
      // Load pricing for all filtered items, not just first 20
      final itemsToLoad =
          _filteredNdisItems.isNotEmpty ? _filteredNdisItems : _allNdisItems;
      debugPrint('  itemsToLoad count: ${itemsToLoad.length}');

      // Use batch processing to avoid overwhelming the API
      const batchSize = 50;
      for (int i = 0; i < itemsToLoad.length; i += batchSize) {
        final batch = itemsToLoad.skip(i).take(batchSize).toList();

        await Future.wait(batch.map((item) async {
          try {
            // Get custom pricing data - both organization-wide and client-specific
            final pricingData = organizationId != null
                ? await _apiMethod.getPricingLookup(
                    organizationId,
                    item.itemNumber,
                    clientId: widget.clientId,
                  )
                : null;

            final supportItemDetails =
                await _apiMethod.getSupportItemDetails(item.itemNumber);

            // Debug logging to see what data we're getting
            debugPrint('DEBUG: Support item details for ${item.itemNumber}:');
            debugPrint('  supportItemDetails: $supportItemDetails');
            if (supportItemDetails != null &&
                supportItemDetails['priceCaps'] != null) {
              debugPrint('  priceCaps: ${supportItemDetails['priceCaps']}');
            }

            // Check if this is client-specific pricing
            final isClientSpecific = pricingData?['clientSpecific'] == true;
            final pricingClientId =
                pricingData?['clientId']; // This can be null
            debugPrint('  isClientSpecific: $isClientSpecific');
            debugPrint('  pricingClientId: $pricingClientId');
            debugPrint('  Full pricing data: $pricingData');

            // Check if this item has high intensity pricing when high intensity is enabled
            bool hasHighIntensityPricing = false;
            if (widget.highIntensity &&
                supportItemDetails != null &&
                supportItemDetails['priceCaps'] != null) {
              final priceCaps = supportItemDetails['priceCaps'];
              hasHighIntensityPricing = priceCaps['highIntensity'] != null;
              debugPrint('  hasHighIntensityPricing: $hasHighIntensityPricing');
            }

            if (mounted) {
              setState(() {
                // Only update if:
                // 1. We don't have pricing data for this item yet, OR
                // 2. This is client-specific pricing for our client, OR
                // 3. This is org-wide pricing and we don't have client-specific pricing
                final existingData = _pricingData[item.itemNumber];
                final hasExistingClientSpecific = existingData != null &&
                    existingData['customPricing'] != null &&
                    existingData['customPricing']?['clientSpecific'] == true &&
                    existingData['customPricing']?['clientId'] ==
                        widget.clientId;

                if (existingData == null ||
                    (isClientSpecific && pricingClientId == widget.clientId) ||
                    (!isClientSpecific && !hasExistingClientSpecific)) {
                  // Extract the price from the pricing data
                  final price = pricingData?['price'] ??
                      pricingData?['customPrice'] ??
                      pricingData?['fixedPrice'];

                  // Create custom pricing data with the correct structure
                  final customPricingData = {
                    'price': price,
                    'customPrice':
                        price, // Ensure we have the price in both fields
                    'fixedPrice':
                        price, // Ensure we have the price in all possible fields
                    'clientSpecific': isClientSpecific,
                    'clientId': pricingClientId,
                    'source': isClientSpecific
                        ? 'Client Custom Price'
                        : 'Organization Custom Price',
                  };

                  debugPrint(
                      'DEBUG: Storing custom pricing data: $customPricingData');
                  debugPrint('DEBUG: Price value: $price');
                  debugPrint('DEBUG: Is client specific: $isClientSpecific');
                  debugPrint('DEBUG: Client ID: $pricingClientId');
                  debugPrint('DEBUG: Widget client ID: ${widget.clientId}');

                  _pricingData[item.itemNumber] = {
                    'customPricing': customPricingData,
                    'supportItem': supportItemDetails,
                    'hasHighIntensityPricing': hasHighIntensityPricing,
                  };
                }
              });
            }
          } catch (e) {
            log.warning(
                "Failed to load pricing data for item ${item.itemNumber}: $e");
            // Continue with other items even if one fails
          }
        }));

        // Small delay between batches to prevent API overload
        if (i + batchSize < itemsToLoad.length) {
          await Future.delayed(const Duration(milliseconds: 100));
        }
      }

      debugPrint('DEBUG: Pricing data loaded for ${_pricingData.length} items');
      // Count client-specific and org-wide pricing
      int clientSpecificCount = 0;
      int orgWideCount = 0;
      _pricingData.forEach((key, value) {
        if (value['customPricing'] != null) {
          if (value['customPricing']['clientSpecific'] == true) {
            clientSpecificCount++;
          } else {
            orgWideCount++;
          }
        }
      });
      debugPrint(
          'DEBUG: Client-specific pricing found for $clientSpecificCount items');
      debugPrint(
          'DEBUG: Organization-wide pricing found for $orgWideCount items');

      // Set loading flag to false when complete
      if (mounted) {
        setState(() {
          _isLoadingCustomPrices = false;

          // Reapply high intensity filter after loading pricing data
          if (widget.highIntensity) {
            debugPrint(
                'DEBUG: Reapplying high intensity filter after loading pricing data');
            _filteredNdisItems = _filteredNdisItems.where((item) {
              final itemData = _pricingData[item.itemNumber];
              return itemData != null &&
                  itemData['hasHighIntensityPricing'] == true;
            }).toList();
            debugPrint(
                'DEBUG: Filtered items count after reapplying filter: ${_filteredNdisItems.length}');
          }
        });
      }
    } catch (e) {
      log.warning("Failed to load pricing data: $e");

      // Set loading flag to false even if there's an error
      if (mounted) {
        setState(() {
          _isLoadingCustomPrices = false;
        });
      }
    }
  }

  void _filterNdisItems(String query) {
    setState(() {
      _searchQuery = query;
      // First apply the search filter
      List<NDISItem> searchFiltered;
      if (query.isEmpty) {
        searchFiltered = _allNdisItems;
      } else {
        searchFiltered = _allNdisItems.where((item) {
          final lowerQuery = query.toLowerCase();
          return item.itemNumber.toLowerCase().contains(lowerQuery) ||
              item.itemName.toLowerCase().contains(lowerQuery);
        }).toList();
      }

      // Then apply high intensity filter if needed
      if (widget.highIntensity) {
        debugPrint('DEBUG: Applying high intensity filter after search');
        _filteredNdisItems = searchFiltered.where((item) {
          final itemData = _pricingData[item.itemNumber];
          return itemData != null &&
              itemData['hasHighIntensityPricing'] == true;
        }).toList();
        debugPrint(
            'DEBUG: Filtered items count after search and high intensity: ${_filteredNdisItems.length}');
      } else {
        _filteredNdisItems = searchFiltered;
      }
    });

    // Load pricing data for newly filtered items
    _loadPricingData();
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
    debugPrint('DEBUG: _getCappedPrice for ${item.itemNumber}:');
    debugPrint('  pricingData exists: ${pricingData != null}');
    debugPrint('  supportItem exists: ${pricingData?['supportItem'] != null}');
    debugPrint('  highIntensity: ${widget.highIntensity}');

    if (pricingData?['supportItem'] != null) {
      final supportItem = pricingData!['supportItem'];
      final priceCaps = supportItem['priceCaps'];
      debugPrint('  priceCaps exists: ${priceCaps != null}');
      debugPrint('  priceCaps data: $priceCaps');

      if (priceCaps != null) {
        // First try to get high intensity price if enabled
        final intensityType =
            widget.highIntensity ? 'highIntensity' : 'standard';
        debugPrint('  intensityType: $intensityType');
        debugPrint('  userState: $_userState');

        final statePrices = priceCaps[intensityType];
        debugPrint('  statePrices for $intensityType: $statePrices');

        if (statePrices != null) {
          // Get client state from SharedPreferences
          String? clientState = _sharedPrefs.getString('clientState');
          debugPrint('  clientState from SharedPreferences: $clientState');

          // Try client state first, then fall back to user state, then default price
          if (clientState != null && statePrices[clientState] != null) {
            final price = (statePrices[clientState] as num).toDouble();
            debugPrint('  Found price for client state: $price');
            return price;
          } else if (statePrices[_userState] != null) {
            final price = (statePrices[_userState] as num).toDouble();
            debugPrint('  Found price for user state: $price');
            return price;
          }
        } else if (widget.highIntensity) {
          // If high intensity pricing is not available, fall back to standard pricing
          debugPrint(
              '  High intensity pricing not available, falling back to standard');
          final standardPrices = priceCaps['standard'];

          if (standardPrices != null) {
            // Try client state first, then fall back to user state
            String? clientState = _sharedPrefs.getString('clientState');
            if (clientState != null && standardPrices[clientState] != null) {
              final price = (standardPrices[clientState] as num).toDouble();
              debugPrint('  Found standard price for client state: $price');
              return price;
            } else if (standardPrices[_userState] != null) {
              final price = (standardPrices[_userState] as num).toDouble();
              debugPrint('  Found standard price for user state: $price');
              return price;
            }
          }
        }
      }
    }
    final fb = double.parse((_fallbackBaseRate ?? 30.00).toStringAsFixed(2));
    debugPrint('  Using fallback price: $fb');
    return fb; // Fallback price
  }

  double _getCurrentPrice(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];

    debugPrint('DEBUG: _getCurrentPrice for ${item.itemNumber}:');
    debugPrint('  pricingData exists: ${pricingData != null}');

    // Check if custom pricing exists for this item
    if (pricingData != null && pricingData['customPricing'] != null) {
      final customPricing = pricingData['customPricing'];
      debugPrint('  customPricing: $customPricing');

      // Check for price field in different possible locations
      final customPrice = customPricing['customPrice'] ??
          customPricing['price'] ??
          customPricing['fixedPrice'];

      debugPrint('  customPrice found: ${customPrice != null}');
      debugPrint('  customPrice value: $customPrice');

      // If there's a custom price and it's for this client or not client-specific
      if (customPrice != null) {
        // Check if this pricing is for the current client or organization-wide
        final isForCurrentClient = widget.clientId != null &&
            customPricing['clientId'] == widget.clientId;
        final isNotClientSpecific = customPricing['clientSpecific'] == false;

        debugPrint('  isForCurrentClient: $isForCurrentClient');
        debugPrint('  isNotClientSpecific: $isNotClientSpecific');
        debugPrint('  widget.clientId: ${widget.clientId}');
        debugPrint('  customPricing[clientId]: ${customPricing['clientId']}');
        debugPrint(
            '  customPricing[clientSpecific]: ${customPricing['clientSpecific']}');

        // Use custom price if it's for this client or not client-specific
        if (isForCurrentClient || isNotClientSpecific) {
          final price = (customPrice as num).toDouble();
          debugPrint('  Using custom price: $price');
          return price;
        }
      }
    }

    // Fall back to capped price if no custom pricing is available
    debugPrint('  Falling back to capped price');
    return _getCappedPrice(item);
  }

  String _getPricingSource(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    debugPrint('DEBUG: _getPricingSource for ${item.itemNumber}:');
    debugPrint('  pricingData exists: ${pricingData != null}');

    if (pricingData?['customPricing'] != null) {
      final customPricing = pricingData!['customPricing'];
      debugPrint('  customPricing: $customPricing');

      // Check if this is a custom price
      final hasCustomPrice = customPricing['customPrice'] != null ||
          customPricing['price'] != null ||
          customPricing['fixedPrice'] != null;

      if (hasCustomPrice) {
        final isClientSpecific = customPricing['clientSpecific'] == true;
        final source = customPricing['source'] ??
            (isClientSpecific
                ? 'Client Custom Price'
                : 'Organization Custom Price');
        debugPrint('  Using source: $source');
        return source;
      }
    }
    debugPrint('  Using default source: Standard NDIS Rate');
    return 'Standard NDIS Rate';
  }

  void _togglePriceOverride(String itemNumber) {
    setState(() {
      _showPriceOverride[itemNumber] =
          !(_showPriceOverride[itemNumber] ?? false);
      if (_showPriceOverride[itemNumber] == true) {
        // Initialize controller with current price
        final item = _filteredNdisItems
            .firstWhere((item) => item.itemNumber == itemNumber);
        _priceControllers[itemNumber] = TextEditingController(
          text: _getCurrentPrice(item).toStringAsFixed(2),
        );
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
          'clientSpecific': widget.clientId !=
              null, // Client-specific if clientId is provided
          'clientId': widget.clientId, // Include clientId if available
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
      appBar: AppBar(
        title: const Text('Select NDIS Item'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.highIntensity
                  ? 'High Intensity Pricing'
                  : 'Standard Pricing',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ),
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
                  decoration: const InputDecoration(
                    labelText: 'Search by Item Number or Description',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue
                        .withAlpha(26), // 0.1 * 255 = 25.5, rounded to 26
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Colors.blue[700], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Pricing shown for ${widget.highIntensity ? "High Intensity" : "Standard"} rates in $_userState. Tap the price icon to set custom pricing.',
                          style:
                              TextStyle(color: Colors.blue[700], fontSize: 12),
                        ),
                      ),
                      if (_isLoadingCustomPrices) ...[
                        // Show loading indicator when custom prices are loading
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue[700]!),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Loading prices...',
                          style:
                              TextStyle(color: Colors.blue[700], fontSize: 12),
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
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: _filteredNdisItems.isEmpty && _searchQuery.isNotEmpty
                      ? const Center(
                          child: Text('No matching NDIS items found.'))
                      : ListView.builder(
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
    debugPrint('DEBUG: Building NDIS item card for ${item.itemNumber}');
    final currentPrice = _getCurrentPrice(item);
    final cappedPrice = _getCappedPrice(item);
    final pricingSource = _getPricingSource(item);

    debugPrint(
        'DEBUG: Item ${item.itemNumber} - currentPrice: $currentPrice, cappedPrice: $cappedPrice, pricingSource: $pricingSource');
    debugPrint('DEBUG: Custom pricing data: ${_pricingData[item.itemNumber]}');
    final showOverride = _showPriceOverride[item.itemNumber] ?? false;
    final isCustomEnabled = _isCustomPriceEnabled[item.itemNumber] ?? false;

    // Debug print to check if custom pricing exists for this item
    final pricingData = _pricingData[item.itemNumber];
    final hasCustomPricing =
        pricingData != null && pricingData['customPricing'] != null;
    debugPrint(
        'DEBUG: Item ${item.itemNumber} has custom pricing: $hasCustomPricing');
    if (hasCustomPricing) {
      final customPricing = pricingData['customPricing'];
      final customPrice = customPricing['customPrice'] ??
          customPricing['price'] ??
          customPricing['fixedPrice'];
      final isForCurrentClient = widget.clientId != null &&
          customPricing['clientId'] == widget.clientId;
      final isNotClientSpecific = customPricing['clientSpecific'] == false;

      debugPrint('  Custom pricing data: ${pricingData['customPricing']}');
      debugPrint('  Custom price value: $customPrice');
      debugPrint('  Is for current client: $isForCurrentClient');
      debugPrint('  Is not client specific: $isNotClientSpecific');
      debugPrint(
          '  Should use custom price: ${isForCurrentClient || isNotClientSpecific}');
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
              item.itemName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemNumber,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: currentPrice != cappedPrice
                            ? Colors.orange.withAlpha(51) // 0.2 * 255 = 51
                            : Colors.green.withAlpha(51), // 0.2 * 255 = 51
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '\$${currentPrice.toStringAsFixed(2)}/hr',
                        style: TextStyle(
                          color: currentPrice != cappedPrice
                              ? Colors.orange[700]
                              : Colors.green[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      pricingSource,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    showOverride ? Icons.expand_less : Icons.attach_money,
                    color: showOverride ? Colors.blue : Colors.grey[600],
                  ),
                  onPressed: () => _togglePriceOverride(item.itemNumber),
                  tooltip: 'Set custom price',
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () => _selectItem(item),
                ),
              ],
            ),
            onTap: () => _selectItem(item),
          ),
          if (showOverride) _buildPriceOverrideSection(item),
        ],
      ),
    );
  }

  Widget _buildPriceOverrideSection(NDISItem item) {
    final cappedPrice = _getCappedPrice(item);
    final controller = _priceControllers[item.itemNumber];
    final isCustomEnabled = _isCustomPriceEnabled[item.itemNumber] ?? false;
    final bool isSaving = _isSavingCustomPrice[item.itemNumber] ?? false;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.blue[600]),
            const SizedBox(width: 8),
            Text(
              'Max Capped Price: \$${cappedPrice.toStringAsFixed(2)}/hr',
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: isCustomEnabled,
              onChanged: (value) {
                setState(() {
                  _isCustomPriceEnabled[item.itemNumber] = value ?? false;
                  if (value == false) {
                    // Reset to capped price
                    controller?.text = cappedPrice.toStringAsFixed(2);
                  }
                });
              },
            ),
            const Text('Set custom price for this assignment'),
          ],
        ),
        if (isCustomEnabled) ...[
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  labelText: 'Custom Price (\$/hour)',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: const OutlineInputBorder(),
                  helperText: 'Enter the custom hourly rate for this NDIS item',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Please enter a valid price';
                  }
                  if (price > cappedPrice) {
                    return 'Price cannot exceed the max capped price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : () async {
                          final price = double.tryParse(controller?.text ?? '');
                          if (price != null && price > 0) {
                            // Validate that price doesn't exceed capped price
                            if (price > cappedPrice) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Price cannot exceed the max capped price'),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              _isSavingCustomPrice[item.itemNumber] = true;
                            });

                            try {
                              // Get user email from SharedPreferences
                              final userEmail =
                                  _sharedPrefs.getString('userEmail');
                              final orgId = widget.organizationId ??
                                  _sharedPrefs.getString('organizationId');

                              if (orgId != null && userEmail != null) {
                                // Determine if we should use client-specific pricing method instead
                                Map<String, dynamic> result;
                                if (widget.clientId != null) {
                                  // Use client-specific pricing method if available
                                  result =
                                      await _apiMethod.saveCustomPriceForClient(
                                              item.itemNumber,
                                              widget.clientId!,
                                              price,
                                              'Custom price set from item selection',
                                              userEmail: userEmail,
                                              organizationId: orgId) ??
                                          {
                                            'success': false,
                                            'message':
                                                'Failed to save client pricing'
                                          };
                                } else {
                                  // Use organization-wide pricing
                                  result = await _apiMethod.saveAsCustomPricing(
                                      orgId,
                                      item.itemNumber,
                                      price,
                                      'fixed', // Using fixed pricing type
                                      userEmail,
                                      supportItemName: item.itemName);
                                }

                                if (result['success'] == true) {
                                  // Optimistically update local pricing state so UI reflects immediately
                                  if (mounted) {
                                    setState(() {
                                      final isClientSpecific = widget.clientId != null;
                                      final customPricingData = {
                                        'price': price,
                                        'customPrice': price,
                                        'fixedPrice': price,
                                        'clientSpecific': isClientSpecific,
                                        'clientId': widget.clientId,
                                        'source': isClientSpecific
                                            ? 'Client Custom Price'
                                            : 'Organization Custom Price',
                                        'updatedAt': DateTime.now().toIso8601String(),
                                      };

                                      _pricingData[item.itemNumber] = {
                                        ..._pricingData[item.itemNumber] ?? {},
                                        'customPricing': customPricingData,
                                      };

                                      // Collapse override and mark as enabled
                                      _showPriceOverride[item.itemNumber] = false;
                                      _isCustomPriceEnabled[item.itemNumber] = true;
                                    });
                                  }

                                  // Optionally also refresh from backend to ensure consistency
                                  await _loadPricingData();

                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Custom price saved successfully'),
                                      ),
                                    );
                                  }
                                } else {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Failed to save custom price: ${result['message']}'),
                                      ),
                                    );
                                  }
                                }
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Missing organization ID or user email'),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Error saving custom price: $e'),
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
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid price'),
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : const Text('Save',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.amber.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, size: 16, color: Colors.amber[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.clientId != null
                        ? 'Custom pricing will be saved for this client and can be reused for future assignments.'
                        : 'Custom pricing will be saved for this organization and can be reused for future assignments.',
                    style: TextStyle(
                      color: Colors.amber[700],
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ]),
    );
  }
}
