import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/widgets/enhanced_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/app/shared/widgets/enhanced_stat_cards.dart';
import 'package:carenest/app/shared/widgets/enhanced_quick_action_cards.dart';
import 'package:carenest/app/shared/widgets/enhanced_search_filter.dart';
import 'package:carenest/app/shared/widgets/appBar_widget.dart';

/// Enhanced Pricing Dashboard with improved UX/UI
class EnhancedPricingDashboardView extends StatefulWidget {
  const EnhancedPricingDashboardView({super.key});

  @override
  State<EnhancedPricingDashboardView> createState() =>
      _EnhancedPricingDashboardViewState();
}

class _EnhancedPricingDashboardViewState
    extends State<EnhancedPricingDashboardView> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  String _searchQuery = '';
  List<String> _activeFilters = [];
  String? _userEmail;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadDashboardData();
    _loadUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// Load dashboard data
  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  /// Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init(); // Ensure SharedPreferences is initialized
    setState(() {
      _userEmail = sharedPrefs.getUserEmail();
      _userName = sharedPrefs.getString(
          'First LastName'); // Using the key defined in SharedPreferencesUtils
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildModernHeader(),
          _buildHorizontalStats(),
          _buildQuickActions(),
          _buildSearchAndFilter(),
          Expanded(
            child: _buildTabSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader() {
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
                      'Pricing Overview',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Comprehensive pricing management and analytics dashboard',
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

  Widget _buildHorizontalStats() {
    return Container(
      height: 145,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Total Services',
                value: '23',
                subtitle: '+3 new this month',
                icon: Icons.business_center,
                color: const Color(0xFF6366F1),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Avg Rate',
                value: '\$85.00',
                subtitle: '+5.2% vs last month',
                icon: Icons.trending_up,
                color: const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Active Rates',
                value: '156',
                subtitle: '87.5% of total',
                icon: Icons.check_circle,
                color: const Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Revenue',
                value: '\$24.5K',
                subtitle: '+12.5% growth',
                icon: Icons.attach_money,
                color: const Color(0xFF8B5CF6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Build quick actions section
  Widget _buildQuickActions() {
    final quickActions = [
      QuickActionData.pricing(
        title: 'Add New Rate',
        subtitle: 'Create pricing rule',
        icon: Icons.add_circle_outline,
        onTap: () => _navigateToAddRate(),
      ),
      QuickActionData.pricing(
        title: 'Bulk Update',
        subtitle: 'Update multiple rates',
        icon: Icons.edit_note,
        onTap: () => _navigateToBulkUpdate(),
      ),
      QuickActionData.pricing(
        title: 'Price History',
        subtitle: 'View rate changes',
        icon: Icons.history,
        onTap: () => _navigateToPriceHistory(),
      ),
      QuickActionData.pricing(
        title: 'Analytics',
        subtitle: 'Pricing insights',
        icon: Icons.analytics,
        badge: 'New',
        onTap: () => _navigateToAnalytics(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingLarge,
            vertical: AppDimens.paddingMedium,
          ),
          child: Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: AppDimens.fontSizeMedium,
              fontWeight: FontWeight.w600,
              color: AppColors.colorBlack87,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            if (constraints.maxWidth >= 1024) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth >= 768) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth >= 480) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 1;
            }
            return EnhancedQuickActionGrid(
              actions: quickActions,
              crossAxisCount: crossAxisCount,
            );
          },
        ),
      ],
    );
  }

  /// Build search and filter section
  Widget _buildSearchAndFilter() {
    final filterOptions = [
      FilterOption(
        label: 'Active Rates',
        value: 'active',
        icon: Icons.check_circle,
        color: AppColors.colorGreen,
        count: 45,
      ),
      FilterOption(
        label: 'Pending Approval',
        value: 'pending',
        icon: Icons.pending,
        color: AppColors.colorOrange,
        count: 12,
      ),
      FilterOption(
        label: 'Expired',
        value: 'expired',
        icon: Icons.cancel,
        color: AppColors.colorRed,
        count: 8,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingLarge),
      child: EnhancedSearchFilterBar(
        searchHint: 'Search pricing rules...',
        onSearchChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        filterOptions: filterOptions,
        onFilterChanged: (filter) {
          if (filter != null) {
            setState(() {
              if (!_activeFilters.contains(filter.label)) {
                _activeFilters.add(filter.label);
              }
            });
          }
        },
        activeFilters: _activeFilters,
        onClearFilters: () {
          setState(() {
            _activeFilters.clear();
          });
        },
      ),
    );
  }

  /// Build tab section with data tables
  Widget _buildTabSection() {
    return Container(
      margin: const EdgeInsets.all(AppDimens.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorShadow,
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tab Bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.colorGrey300,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.colorPrimary,
              unselectedLabelColor: AppColors.colorGrey600,
              indicatorColor: AppColors.colorPrimary,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: AppDimens.fontSizeNormal,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Current Rates'),
                Tab(text: 'Rate History'),
                Tab(text: 'Configurations'),
              ],
            ),
          ),
          // Tab Content
          Container(
            constraints: BoxConstraints(
              minHeight: 300,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCurrentRatesTab(),
                _buildRateHistoryTab(),
                _buildConfigurationsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build current rates tab
  Widget _buildCurrentRatesTab() {
    final columns = [
      const EnhancedDataColumn(
        label: Text('Service'),
        sortable: true,
      ),
      const EnhancedDataColumn(
        label: Text('Rate'),
        numeric: true,
        sortable: true,
      ),
      EnhancedDataColumn(
        label: const Text('Status'),
        sortable: true,
      ),
      EnhancedDataColumn(
        label: const Text('Last Updated'),
        sortable: true,
      ),
      EnhancedDataColumn(
        label: const Text('Actions'),
        sortable: false,
      ),
    ];

    final rows = [
      EnhancedDataRow(
        cells: [
          EnhancedDataCell(child: const Text('Personal Care')),
          EnhancedDataCell(child: const Text('\$85.00/hr')),
          EnhancedDataCell.status(status: 'Active'),
          EnhancedDataCell(child: const Text('2 days ago')),
          EnhancedDataCell.actions(
            actions: [
              ActionButton(
                icon: Icons.edit,
                onPressed: () => _editRate('personal_care'),
                tooltip: 'Edit Rate',
                color: AppColors.colorBlue,
              ),
              ActionButton(
                icon: Icons.history,
                onPressed: () => _viewRateHistory('personal_care'),
                tooltip: 'View History',
                color: AppColors.colorGrey600,
              ),
            ],
          ),
        ],
      ),
      // Add more rows as needed
    ];

    return EnhancedDataTable(
      columns: columns,
      rows: rows,
      isLoading: _isLoading,
      emptyMessage: 'No pricing rates found',
      onSort: (columnIndex, ascending) {
        // Handle sorting with both parameters
        // You can use both columnIndex and ascending to implement your sorting logic
      },
    );
  }

  /// Build rate history tab
  Widget _buildRateHistoryTab() {
    // Similar implementation for rate history
    return const Center(
      child: Text('Rate History Content'),
    );
  }

  /// Build configurations tab
  Widget _buildConfigurationsTab() {
    // Similar implementation for configurations
    return const Center(
      child: Text('Configurations Content'),
    );
  }

  // Navigation methods
  void _navigateToRevenue() {
    // Navigate to revenue details
  }

  void _navigateToClients() {
    // Navigate to clients
  }

  void _navigateToInvoices() {
    // Navigate to invoices
  }

  void _navigateToRates() {
    // Navigate to rates
  }

  void _navigateToAddRate() {
    // Navigate to add rate
  }

  void _navigateToBulkUpdate() {
    // Navigate to bulk update
  }

  void _navigateToPriceHistory() {
    // Navigate to price history
  }

  void _navigateToAnalytics() {
    // Navigate to analytics
  }

  void _editRate(String rateId) {
    // Edit rate functionality
  }

  void _viewRateHistory(String rateId) {
    // View rate history functionality
  }
}
