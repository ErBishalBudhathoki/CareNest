import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/providers/pricing_settings_providers.dart';
import 'package:carenest/providers/fallback_pricing_providers.dart';
import 'package:carenest/widgets/fallback_price_dialog.dart';

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

  final List<Map<String, dynamic>> _pricingRules = [
    {
      'id': 'RULE001',
      'name': 'NDIS Price Cap Validation',
      'description': 'Ensures prices do not exceed NDIS price guide limits',
      'enabled': true,
      'priority': 'High',
      'lastModified': '2024-01-15',
    },
    {
      'id': 'RULE002',
      'name': 'Minimum Rate Validation',
      'description':
          'Validates minimum hourly rates for different service types',
      'enabled': true,
      'priority': 'Medium',
      'lastModified': '2024-01-12',
    },
    {
      'id': 'RULE003',
      'name': 'Geographic Loading Rules',
      'description': 'Applies geographic loading based on service location',
      'enabled': false,
      'priority': 'Low',
      'lastModified': '2024-01-10',
    },
  ];

  final List<Map<String, dynamic>> _integrationSettings = [
    {
      'name': 'NDIS Price Guide API',
      'description': 'Automatic synchronization with NDIS price guide updates',
      'status': 'Connected',
      'lastSync': '2024-01-15 09:30:00',
      'enabled': true,
    },
    {
      'name': 'Accounting System',
      'description': 'Integration with external accounting software',
      'status': 'Disconnected',
      'lastSync': 'Never',
      'enabled': false,
    },
    {
      'name': 'CRM System',
      'description': 'Customer relationship management system integration',
      'status': 'Connected',
      'lastSync': '2024-01-15 08:15:00',
      'enabled': true,
    },
  ];

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

  Widget _buildModernHeader() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            return Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                          ),
                          color: const Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bulk Operations',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 24 : 28,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!isSmallScreen) ...[
                              const SizedBox(height: 8),
                              Text(
                                'Manage and optimize your service pricing across different regions and categories',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]
                          ],
                        ),
                      ),
                      if (!isSmallScreen)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'System Active',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (isSmallScreen) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Import and export data in batch operations',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'System Active',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:
            const EdgeInsetsDirectional.only(start: 20, bottom: 56, end: 20),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.settings,
              size: 20,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              'Pricing Configuration',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.colorPrimary,
                AppColors.colorPrimary.withOpacity(0.1),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -50,
                top: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Consumer(
          builder: (context, ref, _) {
            final vm = ref.watch(pricingSettingsViewModelProvider);
            return IconButton(
              icon: const Icon(Icons.save, color: Colors.white),
              onPressed: (_isLoading || vm.isLoading)
                  ? null
                  : () async {
                      try {
                        // Map current UI values into the ViewModel before saving
                        final vmRead =
                            ref.read(pricingSettingsViewModelProvider);
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
                          _showSnackBar('Settings saved');
                        } else if (vmRead.errorMessage != null) {
                          _showSnackBar(vmRead.errorMessage!);
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
                        _showSnackBar('Failed to save configuration: $e');
                      }
                    },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: _resetConfiguration,
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        isScrollable: true,
        tabs: const [
          Tab(text: 'General Settings'),
          Tab(text: 'Pricing Rules'),
          Tab(text: 'Integrations'),
          Tab(text: 'Advanced'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'General Pricing Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            'Basic Configuration',
            [
              _buildDropdownSetting(
                'Default Currency',
                _defaultCurrency,
                ['AUD', 'USD', 'EUR', 'GBP'],
                (value) => setState(() => _defaultCurrency = value!),
                bottomSpacing: 8,
              ),
              _buildDropdownSetting(
                'Pricing Model',
                _pricingModel,
                ['NDIS Standard', 'Custom', 'Hybrid'],
                (value) => setState(() => _pricingModel = value!),
                bottomSpacing: 8,
              ),
              _buildDropdownSetting(
                'Rounding Method',
                _roundingMethod,
                [
                  'Round to nearest cent',
                  'Round up',
                  'Round down',
                  'No rounding'
                ],
                (value) => setState(() => _roundingMethod = value!),
                bottomSpacing: 8,
                labelFieldGap: 12,
              ),
              _buildDropdownSetting(
                'Tax Calculation',
                _taxCalculation,
                ['GST Inclusive', 'GST Exclusive'],
                (value) => setState(() => _taxCalculation = value!),
                bottomSpacing: 8,
              ),
            ],
            innerPadding: 12,
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            'Pricing Parameters',
            [
              _buildSliderSetting(
                'Default Markup (%)',
                _defaultMarkup,
                0.0,
                50.0,
                (value) => setState(() => _defaultMarkup = value),
              ),
              _buildSliderSetting(
                'Max Price Variation (%)',
                _maxPriceVariation,
                0.0,
                100.0,
                (value) => setState(() => _maxPriceVariation = value),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            'Fallback Base Rate',
            [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Organization Fallback Base Rate',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Used when no client or organization-specific price exists.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              controller: _fallbackRateController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                suffixText: 'AUD',
                                hintText: _fallbackBaseRate != null
                                    ? _fallbackBaseRate!.toStringAsFixed(2)
                                    : 'e.g., 35.00',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: _isSavingFallbackRate
                                ? null
                                : _saveFallbackBaseRate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isSavingFallbackRate
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_fallbackError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _fallbackError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            'System Behavior',
            [
              _buildSwitchSetting(
                'Auto-update Pricing',
                'Automatically update prices when NDIS guide changes',
                _autoUpdatePricing,
                (value) => setState(() => _autoUpdatePricing = value),
              ),
              _buildSwitchSetting(
                'Enable Price Validation',
                'Validate prices against configured rules',
                _enablePriceValidation,
                (value) => setState(() => _enablePriceValidation = value),
              ),
              _buildSwitchSetting(
                'Require Approval for Changes',
                'Require manager approval for price changes',
                _requireApprovalForChanges,
                (value) => setState(() => _requireApprovalForChanges = value),
              ),
              _buildSwitchSetting(
                'Enable Bulk Operations',
                'Allow bulk import/export and updates',
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Pricing Rules',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _addNewRule,
                icon: const Icon(Icons.add),
                label: const Text('Add Rule'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _pricingRules.length,
              itemBuilder: (context, index) {
                final rule = _pricingRules[index];
                return _buildPricingRuleCard(rule, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRuleCard(Map<String, dynamic> rule, int index) {
    final priorityColor = rule['priority'] == 'High'
        ? Colors.red
        : rule['priority'] == 'Medium'
            ? Colors.orange
            : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: rule['enabled'] ? Colors.green[200]! : Colors.grey[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  rule['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  rule['priority'],
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Switch(
                value: rule['enabled'],
                onChanged: (value) {
                  setState(() {
                    _pricingRules[index]['enabled'] = value;
                  });
                },
                activeThumbColor: AppColors.colorPrimary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            rule['description'],
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Last modified: ${rule['lastModified']}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _editRule(rule),
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Edit'),
              ),
              TextButton.icon(
                onPressed: () => _deleteRule(rule['id']),
                icon: const Icon(Icons.delete, size: 16),
                label: const Text('Delete'),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3, end: 0);
  }

  Widget _buildIntegrationsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Integrations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _integrationSettings.length,
              itemBuilder: (context, index) {
                final integration = _integrationSettings[index];
                return _buildIntegrationCard(integration, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationCard(Map<String, dynamic> integration, int index) {
    final isConnected = integration['status'] == 'Connected';
    final statusColor = isConnected ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  integration['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isConnected ? Icons.check_circle : Icons.error,
                      size: 12,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      integration['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Switch(
                value: integration['enabled'],
                onChanged: (value) {
                  setState(() {
                    _integrationSettings[index]['enabled'] = value;
                  });
                },
                activeThumbColor: AppColors.colorPrimary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            integration['description'],
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Last sync: ${integration['lastSync']}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              if (isConnected)
                TextButton.icon(
                  onPressed: () => _syncIntegration(integration['name']),
                  icon: const Icon(Icons.sync, size: 16),
                  label: const Text('Sync Now'),
                )
              else
                TextButton.icon(
                  onPressed: () => _configureIntegration(integration['name']),
                  icon: const Icon(Icons.settings, size: 16),
                  label: const Text('Configure'),
                ),
            ],
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideY(begin: 0.3, end: 0);
  }

  Widget _buildAdvancedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Advanced Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            'Data Management',
            [
              _buildNumberSetting(
                'Price History Retention (days)',
                _priceHistoryRetention,
                30,
                1095,
                (value) => setState(() => _priceHistoryRetention = value),
              ),
              _buildNumberSetting(
                'Bulk Operation Limit',
                _bulkOperationLimit,
                100,
                10000,
                (value) => setState(() => _bulkOperationLimit = value),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            'Notifications & Alerts',
            [
              _buildSwitchSetting(
                'Enable Notifications',
                'Receive notifications for pricing changes and alerts',
                _enableNotifications,
                (value) => setState(() => _enableNotifications = value),
              ),
              _buildSwitchSetting(
                'Enable Price History',
                'Maintain detailed history of all price changes',
                _enablePriceHistory,
                (value) => setState(() => _enablePriceHistory = value),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsSection(
            'System Maintenance',
            [
              _buildActionButton(
                'Export Configuration',
                'Export current pricing configuration to file',
                Icons.download,
                Colors.blue,
                _exportConfiguration,
              ),
              _buildActionButton(
                'Import Configuration',
                'Import pricing configuration from file',
                Icons.upload,
                Colors.green,
                _importConfiguration,
              ),
              _buildActionButton(
                'Reset to Defaults',
                'Reset all settings to default values',
                Icons.restore,
                Colors.orange,
                _resetToDefaults,
              ),
              _buildActionButton(
                'Clear Price History',
                'Remove all historical pricing data',
                Icons.delete_forever,
                Colors.red,
                _clearPriceHistory,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children,
      {double innerPadding = 16}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(innerPadding),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownSetting(String label, String value, List<String> options,
      ValueChanged<String?> onChanged,
      {double bottomSpacing = 16, double labelFieldGap = 12}) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
          SizedBox(width: labelFieldGap),
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<String>(
              initialValue: value,
              isDense: true,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: options
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(
                          option,
                          style: const TextStyle(color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
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
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                value.toStringAsFixed(1),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorPrimary,
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
            activeColor: AppColors.colorPrimary,
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
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.colorPrimary,
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
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              initialValue: value.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
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
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onPressed,
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
        _showSnackBar('No changes to save');
      }
    } catch (e) {
      _showSnackBar('Failed to save configuration: $e');
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
        title: const Text('Reset Configuration'),
        content: const Text(
          'Are you sure you want to reset all settings to their default values? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performReset();
            },
            child: const Text('Reset'),
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
    _showSnackBar('Configuration reset to defaults');
  }

  void _addNewRule() {
    _showSnackBar('Add new pricing rule dialog would open here');
  }

  void _editRule(Map<String, dynamic> rule) {
    _showSnackBar('Edit rule: ${rule['name']}');
  }

  void _deleteRule(String ruleId) {
    setState(() {
      _pricingRules.removeWhere((rule) => rule['id'] == ruleId);
    });
    _showSnackBar('Pricing rule deleted');
  }

  void _syncIntegration(String integrationName) {
    _showSnackBar('Syncing $integrationName...');
  }

  void _configureIntegration(String integrationName) {
    _showSnackBar('Configure $integrationName integration');
  }

  void _exportConfiguration() {
    _showSnackBar('Exporting configuration...');
  }

  void _importConfiguration() {
    _showSnackBar('Import configuration dialog would open here');
  }

  void _resetToDefaults() {
    _resetConfiguration();
  }

  void _clearPriceHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Price History'),
        content: const Text(
          'Are you sure you want to clear all price history data? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Price history cleared');
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear'),
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
