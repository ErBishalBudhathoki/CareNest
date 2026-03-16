import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/viewmodels/automatic_invoice_viewmodel.dart';
import 'package:carenest/app/features/invoice/viewmodels/employee_selection_viewmodel.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer.dart';
import 'package:carenest/app/features/invoice/services/send_invoice_service.dart';
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;

/// Automatic Invoice Generation View
/// Modern UI for one-click invoice generation for all employees and clients
class AutomaticInvoiceGenerationView extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? organizationName;
  final String? email;
  final bool autoMode;
  final String? invoiceType;

  const AutomaticInvoiceGenerationView({
    super.key,
    this.organizationId,
    this.organizationName,
    this.email,
    this.autoMode = false,
    this.invoiceType,
  });

  @override
  ConsumerState<AutomaticInvoiceGenerationView> createState() =>
      _AutomaticInvoiceGenerationViewState();
}

class _AutomaticInvoiceGenerationViewState
    extends ConsumerState<AutomaticInvoiceGenerationView> {
  String? _organizationId;
  bool _hasAttemptedGeneration = false;
  bool _includeExpenses = true;
  bool _applyTax = true;
  double _taxRate = 0.00;
  bool _validatePrices = true;
  bool _allowPriceCapOverride = false;
  bool _includeDetailedPricingInfo = true;

  bool _useSelectedEmployees =
      false; // false => All employees, true => Selected employees only
  final Set<String> _selectedEmployeeEmails = {};
  bool _useSelectedClients =
      false; // false => All clients, true => Selected clients only
  final Set<String> _selectedClientEmails = {};
  // Local state for date range selection
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    // Prevent stale error/progress state when opening this screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(automaticInvoiceViewModelProvider.notifier).reset();
      }
    });
    _loadOrganizationId();
  }

  Future<void> _loadOrganizationId() async {
    if (widget.organizationId != null) {
      _organizationId = widget.organizationId;
    } else {
      final sharedPrefs = SharedPreferencesUtils();
      await sharedPrefs.init();
      _organizationId = sharedPrefs.getString('organizationId');

      if (mounted) {
        setState(() {});
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      foregroundColor: BauhausDesign.textDark,
      elevation: 0,
      titleSpacing: BauhausDesign.space4,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.automaticInvoiceGenerationTitle,
            style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                  color: BauhausDesign.textDark,
                ),
          ),
          Text(
            widget.organizationName ??
                AppLocalizations.of(context)!.organizationLabel,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textDark.withOpacity(0.7),
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
      backgroundColor: BauhausDesign.surfaceWhite,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: Container(
          height: 3,
          color: BauhausDesign.neutral,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_organizationId == null) {
      return const Center(
        child: BauhausLoadingState(showMessage: false),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(automaticInvoiceViewModelProvider);

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                BauhausDesign.space5,
                BauhausDesign.space5,
                BauhausDesign.space5,
                BauhausDesign.space8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeaderCard(),
                  const SizedBox(height: BauhausDesign.space5),
                  _buildConfigurationCard(),
                  const SizedBox(height: BauhausDesign.space5),
                  if (_hasAttemptedGeneration && state.isLoading)
                    ..._buildProgressSection(state),
                  if (!state.isLoading &&
                      !state.isCompleted &&
                      (!_hasAttemptedGeneration || state.errorMessage.isEmpty))
                    _buildGenerateButton(),
                  if (_hasAttemptedGeneration && state.isCompleted)
                    _buildResultsSection(state),
                  if (_hasAttemptedGeneration && state.errorMessage.isNotEmpty)
                    _buildErrorSection(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: BauhausDesign.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space5,
                    vertical: BauhausDesign.space4,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.oneClickGenerationTitle,
                    style: BauhausDesign.getTextTheme(context)
                        .titleMedium
                        ?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: BauhausDesign.surfaceWhite,
                          letterSpacing: 1.1,
                        ),
                  ),
                ),
              ),
              Container(
                width: 74,
                height: 74,
                color: BauhausDesign.accent,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.auto_awesome,
                  color: BauhausDesign.textDark,
                  size: 30,
                ),
              ),
            ],
          ),
          Container(height: 2, color: BauhausDesign.neutral),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(BauhausDesign.space5),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border:
                        Border.all(color: BauhausDesign.neutral, width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.info_outline,
                    color: BauhausDesign.textDark,
                    size: 18,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!
                        .automaticInvoiceGenerationDesc,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w600,
                          height: 1.45,
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

  Widget _buildConfigurationCard() {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: BauhausDesign.textDark,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space5,
              vertical: BauhausDesign.space4,
            ),
            child: Text(
              AppLocalizations.of(context)!
                  .invoiceConfigurationTitle
                  .toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildConfigOption(
                  AppLocalizations.of(context)!.includeExpensesOption,
                  AppLocalizations.of(context)!.includeExpensesOptionDesc,
                  _includeExpenses,
                  (value) => setState(() => _includeExpenses = value),
                  Icons.receipt_long,
                ),
                const SizedBox(height: BauhausDesign.space4),
                _buildConfigOption(
                  AppLocalizations.of(context)!.applyTaxOption,
                  AppLocalizations.of(context)!.applyTaxOptionDesc,
                  _applyTax,
                  (value) => setState(() => _applyTax = value),
                  Icons.calculate,
                ),
                if (_applyTax) ...[
                  const SizedBox(height: BauhausDesign.space4),
                  _buildTaxRateSlider(),
                ],
                const SizedBox(height: BauhausDesign.space4),
                _buildConfigOption(
                  AppLocalizations.of(context)!.validatePricesOption,
                  AppLocalizations.of(context)!.validatePricesOptionDesc,
                  _validatePrices,
                  (value) => setState(() => _validatePrices = value),
                  Icons.verified,
                ),
                const SizedBox(height: BauhausDesign.space4),
                _buildConfigOption(
                  AppLocalizations.of(context)!.allowPriceCapOverrideOption,
                  AppLocalizations.of(context)!.allowPriceCapOverrideOptionDesc,
                  _allowPriceCapOverride,
                  (value) => setState(() => _allowPriceCapOverride = value),
                  Icons.warning,
                ),
                const SizedBox(height: BauhausDesign.space4),
                _buildConfigOption(
                  AppLocalizations.of(context)!.detailedPricingInfoOption,
                  AppLocalizations.of(context)!.detailedPricingInfoOptionDesc,
                  _includeDetailedPricingInfo,
                  (value) =>
                      setState(() => _includeDetailedPricingInfo = value),
                  Icons.info,
                ),
                const SizedBox(height: BauhausDesign.space4),
                if (widget.invoiceType != 'client') ...[
                  _buildEmployeesSelection(),
                  const SizedBox(height: BauhausDesign.space4),
                ],
                if (widget.invoiceType != 'employee') ...[
                  _buildClientsSelection(),
                  const SizedBox(height: BauhausDesign.space4),
                ],

                _buildInvoicePeriodSelection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the invoice period selection UI, allowing the user to choose a
  /// start and end date for filtering line items and expenses.
  Widget _buildInvoicePeriodSelection() {
    return _buildModuleFrame(
      icon: Icons.calendar_today_rounded,
      title: AppLocalizations.of(context)!.invoicePeriodTitle,
      subtitle: 'Filter invoices and expenses by a custom date range.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3,
                    vertical: BauhausDesign.space3,
                  ),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    border:
                        Border.all(color: BauhausDesign.neutral, width: 1.5),
                  ),
                  child: Text(
                    (_selectedStartDate != null && _selectedEndDate != null)
                        ? '${_formatDate(_selectedStartDate!)}  →  ${_formatDate(_selectedEndDate!)}'
                        : AppLocalizations.of(context)!.noPeriodSelectedText,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              BauhausIconButton(
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDateRange:
                        (_selectedStartDate != null && _selectedEndDate != null)
                            ? DateTimeRange(
                                start: _selectedStartDate!,
                                end: _selectedEndDate!,
                              )
                            : null,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: BauhausDesign.primary,
                            onPrimary: BauhausDesign.surfaceWhite,
                            surface: BauhausDesign.surfaceWhite,
                            onSurface: BauhausDesign.textDark,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedStartDate = picked.start;
                      _selectedEndDate = picked.end;
                    });
                  }
                },
                icon: Icons.date_range_rounded,
                tooltip: AppLocalizations.of(context)!.selectPeriodButton,
                variant: BauhausActionVariant.secondary,
              ),
            ],
          ),
          if (_selectedStartDate != null && _selectedEndDate != null) ...[
            const SizedBox(height: BauhausDesign.space3),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedStartDate = null;
                    _selectedEndDate = null;
                  });
                },
                icon: const Icon(Icons.close_rounded),
                label: Text(AppLocalizations.of(context)!.clearButton),
                style: TextButton.styleFrom(
                  foregroundColor: BauhausDesign.error,
                  textStyle: BauhausDesign.getTextTheme(context)
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Employees inclusion/selection UI for intuitive control
  Widget _buildEmployeesSelection() {
    return _buildModuleFrame(
      icon: Icons.people_alt,
      title: AppLocalizations.of(context)!.employeesTitle,
      subtitle: 'Run for all employees or target only selected people.',
      child: Column(
        children: [
          _buildChoiceTile(
            title: AppLocalizations.of(context)!.allEmployeesOption,
            subtitle: 'Use everyone in this organization',
            selected: !_useSelectedEmployees,
            onTap: () => setState(() => _useSelectedEmployees = false),
          ),
          const SizedBox(height: BauhausDesign.space2),
          _buildChoiceTile(
            title: AppLocalizations.of(context)!.selectEmployeesOption,
            subtitle: 'Choose specific employees',
            selected: _useSelectedEmployees,
            onTap: () async {
              setState(() => _useSelectedEmployees = true);
              await _openEmployeeSelectionSheet();
            },
          ),
          if (_useSelectedEmployees) ...[
            const SizedBox(height: BauhausDesign.space3),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceOffWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedEmployeeEmails.isEmpty
                          ? AppLocalizations.of(context)!
                              .noEmployeesSelectedText
                          : AppLocalizations.of(context)!
                              .employeesSelectedCount(
                                  _selectedEmployeeEmails.length.toString()),
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  BauhausActionButton(
                    text: AppLocalizations.of(context)!.chooseEmployeesButton,
                    onPressed: _openEmployeeSelectionSheet,
                    icon: Icons.edit,
                    isSmall: true,
                    variant: BauhausActionVariant.secondary,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }


  Widget _buildModuleFrame({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceOffWhite,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 1.5),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space3,
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  color: BauhausDesign.accent,
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: BauhausDesign.textDark,
                    size: 18,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              color: BauhausDesign.textDark,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      Text(
                        subtitle,
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceTile({
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: selected
              ? BauhausDesign.primary.withOpacity(0.08)
              : BauhausDesign.surfaceWhite,
          border: Border.all(
            color: selected ? BauhausDesign.primary : BauhausDesign.neutral,
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? BauhausDesign.primary
                    : BauhausDesign.surfaceWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigOption(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon,
  ) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: value
              ? BauhausDesign.surfaceOffWhite
              : BauhausDesign.surfaceWhite,
          border: Border.all(
            color: value ? BauhausDesign.primary : BauhausDesign.neutral,
            width: value ? 2 : 1.5,
          ),
          boxShadow: const [BauhausDesign.shadowHardXs],
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color:
                    value ? BauhausDesign.primary : BauhausDesign.surfaceWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              ),
              child: Icon(
                icon,
                color:
                    value ? BauhausDesign.surfaceWhite : BauhausDesign.textDark,
                size: 18,
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: BauhausDesign.textDark,
                        ),
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    subtitle,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                  ),
                ],
              ),
            ),
            BauhausSwitch(
              value: value,
              onChanged: onChanged,
              variant: BauhausSwitchVariant.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxRateSlider() {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        boxShadow: const [BauhausDesign.shadowHardXs],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.taxRateLabel,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: BauhausDesign.textDark,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space2,
                  vertical: BauhausDesign.space1,
                ),
                decoration: BoxDecoration(
                  color: BauhausDesign.accent,
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                ),
                child: Text(
                  '${(_taxRate * 100).toStringAsFixed(1)}%',
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w900,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: BauhausDesign.primary,
              inactiveTrackColor: BauhausDesign.primary.withOpacity(0.1),
              thumbColor: BauhausDesign.primary,
              overlayColor: BauhausDesign.primary.withOpacity(0.1),
            ),
            child: Slider(
              value: _taxRate,
              min: 0.0,
              max: 0.2,
              divisions: 20,
              onChanged: (value) => setState(() => _taxRate = value),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProgressSection(AutomaticInvoiceState state) {
    return [
      BauhausCard(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      BauhausDesign.primary,
                    ),
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.generatingInvoicesTitle,
                    style: BauhausDesign.getTextTheme(context)
                        .titleMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            LinearProgressIndicator(
              value: state.progress,
              valueColor: const AlwaysStoppedAnimation<Color>(
                BauhausDesign.primary,
              ),
              backgroundColor: BauhausDesign.primary.withOpacity(0.1),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    state.currentStep,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${(state.progress * 100).toStringAsFixed(0)}%',
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: BauhausDesign.space4),
    ];
  }

  Widget _buildGenerateButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: BauhausActionButton(
        text: AppLocalizations.of(context)!
            .generateAllInvoicesButton
            .toUpperCase(),
        onPressed: _generateInvoices,
        icon: Icons.auto_awesome,
        isFullWidth: true,
      ),
    );
  }

  Widget _buildResultsSection(AutomaticInvoiceState state) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.success.withOpacity(0.1),
                  border: Border.all(color: BauhausDesign.success, width: 2),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: BauhausDesign.success,
                  size: 28,
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .generationCompleteTitle
                          .toUpperCase(),
                      style: BauhausDesign.getTextTheme(context)
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.success,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Text(
                      AppLocalizations.of(context)!.generationCompleteDesc,
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildStatCard(AppLocalizations.of(context)!.totalEmployeesStat,
              state.totalEmployees.toString(), Icons.people),
          const SizedBox(height: BauhausDesign.space2),
          _buildStatCard(AppLocalizations.of(context)!.totalClientsStat,
              state.totalClients.toString(), Icons.business),
          const SizedBox(height: BauhausDesign.space2),
          _buildStatCard(AppLocalizations.of(context)!.validPairsStat,
              state.validPairs.toString(), Icons.link),
          const SizedBox(height: BauhausDesign.space2),
          _buildStatCard(AppLocalizations.of(context)!.generatedInvoicesStat,
              state.generatedPdfPaths.length.toString(), Icons.description),
          const SizedBox(height: BauhausDesign.space4),
          if (state.generatedPdfPaths.isNotEmpty) ...[
            _buildGeneratedPdfsSection(state.generatedPdfPaths),
            const SizedBox(height: BauhausDesign.space4),
          ],
          BauhausActionButton(
            text:
                AppLocalizations.of(context)!.generateAgainButton.toUpperCase(),
            onPressed: _resetGeneration,
            isFullWidth: true,
            icon: Icons.refresh_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [
          BoxShadow(
            color: BauhausDesign.textDark,
            offset: const Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: BauhausDesign.primary,
            size: 24,
          ),
          const SizedBox(width: BauhausDesign.space4),
          Expanded(
            child: Text(
              label,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
            ),
          ),
          Text(
            value,
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  color: BauhausDesign.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection(AutomaticInvoiceState state) {
    final isWarning = _isInvoiceWarningState(state.errorMessage);
    final accent = isWarning ? BauhausDesign.warning : BauhausDesign.error;
    final icon = isWarning ? Icons.info_outline : Icons.error_outline;
    final title = isWarning
        ? 'Invoice Setup Required'
        : AppLocalizations.of(context)!.generationFailedTitle.toUpperCase();

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  border: Border.all(color: accent, width: 2),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                ),
                child: Icon(
                  icon,
                  color: accent,
                  size: 28,
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: Text(
                  title,
                  style:
                      BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: accent,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            state.errorMessage,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          BauhausActionButton(
            text: AppLocalizations.of(context)!.tryAgainButton.toUpperCase(),
            onPressed: _resetGeneration,
            isFullWidth: true,
            icon: Icons.refresh,
          ),
        ],
      ),
    );
  }

  bool _isInvoiceWarningState(String message) {
    final m = message.toLowerCase();
    return m.contains('no clients found') ||
        m.contains('no employees found') ||
        m.contains('no valid employee-client relationships') ||
        m.contains('no selected employees');
  }

  Future<void> _generateInvoices() async {
    if (_organizationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorOrgIdNotFound),
        ),
      );
      return;
    }

    // If using selected employees, ensure at least one is chosen
    if (widget.invoiceType != 'client' && _useSelectedEmployees && _selectedEmployeeEmails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(AppLocalizations.of(context)!.errorSelectAtLeastOneEmployee),
        ),
      );
      return;
    }

    // If using selected clients, ensure at least one is chosen
    if (widget.invoiceType != 'employee' && _useSelectedClients && _selectedClientEmails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please select at least one client to include.'), // AppLocalizations doesn't exist for this right now
        ),
      );
      return;
    }

    // Validate tax settings: allow 0% tax, only block negatives
    if (_applyTax && (_taxRate < 0.0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorNegativeTaxRate),
        ),
      );
      return;
    }

    // Validate date range when both dates are provided
    if (_selectedStartDate != null && _selectedEndDate != null) {
      if (_selectedEndDate!.isBefore(_selectedStartDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorInvalidDateRange),
          ),
        );
        return;
      }
    }

    final viewModel = ref.read(automaticInvoiceViewModelProvider.notifier);

    setState(() {
      _hasAttemptedGeneration = true;
    });

    await viewModel.generateAutomaticInvoices(
      context,
      organizationId: _organizationId!,
      validatePrices: _validatePrices,
      allowPriceCapOverride: _allowPriceCapOverride,
      includeDetailedPricingInfo: _includeDetailedPricingInfo,
      applyTax: _applyTax,
      taxRate: _taxRate,
      includeExpenses: _includeExpenses,
      selectedEmployeeEmails:
          _useSelectedEmployees ? _selectedEmployeeEmails.toList() : null,
      selectedClientEmails:
          _useSelectedClients ? _selectedClientEmails.toList() : null,
      startDate: _selectedStartDate,
      endDate: _selectedEndDate,
      invoiceType: widget.invoiceType,
    );
  }

  /// Opens a bottom sheet to quickly pick employees to include
  Future<void> _openEmployeeSelectionSheet() async {
    if (_organizationId == null) return;

    // Pre-fetch employees for smooth UX
    final provider = employeeSelectionViewModelProvider(_organizationId!);
    final vm = ref.read(provider.notifier);
    final state = ref.read(provider);
    if (state.employees.isEmpty && !state.isLoading) {
      await vm.fetchEmployees();
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: BauhausDesign.surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(BauhausDesign.radiusXl)),
      ),
      builder: (ctx) {
        return Consumer(
          builder: (context, ref, _) {
            final s = ref.watch(provider);
            return Padding(
              padding: EdgeInsets.only(
                left: BauhausDesign.space4,
                right: BauhausDesign.space4,
                top: BauhausDesign.space4,
                bottom: BauhausDesign.space4 +
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(BauhausDesign.space2),
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(color: BauhausDesign.primary),
                        ),
                        child: const Icon(Icons.people_alt,
                            color: BauhausDesign.primary, size: 20),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Text(
                        AppLocalizations.of(context)!.selectEmployeesModalTitle,
                        style: BauhausDesign.getTextTheme(context)
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                        color: BauhausDesign.textDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  if (s.isLoading && s.employees.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                          child: CircularProgressIndicator(
                              color: BauhausDesign.primary)),
                    )
                  else if (s.employees.isEmpty)
                    Text(
                      AppLocalizations.of(context)!.noEmployeesFound,
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                    )
                  else
                    const SizedBox(height: BauhausDesign.space2),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: s.employees.length,
                      itemBuilder: (context, index) {
                        final emp = s.employees[index];
                        final isChecked = emp.isSelected ||
                            _selectedEmployeeEmails.contains(emp.email);
                        return CheckboxListTile(
                          title: Text(emp.name,
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          subtitle: Text(emp.email,
                              style: BauhausDesign.getTextTheme(context)
                                  .bodySmall
                                  ?.copyWith(color: BauhausDesign.textMuted)),
                          value: isChecked,
                          activeColor: BauhausDesign.primary,
                          checkColor: BauhausDesign.surfaceWhite,
                          onChanged: (val) {
                            ref
                                .read(provider.notifier)
                                .toggleEmployeeSelection(emp.id);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  BauhausActionButton(
                    text: AppLocalizations.of(context)!
                        .confirmSelectionButton
                        .toUpperCase(),
                    onPressed: () {
                      final picked = ref
                          .read(provider)
                          .employees
                          .where((e) => e.isSelected)
                          .map((e) => e.email)
                          .where((e) => e.isNotEmpty)
                          .toSet();
                      setState(() {
                        _selectedEmployeeEmails
                          ..clear()
                          ..addAll(picked);
                      });
                      Navigator.of(context).pop();
                    },
                    icon: Icons.check_circle,
                    isFullWidth: true,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Clients inclusion/selection UI for intuitive control
  Widget _buildClientsSelection() {
    return _buildModuleFrame(
      icon: Icons.business_rounded,
      title: 'Clients', // Assuming localization might not cover it directly, fallback
      subtitle: 'Run for all clients or target only selected clients.',
      child: Column(
        children: [
          _buildChoiceTile(
            title: 'All Clients',
            subtitle: 'Use all clients in this organization',
            selected: !_useSelectedClients,
            onTap: () => setState(() => _useSelectedClients = false),
          ),
          const SizedBox(height: BauhausDesign.space2),
          _buildChoiceTile(
            title: 'Select Clients',
            subtitle: 'Choose specific clients',
            selected: _useSelectedClients,
            onTap: () async {
              setState(() => _useSelectedClients = true);
              await _openClientSelectionSheet();
            },
          ),
          if (_useSelectedClients) ...[
            const SizedBox(height: BauhausDesign.space3),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceOffWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedClientEmails.isEmpty
                          ? 'No clients selected'
                          : '${_selectedClientEmails.length} client(s) selected',
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  BauhausActionButton(
                    text: 'Choose Clients',
                    onPressed: _openClientSelectionSheet,
                    icon: Icons.edit,
                    isSmall: true,
                    variant: BauhausActionVariant.secondary,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Opens a bottom sheet to quickly pick clients to include
  Future<void> _openClientSelectionSheet() async {
    if (_organizationId == null) return;

    List<Map<String, dynamic>> clientsData = [];
    bool isLoading = true;
    String error = '';

    // Create a local StateSetter to manage sheet state
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: BauhausDesign.surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(BauhausDesign.radiusXl)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            // Fetch once
            if (isLoading && clientsData.isEmpty && error.isEmpty) {
              final api = ref.read(app_providers.apiMethodProvider);
              api.getClientsByOrganizationId(_organizationId!).then((clients) {
                if (mounted) {
                  setModalState(() {
                    clientsData = clients;
                    isLoading = false;
                  });
                }
              }).catchError((e) {
                if (mounted) {
                  setModalState(() {
                    error = 'Failed to load clients: $e';
                    isLoading = false;
                  });
                }
              });
            }

            return Padding(
              padding: EdgeInsets.only(
                left: BauhausDesign.space4,
                right: BauhausDesign.space4,
                top: BauhausDesign.space4,
                bottom: BauhausDesign.space4 +
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(BauhausDesign.space2),
                        decoration: BoxDecoration(
                          color: BauhausDesign.primary.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(color: BauhausDesign.primary),
                        ),
                        child: const Icon(Icons.business_rounded,
                            color: BauhausDesign.primary, size: 20),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Text(
                        'Select Clients',
                        style: BauhausDesign.getTextTheme(context)
                            .titleLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                        color: BauhausDesign.textDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                          child: CircularProgressIndicator(
                              color: BauhausDesign.primary)),
                    )
                  else if (error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        error,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: BauhausDesign.error),
                      ),
                    )
                  else if (clientsData.isEmpty)
                    Text(
                      'No clients found in this organization.',
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                    )
                  else
                    const SizedBox(height: BauhausDesign.space2),
                  if (!isLoading && clientsData.isNotEmpty)
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: clientsData.length,
                        itemBuilder: (context, index) {
                          final client = clientsData[index];
                          final clientEmail = client['clientEmail'] ?? '';
                          final clientName = client['clientName'] ??
                              client['clientEmail'] ??
                              'Unknown';
                          final isChecked =
                              _selectedClientEmails.contains(clientEmail);

                          // Important: skip empty emails
                          if (clientEmail.toString().isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return CheckboxListTile(
                            title: Text(clientName,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            subtitle: Text(clientEmail,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: BauhausDesign.textMuted)),
                            value: isChecked,
                            activeColor: BauhausDesign.primary,
                            checkColor: BauhausDesign.surfaceWhite,
                            onChanged: (val) {
                              setModalState(() {
                                if (val == true) {
                                  _selectedClientEmails.add(clientEmail);
                                } else {
                                  _selectedClientEmails.remove(clientEmail);
                                }
                              });
                              // Also call main setState so UI updates under the modal
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: BauhausDesign.space4),
                  BauhausActionButton(
                    text: AppLocalizations.of(context)!
                        .confirmSelectionButton
                        .toUpperCase(),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icons.check_circle,
                    isFullWidth: true,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _resetGeneration() {
    final viewModel = ref.read(automaticInvoiceViewModelProvider.notifier);
    viewModel.reset();
    if (mounted) {
      setState(() {
        _hasAttemptedGeneration = false;
      });
    }
  }

  Widget _buildGeneratedPdfsSection(List<String> generatedPdfs) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.primary),
                ),
                child: const Icon(
                  Icons.file_present_rounded,
                  color: BauhausDesign.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.generatedInvoicesTitle,
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.primary,
                          ),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .invoicesReadyCount(generatedPdfs.length),
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          ...generatedPdfs.asMap().entries.map((entry) {
            final index = entry.key;
            final pdfPath = entry.value;
            final fileName = pdfPath.split('/').last;

            return Container(
              margin: index < generatedPdfs.length - 1
                  ? const EdgeInsets.only(bottom: BauhausDesign.space2)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: 1.5,
                ),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  onTap: () => _viewPdf(pdfPath),
                  child: Padding(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: BauhausDesign.success.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusSm),
                            border: Border.all(color: BauhausDesign.success),
                          ),
                          child: const Icon(
                            Icons.picture_as_pdf_rounded,
                            color: BauhausDesign.success,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fileName,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                AppLocalizations.of(context)!.tapToViewPdf,
                                style: BauhausDesign.getTextTheme(context)
                                    .labelSmall
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final hasSpaceForBothButtons =
                                constraints.maxWidth > 120;

                            if (hasSpaceForBothButtons) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildActionButton(
                                    icon: Icons.visibility_rounded,
                                    onPressed: () => _viewPdf(pdfPath),
                                    tooltip: AppLocalizations.of(context)!
                                        .viewPdfTooltip,
                                  ),
                                  const SizedBox(width: 8.0),
                                  _buildActionButton(
                                    icon: Icons.send_rounded,
                                    onPressed: () => _sendInvoices(pdfPath),
                                    tooltip: AppLocalizations.of(context)!
                                        .sendInvoiceTooltip,
                                  ),
                                ],
                              );
                            } else {
                              return _buildActionButton(
                                icon: Icons.visibility_rounded,
                                onPressed: () => _viewPdf(pdfPath),
                                tooltip: AppLocalizations.of(context)!
                                    .viewPdfTooltip,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _viewPdf(String pdfPath) async {
    if (File(pdfPath).existsSync()) {
      try {
        // Find the corresponding invoice data to extract receipt URLs
        final state = ref.read(automaticInvoiceViewModelProvider);
        List<String> receiptUrls = [];

        // Try to find the invoice that matches this PDF path
        final index = state.generatedPdfPaths.indexOf(pdfPath);
        if (index != -1 && index < state.invoices.length) {
          final invoiceData = state.invoices[index];

          // Extract receipts logic
          try {
            final expenses = invoiceData['expenses'] as List<dynamic>?;
            if (expenses != null) {
              for (var expense in expenses) {
                if (expense is Map<String, dynamic>) {
                  final receiptFiles = expense['receiptFiles'] as List?;
                  final receiptPhotos = expense['receiptPhotos'] as List?;
                  final receiptUrl = expense['receiptUrl'] as String?;

                  String? resolveToDownloadUrl(String value) {
                    final resolved = AppConfig.resolveResourceUrl(value);
                    if (!(resolved.startsWith('http://') ||
                        resolved.startsWith('https://'))) {
                      return null;
                    }
                    try {
                      if (AppConfig.isPrivateR2StorageUrl(resolved)) {
                        return AppConfig.buildFilesProxyUrl(resolved);
                      }
                      return AppConfig.buildFilesDownloadUrl(resolved);
                    } catch (e) {
                      debugPrint(
                          'Error building receipt download URL in _viewPdf: $e');
                      return resolved;
                    }
                  }

                  if (receiptFiles != null) {
                    for (var file in receiptFiles) {
                      if (file is String && file.trim().isNotEmpty) {
                        final fullUrl = resolveToDownloadUrl(file.trim());
                        if (fullUrl != null) receiptUrls.add(fullUrl);
                      }
                    }
                  }

                  if (receiptPhotos != null) {
                    for (var photo in receiptPhotos) {
                      if (photo is String && photo.trim().isNotEmpty) {
                        final fullUrl = resolveToDownloadUrl(photo.trim());
                        if (fullUrl != null) receiptUrls.add(fullUrl);
                      }
                    }
                  }

                  if (receiptUrl != null && receiptUrl.trim().isNotEmpty) {
                    final fullUrl = resolveToDownloadUrl(receiptUrl.trim());
                    if (fullUrl != null) receiptUrls.add(fullUrl);
                  }
                }
              }
            }
          } catch (e) {
            debugPrint('Error extracting receipts in _viewPdf: $e');
          }
        }

        // Remove duplicates
        receiptUrls = receiptUrls.toSet().toList();

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewPage(
              pdfPath: pdfPath,
              receiptUrls: receiptUrls,
            ),
          ),
        );
      } catch (e) {
        debugPrint('Error viewing PDF: $e');
        // Fallback to simple view
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewPage(pdfPath: pdfPath),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorPdfFileNotFound),
        ),
      );
    }
  }

  void _sendInvoices(String pdfPath) {
    final sendInvoiceService = SendInvoiceService();
    sendInvoiceService.sendInvoice({
      'pdfPath': pdfPath,
      'organizationName': widget.organizationName ?? 'Organization',
      'email': widget.email ?? '',
    });
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return BauhausIconButton(
      onPressed: onPressed,
      icon: icon,
      tooltip: tooltip,
      isSmall: true,
      variant: BauhausActionVariant.neutral,
    );
  }

  /// Formats a `DateTime` to a simple `YYYY-MM-DD` string for display.
  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
