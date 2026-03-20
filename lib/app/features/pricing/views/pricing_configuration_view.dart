import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/providers/pricing_settings_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class PricingConfigurationView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const PricingConfigurationView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  });

  @override
  ConsumerState<PricingConfigurationView> createState() =>
      _PricingConfigurationViewState();
}

class _PricingConfigurationViewState
    extends ConsumerState<PricingConfigurationView>
    with TickerProviderStateMixin {
  static const Color _screenGray = BauhausDesign.backgroundLight;
  static const Color _inkBlack = BauhausDesign.neutral;
  static const Color _accentRed = BauhausDesign.primary;
  static const Color _panelWhite = BauhausDesign.surfaceWhite;
  static const Color _accentBlue = BauhausDesign.secondary;
  static const String _currencyAud = 'AUD';

  late TabController _tabController;
  bool _isLoading = false;
  bool _didInitializeLocalizedDefaults = false;

  // Configuration settings
  bool _autoUpdatePricing = true;
  bool _enablePriceValidation = true;
  bool _requireApprovalForChanges = false;
  bool _enableBulkOperations = true;
  bool _enablePriceHistory = true;
  bool _enableNotifications = true;

  String _defaultCurrency = _currencyAud;
  String _pricingModel = '';
  String _roundingMethod = '';
  String _taxCalculation = '';

  double _defaultMarkup = 15.0;
  double _maxPriceVariation = 20.0;
  int _priceHistoryRetention = 365;
  int _bulkOperationLimit = 1000;

  // Fallback base rate state
  late final ApiMethod _api;
  final TextEditingController _fallbackRateController = TextEditingController();
  double? _fallbackBaseRate;
  bool _isFallbackLoading = false;
  bool _isSavingFallbackRate = false;
  String? _fallbackError;

  List<Map<String, dynamic>> _getPricingRules(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'id': 'RULE001',
        'name': l10n.ruleNdisPriceCapValidationName,
        'description': l10n.ruleNdisPriceCapValidationDescription,
        'enabled': true,
        'priority': l10n.rulePriorityHigh,
        'lastModified': '2024-01-15',
      },
      {
        'id': 'RULE002',
        'name': l10n.ruleMinimumRateValidationName,
        'description': l10n.ruleMinimumRateValidationDescription,
        'enabled': true,
        'priority': l10n.rulePriorityMedium,
        'lastModified': '2024-01-12',
      },
      {
        'id': 'RULE003',
        'name': l10n.ruleGeographicLoadingName,
        'description': l10n.ruleGeographicLoadingDescription,
        'enabled': false,
        'priority': l10n.rulePriorityLow,
        'lastModified': '2024-01-10',
      },
    ];
  }

  List<Map<String, dynamic>> _getIntegrationSettings(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'name': l10n.integrationNdisPriceGuideApiName,
        'description': l10n.integrationNdisPriceGuideApiDescription,
        'status': l10n.ruleStatusConnected,
        'lastSync': '2024-01-15 09:30:00',
        'enabled': true,
      },
      {
        'name': l10n.integrationAccountingSystemName,
        'description': l10n.integrationAccountingSystemDescription,
        'status': l10n.ruleStatusDisconnected,
        'lastSync': l10n.ruleNeverSync,
        'enabled': false,
      },
      {
        'name': l10n.integrationCrmSystemName,
        'description': l10n.integrationCrmSystemDescription,
        'status': l10n.ruleStatusConnected,
        'lastSync': '2024-01-15 08:15:00',
        'enabled': true,
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInitializeLocalizedDefaults) return;
    _applyLocalizedDefaults(AppLocalizations.of(context)!);
    _didInitializeLocalizedDefaults = true;
    _loadFallbackBaseRate();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fallbackRateController.dispose();
    super.dispose();
  }

  void _applyLocalizedDefaults(AppLocalizations l10n) {
    _defaultCurrency = _currencyAud;
    _pricingModel = l10n.optionNdisStandard;
    _roundingMethod = l10n.optionNearestCent;
    _taxCalculation = l10n.optionGstInclusive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenGray,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverFillRemaining(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    final l10n = AppLocalizations.of(context)!;
    return SliverAppBar(
      toolbarHeight: BauhausDesign.appBarCompactHeight,
      floating: false,
      pinned: true,
      centerTitle: false,
      backgroundColor: _screenGray,
      surfaceTintColor: _screenGray,
      leadingWidth: 44,
      leading: Padding(
        padding: const EdgeInsets.only(
          left: BauhausDesign.space2,
          top: BauhausDesign.space2,
          bottom: BauhausDesign.space2,
        ),
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
              color: _panelWhite,
              border: Border.all(
                  color: _inkBlack, width: BauhausDesign.borderThick),
            ),
            child: const Icon(
              Icons.arrow_back,
              size: BauhausDesign.iconMd,
              color: _inkBlack,
            ),
          ),
        ),
      ),
      title: Text(
        l10n.pricingConfigurationTitle.toUpperCase(),
        style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
              color: _inkBlack,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: [
        Consumer(
          builder: (context, ref, _) {
            final vm = ref.watch(pricingSettingsViewModelProvider);
            return _buildHeaderActionIcon(
              icon: Icons.save,
              tooltip: l10n.save,
              onTap: (_isLoading || vm.isLoading) ? null : _saveConfiguration,
              color: _accentRed,
            );
          },
        ),
        _buildHeaderActionIcon(
          icon: Icons.refresh,
          tooltip: l10n.resetToDefaultsTooltip,
          onTap: _resetConfiguration,
          color: _accentBlue,
        ),
        const SizedBox(width: BauhausDesign.space2),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(82),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                BauhausDesign.space3,
                0,
                BauhausDesign.space3,
                BauhausDesign.space2,
              ),
              child: Row(
                children: [
                  Text(
                    l10n.pricingConfigurationTitle.toUpperCase(),
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(
                          color: _inkBlack,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space3,
                      vertical: BauhausDesign.space1,
                    ),
                    decoration: BoxDecoration(
                      color: _accentRed,
                      border: Border.all(
                        color: _inkBlack,
                        width: BauhausDesign.borderThick,
                      ),
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
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _inkBlack, width: BauhausDesign.borderThin),
                  bottom: BorderSide(
                      color: _inkBlack, width: BauhausDesign.borderThin),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: _accentRed,
                indicatorWeight: 3,
                labelColor: _inkBlack,
                unselectedLabelColor: BauhausDesign.textMuted,
                labelStyle: BauhausDesign.getTextTheme(context)
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.4),
                isScrollable: true,
                tabs: [
                  Tab(text: l10n.tabGeneralSettings.toUpperCase()),
                  Tab(text: l10n.tabPricingRules.toUpperCase()),
                  Tab(text: l10n.tabIntegrations.toUpperCase()),
                  Tab(text: l10n.tabAdvanced.toUpperCase()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        BauhausDesign.space3,
        BauhausDesign.space3,
        BauhausDesign.space3,
        BauhausDesign.space3,
      ),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: BauhausDesign.borderThick),
      ),
      padding: EdgeInsets.zero,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralSettingsTab(),
          _buildPricingRulesTab(),
          _buildIntegrationsTab(),
          _buildAdvancedTab(),
        ],
      ),
    );
  }

  Widget _buildHeaderActionIcon({
    required IconData icon,
    required String tooltip,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        right: BauhausDesign.space2,
        top: BauhausDesign.space2,
        bottom: BauhausDesign.space2,
      ),
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: BauhausDesign.space8 + BauhausDesign.space1,
            height: BauhausDesign.space8 + BauhausDesign.space1,
            decoration: BoxDecoration(
              color: onTap == null ? BauhausDesign.surfaceOffWhite : color,
              border: Border.all(
                  color: _inkBlack, width: BauhausDesign.borderThick),
            ),
            child: Icon(
              icon,
              size: BauhausDesign.fontXl,
              color: BauhausDesign.surfaceWhite,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPanelTitle(String text) {
    return Text(
      text.toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
            color: _inkBlack,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.6,
          ),
    );
  }

  Widget _buildInlineActionButton({
    required String label,
    required VoidCallback? onTap,
    bool isPrimary = false,
  }) {
    final bg = onTap == null
        ? BauhausDesign.surfaceOffWhite
        : (isPrimary ? _accentRed : _panelWhite);
    final textColor = onTap == null
        ? BauhausDesign.textMuted
        : (isPrimary ? BauhausDesign.surfaceWhite : _inkBlack);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space2,
          vertical: BauhausDesign.space2,
        ),
        decoration: BoxDecoration(
          color: bg,
          border:
              Border.all(color: _inkBlack, width: BauhausDesign.borderThick),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
        ),
      ),
    );
  }

  Widget _buildGeneralSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPanelTitle(
              AppLocalizations.of(context)!.generalPricingSettings),
          const SizedBox(height: BauhausDesign.space3),
          _buildSettingsSection(
            AppLocalizations.of(context)!.basicConfiguration,
            [
              _buildDropdownSetting(
                AppLocalizations.of(context)!.defaultCurrency,
                _defaultCurrency,
                ['AUD', 'USD', 'EUR', 'GBP'],
                (value) => setState(() => _defaultCurrency = value!),
                bottomSpacing: BauhausDesign.space2,
              ),
              _buildDropdownSetting(
                AppLocalizations.of(context)!.pricingModel,
                _pricingModel,
                [
                  AppLocalizations.of(context)!.optionNdisStandard,
                  AppLocalizations.of(context)!.optionCustom,
                  AppLocalizations.of(context)!.optionHybrid
                ],
                (value) => setState(() => _pricingModel = value!),
                bottomSpacing: BauhausDesign.space2,
              ),
              _buildDropdownSetting(
                AppLocalizations.of(context)!.roundingMethod,
                _roundingMethod,
                [
                  AppLocalizations.of(context)!.optionNearestCent,
                  AppLocalizations.of(context)!.optionRoundUp,
                  AppLocalizations.of(context)!.optionRoundDown,
                  AppLocalizations.of(context)!.optionNoRounding
                ],
                (value) => setState(() => _roundingMethod = value!),
                bottomSpacing: BauhausDesign.space2,
                labelFieldGap: BauhausDesign.space3,
              ),
              _buildDropdownSetting(
                AppLocalizations.of(context)!.taxCalculation,
                _taxCalculation,
                [
                  AppLocalizations.of(context)!.optionGstInclusive,
                  AppLocalizations.of(context)!.optionGstExclusive
                ],
                (value) => setState(() => _taxCalculation = value!),
                bottomSpacing: BauhausDesign.space2,
              ),
            ],
            innerPadding: BauhausDesign.space3,
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildSettingsSection(
            AppLocalizations.of(context)!.pricingParameters,
            [
              _buildSliderSetting(
                '${AppLocalizations.of(context)!.defaultMarkup} (%)',
                _defaultMarkup,
                0.0,
                50.0,
                (value) => setState(() => _defaultMarkup = value),
              ),
              _buildSliderSetting(
                '${AppLocalizations.of(context)!.maxPriceVariation} (%)',
                _maxPriceVariation,
                0.0,
                100.0,
                (value) => setState(() => _maxPriceVariation = value),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildSettingsSection(
            AppLocalizations.of(context)!.fallbackBaseRateSection,
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.organizationFallbackBaseRate,
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    AppLocalizations.of(context)!.organizationFallbackDesc,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.textMuted,
                            ),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  TextFormField(
                    controller: _fallbackRateController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                            color: _inkBlack, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      hintText: _fallbackBaseRate != null
                          ? _fallbackBaseRate!.toStringAsFixed(2)
                          : AppLocalizations.of(context)!.fallbackRateHint,
                      filled: true,
                      fillColor: _panelWhite,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: _inkBlack,
                          width: BauhausDesign.borderThick,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: _inkBlack,
                          width: BauhausDesign.borderThick,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: _inkBlack,
                          width: BauhausDesign.borderThick,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space3,
                        vertical: BauhausDesign.space2,
                      ),
                      suffixText:
                          AppLocalizations.of(context)!.fallbackCurrencyHint,
                      suffixStyle: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  SizedBox(
                    width: double.infinity,
                    child: _buildInlineActionButton(
                      label: _isSavingFallbackRate
                          ? '${AppLocalizations.of(context)!.save.toUpperCase()}...'
                          : AppLocalizations.of(context)!.save.toUpperCase(),
                      onTap:
                          _isSavingFallbackRate ? null : _saveFallbackBaseRate,
                      isPrimary: true,
                    ),
                  ),
                ],
              ),
              if (_fallbackError != null)
                Padding(
                  padding: const EdgeInsets.only(top: BauhausDesign.space2),
                  child: Text(
                    _fallbackError!,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.error,
                            ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildSettingsSection(
            AppLocalizations.of(context)!.systemBehavior,
            [
              _buildSwitchSetting(
                AppLocalizations.of(context)!.autoUpdatePricing,
                AppLocalizations.of(context)!.autoUpdatePricingDesc,
                _autoUpdatePricing,
                (value) => setState(() => _autoUpdatePricing = value),
              ),
              _buildSwitchSetting(
                AppLocalizations.of(context)!.enablePriceValidation,
                AppLocalizations.of(context)!.enablePriceValidationDesc,
                _enablePriceValidation,
                (value) => setState(() => _enablePriceValidation = value),
              ),
              _buildSwitchSetting(
                AppLocalizations.of(context)!.requireApproval,
                AppLocalizations.of(context)!.requireApprovalDesc,
                _requireApprovalForChanges,
                (value) => setState(() => _requireApprovalForChanges = value),
              ),
              _buildSwitchSetting(
                AppLocalizations.of(context)!.enableBulkOperations,
                AppLocalizations.of(context)!.enableBulkOperationsDesc,
                _enableBulkOperations,
                (value) => setState(() => _enableBulkOperations = value),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRulesTab() {
    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildPanelTitle(
                    AppLocalizations.of(context)!.pricingRulesTitle),
              ),
              _buildHeaderActionIcon(
                icon: Icons.add,
                tooltip: AppLocalizations.of(context)!.addRuleAction,
                onTap: _addNewRule,
                color: _accentRed,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Expanded(
            child: ListView.builder(
              itemCount: _getPricingRules(context).length,
              itemBuilder: (context, index) {
                final rule = _getPricingRules(context)[index];
                return _buildPricingRuleCard(rule, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRuleCard(Map<String, dynamic> rule, int index) {
    final l10n = AppLocalizations.of(context)!;
    final priorityColor = rule['priority'] == l10n.rulePriorityHigh
        ? BauhausDesign.error
        : rule['priority'] == l10n.rulePriorityMedium
            ? BauhausDesign.warning
            : BauhausDesign.success;

    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space2),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: BauhausDesign.borderThick),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: _inkBlack,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space2,
            ),
            child: Text(
              rule['id'],
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        rule['name'],
                        style: BauhausDesign.getTextTheme(context)
                            .bodyLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: _inkBlack,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: priorityColor,
                        border: Border.all(
                          color: _inkBlack,
                          width: BauhausDesign.borderThick,
                        ),
                      ),
                      child: Text(
                        rule['priority'].toString().toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    BauhausSwitch(
                      value: rule['enabled'],
                      onChanged: (value) {
                        setState(() {});
                      },
                      variant: BauhausSwitchVariant.primary,
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  rule['description'],
                  style: BauhausDesign.getTextTheme(context)
                      .bodyMedium
                      ?.copyWith(color: BauhausDesign.textDark),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!
                      .lastModified(rule['lastModified']),
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontWeight: FontWeight.w700,
                          ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Row(
                  children: [
                    Expanded(
                      child: _buildInlineActionButton(
                        label: AppLocalizations.of(context)!.edit.toUpperCase(),
                        onTap: () => _editRule(rule),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: _buildInlineActionButton(
                        label:
                            AppLocalizations.of(context)!.delete.toUpperCase(),
                        onTap: () => _deleteRule(rule['id']),
                        isPrimary: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationsTab() {
    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPanelTitle(AppLocalizations.of(context)!.systemIntegrations),
          const SizedBox(height: BauhausDesign.space3),
          Expanded(
            child: ListView.builder(
              itemCount: _getIntegrationSettings(context).length,
              itemBuilder: (context, index) {
                final integration = _getIntegrationSettings(context)[index];
                return _buildIntegrationCard(integration, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationCard(Map<String, dynamic> integration, int index) {
    final l10n = AppLocalizations.of(context)!;
    final isConnected = integration['status'] == l10n.ruleStatusConnected;
    final statusColor =
        isConnected ? BauhausDesign.success : BauhausDesign.error;

    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space2),
      decoration: BoxDecoration(
        color: _panelWhite,
        border: Border.all(color: _inkBlack, width: BauhausDesign.borderThick),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: _inkBlack,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space2,
            ),
            child: Text(
              AppLocalizations.of(context)!.systemIntegrations.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        integration['name'],
                        style: BauhausDesign.getTextTheme(context)
                            .bodyLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: _inkBlack,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        border: Border.all(
                          color: _inkBlack,
                          width: BauhausDesign.borderThick,
                        ),
                      ),
                      child: Text(
                        integration['status'].toString().toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    BauhausSwitch(
                      value: integration['enabled'],
                      onChanged: (value) {
                        setState(() {});
                      },
                      variant: BauhausSwitchVariant.primary,
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  integration['description'],
                  style: BauhausDesign.getTextTheme(context)
                      .bodyMedium
                      ?.copyWith(color: BauhausDesign.textDark),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!
                      .lastSynced(integration['lastSync']),
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textMuted,
                            fontWeight: FontWeight.w700,
                          ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Row(
                  children: [
                    if (isConnected)
                      Expanded(
                        child: _buildInlineActionButton(
                          label:
                              AppLocalizations.of(context)!.sync.toUpperCase(),
                          onTap: () => _syncIntegration(integration['name']),
                        ),
                      ),
                    if (isConnected)
                      const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: _buildInlineActionButton(
                        label: AppLocalizations.of(context)!
                            .configure
                            .toUpperCase(),
                        onTap: () => _configureIntegration(integration['name']),
                        isPrimary: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPanelTitle(AppLocalizations.of(context)!.advancedConfiguration),
          const SizedBox(height: BauhausDesign.space3),
          _buildSettingsSection(
            AppLocalizations.of(context)!.dataManagement,
            [
              _buildNumberSetting(
                AppLocalizations.of(context)!.priceHistoryRetention,
                _priceHistoryRetention,
                30,
                1095,
                (value) => setState(() => _priceHistoryRetention = value),
              ),
              _buildNumberSetting(
                AppLocalizations.of(context)!.bulkOperationLimit,
                _bulkOperationLimit,
                100,
                10000,
                (value) => setState(() => _bulkOperationLimit = value),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildSettingsSection(
            AppLocalizations.of(context)!.notificationsAndAlerts,
            [
              _buildSwitchSetting(
                AppLocalizations.of(context)!.enableNotifications,
                AppLocalizations.of(context)!.enableNotificationsDesc,
                _enableNotifications,
                (value) => setState(() => _enableNotifications = value),
              ),
              _buildSwitchSetting(
                AppLocalizations.of(context)!.enablePriceHistory,
                AppLocalizations.of(context)!.enablePriceHistoryDesc,
                _enablePriceHistory,
                (value) => setState(() => _enablePriceHistory = value),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildSettingsSection(
            AppLocalizations.of(context)!.systemMaintenance,
            [
              _buildActionButton(
                AppLocalizations.of(context)!.exportConfiguration,
                AppLocalizations.of(context)!.exportConfigurationDesc,
                Icons.download,
                BauhausDesign.primary,
                _exportConfiguration,
              ),
              _buildActionButton(
                AppLocalizations.of(context)!.importConfiguration,
                AppLocalizations.of(context)!.importConfigurationDesc,
                Icons.upload,
                BauhausDesign.success,
                _importConfiguration,
              ),
              _buildActionButton(
                AppLocalizations.of(context)!.resetToDefaults,
                AppLocalizations.of(context)!.resetToDefaultsDesc,
                Icons.restore,
                BauhausDesign.warning,
                _resetToDefaults,
              ),
              _buildActionButton(
                AppLocalizations.of(context)!.clearPriceHistory,
                AppLocalizations.of(context)!.clearPriceHistoryDesc,
                Icons.delete_forever,
                BauhausDesign.error,
                _clearPriceHistory,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children,
      {double innerPadding = BauhausDesign.space3}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border:
                Border.all(color: _inkBlack, width: BauhausDesign.borderThick),
            color: _panelWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: _inkBlack,
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                  vertical: BauhausDesign.space2,
                ),
                child: Text(
                  title.toUpperCase(),
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.surfaceWhite,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(innerPadding),
                child: Column(
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownSetting(String label, String value, List<String> options,
      ValueChanged<String?> onChanged,
      {double bottomSpacing = BauhausDesign.space3,
      double labelFieldGap = BauhausDesign.space3}) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: _inkBlack,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          SizedBox(width: labelFieldGap),
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<String>(
              value: value,
              isDense: true,
              isExpanded: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: _panelWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: _inkBlack,
                    width: BauhausDesign.borderThick,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: _inkBlack,
                    width: BauhausDesign.borderThick,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: _inkBlack,
                    width: BauhausDesign.borderThick,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                  vertical: BauhausDesign.space2,
                ),
              ),
              items: options
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(
                          option,
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: _inkBlack,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ))
                  .toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down, color: _inkBlack),
              dropdownColor: _panelWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: _inkBlack,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              Text(
                value.toStringAsFixed(1),
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: _accentRed,
                    ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) / 1).round(),
            onChanged: onChanged,
            activeColor: _accentRed,
            inactiveColor: BauhausDesign.textMuted.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchSetting(
    String title,
    String description,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            color: _inkBlack,
                            fontWeight: FontWeight.w700,
                          ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  description,
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textMuted,
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
    );
  }

  Widget _buildNumberSetting(
    String label,
    int value,
    int min,
    int max,
    ValueChanged<int> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: _inkBlack,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            flex: 3,
            child: BauhausTextField(
              controller: TextEditingController(text: value.toString())
                ..selection =
                    TextSelection.collapsed(offset: value.toString().length),
              keyboardType: TextInputType.number,
              hintText: '$min - $max',
              onChanged: (text) {
                final newValue = int.tryParse(text);
                if (newValue != null && newValue >= min && newValue <= max) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
      child: Container(
        decoration: BoxDecoration(
          color: _panelWhite,
          border:
              Border.all(color: _inkBlack, width: BauhausDesign.borderThick),
        ),
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          child: Row(
            children: [
              Container(
                width: BauhausDesign.space8 + BauhausDesign.space1,
                height: BauhausDesign.space8 + BauhausDesign.space1,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    color: _inkBlack,
                    width: BauhausDesign.borderThick,
                  ),
                ),
                child: Icon(
                  icon,
                  color: BauhausDesign.surfaceWhite,
                  size: BauhausDesign.iconMd,
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
                            color: _inkBlack,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      description,
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(color: BauhausDesign.textMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              SizedBox(
                width: BauhausDesign.space16 + BauhausDesign.space5 + 2,
                child: _buildInlineActionButton(
                  label: AppLocalizations.of(context)!.configure.toUpperCase(),
                  onTap: onPressed,
                  isPrimary: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Persist configuration changes triggered via the AppBar Save icon.
  ///
  /// Saves General Pricing Settings to the backend and, if applicable,
  /// updates the Fallback Base Rate. The Save icon is disabled while saving,
  /// and user feedback is provided via a SnackBar.
  Future<void> _saveConfiguration() async {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    bool didSave = false;
    try {
      // 1) Save General Pricing Settings
      final generalSettingsPayload = {
        'autoUpdatePricing': _autoUpdatePricing,
        'enablePriceValidation': _enablePriceValidation,
        'requireApprovalForChanges': _requireApprovalForChanges,
        'enableBulkOperations': _enableBulkOperations,
        'enablePriceHistory': _enablePriceHistory,
        'enableNotifications': _enableNotifications,
        'defaultCurrency': _defaultCurrency,
        'pricingModel': _pricingModel,
        'roundingMethod': _roundingMethod,
        'taxCalculation': _taxCalculation,
        'defaultMarkup': _defaultMarkup,
        'maxPriceVariation': _maxPriceVariation,
        'priceHistoryRetention': _priceHistoryRetention,
        'bulkOperationLimit': _bulkOperationLimit,
      };
      final settingsResp = await _api.updateGeneralPricingSettings(
        widget.organizationId,
        generalSettingsPayload,
      );
      if (settingsResp['success'] == true) {
        didSave = true;
        _showSnackBar(settingsResp['message'] ?? l10n.settingsSaved);
      } else {
        // If validation errors come back, surface the first user-friendly message
        final msg = settingsResp['message'] ??
            l10n.failedToSaveSettings(l10n.errorGenericMessage);
        _showSnackBar(msg);
      }

      // Save Fallback Base Rate if present and changed
      final input = _fallbackRateController.text.trim();
      final parsed = double.tryParse(input);
      final shouldSaveFallback = input.isNotEmpty &&
          parsed != null &&
          parsed > 0 &&
          parsed != _fallbackBaseRate;

      if (shouldSaveFallback) {
        await _saveFallbackBaseRate();
        didSave = true;
      }

      if (!didSave) {
        _showSnackBar(AppLocalizations.of(context)!.noChangesToSave);
      }
    } catch (e) {
      _showSnackBar(
          AppLocalizations.of(context)!.failedToSaveSettings(e.toString()));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _resetConfiguration() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.resetConfigurationTitle),
        content: Text(
          AppLocalizations.of(context)!.resetConfigurationConfirm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performReset();
            },
            child: Text(AppLocalizations.of(context)!.reset),
          ),
        ],
      ),
    );
  }

  void _performReset() {
    setState(() {
      _autoUpdatePricing = true;
      _enablePriceValidation = true;
      _requireApprovalForChanges = false;
      _enableBulkOperations = true;
      _enablePriceHistory = true;
      _enableNotifications = true;
      _applyLocalizedDefaults(AppLocalizations.of(context)!);
      _defaultMarkup = 15.0;
      _maxPriceVariation = 20.0;
      _priceHistoryRetention = 365;
      _bulkOperationLimit = 1000;
    });
    _showSnackBar(AppLocalizations.of(context)!.configurationResetSuccess);
  }

  void _addNewRule() {
    _showSnackBar(AppLocalizations.of(context)!.addPricingRuleDialog);
  }

  void _editRule(Map<String, dynamic> rule) {
    _showSnackBar(
        AppLocalizations.of(context)!.editPricingRuleDialog(rule['name']));
  }

  void _deleteRule(String ruleId) {
    // In a real app, this would delete via API
    _showSnackBar(AppLocalizations.of(context)!.pricingRuleDeleted);
  }

  void _syncIntegration(String integrationName) {
    _showSnackBar(
        AppLocalizations.of(context)!.syncingIntegration(integrationName));
  }

  void _configureIntegration(String integrationName) {
    _showSnackBar(AppLocalizations.of(context)!
        .configureIntegrationHint(integrationName));
  }

  void _exportConfiguration() {
    _showSnackBar(AppLocalizations.of(context)!.exportingConfigurationMsg);
  }

  void _importConfiguration() {
    _showSnackBar(AppLocalizations.of(context)!.importConfigurationDialogHint);
  }

  void _resetToDefaults() {
    _resetConfiguration();
  }

  void _clearPriceHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.priceHistoryClearedTitle),
        content: Text(
          AppLocalizations.of(context)!.priceHistoryClearedConfirm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar(
                  AppLocalizations.of(context)!.priceHistoryClearedSuccess);
            },
            style: TextButton.styleFrom(foregroundColor: BauhausDesign.error),
            child: Text(AppLocalizations.of(context)!.clear),
          ),
        ],
      ),
    );
  }

  /// Load the organization's fallback base rate from the backend and update UI.
  Future<void> _loadFallbackBaseRate() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isFallbackLoading = true;
      _fallbackError = null;
    });
    try {
      final rate = await _api.getFallbackBaseRate(widget.organizationId);
      setState(() {
        _fallbackBaseRate = rate;
        if (rate != null) {
          _fallbackRateController.text = rate.toStringAsFixed(2);
        } else {
          // No configured rate (e.g., 404). Keep UI clean and editable.
          _fallbackRateController.text = '';
        }
        _isFallbackLoading = false;
      });
    } catch (e) {
      setState(() {
        _isFallbackLoading = false;
        _fallbackError = l10n.failedLoadFallbackBaseRate(e.toString());
      });
    }
  }

  /// Validate and save the fallback base rate via backend API.
  Future<void> _saveFallbackBaseRate() async {
    final l10n = AppLocalizations.of(context)!;
    final input = _fallbackRateController.text.trim();
    final parsed = double.tryParse(input);
    if (parsed == null || parsed <= 0) {
      setState(() {
        _fallbackError = l10n.validPositiveAmountError;
      });
      return;
    }
    setState(() {
      _isSavingFallbackRate = true;
      _fallbackError = null;
    });
    try {
      final result = await _api.setFallbackBaseRate(
        widget.organizationId,
        parsed,
        widget.adminEmail,
      );
      if (result['success'] == true) {
        setState(() {
          _fallbackBaseRate = parsed;
          _isSavingFallbackRate = false;
        });
        _showSnackBar(result['message'] ?? l10n.fallbackRateUpdatedSuccess);
      } else {
        setState(() {
          _isSavingFallbackRate = false;
          _fallbackError =
              result['message'] ?? l10n.failedUpdateFallbackBaseRate;
        });
      }
    } catch (e) {
      setState(() {
        _isSavingFallbackRate = false;
        _fallbackError = l10n.errorUpdatingFallbackBaseRate(e.toString());
      });
    }
  }

  void _showSnackBar(String message,
      {bool isSuccess = false, bool isError = false}) {
    if (!mounted) return;

    final color = isError
        ? BauhausDesign.error
        : isSuccess
            ? BauhausDesign.success
            : BauhausDesign.textDark;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.surfaceWhite,
              ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        ),
        margin: const EdgeInsets.all(BauhausDesign.space4),
      ),
    );
  }
}
