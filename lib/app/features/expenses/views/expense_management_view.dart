import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/app/shared/widgets/stat_cards.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import 'package:carenest/app/features/expenses/providers/expense_provider.dart';
import 'package:carenest/app/features/expenses/views/add_expense_view.dart';
import 'package:carenest/app/features/expenses/views/expense_detail_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_components.dart';

class ExpenseManagementView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String? organizationId;
  final String? organizationName;

  const ExpenseManagementView({
    super.key,
    required this.adminEmail,
    this.organizationId,
    this.organizationName,
  });

  @override
  ConsumerState<ExpenseManagementView> createState() =>
      _ExpenseManagementViewState();
}

class _ExpenseManagementViewState extends ConsumerState<ExpenseManagementView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late TabController _tabController;
  bool _isLoadingExpenses = false;
  bool _expensesEmpty = false;
  bool _showOnboarding = true; // For onboarding tooltip

  // User role management
  final SharedPreferencesUtils _sharedPrefs = SharedPreferencesUtils();
  UserRole? _userRole;
  List<String> _tabs = [];

  final List<String> _allTabs = [
    'Dashboard',
    'Expense List',
    'Add Expense',
    'Approvals',
    'Recurring',
    'Reports'
  ];

  final List<String> _normalUserTabs = [
    'Dashboard',
    'Expense List',
    'Add Expense',
    'Recurring',
    'Reports'
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Initialize with default tabs first to prevent LateInitializationError
    _tabs = _normalUserTabs; // Default to normal user tabs
    _tabController = TabController(length: _tabs.length, vsync: this);

    // Initialize SharedPreferences and set up tabs based on user role
    _initializeUserRole();

    _animationController.forward();

    // Fetch expenses data if organization ID is available
    // Use addPostFrameCallback to avoid modifying provider during widget tree building
    if (widget.organizationId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchExpenses();
      });
    }
  }

  /// Initialize SharedPreferences and determine user role to set appropriate tabs
  Future<void> _initializeUserRole() async {
    await _sharedPrefs.init();
    _userRole = _sharedPrefs.getRole();

    setState(() {
      // Set tabs based on user role - only admins can see Approvals tab
      final newTabs = _userRole == UserRole.admin ? _allTabs : _normalUserTabs;

      // Only update if tabs actually changed to avoid unnecessary rebuilds
      if (_tabs.length != newTabs.length ||
          !_tabs.every((tab) => newTabs.contains(tab))) {
        _tabs = newTabs;

        // Dispose old controller and create new one with correct length
        _tabController.dispose();
        _tabController = TabController(length: _tabs.length, vsync: this);
      }
    });
  }

  /// Build tab views dynamically based on user role
  List<Widget> _buildTabViews() {
    final List<Widget> tabViews = [];

    for (String tab in _tabs) {
      switch (tab) {
        case 'Dashboard':
          tabViews.add(_buildDashboardTab());
          break;
        case 'Expense List':
          tabViews.add(_buildExpenseListTab());
          break;
        case 'Add Expense':
          tabViews.add(_buildAddExpenseTab());
          break;
        case 'Approvals':
          // Only show approvals tab for admin users
          if (_userRole == UserRole.admin) {
            tabViews.add(_buildApprovalsTab());
          }
          break;
        case 'Recurring':
          tabViews.add(_buildRecurringTab());
          break;
        case 'Reports':
          tabViews.add(_buildReportsTab());
          break;
      }
    }

    return tabViews;
  }

  Future<void> _fetchExpenses() async {
    debugPrint('=== EXPENSE DEBUG: _fetchExpenses called ===');
    debugPrint(
        '=== EXPENSE DEBUG: widget.organizationId = ${widget.organizationId} ===');
    debugPrint(
        '=== EXPENSE DEBUG: organizationId is null? ${widget.organizationId == null} ===');
    debugPrint(
        '=== EXPENSE DEBUG: organizationId is empty? ${widget.organizationId?.isEmpty} ===');

    setState(() {
      _isLoadingExpenses = true;
    });

    try {
      debugPrint(
          '=== EXPENSE DEBUG: About to call fetchExpenses with organizationId: ${widget.organizationId} ===');
      await ref
          .read(expenseProvider.notifier)
          .fetchExpenses(widget.organizationId!);
      final expenses = ref.read(expenseProvider).expenses;
      debugPrint(
          '=== EXPENSE DEBUG: fetchExpenses completed, expenses count: ${expenses.length} ===');

      // Print each expense for debugging
      for (int i = 0; i < expenses.length; i++) {
        debugPrint(
            '=== EXPENSE DEBUG: Expense $i: ${expenses[i].id} - ${expenses[i].title} ===');
      }

      setState(() {
        _expensesEmpty = expenses.isEmpty;
        _isLoadingExpenses = false;
      });
    } catch (e) {
      debugPrint('=== EXPENSE DEBUG: Error in _fetchExpenses: $e ===');
      setState(() {
        _isLoadingExpenses = false;
      });
      _showSnackBar('Failed to load expenses: ${e.toString()}', isError: true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernSaasDesign.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildStatsCards(),
                    _buildTabSection(),
                  ],
                ),
              ),
            ],
          ),
          if (_showOnboarding)
            Positioned(
              top: 120,
              left: ModernSaasDesign.space6,
              right: ModernSaasDesign.space6,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(ModernSaasDesign.space4),
                  decoration: BoxDecoration(
                    color: ModernSaasDesign.surface,
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color:
                            ModernSaasDesign.neutral900.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: ModernSaasDesign.primary),
                      SizedBox(width: ModernSaasDesign.space3),
                      Expanded(
                        child: Text(
                          'Welcome! Use the tabs to manage expenses, approvals, and reports. Tap any stat card for details.',
                          style: ModernSaasDesign.bodyMedium,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Dismiss',
                        onPressed: () =>
                            setState(() => _showOnboarding = false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 160,
      floating: false,
      pinned: true,
      backgroundColor: ModernSaasDesign.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Expense Management',
          style: ModernSaasDesign.headlineSmall.copyWith(
            color: ModernSaasDesign.textOnPrimary,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ModernSaasDesign.primary,
                ModernSaasDesign.primaryDark,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 60,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: ModernSaasDesign.surface),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: ModernSaasDesign.surface),
          onPressed: () {
            _refreshExpenseData();
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: ModernSaasDesign.surface),
          onPressed: () {
            _showSnackBar('Expense settings coming soon...');
          },
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    final expenseState = ref.watch(expenseProvider);
    final expenses = expenseState.expenses;
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    // Calculate real data from expenses
    final totalAmount = expenses.totalAmount;
    final pendingCount = expenses.filterByStatus('pending').length;
    final thisMonthAmount = expenses.where((expense) {
      final now = DateTime.now();
      return expense.date.year == now.year && expense.date.month == now.month;
    }).fold<double>(0.0, (sum, expense) => sum + expense.amount);

    final List<StatCardData> statCardsData = [
      StatCardData(
        title: 'Total Expenses',
        value: currencyFormat.format(totalAmount),
        icon: Icons.account_balance_wallet_rounded,
        color: const Color(0xFF4CAF50),
        backgroundColor: Colors.white,
        showBorder: true,
        valueColor: const Color(0xFF1E293B),
        titleColor: Colors.grey[600],
      ),
      StatCardData(
        title: 'Pending Approval',
        value: pendingCount.toString(),
        icon: Icons.pending_actions_rounded,
        color: const Color(0xFFF59E0B),
        backgroundColor: Colors.white,
        showBorder: true,
        valueColor: const Color(0xFF1E293B),
        titleColor: Colors.grey[600],
      ),
      StatCardData(
        title: 'This Month',
        value: currencyFormat.format(thisMonthAmount),
        icon: Icons.date_range_rounded,
        color: const Color(0xFF3B82F6),
        backgroundColor: Colors.white,
        showBorder: true,
        valueColor: const Color(0xFF1E293B),
        titleColor: Colors.grey[600],
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use responsive layout to prevent overflow
        if (constraints.maxWidth < 600) {
          // For smaller screens, use a column layout with 2 cards per row
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        data: statCardsData[0],
                        animate: true,
                        animationDelay: Duration.zero,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        data: statCardsData[1],
                        animate: true,
                        animationDelay: const Duration(milliseconds: 150),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        data: statCardsData[2],
                        animate: true,
                        animationDelay: const Duration(milliseconds: 300),
                      ),
                    ),
                    const Expanded(
                        child: SizedBox()), // Empty space for balance
                  ],
                ),
              ],
            ),
          );
        } else {
          // For larger screens, use the original row layout
          return StatCards(
            cards: statCardsData,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            spacing: 16,
          );
        }
      },
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color(0xFF4CAF50),
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.0,
                    color: const Color(0xFF4CAF50),
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16.0)),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
          SizedBox(
            height: 600,
            child: TabBarView(
              controller: _tabController,
              children: _buildTabViews(),
            ),
          ),
        ],
      ),
    )
        .animate(delay: 300.ms)
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuart);
  }

  Widget _buildDashboardTab() {
    final expenseState = ref.watch(expenseProvider);
    final expenses = expenseState.expenses;
    final isLoading = expenseState.isLoading || _isLoadingExpenses;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (expenses.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.dashboard_rounded,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'No Expense Data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Add expenses to view dashboard statistics',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _tabController.animateTo(2); // Switch to add expense tab
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ModernSaasDesign.primary,
                  foregroundColor: ModernSaasDesign.textOnPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusMd),
                  ),
                ),
                child: const Text('Add Expense'),
              ),
            ],
          ),
        ),
      );
    }

    /// Calculate summary data for the expense dashboard
    final totalExpenses = expenses.length;
    final totalAmount = expenses.totalAmount;
    final approvedAmount = expenses.totalAmountByStatus('approved');
    final pendingAmount = expenses.totalAmountByStatus('pending');

    // Get recent expenses (last 5)
    final recentExpenses = List<ExpenseModel>.from(expenses)
      ..sort((a, b) => b.date.compareTo(a.date));
    final latestExpenses = recentExpenses.take(5).toList();

    // Format currency
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: RefreshIndicator(
          onRefresh: _fetchExpenses,
          child: ListView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom +
                  kBottomNavigationBarHeight +
                  16,
            ),
            children: [
              // Summary cards
              Row(
                children: [
                  Expanded(
                    child: _buildDashboardCard(
                      'Total Expenses',
                      currencyFormat.format(totalAmount),
                      Icons.account_balance_wallet,
                      Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildDashboardCard(
                      'Approved',
                      currencyFormat.format(approvedAmount),
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: _buildDashboardCard(
                      'Pending',
                      currencyFormat.format(pendingAmount),
                      Icons.pending,
                      Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Recent expenses
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Expenses',
                    style: ModernSaasDesign.headlineSmall.copyWith(
                      color: ModernSaasDesign.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ModernButton(
                      text: 'View All',
                      icon: Icons.list,
                      onPressed: () {
                        _tabController
                            .animateTo(1); // Switch to expense list tab
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...latestExpenses
                  .map((expense) => _buildRecentExpenseItem(expense))
                  .toList(),

              const SizedBox(height: 24),
              // Quick actions
              ModernCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: ModernSaasDesign.headlineSmall.copyWith(
                        color: ModernSaasDesign.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildModernActionButton(
                      'Add Expense',
                      'Create a new expense entry',
                      Icons.add_circle_outline,
                      ModernSaasDesign.success,
                      () {
                        _tabController.animateTo(2);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildModernActionButton(
                      'Approvals',
                      'Review pending expenses',
                      Icons.approval_outlined,
                      ModernSaasDesign.warning,
                      () {
                        _tabController.animateTo(3);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildModernActionButton(
                      'Reports',
                      'View expense analytics',
                      Icons.bar_chart_outlined,
                      ModernSaasDesign.info,
                      () {
                        _tabController.animateTo(5);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildDashboardCard(
      String title, String value, IconData icon, Color color) {
    return ModernCard(
      padding: const EdgeInsets.all(ModernSaasDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernSaasDesign.space2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusMd),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: ModernSaasDesign.space3),
              Expanded(
                child: Text(
                  title,
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space3),
          Text(
            value,
            style: ModernSaasDesign.headlineMedium.copyWith(
              color: ModernSaasDesign.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentExpenseItem(ExpenseModel expense) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMM dd, yyyy');

    return ModernCard(
      margin: const EdgeInsets.only(bottom: ModernSaasDesign.space3),
      padding: const EdgeInsets.all(ModernSaasDesign.space4),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseDetailView(
              expense: expense,
              adminEmail: widget.adminEmail,
              organizationId: widget.organizationId!,
              organizationName: widget.organizationName,
            ),
          ),
        ).then((value) {
          if (value == true) {
            _fetchExpenses();
          }
        });
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: ModernSaasDesign.bodyLarge.copyWith(
                    color: ModernSaasDesign.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: ModernSaasDesign.space1),
                Text(
                  '${expense.category} • ${dateFormat.format(expense.date)}',
                  style: ModernSaasDesign.bodySmall.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: ModernSaasDesign.space3),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currencyFormat.format(expense.amount ?? 0.0),
                style: ModernSaasDesign.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ModernSaasDesign.success,
                ),
              ),
              const SizedBox(height: ModernSaasDesign.space2),
              _buildStatusBadge(expense.status),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ModernButton(
        text: label,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildModernActionButton(String title, String subtitle, IconData icon,
      Color color, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusMd),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: ModernSaasDesign.labelLarge.copyWith(
                          color: ModernSaasDesign.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: ModernSaasDesign.bodySmall.copyWith(
                          color: ModernSaasDesign.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ModernSaasDesign.textSecondary,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseListTab() {
    final expenseState = ref.watch(expenseProvider);
    final expenses = expenseState.expenses;
    final isLoading = expenseState.isLoading || _isLoadingExpenses;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (expenses.isEmpty) {
      return ModernCard(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      ModernSaasDesign.primary,
                      ModernSaasDesign.secondary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ModernSaasDesign.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.list_alt_rounded,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No Expenses Found',
                style: ModernSaasDesign.headlineMedium.copyWith(
                  color: ModernSaasDesign.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Add your first expense to get started',
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ModernButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExpenseView(
                        adminEmail: widget.adminEmail,
                        organizationId: widget.organizationId!,
                        organizationName: widget.organizationName,
                      ),
                    ),
                  ).then((value) {
                    if (value == true) {
                      _fetchExpenses();
                    }
                  });
                },
                text: 'Add New Expense',
                icon: Icons.add,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Expenses',
                style: ModernSaasDesign.headlineSmall.copyWith(
                  color: ModernSaasDesign.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ModernButton(
                text: 'Add New',
                icon: Icons.add,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExpenseView(
                        adminEmail: widget.adminEmail,
                        organizationId: widget.organizationId!,
                        organizationName: widget.organizationName,
                      ),
                    ),
                  ).then((value) {
                    if (value == true) {
                      _fetchExpenses();
                    }
                  });
                },
              ),
            ],
          ),
          //const SizedBox(height: 16),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchExpenses,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return _buildExpenseCard(expense);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCard(ExpenseModel expense) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMM dd, yyyy');

    return ModernCard(
      margin: const EdgeInsets.only(bottom: ModernSaasDesign.space4),
      padding: const EdgeInsets.all(ModernSaasDesign.space4),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseDetailView(
              expense: expense,
              adminEmail: widget.adminEmail,
              organizationId: widget.organizationId!,
              organizationName: widget.organizationName,
            ),
          ),
        ).then((value) {
          if (value == true) {
            _fetchExpenses();
          }
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  expense.title,
                  style: ModernSaasDesign.bodyLarge.copyWith(
                    color: ModernSaasDesign.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                currencyFormat.format(expense.amount ?? 0.0),
                style: ModernSaasDesign.headlineSmall.copyWith(
                  color: ModernSaasDesign.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space2),
          Row(
            children: [
              Icon(
                Icons.category,
                size: 14,
                color: ModernSaasDesign.textSecondary,
              ),
              const SizedBox(width: ModernSaasDesign.space1),
              Text(
                expense.category,
                style: ModernSaasDesign.bodySmall.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
              const SizedBox(width: ModernSaasDesign.space4),
              Icon(
                Icons.calendar_today,
                size: 14,
                color: ModernSaasDesign.textSecondary,
              ),
              const SizedBox(width: ModernSaasDesign.space1),
              Text(
                dateFormat.format(expense.date),
                style: ModernSaasDesign.bodySmall.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space2,
                  vertical: ModernSaasDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(expense.status),
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusSm),
                ),
                child: Text(
                  expense.status,
                  style: ModernSaasDesign.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (expense.isRecurring)
                Row(
                  children: [
                    Icon(
                      Icons.repeat,
                      size: 14,
                      color: ModernSaasDesign.textSecondary,
                    ),
                    const SizedBox(width: ModernSaasDesign.space1),
                    Text(
                      'Recurring',
                      style: ModernSaasDesign.bodySmall.copyWith(
                        color: ModernSaasDesign.textSecondary,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddExpenseTab() {
    final List<String> quickCategories = const [
      'Travel',
      'Meals',
      'Office',
      'Software',
      'Hardware',
      'Marketing',
    ];

    void _openAddExpense({String? initialCategory}) {
      if (widget.organizationId == null) {
        _showSnackBar('Organization ID is required', isError: true);
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddExpenseView(
            adminEmail: widget.adminEmail,
            organizationId: widget.organizationId!,
            organizationName: widget.organizationName,
            initialCategory: initialCategory,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _fetchExpenses();
          _tabController.animateTo(1); // Switch to expense list tab
          _showSnackBar('Expense added successfully');
        }
      });
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(ModernSaasDesign.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header card
          ModernCard(
            padding: const EdgeInsets.all(ModernSaasDesign.space6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ModernSaasDesign.primary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_circle_outline_rounded,
                    size: 64,
                    color: ModernSaasDesign.primary,
                  ),
                ),
                const SizedBox(height: ModernSaasDesign.space4),
                Text(
                  'Add Expense',
                  style: ModernSaasDesign.headlineMedium.copyWith(
                    color: ModernSaasDesign.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: ModernSaasDesign.space2),
                Text(
                  'Create a new expense entry with details, receipts, and optional recurring settings.',
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: ModernSaasDesign.space5),

          // Quick category shortcuts
          Padding(
            padding: EdgeInsets.only(bottom: ModernSaasDesign.space3),
            child: Text(
              'Quick Categories',
              style: ModernSaasDesign.headlineSmall.copyWith(
                color: ModernSaasDesign.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: quickCategories
                .map(
                  (cat) => ActionChip(
                    backgroundColor: ModernSaasDesign.surface,
                    side: const BorderSide(color: ModernSaasDesign.border),
                    label: Text(cat,
                        style: ModernSaasDesign.bodyMedium
                            .copyWith(color: ModernSaasDesign.textPrimary)),
                    avatar: const Icon(Icons.local_offer,
                        size: 18, color: ModernSaasDesign.textSecondary),
                    onPressed: () => _openAddExpense(initialCategory: cat),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: ModernSaasDesign.space6),

          // Actions
          Row(
            children: [
              Expanded(
                child: ModernButton(
                  text: 'Scan Receipt',
                  icon: Icons.photo_camera_outlined,
                  onPressed: () => _openAddExpense(),
                ),
              ),
              const SizedBox(width: ModernSaasDesign.space4),
              Expanded(
                child: ModernButton(
                  text: 'Add New Expense',
                  icon: Icons.add_circle_outline,
                  onPressed: () => _openAddExpense(),
                ),
              ),
            ],
          ),

          const SizedBox(height: ModernSaasDesign.space5),

          // Helpful tip
          ModernCard(
            padding: const EdgeInsets.all(ModernSaasDesign.space4),
            backgroundColor: ModernSaasDesign.primary.withValues(alpha: 0.04),
            border: Border.all(
              color: ModernSaasDesign.primary.withValues(alpha: 0.12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: ModernSaasDesign.primary),
                const SizedBox(width: ModernSaasDesign.space3),
                Expanded(
                  child: Text(
                    'Pro tip: Attaching a receipt speeds up approvals and reduces back-and-forth.',
                    style: ModernSaasDesign.bodyMedium.copyWith(
                      color: ModernSaasDesign.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalsTab() {
    final expenseState = ref.watch(expenseProvider);
    final expenses = expenseState.expenses;
    // Use the extension method to filter pending expenses
    final pendingExpenses = expenses.filterByStatus('pending');
    final isLoading = expenseState.isLoading || _isLoadingExpenses;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (pendingExpenses.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.approval_rounded,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'No Pending Approvals',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'All expenses have been reviewed',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _fetchExpenses();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pending Approvals',
            style: ModernSaasDesign.headlineMedium,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchExpenses,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: pendingExpenses.length,
                itemBuilder: (context, index) {
                  final expense = pendingExpenses[index];
                  return _buildApprovalCard(expense);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalCard(ExpenseModel expense) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMM dd, yyyy');

    return ModernCard(
      margin: EdgeInsets.only(bottom: ModernSaasDesign.space4),
      padding: EdgeInsets.only(
        top: ModernSaasDesign.space2,
        left: ModernSaasDesign.space4,
        right: ModernSaasDesign.space4,
        bottom: ModernSaasDesign.space4,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpenseDetailView(
              expense: expense,
              adminEmail: widget.adminEmail,
              organizationId: widget.organizationId!,
              organizationName: widget.organizationName,
            ),
          ),
        ).then((value) {
          if (value == true) {
            _fetchExpenses();
          }
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with status badge and amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space3,
                  vertical: ModernSaasDesign.space2,
                ),
                decoration: BoxDecoration(
                  color: ModernSaasDesign.warning,
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: ModernSaasDesign.space1),
                    Text(
                      'PENDING APPROVAL',
                      style: ModernSaasDesign.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                currencyFormat.format(expense.amount ?? 0.0),
                style: ModernSaasDesign.headlineMedium.copyWith(
                  color: ModernSaasDesign.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: ModernSaasDesign.space4),

          // Title
          Text(
            expense.title,
            style: ModernSaasDesign.headlineSmall.copyWith(
              color: ModernSaasDesign.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: ModernSaasDesign.space3),

          // Category and Date chips
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space3,
                  vertical: ModernSaasDesign.space2,
                ),
                decoration: BoxDecoration(
                  color: ModernSaasDesign.primary.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusFull),
                  border: Border.all(
                    color: ModernSaasDesign.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.category_outlined,
                      size: 14,
                      color: ModernSaasDesign.primary,
                    ),
                    SizedBox(width: ModernSaasDesign.space1),
                    Text(
                      expense.category,
                      style: ModernSaasDesign.labelMedium.copyWith(
                        color: ModernSaasDesign.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: ModernSaasDesign.space2),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space3,
                  vertical: ModernSaasDesign.space2,
                ),
                decoration: BoxDecoration(
                  color: ModernSaasDesign.neutral200,
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: ModernSaasDesign.neutral600,
                    ),
                    SizedBox(width: ModernSaasDesign.space1),
                    Text(
                      dateFormat.format(expense.date),
                      style: ModernSaasDesign.labelMedium.copyWith(
                        color: ModernSaasDesign.neutral600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Description (if exists)
          if (expense.description != null &&
              expense.description!.isNotEmpty) ...[
            SizedBox(height: ModernSaasDesign.space3),
            Container(
              padding: EdgeInsets.all(ModernSaasDesign.space3),
              decoration: BoxDecoration(
                color: ModernSaasDesign.neutral100,
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
              ),
              child: Text(
                expense.description!,
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: ModernSaasDesign.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],

          SizedBox(height: ModernSaasDesign.space4),

          // Submission info and date
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 16,
                color: ModernSaasDesign.neutral500,
              ),
              SizedBox(width: ModernSaasDesign.space2),
              Expanded(
                child: Text(
                  'Submitted by ${expense.submittedBy}',
                  style: ModernSaasDesign.bodySmall.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.access_time_outlined,
                size: 16,
                color: ModernSaasDesign.neutral500,
              ),
              SizedBox(width: ModernSaasDesign.space1),
              Text(
                dateFormat.format(expense.createdAt),
                style: ModernSaasDesign.bodySmall.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
            ],
          ),

          SizedBox(height: ModernSaasDesign.space4),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ModernButton(
                  text: 'Approve',
                  icon: Icons.check_circle_outline,
                  onPressed: () async {
                    try {
                      await ref
                          .read(expenseProvider.notifier)
                          .approveExpense(expense.id, widget.adminEmail);
                      _showSnackBar('Expense approved successfully');
                      _fetchExpenses();
                    } catch (e) {
                      _showSnackBar(
                          'Failed to approve expense: ${e.toString()}',
                          isError: true);
                    }
                  },
                ),
              ),
              SizedBox(width: ModernSaasDesign.space2),
              Expanded(
                child: ModernButton(
                  text: 'Reject',
                  icon: Icons.cancel_outlined,
                  onPressed: () async {
                    try {
                      await ref
                          .read(expenseProvider.notifier)
                          .rejectExpense(expense.id, widget.adminEmail);
                      _showSnackBar('Expense rejected successfully');
                      _fetchExpenses();
                    } catch (e) {
                      _showSnackBar('Failed to reject expense: ${e.toString()}',
                          isError: true);
                    }
                  },
                ),
              ),
              SizedBox(width: ModernSaasDesign.space2),
              Container(
                decoration: BoxDecoration(
                  color: ModernSaasDesign.surface,
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusLg),
                  border: Border.all(color: ModernSaasDesign.border),
                  boxShadow: ModernSaasDesign.shadowSm,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpenseDetailView(
                          expense: expense,
                          adminEmail: widget.adminEmail,
                          organizationId: widget.organizationId!,
                          organizationName: widget.organizationName,
                        ),
                      ),
                    ).then((value) {
                      if (value == true) {
                        _fetchExpenses();
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.visibility_rounded,
                    size: 18,
                    color: ModernSaasDesign.textSecondary,
                  ),
                  tooltip: 'View',
                  padding: const EdgeInsets.all(ModernSaasDesign.space2),
                  constraints:
                      const BoxConstraints.tightFor(width: 36, height: 36),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringTab() {
    final expenseState = ref.watch(expenseProvider);
    final expenses = expenseState.expenses;
    final recurringExpenses = expenses.where((e) => e.isRecurring).toList();
    final isLoading = expenseState.isLoading || _isLoadingExpenses;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (recurringExpenses.isEmpty) {
      return ModernCard(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      ModernSaasDesign.primary,
                      ModernSaasDesign.secondary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ModernSaasDesign.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.repeat_rounded,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No Recurring Expenses',
                style: ModernSaasDesign.headlineMedium.copyWith(
                  color: ModernSaasDesign.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create expenses with recurring option enabled',
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ModernButton(
                onPressed: () {
                  _tabController.animateTo(2); // Switch to add expense tab
                },
                text: 'Add Recurring Expense',
                icon: Icons.add,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModernCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recurring Expenses',
                  style: ModernSaasDesign.headlineMedium.copyWith(
                    color: ModernSaasDesign.textPrimary,
                  ),
                ),
                ModernButton(
                  onPressed: () {
                    _tabController.animateTo(2); // Switch to add expense tab
                  },
                  text: 'Add New',
                  icon: Icons.add,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchExpenses,
              color: ModernSaasDesign.primary,
              backgroundColor: ModernSaasDesign.surface,
              child: ListView.builder(
                itemCount: recurringExpenses.length,
                itemBuilder: (context, index) {
                  final expense = recurringExpenses[index];
                  return _buildRecurringExpenseCard(expense);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringExpenseCard(ExpenseModel expense) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMM dd, yyyy');

    return ModernCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  expense.title,
                  style: ModernSaasDesign.headlineSmall.copyWith(
                    color: ModernSaasDesign.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ModernSaasDesign.primary,
                      ModernSaasDesign.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: ModernSaasDesign.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.repeat,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Monthly',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ModernSaasDesign.primary.withValues(alpha: 0.1),
                  ModernSaasDesign.secondary.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ModernSaasDesign.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currencyFormat.format(expense.amount ?? 0.0),
                  style: ModernSaasDesign.headlineMedium.copyWith(
                    color: ModernSaasDesign.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusBadge(expense.status),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ModernSaasDesign.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.category,
                  size: 16,
                  color: ModernSaasDesign.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                expense.category,
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ModernSaasDesign.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: ModernSaasDesign.secondary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Next: ${dateFormat.format(expense.date)}',
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ModernButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpenseDetailView(
                        expense: expense,
                        adminEmail: widget.adminEmail,
                        organizationId: widget.organizationId!,
                        organizationName: widget.organizationName,
                      ),
                    ),
                  ).then((value) {
                    if (value == true) {
                      _fetchExpenses();
                    }
                  });
                },
                text: 'View Details',
                icon: Icons.visibility,
              ),
            ],
          ),
          const SizedBox(width: 12),
          ModernButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExpenseView(
                    expenseToEdit: expense,
                    adminEmail: widget.adminEmail,
                    organizationId: widget.organizationId!,
                    organizationName: widget.organizationName,
                  ),
                ),
              ).then((value) {
                if (value == true) {
                  _fetchExpenses();
                }
              });
            },
            text: 'Edit',
            icon: Icons.edit,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ModernSaasDesign.space2,
        vertical: ModernSaasDesign.space1,
      ),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusSm),
      ),
      child: Text(
        status,
        style: ModernSaasDesign.bodySmall.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildReportsTab() {
    final expenseState = ref.watch(expenseProvider);
    final expenses = expenseState.expenses;
    final isLoading = expenseState.isLoading || _isLoadingExpenses;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (expenses.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ModernCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  size: 64,
                  color: ModernSaasDesign.primary.withValues(alpha: 0.6),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Expense Data',
                  style: ModernSaasDesign.headlineMedium.copyWith(
                    color: ModernSaasDesign.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add expenses to generate reports',
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ModernButton(
                  text: 'Add Expenses',
                  onPressed: () {
                    _tabController.animateTo(0); // Switch to expenses tab
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    /// Calculate summary data for the expense dashboard
    /// This includes counts by status and financial calculations
    final totalExpenses = expenses.length;
    final approvedExpenses = expenses.filterByStatus('approved').length;
    final pendingExpenses = expenses.filterByStatus('pending').length;
    final rejectedExpenses = expenses.filterByStatus('rejected').length;

    // Calculate financial totals using extension methods
    final totalAmount = expenses.totalAmount;
    final approvedAmount = expenses.totalAmountByStatus('approved');

    // Get sorted categories by amount for the expense breakdown chart
    final sortedCategories =
        expenses.sortedCategoriesByAmount(filterStatus: 'approved');

    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final percentFormat = NumberFormat.percentPattern();

    return Container(
      padding: const EdgeInsets.all(16),
      child: RefreshIndicator(
        onRefresh: _fetchExpenses,
        child: ListView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight +
                16,
          ),
          children: [
            // Summary cards - Responsive layout to prevent overflow
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  // For smaller screens, use a 2x3 grid layout
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              'Total Expenses',
                              totalExpenses.toString(),
                              Icons.receipt_long,
                              ModernSaasDesign.info,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Total Amount',
                              currencyFormat.format(totalAmount),
                              Icons.attach_money,
                              ModernSaasDesign.success,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              'Approved',
                              '$approvedExpenses (${totalExpenses > 0 ? percentFormat.format(approvedExpenses / totalExpenses) : '0%'})',
                              Icons.check_circle,
                              ModernSaasDesign.success,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Pending',
                              '$pendingExpenses (${totalExpenses > 0 ? percentFormat.format(pendingExpenses / totalExpenses) : '0%'})',
                              Icons.pending,
                              ModernSaasDesign.warning,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              'Rejected',
                              '$rejectedExpenses (${totalExpenses > 0 ? percentFormat.format(rejectedExpenses / totalExpenses) : '0%'})',
                              Icons.cancel,
                              ModernSaasDesign.error,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Approved Amount',
                              currencyFormat.format(approvedAmount),
                              Icons.monetization_on,
                              ModernSaasDesign.success,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  // For larger screens, use the original layout but with Wrap for safety
                  return Column(
                    children: [
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildSummaryCard(
                              'Total Expenses',
                              totalExpenses.toString(),
                              Icons.receipt_long,
                              ModernSaasDesign.info,
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildSummaryCard(
                              'Total Amount',
                              currencyFormat.format(totalAmount),
                              Icons.attach_money,
                              ModernSaasDesign.success,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildSummaryCard(
                              'Approved',
                              '$approvedExpenses (${totalExpenses > 0 ? percentFormat.format(approvedExpenses / totalExpenses) : '0%'})',
                              Icons.check_circle,
                              ModernSaasDesign.success,
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildSummaryCard(
                              'Pending',
                              '$pendingExpenses (${totalExpenses > 0 ? percentFormat.format(pendingExpenses / totalExpenses) : '0%'})',
                              Icons.pending,
                              ModernSaasDesign.warning,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 140,
                              maxWidth: (constraints.maxWidth - 16) / 2,
                            ),
                            child: _buildSummaryCard(
                              'Rejected',
                              '$rejectedExpenses (${totalExpenses > 0 ? percentFormat.format(rejectedExpenses / totalExpenses) : '0%'})',
                              Icons.cancel,
                              ModernSaasDesign.error,
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 140,
                              maxWidth: (constraints.maxWidth - 16) / 2,
                            ),
                            child: _buildSummaryCard(
                              'Approved Amt',
                              currencyFormat.format(approvedAmount),
                              Icons.monetization_on,
                              ModernSaasDesign.success,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 24),

            // Category breakdown
            Text(
              'Expense Categories',
              style: ModernSaasDesign.headlineMedium.copyWith(
                color: ModernSaasDesign.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            if (sortedCategories.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No approved expenses to show category breakdown',
                    style: ModernSaasDesign.bodyMedium.copyWith(
                      color: ModernSaasDesign.textSecondary,
                    ),
                  ),
                ),
              )
            else
              ...sortedCategories.map((entry) {
                final percentage = entry.value / approvedAmount;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              entry.key,
                              style: ModernSaasDesign.labelLarge.copyWith(
                                color: ModernSaasDesign.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: Text(
                              '${currencyFormat.format(entry.value)} (${percentFormat.format(percentage)})',
                              style: ModernSaasDesign.labelLarge.copyWith(
                                color: ModernSaasDesign.textPrimary,
                              ),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: ModernSaasDesign.neutral200,
                          borderRadius: BorderRadius.circular(
                              ModernSaasDesign.radiusFull),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: percentage.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _getCategoryColor(entry.key),
                              borderRadius: BorderRadius.circular(
                                  ModernSaasDesign.radiusFull),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

            const SizedBox(height: 24),
            ModernButton(
              text: 'Export Report',
              icon: Icons.download,
              onPressed: () {
                _showSnackBar('Expense report export coming soon...');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return ModernCard(
      padding: const EdgeInsets.all(ModernSaasDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernSaasDesign.space2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusLg),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              const SizedBox(width: ModernSaasDesign.space2),
              Expanded(
                child: Text(
                  title,
                  style: ModernSaasDesign.labelMedium.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernSaasDesign.space3),
          Text(
            value,
            style: ModernSaasDesign.headlineSmall.copyWith(
              color: ModernSaasDesign.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  /// Map of expense categories to their display colors
  /// This provides consistent coloring across the expense management UI
  static const Map<String, Color> _categoryColors = {
    'travel': ModernSaasDesign.info,
    'meals': ModernSaasDesign.warning,
    'supplies': ModernSaasDesign.success,
    'equipment': ModernSaasDesign.primary,
    'services': ModernSaasDesign.secondary,
  };

  /// Returns a color for the given expense category
  ///
  /// Uses a predefined color map for known categories and
  /// falls back to a default color for unknown categories
  Color _getCategoryColor(String category) {
    final normalizedCategory = category.toLowerCase();
    return _categoryColors[normalizedCategory] ?? ModernSaasDesign.neutral400;
  }

  /// Refresh all expense data
  Future<void> _refreshExpenseData() async {
    _showSnackBar('Refreshing expense data...');

    if (widget.organizationId != null) {
      await _fetchExpenses();
      _showSnackBar('Expense data refreshed successfully!');
    } else {
      _showSnackBar('No organization selected', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? ModernSaasDesign.error : ModernSaasDesign.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return ModernSaasDesign.success;
      case 'pending':
      case 'pending approval':
        return ModernSaasDesign.warning;
      case 'rejected':
        return ModernSaasDesign.error;
      default:
        return ModernSaasDesign.neutral500;
    }
  }
}
