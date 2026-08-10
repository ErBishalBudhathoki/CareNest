import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/features/expenses/models/expense_model.dart';
import 'package:carenest/app/features/expenses/providers/expense_provider.dart';
import 'package:carenest/app/features/expenses/views/add_expense_view.dart';
import 'package:carenest/app/features/expenses/views/expense_detail_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:intl/intl.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/expenses/views/quick_expense_capture_view.dart';

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
  bool _showOnboarding = true;

  final SharedPreferencesUtils _sharedPrefs = SharedPreferencesUtils();
  UserRole? _userRole;
  List<String> _tabs = [];

  final List<String> _allTabs = [
    'Dashboard',
    'Expense List',
    'Add Expense',
    'Approvals',
    'Recurring',
    'Reports',
  ];

  final List<String> _normalUserTabs = [
    'Dashboard',
    'Expense List',
    'Add Expense',
    'Recurring',
    'Reports',
  ];

  AppLocalizations get l10n => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _tabs = _normalUserTabs;
    _tabController = TabController(length: _tabs.length, vsync: this);

    _initializeUserRole();

    _animationController.forward();

    if (widget.organizationId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchExpenses();
      });
    }
  }

  Future<void> _initializeUserRole() async {
    await _sharedPrefs.init();
    _userRole = _sharedPrefs.getRole();
    if (!mounted) return;

    setState(() {
      final newTabs = _userRole == UserRole.admin ? _allTabs : _normalUserTabs;

      if (_tabs.length != newTabs.length ||
          !_tabs.every((tab) => newTabs.contains(tab))) {
        _tabs = newTabs;
        _tabController.dispose();
        _tabController = TabController(length: _tabs.length, vsync: this);
      }
    });
  }

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
    setState(() {
      _isLoadingExpenses = true;
    });

    try {
      await ref
          .read(expenseProvider.notifier)
          .fetchExpenses(widget.organizationId!);

      if (!mounted) return;
      setState(() {
        _isLoadingExpenses = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingExpenses = false;
      });
      if (!mounted) return;
      _showSnackBar(l10n.expensesFailedLoad(e.toString()), isError: true);
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
      backgroundColor: BauhausDesign.backgroundLight,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [_buildStatsCards(), _buildTabSection()],
                ),
              ),
            ],
          ),
          if (_showOnboarding)
            Positioned(
              top: 120,
              left: 24.0,
              right: 24.0,
              child: _squareCard(
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: BauhausDesign.info),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        '${l10n.expensesWelcomeTitle} ${l10n.expensesWelcomeMessage}',
                        style: BauhausDesign.getTextTheme(context).bodyMedium,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: l10n.expensesWelcomeDismiss,
                      onPressed: () => setState(() => _showOnboarding = false),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: BauhausDesign.backgroundLight,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(
          l10n.expensesTitle,
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w800,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            color: BauhausDesign.backgroundLight,
            border: Border(
              bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
            ),
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: _buildSquareIconButton(
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _buildSquareIconButton(
            icon: Icons.refresh,
            onTap: _refreshExpenseData,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          child: _buildSquareIconButton(
            icon: Icons.settings,
            onTap: () => _showSnackBar(l10n.expensesSettingsComingSoon),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    final expenseState = ref.watch(expenseProvider);
    final expenses = expenseState.expenses;
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    final totalAmount = expenses.totalAmount;
    final pendingCount = expenses.filterByStatus('pending').length;
    final thisMonthAmount = expenses
        .where((expense) {
          final now = DateTime.now();
          return expense.date.year == now.year &&
              expense.date.month == now.month;
        })
        .fold<double>(0.0, (sum, expense) => sum + expense.amount);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop/Tablet view
        if (constraints.maxWidth >= 600) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child:
                      _buildTopStatCard(
                            title: l10n.statsTotalExpenses,
                            value: currencyFormat.format(totalAmount),
                            icon: Icons.account_balance_wallet_outlined,
                            color: BauhausDesign.success,
                          )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: 0.2, end: 0),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child:
                      _buildTopStatCard(
                            title: l10n.statsPendingApproval,
                            value: pendingCount.toString(),
                            icon: Icons.pending_actions_outlined,
                            color: BauhausDesign.warning,
                          )
                          .animate(delay: 150.ms)
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: 0.2, end: 0),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child:
                      _buildTopStatCard(
                            title: l10n.statsThisMonth,
                            value: currencyFormat.format(thisMonthAmount),
                            icon: Icons.date_range_outlined,
                            color: BauhausDesign.info,
                          )
                          .animate(delay: 300.ms)
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: 0.2, end: 0),
                ),
              ],
            ),
          );
        }

        // Mobile view
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child:
                        _buildTopStatCard(
                              title: l10n.statsTotalExpenses,
                              value: currencyFormat.format(totalAmount),
                              icon: Icons.account_balance_wallet_outlined,
                              color: BauhausDesign.success,
                            )
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .slideX(begin: 0.2, end: 0),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child:
                        _buildTopStatCard(
                              title: l10n.statsPendingApproval,
                              value: pendingCount.toString(),
                              icon: Icons.pending_actions_outlined,
                              color: BauhausDesign.warning,
                            )
                            .animate(delay: 150.ms)
                            .fadeIn(duration: 400.ms)
                            .slideX(begin: 0.2, end: 0),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child:
                        _buildTopStatCard(
                              title: l10n.statsThisMonth,
                              value: currencyFormat.format(thisMonthAmount),
                              icon: Icons.date_range_outlined,
                              color: BauhausDesign.info,
                            )
                            .animate(delay: 300.ms)
                            .fadeIn(duration: 400.ms)
                            .slideX(begin: 0.2, end: 0),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabSection() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.fromBorderSide(
              BorderSide(color: BauhausDesign.neutral, width: 2),
            ),
            boxShadow: [BauhausDesign.shadowHardSm],
          ),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: BauhausDesign.surfaceOffWhite,
                  border: Border(
                    bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: BauhausDesign.surfaceWhite,
                  unselectedLabelColor: BauhausDesign.textDark,
                  labelStyle: BauhausDesign.getTextTheme(
                    context,
                  ).labelLarge?.copyWith(fontWeight: FontWeight.w900),
                  unselectedLabelStyle: BauhausDesign.getTextTheme(
                    context,
                  ).labelLarge?.copyWith(fontWeight: FontWeight.w700),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: const BoxDecoration(color: BauhausDesign.neutral),
                  indicatorPadding: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  tabs: _tabs.map((tab) {
                    String label = tab;
                    if (tab == 'Dashboard') label = l10n.expensesTabDashboard;
                    if (tab == 'Expense List') label = l10n.expensesTabList;
                    if (tab == 'Add Expense') label = l10n.expensesTabAdd;
                    if (tab == 'Approvals') label = l10n.expensesTabApprovals;
                    if (tab == 'Recurring') label = l10n.expensesTabRecurring;
                    if (tab == 'Reports') label = l10n.expensesTabReports;
                    return Tab(text: label);
                  }).toList(),
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
        child: CircularProgressIndicator(color: BauhausDesign.primary),
      );
    }

    if (expenses.isEmpty) {
      return BauhausEmptyState(
        title: l10n.expensesEmptyDashboardTitle,
        message: l10n.expensesEmptyDashboardMessage,
        icon: Icons.dashboard_rounded,
        action: BauhausActionButton(
          text: l10n.expensesTabAdd,
          onPressed: () {
            _tabController.animateTo(2);
          },
        ),
      );
    }

    final totalAmount = expenses.totalAmount;
    final approvedAmount = expenses.totalAmountByStatus('approved');
    final pendingAmount = expenses.totalAmountByStatus('pending');

    final recentExpenses = List<ExpenseModel>.from(expenses)
      ..sort((a, b) => b.date.compareTo(a.date));
    final latestExpenses = recentExpenses.take(5).toList();

    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: RefreshIndicator(
        onRefresh: _fetchExpenses,
        child: ListView(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight +
                16,
          ),
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDashboardCard(
                    'Total Expenses',
                    currencyFormat.format(totalAmount),
                    Icons.account_balance_wallet,
                    BauhausDesign.info,
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
                    BauhausDesign.success,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: _buildDashboardCard(
                    'Pending',
                    currencyFormat.format(pendingAmount),
                    Icons.pending,
                    BauhausDesign.warning,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.dashboardRecentExpenses,
                  style: BauhausDesign.getTextTheme(context).headlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: BauhausActionButton(
                    text: l10n.dashboardViewAll,
                    icon: Icons.list,
                    variant: BauhausActionVariant.ghost,
                    onPressed: () {
                      _tabController.animateTo(1);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...latestExpenses.map(
              (expense) => _buildRecentExpenseItem(expense),
            ),
            const SizedBox(height: 24),
            _squareCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dashboardQuickActions,
                    style: BauhausDesign.getTextTheme(context).headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  _buildModernActionButton(
                    l10n.expensesTabAdd,
                    l10n.dashboardAddExpenseDesc,
                    Icons.add_circle_outline,
                    BauhausDesign.success,
                    () {
                      _tabController.animateTo(2);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildModernActionButton(
                    l10n.expensesTabApprovals,
                    l10n.dashboardApprovalsDesc,
                    Icons.approval_outlined,
                    BauhausDesign.warning,
                    () {
                      _tabController.animateTo(3);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildModernActionButton(
                    l10n.expensesTabReports,
                    l10n.dashboardReportsDesc,
                    Icons.bar_chart_outlined,
                    BauhausDesign.info,
                    () {
                      _tabController.animateTo(5);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return _squareCard(
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
                  border: Border.all(color: BauhausDesign.neutral, width: 1),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentExpenseItem(ExpenseModel expense) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMM dd, yyyy');

    return _squareCard(
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
                  style: BauhausDesign.getTextTheme(context).labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${expense.category} • ${dateFormat.format(expense.date)}',
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(color: BauhausDesign.textMuted, fontSize: 12),
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
                currencyFormat.format(expense.amount),
                style: BauhausDesign.getTextTheme(
                  context,
                ).labelLarge?.copyWith(color: BauhausDesign.success),
              ),
              const SizedBox(height: 8.0),
              _buildStatusBadge(expense.status),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernActionButton(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: BauhausDesign.getTextTheme(context).labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: BauhausDesign.textMuted,
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
        child: CircularProgressIndicator(color: BauhausDesign.primary),
      );
    }

    if (expenses.isEmpty) {
      return BauhausEmptyState(
        title: l10n.expensesEmptyTitle,
        message: l10n.expensesEmptyMessage,
        icon: Icons.list_alt_rounded,
        action: BauhausActionButton(
          text: l10n.expensesAddButton,
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
                l10n.expensesAllExpenses,
                style: BauhausDesign.getTextTheme(context).headlineMedium,
              ),
              BauhausActionButton(
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchExpenses,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildExpenseCard(expense),
                  );
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

    return _squareCard(
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
                  style: BauhausDesign.getTextTheme(context).labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                currencyFormat.format(expense.amount),
                style: BauhausDesign.getTextTheme(
                  context,
                ).headlineMedium?.copyWith(color: BauhausDesign.primary),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Icon(Icons.category, size: 14, color: BauhausDesign.textMuted),
              const SizedBox(width: 4.0),
              Text(
                expense.category,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16.0),
              Icon(
                Icons.calendar_today,
                size: 14,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(width: 4.0),
              Text(
                dateFormat.format(expense.date),
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusBadge(expense.status),
              if (expense.isRecurring)
                Row(
                  children: [
                    Icon(
                      Icons.repeat,
                      size: 14,
                      color: BauhausDesign.textMuted,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      'Recurring',
                      style: BauhausDesign.getTextTheme(context).bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontSize: 12,
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
          _tabController.animateTo(1);
          _showSnackBar('Expense added successfully');
        }
      });
    }

    void openQuickCapture() {
      if (widget.organizationId == null) {
        _showSnackBar('Organization ID is required', isError: true);
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuickExpenseCaptureView(
            adminEmail: widget.adminEmail,
            organizationId: widget.organizationId!,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _squareCard(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: BauhausDesign.primary.withValues(alpha: 0.1),
                    border: Border.all(color: BauhausDesign.neutral),
                  ),
                  child: Icon(
                    Icons.add_circle_outline_rounded,
                    size: 64,
                    color: BauhausDesign.primary,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Add Expense',
                  style: BauhausDesign.getTextTheme(context).headlineMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Create a new expense entry with details, receipts, and optional recurring settings.',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Quick Categories',
            style: BauhausDesign.getTextTheme(context).headlineMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: quickCategories
                .map(
                  (cat) => _buildQuickCategoryButton(
                    label: cat,
                    onTap: () => openAddExpense(initialCategory: cat),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  text: 'Scan Receipt',
                  icon: Icons.photo_camera_outlined,
                  onPressed: () => openQuickCapture(),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: BauhausActionButton(
                  text: 'Add New',
                  icon: Icons.add_circle_outline,
                  onPressed: () => openAddExpense(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          _squareCard(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: BauhausDesign.info),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'Pro tip: Attaching a receipt speeds up approvals and reduces back-and-forth.',
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
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
    final pendingExpenses = expenses.filterByStatus('pending');
    final isLoading = expenseState.isLoading || _isLoadingExpenses;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: BauhausDesign.primary),
      );
    }

    if (pendingExpenses.isEmpty) {
      return BauhausEmptyState(
        title: 'No Pending Approvals',
        message: 'All expenses have been reviewed',
        icon: Icons.approval_rounded,
        action: BauhausActionButton(text: 'Refresh', onPressed: _fetchExpenses),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pending Approvals',
            style: BauhausDesign.getTextTheme(context).headlineMedium,
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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildApprovalCard(expense),
                  );
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

    return _squareCard(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTag(
                label: 'PENDING APPROVAL',
                icon: Icons.schedule,
                background: BauhausDesign.warning.withValues(alpha: 0.2),
                textColor: BauhausDesign.textDark,
              ),
              Text(
                currencyFormat.format(expense.amount),
                style: BauhausDesign.getTextTheme(
                  context,
                ).headlineMedium?.copyWith(color: BauhausDesign.success),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            expense.title,
            style: BauhausDesign.getTextTheme(context).headlineMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              _buildTag(label: expense.category, icon: Icons.category_outlined),
              const SizedBox(width: 8.0),
              _buildTag(
                label: dateFormat.format(expense.date),
                icon: Icons.calendar_today_outlined,
              ),
            ],
          ),
          if (expense.description != null &&
              expense.description!.isNotEmpty) ...[
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceOffWhite,
                border: Border.all(color: BauhausDesign.neutral),
              ),
              child: Text(
                expense.description!,
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          const SizedBox(height: 16.0),
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 16,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Submitted by ${expense.submittedBy}',
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(color: BauhausDesign.textMuted, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.access_time_outlined,
                size: 16,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(width: 4.0),
              Text(
                dateFormat.format(expense.createdAt),
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  text: 'Approve',
                  icon: Icons.check_circle_outline,
                  variant: BauhausActionVariant.success,
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
                        isError: true,
                      );
                    }
                  },
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: BauhausActionButton(
                  text: 'Reject',
                  icon: Icons.cancel_outlined,
                  variant: BauhausActionVariant.danger,
                  onPressed: () async {
                    try {
                      await ref
                          .read(expenseProvider.notifier)
                          .rejectExpense(expense.id, widget.adminEmail);
                      _showSnackBar('Expense rejected successfully');
                      _fetchExpenses();
                    } catch (e) {
                      _showSnackBar(
                        'Failed to reject expense: ${e.toString()}',
                        isError: true,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceWhite,
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                  boxShadow: const [BauhausDesign.shadowHardSm],
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
                    color: BauhausDesign.textDark,
                  ),
                  tooltip: 'View',
                  padding: const EdgeInsets.all(8.0),
                  constraints: const BoxConstraints.tightFor(
                    width: 44,
                    height: 44,
                  ),
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
        child: CircularProgressIndicator(color: BauhausDesign.primary),
      );
    }

    if (recurringExpenses.isEmpty) {
      return BauhausEmptyState(
        title: 'No Recurring Expenses',
        message: 'Create expenses with recurring option enabled',
        icon: Icons.repeat_rounded,
        action: BauhausActionButton(
          text: 'Add Recurring Expense',
          icon: Icons.add,
          onPressed: () {
            _tabController.animateTo(2);
          },
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _squareCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recurring Expenses',
                  style: BauhausDesign.getTextTheme(context).headlineMedium,
                ),
                BauhausActionButton(
                  onPressed: () {
                    _tabController.animateTo(2);
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
              color: BauhausDesign.primary,
              child: ListView.builder(
                itemCount: recurringExpenses.length,
                itemBuilder: (context, index) {
                  final expense = recurringExpenses[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildRecurringExpenseCard(expense),
                  );
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

    return _squareCard(
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
                  style: BauhausDesign.getTextTheme(context).headlineMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildTag(
                label: 'Monthly',
                icon: Icons.repeat,
                background: BauhausDesign.info.withValues(alpha: 0.15),
                textColor: BauhausDesign.info,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceOffWhite,
              border: Border.all(color: BauhausDesign.neutral),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currencyFormat.format(expense.amount),
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).headlineMedium?.copyWith(color: BauhausDesign.primary),
                ),
                _buildStatusBadge(expense.status),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: BauhausDesign.textMuted),
              const SizedBox(width: 8),
              Text(
                expense.category,
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
              const SizedBox(width: 20),
              Icon(
                Icons.calendar_today,
                size: 16,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(width: 8),
              Text(
                'Next: ${dateFormat.format(expense.date)}',
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BauhausActionButton(
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
                text: 'View',
                icon: Icons.visibility,
                variant: BauhausActionVariant.ghost,
              ),
              const SizedBox(width: 12),
              BauhausActionButton(
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
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color background;
    Color textColor;
    switch (status.toLowerCase()) {
      case 'approved':
        background = BauhausDesign.success.withValues(alpha: 0.2);
        textColor = BauhausDesign.success;
        break;
      case 'pending':
      case 'pending approval':
        background = BauhausDesign.warning.withValues(alpha: 0.2);
        textColor = BauhausDesign.textDark;
        break;
      case 'rejected':
        background = BauhausDesign.error.withValues(alpha: 0.2);
        textColor = BauhausDesign.error;
        break;
      default:
        background = BauhausDesign.surfaceOffWhite;
        textColor = BauhausDesign.textDark;
    }

    return _buildTag(
      label: status.toUpperCase(),
      background: background,
      textColor: textColor,
    );
  }

  Widget _buildReportsTab() {
    final expenseState = ref.watch(expenseProvider);
    final expenses = expenseState.expenses;
    final isLoading = expenseState.isLoading || _isLoadingExpenses;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: BauhausDesign.primary),
      );
    }

    if (expenses.isEmpty) {
      return BauhausEmptyState(
        title: 'No Expense Data',
        message: 'Add expenses to generate reports',
        icon: Icons.bar_chart_rounded,
        action: BauhausActionButton(
          text: 'Add Expenses',
          onPressed: () {
            _tabController.animateTo(0);
          },
        ),
      );
    }

    final totalExpenses = expenses.length;
    final approvedExpenses = expenses.filterByStatus('approved').length;
    final pendingExpenses = expenses.filterByStatus('pending').length;
    final rejectedExpenses = expenses.filterByStatus('rejected').length;

    final totalAmount = expenses.totalAmount;
    final approvedAmount = expenses.totalAmountByStatus('approved');

    final sortedCategories = expenses.sortedCategoriesByAmount(
      filterStatus: 'approved',
    );

    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final percentFormat = NumberFormat.percentPattern();

    return Container(
      padding: const EdgeInsets.all(16),
      child: RefreshIndicator(
        onRefresh: _fetchExpenses,
        child: ListView(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight +
                16,
          ),
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              'Total Expenses',
                              totalExpenses.toString(),
                              Icons.receipt_long,
                              BauhausDesign.info,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Total Amount',
                              currencyFormat.format(totalAmount),
                              Icons.attach_money,
                              BauhausDesign.success,
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
                              BauhausDesign.success,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Pending',
                              '$pendingExpenses (${totalExpenses > 0 ? percentFormat.format(pendingExpenses / totalExpenses) : '0%'})',
                              Icons.pending,
                              BauhausDesign.warning,
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
                              BauhausDesign.error,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSummaryCard(
                              'Approved Amt',
                              currencyFormat.format(approvedAmount),
                              Icons.monetization_on,
                              BauhausDesign.success,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
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
                              BauhausDesign.info,
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildSummaryCard(
                              'Total Amount',
                              currencyFormat.format(totalAmount),
                              Icons.attach_money,
                              BauhausDesign.success,
                            ),
                          ),
                        ],
                      ),
                      // ... (similar Wrap structure for others if needed)
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Expense Categories',
              style: BauhausDesign.getTextTheme(context).headlineMedium,
            ),
            const SizedBox(height: 16),
            if (sortedCategories.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No approved expenses to show category breakdown',
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
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
                              style: BauhausDesign.getTextTheme(
                                context,
                              ).labelLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: Text(
                              '${currencyFormat.format(entry.value)} (${percentFormat.format(percentage)})',
                              style: BauhausDesign.getTextTheme(
                                context,
                              ).labelLarge,
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
                          color: BauhausDesign.surfaceOffWhite,
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1,
                          ),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: percentage.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _getCategoryColor(entry.key),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 24),
            BauhausActionButton(
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
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return _squareCard(
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
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(color: BauhausDesign.textMuted, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _squareCard({
    required Widget child,
    EdgeInsets padding = const EdgeInsets.all(16),
    EdgeInsets? margin,
    VoidCallback? onTap,
    Color backgroundColor = BauhausDesign.surfaceWhite,
  }) {
    final card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: child,
    );

    if (onTap == null) return card;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.zero,
        child: card,
      ),
    );
  }

  Widget _buildSquareIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.zero,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
          ),
          child: Icon(icon, size: 18, color: BauhausDesign.textDark),
        ),
      ),
    );
  }

  Widget _buildTopStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return _squareCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: Icon(icon, size: 14, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textMuted,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag({
    required String label,
    IconData? icon,
    Color background = BauhausDesign.surfaceWhite,
    Color textColor = BauhausDesign.textDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCategoryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.zero,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.local_offer_outlined,
                size: 14,
                color: BauhausDesign.primary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    final normalizedCategory = category.toLowerCase();
    // Simple mapping or hash to Bauhaus colors
    switch (normalizedCategory) {
      case 'travel':
        return BauhausDesign.info;
      case 'meals':
        return BauhausDesign.warning;
      case 'supplies':
        return BauhausDesign.success;
      case 'equipment':
        return BauhausDesign.primary;
      case 'services':
        return BauhausDesign.secondary;
      default:
        return BauhausDesign.neutral;
    }
  }

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
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }
}
