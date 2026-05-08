import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/holiday/models/holiday_model.dart';
import 'package:carenest/app/features/holiday/services/holiday_service.dart';
import 'package:carenest/app/features/holiday/views/add_holiday_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HolidayListView extends ConsumerStatefulWidget {
  final List<dynamic> holidays;
  final bool readonly;

  const HolidayListView({
    super.key,
    this.holidays = const [],
    this.readonly = false,
  });

  @override
  ConsumerState<HolidayListView> createState() => _HolidayListViewState();
}

class _HolidayListViewState extends ConsumerState<HolidayListView> {
  static const List<String> _stateFilters = <String>[
    'ALL',
    'NATIONAL',
    'ACT',
    'NSW',
    'NT',
    'QLD',
    'SA',
    'TAS',
    'VIC',
    'WA',
    'CUSTOM',
  ];

  List<Holiday> _allHolidays = [];
  String _selectedState = 'NSW';
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _primeFromInitialPayload(widget.holidays);
    _loadHolidays();
  }

  @override
  void didUpdateWidget(covariant HolidayListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.holidays, widget.holidays) &&
        widget.holidays.isNotEmpty) {
      _primeFromInitialPayload(widget.holidays);
    }
  }

  void _primeFromInitialPayload(List<dynamic> source) {
    final seeded = source
        .map(_toHoliday)
        .whereType<Holiday>()
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (seeded.isEmpty) return;
    setState(() {
      _allHolidays = seeded;
    });
  }

  Holiday? _toHoliday(dynamic raw) {
    if (raw is Holiday) return raw;
    if (raw is! Map) return null;

    final map = Map<String, dynamic>.from(raw);
    final title = (map['Holiday'] ?? map['name'] ?? map['title'])?.toString();
    final date = _parseDateFlexible(map['Date'] ?? map['date']);
    if (title == null || title.trim().isEmpty || date == null) {
      return null;
    }

    final itemOrgId = map['organizationId'] ?? map['OrganizationId'];
    final isCustom = map['isCustom'] == true ||
        (itemOrgId != null && itemOrgId.toString().isNotEmpty);

    String jurisdiction = 'national';
    if (isCustom) {
      jurisdiction = 'custom';
    } else {
      final state = map['state']?.toString();
      if (state != null && state.trim().isNotEmpty) {
        jurisdiction = state.toLowerCase();
      }
    }

    return Holiday(
      id: (map['_id'] ??
              map['id'] ??
              'local_${date.millisecondsSinceEpoch}_${title.hashCode}')
          .toString(),
      title: title,
      date: date,
      jurisdiction: jurisdiction,
      isPublic: !isCustom,
      isCustom: isCustom,
    );
  }

  DateTime? _parseDateFlexible(dynamic rawDate) {
    if (rawDate == null) return null;
    final value = rawDate.toString().trim();
    if (value.isEmpty) return null;

    try {
      return DateTime.parse(value);
    } catch (_) {}

    try {
      return DateFormat('dd-MM-yyyy').parseStrict(value);
    } catch (_) {}

    try {
      return DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (_) {
      return null;
    }
  }

  Future<void> _loadHolidays() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final holidays = await ref.read(holidayServiceProvider).getAllHolidays();
      if (!mounted) return;
      setState(() {
        _allHolidays = holidays;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Holiday> get _filteredHolidays {
    if (_selectedState == 'ALL') {
      return _allHolidays;
    }

    if (_selectedState == 'CUSTOM') {
      return _allHolidays.where((h) => h.isCustom).toList();
    }

    if (_selectedState == 'NATIONAL') {
      return _allHolidays
          .where((h) => h.isCustom || h.jurisdiction == 'national')
          .toList();
    }

    return _allHolidays.where((h) {
      if (h.isCustom) return true;
      if (h.jurisdiction == 'national') return true;
      return h.jurisdiction.toUpperCase() == _selectedState;
    }).toList();
  }

  void _addHoliday(Map<String, String> holiday) {
    _loadHolidays();
  }

  Future<void> _deleteHoliday(Holiday holiday) async {
    if (!holiday.isCustom) return;

    final backup = List<Holiday>.from(_allHolidays);
    setState(() {
      _allHolidays.removeWhere((h) => h.id == holiday.id);
    });

    try {
      await _deleteHolidayItem(holiday.id);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _allHolidays = backup;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete holiday: $e')),
      );
    }
  }

  Future<dynamic> _deleteHolidayItem(String id) async {
    final apiMethod = ref.read(apiMethodProvider);
    return await apiMethod.deleteHolidayItem(id);
  }

  String _getDaysUntil(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final difference = target.difference(today).inDays;

    if (difference == 0) {
      return AppLocalizations.of(context)!.today;
    }
    if (difference == 1) {
      return 'Tomorrow';
    }
    if (difference > 1) {
      return 'In $difference days';
    }
    return AppLocalizations.of(context)!.past;
  }

  String _filterLabel(String state) {
    switch (state) {
      case 'NATIONAL':
        return 'National';
      case 'CUSTOM':
        return 'Custom';
      default:
        return state;
    }
  }

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.25),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedState,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
          items: _stateFilters
              .map(
                (state) => DropdownMenuItem<String>(
                  value: state,
                  child: Text(_filterLabel(state)),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _selectedState = value;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final visibleHolidays = _filteredHolidays;

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: BauhausDesign.space2),
          child: Center(
            child: BauhausIconButton(
              icon: Icons.arrow_back_ios_new,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: BauhausDesign.space2),
            child: BauhausIconButton(
              icon: Icons.refresh,
              onPressed: _isLoading ? null : _loadHolidays,
            ),
          ),
        ],
        title: Text(
          l10n.holidays,
          style: BauhausDesign.getTextTheme(context).headlineMedium,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: BauhausCard(
              padding: const EdgeInsets.all(BauhausDesign.space6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(BauhausDesign.space3),
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusMd),
                        ),
                        child: Icon(
                          Icons.calendar_month,
                          color: BauhausDesign.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.holidayList,
                              style: BauhausDesign.getTextTheme(context)
                                  .headlineSmall,
                            ),
                            Text(
                              l10n.holidayListDesc,
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(color: BauhausDesign.textMuted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildFilterDropdown(),
                  const SizedBox(height: BauhausDesign.space3),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space4,
                      vertical: BauhausDesign.space3,
                    ),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceOffWhite,
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusMd),
                      border: Border.all(color: BauhausDesign.neutral),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_available,
                          size: 20,
                          color: BauhausDesign.textDark,
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Text(
                          '${l10n.total}: ${visibleHolidays.length}',
                          style: BauhausDesign.getTextTheme(context).labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
          ),
          Expanded(
            child: _buildBody(visibleHolidays, l10n),
          ),
        ],
      ),
      floatingActionButton: widget.readonly
          ? null
          : BauhausActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddHolidayScreen(
                      addHoliday: _addHoliday,
                      holidays: const [],
                    ),
                  ),
                );
              },
              icon: Icons.add,
              text: l10n.addHoliday,
              isFullWidth: false,
            ),
    );
  }

  Widget _buildBody(List<Holiday> holidays, AppLocalizations l10n) {
    if (_isLoading && _allHolidays.isEmpty) {
      return const BauhausLoadingState(message: 'Loading holidays...');
    }

    if (_errorMessage != null && _allHolidays.isEmpty) {
      return BauhausErrorState(
        description: _errorMessage!,
        onRetry: _loadHolidays,
      );
    }

    if (holidays.isEmpty) {
      return _buildEmptyState(l10n);
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        BauhausDesign.space4,
        0,
        BauhausDesign.space4,
        widget.readonly ? BauhausDesign.space6 : 120,
      ),
      itemCount: holidays.length,
      itemBuilder: (context, index) {
        final holiday = holidays[index];
        final holidayDate = holiday.date;

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final itemDate =
            DateTime(holidayDate.year, holidayDate.month, holidayDate.day);

        final isUpcoming = !itemDate.isBefore(today);
        final isToday = itemDate == today;

        final Color dateCircleColor = isToday
            ? BauhausDesign.primary
            : (isUpcoming
                ? BauhausDesign.secondary.withOpacity(0.9)
                : BauhausDesign.surfaceOffWhite);
        final Color dateTextColor =
            (isToday || isUpcoming) ? BauhausDesign.surfaceWhite : BauhausDesign.textDark;

        return Padding(
          padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
          child: BauhausCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: dateCircleColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: BauhausDesign.textDark.withOpacity(0.65),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('dd').format(holidayDate),
                        style: BauhausDesign.getTextTheme(context)
                            .headlineSmall
                            ?.copyWith(
                              color: dateTextColor,
                              height: 1,
                            ),
                      ),
                      Text(
                        DateFormat('MMM').format(holidayDate).toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: dateTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        holiday.title,
                        style: BauhausDesign.getTextTheme(context)
                            .titleMedium
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${DateFormat('dd-MM-yyyy').format(holidayDate)} • ${DateFormat('EEEE').format(holidayDate)}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          BauhausChip(
                            label: holiday.isCustom ? 'CUSTOM' : 'PUBLIC',
                            size: BauhausChipSize.small,
                            variant: holiday.isCustom
                                ? BauhausChipVariant.secondary
                                : BauhausChipVariant.primary,
                          ),
                          if (!holiday.isCustom)
                            BauhausChip(
                              label: holiday.jurisdiction.toUpperCase(),
                              size: BauhausChipSize.small,
                              variant: BauhausChipVariant.outlined,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isUpcoming) ...[
                      BauhausChip(
                        text: isToday
                            ? l10n.today.toUpperCase()
                            : _getDaysUntil(holidayDate).toUpperCase(),
                        variant: isToday
                            ? BauhausChipVariant.primary
                            : BauhausChipVariant.outlined,
                        size: BauhausChipSize.small,
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (!widget.readonly && holiday.isCustom)
                      InkWell(
                        onTap: () => _deleteHoliday(holiday),
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusFull),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: BauhausDesign.error,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ).animate(delay: (40 * index).ms).fadeIn().slideX(),
        );
      },
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return BauhausEmptyState(
      title: 'No Holidays Found',
      subtitle: 'Try another state filter or add a custom holiday.',
      icon: Icons.calendar_today,
      onAction: widget.readonly
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddHolidayScreen(
                    addHoliday: _addHoliday,
                    holidays: const [],
                  ),
                ),
              );
            },
      actionLabel: widget.readonly ? null : l10n.addHoliday,
    );
  }
}
