import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/views/price_override_view.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Client Pricing Review View
///
/// Displays clients with assigned employees and their support item pricing.
/// Allows reviewing and editing rates before invoice generation.
///
/// Features:
/// - Responsive design: side-by-side panels on tablet/desktop, stacked navigation on mobile
/// - Shows current pricing rates with source indicators (client-specific, organization, fallback, NDIS)
/// - Displays NDIS price caps with visual warnings for items exceeding caps
/// - Edit button navigates to PriceOverrideView for price modifications
/// - Color-coded pricing sources for quick identification
class ClientPricingReviewView extends StatefulWidget {
  final String organizationId;
  final String userEmail;

  const ClientPricingReviewView({
    super.key,
    required this.organizationId,
    required this.userEmail,
  });

  @override
  State<ClientPricingReviewView> createState() =>
      _ClientPricingReviewViewState();
}

class _ClientPricingReviewViewState extends State<ClientPricingReviewView> {
  final ApiMethod _apiMethod = ApiMethod();

  // Loading and error states
  bool _isLoading = true;
  String? _errorMessage;

  // Client data
  List<Map<String, dynamic>> _clientsWithAssignments = [];
  String? _selectedClientId;
  Map<String, dynamic>? _selectedClientData;

  // Support items for selected client
  List<Map<String, dynamic>> _supportItems = [];
  bool _isLoadingItems = false;

  /// Responsive breakpoint - below this width uses mobile layout
  static const double _tabletBreakpoint = 600;

  /// Check if current screen width is tablet or larger
  bool _isTabletOrLarger(BuildContext context) {
    return MediaQuery.of(context).size.width >= _tabletBreakpoint;
  }

  @override
  void initState() {
    super.initState();
    _loadClientsWithAssignments();
  }

  /// Load all clients that have employee assignments in this organization.
  /// Groups assignments by client and extracts client details.
  Future<void> _loadClientsWithAssignments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      debugPrint(
          'ClientPricingReview: Loading clients for org ${widget.organizationId}');
      final response =
          await _apiMethod.getOrganizationAssignments(widget.organizationId);

      if (response != null && response['success'] == true) {
        final assignments = response['assignments'] as List<dynamic>? ?? [];
        debugPrint(
            'ClientPricingReview: Found ${assignments.length} assignments');

        // Group assignments by client
        final Map<String, Map<String, dynamic>> clientMap = {};

        for (final assignment in assignments) {
          if (assignment is Map<String, dynamic>) {
            final clientEmail = assignment['clientEmail'] as String? ?? '';
            final clientId = assignment['clientId']?.toString() ??
                assignment['_id']?.toString() ??
                clientEmail;

            if (clientEmail.isNotEmpty) {
              if (!clientMap.containsKey(clientId)) {
                clientMap[clientId] = {
                  'clientId': clientId,
                  'clientEmail': clientEmail,
                  'clientName': assignment['clientName'] ??
                      assignment['clientDetails']?['clientFirstName'] ??
                      clientEmail.split('@')[0],
                  'clientState': assignment['clientState'] ??
                      assignment['clientDetails']?['clientState'] ??
                      'NSW',
                  'assignments': <Map<String, dynamic>>[],
                };
              }
              (clientMap[clientId]!['assignments']
                      as List<Map<String, dynamic>>)
                  .add(assignment);
            }
          }
        }

        debugPrint(
            'ClientPricingReview: Grouped into ${clientMap.length} clients');

        setState(() {
          _clientsWithAssignments = clientMap.values.toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response?['message'] ?? 'Failed to load clients';
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('ClientPricingReview: Error loading clients: $e');
      setState(() {
        _errorMessage = 'Error loading clients: $e';
        _isLoading = false;
      });
    }
  }

  /// Load support items and pricing for the selected client.
  /// Fetches client-specific pricing using getPricingLookup with clientId.
  /// Also fetches NDIS price caps for comparison.
  Future<void> _loadClientSupportItems(Map<String, dynamic> clientData) async {
    setState(() {
      _isLoadingItems = true;
      _selectedClientData = clientData;
      _selectedClientId = clientData['clientId'] as String?;
      _supportItems = [];
    });

    try {
      final clientId = clientData['clientId'] as String;
      final clientState = clientData['clientState'] as String? ?? 'NSW';
      final assignments =
          clientData['assignments'] as List<Map<String, dynamic>>;

      debugPrint(
          'ClientPricingReview: Loading items for client $clientId (state: $clientState)');

      // Collect unique NDIS items from all assignments
      final Map<String, Map<String, dynamic>> uniqueItems = {};

      for (final assignment in assignments) {
        final schedule = assignment['schedule'] as List<dynamic>? ?? [];
        for (final scheduleItem in schedule) {
          if (scheduleItem is Map<String, dynamic>) {
            final ndisItem = scheduleItem['ndisItem'] as Map<String, dynamic>?;
            if (ndisItem != null) {
              final itemNumber = ndisItem['itemNumber'] as String? ?? '';
              final itemName = ndisItem['itemName'] as String? ?? '';
              if (itemNumber.isNotEmpty &&
                  !uniqueItems.containsKey(itemNumber)) {
                uniqueItems[itemNumber] = {
                  'itemNumber': itemNumber,
                  'itemName': itemName,
                  'employeeEmail': assignment['userEmail'] ?? '',
                };
              }
            }
          }
        }
      }

      debugPrint(
          'ClientPricingReview: Found ${uniqueItems.length} unique NDIS items');

      // Fetch pricing for each unique item
      final List<Map<String, dynamic>> itemsWithPricing = [];

      for (final entry in uniqueItems.entries) {
        final itemNumber = entry.key;
        final itemData = entry.value;

        debugPrint('ClientPricingReview: Fetching pricing for $itemNumber');

        // Get client-specific pricing using organizationId and clientId
        final pricingData = await _apiMethod.getPricingLookup(
          widget.organizationId,
          itemNumber,
          clientId: clientId,
        );

        debugPrint(
            'ClientPricingReview: Pricing data for $itemNumber: $pricingData');

        // Get NDIS price cap details
        final supportItemDetails =
            await _apiMethod.getSupportItemDetails(itemNumber);

        // Extract current price - prefer customPrice over price
        double currentPrice = 0.0;
        String priceSource = 'missing';

        if (pricingData != null) {
          final customPrice = (pricingData['customPrice'] as num?)?.toDouble();
          final price = (pricingData['price'] as num?)?.toDouble();
          priceSource = pricingData['source']?.toString() ?? 'unknown';

          // Use customPrice if available and > 0, otherwise use price
          currentPrice = (customPrice != null && customPrice > 0)
              ? customPrice
              : (price ?? 0.0);

          debugPrint(
              'ClientPricingReview: $itemNumber - customPrice: $customPrice, price: $price, resolved: $currentPrice, source: $priceSource');
        }

        // Extract NDIS price cap based on client state
        double? ndisPriceCap;
        String? priceCapType;

        if (supportItemDetails != null &&
            supportItemDetails['priceCaps'] != null) {
          final priceCaps =
              supportItemDetails['priceCaps'] as Map<String, dynamic>;

          // Check standard caps first
          if (priceCaps['standard'] != null && priceCaps['standard'] is Map) {
            final standardCaps = priceCaps['standard'] as Map<String, dynamic>;
            if (standardCaps[clientState] != null) {
              ndisPriceCap = (standardCaps[clientState] as num).toDouble();
              priceCapType = 'standard';
            }
          }

          // Check high intensity if no standard cap found
          if (ndisPriceCap == null && priceCaps['highIntensity'] != null) {
            final hiCaps = priceCaps['highIntensity'] as Map<String, dynamic>;
            if (hiCaps[clientState] != null) {
              ndisPriceCap = (hiCaps[clientState] as num).toDouble();
              priceCapType = 'highIntensity';
            }
          }
        }

        // Determine if current price exceeds NDIS cap
        final exceedsCap = ndisPriceCap != null && currentPrice > ndisPriceCap;

        itemsWithPricing.add({
          'itemNumber': itemNumber,
          'itemName': itemData['itemName'],
          'currentPrice': currentPrice,
          'priceSource': priceSource,
          'ndisPriceCap': ndisPriceCap,
          'priceCapType': priceCapType,
          'exceedsCap': exceedsCap,
          'clientState': clientState,
        });
      }

      // Sort by item number for consistent display
      itemsWithPricing.sort((a, b) =>
          (a['itemNumber'] as String).compareTo(b['itemNumber'] as String));

      debugPrint(
          'ClientPricingReview: Loaded ${itemsWithPricing.length} items with pricing');

      setState(() {
        _supportItems = itemsWithPricing;
        _isLoadingItems = false;
      });
    } catch (e) {
      debugPrint('ClientPricingReview: Error loading support items: $e');
      setState(() {
        _isLoadingItems = false;
        _errorMessage = 'Error loading support items: $e';
      });
    }
  }

  /// Navigate to PriceOverrideView for editing client-specific prices
  void _navigateToPriceOverride() {
    if (_selectedClientData == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PriceOverrideView(
          clientId: _selectedClientId ?? '',
          organizationId: widget.organizationId,
          clientAssignments:
              _selectedClientData!['assignments'] as List<Map<String, dynamic>>,
        ),
      ),
    ).then((_) {
      // Refresh pricing after returning from edit view
      if (_selectedClientData != null) {
        _loadClientSupportItems(_selectedClientData!);
      }
    });
  }

  /// Mobile: Navigate to detail page for selected client
  void _onClientTapMobile(Map<String, dynamic> client) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ClientPricingDetailPage(
          clientData: client,
          organizationId: widget.organizationId, // Pass organizationId!
          getPriceSourceLabel: _getPriceSourceLabel,
          getPriceSourceColor: _getPriceSourceColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ModernInvoiceDesign.surface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Text(
        'Client Pricing Review',
        style:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
          color: ModernInvoiceDesign.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: 'Back',
        color: ModernInvoiceDesign.textPrimary,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: _loadClientsWithAssignments,
          tooltip: 'Refresh',
          color: ModernInvoiceDesign.textPrimary,
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 64, color: ModernInvoiceDesign.error),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: TextStyle(color: ModernInvoiceDesign.error),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadClientsWithAssignments,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_clientsWithAssignments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline,
                size: 64, color: ModernInvoiceDesign.border),
            const SizedBox(height: 16),
            Text(
              'No clients with assignments found',
              style: const TextStyle(fontSize: 16).copyWith(
                color: ModernInvoiceDesign.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    // Responsive layout based on screen width
    if (_isTabletOrLarger(context)) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  /// Mobile layout - full screen client list, tap to navigate to detail page
  Widget _buildMobileLayout() {
    return _buildClientListMobile();
  }

  /// Tablet/Desktop layout - side by side panels
  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Left panel - Client list (fixed width)
        SizedBox(width: 320, child: _buildClientListTablet()),
        // Divider
        Container(width: 1, color: ModernInvoiceDesign.border),
        // Right panel - Support items (expanded)
        Expanded(child: _buildSupportItemsPanel()),
      ],
    );
  }

  // ==================== MOBILE LAYOUT WIDGETS ====================

  /// Mobile client list - full width cards, navigates on tap
  Widget _buildClientListMobile() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _clientsWithAssignments.length,
      itemBuilder: (context, index) {
        final client = _clientsWithAssignments[index];
        final assignmentCount = (client['assignments'] as List).length;
        return _buildClientCardMobile(client, assignmentCount, index);
      },
    );
  }

  /// Mobile client card with tap to navigate
  Widget _buildClientCardMobile(
      Map<String, dynamic> client, int assignmentCount, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ModernInvoiceDesign.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _onClientTapMobile(client),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.person, color: ModernInvoiceDesign.accent),
              ),
              const SizedBox(width: 12),
              // Client info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client['clientName'] ?? 'Unknown',
                      style: const TextStyle(fontSize: 16).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      client['clientEmail'] ?? '',
                      style: const TextStyle(fontSize: 12).copyWith(
                        color: ModernInvoiceDesign.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildChip(client['clientState'] ?? 'NSW',
                            ModernInvoiceDesign.primary),
                        const SizedBox(width: 8),
                        _buildChip('$assignmentCount items',
                            ModernInvoiceDesign.accent),
                      ],
                    ),
                  ],
                ),
              ),
              // Chevron
              Icon(Icons.chevron_right, color: ModernInvoiceDesign.border),
            ],
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: index * 50))
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.1, end: 0);
  }

  /// Small chip widget for labels
  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style:
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w500).copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ==================== TABLET LAYOUT WIDGETS ====================

  /// Tablet client list - sidebar style with selection indicator
  Widget _buildClientListTablet() {
    return Container(
      color: ModernInvoiceDesign.background,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.background.withValues(alpha: 0.1),
              border:
                  Border(bottom: BorderSide(color: ModernInvoiceDesign.border)),
            ),
            child: Row(
              children: [
                Icon(Icons.people,
                    color: ModernInvoiceDesign.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Clients (${_clientsWithAssignments.length})',
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                          .copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Client list
          Expanded(
            child: ListView.builder(
              itemCount: _clientsWithAssignments.length,
              itemBuilder: (context, index) {
                final client = _clientsWithAssignments[index];
                final isSelected = client['clientId'] == _selectedClientId;
                final assignmentCount = (client['assignments'] as List).length;
                return _buildClientTileTablet(
                    client, isSelected, assignmentCount);
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.1, end: 0);
  }

  /// Tablet client tile with selection state
  Widget _buildClientTileTablet(
      Map<String, dynamic> client, bool isSelected, int count) {
    return Material(
      color: isSelected
          ? ModernInvoiceDesign.primary.withOpacity(0.1)
          : Colors.transparent,
      child: InkWell(
        onTap: () => _loadClientSupportItems(client),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: ModernInvoiceDesign.border.withOpacity(0.1)),
              left: isSelected
                  ? BorderSide(color: ModernInvoiceDesign.primary, width: 3)
                  : BorderSide.none,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client['clientName'] ?? 'Unknown',
                style: const TextStyle(fontSize: 16).copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? ModernInvoiceDesign.primary
                      : const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.email_outlined,
                      size: 14, color: ModernInvoiceDesign.textSecondary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      client['clientEmail'] ?? '',
                      style: const TextStyle(fontSize: 12).copyWith(
                        color: ModernInvoiceDesign.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _buildChip(client['clientState'] ?? 'NSW',
                      ModernInvoiceDesign.primary),
                  const SizedBox(width: 8),
                  _buildChip('$count assignment${count != 1 ? 's' : ''}',
                      ModernInvoiceDesign.primary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tablet right panel - support items for selected client
  Widget _buildSupportItemsPanel() {
    if (_selectedClientData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.touch_app_outlined,
                size: 64, color: ModernInvoiceDesign.border),
            const SizedBox(height: 16),
            Text(
              'Select a client to view pricing',
              style: const TextStyle(fontSize: 16).copyWith(
                color: ModernInvoiceDesign.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    if (_isLoadingItems) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      color: ModernInvoiceDesign.background,
      child: Column(
        children: [
          _buildItemsPanelHeader(),
          Expanded(
            child: _supportItems.isEmpty
                ? _buildNoItemsMessage()
                : _buildItemsListTablet(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  /// Header for items panel showing client info and edit button
  Widget _buildItemsPanelHeader() {
    final clientName = _selectedClientData?['clientName'] ?? 'Unknown';
    final clientState = _selectedClientData?['clientState'] ?? 'NSW';
    final itemCount = _supportItems.length;
    final exceedsCapCount =
        _supportItems.where((i) => i['exceedsCap'] == true).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.background.withValues(alpha: 0.1),
        border: Border(bottom: BorderSide(color: ModernInvoiceDesign.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientName,
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                          .copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildInfoChip(Icons.location_on, clientState,
                        const Color(0xFF764BA2)),
                    _buildInfoChip(
                        Icons.list_alt, '$itemCount items', Colors.blue),
                    if (exceedsCapCount > 0)
                      _buildInfoChip(
                        Icons.warning_amber_rounded,
                        '$exceedsCapCount exceeds cap',
                        ModernInvoiceDesign.error,
                      ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _navigateToPriceOverride,
            icon: const Icon(Icons.edit_rounded, size: 18),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ModernInvoiceDesign.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  /// Info chip with icon
  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)
                .copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Empty state message
  Widget _buildNoItemsMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: 64, color: ModernInvoiceDesign.border),
          const SizedBox(height: 16),
          Text(
            'No support items found',
            style: const TextStyle(fontSize: 16).copyWith(
              color: ModernInvoiceDesign.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Tablet items list
  Widget _buildItemsListTablet() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _supportItems.length,
      itemBuilder: (context, index) =>
          _buildSupportItemCard(_supportItems[index], index, false),
    );
  }

  /// Support item card - used in both tablet and mobile layouts
  Widget _buildSupportItemCard(
      Map<String, dynamic> item, int index, bool isMobile) {
    final itemNumber = item['itemNumber'] as String;
    final itemName = item['itemName'] as String? ?? 'Unknown Item';
    final currentPrice = item['currentPrice'] as double;
    final priceSource = item['priceSource'] as String;
    final ndisPriceCap = item['ndisPriceCap'] as double?;
    final exceedsCap = item['exceedsCap'] as bool;
    final priceCapType = item['priceCapType'] as String?;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: exceedsCap
              ? ModernInvoiceDesign.error.withOpacity(0.1)
              : ModernInvoiceDesign.border,
          width: exceedsCap ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item header with number, name, and warning badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemNumber,
                        style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)
                            .copyWith(
                          color: ModernInvoiceDesign.primary,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        itemName,
                        style: const TextStyle(fontSize: 14).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (exceedsCap)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ModernInvoiceDesign.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            size: 16, color: ModernInvoiceDesign.error),
                        const SizedBox(width: 4),
                        Text(
                          'Exceeds',
                          style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w500)
                              .copyWith(
                            color: ModernInvoiceDesign.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            // Pricing details - different layout for mobile vs tablet
            isMobile
                ? _buildPricingColumnsMobile(currentPrice, priceSource,
                    ndisPriceCap, priceCapType, exceedsCap)
                : _buildPricingColumnsTablet(currentPrice, priceSource,
                    ndisPriceCap, priceCapType, exceedsCap),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: index * 50))
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0);
  }

  /// Tablet pricing columns - horizontal layout
  Widget _buildPricingColumnsTablet(double currentPrice, String priceSource,
      double? ndisPriceCap, String? priceCapType, bool exceedsCap) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildPriceColumn(
              'Current Rate',
              '\$${currentPrice.toStringAsFixed(2)}',
              _getPriceSourceLabel(priceSource),
              _getPriceSourceColor(priceSource),
            ),
          ),
          Container(width: 1, height: 50, color: ModernInvoiceDesign.border),
          Expanded(
            child: _buildPriceColumn(
              'NDIS Cap',
              ndisPriceCap != null
                  ? '\$${ndisPriceCap.toStringAsFixed(2)}'
                  : 'N/A',
              priceCapType ?? 'N/A',
              ModernInvoiceDesign.border,
            ),
          ),
          Container(width: 1, height: 50, color: ModernInvoiceDesign.border),
          Expanded(
            child: _buildPriceColumn(
              'Diff',
              ndisPriceCap != null
                  ? '\$${(currentPrice - ndisPriceCap).toStringAsFixed(2)}'
                  : 'N/A',
              exceedsCap ? 'Over cap' : 'Within cap',
              exceedsCap
                  ? ModernInvoiceDesign.error
                  : ModernInvoiceDesign.success,
            ),
          ),
        ],
      ),
    );
  }

  /// Mobile pricing columns - 2x2 grid layout
  Widget _buildPricingColumnsMobile(double currentPrice, String priceSource,
      double? ndisPriceCap, String? priceCapType, bool exceedsCap) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.background.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildPriceRowMobile(
                  'Current',
                  '\$${currentPrice.toStringAsFixed(2)}',
                  _getPriceSourceColor(priceSource),
                ),
              ),
              Expanded(
                child: _buildPriceRowMobile(
                  'NDIS Cap',
                  ndisPriceCap != null
                      ? '\$${ndisPriceCap.toStringAsFixed(2)}'
                      : 'N/A',
                  ModernInvoiceDesign.border,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildPriceRowMobile(
                  'Source',
                  _getPriceSourceLabel(priceSource),
                  _getPriceSourceColor(priceSource),
                ),
              ),
              Expanded(
                child: _buildPriceRowMobile(
                  'Status',
                  exceedsCap ? 'Over cap' : 'OK',
                  exceedsCap
                      ? ModernInvoiceDesign.error
                      : ModernInvoiceDesign.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Mobile price row - label on top, value below
  Widget _buildPriceRowMobile(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)
              .copyWith(
            color: ModernInvoiceDesign.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14).copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  /// Tablet price column - centered with subtitle
  Widget _buildPriceColumn(
      String label, String value, String subtitle, Color subtitleColor) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)
              .copyWith(
            color: ModernInvoiceDesign.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
              .copyWith(
            fontWeight: FontWeight.w700,
            color: ModernInvoiceDesign.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)
              .copyWith(
            color: subtitleColor,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ==================== HELPER METHODS ====================

  /// Get human-readable label for pricing source
  String _getPriceSourceLabel(String source) {
    switch (source) {
      case 'client-specific':
      case 'client_specific':
        return 'Client';
      case 'organization':
        return 'Org';
      case 'fallback-base-rate':
        return 'Fallback';
      case 'standard':
      case 'ndis-standard':
        return 'NDIS';
      case 'missing':
        return 'Missing';
      default:
        return source;
    }
  }

  /// Get color for pricing source indicator
  /// Green = client-specific (best)
  /// Blue = organization level
  /// Orange = fallback rate
  /// Gray = NDIS standard
  /// Red = missing/not configured
  Color _getPriceSourceColor(String source) {
    switch (source) {
      case 'client-specific':
      case 'client_specific':
        return Colors.green;
      case 'organization':
        return Colors.blue;
      case 'fallback-base-rate':
        return Colors.orange;
      case 'standard':
      case 'ndis-standard':
        return const Color(0xFF764BA2);
      case 'missing':
        return Colors.red;
      default:
        return ModernInvoiceDesign.textSecondary;
    }
  }
}

// ==================== MOBILE DETAIL PAGE ====================

/// Separate page for mobile to show client pricing details.
/// This is navigated to when tapping a client on mobile devices.
class _ClientPricingDetailPage extends StatefulWidget {
  final Map<String, dynamic> clientData;
  final String organizationId;
  final String Function(String) getPriceSourceLabel;
  final Color Function(String) getPriceSourceColor;

  const _ClientPricingDetailPage({
    required this.clientData,
    required this.organizationId,
    required this.getPriceSourceLabel,
    required this.getPriceSourceColor,
  });

  @override
  State<_ClientPricingDetailPage> createState() =>
      _ClientPricingDetailPageState();
}

class _ClientPricingDetailPageState extends State<_ClientPricingDetailPage> {
  final ApiMethod _apiMethod = ApiMethod();
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  /// Load support items with pricing for this client
  Future<void> _loadItems() async {
    setState(() => _isLoading = true);

    try {
      final clientId = widget.clientData['clientId'] as String;
      final clientState = widget.clientData['clientState'] as String? ?? 'NSW';
      final assignments =
          widget.clientData['assignments'] as List<Map<String, dynamic>>;

      debugPrint(
          'MobileDetailPage: Loading items for client $clientId, org ${widget.organizationId}');

      // Collect unique NDIS items from all assignments
      final Map<String, Map<String, dynamic>> uniqueItems = {};

      for (final assignment in assignments) {
        final schedule = assignment['schedule'] as List<dynamic>? ?? [];
        for (final scheduleItem in schedule) {
          if (scheduleItem is Map<String, dynamic>) {
            final ndisItem = scheduleItem['ndisItem'] as Map<String, dynamic>?;
            if (ndisItem != null) {
              final itemNumber = ndisItem['itemNumber'] as String? ?? '';
              final itemName = ndisItem['itemName'] as String? ?? '';
              if (itemNumber.isNotEmpty &&
                  !uniqueItems.containsKey(itemNumber)) {
                uniqueItems[itemNumber] = {
                  'itemNumber': itemNumber,
                  'itemName': itemName,
                };
              }
            }
          }
        }
      }

      debugPrint('MobileDetailPage: Found ${uniqueItems.length} unique items');

      final List<Map<String, dynamic>> itemsWithPricing = [];

      for (final entry in uniqueItems.entries) {
        final itemNumber = entry.key;
        final itemData = entry.value;

        debugPrint(
            'MobileDetailPage: Fetching pricing for $itemNumber with orgId: ${widget.organizationId}, clientId: $clientId');

        // Get client-specific pricing - use widget.organizationId!
        final pricingData = await _apiMethod.getPricingLookup(
          widget.organizationId,
          itemNumber,
          clientId: clientId,
        );

        debugPrint(
            'MobileDetailPage: Pricing response for $itemNumber: $pricingData');

        // Get NDIS price cap details
        final supportItemDetails =
            await _apiMethod.getSupportItemDetails(itemNumber);

        // Extract current price
        double currentPrice = 0.0;
        String priceSource = 'missing';

        if (pricingData != null) {
          final customPrice = (pricingData['customPrice'] as num?)?.toDouble();
          final price = (pricingData['price'] as num?)?.toDouble();
          priceSource = pricingData['source']?.toString() ?? 'unknown';

          // Use customPrice if available and > 0, otherwise use price
          currentPrice = (customPrice != null && customPrice > 0)
              ? customPrice
              : (price ?? 0.0);

          debugPrint(
              'MobileDetailPage: $itemNumber - customPrice: $customPrice, price: $price, resolved: $currentPrice, source: $priceSource');
        }

        // Extract NDIS price cap based on client state
        double? ndisPriceCap;
        String? priceCapType;

        if (supportItemDetails != null &&
            supportItemDetails['priceCaps'] != null) {
          final priceCaps =
              supportItemDetails['priceCaps'] as Map<String, dynamic>;

          // Check standard caps first
          if (priceCaps['standard'] != null && priceCaps['standard'] is Map) {
            final standardCaps = priceCaps['standard'] as Map<String, dynamic>;
            if (standardCaps[clientState] != null) {
              ndisPriceCap = (standardCaps[clientState] as num).toDouble();
              priceCapType = 'standard';
            }
          }

          // Check high intensity if no standard cap
          if (ndisPriceCap == null && priceCaps['highIntensity'] != null) {
            final hiCaps = priceCaps['highIntensity'] as Map<String, dynamic>;
            if (hiCaps[clientState] != null) {
              ndisPriceCap = (hiCaps[clientState] as num).toDouble();
              priceCapType = 'highIntensity';
            }
          }
        }

        final exceedsCap = ndisPriceCap != null && currentPrice > ndisPriceCap;

        itemsWithPricing.add({
          'itemNumber': itemNumber,
          'itemName': itemData['itemName'],
          'currentPrice': currentPrice,
          'priceSource': priceSource,
          'ndisPriceCap': ndisPriceCap,
          'priceCapType': priceCapType,
          'exceedsCap': exceedsCap,
        });
      }

      // Sort by item number
      itemsWithPricing.sort((a, b) =>
          (a['itemNumber'] as String).compareTo(b['itemNumber'] as String));

      debugPrint(
          'MobileDetailPage: Loaded ${itemsWithPricing.length} items with pricing');

      setState(() {
        _items = itemsWithPricing;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('MobileDetailPage: Error loading items: $e');
      setState(() => _isLoading = false);
    }
  }

  /// Navigate to price override view for editing
  void _navigateToPriceOverride() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PriceOverrideView(
          clientId: widget.clientData['clientId'] ?? '',
          organizationId: widget.organizationId,
          clientAssignments:
              widget.clientData['assignments'] as List<Map<String, dynamic>>,
        ),
      ),
    ).then((_) => _loadItems()); // Refresh after editing
  }

  @override
  Widget build(BuildContext context) {
    final clientName = widget.clientData['clientName'] ?? 'Unknown';
    final clientState = widget.clientData['clientState'] ?? 'NSW';
    final exceedsCapCount = _items.where((i) => i['exceedsCap'] == true).length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ModernInvoiceDesign.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        foregroundColor: ModernInvoiceDesign.textPrimary,
        elevation: 0,
        title: Text(
          clientName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
              .copyWith(
            color: ModernInvoiceDesign.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadItems,
            tooltip: 'Refresh',
            color: ModernInvoiceDesign.textSecondary,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header with client info and edit button
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Info chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildChipMobile(
                              clientState, const Color(0xFF764BA2)),
                          _buildChipMobile(
                              '${_items.length} items', Colors.blue),
                          if (exceedsCapCount > 0)
                            _buildChipMobile(
                                '$exceedsCapCount over cap', Colors.red),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Edit button - full width
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _navigateToPriceOverride,
                          icon: const Icon(Icons.edit_rounded, size: 18),
                          label: const Text('Edit Prices'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Items list
                Expanded(
                  child: _items.isEmpty
                      ? Center(
                          child: Text(
                            'No support items found',
                            style: const TextStyle(fontSize: 16).copyWith(
                              color: ModernInvoiceDesign.textSecondary,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _items.length,
                          itemBuilder: (context, index) =>
                              _buildItemCardMobile(_items[index], index),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildChipMobile(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style:
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w500).copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Mobile item card with 2x2 pricing grid
  Widget _buildItemCardMobile(Map<String, dynamic> item, int index) {
    final itemNumber = item['itemNumber'] as String;
    final itemName = item['itemName'] as String? ?? 'Unknown';
    final currentPrice = item['currentPrice'] as double;
    final priceSource = item['priceSource'] as String;
    final ndisPriceCap = item['ndisPriceCap'] as double?;
    final exceedsCap = item['exceedsCap'] as bool;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: exceedsCap
              ? Colors.red.withOpacity(0.1)
              : const Color(0xFFE0E0E0),
          width: exceedsCap ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemNumber,
                        style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)
                            .copyWith(
                          color: ModernInvoiceDesign.primary,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        itemName,
                        style: const TextStyle(fontSize: 12).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (exceedsCap)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 16,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            // Pricing grid - 2x2 layout
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildPriceRowMobile(
                          'Current',
                          '\$${currentPrice.toStringAsFixed(2)}',
                          widget.getPriceSourceColor(priceSource),
                        ),
                      ),
                      Expanded(
                        child: _buildPriceRowMobile(
                          'NDIS Cap',
                          ndisPriceCap != null
                              ? '\$${ndisPriceCap.toStringAsFixed(2)}'
                              : 'N/A',
                          ModernInvoiceDesign.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPriceRowMobile(
                          'Source',
                          widget.getPriceSourceLabel(priceSource),
                          widget.getPriceSourceColor(priceSource),
                        ),
                      ),
                      Expanded(
                        child: _buildPriceRowMobile(
                          'Status',
                          exceedsCap ? 'Over cap' : 'OK',
                          exceedsCap ? Colors.red : Colors.green,
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
    )
        .animate(delay: Duration(milliseconds: index * 50))
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildPriceRowMobile(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)
              .copyWith(
            color: const Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14).copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
