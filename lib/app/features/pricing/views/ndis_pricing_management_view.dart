import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/shared/utils/logging.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// NDIS Pricing Management View for the Pricing Management Dashboard
/// Allows users to view, search, and manage custom pricing for NDIS items
class NdisPricingManagementView extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? adminEmail;
  final String? organizationName;

  const NdisPricingManagementView({
    Key? key,
    this.organizationId,
    this.adminEmail,
    this.organizationName,
  }) : super(key: key);

  @override
  ConsumerState<NdisPricingManagementView> createState() =>
      _NdisPricingManagementViewState();
}

class _NdisPricingManagementViewState
    extends ConsumerState<NdisPricingManagementView> {
  final NDISMatcher _ndisMatcher = NDISMatcher();
  final ApiMethod _apiMethod = ApiMethod();
  final SharedPreferencesUtils _sharedPrefs = SharedPreferencesUtils();
  final TextEditingController _searchController = TextEditingController();

  List<NDISItem> _allNdisItems = [];
  List<NDISItem> _filteredNdisItems = [];
  Map<String, Map<String, dynamic>> _pricingData = {};
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
        _showSnackBar('Failed to load NDIS items. Please try again.',
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

  /// Get standard NDIS price for an item
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
    return 30.00; // Fallback price
  }

  /// Get current price (custom or standard) for an item
  double _getCurrentPrice(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    if (pricingData?['customPricing'] != null) {
      final customPricing = pricingData!['customPricing'];
      final source = customPricing['source'];

      // Only use custom pricing if it's not base rate
      if (source != null && source != 'base-rate') {
        return (customPricing['price'] as num?)?.toDouble() ??
            _getStandardPrice(item);
      }
    }
    return _getStandardPrice(item);
  }

  /// Get pricing source description
  String _getPricingSource(NDISItem item) {
    final pricingData = _pricingData[item.itemNumber];
    if (pricingData?['customPricing'] != null) {
      final customPricing = pricingData!['customPricing'];
      final source = customPricing['source'];

      // Check if this is actual custom pricing or just base rate
      if (source != null && source != 'base-rate') {
        final isClientSpecific =
            customPricing['clientId'] != null || source == 'client_specific';
        return isClientSpecific ? 'Client-Specific Rate' : 'Organization Rate';
      }
    }
    return 'Standard NDIS Rate';
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
        _priceControllers[itemNumber] = TextEditingController(
          text: _getCurrentPrice(item).toStringAsFixed(2),
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
      _showSnackBar('Please enter a valid price', isError: true);
      return;
    }

    setState(() {
      _isSavingPrice[item.itemNumber] = true;
    });

    try {
      final result = await _apiMethod.saveAsCustomPricing(
        widget.organizationId!,
        item.itemNumber,
        price,
        'organization', // Save as organization-level pricing
        widget.adminEmail ?? '',
      );

      if (result['success'] == true) {
        // Update local pricing data
        setState(() {
          _pricingData[item.itemNumber] = {
            ..._pricingData[item.itemNumber] ?? {},
            'customPricing': {
              'price': price,
              'source': 'Organization Rate',
              'createdAt': DateTime.now().toIso8601String(),
            },
          };
          _showPriceOverride[item.itemNumber] = false;
        });

        _showSnackBar('Custom pricing saved successfully');
      } else {
        _showSnackBar(result['message'] ?? 'Failed to save custom pricing',
            isError: true);
      }
    } catch (e) {
      log.severe("Failed to save custom pricing: $e");
      _showSnackBar('Failed to save custom pricing. Please try again.',
          isError: true);
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

        _showSnackBar('Custom pricing removed successfully');
      } else {
        _showSnackBar(result['message'] ?? 'Failed to remove custom pricing',
            isError: true);
      }
    } catch (e) {
      log.severe("Failed to remove custom pricing: $e");
      _showSnackBar('Failed to remove custom pricing. Please try again.',
          isError: true);
    }
  }

  /// Show snackbar message
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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
                  Expanded(child: _buildItemsList()),
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
      color: Colors.white,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            return Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                          ),
                          color: const Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NDIS Pricing Management',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 24 : 28,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!isSmallScreen) ...[
                              const SizedBox(height: 8),
                              Text(
                                'Manage NDIS rate and compliance',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]
                          ],
                        ),
                      ),
                      if (!isSmallScreen)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'System Active',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (isSmallScreen) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Import and export data in batch operations',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'System Active',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
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
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'NDIS Price Management',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage NDIS rates and compliance',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'System Active',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            TextField(
              controller: _searchController,
              onChanged: _filterNdisItems,
              decoration: const InputDecoration(
                labelText: 'Search Items',
                hintText: 'Item number or description',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
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
    return DropdownButtonFormField<String>(
      value: _selectedFilter,
      decoration: const InputDecoration(
        labelText: 'Filter by Pricing',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: ['All', 'Custom', 'Standard', 'High Intensity']
          .map((filter) => DropdownMenuItem(
                value: filter == 'Custom'
                    ? 'Custom Pricing'
                    : filter == 'Standard'
                        ? 'Standard Pricing'
                        : filter == 'High Intensity'
                            ? 'High Intensity'
                            : filter,
                child: Text(
                  filter,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
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
    );
  }

  Widget _buildStateFilter() {
    return DropdownButtonFormField<String>(
      value: _selectedStateFilter,
      decoration: const InputDecoration(
        labelText: 'Filter by State',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: ['All', 'NSW', 'VIC', 'QLD', 'WA', 'SA', 'TAS', 'ACT', 'NT']
          .map((state) => DropdownMenuItem(
                value: state,
                child: Text(
                  state,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
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
    );
  }

  /// Build information banner
  Widget _buildInfoBanner() {
    final displayState =
        _selectedStateFilter != 'All' ? _selectedStateFilter : _userState;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Pricing shown for Standard rates in $displayState. Custom pricing will override standard rates for your organization.',
              style: TextStyle(color: Colors.blue[700], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  /// Build NDIS items list
  Widget _buildItemsList() {
    if (_isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'Loading NDIS items',
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
                    ? 'No NDIS items found matching "$_searchQuery"'
                    : 'No NDIS items found',
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
                child: const Text('Clear filters'),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
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

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasCustomPricing ? Colors.orange[300]! : Colors.grey[200]!,
          width: hasCustomPricing ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              item.itemName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  item.itemNumber,
                  style: TextStyle(
                    color: const Color(0xFF6C5CE7),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: hasCustomPricing
                            ? Colors.orange.withValues(alpha: 0.2)
                            : Colors.green.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '\$${currentPrice.toStringAsFixed(2)}/hr',
                        style: TextStyle(
                          color: hasCustomPricing
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
                if (hasCustomPricing)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    onPressed: () => _removeCustomPricing(item),
                    tooltip: 'Remove custom pricing',
                    color: Colors.red[600],
                  ),
                IconButton(
                  icon: Icon(
                    showOverride ? Icons.expand_less : Icons.attach_money,
                    color: showOverride ? Colors.blue : Colors.grey[600],
                    size: 18,
                  ),
                  onPressed: () => _togglePriceOverride(item.itemNumber),
                  tooltip: 'Set custom price',
                ),
              ],
            ),
          ),
          if (showOverride) _buildPriceOverrideSection(item),
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
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[50]!,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with standard rate info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue[100]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.blue[700],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Standard NDIS Rate',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$${standardPrice.toStringAsFixed(2)} per hour',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Custom pricing toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isCustomEnabled ? Colors.purple[50] : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isCustomEnabled ? Colors.purple[200]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isCustomEnabled
                        ? const Color(0xFF6C5CE7)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isCustomEnabled
                          ? const Color(0xFF6C5CE7)
                          : Colors.grey[400]!,
                      width: 2,
                    ),
                  ),
                  child: isCustomEnabled
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isCustomPriceEnabled[item.itemNumber] =
                            !isCustomEnabled;
                        if (!isCustomEnabled) {
                          // Reset to standard price when enabling
                          controller?.text = standardPrice.toStringAsFixed(2);
                        }
                      });
                    },
                    child: Text(
                      'Set custom price for this organization',
                      style: TextStyle(
                        color: isCustomEnabled
                            ? Colors.purple[700]
                            : Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (isCustomEnabled) ...[
            const SizedBox(height: 20),

            // Custom price input
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  labelText: 'Custom Price (\$/hour)',
                  labelStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.attach_money,
                      color: Color(0xFF6C5CE7),
                      size: 20,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  helperText: 'Enter the custom hourly rate for this NDIS item',
                  helperStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Please enter a valid price';
                  }
                  if (price > standardPrice * 2) {
                    return 'Price seems unusually high';
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 20),

            // Action buttons
            Column(
              children: [
                // Save button
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C5CE7), Color(0xFF5A4FCF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: isSaving ? null : () => _saveCustomPricing(item),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.save,
                                size: 18,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Save Custom Price',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                // Reset and Cancel buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              controller?.text =
                                  standardPrice.toStringAsFixed(2);
                            });
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _showPriceOverride[item.itemNumber] = false;
                            });
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Info notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.amber[200]!,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.lightbulb_outline,
                      size: 14,
                      color: Colors.amber[700],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Custom pricing will be applied organization-wide and used for all future assignments.',
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
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
