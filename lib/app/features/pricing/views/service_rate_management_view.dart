import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceRateManagementView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const ServiceRateManagementView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  });

  @override
  ConsumerState<ServiceRateManagementView> createState() =>
      _ServiceRateManagementViewState();
}

class _ServiceRateManagementViewState
    extends ConsumerState<ServiceRateManagementView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedRegion = 'All';
  bool _isLoading = false;
  final bool _showOnboarding = true;
  final Set<String> _selectedRateIds = {};
  final List<String> _activeFilters = [];

  // Mock data for service rates
  final List<Map<String, dynamic>> _serviceRates = [
    {
      'id': 'SR001',
      'serviceName': 'Personal Care',
      'category': 'Core Support',
      'baseRate': 65.57,
      'weekendRate': 98.36,
      'publicHolidayRate': 131.14,
      'region': 'Capital City',
      'effectiveDate': '2024-01-01',
      'status': 'Active',
      'lastUpdated': '2024-01-15',
    },
    {
      'id': 'SR002',
      'serviceName': 'Community Participation',
      'category': 'Capacity Building',
      'baseRate': 68.19,
      'weekendRate': 102.29,
      'publicHolidayRate': 136.38,
      'region': 'Regional',
      'effectiveDate': '2024-01-01',
      'status': 'Active',
      'lastUpdated': '2024-01-10',
    },
    {
      'id': 'SR003',
      'serviceName': 'Household Tasks',
      'category': 'Core Support',
      'baseRate': 65.57,
      'weekendRate': 98.36,
      'publicHolidayRate': 131.14,
      'region': 'Remote',
      'effectiveDate': '2024-02-01',
      'status': 'Pending',
      'lastUpdated': '2024-01-20',
    },
  ];

  List<String> _getCategoryOptions(BuildContext context) {
    return [
      AppLocalizations.of(context)!.allFilter,
      'Core Support',
      'Capacity Building',
      'Capital Support'
    ];
  }

  List<String> _getRegionOptions(BuildContext context) {
    return [
      AppLocalizations.of(context)!.allFilter,
      'Capital City',
      'Regional',
      'Remote'
    ];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRates = _serviceRates.where((rate) {
      final matchesSearch = _searchController.text.isEmpty ||
          rate['serviceName']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || rate['category'] == _selectedCategory;
      final matchesRegion =
          _selectedRegion == 'All' || rate['region'] == _selectedRegion;
      return matchesSearch && matchesCategory && matchesRegion;
    }).toList();
    final isEmpty = !_isLoading && filteredRates.isEmpty;
    return Scaffold(
      body: Column(
        children: [
          _buildModernHeader(),
          _buildEnhancedSearchBar(),
          _buildHorizontalStats(),
          Expanded(
            child: _buildRatesList(),
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
                                  .serviceRateManagementTitle,
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
                                    .serviceRateManagementSubtitle,
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
                          text: AppLocalizations.of(context)!.systemActiveLabel,
                          variant: BauhausChipVariant.success,
                          size: BauhausChipSize.small,
                        ),
                    ],
                  ),
                  if (isSmallScreen) ...[
                    const SizedBox(height: BauhausDesign.space3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Manage and optimize your service pricing across different regions and categories',
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
                          text: 'System Active',
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

  // Widget _buildModernHeader() {
  //   return Container(
  //     color: Colors.white,
  //     child: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(24.0),
  //         child: Row(
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: const Color(0xFFF5F5F5),
  //                 borderRadius:
  //                     BorderRadius.circular(8.0),
  //               ),
  //               child: IconButton(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 icon: const Icon(
  //                   Icons.arrow_back_ios_new,
  //                   size: 20,
  //                 ),
  //                 color: const Color(0xFF404040),
  //               ),
  //             ),
  //             const SizedBox(width: 16.0),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Service Rate Management',
  //                     style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
  //                   ),
  //                   const SizedBox(height: 8.0),
  //                   Text(
  //                     'Manage and optimize your service pricing across different regions and categories',
  //                     style: const TextStyle(fontSize: 16).copyWith(
  //                       color: const Color(0xFF757575),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 16.0,
  //                 vertical: 8.0,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: Colors.green.withOpacity(0.1),
  //                 borderRadius:
  //                     BorderRadius.circular(12.0),
  //                 border: Border.all(
  //                   color: Colors.green.withOpacity(0.1),
  //                 ),
  //               ),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     width: 8,
  //                     height: 8,
  //                     decoration: BoxDecoration(
  //                       color: Colors.green,
  //                       borderRadius: BorderRadius.circular(4),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 8.0),
  //                   Text(
  //                     'System Active',
  //                     style: const TextStyle(fontSize: 12).copyWith(
  //                       color: Colors.green,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildEnhancedSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space6, vertical: BauhausDesign.space4),
      child: Row(
        children: [
          Expanded(
            child: BauhausTextField(
              controller: _searchController,
              hintText: AppLocalizations.of(context)!.searchServiceRatesHint,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(width: BauhausDesign.space4),
          BauhausActionButton(
            onPressed: _showFilterDialog,
            icon: Icons.filter_list,
            text: AppLocalizations.of(context)!.filterAction,
            variant: BauhausActionVariant.secondary,
            isSmall: false,
          ),
          const SizedBox(width: BauhausDesign.space2),
          BauhausActionButton(
            onPressed: _showAddRateDialog,
            icon: Icons.add,
            text: AppLocalizations.of(context)!.addRateAction,
            variant: BauhausActionVariant.primary,
            isSmall: false,
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalStats() {
    return Container(
      height: 145,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: BauhausStatCard(
                title: AppLocalizations.of(context)!.totalRatesStat,
                value: '${_serviceRates.length}',
                subtitle: AppLocalizations.of(context)!.totalRatesSubtitle,
                icon: Icons.rate_review,
                iconColor: const Color(0xFF667EEA),
                isLoading: _isLoading,
                onTap: () => _filterByStatus('all'),
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 160,
              child: BauhausStatCard(
                title: AppLocalizations.of(context)!.activeRatesStat,
                value:
                    '${_serviceRates.where((r) => r['status'] == 'Active').length}',
                subtitle: AppLocalizations.of(context)!.activeRatesSubtitle,
                icon: Icons.check_circle,
                iconColor: Colors.green,
                isLoading: _isLoading,
                onTap: () => _filterByStatus('active'),
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 160,
              child: BauhausStatCard(
                title: AppLocalizations.of(context)!.pendingUpdatesStat,
                value:
                    '${_serviceRates.where((r) => r['status'] == 'Pending').length}',
                subtitle: AppLocalizations.of(context)!.pendingUpdatesSubtitle,
                icon: Icons.pending,
                iconColor: Colors.orange,
                isLoading: _isLoading,
                onTap: () => _filterByStatus('pending'),
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              width: 160,
              child: BauhausStatCard(
                title: AppLocalizations.of(context)!.avgBaseRateStat,
                value: _serviceRates.isEmpty
                    ? '\$0.00'
                    : '\$${(_serviceRates.map((r) => r['baseRate'] as double).reduce((a, b) => a + b) / _serviceRates.length).toStringAsFixed(2)}',
                subtitle: AppLocalizations.of(context)!.avgBaseRateSubtitle,
                icon: Icons.attach_money,
                iconColor: Colors.blue,
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatesList() {
    final filteredRates = _serviceRates.where((rate) {
      final matchesSearch = _searchController.text.isEmpty ||
          rate['serviceName']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || rate['category'] == _selectedCategory;
      final matchesRegion =
          _selectedRegion == 'All' || rate['region'] == _selectedRegion;
      return matchesSearch && matchesCategory && matchesRegion;
    }).toList();

    if (filteredRates.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: BauhausEmptyState(
          title: AppLocalizations.of(context)!.noServiceRatesFoundTitle,
          subtitle: AppLocalizations.of(context)!.noServiceRatesFoundSubtitle,
          icon: Icons.rate_review,
          actionLabel: AppLocalizations.of(context)!.addNewRateAction,
          onAction: _showAddRateDialog,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 24.0),
        itemCount: filteredRates.length,
        itemBuilder: (context, index) {
          final rate = filteredRates[index];
          final isSelected = _selectedRateIds.contains(rate['id']);
          return Padding(
            padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
            child: BauhausCard(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: InkWell(
                onTap: () => _viewRateDetails(rate),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(BauhausDesign.space2),
                          decoration: BoxDecoration(
                            color: BauhausDesign.primary.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusSm),
                          ),
                          child: Icon(Icons.description,
                              color: BauhausDesign.primary, size: 20),
                        ),
                        const SizedBox(width: BauhausDesign.space4),
                        Expanded(
                            child: Text(rate['serviceName'],
                                style: BauhausDesign.getTextTheme(context)
                                    .titleMedium)),
                        Text('\$${rate['baseRate']}',
                            style: BauhausDesign.getTextTheme(context)
                                .titleMedium
                                ?.copyWith(color: BauhausDesign.primary)),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(rate['category'],
                            style: BauhausDesign.getTextTheme(context)
                                .bodySmall
                                ?.copyWith(color: BauhausDesign.textLight)),
                        Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                onPressed: () => _editRate(rate)),
                            IconButton(
                                icon: const Icon(Icons.delete, size: 18),
                                onPressed: () => _deleteRate(rate['id'])),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Column(
        children: [
          BauhausTextField(
            controller: _searchController,
            hintText: 'Search service rates...',
            prefixIcon: const Icon(Icons.search),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: _buildModernDropdown(
                  AppLocalizations.of(context)!.categoryLabel,
                  _selectedCategory,
                  ['All', 'Support Worker', 'Specialist'],
                  (value) => setState(() => _selectedCategory = value!),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildModernDropdown(
                  AppLocalizations.of(context)!.regionLabel,
                  _selectedRegion,
                  ['All', 'Metro', 'Regional', 'Remote'],
                  (value) => setState(() => _selectedRegion = value!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: const Color(0xFFD4D4D4),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14).copyWith(
            color: const Color(0xFF757575),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          isDense: true,
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ))
            .toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        style: const TextStyle(fontSize: 14),
        menuMaxHeight: 300,
      ),
    );
  }

  // Layout for wide screens - horizontal arrangement
  Widget _buildWideScreenLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 250,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchServiceRatesHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 150,
            child: DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.categoryLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _getCategoryOptions(context).map((category) {
                return DropdownMenuItem(
                  value: category == AppLocalizations.of(context)!.allFilter
                      ? 'All'
                      : category,
                  child: Text(category, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 150,
            child: DropdownButtonFormField<String>(
              initialValue: _selectedRegion,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.regionLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _getRegionOptions(context).map((region) {
                return DropdownMenuItem(
                  value: region == AppLocalizations.of(context)!.allFilter
                      ? 'All'
                      : region,
                  child: Text(region, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedRegion = value!),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: _showAddRateDialog,
            icon: const Icon(Icons.add),
            label: Text(AppLocalizations.of(context)!.addRateAction),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Layout for narrow screens - vertical arrangement
  Widget _buildNarrowScreenLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchServiceRatesHint,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.categoryLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _getCategoryOptions(context).map((category) {
                return DropdownMenuItem(
                  value: category == AppLocalizations.of(context)!.allFilter
                      ? 'All'
                      : category,
                  child: Text(category, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedRegion,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.regionLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _getRegionOptions(context).map((region) {
                return DropdownMenuItem(
                  value: region == AppLocalizations.of(context)!.allFilter
                      ? 'All'
                      : region,
                  child: Text(region, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedRegion = value!),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _showAddRateDialog,
          icon: const Icon(Icons.add),
          label: Text(AppLocalizations.of(context)!.addRateAction),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildModernRateCard(Map<String, dynamic> rate) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF667EEA).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.schedule,
                        color: const Color(0xFF667EEA),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rate['serviceName'],
                            style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)
                                .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF667EEA).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  rate['category'],
                                  style: const TextStyle(fontSize: 12).copyWith(
                                    color: const Color(0xFF667EEA),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: const Color(0xFFD4D4D4),
                                  ),
                                ),
                                child: Text(
                                  rate['region'],
                                  style: const TextStyle(fontSize: 12).copyWith(
                                    color: const Color(0xFF757575),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: rate['status'] == 'Active'
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        rate['status'],
                        style: const TextStyle(fontSize: 12).copyWith(
                          color: rate['status'] == 'Active'
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 400) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRateInfo(
                            AppLocalizations.of(context)!.baseRateLabel,
                            '\$${rate['baseRate'].toStringAsFixed(2)}${AppLocalizations.of(context)!.perHourSuffix}',
                            Colors.green,
                          ),
                          const SizedBox(height: 16.0),
                          _buildRateInfo(
                            AppLocalizations.of(context)!.weekendRateLabel,
                            '\$${rate['weekendRate'].toStringAsFixed(2)}${AppLocalizations.of(context)!.perHourSuffix}',
                            Colors.blue,
                          ),
                          const SizedBox(height: 16.0),
                          _buildRateInfo(
                            AppLocalizations.of(context)!.holidayRateLabel,
                            '\$${rate['publicHolidayRate'].toStringAsFixed(2)}${AppLocalizations.of(context)!.perHourSuffix}',
                            Colors.orange,
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: _buildRateInfo(
                            AppLocalizations.of(context)!.baseRateLabel,
                            '\$${rate['baseRate'].toStringAsFixed(2)}${AppLocalizations.of(context)!.perHourSuffix}',
                            Colors.green,
                          ),
                        ),
                        Expanded(
                          child: _buildRateInfo(
                            AppLocalizations.of(context)!.weekendRateLabel,
                            '\$${rate['weekendRate'].toStringAsFixed(2)}${AppLocalizations.of(context)!.perHourSuffix}',
                            Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: _buildRateInfo(
                            AppLocalizations.of(context)!.holidayRateLabel,
                            '\$${rate['publicHolidayRate'].toStringAsFixed(2)}${AppLocalizations.of(context)!.perHourSuffix}',
                            Colors.orange,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 300) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildActionButton(
                            icon: Icons.edit,
                            onPressed: () => _editRate(rate),
                            color: const Color(0xFF757575),
                          ),
                          const SizedBox(height: 8.0),
                          _buildActionButton(
                            icon: Icons.delete,
                            onPressed: () => _deleteRate(rate['id']),
                            color: Colors.red,
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildActionButton(
                          icon: Icons.edit,
                          onPressed: () => _editRate(rate),
                          color: const Color(0xFF757575),
                        ),
                        const SizedBox(width: 8.0),
                        _buildActionButton(
                          icon: Icons.delete,
                          onPressed: () => _deleteRate(rate['id']),
                          color: Colors.red,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildRateInfo(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12).copyWith(
            color: const Color(0xFF757575),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(fontSize: 16).copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  void _refreshData() {
    setState(() {
      _isLoading = true;
    });
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar(AppLocalizations.of(context)!.dataRefreshedSuccess);
    });
  }

  void _exportRates() {
    _showSnackBar(AppLocalizations.of(context)!.exportingRatesMsg);
  }

  void _showAddRateDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF667EEA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.add,
                      color: const Color(0xFF667EEA),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    AppLocalizations.of(context)!.addNewServiceRateTitle,
                    style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)
                        .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Text(
                AppLocalizations.of(context)!.addNewRateFeatureComingSoon,
                style: const TextStyle(fontSize: 14).copyWith(
                  color: const Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildActionButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.pop(context),
                    color: const Color(0xFF757575),
                  ),
                  const SizedBox(width: 8.0),
                  _buildActionButton(
                    icon: Icons.add,
                    onPressed: () {
                      Navigator.pop(context);
                      _showSnackBar(
                          AppLocalizations.of(context)!.comingSoonMsg);
                    },
                    color: const Color(0xFF667EEA),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editRate(Map<String, dynamic> rate) {
    _showSnackBar('Edit rate: ${rate['serviceName']}');
  }

  void _deleteRate(String rateId) {
    final rate = _serviceRates.firstWhere((r) => r['id'] == rateId);
    _showDeleteConfirmation(rate);
  }

  void _handleRateAction(String action, Map<String, dynamic> rate) {
    switch (action) {
      case 'edit':
        _editRate(rate);
        break;
      case 'duplicate':
        _showSnackBar('Duplicate rate: ${rate['serviceName']}');
        break;
      case 'delete':
        _deleteRate(rate['id']);
        break;
    }
  }

  void _showDeleteConfirmation(Map<String, dynamic> rate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteRateTitle),
        content: Text(AppLocalizations.of(context)!
            .deleteRateConfirm(rate['serviceName'])),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancelAction),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _serviceRates.remove(rate);
              });
              _showSnackBar(AppLocalizations.of(context)!.rateDeletedSuccess);
            },
            style: ElevatedButton.styleFrom(),
            child: Text(AppLocalizations.of(context)!.deleteAction),
          ),
        ],
      ),
    );
  }

  // Action methods
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF667EEA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: const Color(0xFF667EEA),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    AppLocalizations.of(context)!.filterServiceRatesTitle,
                    style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)
                        .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Text(
                AppLocalizations.of(context)!.categoryLabel,
                style: const TextStyle(fontSize: 14).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                  ),
                  items: _getCategoryOptions(context)
                      .map((category) => DropdownMenuItem(
                            value: category ==
                                    AppLocalizations.of(context)!.allFilter
                                ? 'All'
                                : category,
                            child: Text(
                              category,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.regionLabel,
                style: const TextStyle(fontSize: 14).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedRegion,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                  ),
                  items: _getRegionOptions(context)
                      .map((region) => DropdownMenuItem(
                            value: region ==
                                    AppLocalizations.of(context)!.allFilter
                                ? 'All'
                                : region,
                            child: Text(
                              region,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRegion = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildActionButton(
                    icon: Icons.clear,
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'All';
                        _selectedRegion = 'All';
                        _activeFilters.clear();
                      });
                      Navigator.pop(context);
                      _showSnackBar(
                          AppLocalizations.of(context)!.filtersClearedMsg);
                    },
                    color: const Color(0xFF757575),
                  ),
                  const SizedBox(width: 8.0),
                  _buildActionButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.pop(context),
                    color: const Color(0xFF757575),
                  ),
                  const SizedBox(width: 8.0),
                  _buildActionButton(
                    icon: Icons.check,
                    onPressed: () {
                      Navigator.pop(context);
                      _showSnackBar(
                          AppLocalizations.of(context)!.filtersAppliedMsg);
                    },
                    color: const Color(0xFF667EEA),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterByStatus(String status) {
    setState(() {
      if (!_activeFilters.contains(status)) {
        _activeFilters.add(status);
      }
    });
  }

  void _viewRateDetails(Map<String, dynamic> rate) {
    // Implementation for viewing rate details
    debugPrint('View rate details: ${rate['id']}');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Icon(
            icon,
            size: 18,
            color: color,
          ),
        ),
      ),
    );
  }
}
