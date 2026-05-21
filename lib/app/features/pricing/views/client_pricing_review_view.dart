import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/views/price_override_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

/// Client Pricing Review View
///
/// Displays clients with assigned employees and their support item pricing.
/// Allows reviewing and editing rates before invoice generation.
class ClientPricingReviewView extends ConsumerStatefulWidget {
  final String organizationId;
  final String userEmail;

  const ClientPricingReviewView({
    super.key,
    required this.organizationId,
    required this.userEmail,
  });

  @override
  ConsumerState<ClientPricingReviewView> createState() =>
      _ClientPricingReviewViewState();
}

class _ClientPricingReviewViewState
    extends ConsumerState<ClientPricingReviewView> {
  late final ApiMethod _apiMethod;

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
    _apiMethod = ref.read(app_providers.apiMethodProvider);
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
      final response =
          await _apiMethod.getOrganizationAssignments(widget.organizationId);

      if (response != null && response['success'] == true) {
        final assignments = response['assignments'] as List<dynamic>? ?? [];

        // Group assignments by client
        final Map<String, Map<String, dynamic>> clientMap = {};

        for (final assignment in assignments) {
          if (assignment is Map<String, dynamic>) {
            final clientEmail = assignment['clientEmail'] as String? ?? '';
            final clientId = assignment['clientId']?.toString() ?? clientEmail;

            if (clientEmail.isNotEmpty) {
              if (!clientMap.containsKey(clientId)) {
                String resolvedName = '';
                final details =
                    assignment['clientDetails'] as Map<String, dynamic>?;
                if (details != null) {
                  final first = details['clientFirstName']?.toString() ?? '';
                  final last = details['clientLastName']?.toString() ?? '';
                  resolvedName = '$first $last'.trim();
                }
                if (resolvedName.isEmpty) {
                  resolvedName = assignment['clientName']?.toString() ??
                      clientEmail.split('@')[0];
                }

                clientMap[clientId] = {
                  'clientId': clientId,
                  'clientEmail': clientEmail,
                  'clientName': resolvedName,
                  'clientState': assignment['clientState'] ??
                      details?['clientState'] ??
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

        setState(() {
          _clientsWithAssignments = clientMap.values.toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response?['message'] ??
              AppLocalizations.of(context)!.failedToLoadClients;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            AppLocalizations.of(context)!.errorLoadingClients(e.toString());
        _isLoading = false;
      });
    }
  }

  /// Load support items and pricing for the selected client.
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

      // Fetch pricing for each unique item
      final List<Map<String, dynamic>> itemsWithPricing = [];

      for (final entry in uniqueItems.entries) {
        final itemNumber = entry.key;
        final itemData = entry.value;

        // Get client-specific pricing using organizationId and clientId
        final pricingData = await _apiMethod.getPricingLookup(
          widget.organizationId,
          itemNumber,
          clientId: clientId,
        );

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

      setState(() {
        _supportItems = itemsWithPricing;
        _isLoadingItems = false;
      });
    } catch (e) {
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
          organizationId: widget.organizationId,
          getPriceSourceLabel: _getPriceSourceLabel,
          getPriceSourceColor: _getPriceSourceColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: BauhausDesign.surfaceWhite,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Text(
        AppLocalizations.of(context)!.clientPricingReviewTitle,
        style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.bold,
            ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: AppLocalizations.of(context)!.backAction,
        color: BauhausDesign.textDark,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: _loadClientsWithAssignments,
          tooltip: AppLocalizations.of(context)!.refreshAction,
          color: BauhausDesign.textDark,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: BauhausDesign.neutral, height: 1),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator(color: BauhausDesign.primary));
    }

    if (_errorMessage != null) {
      return Center(
        child: BauhausErrorState(
          message: _errorMessage!,
          onRetry: _loadClientsWithAssignments,
        ),
      );
    }

    if (_clientsWithAssignments.isEmpty) {
      return Center(
        child: BauhausEmptyState(
          title: AppLocalizations.of(context)!.noClientsFound,
          subtitle: AppLocalizations.of(context)!.noClientsFoundDesc,
          icon: Icons.people_outline,
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
    return ListView.separated(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      itemCount: _clientsWithAssignments.length,
      separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space3),
      itemBuilder: (context, index) {
        final client = _clientsWithAssignments[index];
        final assignmentCount = (client['assignments'] as List).length;
        return _buildClientCardMobile(client, assignmentCount, index);
      },
    );
  }

  /// Tablet/Desktop layout - side by side panels
  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Left panel - Client list (fixed width)
        SizedBox(width: 320, child: _buildClientListTablet()),
        // Divider
        Container(width: 1, color: BauhausDesign.neutral),
        // Right panel - Support items (expanded)
        Expanded(child: _buildSupportItemsPanel()),
      ],
    );
  }

  // ==================== MOBILE LAYOUT WIDGETS ====================

  /// Mobile client card with tap to navigate
  Widget _buildClientCardMobile(
      Map<String, dynamic> client, int assignmentCount, int index) {
    return BauhausCard(
      onTap: () => _onClientTapMobile(client),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: BauhausDesign.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            ),
            child: Icon(Icons.person, color: BauhausDesign.secondary),
          ),
          const SizedBox(width: BauhausDesign.space3),
          // Client info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client['clientName'] ?? 'Unknown',
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textDark,
                          ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  client['clientEmail'] ?? '',
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: BauhausDesign.space2),
                Row(
                  children: [
                    BauhausChip(
                      text: client['clientState'] ?? 'NSW',
                      color: BauhausDesign.primary,
                      size: BauhausChipSize.small,
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    BauhausChip(
                      text: AppLocalizations.of(context)!
                          .assignmentsCountLabel(assignmentCount.toString()),
                      color: BauhausDesign.secondary,
                      size: BauhausChipSize.small,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Chevron
          Icon(Icons.chevron_right, color: BauhausDesign.neutral),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: index * 50))
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.1, end: 0);
  }

  // ==================== TABLET LAYOUT WIDGETS ====================

  /// Tablet client list - sidebar style with selection indicator
  Widget _buildClientListTablet() {
    return Container(
      color: BauhausDesign.surfaceWhite,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BauhausDesign.neutral)),
            ),
            child: Row(
              children: [
                Icon(Icons.people, color: BauhausDesign.primary, size: 20),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!.clientsCountTitle(
                      _clientsWithAssignments.length.toString()),
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
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
          ? BauhausDesign.primary.withOpacity(0.1)
          : Colors.transparent,
      child: InkWell(
        onTap: () => _loadClientSupportItems(client),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4, vertical: BauhausDesign.space3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: BauhausDesign.neutral.withOpacity(0.5)),
              left: isSelected
                  ? const BorderSide(color: BauhausDesign.primary, width: 3)
                  : BorderSide.none,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client['clientName'] ?? 'Unknown',
                style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? BauhausDesign.primary
                          : BauhausDesign.textDark,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space1),
              Row(
                children: [
                  Icon(Icons.email_outlined,
                      size: 14, color: BauhausDesign.textMuted),
                  const SizedBox(width: BauhausDesign.space1),
                  Expanded(
                    child: Text(
                      client['clientEmail'] ?? '',
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space2),
              Row(
                children: [
                  BauhausChip(
                    text: client['clientState'] ?? 'NSW',
                    color: BauhausDesign.primary,
                    size: BauhausChipSize.small,
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  BauhausChip(
                    text: AppLocalizations.of(context)!
                        .assignmentsCountLabel(count.toString()),
                    color: BauhausDesign.primary,
                    size: BauhausChipSize.small,
                  ),
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
        child: BauhausEmptyState(
          title: AppLocalizations.of(context)!.selectClientPrompt,
          subtitle: AppLocalizations.of(context)!.chooseClientFromListDesc,
          icon: Icons.touch_app_outlined,
        ),
      );
    }

    if (_isLoadingItems) {
      return const Center(
          child: CircularProgressIndicator(color: BauhausDesign.primary));
    }

    return Container(
      color: BauhausDesign.backgroundLight,
      child: Column(
        children: [
          _buildItemsPanelHeader(),
          Expanded(
            child: _supportItems.isEmpty
                ? Center(
                    child: BauhausEmptyState(
                      title: AppLocalizations.of(context)!.noSupportItemsTitle,
                      subtitle: AppLocalizations.of(context)!
                          .noItemsFoundForClientDesc,
                      icon: Icons.inventory_2_outlined,
                    ),
                  )
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
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(bottom: BorderSide(color: BauhausDesign.neutral)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientName,
                  style: BauhausDesign.getTextTheme(context)
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Wrap(
                  spacing: BauhausDesign.space2,
                  runSpacing: BauhausDesign.space2,
                  children: [
                    BauhausChip(
                      text: clientState,
                      color: const Color(0xFF764BA2),
                      icon: Icons.location_on,
                      size: BauhausChipSize.small,
                    ),
                    BauhausChip(
                      text: AppLocalizations.of(context)!
                          .assignmentsCountLabel(itemCount.toString()),
                      color: BauhausDesign.primary,
                      icon: Icons.list_alt,
                      size: BauhausChipSize.small,
                    ),
                    if (exceedsCapCount > 0)
                      BauhausChip(
                        text: '$exceedsCapCount exceeds cap',
                        color: BauhausDesign.error,
                        icon: Icons.warning_amber_rounded,
                        size: BauhausChipSize.small,
                      ),
                  ],
                ),
              ],
            ),
          ),
          BauhausActionButton(
            onPressed: _navigateToPriceOverride,
            text: AppLocalizations.of(context)!.editPricesAction,
            icon: Icons.edit_rounded,
            variant: BauhausActionVariant.primary,
          ),
        ],
      ),
    );
  }

  /// Tablet items list
  Widget _buildItemsListTablet() {
    return ListView.builder(
      padding: const EdgeInsets.all(BauhausDesign.space4),
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

    return BauhausCard(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      borderColor: exceedsCap ? BauhausDesign.error.withOpacity(0.5) : null,
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
                      style: BauhausDesign.getTextTheme(context)
                          .labelMedium
                          ?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      itemName,
                      style: BauhausDesign.getTextTheme(context)
                          .bodyLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              if (exceedsCap)
                BauhausChip(
                  text: AppLocalizations.of(context)!.exceedsLabel,
                  color: BauhausDesign.error,
                  icon: Icons.warning_amber_rounded,
                  size: BauhausChipSize.small,
                ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          // Pricing details - different layout for mobile vs tablet
          isMobile
              ? _buildPricingColumnsMobile(currentPrice, priceSource,
                  ndisPriceCap, priceCapType, exceedsCap)
              : _buildPricingColumnsTablet(currentPrice, priceSource,
                  ndisPriceCap, priceCapType, exceedsCap),
        ],
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
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.neutral.withOpacity(0.2),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildPriceColumn(
              AppLocalizations.of(context)!.currentRateLabel,
              '\$${currentPrice.toStringAsFixed(2)}',
              _getPriceSourceLabel(priceSource),
              _getPriceSourceColor(priceSource),
            ),
          ),
          Container(width: 1, height: 40, color: BauhausDesign.neutral),
          Expanded(
            child: _buildPriceColumn(
              AppLocalizations.of(context)!.ndisCapLabel,
              ndisPriceCap != null
                  ? '\$${ndisPriceCap.toStringAsFixed(2)}'
                  : AppLocalizations.of(context)!.notAvailableLabel,
              priceCapType ?? AppLocalizations.of(context)!.notAvailableLabel,
              BauhausDesign.textMuted,
            ),
          ),
          Container(width: 1, height: 40, color: BauhausDesign.neutral),
          Expanded(
            child: _buildPriceColumn(
              AppLocalizations.of(context)!.diffLabel,
              ndisPriceCap != null
                  ? '\$${(currentPrice - ndisPriceCap).toStringAsFixed(2)}'
                  : AppLocalizations.of(context)!.notAvailableLabel,
              exceedsCap
                  ? AppLocalizations.of(context)!.overCapLabel
                  : AppLocalizations.of(context)!.withinCapLabel,
              exceedsCap ? BauhausDesign.error : BauhausDesign.success,
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
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.neutral.withOpacity(0.2),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildPriceRowMobile(
                  AppLocalizations.of(context)!.currentLabel,
                  '\$${currentPrice.toStringAsFixed(2)}',
                  _getPriceSourceColor(priceSource),
                ),
              ),
              Expanded(
                child: _buildPriceRowMobile(
                  AppLocalizations.of(context)!.ndisCapLabel,
                  ndisPriceCap != null
                      ? '\$${ndisPriceCap.toStringAsFixed(2)}'
                      : AppLocalizations.of(context)!.notAvailableLabel,
                  BauhausDesign.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Row(
            children: [
              Expanded(
                child: _buildPriceRowMobile(
                  AppLocalizations.of(context)!.sourceLabel,
                  _getPriceSourceLabel(priceSource),
                  _getPriceSourceColor(priceSource),
                ),
              ),
              Expanded(
                child: _buildPriceRowMobile(
                  AppLocalizations.of(context)!.statusLabel,
                  exceedsCap
                      ? AppLocalizations.of(context)!.overCapLabel
                      : AppLocalizations.of(context)!.okLabel,
                  exceedsCap ? BauhausDesign.error : BauhausDesign.success,
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
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textMuted,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
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
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textMuted,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.primary,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: subtitleColor,
                fontWeight: FontWeight.w600,
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
        return AppLocalizations.of(context)!.priceSourceCustom;
      case 'organization':
        return AppLocalizations.of(context)!.priceSourceManual;
      case 'fallback-base-rate':
        return AppLocalizations.of(context)!.priceSourceNdis;
      case 'standard':
      case 'ndis-standard':
        return AppLocalizations.of(context)!.ndisLabel;
      case 'missing':
        return AppLocalizations.of(context)!.priceSourceMissing;
      default:
        return source;
    }
  }

  /// Get color for pricing source indicator
  Color _getPriceSourceColor(String source) {
    switch (source) {
      case 'client-specific':
      case 'client_specific':
        return BauhausDesign.success;
      case 'organization':
        return BauhausDesign.primary;
      case 'fallback-base-rate':
        return BauhausDesign.warning;
      case 'standard':
      case 'ndis-standard':
        return const Color(0xFF764BA2);
      case 'missing':
        return BauhausDesign.error;
      default:
        return BauhausDesign.textMuted;
    }
  }
}

// ==================== MOBILE DETAIL PAGE ====================

/// Separate page for mobile to show client pricing details.
class _ClientPricingDetailPage extends ConsumerStatefulWidget {
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
  ConsumerState<_ClientPricingDetailPage> createState() =>
      _ClientPricingDetailPageState();
}

class _ClientPricingDetailPageState
    extends ConsumerState<_ClientPricingDetailPage> {
  late final ApiMethod _apiMethod;
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(app_providers.apiMethodProvider);
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

      final List<Map<String, dynamic>> itemsWithPricing = [];

      for (final entry in uniqueItems.entries) {
        final itemNumber = entry.key;
        final itemData = entry.value;

        // Get client-specific pricing
        final pricingData = await _apiMethod.getPricingLookup(
          widget.organizationId,
          itemNumber,
          clientId: clientId,
        );

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

        if (currentPrice == 0.0 && ndisPriceCap != null) {
          currentPrice = ndisPriceCap;
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

      setState(() {
        _items = itemsWithPricing;
        _isLoading = false;
      });
    } catch (e) {
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
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        title: Text(
          clientName,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadItems,
            tooltip: 'Refresh',
            color: BauhausDesign.textDark,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : Column(
              children: [
                // Header with client info and edit button
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  color: BauhausDesign.surfaceWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Info chips
                      Wrap(
                        spacing: BauhausDesign.space2,
                        runSpacing: BauhausDesign.space2,
                        children: [
                          BauhausChip(
                            text: clientState,
                            color: const Color(0xFF764BA2),
                            size: BauhausChipSize.small,
                          ),
                          BauhausChip(
                            text: '${_items.length} items',
                            color: BauhausDesign.primary,
                            size: BauhausChipSize.small,
                          ),
                          if (exceedsCapCount > 0)
                            BauhausChip(
                              text: '$exceedsCapCount over cap',
                              color: BauhausDesign.error,
                              size: BauhausChipSize.small,
                            ),
                        ],
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      // Edit button - full width
                      SizedBox(
                        width: double.infinity,
                        child: BauhausActionButton(
                          onPressed: _navigateToPriceOverride,
                          text: AppLocalizations.of(context)!.editPricesAction,
                          icon: Icons.edit_rounded,
                          variant: BauhausActionVariant.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Items list
                Expanded(
                  child: _items.isEmpty
                      ? Center(
                          child: BauhausEmptyState(
                            title: AppLocalizations.of(context)!
                                .noSupportItemsTitle,
                            subtitle: AppLocalizations.of(context)!
                                .noItemsFoundForClientDesc,
                            icon: Icons.inventory_2_outlined,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(BauhausDesign.space4),
                          itemCount: _items.length,
                          itemBuilder: (context, index) =>
                              _buildItemCardMobile(_items[index], index),
                        ),
                ),
              ],
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

    return BauhausCard(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      borderColor: exceedsCap ? BauhausDesign.error.withOpacity(0.5) : null,
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
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      itemName,
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: BauhausDesign.textDark,
                          ),
                    ),
                  ],
                ),
              ),
              if (exceedsCap)
                BauhausChip(
                  text: AppLocalizations.of(context)!.exceedsLabel,
                  color: BauhausDesign.error,
                  icon: Icons.warning_amber_rounded,
                  size: BauhausChipSize.small,
                ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          // Pricing bento grid
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDD0), // Cream color
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top section: Current Price
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.currentLabel.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: BauhausDesign.textMuted,
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        '\$${currentPrice.toStringAsFixed(2)}',
                        style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: widget.getPriceSourceColor(priceSource),
                            ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 2, thickness: 2, color: BauhausDesign.neutral),
                
                // Middle section: NDIS Cap & Status
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(BauhausDesign.space3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.ndisCapLabel.toUpperCase(),
                                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              Text(
                                ndisPriceCap != null
                                    ? '\$${ndisPriceCap.toStringAsFixed(2)}'
                                    : AppLocalizations.of(context)!.notAvailableLabel,
                                style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: BauhausDesign.textDark,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const VerticalDivider(width: 2, thickness: 2, color: BauhausDesign.neutral),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(BauhausDesign.space3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.statusLabel.toUpperCase(),
                                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              Row(
                                children: [
                                  Icon(
                                    exceedsCap ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                                    color: exceedsCap ? BauhausDesign.error : BauhausDesign.success,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      exceedsCap
                                          ? AppLocalizations.of(context)!.overCapLabel
                                          : AppLocalizations.of(context)!.okLabel,
                                      style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: exceedsCap ? BauhausDesign.error : BauhausDesign.success,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 2, thickness: 2, color: BauhausDesign.neutral),
                
                // Bottom section: Source
                Container(
                  color: BauhausDesign.surfaceWhite,
                  padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space3, vertical: BauhausDesign.space3),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.sourceLabel.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textMuted,
                            ),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: Text(
                          widget.getPriceSourceLabel(priceSource),
                          textAlign: TextAlign.right,
                          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: widget.getPriceSourceColor(priceSource),
                              ),
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
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                color: BauhausDesign.textMuted,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        Text(
          value,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
      ],
    );
  }
}
