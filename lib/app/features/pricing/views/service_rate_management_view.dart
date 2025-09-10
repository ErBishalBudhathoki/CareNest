import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/app/features/pricing/widgets/enhanced_design_system.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/foundation.dart';

class ServiceRateManagementView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const ServiceRateManagementView({
    Key? key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  }) : super(key: key);

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
  bool _showOnboarding = true;
  Set<String> _selectedRateIds = {};
  List<String> _activeFilters = [];

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

  final List<String> _categories = [
    'All',
    'Core Support',
    'Capacity Building',
    'Capital Support'
  ];
  final List<String> _regions = ['All', 'Capital City', 'Regional', 'Remote'];

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
      backgroundColor: EnhancedDesignSystem.surfaceGray,
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
                              'Service Rate Management',
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
                                'Manage and optimize your service pricing across different regions and categories',
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
                            'Manage and optimize your service pricing across different regions and categories',
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

  // Widget _buildModernHeader() {
  //   return Container(
  //     color: EnhancedDesignSystem.surfaceWhite,
  //     child: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(EnhancedDesignSystem.space6),
  //         child: Row(
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: EnhancedDesignSystem.gray100,
  //                 borderRadius:
  //                     BorderRadius.circular(EnhancedDesignSystem.radiusMd),
  //               ),
  //               child: IconButton(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 icon: const Icon(
  //                   Icons.arrow_back_ios_new,
  //                   size: 20,
  //                 ),
  //                 color: EnhancedDesignSystem.gray700,
  //               ),
  //             ),
  //             const SizedBox(width: EnhancedDesignSystem.space4),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Service Rate Management',
  //                     style: EnhancedDesignSystem.headingXl,
  //                   ),
  //                   const SizedBox(height: EnhancedDesignSystem.space2),
  //                   Text(
  //                     'Manage and optimize your service pricing across different regions and categories',
  //                     style: EnhancedDesignSystem.bodyLg.copyWith(
  //                       color: EnhancedDesignSystem.gray600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: EnhancedDesignSystem.space4,
  //                 vertical: EnhancedDesignSystem.space2,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: EnhancedDesignSystem.successColor.withValues(alpha:0.1),
  //                 borderRadius:
  //                     BorderRadius.circular(EnhancedDesignSystem.radiusLg),
  //                 border: Border.all(
  //                   color: EnhancedDesignSystem.successColor.withValues(alpha:0.3),
  //                 ),
  //               ),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     width: 8,
  //                     height: 8,
  //                     decoration: BoxDecoration(
  //                       color: EnhancedDesignSystem.successColor,
  //                       borderRadius: BorderRadius.circular(4),
  //                     ),
  //                   ),
  //                   const SizedBox(width: EnhancedDesignSystem.space2),
  //                   Text(
  //                     'System Active',
  //                     style: EnhancedDesignSystem.bodySm.copyWith(
  //                       color: EnhancedDesignSystem.successColor,
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
    return EnhancedSearchBar(
      controller: _searchController,
      hintText: 'Search service rates...',
      activeFilters: _activeFilters,
      onFilterTap: _showFilterDialog,
      onAddTap: _showAddRateDialog,
    );
  }

  Widget _buildHorizontalStats() {
    return Container(
      height: 145,
      margin: const EdgeInsets.symmetric(vertical: EnhancedDesignSystem.space4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(horizontal: EnhancedDesignSystem.space4),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: EnhancedStatCard(
                title: 'Total Rates',
                value: '${_serviceRates.length}',
                subtitle: '+12 this month',
                icon: Icons.rate_review,
                color: EnhancedDesignSystem.primaryColor,
                isLoading: _isLoading,
                onTap: () => _filterByStatus('all'),
              ),
            ),
            const SizedBox(width: EnhancedDesignSystem.space2),
            SizedBox(
              width: 160,
              child: EnhancedStatCard(
                title: 'Active Rates',
                value:
                    '${_serviceRates.where((r) => r['status'] == 'Active').length}',
                subtitle: '3 urgent',
                icon: Icons.check_circle,
                color: EnhancedDesignSystem.successColor,
                isLoading: _isLoading,
                onTap: () => _filterByStatus('active'),
              ),
            ),
            const SizedBox(width: EnhancedDesignSystem.space2),
            SizedBox(
              width: 160,
              child: EnhancedStatCard(
                title: 'Pending Updates',
                value:
                    '${_serviceRates.where((r) => r['status'] == 'Pending').length}',
                subtitle: 'vs last quarter',
                icon: Icons.pending,
                color: EnhancedDesignSystem.warningColor,
                isLoading: _isLoading,
                onTap: () => _filterByStatus('pending'),
              ),
            ),
            const SizedBox(width: EnhancedDesignSystem.space2),
            SizedBox(
              width: 160,
              child: EnhancedStatCard(
                title: 'Avg Base Rate',
                value: _serviceRates.isEmpty
                    ? '\$0.00'
                    : '\$${(_serviceRates.map((r) => r['baseRate'] as double).reduce((a, b) => a + b) / _serviceRates.length).toStringAsFixed(2)}',
                subtitle: 'projected monthly',
                icon: Icons.attach_money,
                color: EnhancedDesignSystem.infoColor,
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
      return EnhancedEmptyState(
        title: 'No Service Rates Found',
        message:
            'Try adjusting your search criteria or add new service rates to get started.',
        icon: Icons.rate_review_outlined,
        actionLabel: 'Add New Rate',
        onAction: _showAddRateDialog,
      );
    }

    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: EnhancedDesignSystem.space6),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: EnhancedDesignSystem.space6),
        itemCount: filteredRates.length,
        itemBuilder: (context, index) {
          final rate = filteredRates[index];
          final isSelected = _selectedRateIds.contains(rate['id']);
          return EnhancedRateCard(
            rate: rate,
            isSelected: isSelected,
            onTap: () => _viewRateDetails(rate),
            onEdit: () => _editRate(rate),
            onDelete: () => _deleteRate(rate['id']),
            onToggleSelect: () {
              setState(() {
                if (isSelected) {
                  _selectedRateIds.remove(rate['id']);
                } else {
                  _selectedRateIds.add(rate['id']);
                }
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildModernSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(EnhancedDesignSystem.space6),
      decoration: BoxDecoration(
        color: EnhancedDesignSystem.surfaceWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(EnhancedDesignSystem.radiusLg),
          topRight: Radius.circular(EnhancedDesignSystem.radiusLg),
        ),
      ),
      child: Column(
        children: [
          EnhancedSearchBar(
            controller: _searchController,
            hintText: 'Search service rates...',
            activeFilters: _activeFilters,
            onFilterTap: _showFilterDialog,
            onAddTap: _showAddRateDialog,
          ),
          const SizedBox(height: EnhancedDesignSystem.space4),
          Row(
            children: [
              Expanded(
                child: _buildModernDropdown(
                  'Category',
                  _selectedCategory,
                  ['All', 'Support Worker', 'Specialist'],
                  (value) => setState(() => _selectedCategory = value!),
                ),
              ),
              const SizedBox(width: EnhancedDesignSystem.space4),
              Expanded(
                child: _buildModernDropdown(
                  'Region',
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
        color: EnhancedDesignSystem.surfaceGray,
        borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusMd),
        border: Border.all(
          color: EnhancedDesignSystem.gray300,
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: EnhancedDesignSystem.bodyMd.copyWith(
            color: EnhancedDesignSystem.gray600,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: EnhancedDesignSystem.space4,
            vertical: EnhancedDesignSystem.space2,
          ),
          isDense: true,
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: EnhancedDesignSystem.bodyMd,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ))
            .toList(),
        onChanged: onChanged,
        dropdownColor: EnhancedDesignSystem.surfaceWhite,
        style: EnhancedDesignSystem.bodyMd,
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
                hintText: 'Search service rates...',
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
              value: _selectedCategory,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
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
              value: _selectedRegion,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Region',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _regions.map((region) {
                return DropdownMenuItem(
                  value: region,
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
            label: const Text('Add Rate'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
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
            hintText: 'Search service rates...',
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
              value: _selectedCategory,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRegion,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Region',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: _regions.map((region) {
                return DropdownMenuItem(
                  value: region,
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
          label: const Text('Add Rate'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.colorPrimary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildModernRateCard(Map<String, dynamic> rate) {
    return Container(
        margin: const EdgeInsets.only(bottom: EnhancedDesignSystem.space4),
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
                      padding:
                          const EdgeInsets.all(EnhancedDesignSystem.space2),
                      decoration: BoxDecoration(
                        color: EnhancedDesignSystem.primaryColor
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                            EnhancedDesignSystem.radiusMd),
                      ),
                      child: Icon(
                        Icons.schedule,
                        color: EnhancedDesignSystem.primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: EnhancedDesignSystem.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rate['serviceName'],
                            style: EnhancedDesignSystem.headingMd.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: EnhancedDesignSystem.space1),
                          Wrap(
                            spacing: EnhancedDesignSystem.space2,
                            runSpacing: EnhancedDesignSystem.space1,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: EnhancedDesignSystem.primaryColor
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  rate['category'],
                                  style: EnhancedDesignSystem.bodySm.copyWith(
                                    color: EnhancedDesignSystem.primaryColor,
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
                                    color: EnhancedDesignSystem.gray300,
                                  ),
                                ),
                                child: Text(
                                  rate['region'],
                                  style: EnhancedDesignSystem.bodySm.copyWith(
                                    color: EnhancedDesignSystem.gray600,
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
                            ? EnhancedDesignSystem.successColor
                                .withValues(alpha: 0.1)
                            : EnhancedDesignSystem.warningColor
                                .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        rate['status'],
                        style: EnhancedDesignSystem.bodySm.copyWith(
                          color: rate['status'] == 'Active'
                              ? EnhancedDesignSystem.successColor
                              : EnhancedDesignSystem.warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: EnhancedDesignSystem.space6),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 400) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRateInfo(
                            'Base Rate',
                            '\$${rate['baseRate'].toStringAsFixed(2)}/hr',
                            EnhancedDesignSystem.successColor,
                          ),
                          const SizedBox(height: EnhancedDesignSystem.space4),
                          _buildRateInfo(
                            'Weekend Rate',
                            '\$${rate['weekendRate'].toStringAsFixed(2)}/hr',
                            EnhancedDesignSystem.infoColor,
                          ),
                          const SizedBox(height: EnhancedDesignSystem.space4),
                          _buildRateInfo(
                            'Holiday Rate',
                            '\$${rate['publicHolidayRate'].toStringAsFixed(2)}/hr',
                            EnhancedDesignSystem.warningColor,
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: _buildRateInfo(
                            'Base Rate',
                            '\$${rate['baseRate'].toStringAsFixed(2)}/hr',
                            EnhancedDesignSystem.successColor,
                          ),
                        ),
                        Expanded(
                          child: _buildRateInfo(
                            'Weekend Rate',
                            '\$${rate['weekendRate'].toStringAsFixed(2)}/hr',
                            EnhancedDesignSystem.infoColor,
                          ),
                        ),
                        Expanded(
                          child: _buildRateInfo(
                            'Holiday Rate',
                            '\$${rate['publicHolidayRate'].toStringAsFixed(2)}/hr',
                            EnhancedDesignSystem.warningColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: EnhancedDesignSystem.space6),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 300) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildActionButton(
                            icon: Icons.edit,
                            onPressed: () => _editRate(rate),
                            color: EnhancedDesignSystem.gray600,
                          ),
                          const SizedBox(height: EnhancedDesignSystem.space2),
                          _buildActionButton(
                            icon: Icons.delete,
                            onPressed: () => _deleteRate(rate['id']),
                            color: EnhancedDesignSystem.errorColor,
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
                          color: EnhancedDesignSystem.gray600,
                        ),
                        const SizedBox(width: EnhancedDesignSystem.space2),
                        _buildActionButton(
                          icon: Icons.delete,
                          onPressed: () => _deleteRate(rate['id']),
                          color: EnhancedDesignSystem.errorColor,
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
          style: EnhancedDesignSystem.bodySm.copyWith(
            color: EnhancedDesignSystem.gray600,
          ),
        ),
        const SizedBox(height: EnhancedDesignSystem.space1),
        Text(
          value,
          style: EnhancedDesignSystem.bodyLg.copyWith(
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
      _showSnackBar('Data refreshed successfully');
    });
  }

  void _exportRates() {
    _showSnackBar('Exporting rates to CSV...');
  }

  void _showAddRateDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusLg),
        ),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(EnhancedDesignSystem.space6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(EnhancedDesignSystem.space2),
                    decoration: BoxDecoration(
                      color: EnhancedDesignSystem.primaryColor
                          .withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(EnhancedDesignSystem.radiusMd),
                    ),
                    child: Icon(
                      Icons.add,
                      color: EnhancedDesignSystem.primaryColor,
                    ),
                  ),
                  const SizedBox(width: EnhancedDesignSystem.space4),
                  Text(
                    'Add New Service Rate',
                    style: EnhancedDesignSystem.headingMd.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: EnhancedDesignSystem.space6),
              Text(
                'Create a new service rate configuration. This feature will be fully implemented in the next update.',
                style: EnhancedDesignSystem.bodyMd.copyWith(
                  color: EnhancedDesignSystem.gray600,
                ),
              ),
              const SizedBox(height: EnhancedDesignSystem.space6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildActionButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.pop(context),
                    color: EnhancedDesignSystem.gray600,
                  ),
                  const SizedBox(width: EnhancedDesignSystem.space2),
                  _buildActionButton(
                    icon: Icons.add,
                    onPressed: () {
                      Navigator.pop(context);
                      _showSnackBar('New rate feature coming soon!');
                    },
                    color: EnhancedDesignSystem.primaryColor,
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
        title: const Text('Delete Rate'),
        content: Text(
            'Are you sure you want to delete the rate for ${rate['serviceName']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _serviceRates.remove(rate);
              });
              _showSnackBar('Rate deleted successfully');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
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
          borderRadius: BorderRadius.circular(EnhancedDesignSystem.radiusLg),
        ),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(EnhancedDesignSystem.space6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(EnhancedDesignSystem.space2),
                    decoration: BoxDecoration(
                      color: EnhancedDesignSystem.primaryColor
                          .withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(EnhancedDesignSystem.radiusMd),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: EnhancedDesignSystem.primaryColor,
                    ),
                  ),
                  const SizedBox(width: EnhancedDesignSystem.space4),
                  Text(
                    'Filter Service Rates',
                    style: EnhancedDesignSystem.headingMd.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: EnhancedDesignSystem.space6),
              Text(
                'Category',
                style: EnhancedDesignSystem.bodyMd.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: EnhancedDesignSystem.space2),
              Container(
                decoration: BoxDecoration(
                  color: EnhancedDesignSystem.gray50,
                  borderRadius:
                      BorderRadius.circular(EnhancedDesignSystem.radiusMd),
                  border: Border.all(
                    color: EnhancedDesignSystem.borderColor,
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: EnhancedDesignSystem.space4,
                      vertical: EnhancedDesignSystem.space2,
                    ),
                  ),
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style: EnhancedDesignSystem.bodyMd,
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
              const SizedBox(height: EnhancedDesignSystem.space4),
              Text(
                'Region',
                style: EnhancedDesignSystem.bodyMd.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: EnhancedDesignSystem.space2),
              Container(
                decoration: BoxDecoration(
                  color: EnhancedDesignSystem.gray50,
                  borderRadius:
                      BorderRadius.circular(EnhancedDesignSystem.radiusMd),
                  border: Border.all(
                    color: EnhancedDesignSystem.borderColor,
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedRegion,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: EnhancedDesignSystem.space4,
                      vertical: EnhancedDesignSystem.space2,
                    ),
                  ),
                  items: _regions
                      .map((region) => DropdownMenuItem(
                            value: region,
                            child: Text(
                              region,
                              style: EnhancedDesignSystem.bodyMd,
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
              const SizedBox(height: EnhancedDesignSystem.space6),
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
                      _showSnackBar('Filters cleared');
                    },
                    color: EnhancedDesignSystem.gray600,
                  ),
                  const SizedBox(width: EnhancedDesignSystem.space2),
                  _buildActionButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.pop(context),
                    color: EnhancedDesignSystem.gray600,
                  ),
                  const SizedBox(width: EnhancedDesignSystem.space2),
                  _buildActionButton(
                    icon: Icons.check,
                    onPressed: () {
                      Navigator.pop(context);
                      _showSnackBar('Filters applied');
                    },
                    color: EnhancedDesignSystem.primaryColor,
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
        backgroundColor: AppColors.colorPrimary,
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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
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
