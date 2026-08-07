import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/pricing/providers/pricing_live_data_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

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
    with SingleTickerProviderStateMixin {
  static const Color _screenGray = Color(0xFFE3E3E3);
  static const Color _inkBlack = Color(0xFF171717);
  static const Color _accentRed = Color(0xFFE21F26);
  static const Color _panelWhite = Color(0xFFF8F8F8);

  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  int _rangeDays = 30;
  String? _selectedClientId;
  String? _selectedSupportItem;

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

  DateTime? _historyDateFromMap(Map<String, dynamic> row) {
    return pricingParseDate(
      row['changedAt'] ?? row['updatedAt'] ?? row['createdAt'] ?? row['date'],
    );
  }

  String _formatDate(DateTime value) {
    return '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final recordsAsync = ref.watch(
      pricingLiveRecordsProvider(widget.organizationId),
    );
    final analyticsAsync = ref.watch(
      pricingOrgAnalyticsProvider(widget.organizationId),
    );
    final clientsAsync = ref.watch(
      pricingOrgClientsProvider(widget.organizationId),
    );

    final records = recordsAsync.value ?? const <PricingLiveRecord>[];
    final clients = clientsAsync.value ?? const <Map<String, dynamic>>[];
    final analytics = analyticsAsync.value;

    final filteredRecords = records.where((record) {
      if (!record.isCustom) return false;
      final search = _searchController.text.trim().toLowerCase();
      if (search.isNotEmpty &&
          !record.supportItemName.toLowerCase().contains(search) &&
          !record.supportItemNumber.toLowerCase().contains(search)) {
        return false;
      }
      final dt = record.effectiveTimestamp;
      if (dt == null) return true;
      return dt.isAfter(DateTime.now().subtract(Duration(days: _rangeDays)));
    }).toList();

    final detailAsync =
        (_selectedClientId != null && _selectedSupportItem != null)
        ? ref.watch(
            pricingDetailedHistoryProvider(
              PriceHistoryQuery(
                supportItemNumber: _selectedSupportItem!,
                clientId: _selectedClientId!,
              ),
            ),
          )
        : const AsyncData<List<Map<String, dynamic>>>([]);

    final detailRows = detailAsync.value ?? const <Map<String, dynamic>>[];

    return Scaffold(
      backgroundColor: _screenGray,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(pricingLiveRecordsProvider(widget.organizationId));
          ref.invalidate(pricingOrgAnalyticsProvider(widget.organizationId));
          ref.invalidate(pricingOrgClientsProvider(widget.organizationId));
          if (_selectedClientId != null && _selectedSupportItem != null) {
            ref.invalidate(
              pricingDetailedHistoryProvider(
                PriceHistoryQuery(
                  supportItemNumber: _selectedSupportItem!,
                  clientId: _selectedClientId!,
                ),
              ),
            );
          }
        },
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
                    _buildStats(l10n, records, analytics),
                    const SizedBox(height: 20),
                    _buildTabs(l10n),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.60,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildRecordTimeline(l10n, filteredRecords),
                          _buildClientHistory(
                            l10n: l10n,
                            clients: clients,
                            records: records,
                            detailRows: detailRows,
                            isLoading: detailAsync.isLoading,
                          ),
                          _buildAnalyticsTab(l10n, records, analytics),
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
                        l10n.priceHistoryTitle,
                        style: BauhausDesign.getTextTheme(context)
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: _inkBlack,
                              letterSpacing: 0.4,
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
                        l10n.trackPricingChanges,
                        style: BauhausDesign.getTextTheme(context).labelLarge
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
                        style: BauhausDesign.getTextTheme(context).labelSmall
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

  Widget _buildStats(
    AppLocalizations l10n,
    List<PricingLiveRecord> records,
    dynamic analytics,
  ) {
    final custom = records.where((record) => record.isCustom).length;
    final updated = records
        .where(
          (record) =>
              record.isCustom &&
              (record.effectiveTimestamp != null) &&
              record.effectiveTimestamp!.isAfter(
                DateTime.now().subtract(const Duration(days: 7)),
              ),
        )
        .length;
    final violations = analytics?.metrics.nonCompliantItems ?? 0;
    final compliance =
        analytics?.metrics.complianceRate ??
        (records.isEmpty ? 0.0 : (custom / records.length) * 100);

    final List<Map<String, Object>> cards = [
      {
        'title': l10n.totalChanges,
        'value': custom.toString(),
        'color': BauhausDesign.secondary,
        'icon': Icons.history_outlined,
      },
      {
        'title': l10n.pendingUpdatesLabel,
        'value': updated.toString(),
        'color': BauhausDesign.success,
        'icon': Icons.update_outlined,
      },
      {
        'title': l10n.moduleMetricActionableItems,
        'value': violations.toString(),
        'color': BauhausDesign.warning,
        'icon': Icons.warning_amber_outlined,
      },
      {
        'title': l10n.moduleMetricCompliance,
        'value': '${compliance.toStringAsFixed(1)}%',
        'color': BauhausDesign.info,
        'icon': Icons.verified_outlined,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 88,
      ),
      itemBuilder: (context, index) {
        final card = cards[index];
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
                  color: card['color'] as Color,
                  border: Border.all(color: _inkBlack, width: 2),
                ),
                child: Icon(
                  card['icon'] as IconData,
                  size: 12,
                  color: BauhausDesign.surfaceWhite,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      card['value'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BauhausDesign.getTextTheme(context).labelLarge
                          ?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      card['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
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
        indicator: const BoxDecoration(color: _inkBlack),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        labelColor: BauhausDesign.surfaceWhite,
        unselectedLabelColor: _inkBlack,
        labelStyle: BauhausDesign.getTextTheme(
          context,
        ).labelSmall?.copyWith(fontWeight: FontWeight.w900),
        tabs: [
          Tab(text: l10n.tabPriceChanges),
          Tab(text: l10n.tabHistory),
          Tab(text: l10n.tabAnalytics),
        ],
      ),
    );
  }

  Widget _buildRecordTimeline(
    AppLocalizations l10n,
    List<PricingLiveRecord> records,
  ) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      children: [
        _buildFilterControls(l10n),
        const SizedBox(height: 2),
        if (records.isEmpty)
          _buildEmpty(l10n.moduleNoTrackedChanges)
        else
          ...records
              .take(80)
              .map(
                (record) => _buildTimelineCard(
                  title:
                      '${record.supportItemNumber} · ${record.supportItemName}',
                  subtitle:
                      '\$${(record.customPrice ?? 0).toStringAsFixed(2)} · cap ${record.priceCap?.toStringAsFixed(2) ?? '-'} · ${record.source}',
                  time: record.effectiveTimestamp,
                  status: record.ndisCompliant == false
                      ? l10n.moduleStatusNeedsAction
                      : l10n.moduleStatusHealthy,
                ),
              ),
      ],
    );
  }

  Widget _buildFilterControls(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.searchHistoryHint,
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
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: _buildRangeButton(l10n.timeRange7Days, 7)),
              const SizedBox(width: 6),
              Expanded(child: _buildRangeButton(l10n.timeRange30Days, 30)),
              const SizedBox(width: 6),
              Expanded(child: _buildRangeButton(l10n.timeRange90Days, 90)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRangeButton(String label, int days) {
    final selected = _rangeDays == days;
    return InkWell(
      onTap: () => setState(() => _rangeDays = days),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _inkBlack : BauhausDesign.surfaceWhite,
          border: Border.all(color: _inkBlack, width: 2),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
            color: selected ? BauhausDesign.surfaceWhite : _inkBlack,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildClientHistory({
    required AppLocalizations l10n,
    required List<Map<String, dynamic>> clients,
    required List<PricingLiveRecord> records,
    required List<Map<String, dynamic>> detailRows,
    required bool isLoading,
  }) {
    final customRecords = records.where((record) => record.isCustom).toList();

    return ListView(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _panelWhite,
            border: Border.all(color: _inkBlack, width: 2),
          ),
          child: Column(
            children: [
              _buildDropdown(
                value: _selectedClientId,
                hint: l10n.selectClientToViewPricing,
                items: clients
                    .map(
                      (client) => DropdownMenuItem<String>(
                        value:
                            (client['id'] ??
                                    client['_id'] ??
                                    client['clientId'])
                                ?.toString(),
                        child: Text(
                          (client['name'] ??
                                  '${client['firstName'] ?? ''} ${client['lastName'] ?? ''}')
                              .toString()
                              .trim(),
                          overflow: TextOverflow.ellipsis,
                          style:
                              (BauhausDesign.getTextTheme(context).labelSmall ??
                                      const TextStyle(fontSize: 12))
                                  .copyWith(
                                    color: BauhausDesign.textDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    )
                    .where(
                      (item) => item.value != null && item.value!.isNotEmpty,
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedClientId = value);
                },
              ),
              const SizedBox(height: 4),
              _buildDropdown(
                value: _selectedSupportItem,
                hint: l10n.searchItems,
                items: customRecords
                    .map(
                      (record) => DropdownMenuItem<String>(
                        value: record.supportItemNumber,
                        child: Text(
                          '${record.supportItemNumber} · ${record.supportItemName}',
                          overflow: TextOverflow.ellipsis,
                          style:
                              (BauhausDesign.getTextTheme(context).labelSmall ??
                                      const TextStyle(fontSize: 12))
                                  .copyWith(
                                    color: BauhausDesign.textDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedSupportItem = value);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        if (_selectedClientId == null || _selectedSupportItem == null)
          _buildEmpty(l10n.selectClientToViewPricing)
        else if (isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          )
        else if (detailRows.isEmpty)
          _buildEmpty(l10n.moduleNoTrackedChanges)
        else
          ...detailRows.map((row) {
            final oldPrice = pricingToDouble(row['oldPrice']);
            final newPrice = pricingToDouble(row['newPrice'] ?? row['price']);
            final reason = (row['reason'] ?? row['changeReason'] ?? '')
                .toString();
            final changedBy = (row['changedBy'] ?? row['userEmail'] ?? '')
                .toString();
            return _buildTimelineCard(
              title: '${row['supportItemNumber'] ?? _selectedSupportItem}',
              subtitle:
                  'old \$${oldPrice.toStringAsFixed(2)} -> new \$${newPrice.toStringAsFixed(2)} ${reason.isNotEmpty ? '· $reason' : ''} ${changedBy.isNotEmpty ? '· $changedBy' : ''}',
              time: _historyDateFromMap(row),
              status:
                  (row['status'] ??
                          row['changeType'] ??
                          l10n.moduleStatusHealthy)
                      .toString(),
            );
          }),
      ],
    );
  }

  Widget _buildAnalyticsTab(
    AppLocalizations l10n,
    List<PricingLiveRecord> records,
    dynamic analytics,
  ) {
    final custom = records.where((record) => record.isCustom).toList();
    final avgCustom = custom.isEmpty
        ? 0.0
        : custom.fold<double>(
                0.0,
                (sum, record) => sum + (record.customPrice ?? 0),
              ) /
              custom.length;
    final avgStandard = records.isEmpty
        ? 0.0
        : records.fold<double>(
                0.0,
                (sum, record) => sum + record.standardPrice,
              ) /
              records.length;

    final compliance =
        analytics?.metrics.complianceRate ??
        (records.isEmpty ? 0.0 : (custom.length / records.length) * 100);
    final violations = analytics?.metrics.nonCompliantItems ?? 0;

    return ListView(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      children: [
        _buildInsightCard(
          title: l10n.moduleMetricAvgBaseRate,
          value: avgCustom > 0
              ? '\$${avgCustom.toStringAsFixed(2)}'
              : l10n.naLabel,
          secondary:
              '${l10n.standardNdisRateLabel}: \$${avgStandard.toStringAsFixed(2)}',
        ),
        _buildInsightCard(
          title: l10n.moduleMetricCompliance,
          value: '${compliance.toStringAsFixed(1)}%',
          secondary: '${l10n.moduleMetricActionableItems}: $violations',
        ),
        _buildInsightCard(
          title: l10n.moduleMetricTrackedEntries,
          value: custom.length.toString(),
          secondary: l10n.moduleKeyInsightCoverage(
            custom.length.toString(),
            records.length.toString(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    final baseStyle =
        BauhausDesign.getTextTheme(context).labelSmall ??
        const TextStyle(fontSize: 12);
    final dropdownTextStyle = baseStyle.copyWith(
      color: BauhausDesign.textDark,
      fontWeight: FontWeight.w700,
    );
    final bool hasItems = items.isNotEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.any((item) => item.value == value) ? value : null,
          hint: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            style: dropdownTextStyle,
          ),
          disabledHint: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            style: dropdownTextStyle,
          ),
          style: dropdownTextStyle,
          dropdownColor: BauhausDesign.surfaceWhite,
          iconEnabledColor: _inkBlack,
          isExpanded: true,
          items: items,
          onChanged: hasItems ? onChanged : null,
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String value,
    required String secondary,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: _inkBlack,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
              color: _inkBlack,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            secondary,
            style: BauhausDesign.getTextTheme(
              context,
            ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard({
    required String title,
    required String subtitle,
    required DateTime? time,
    required String status,
  }) {
    final statusColor = _statusColor(status);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
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
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
                ),
                const SizedBox(height: 2),
                Text(
                  time == null
                      ? AppLocalizations.of(context)!.moduleNoDataYet
                      : _formatDate(time),
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              border: Border.all(color: _inkBlack, width: 1),
            ),
            child: Text(
              status.toUpperCase(),
              style: BauhausDesign.getTextTheme(
                context,
              ).labelSmall?.copyWith(color: BauhausDesign.surfaceWhite),
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    final l10n = AppLocalizations.of(context)!;
    final normalized = status.trim().toLowerCase();
    if (normalized == l10n.moduleStatusHealthy.toLowerCase() ||
        normalized.contains('healthy')) {
      return BauhausDesign.success;
    }
    if (normalized == l10n.moduleStatusNeedsAction.toLowerCase() ||
        normalized.contains('unhealthy') ||
        normalized.contains('needs')) {
      return BauhausDesign.warning;
    }
    return BauhausDesign.neutral;
  }

  Widget _buildEmpty(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: BauhausDesign.getTextTheme(
          context,
        ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
      ),
    );
  }
}
