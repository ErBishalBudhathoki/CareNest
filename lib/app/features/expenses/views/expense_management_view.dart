import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/shared/widgets/stat_cards.dart';
import 'package:carenest/app/features/expenses/views/modern_widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import 'package:carenest/app/features/expenses/providers/expense_provider.dart';
import 'package:carenest/app/features/expenses/views/add_expense_view.dart';
import 'package:carenest/app/features/expenses/views/expense_detail_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:intl/intl.dart';

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
              left: 24.0,
              right: 24.0,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF171717).withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: const Color(0xFF667EEA)),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          'Welcome! Use the tabs to manage expenses, approvals, and reports. Tap any stat card for details.',
                          style: const TextStyle(fontSize: 14),
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
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Expense Management',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
              .copyWith(
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF667EEA),
                const Color(0xFF667EEA),
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
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: () {
            _refreshExpenseData();
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
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
        showBorder: true,
        valueColor: const Color(0xFF1E293B),
        titleColor: Colors.grey[600],
      ),
      StatCardData(
        title: 'Pending Approval',
        value: pendingCount.toString(),
        icon: Icons.pending_actions_rounded,
        color: const Color(0xFFF59E0B),
        showBorder: true,
        valueColor: const Color(0xFF1E293B),
        titleColor: Colors.grey[600],
      ),
      StatCardData(
        title: 'This Month',
        value: currencyFormat.format(thisMonthAmount),
        icon: Icons.date_range_rounded,
        color: const Color(0xFF3B82F6),
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
            color: Colors.black.withValues(alpha: 0.1),
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
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
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
                    style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)
                        .copyWith(
                      color: const Color(0xFF1F2937),
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
                  .map((expense) => _buildRecentExpenseItem(expense)),

              const SizedBox(height: 24),
              // Quick actions
              ModernCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)
                          .copyWith(
                        color: const Color(0xFF1F2937),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildModernActionButton(
                      'Add Expense',
                      'Create a new expense entry',
                      Icons.add_circle_outline,
                      Colors.green,
                      () {
                        _tabController.animateTo(2);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildModernActionButton(
                      'Approvals',
                      'Review pending expenses',
                      Icons.approval_outlined,
                      Colors.orange,
                      () {
                        _tabController.animateTo(3);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildModernActionButton(
                      'Reports',
                      'View expense analytics',
                      Icons.bar_chart_outlined,
                      Colors.blue,
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14).copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                .copyWith(
              color: const Color(0xFF1F2937),
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
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
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
                  style: const TextStyle(fontSize: 16).copyWith(
                    color: const Color(0xFF1F2937),
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${expense.category} • ${dateFormat.format(expense.date)}',
                  style: const TextStyle(fontSize: 12).copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currencyFormat.format(expense.amount ?? 0.0),
                style: const TextStyle(fontSize: 16).copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8.0),
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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: color.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
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
                        style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)
                            .copyWith(
                          color: const Color(0xFF1F2937),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(fontSize: 12).copyWith(
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF6B7280),
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
                      const Color(0xFF667EEA),
                      const Color(0xFF764BA2),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withValues(alpha: 0.1),
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                        .copyWith(
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Add your first expense to get started',
                style: const TextStyle(fontSize: 14).copyWith(
                  color: const Color(0xFF6B7280),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                        .copyWith(
                  color: const Color(0xFF1F2937),
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
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
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
                  style: const TextStyle(fontSize: 16).copyWith(
                    color: const Color(0xFF1F2937),
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                currencyFormat.format(expense.amount ?? 0.0),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                        .copyWith(
                  color: const Color(0xFF667EEA),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Icon(
                Icons.category,
                size: 14,
                color: const Color(0xFF6B7280),
              ),
              const SizedBox(width: 4.0),
              Text(
                expense.category,
                style: const TextStyle(fontSize: 12).copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(width: 16.0),
              Icon(
                Icons.calendar_today,
                size: 14,
                color: const Color(0xFF6B7280),
              ),
              const SizedBox(width: 4.0),
              Text(
                dateFormat.format(expense.date),
                style: const TextStyle(fontSize: 12).copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(expense.status),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  expense.status,
                  style: const TextStyle(fontSize: 12).copyWith(
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
                      color: const Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      'Recurring',
                      style: const TextStyle(fontSize: 12).copyWith(
                        color: const Color(0xFF6B7280),
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

    void openAddExpense({String? initialCategory}) {
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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header card
          ModernCard(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF667EEA).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_circle_outline_rounded,
                    size: 64,
                    color: Color(0xFF667EEA),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Add Expense',
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                          .copyWith(
                    color: const Color(0xFF1F2937),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Create a new expense entry with details, receipts, and optional recurring settings.',
                  style: const TextStyle(fontSize: 14).copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20.0),

          // Quick category shortcuts
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              'Quick Categories',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                  .copyWith(
                color: const Color(0xFF1F2937),
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
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    label: Text(cat,
                        style: const TextStyle(fontSize: 14)
                            .copyWith(color: const Color(0xFF1F2937))),
                    avatar: const Icon(Icons.local_offer,
                        size: 18, color: Color(0xFF6B7280)),
                    onPressed: () => openAddExpense(initialCategory: cat),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 24.0),

          // Actions
          Row(
            children: [
              Expanded(
                child: ModernButton(
                  text: 'Scan Receipt',
                  icon: Icons.photo_camera_outlined,
                  onPressed: () => openAddExpense(),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: ModernButton(
                  text: 'Add New Expense',
                  icon: Icons.add_circle_outline,
                  onPressed: () => openAddExpense(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20.0),

          // Helpful tip
          ModernCard(
            padding: const EdgeInsets.all(16.0),
            border: Border.all(
              color: const Color(0xFF667EEA).withValues(alpha: 0.1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF667EEA)),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'Pro tip: Attaching a receipt speeds up approvals and reduces back-and-forth.',
                    style: const TextStyle(fontSize: 14).copyWith(
                      color: const Color(0xFF6B7280),
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
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
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'PENDING APPROVAL',
                      style: const TextStyle(fontSize: 12).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                currencyFormat.format(expense.amount ?? 0.0),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                        .copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.0),

          // Title
          Text(
            expense.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                .copyWith(
              color: const Color(0xFF1F2937),
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 12.0),

          // Category and Date chips
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF667EEA).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(
                    color: const Color(0xFF667EEA).withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.category_outlined,
                      size: 14,
                      color: const Color(0xFF667EEA),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      expense.category,
                      style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500)
                          .copyWith(
                        color: const Color(0xFF667EEA),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(999.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: const Color(0xFF525252),
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      dateFormat.format(expense.date),
                      style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500)
                          .copyWith(
                        color: const Color(0xFF525252),
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
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                expense.description!,
                style: const TextStyle(fontSize: 14).copyWith(
                  color: const Color(0xFF6B7280),
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],

          SizedBox(height: 16.0),

          // Submission info and date
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 16,
                color: const Color(0xFF737373),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Submitted by ${expense.submittedBy}',
                  style: const TextStyle(fontSize: 12).copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.access_time_outlined,
                size: 16,
                color: const Color(0xFF737373),
              ),
              SizedBox(width: 4.0),
              Text(
                dateFormat.format(expense.createdAt),
                style: const TextStyle(fontSize: 12).copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.0),

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
              SizedBox(width: 8.0),
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
              SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ],
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
                    color: Color(0xFF6B7280),
                  ),
                  tooltip: 'View',
                  padding: const EdgeInsets.all(8.0),
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
                      const Color(0xFF667EEA),
                      const Color(0xFF764BA2),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.1),
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                        .copyWith(
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create expenses with recurring option enabled',
                style: const TextStyle(fontSize: 14).copyWith(
                  color: const Color(0xFF6B7280),
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
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                          .copyWith(
                    color: const Color(0xFF1F2937),
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
              color: const Color(0xFF667EEA),
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
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                          .copyWith(
                    color: const Color(0xFF1F2937),
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
                      const Color(0xFF667EEA),
                      const Color(0xFF764BA2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF667EEA).withOpacity(0.1),
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
                  const Color(0xFF667EEA).withOpacity(0.1),
                  const Color(0xFF764BA2).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF667EEA).withOpacity(0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currencyFormat.format(expense.amount ?? 0.0),
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                          .copyWith(
                    color: const Color(0xFF667EEA),
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
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.category,
                  size: 16,
                  color: const Color(0xFF667EEA),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                expense.category,
                style: const TextStyle(fontSize: 14).copyWith(
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF764BA2).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: const Color(0xFF764BA2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Next: ${dateFormat.format(expense.date)}',
                style: const TextStyle(fontSize: 14).copyWith(
                  color: const Color(0xFF6B7280),
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
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        status,
        style: const TextStyle(fontSize: 12).copyWith(
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
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Expense Data',
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                          .copyWith(
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add expenses to generate reports',
                  style: const TextStyle(fontSize: 14).copyWith(
                    color: const Color(0xFF6B7280),
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
                              Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Total Amount',
                              currencyFormat.format(totalAmount),
                              Icons.attach_money,
                              Colors.green,
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
                              Colors.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Pending',
                              '$pendingExpenses (${totalExpenses > 0 ? percentFormat.format(pendingExpenses / totalExpenses) : '0%'})',
                              Icons.pending,
                              Colors.orange,
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
                              Colors.red,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Approved Amount',
                              currencyFormat.format(approvedAmount),
                              Icons.monetization_on,
                              Colors.green,
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
                              Colors.blue,
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildSummaryCard(
                              'Total Amount',
                              currencyFormat.format(totalAmount),
                              Icons.attach_money,
                              Colors.green,
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
                              Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildSummaryCard(
                              'Pending',
                              '$pendingExpenses (${totalExpenses > 0 ? percentFormat.format(pendingExpenses / totalExpenses) : '0%'})',
                              Icons.pending,
                              Colors.orange,
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
                              Colors.red,
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
                              Colors.green,
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                  .copyWith(
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            if (sortedCategories.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No approved expenses to show category breakdown',
                    style: const TextStyle(fontSize: 14).copyWith(
                      color: const Color(0xFF6B7280),
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
                              style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500)
                                  .copyWith(
                                color: const Color(0xFF1F2937),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: Text(
                              '${currencyFormat.format(entry.value)} (${percentFormat.format(percentage)})',
                              style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500)
                                  .copyWith(
                                color: const Color(0xFF1F2937),
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
                          color: const Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(999.0),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: percentage.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _getCategoryColor(entry.key),
                              borderRadius: BorderRadius.circular(999.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
                          .copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                .copyWith(
              color: const Color(0xFF1F2937),
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
    'travel': Colors.blue,
    'meals': Colors.orange,
    'supplies': Colors.green,
    'equipment': Color(0xFF667EEA),
    'services': Color(0xFF764BA2),
  };

  /// Returns a color for the given expense category
  ///
  /// Uses a predefined color map for known categories and
  /// falls back to a default color for unknown categories
  Color _getCategoryColor(String category) {
    final normalizedCategory = category.toLowerCase();
    return _categoryColors[normalizedCategory] ?? const Color(0xFFA3A3A3);
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
        return Colors.green;
      case 'pending':
      case 'pending approval':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return const Color(0xFF737373);
    }
  }
}
