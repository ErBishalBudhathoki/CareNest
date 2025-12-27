import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

import 'package:flutter_animate/flutter_animate.dart';

class PriceHistoryView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const PriceHistoryView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  });

  @override
  ConsumerState<PriceHistoryView> createState() => _PriceHistoryViewState();
}

class _PriceHistoryViewState extends ConsumerState<PriceHistoryView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedTimeRange = '30 days';
  String _selectedCategory = 'All';
  bool _isLoading = false;

  // Mock data for price history
  final List<Map<String, dynamic>> _priceHistory = [
    {
      'id': 'PH001',
      'itemCode': '01_001_0107_1_1',
      'itemName': 'Personal Care - Weekday',
      'category': 'Core Support',
      'oldPrice': 62.17,
      'newPrice': 65.57,
      'changeAmount': 3.40,
      'changePercentage': 5.47,
      'changeType': 'Increase',
      'changeDate': '2024-01-15',
      'effectiveDate': '2024-02-01',
      'reason': 'Annual NDIS price review',
      'changedBy': 'admin@example.com',
      'status': 'Active',
    },
    {
      'id': 'PH002',
      'itemCode': '01_002_0107_1_1',
      'itemName': 'Community Participation',
      'category': 'Capacity Building',
      'oldPrice': 64.82,
      'newPrice': 68.19,
      'changeAmount': 3.37,
      'changePercentage': 5.20,
      'changeType': 'Increase',
      'changeDate': '2024-01-15',
      'effectiveDate': '2024-02-01',
      'reason': 'Annual NDIS price review',
      'changedBy': 'admin@example.com',
      'status': 'Active',
    },
    {
      'id': 'PH003',
      'itemCode': '01_003_0107_1_1',
      'itemName': 'Household Tasks',
      'category': 'Core Support',
      'oldPrice': 65.57,
      'newPrice': 62.17,
      'changeAmount': -3.40,
      'changePercentage': -5.18,
      'changeType': 'Decrease',
      'changeDate': '2024-01-10',
      'effectiveDate': '2024-01-20',
      'reason': 'Regional adjustment',
      'changedBy': 'admin@example.com',
      'status': 'Pending',
    },
    {
      'id': 'PH004',
      'itemCode': '01_004_0107_1_1',
      'itemName': 'Transport Services',
      'category': 'Core Support',
      'oldPrice': 58.90,
      'newPrice': 61.85,
      'changeAmount': 2.95,
      'changePercentage': 5.01,
      'changeType': 'Increase',
      'changeDate': '2024-01-05',
      'effectiveDate': '2024-01-15',
      'reason': 'Fuel cost adjustment',
      'changedBy': 'admin@example.com',
      'status': 'Active',
    },
  ];

  final List<String> _timeRanges = [
    '7 days',
    '30 days',
    '90 days',
    '6 months',
    '1 year'
  ];
  final List<String> _categories = [
    'All',
    'Core Support',
    'Capacity Building',
    'Capital Support'
  ];

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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildModernHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildStatsCards(),
                  const SizedBox(height: 24),
                  _buildTabSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader() {
    return SliverToBoxAdapter(
      child: Container(
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
                                'Price History',
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
                                  'Track pricing changes over time',
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
                              color: const Color(0xFF10B981).withOpacity(0.1),
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
                              'Track pricing changes over time',
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
                              color: const Color(0xFF10B981).withOpacity(0.1),
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
      ),
    );
  }

  // Widget _buildSliverAppBar() {
  //   return SliverAppBar(
  //     expandedHeight: 120,
  //     floating: false,
  //     pinned: true,
  //,
  //     flexibleSpace: FlexibleSpaceBar(
  //       title: const Text(
  //         'Price History',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       surface: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //             colors: [
  //               AppColors.colorPrimary,
  //               AppColors.colorPrimary.withOpacity(0.1),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //     leading: IconButton(
  //       icon: const Icon(Icons.arrow_back, color: Colors.white),
  //       onPressed: () => Navigator.pop(context),
  //     ),
  //     actions: [
  //       IconButton(
  //         icon: const Icon(Icons.refresh, color: Colors.white),
  //         onPressed: _refreshData,
  //       ),
  //       IconButton(
  //         icon: const Icon(Icons.download, color: Colors.white),
  //         onPressed: _exportHistory,
  //       ),
  //     ],
  //   );
  // }

  Widget _buildStatsCards() {
    final totalChanges = _priceHistory.length;
    final increases =
        _priceHistory.where((h) => h['changeType'] == 'Increase').length;
    final decreases =
        _priceHistory.where((h) => h['changeType'] == 'Decrease').length;
    final avgChange = _priceHistory.isNotEmpty
        ? _priceHistory
                .map((h) => h['changePercentage'] as double)
                .reduce((a, b) => a + b) /
            _priceHistory.length
        : 0.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: _buildStatCard(
              'Total Changes',
              '$totalChanges',
              Icons.timeline,
              AppColors.colorBlue,
              AppColors.colorBlue50,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 160,
            child: _buildStatCard(
              'Price Increases',
              '$increases',
              Icons.trending_up,
              AppColors.colorGreen,
              AppColors.colorGreen50,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 160,
            child: _buildStatCard(
              'Price Decreases',
              '$decreases',
              Icons.trending_down,
              AppColors.colorRed,
              AppColors.colorRed50,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 160,
            child: _buildStatCard(
              'Avg Change',
              '${avgChange.toStringAsFixed(1)}%',
              Icons.percent,
              AppColors.colorPurple,
              Colors.purple[50]!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color, Color bgInfo) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.colorGrey200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: bgInfo,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorGrey900,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.colorGrey600,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.colorGrey100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(4),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.colorWhite,
            unselectedLabelColor: AppColors.colorGrey600,
            indicator: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Price Changes'),
              Tab(text: 'Trends'),
              Tab(text: 'Analytics'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          constraints: BoxConstraints(
            minHeight: 400,
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildPriceChangesTab(),
              _buildTrendsTab(),
              _buildAnalyticsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceChangesTab() {
    return Column(
      children: [
        _buildSearchAndFilters(),
        const SizedBox(height: 8),
        Expanded(
          child: _buildHistoryList(),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return LayoutBuilder(builder: (context, constraints) {
      final searchField = TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search price history...',
          hintStyle:
              const TextStyle(color: AppColors.colorGrey400, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: AppColors.colorGrey400),
          filled: true,
          fillColor: AppColors.colorWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.colorGrey200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.colorGrey200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.colorPrimary, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        onChanged: (value) => setState(() {}),
      );

      final timeRangeDropdown = DropdownButtonFormField<String>(
        initialValue: _selectedTimeRange,
        isExpanded: true,
        isDense: true,
        decoration: InputDecoration(
          labelText: 'Time Range',
          labelStyle:
              const TextStyle(color: AppColors.colorGrey600, fontSize: 14),
          filled: true,
          fillColor: AppColors.colorWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.colorGrey200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.colorGrey200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.colorPrimary, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        items: _timeRanges.map((range) {
          return DropdownMenuItem(
            value: range,
            child: Text(
              range,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 14, color: AppColors.colorGrey800),
            ),
          );
        }).toList(),
        onChanged: (value) => setState(() => _selectedTimeRange = value!),
      );

      final categoryDropdown = DropdownButtonFormField<String>(
        initialValue: _selectedCategory,
        isExpanded: true,
        isDense: true,
        decoration: InputDecoration(
          labelText: 'Category',
          labelStyle:
              const TextStyle(color: AppColors.colorGrey600, fontSize: 14),
          filled: true,
          fillColor: AppColors.colorWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.colorGrey200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.colorGrey200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.colorPrimary, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        items: _categories.map((category) {
          return DropdownMenuItem(
            value: category,
            child: Text(
              category,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 14, color: AppColors.colorGrey800),
            ),
          );
        }).toList(),
        onChanged: (value) => setState(() => _selectedCategory = value!),
      );

      if (constraints.maxWidth > 700) {
        return Row(
          children: [
            Expanded(flex: 2, child: searchField),
            const SizedBox(width: 16),
            Expanded(flex: 1, child: timeRangeDropdown),
            const SizedBox(width: 16),
            Expanded(flex: 1, child: categoryDropdown),
          ],
        );
      } else {
        return Column(
          children: [
            searchField,
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: timeRangeDropdown),
                const SizedBox(width: 12),
                Expanded(child: categoryDropdown),
              ],
            ),
          ],
        );
      }
    });
  }

  Widget _buildHistoryList() {
    final filteredHistory = _priceHistory.where((history) {
      final matchesSearch = _searchController.text.isEmpty ||
          history['itemName']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          history['itemCode']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' ||
          history['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: filteredHistory.length,
      itemBuilder: (context, index) {
        final history = filteredHistory[index];
        return _buildHistoryCard(history);
      },
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history) {
    final isIncrease = history['changeType'] == 'Increase';
    final changeColor = isIncrease ? Colors.green : Colors.red;
    final changeIcon = isIncrease ? Icons.trending_up : Icons.trending_down;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history['itemName'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${history['itemCode']} • ${history['category']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: history['status'] == 'Active'
                          ? Colors.green[100]
                          : Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      history['status'],
                      style: TextStyle(
                        color: history['status'] == 'Active'
                            ? Colors.green[700]
                            : Colors.orange[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(changeIcon, color: changeColor, size: 24),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPriceInfo(
                  'Old Price',
                  '\$${history['oldPrice'].toStringAsFixed(2)}',
                  Colors.grey[600]!,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.arrow_forward, color: Colors.grey[400]),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPriceInfo(
                  'New Price',
                  '\$${history['newPrice'].toStringAsFixed(2)}',
                  changeColor,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildPriceInfo(
                  'Change',
                  '${isIncrease ? '+' : ''}\$${history['changeAmount'].toStringAsFixed(2)}',
                  changeColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPriceInfo(
                  'Percentage',
                  '${isIncrease ? '+' : ''}${history['changePercentage'].toStringAsFixed(1)}%',
                  changeColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Reason: ${history['reason']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Changed: ${history['changeDate']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Effective: ${history['effectiveDate']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'By: ${history['changedBy']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildPriceInfo(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendsTab() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.trending_up, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Price Trends',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Visual charts and trends analysis',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Price Analytics',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Detailed analytics and insights',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
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

  void _exportHistory() {
    _showSnackBar('Exporting price history to CSV...');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
