import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/pricing/providers/pricing_live_data_providers.dart';
import 'package:carenest/app/features/pricing/views/employee_pay_rate_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

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
    with SingleTickerProviderStateMixin {
  static const Color _screenGray = Color(0xFFE3E3E3);
  static const Color _inkBlack = Color(0xFF171717);
  static const Color _accentRed = Color(0xFFE21F26);
  static const Color _panelWhite = Color(0xFFF8F8F8);
  static const Color _accentBlue = Color(0xFF0D62B3);

  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedEmployment = 'all';
  String _selectedStream = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    ref.invalidate(pricingOrgEmployeesProvider(widget.organizationId));
  }

  bool _matchesFilters(
    dynamic employee,
    String query,
  ) {
    final name = employee.name.toLowerCase();
    final email = employee.email.toLowerCase();
    final stream = (employee.stream ?? '').toLowerCase();
    final employmentType = (employee.employmentType ?? '').toLowerCase();

    final queryMatch =
        query.isEmpty || name.contains(query) || email.contains(query);
    final streamMatch =
        _selectedStream == 'all' || stream == _selectedStream.toLowerCase();
    final employmentMatch = _selectedEmployment == 'all' ||
        employmentType == _selectedEmployment.toLowerCase();

    return queryMatch && streamMatch && employmentMatch;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final employeesAsync =
        ref.watch(pricingOrgEmployeesProvider(widget.organizationId));
    final isLoading = employeesAsync.isLoading;
    final employees = employeesAsync.value ?? const [];

    final query = _searchController.text.trim().toLowerCase();
    final filtered = employees.where((e) => _matchesFilters(e, query)).toList();
    final configured = filtered.where((e) => e.payRate > 0).toList();
    final missing = filtered.where((e) => e.payRate <= 0).toList();
    final averageRate = configured.isEmpty
        ? 0.0
        : configured.fold<double>(0.0, (sum, e) => sum + e.payRate) /
            configured.length;

    return Scaffold(
      backgroundColor: _screenGray,
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: BauhausDesign.primary,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(l10n)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchAndFilters(l10n, employees),
                    const SizedBox(height: 20),
                    _buildStatsRow(
                      l10n: l10n,
                      isLoading: isLoading,
                      total: filtered.length,
                      configured: configured.length,
                      missing: missing.length,
                      avgRate: averageRate,
                    ),
                    const SizedBox(height: 20),
                    _buildTabs(l10n),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.56,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildCoverageList(l10n, filtered, isLoading),
                          _buildCoverageList(l10n, missing, isLoading,
                              emptyTitle:
                                  l10n.moduleKeyInsightAllRatesConfigured),
                          _buildStreamSummary(l10n, filtered, isLoading),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      color: _screenGray,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
          child: Container(
            color: _screenGray,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _panelWhite,
                          border: Border.all(color: _inkBlack, width: 2),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: _inkBlack,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.serviceRateManagementTitle,
                        style: BauhausDesign.getTextTheme(context)
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: _inkBlack,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                    InkWell(
                      onTap: _openEmployeePayRates,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _accentBlue,
                          border: Border.all(color: _inkBlack, width: 2),
                        ),
                        child: const Icon(
                          Icons.settings,
                          size: 18,
                          color: BauhausDesign.surfaceWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.serviceRateManagementSubtitle,
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              color: _inkBlack,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _accentRed,
                        border: Border.all(color: _inkBlack, width: 2),
                      ),
                      child: Text(
                        l10n.systemActive.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.6,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: _inkBlack, height: 1, thickness: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters(
      AppLocalizations l10n, List<dynamic> employees) {
    final streams = <String>{'all'};
    final employmentTypes = <String>{'all'};
    for (final employee in employees) {
      final stream = (employee.stream ?? '').trim();
      if (stream.isNotEmpty) streams.add(stream);
      final employment = (employee.employmentType ?? '').trim();
      if (employment.isNotEmpty) employmentTypes.add(employment);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.searchServiceRatesHint,
              hintStyle: BauhausDesign.getTextTheme(context)
                  .bodySmall
                  ?.copyWith(color: BauhausDesign.textMuted),
              prefixIcon: const Icon(Icons.search, color: _inkBlack),
              isDense: true,
              filled: true,
              fillColor: BauhausDesign.surfaceWhite,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: _inkBlack, width: 2),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: _inkBlack, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildSimpleDropdown(
                  label: l10n.streamLabel,
                  value: _selectedStream,
                  options: streams.toList()..sort(),
                  onChanged: (value) => setState(() => _selectedStream = value),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSimpleDropdown(
                  label: l10n.employmentTypeLabel,
                  value: _selectedEmployment,
                  options: employmentTypes.toList()..sort(),
                  onChanged: (value) =>
                      setState(() => _selectedEmployment = value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleDropdown({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: options.contains(value) ? value : options.first,
          isExpanded: true,
          items: options
              .map(
                (option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option == 'all'
                        ? AppLocalizations.of(context)!.allFilter
                        : option,
                    overflow: TextOverflow.ellipsis,
                    style: BauhausDesign.getTextTheme(context)
                        .bodySmall
                        ?.copyWith(
                            color: _inkBlack, fontWeight: FontWeight.w700),
                  ),
                ),
              )
              .toList(),
          onChanged: (selected) {
            if (selected != null) onChanged(selected);
          },
        ),
      ),
    );
  }

  Widget _buildStatsRow({
    required AppLocalizations l10n,
    required bool isLoading,
    required int total,
    required int configured,
    required int missing,
    required double avgRate,
  }) {
    final stats = [
      {
        'title': l10n.totalServicesLabel,
        'value': isLoading ? '--' : total.toString(),
        'icon': Icons.people_alt_outlined,
        'color': BauhausDesign.secondary,
      },
      {
        'title': l10n.activeRatesLabel,
        'value': isLoading ? '--' : configured.toString(),
        'icon': Icons.check_circle_outline,
        'color': BauhausDesign.success,
      },
      {
        'title': l10n.pendingUpdatesLabel,
        'value': isLoading ? '--' : missing.toString(),
        'icon': Icons.warning_amber_outlined,
        'color': BauhausDesign.warning,
      },
      {
        'title': l10n.moduleMetricAvgBaseRate,
        'value': isLoading
            ? '--'
            : (avgRate > 0 ? '\$${avgRate.toStringAsFixed(2)}' : l10n.naLabel),
        'icon': Icons.attach_money_outlined,
        'color': BauhausDesign.info,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 88,
      ),
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _panelWhite,
            border: Border.all(color: _inkBlack, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: stat['color'] as Color,
                  border: Border.all(color: _inkBlack, width: 2),
                ),
                child: Icon(stat['icon'] as IconData,
                    size: 12, color: BauhausDesign.surfaceWhite),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      stat['value'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(
                              color: _inkBlack, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      stat['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(color: BauhausDesign.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabs(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: const BoxDecoration(
          color: _inkBlack,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        labelColor: BauhausDesign.surfaceWhite,
        unselectedLabelColor: _inkBlack,
        labelStyle: BauhausDesign.getTextTheme(context)
            .labelSmall
            ?.copyWith(fontWeight: FontWeight.w900),
        tabs: [
          Tab(text: l10n.moduleMetricConfiguredRates),
          Tab(text: l10n.moduleStatusNeedsAction),
          Tab(text: l10n.moduleBadgeRates),
        ],
      ),
    );
  }

  Widget _buildCoverageList(
    AppLocalizations l10n,
    List<dynamic> employees,
    bool isLoading, {
    String? emptyTitle,
  }) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (employees.isEmpty) {
      return Center(
        child: Text(
          emptyTitle ?? l10n.moduleNoDataYet,
          style: BauhausDesign.getTextTheme(context)
              .bodyMedium
              ?.copyWith(color: BauhausDesign.textMuted),
        ),
      );
    }

    return ListView.builder(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final employee = employees[index];
        final hasRate = employee.payRate > 0;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _panelWhite,
            border: Border.all(color: _inkBlack, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name.isEmpty ? employee.email : employee.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BauhausDesign.getTextTheme(context)
                          .labelLarge
                          ?.copyWith(
                              color: _inkBlack, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      employee.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(color: BauhausDesign.textMuted),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${employee.stream ?? l10n.naLabel} · ${employee.employmentType ?? l10n.naLabel}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                              color: _inkBlack, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hasRate
                        ? '\$${employee.payRate.toStringAsFixed(2)}'
                        : l10n.naLabel,
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(
                          color: hasRate
                              ? BauhausDesign.success
                              : BauhausDesign.warning,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: _openEmployeePayRates,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary,
                        border: Border.all(color: _inkBlack, width: 2),
                      ),
                      child: Text(
                        l10n.configure.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStreamSummary(
    AppLocalizations l10n,
    List<dynamic> employees,
    bool isLoading,
  ) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (employees.isEmpty) {
      return Center(
        child: Text(
          l10n.moduleNoDataYet,
          style: BauhausDesign.getTextTheme(context)
              .bodyMedium
              ?.copyWith(color: BauhausDesign.textMuted),
        ),
      );
    }

    final grouped = <String, List<dynamic>>{};
    for (final employee in employees) {
      final key = (employee.stream ?? l10n.naLabel).trim();
      grouped
          .putIfAbsent(key.isEmpty ? l10n.naLabel : key, () => [])
          .add(employee);
    }

    final entries = grouped.entries.toList()
      ..sort((a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()));

    return ListView.builder(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final configured = entry.value.where((e) => e.payRate > 0).toList();
        final avgRate = configured.isEmpty
            ? 0.0
            : configured.fold<double>(0.0, (sum, e) => sum + e.payRate) /
                configured.length;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _panelWhite,
            border: Border.all(color: _inkBlack, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  entry.key,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                '${entry.value.length}',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.info, fontWeight: FontWeight.w900),
              ),
              const SizedBox(width: 8),
              Text(
                avgRate > 0 ? '\$${avgRate.toStringAsFixed(2)}' : l10n.naLabel,
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.success, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openEmployeePayRates() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EmployeePayRateView(
          organizationId: widget.organizationId,
          adminEmail: widget.adminEmail,
        ),
      ),
    );
  }
}
