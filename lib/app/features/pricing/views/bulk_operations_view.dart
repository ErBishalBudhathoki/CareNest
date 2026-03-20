import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/pricing/providers/pricing_live_data_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class BulkOperationsView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const BulkOperationsView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  });

  @override
  ConsumerState<BulkOperationsView> createState() => _BulkOperationsViewState();
}

class _BulkOperationsViewState extends ConsumerState<BulkOperationsView>
    with SingleTickerProviderStateMixin {
  static const Color _screenGray = Color(0xFFE3E3E3);
  static const Color _inkBlack = Color(0xFF171717);
  static const Color _accentRed = Color(0xFFE21F26);
  static const Color _panelWhite = Color(0xFFF8F8F8);
  static const Color _accentBlue = Color(0xFF0D62B3);

  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _percentageController =
      TextEditingController(text: '5');
  final TextEditingController _fixedRateController = TextEditingController();

  bool _isProcessing = false;
  String _bulkMode = 'percentage';
  bool _showOnlyCustom = false;
  final Set<String> _selectedItemNumbers = <String>{};
  String _exportCsv = '';
  String _lastImportSummary = '';

  final List<_BulkEvent> _events = <_BulkEvent>[];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _percentageController.dispose();
    _fixedRateController.dispose();
    super.dispose();
  }

  Future<void> _refreshAll() async {
    ref.invalidate(pricingLiveRecordsProvider(widget.organizationId));
    ref.invalidate(pricingOrgAnalyticsProvider(widget.organizationId));
  }

  List<Map<String, String>> _parseCsvRows(String raw) {
    final lines = raw
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    if (lines.length < 2) return const [];

    final headers = lines.first.split(',').map((h) => h.trim()).toList();
    final rows = <Map<String, String>>[];

    for (final line in lines.skip(1)) {
      final values = line.split(',').map((v) => v.trim()).toList();
      if (values.isEmpty) continue;
      final row = <String, String>{};
      for (var i = 0; i < headers.length; i++) {
        final header = headers[i];
        row[header] = i < values.length ? values[i] : '';
      }
      rows.add(row);
    }

    return rows;
  }

  Future<void> _importCsv(List<PricingLiveRecord> records) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['csv'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.first.bytes;
    if (bytes == null || bytes.isEmpty) return;

    final csvText = utf8.decode(bytes, allowMalformed: true);
    final rows = _parseCsvRows(csvText);
    if (rows.isEmpty) {
      _showSnackBar(l10n.errorOccurred, isError: true);
      return;
    }

    final api = ref.read(app_providers.apiMethodProvider);
    final nameByItem = {
      for (final r in records) r.supportItemNumber: r.supportItemName,
    };

    setState(() => _isProcessing = true);
    var success = 0;
    var failed = 0;

    for (final row in rows) {
      final itemNumber =
          (row['supportItemNumber'] ?? row['itemNumber'] ?? '').trim();
      final priceRaw = row['customPrice'] ?? row['price'] ?? '';
      final price = pricingToDouble(priceRaw);

      if (itemNumber.isEmpty || price <= 0) {
        failed++;
        continue;
      }

      try {
        final response = await api.saveAsCustomPricing(
          widget.organizationId,
          itemNumber,
          price,
          'fixed',
          widget.adminEmail,
          supportItemName: nameByItem[itemNumber] ?? itemNumber,
        );
        if (response['success'] == true) {
          success++;
        } else {
          failed++;
        }
      } catch (_) {
        failed++;
      }
    }

    if (!mounted) return;
    setState(() {
      _isProcessing = false;
      _lastImportSummary =
          'Imported ${rows.length} rows: $success success, $failed failed';
      _events.insert(
        0,
        _BulkEvent(
          action: 'CSV Import',
          detail: _lastImportSummary,
          successCount: success,
          failedCount: failed,
          timestamp: DateTime.now(),
        ),
      );
    });

    await _refreshAll();
    _showSnackBar(
        success > 0 ? l10n.importCompletedMsg('CSV') : l10n.errorOccurred,
        isError: success == 0);
  }

  String _buildExportCsv(List<PricingLiveRecord> records) {
    final customRecords = records.where((record) => record.isCustom).toList();
    final buffer = StringBuffer();
    buffer.writeln(
      'supportItemNumber,supportItemName,customPrice,standardPrice,priceCap,source,updatedAt',
    );

    for (final record in customRecords) {
      buffer.writeln(
        '${record.supportItemNumber},'
        '${record.supportItemName.replaceAll(',', ' ')},'
        '${record.customPrice?.toStringAsFixed(2) ?? ''},'
        '${record.standardPrice.toStringAsFixed(2)},'
        '${record.priceCap?.toStringAsFixed(2) ?? ''},'
        '${record.source},'
        '${record.effectiveTimestamp?.toIso8601String() ?? ''}',
      );
    }

    return buffer.toString();
  }

  Future<void> _generateExport(List<PricingLiveRecord> records) async {
    final csv = _buildExportCsv(records);
    setState(() {
      _exportCsv = csv;
      _events.insert(
        0,
        _BulkEvent(
          action: 'CSV Export',
          detail:
              'Exported ${records.where((r) => r.isCustom).length} custom records',
          successCount: records.where((r) => r.isCustom).length,
          failedCount: 0,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  Future<void> _copyExportCsv() async {
    final l10n = AppLocalizations.of(context)!;
    if (_exportCsv.trim().isEmpty) {
      _showSnackBar(l10n.exportComingSoon, isError: true);
      return;
    }

    await Clipboard.setData(ClipboardData(text: _exportCsv));
    _showSnackBar(l10n.exportDataQuickDesc);
  }

  Future<void> _applyBulkUpdate(List<PricingLiveRecord> records) async {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedItemNumbers.isEmpty) {
      _showSnackBar(l10n.tipBulkActions, isError: true);
      return;
    }

    final api = ref.read(app_providers.apiMethodProvider);
    final selected = records
        .where(
            (record) => _selectedItemNumbers.contains(record.supportItemNumber))
        .toList();

    final percentage = pricingToDouble(_percentageController.text);
    final fixedRate = pricingToDouble(_fixedRateController.text);

    setState(() => _isProcessing = true);
    var success = 0;
    var failed = 0;

    for (final record in selected) {
      final base = record.customPrice ?? record.standardPrice;
      final updatedPrice =
          _bulkMode == 'fixed' ? fixedRate : (base * (1 + (percentage / 100)));

      if (updatedPrice <= 0) {
        failed++;
        continue;
      }

      try {
        final response = await api.saveAsCustomPricing(
          widget.organizationId,
          record.supportItemNumber,
          updatedPrice,
          'fixed',
          widget.adminEmail,
          supportItemName: record.supportItemName,
        );

        if (response['success'] == true) {
          success++;
        } else {
          failed++;
        }
      } catch (_) {
        failed++;
      }
    }

    if (!mounted) return;
    setState(() {
      _isProcessing = false;
      _selectedItemNumbers.clear();
      _events.insert(
        0,
        _BulkEvent(
          action: 'Bulk Update',
          detail:
              'Processed ${selected.length} items (${_bulkMode == 'fixed' ? 'fixed' : 'percentage'})',
          successCount: success,
          failedCount: failed,
          timestamp: DateTime.now(),
        ),
      );
    });

    await _refreshAll();
    _showSnackBar(
      success > 0
          ? l10n.importCompletedMsg('Bulk update')
          : l10n.importFailedMsg('No updates applied'),
      isError: success == 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final recordsAsync =
        ref.watch(pricingLiveRecordsProvider(widget.organizationId));
    final analyticsAsync =
        ref.watch(pricingOrgAnalyticsProvider(widget.organizationId));

    final records = recordsAsync.valueOrNull ?? const <PricingLiveRecord>[];
    final analytics = analyticsAsync.valueOrNull;
    final isLoading = recordsAsync.isLoading || analyticsAsync.isLoading;

    final customCount = records.where((record) => record.isCustom).length;
    final pendingCount = records.where((record) => !record.isCustom).length;
    final violations = analytics?.metrics.nonCompliantItems ?? 0;
    final compliance = analytics?.metrics.complianceRate ??
        (records.isEmpty ? 0.0 : (customCount / records.length) * 100);

    final search = _searchController.text.trim().toLowerCase();
    final filtered = records.where((record) {
      if (_showOnlyCustom && !record.isCustom) return false;
      if (search.isEmpty) return true;
      return record.supportItemNumber.toLowerCase().contains(search) ||
          record.supportItemName.toLowerCase().contains(search);
    }).toList();

    return Scaffold(
      backgroundColor: _screenGray,
      body: RefreshIndicator(
        onRefresh: _refreshAll,
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
                    _buildStats(
                      l10n: l10n,
                      isLoading: isLoading,
                      total: records.length,
                      custom: customCount,
                      pending: pendingCount,
                      compliance: compliance,
                      violations: violations,
                    ),
                    const SizedBox(height: 20),
                    _buildTabs(l10n),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.60,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildImportTab(l10n, records),
                          _buildExportTab(l10n, records),
                          _buildBulkTab(l10n, filtered, records),
                          _buildHistoryTab(l10n, records),
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
                        l10n.bulkOperationsTitle,
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
                      onTap: _refreshAll,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: _accentBlue,
                          border: Border.all(color: _inkBlack, width: 2),
                        ),
                        child: const Icon(
                          Icons.refresh,
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
                        l10n.bulkOperationsDesc,
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

  Widget _buildStats({
    required AppLocalizations l10n,
    required bool isLoading,
    required int total,
    required int custom,
    required int pending,
    required double compliance,
    required int violations,
  }) {
    final List<Map<String, Object>> stats = [
      {
        'title': l10n.totalOperations,
        'value': isLoading ? '--' : total.toString(),
        'color': BauhausDesign.secondary,
        'icon': Icons.inventory_2_outlined,
      },
      {
        'title': l10n.activeRatesLabel,
        'value': isLoading ? '--' : custom.toString(),
        'color': BauhausDesign.success,
        'icon': Icons.check_circle_outline,
      },
      {
        'title': l10n.pendingUpdatesLabel,
        'value': isLoading ? '--' : pending.toString(),
        'color': BauhausDesign.warning,
        'icon': Icons.pending_actions_outlined,
      },
      {
        'title': l10n.moduleMetricCompliance,
        'value': isLoading ? '--' : '${compliance.toStringAsFixed(1)}%',
        'color': violations > 0 ? BauhausDesign.warning : BauhausDesign.info,
        'icon': Icons.verified_outlined,
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
        indicator: const BoxDecoration(color: _inkBlack),
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
          Tab(text: l10n.tabImport),
          Tab(text: l10n.tabExport),
          Tab(text: l10n.tabBulk),
          Tab(text: l10n.tabHistory),
        ],
      ),
    );
  }

  Widget _buildImportTab(
      AppLocalizations l10n, List<PricingLiveRecord> records) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      children: [
        _buildPanel(
          title: l10n.importDataTitle,
          subtitle: l10n.importDataDesc,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPrimaryButton(
                label: l10n.importDataQuickAction,
                onTap: _isProcessing ? null : () => _importCsv(records),
              ),
              const SizedBox(height: 4),
              if (_isProcessing) const LinearProgressIndicator(minHeight: 2),
              if (_lastImportSummary.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  _lastImportSummary,
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w700),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExportTab(
      AppLocalizations l10n, List<PricingLiveRecord> records) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      children: [
        _buildPanel(
          title: l10n.exportDataTitle,
          subtitle: l10n.exportDataDesc,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildPrimaryButton(
                      label: l10n.exportDataQuickAction,
                      onTap: () => _generateExport(records),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildSecondaryButton(
                      label: l10n.dashboardViewAll,
                      onTap: _copyExportCsv,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 280,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceWhite,
                  border: Border.all(color: _inkBlack, width: 2),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    _exportCsv.isEmpty ? l10n.moduleNoDataYet : _exportCsv,
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(color: _inkBlack),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulkTab(
    AppLocalizations l10n,
    List<PricingLiveRecord> filtered,
    List<PricingLiveRecord> allRecords,
  ) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      children: [
        _buildPanel(
          title: l10n.bulkUpdatesTitle,
          subtitle: l10n.bulkUpdatesDesc,
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
                  Expanded(
                    child: _buildSimpleModeDropdown(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _bulkMode == 'fixed'
                          ? _fixedRateController
                          : _percentageController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText:
                            _bulkMode == 'fixed' ? 'Fixed rate' : 'Percent',
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
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Checkbox(
                    value: _showOnlyCustom,
                    onChanged: (value) {
                      setState(() => _showOnlyCustom = value ?? false);
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    side: const BorderSide(color: _inkBlack, width: 2),
                  ),
                  Expanded(
                    child: Text(
                      l10n.pricingFilterCustom,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                              color: _inkBlack, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    '${_selectedItemNumbers.length} ${l10n.employeesSelected}',
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(color: BauhausDesign.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              _buildPrimaryButton(
                label: l10n.bulkUpdatesQuickAction,
                onTap:
                    _isProcessing ? null : () => _applyBulkUpdate(allRecords),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        ...filtered.take(80).map(
              (record) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _panelWhite,
                  border: Border.all(color: _inkBlack, width: 2),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: _selectedItemNumbers
                          .contains(record.supportItemNumber),
                      onChanged: (selected) {
                        setState(() {
                          if (selected == true) {
                            _selectedItemNumbers.add(record.supportItemNumber);
                          } else {
                            _selectedItemNumbers
                                .remove(record.supportItemNumber);
                          }
                        });
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      side: const BorderSide(color: _inkBlack, width: 2),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${record.supportItemNumber} · ${record.supportItemName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                    color: _inkBlack,
                                    fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Current: \$${(record.customPrice ?? record.standardPrice).toStringAsFixed(2)} · Cap: ${record.priceCap?.toStringAsFixed(2) ?? '-'}',
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
              ),
            ),
      ],
    );
  }

  Widget _buildHistoryTab(
      AppLocalizations l10n, List<PricingLiveRecord> records) {
    final timeline = records
        .where((record) => record.isCustom && record.effectiveTimestamp != null)
        .take(20)
        .toList();

    return ListView(
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      children: [
        _buildPanel(
          title: l10n.operationHistoryTitle,
          subtitle: l10n.operationHistoryDesc,
          child: _events.isEmpty
              ? Text(
                  l10n.moduleNoTrackedChanges,
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(color: BauhausDesign.textMuted),
                )
              : Column(
                  children: _events
                      .take(12)
                      .map(
                        (event) => _buildHistoryRow(
                          title: event.action,
                          detail: event.detail,
                          summary:
                              '${event.successCount} ok / ${event.failedCount} failed',
                          time: event.timestamp,
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 4),
        _buildPanel(
          title: l10n.priceHistoryTitle,
          subtitle: l10n.trackPricingChanges,
          child: timeline.isEmpty
              ? Text(
                  l10n.moduleNoTrackedChanges,
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(color: BauhausDesign.textMuted),
                )
              : Column(
                  children: timeline
                      .map(
                        (record) => _buildHistoryRow(
                          title: record.supportItemNumber,
                          detail: record.supportItemName,
                          summary:
                              '\$${record.customPrice?.toStringAsFixed(2) ?? '-'} · ${record.source}',
                          time: record.effectiveTimestamp!,
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildHistoryRow({
    required String title,
    required String detail,
    required String summary,
    required DateTime time,
  }) {
    final stamp =
        '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: _inkBlack, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BauhausDesign.getTextTheme(context)
                .labelSmall
                ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w900),
          ),
          Text(
            detail,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: BauhausDesign.getTextTheme(context)
                .labelSmall
                ?.copyWith(color: BauhausDesign.textMuted),
          ),
          const SizedBox(height: 2),
          Text(
            summary,
            style: BauhausDesign.getTextTheme(context)
                .labelSmall
                ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w700),
          ),
          Text(
            stamp,
            style: BauhausDesign.getTextTheme(context)
                .labelSmall
                ?.copyWith(color: BauhausDesign.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildPanel({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
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
            style: BauhausDesign.getTextTheme(context)
                .labelLarge
                ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: BauhausDesign.getTextTheme(context)
                .labelSmall
                ?.copyWith(color: BauhausDesign.textMuted),
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  Widget _buildSimpleModeDropdown() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: _inkBlack, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _bulkMode,
          isExpanded: true,
          items: [
            DropdownMenuItem(value: 'percentage', child: Text(l10n.percentage)),
            const DropdownMenuItem(value: 'fixed', child: Text('Fixed Rate')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _bulkMode = value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color:
              onTap == null ? BauhausDesign.textMuted : BauhausDesign.primary,
          border: Border.all(color: _inkBlack, width: 2),
        ),
        child: Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
              ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String label,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          border: Border.all(color: _inkBlack, width: 2),
        ),
        child: Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context)
              .labelSmall
              ?.copyWith(color: _inkBlack, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
      ),
    );
  }
}

class _BulkEvent {
  final String action;
  final String detail;
  final int successCount;
  final int failedCount;
  final DateTime timestamp;

  const _BulkEvent({
    required this.action,
    required this.detail,
    required this.successCount,
    required this.failedCount,
    required this.timestamp,
  });
}
