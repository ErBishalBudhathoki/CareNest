import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/providers/pricing_settings_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class PricingConfigurationView extends StatefulWidget {
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
  _PricingConfigurationViewState createState() =>
      _PricingConfigurationViewState();
}

class _PricingConfigurationViewState extends State<PricingConfigurationView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  // Configuration settings
  bool _autoUpdatePricing = true;
  bool _enablePriceValidation = true;
  bool _requireApprovalForChanges = false;
  bool _enableBulkOperations = true;
  bool _enablePriceHistory = true;
  bool _enableNotifications = true;

  String _defaultCurrency = 'AUD';
  String _pricingModel = 'NDIS Standard';
  String _roundingMethod = 'Round to nearest cent';
  String _taxCalculation = 'GST Inclusive';

  double _defaultMarkup = 15.0;
  double _maxPriceVariation = 20.0;
  int _priceHistoryRetention = 365;
  int _bulkOperationLimit = 1000;

  // Fallback base rate state
  final ApiMethod _api = ApiMethod();
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
        'name': 'NDIS Price Cap Validation',
        'description': 'Ensures prices do not exceed NDIS price guide limits',
        'enabled': true,
        'priority': l10n.rulePriorityHigh,
        'lastModified': '2024-01-15',
      },
      {
        'id': 'RULE002',
        'name': 'Minimum Rate Validation',
        'description':
            'Validates minimum hourly rates for different service types',
        'enabled': true,
        'priority': l10n.rulePriorityMedium,
        'lastModified': '2024-01-12',
      },
      {
        'id': 'RULE003',
        'name': 'Geographic Loading Rules',
        'description': 'Applies geographic loading based on service location',
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
        'name': 'NDIS Price Guide API',
        'description':
            'Automatic synchronization with NDIS price guide updates',
        'status': l10n.ruleStatusConnected,
        'lastSync': '2024-01-15 09:30:00',
        'enabled': true,
      },
      {
        'name': 'Accounting System',
        'description': 'Integration with external accounting software',
        'status': l10n.ruleStatusDisconnected,
        'lastSync': l10n.ruleNeverSync,
        'enabled': false,
      },
      {
        'name': 'CRM System',
        'description': 'Customer relationship management system integration',
        'status': l10n.ruleStatusConnected,
        'lastSync': '2024-01-15 08:15:00',
        'enabled': true,
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadFallbackBaseRate();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fallbackRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return SliverAppBar(
      expandedHeight: 120, // Reduced height as per Bauhaus minimalist headers
      floating: false,
      pinned: true,
      centerTitle: false,
      backgroundColor: BauhausDesign.surfaceWhite,
      surfaceTintColor: BauhausDesign.surfaceWhite,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: BauhausDesign.textDark),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.only(
            start: BauhausDesign.space4, bottom: 56, end: BauhausDesign.space4),
        title: Text(
          AppLocalizations.of(context)!.pricingConfigurationTitle,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        background: Container(
          color: BauhausDesign.surfaceWhite,
        ),
      ),
      actions: [
        Consumer(
          builder: (context, ref, _) {
            final vm = ref.watch(pricingSettingsViewModelProvider);
            return BauhausActionButton(
              text: AppLocalizations.of(context)!.save,
              icon: Icons.save,
              isLoading: _isLoading || vm.isLoading,
              variant: BauhausActionVariant.primary,
              onPressed: () async {
                try {
                  // Map current UI values into the ViewModel before saving
                  final vmRead = ref.read(pricingSettingsViewModelProvider);
                  vmRead.updateSettings(
                    defaultCurrency: _defaultCurrency,
                    pricingModel: _pricingModel,
                    roundingMethod: _roundingMethod,
                    taxCalculation: _taxCalculation,
                    defaultMarkup: _defaultMarkup,
                    maxPriceVariation: _maxPriceVariation,
                    priceHistoryRetention: _priceHistoryRetention,
                    bulkOperationLimit: _bulkOperationLimit,
                    autoUpdatePricing: _autoUpdatePricing,
                    enablePriceValidation: _enablePriceValidation,
                    requireApprovalForChanges: _requireApprovalForChanges,
                    enableBulkOperations: _enableBulkOperations,
                    enablePriceHistory: _enablePriceHistory,
                    enableNotifications: _enableNotifications,
                  );

                  // Save general pricing settings via ViewModel
                  await vmRead.save(widget.organizationId);

                  if (vmRead.saveSucceeded) {
                    _showSnackBar(AppLocalizations.of(context)!.settingsSaved,
                        isSuccess: true);
                  } else if (vmRead.errorMessage != null) {
                    _showSnackBar(vmRead.errorMessage!, isError: true);
                  }

                  // Preserve fallback base rate save if changed
                  final input = _fallbackRateController.text.trim();
                  final parsed = double.tryParse(input);
                  final shouldSaveFallback = input.isNotEmpty &&
                      parsed != null &&
                      parsed > 0 &&
                      parsed != _fallbackBaseRate;

                  if (shouldSaveFallback) {
                    await _saveFallbackBaseRate();
                  }
                } catch (e) {
                  _showSnackBar(
                      AppLocalizations.of(context)!
                          .failedToSaveSettings(e.toString()),
                      isError: true);
                }
              },
            );
          },
        ),
        const SizedBox(width: BauhausDesign.space2),
        BauhausIconButton(
          onPressed: _resetConfiguration,
          icon: Icons.refresh,
          tooltip: AppLocalizations.of(context)!.resetToDefaultsTooltip,
          variant: BauhausActionVariant.secondary,
        ),
        const SizedBox(width: BauhausDesign.space3),
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: BauhausDesign.primary,
        indicatorWeight: 3,
        labelColor: BauhausDesign.primary,
        unselectedLabelColor: BauhausDesign.textMuted,
        labelStyle: BauhausDesign.getTextTheme(context)
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        isScrollable: true,
        tabs: [
          Tab(text: AppLocalizations.of(context)!.tabGeneralSettings),
          Tab(text: AppLocalizations.of(context)!.tabPricingRules),
          Tab(text: AppLocalizations.of(context)!.tabIntegrations),
          Tab(text: AppLocalizations.of(context)!.tabAdvanced),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return BauhausCard(
      margin: const EdgeInsets.all(BauhausDesign.space4),
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

  Widget _buildGeneralSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.generalPricingSettings,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space4),
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
          const SizedBox(height: BauhausDesign.space4),
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
          const SizedBox(height: BauhausDesign.space4),
          _buildSettingsSection(
            AppLocalizations.of(context)!.fallbackBaseRateSection,
            [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .organizationFallbackBaseRate,
                          style: BauhausDesign.getTextTheme(context)
                              .labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          AppLocalizations.of(context)!
                              .organizationFallbackDesc,
                          style: BauhausDesign.getTextTheme(context)
                              .bodySmall
                              ?.copyWith(
                                color: BauhausDesign.textMuted,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space4),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                          child: BauhausTextField(
                            controller: _fallbackRateController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            hintText: _fallbackBaseRate != null
                                ? _fallbackBaseRate!.toStringAsFixed(2)
                                : AppLocalizations.of(context)!
                                    .fallbackRateHint,
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.all(BauhausDesign.space3),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .fallbackCurrencyHint,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space2),
                        BauhausActionButton(
                          text: AppLocalizations.of(context)!.save,
                          isLoading: _isSavingFallbackRate,
                          onPressed: _isSavingFallbackRate
                              ? null
                              : _saveFallbackBaseRate,
                          variant: BauhausActionVariant.primary,
                          isSmall: true,
                        ),
                      ],
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
          const SizedBox(height: BauhausDesign.space4),
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
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.pricingRulesTitle,
                style:
                    BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                        ),
              ),
              const Spacer(),
              BauhausActionButton(
                onPressed: _addNewRule,
                icon: Icons.add,
                text: AppLocalizations.of(context)!.addRuleAction,
                variant: BauhausActionVariant.primary,
                isSmall: true,
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
    final priorityVariant = rule['priority'] == l10n.rulePriorityHigh
        ? BauhausChipVariant.error
        : rule['priority'] == l10n.rulePriorityMedium
            ? BauhausChipVariant.warning
            : BauhausChipVariant.success;

    return BauhausCard(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
      borderColor:
          rule['enabled'] ? BauhausDesign.success.withOpacity(0.3) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  rule['name'],
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textDark,
                          ),
                ),
              ),
              BauhausChip(
                text: rule['priority'],
                variant: priorityVariant,
                isSmall: true,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Switch(
                value: rule['enabled'],
                onChanged: (value) {
                  // Note: Logic for toggling rules is currently local only
                  setState(() {
                    // Update the local state if it was stored in a proper state object
                    // In a real app, this would update the backend
                  });
                },
                activeColor: BauhausDesign.primary,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            rule['description'],
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!
                    .lastModified(rule['lastModified']),
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _editRule(rule),
                icon: Icon(Icons.edit, size: 16, color: BauhausDesign.primary),
                label: Text(AppLocalizations.of(context)!.edit,
                    style: TextStyle(color: BauhausDesign.primary)),
              ),
              TextButton.icon(
                onPressed: () => _deleteRule(rule['id']),
                icon: Icon(Icons.delete, size: 16, color: BauhausDesign.error),
                label: Text(AppLocalizations.of(context)!.delete,
                    style: TextStyle(color: BauhausDesign.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationsTab() {
    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.systemIntegrations,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textDark,
                ),
          ),
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
    final statusVariant =
        isConnected ? BauhausChipVariant.success : BauhausChipVariant.error;

    return BauhausCard(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
      borderColor: isConnected ? BauhausDesign.success.withOpacity(0.3) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  integration['name'],
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textDark,
                          ),
                ),
              ),
              BauhausChip(
                text: integration['status'],
                icon: isConnected ? Icons.check_circle : Icons.error,
                variant: statusVariant,
                isSmall: true,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Switch(
                value: integration['enabled'],
                onChanged: (value) {
                  setState(() {
                    // Update local state if it was stored in a proper state object
                  });
                },
                activeColor: BauhausDesign.primary,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            integration['description'],
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!
                    .lastSynced(integration['lastSync']),
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
              ),
              const Spacer(),
              if (isConnected)
                TextButton.icon(
                  onPressed: () => _syncIntegration(integration['name']),
                  icon:
                      Icon(Icons.sync, size: 16, color: BauhausDesign.primary),
                  label: Text(AppLocalizations.of(context)!.sync,
                      style: TextStyle(color: BauhausDesign.primary)),
                ),
              TextButton.icon(
                onPressed: () => _configureIntegration(integration['name']),
                icon: Icon(Icons.settings,
                    size: 16, color: BauhausDesign.textDark),
                label: Text(AppLocalizations.of(context)!.configure,
                    style: TextStyle(color: BauhausDesign.textDark)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.advancedConfiguration,
            style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space4),
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
          const SizedBox(height: BauhausDesign.space4),
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
          const SizedBox(height: BauhausDesign.space4),
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
        Text(
          title,
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        BauhausCard(
          padding: EdgeInsets.all(innerPadding),
          child: Column(
            children: children,
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
                    fontWeight: FontWeight.w500,
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
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                  vertical: BauhausDesign.space2,
                ),
              ),
              items: options
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(
                          option,
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                        ),
                      ))
                  .toList(),
              onChanged: onChanged,
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
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Spacer(),
              Text(
                value.toStringAsFixed(1),
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.primary,
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
            activeColor: BauhausDesign.primary,
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
                            fontWeight: FontWeight.w500,
                          ),
                ),
                const SizedBox(height: 4),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: BauhausDesign.primary,
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
                    fontWeight: FontWeight.w500,
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
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: BauhausCard(
        padding: EdgeInsets.zero,
        borderColor: BauhausDesign.neutral.withOpacity(0.2),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          title: Text(
            title,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          subtitle: Text(
            description,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              size: 14, color: BauhausDesign.textMuted),
          onTap: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd)),
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
        _showSnackBar(settingsResp['message'] ?? 'Settings saved');
      } else {
        // If validation errors come back, surface the first user-friendly message
        final msg = settingsResp['message'] ?? 'Failed to save settings';
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
      _defaultCurrency = 'AUD';
      _pricingModel = 'NDIS Standard';
      _roundingMethod = 'Round to nearest cent';
      _taxCalculation = 'GST Inclusive';
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
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)!.clear),
          ),
        ],
      ),
    );
  }

  /// Load the organization's fallback base rate from the backend and update UI.
  Future<void> _loadFallbackBaseRate() async {
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
        _fallbackError = 'Failed to load fallback base rate: $e';
      });
    }
  }

  /// Validate and save the fallback base rate via backend API.
  Future<void> _saveFallbackBaseRate() async {
    final input = _fallbackRateController.text.trim();
    final parsed = double.tryParse(input);
    if (parsed == null || parsed <= 0) {
      setState(() {
        _fallbackError = 'Please enter a valid positive amount.';
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
        _showSnackBar(result['message'] ?? 'Fallback base rate updated');
      } else {
        setState(() {
          _isSavingFallbackRate = false;
          _fallbackError =
              result['message'] ?? 'Failed to update fallback base rate';
        });
      }
    } catch (e) {
      setState(() {
        _isSavingFallbackRate = false;
        _fallbackError = 'Error updating fallback base rate: $e';
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
