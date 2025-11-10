import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/viewmodels/automatic_invoice_viewmodel.dart';
import 'package:carenest/app/features/invoice/viewmodels/employee_selection_viewmodel.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer.dart';
import 'package:carenest/app/features/invoice/services/send_invoice_service.dart';
import 'dart:io';

/// Automatic Invoice Generation View
/// Modern UI for one-click invoice generation for all employees and clients
class AutomaticInvoiceGenerationView extends ConsumerStatefulWidget {
  final String? organizationId;
  final String? organizationName;
  final String? email;

  const AutomaticInvoiceGenerationView({
    Key? key,
    this.organizationId,
    this.organizationName,
    this.email,
  }) : super(key: key);

  @override
  ConsumerState<AutomaticInvoiceGenerationView> createState() =>
      _AutomaticInvoiceGenerationViewState();
}

class _AutomaticInvoiceGenerationViewState
    extends ConsumerState<AutomaticInvoiceGenerationView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? _organizationId;
  bool _includeExpenses = true;
  bool _applyTax = true;
  double _taxRate = 0.00;
  bool _validatePrices = true;
  bool _allowPriceCapOverride = false;
  bool _includeDetailedPricingInfo = true;
  bool _useAdminBankDetails = false;
  bool _useSelectedEmployees = false; // false => All employees, true => Selected employees only
  final Set<String> _selectedEmployeeEmails = {};
  // Local state for date range selection
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadOrganizationId();
    _loadUseAdminPreference();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  Future<void> _loadOrganizationId() async {
    if (widget.organizationId != null) {
      _organizationId = widget.organizationId;
      return;
    }

    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init();
    _organizationId = sharedPrefs.getString('organizationId');

    if (mounted) {
      setState(() {});
    }
  }

  /// Loads the persisted preference for using admin bank details.
  /// Defaults to false if no value is stored.
  Future<void> _loadUseAdminPreference() async {
    try {
      final prefs = SharedPreferencesUtils();
      await prefs.init();
      final stored = prefs.getBool(SharedPreferencesUtils.kUseAdminBankDetailsKey);
      if (stored != null && mounted) {
        setState(() => _useAdminBankDetails = stored);
      }
    } catch (e) {
      debugPrint('Failed to load useAdminBankDetails preference: $e');
    }
  }

  /// Persists the current admin/employee bank detail preference.
  Future<void> _persistUseAdminPreference(bool value) async {
    try {
      final prefs = SharedPreferencesUtils();
      await prefs.init();
      await prefs.setBool(SharedPreferencesUtils.kUseAdminBankDetailsKey, value);
    } catch (e) {
      debugPrint('Failed to persist useAdminBankDetails preference: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernInvoiceDesign.background,
      appBar: _buildAppBar(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: _buildBody(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ModernInvoiceDesign.primary,
      foregroundColor: ModernInvoiceDesign.textOnPrimary,
      elevation: 0,
      title: Text(
        'Automatic Invoice Generation',
        style: ModernInvoiceDesign.headlineMedium.copyWith(
          color: ModernInvoiceDesign.textOnPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    if (_organizationId == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(automaticInvoiceViewModelProvider);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: ModernInvoiceDesign.space6),
              _buildConfigurationCard(),
              const SizedBox(height: ModernInvoiceDesign.space6),
              if (state.isLoading) ..._buildProgressSection(state),
              if (!state.isLoading && !state.isCompleted)
                _buildGenerateButton(),
              if (state.isCompleted) _buildResultsSection(state),
              if (state.errorMessage.isNotEmpty) _buildErrorSection(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.surface,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
        boxShadow: ModernInvoiceDesign.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernInvoiceDesign.space3),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: ModernInvoiceDesign.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'One-Click Invoice Generation',
                      style: ModernInvoiceDesign.headlineSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space1),
                    Text(
                      widget.organizationName ?? 'Organization',
                      style: ModernInvoiceDesign.bodyMedium.copyWith(
                        color: ModernInvoiceDesign.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          Container(
            padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              border: Border.all(
                color: ModernInvoiceDesign.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: ModernInvoiceDesign.primary,
                  size: 20,
                ),
                const SizedBox(width: ModernInvoiceDesign.space3),
                Expanded(
                  child: Text(
                    'This will automatically generate invoices for all employees and their assigned clients in your organization. No manual selection required.',
                    style: ModernInvoiceDesign.bodyMedium.copyWith(
                      color: ModernInvoiceDesign.primary,
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
      padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.surface,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
        boxShadow: ModernInvoiceDesign.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice Configuration',
            style: ModernInvoiceDesign.headlineSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: ModernInvoiceDesign.space5),
          _buildConfigOption(
            'Include Expenses',
            'Add expense items to invoices',
            _includeExpenses,
            (value) => setState(() => _includeExpenses = value),
            Icons.receipt_long,
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildConfigOption(
            'Apply Tax',
            'Include tax calculations',
            _applyTax,
            (value) => setState(() => _applyTax = value),
            Icons.calculate,
          ),
          if (_applyTax) ...[
            const SizedBox(height: ModernInvoiceDesign.space4),
            _buildTaxRateSlider(),
          ],
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildConfigOption(
            'Validate Prices',
            'Check prices against NDIS price caps',
            _validatePrices,
            (value) => setState(() => _validatePrices = value),
            Icons.verified,
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildConfigOption(
            'Allow Price Cap Override',
            'Allow prices above NDIS caps',
            _allowPriceCapOverride,
            (value) => setState(() => _allowPriceCapOverride = value),
            Icons.warning,
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildConfigOption(
            'Detailed Pricing Info',
            'Include comprehensive pricing details',
            _includeDetailedPricingInfo,
            (value) => setState(() => _includeDetailedPricingInfo = value),
            Icons.info,
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildEmployeesSelection(),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildBankDetailsSelection(),
          const SizedBox(height: ModernInvoiceDesign.space4),
          _buildInvoicePeriodSelection(),
        ],
      ),
    );
  }

  /// Builds the invoice period selection UI, allowing the user to choose a
  /// start and end date for filtering line items and expenses.
  Widget _buildInvoicePeriodSelection() {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.background,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        border: Border.all(color: ModernInvoiceDesign.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernInvoiceDesign.space2),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.surfaceVariant,
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                ),
                child: Icon(
                  Icons.calendar_today_rounded,
                  color: ModernInvoiceDesign.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Expanded(
                child: Text(
                  'Invoice Period',
                  style: ModernInvoiceDesign.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    initialDateRange: (_selectedStartDate != null &&
                            _selectedEndDate != null)
                        ? DateTimeRange(
                            start: _selectedStartDate!,
                            end: _selectedEndDate!,
                          )
                        : null,
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedStartDate = picked.start;
                      _selectedEndDate = picked.end;
                    });
                  }
                },
                icon: const Icon(Icons.date_range_rounded),
                label: const Text('Select Period'),
                style: TextButton.styleFrom(
                  foregroundColor: ModernInvoiceDesign.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space3),
          Row(
            children: [
              Expanded(
                child: Text(
                  (_selectedStartDate != null && _selectedEndDate != null)
                      ? '${_formatDate(_selectedStartDate!)}  —  ${_formatDate(_selectedEndDate!)}'
                      : 'No period selected (using default)',
                  style: ModernInvoiceDesign.bodySmall.copyWith(
                    color: ModernInvoiceDesign.textSecondary,
                  ),
                ),
              ),
              if (_selectedStartDate != null && _selectedEndDate != null)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedStartDate = null;
                      _selectedEndDate = null;
                    });
                  },
                  child: const Text('Clear'),
                ),
            ],
          ),
        ],
      ),
    );
  }
  
  /// Employees inclusion/selection UI for intuitive control
  Widget _buildEmployeesSelection() {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.background,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        border: Border.all(color: ModernInvoiceDesign.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernInvoiceDesign.space2),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.surfaceVariant,
                  borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                ),
                child: Icon(
                  Icons.people_alt,
                  color: ModernInvoiceDesign.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Text(
                'Employees',
                style: ModernInvoiceDesign.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space3),
          RadioListTile<bool>(
            title: Text('All Employees', style: ModernInvoiceDesign.bodyMedium),
            value: false,
            groupValue: _useSelectedEmployees,
            onChanged: (value) {
              setState(() {
                _useSelectedEmployees = value!;
              });
            },
            activeColor: ModernInvoiceDesign.primary,
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile<bool>(
            title: Text('Select Employees', style: ModernInvoiceDesign.bodyMedium),
            value: true,
            groupValue: _useSelectedEmployees,
            onChanged: (value) async {
              setState(() {
                _useSelectedEmployees = value!;
              });
              // Prompt employee picker immediately for a smooth flow
              await _openEmployeeSelectionSheet();
            },
            activeColor: ModernInvoiceDesign.primary,
            contentPadding: EdgeInsets.zero,
          ),
          if (_useSelectedEmployees) ...[
            const SizedBox(height: ModernInvoiceDesign.space2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedEmployeeEmails.isEmpty
                        ? 'No employees selected'
                        : '${_selectedEmployeeEmails.length} selected',
                    style: ModernInvoiceDesign.bodySmall.copyWith(
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _openEmployeeSelectionSheet,
                  icon: const Icon(Icons.edit),
                  label: const Text('Choose Employees'),
                  style: TextButton.styleFrom(
                    foregroundColor: ModernInvoiceDesign.primary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildBankDetailsSelection() {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.background,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        border: Border.all(color: ModernInvoiceDesign.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernInvoiceDesign.space2),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.surfaceVariant,
                  borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: ModernInvoiceDesign.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Text(
                'Bank Details',
                style: ModernInvoiceDesign.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space3),
          RadioListTile<bool>(
            title: Text('Employee Bank Details', 
              style: ModernInvoiceDesign.bodyMedium),
            value: false,
            groupValue: _useAdminBankDetails,
            onChanged: (value) {
              setState(() => _useAdminBankDetails = value!);
              _persistUseAdminPreference(_useAdminBankDetails);
            },
            activeColor: ModernInvoiceDesign.primary,
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile<bool>(
            title: Text('Admin Bank Details', 
              style: ModernInvoiceDesign.bodyMedium),
            value: true,
            groupValue: _useAdminBankDetails,
            onChanged: (value) {
              setState(() => _useAdminBankDetails = value!);
              _persistUseAdminPreference(_useAdminBankDetails);
            },
            activeColor: ModernInvoiceDesign.primary,
            contentPadding: EdgeInsets.zero,
          ),
        ],
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
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
      decoration: BoxDecoration(
        color: value
            ? ModernInvoiceDesign.primary.withValues(alpha: 0.05)
            : ModernInvoiceDesign.background,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        border: Border.all(
          color: value
              ? ModernInvoiceDesign.primary.withValues(alpha: 0.3)
              : ModernInvoiceDesign.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(ModernInvoiceDesign.space2),
            decoration: BoxDecoration(
              color: value
                  ? ModernInvoiceDesign.primary.withValues(alpha: 0.1)
                  : ModernInvoiceDesign.surfaceVariant,
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
            ),
            child: Icon(
              icon,
              color: value
                  ? ModernInvoiceDesign.primary
                  : ModernInvoiceDesign.textSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: ModernInvoiceDesign.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ModernInvoiceDesign.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: ModernInvoiceDesign.space1),
                Text(
                  subtitle,
                  style: ModernInvoiceDesign.bodySmall.copyWith(
                    color: ModernInvoiceDesign.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: ModernInvoiceDesign.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildTaxRateSlider() {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.background,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        border: Border.all(color: ModernInvoiceDesign.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax Rate',
                style: ModernInvoiceDesign.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(_taxRate * 100).toStringAsFixed(1)}%',
                style: ModernInvoiceDesign.bodyLarge.copyWith(
                  color: ModernInvoiceDesign.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space2),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: ModernInvoiceDesign.primary,
              inactiveTrackColor:
                  ModernInvoiceDesign.primary.withValues(alpha: 0.3),
              thumbColor: ModernInvoiceDesign.primary,
              overlayColor: ModernInvoiceDesign.primary.withValues(alpha: 0.2),
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
      Container(
        padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
        decoration: BoxDecoration(
          color: ModernInvoiceDesign.surface,
          borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
          boxShadow: ModernInvoiceDesign.shadowMd,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: ModernInvoiceDesign.space6,
                  height: ModernInvoiceDesign.space6,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ModernInvoiceDesign.primary,
                    ),
                  ),
                ),
                const SizedBox(width: ModernInvoiceDesign.space4),
                Expanded(
                  child: Text(
                    'Generating Invoices...',
                    style: ModernInvoiceDesign.headlineSmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: ModernInvoiceDesign.space5),
            LinearProgressIndicator(
              value: state.progress,
              backgroundColor:
                  ModernInvoiceDesign.primary.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                ModernInvoiceDesign.primary,
              ),
            ),
            const SizedBox(height: ModernInvoiceDesign.space3),
            Text(
              state.currentStep,
              style: ModernInvoiceDesign.bodyMedium.copyWith(
                color: ModernInvoiceDesign.textSecondary,
              ),
            ),
            const SizedBox(height: ModernInvoiceDesign.space2),
            Text(
              '${(state.progress * 100).toStringAsFixed(0)}% Complete',
              style: ModernInvoiceDesign.bodySmall.copyWith(
                color: ModernInvoiceDesign.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: ModernInvoiceDesign.space6),
    ];
  }

  Widget _buildGenerateButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ModernInvoiceDesign.primary,
            ModernInvoiceDesign.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
        boxShadow: [
          BoxShadow(
            color: ModernInvoiceDesign.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: _generateInvoices,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: ModernInvoiceDesign.textOnPrimary,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
          ),
        ),
        icon: const Icon(Icons.auto_awesome, size: 24),
        label: Text(
          'Generate All Invoices',
          style: ModernInvoiceDesign.headlineSmall.copyWith(
            color: ModernInvoiceDesign.textOnPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildResultsSection(AutomaticInvoiceState state) {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.surface,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
        boxShadow: ModernInvoiceDesign.shadowMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernInvoiceDesign.space3),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.success.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: ModernInvoiceDesign.success,
                  size: 28,
                ),
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Generation Complete!',
                      style: ModernInvoiceDesign.headlineSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ModernInvoiceDesign.success,
                      ),
                    ),
                    const SizedBox(height: ModernInvoiceDesign.space1),
                    Text(
                      'All invoices have been generated successfully',
                      style: ModernInvoiceDesign.bodyMedium.copyWith(
                        color: ModernInvoiceDesign.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space5),
          _buildStatCard(
              'Total Employees', state.totalEmployees.toString(), Icons.people),
          const SizedBox(height: ModernInvoiceDesign.space3),
          _buildStatCard(
              'Total Clients', state.totalClients.toString(), Icons.business),
          const SizedBox(height: ModernInvoiceDesign.space3),
          _buildStatCard(
              'Valid Pairs', state.validPairs.toString(), Icons.link),
          const SizedBox(height: ModernInvoiceDesign.space3),
          _buildStatCard('Generated Invoices',
              state.generatedPdfPaths.length.toString(), Icons.description),
          const SizedBox(height: ModernInvoiceDesign.space5),
          if (state.generatedPdfPaths.isNotEmpty) ...[
            _buildGeneratedPdfsSection(state.generatedPdfPaths),
            const SizedBox(height: ModernInvoiceDesign.space5),
          ],
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ModernInvoiceDesign.primary,
                  ModernInvoiceDesign.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: ModernInvoiceDesign.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: ModernInvoiceDesign.neutral900.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                onTap: _resetGeneration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18, horizontal: ModernInvoiceDesign.space6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(ModernInvoiceDesign.space2),
                        decoration: BoxDecoration(
                          color: ModernInvoiceDesign.neutral50
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusMd),
                        ),
                        child: Icon(
                          Icons.refresh_rounded,
                          color: ModernInvoiceDesign.neutral50,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: ModernInvoiceDesign.space3),
                      Text(
                        'Generate Again',
                        style: ModernInvoiceDesign.bodyLarge.copyWith(
                          color: ModernInvoiceDesign.neutral50,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.background,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        border: Border.all(color: ModernInvoiceDesign.border),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: ModernInvoiceDesign.primary,
            size: 24,
          ),
          const SizedBox(width: ModernInvoiceDesign.space4),
          Expanded(
            child: Text(
              label,
              style: ModernInvoiceDesign.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: ModernInvoiceDesign.headlineSmall.copyWith(
              color: ModernInvoiceDesign.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection(AutomaticInvoiceState state) {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.error.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
        border:
            Border.all(color: ModernInvoiceDesign.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: ModernInvoiceDesign.error,
                size: 28,
              ),
              const SizedBox(width: ModernInvoiceDesign.space4),
              Expanded(
                child: Text(
                  'Generation Failed',
                  style: ModernInvoiceDesign.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ModernInvoiceDesign.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: ModernInvoiceDesign.space4),
          Text(
            state.errorMessage,
            style: ModernInvoiceDesign.bodyMedium.copyWith(
              color: ModernInvoiceDesign.error,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _resetGeneration,
              style: ElevatedButton.styleFrom(
                backgroundColor: ModernInvoiceDesign.error,
                foregroundColor: ModernInvoiceDesign.neutral50,
                padding: const EdgeInsets.symmetric(
                    vertical: ModernInvoiceDesign.space4),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateInvoices() async {
    if (_organizationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Organization ID not found'),
          backgroundColor: ModernInvoiceDesign.error,
        ),
      );
      return;
    }

    // If using selected employees, ensure at least one is chosen
    if (_useSelectedEmployees && _selectedEmployeeEmails.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one employee'),
          backgroundColor: ModernInvoiceDesign.error,
        ),
      );
      return;
    }

    // Validate tax settings: allow 0% tax, only block negatives
    if (_applyTax && (_taxRate < 0.0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tax rate cannot be negative when tax is applied'),
          backgroundColor: ModernInvoiceDesign.error,
        ),
      );
      return;
    }

    // Validate date range when both dates are provided
    if (_selectedStartDate != null && _selectedEndDate != null) {
      if (_selectedEndDate!.isBefore(_selectedStartDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('End date must be on or after start date'),
            backgroundColor: ModernInvoiceDesign.error,
          ),
        );
        return;
      }
    }

    final viewModel = ref.read(automaticInvoiceViewModelProvider.notifier);

    await viewModel.generateAutomaticInvoices(
      context,
      organizationId: _organizationId!,
      validatePrices: _validatePrices,
      allowPriceCapOverride: _allowPriceCapOverride,
      includeDetailedPricingInfo: _includeDetailedPricingInfo,
      applyTax: _applyTax,
      taxRate: _taxRate,
      includeExpenses: _includeExpenses,
      useAdminBankDetails: _useAdminBankDetails,
      selectedEmployeeEmails:
          _useSelectedEmployees ? _selectedEmployeeEmails.toList() : null,
      startDate: _selectedStartDate,
      endDate: _selectedEndDate,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
      ),
      builder: (ctx) {
        return Consumer(
          builder: (context, ref, _) {
            final s = ref.watch(provider);
            return Padding(
              padding: EdgeInsets.only(
                left: ModernInvoiceDesign.space4,
                right: ModernInvoiceDesign.space4,
                top: ModernInvoiceDesign.space4,
                bottom: ModernInvoiceDesign.space4 +
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people_alt, color: ModernInvoiceDesign.primary),
                      const SizedBox(width: ModernInvoiceDesign.space3),
                      Text(
                        'Select Employees',
                        style: ModernInvoiceDesign.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: ModernInvoiceDesign.space3),
                  if (s.isLoading && s.employees.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (s.employees.isEmpty)
                    Text(
                      'No employees found',
                      style: ModernInvoiceDesign.bodyMedium,
                    )
                  else
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: s.employees.length,
                        itemBuilder: (context, index) {
                          final emp = s.employees[index];
                          final isChecked = emp.isSelected ||
                              _selectedEmployeeEmails.contains(emp.email);
                          return CheckboxListTile(
                            title: Text(emp.name),
                            subtitle: Text(emp.email),
                            value: isChecked,
                            activeColor: ModernInvoiceDesign.primary,
                            onChanged: (val) {
                              ref.read(provider.notifier).toggleEmployeeSelection(emp.id);
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: ModernInvoiceDesign.space3),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
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
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Confirm Selection'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ModernInvoiceDesign.primary,
                        foregroundColor: ModernInvoiceDesign.textOnPrimary,
                        padding: const EdgeInsets.symmetric(
                          vertical: ModernInvoiceDesign.space4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              ModernInvoiceDesign.radiusLg),
                        ),
                      ),
                    ),
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
  }

  Widget _buildGeneratedPdfsSection(List<String> generatedPdfs) {
    return Container(
      padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ModernInvoiceDesign.surface,
            ModernInvoiceDesign.surface.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusXl),
        border: Border.all(
          color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ModernInvoiceDesign.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: ModernInvoiceDesign.neutral900.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: ModernInvoiceDesign.space4,
                vertical: ModernInvoiceDesign.space3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                  ModernInvoiceDesign.primary.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(ModernInvoiceDesign.space2),
                  decoration: BoxDecoration(
                    color: ModernInvoiceDesign.primary,
                    borderRadius:
                        BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                    boxShadow: [
                      BoxShadow(
                        color:
                            ModernInvoiceDesign.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.file_present_rounded,
                    color: ModernInvoiceDesign.neutral50,
                    size: 24,
                  ),
                ),
                const SizedBox(width: ModernInvoiceDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Generated Invoices',
                        style: ModernInvoiceDesign.headlineSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ModernInvoiceDesign.primary,
                        ),
                      ),
                      Text(
                        '${generatedPdfs.length} invoice${generatedPdfs.length != 1 ? 's' : ''} ready',
                        style: ModernInvoiceDesign.bodySmall.copyWith(
                          color: ModernInvoiceDesign.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: ModernInvoiceDesign.space6),
          ...generatedPdfs.asMap().entries.map((entry) {
            final index = entry.key;
            final pdfPath = entry.value;
            final fileName = pdfPath.split('/').last;

            return Container(
              margin: index < generatedPdfs.length - 1
                  ? const EdgeInsets.only(bottom: ModernInvoiceDesign.space4)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.neutral50,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                border: Border.all(
                  color: ModernInvoiceDesign.border.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        ModernInvoiceDesign.neutral900.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusXl),
                  onTap: () => _viewPdf(pdfPath),
                  child: Padding(
                    padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
                    child: Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.all(ModernInvoiceDesign.space3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ModernInvoiceDesign.success
                                    .withValues(alpha: 0.15),
                                ModernInvoiceDesign.success
                                    .withValues(alpha: 0.08),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                                ModernInvoiceDesign.radiusLg),
                          ),
                          child: Icon(
                            Icons.picture_as_pdf_rounded,
                            color: ModernInvoiceDesign.success,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: ModernInvoiceDesign.space4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fileName,
                                style: ModernInvoiceDesign.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ModernInvoiceDesign.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                  height: ModernInvoiceDesign.space1),
                              Row(
                                children: [
                                  Icon(
                                    Icons.touch_app_rounded,
                                    size: 14,
                                    color: ModernInvoiceDesign.textSecondary,
                                  ),
                                  const SizedBox(
                                      width: ModernInvoiceDesign.space1),
                                  Flexible(
                                    child: Text(
                                      'Tap to view PDF',
                                      style: ModernInvoiceDesign.bodySmall
                                          .copyWith(
                                        color:
                                            ModernInvoiceDesign.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            // Check if we have enough space for both buttons side by side
                            final hasSpaceForBothButtons =
                                constraints.maxWidth > 120;

                            if (hasSpaceForBothButtons) {
                              // Desktop/tablet layout - buttons side by side
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildActionButton(
                                    icon: Icons.visibility_rounded,
                                    onPressed: () => _viewPdf(pdfPath),
                                    tooltip: 'View PDF',
                                  ),
                                  const SizedBox(
                                      width: ModernInvoiceDesign.space2),
                                  _buildActionButton(
                                    icon: Icons.send_rounded,
                                    onPressed: () => _sendInvoices(pdfPath),
                                    tooltip: 'Send Invoice',
                                  ),
                                ],
                              );
                            } else {
                              // Mobile layout - single button with popup menu
                              return PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'view') {
                                    _viewPdf(pdfPath);
                                  } else if (value == 'send') {
                                    _sendInvoices(pdfPath);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'view',
                                    child: Row(
                                      children: [
                                        Icon(Icons.visibility_rounded,
                                            size: 18),
                                        SizedBox(
                                            width: ModernInvoiceDesign.space2),
                                        Text('View PDF'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'send',
                                    child: Row(
                                      children: [
                                        Icon(Icons.send_rounded, size: 18),
                                        SizedBox(
                                            width: ModernInvoiceDesign.space2),
                                        Text('Send Invoice'),
                                      ],
                                    ),
                                  ),
                                ],
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ModernInvoiceDesign.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(
                                        ModernInvoiceDesign.radiusMd),
                                  ),
                                  child: IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: ModernInvoiceDesign.primary,
                                      size: 20,
                                    ),
                                    tooltip: 'Actions',
                                    padding: const EdgeInsets.all(
                                        ModernInvoiceDesign.space2),
                                  ),
                                ),
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
          }).toList(),
        ],
      ),
    );
  }

  void _viewPdf(String pdfPath) {
    if (File(pdfPath).existsSync()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewPage(pdfPath: pdfPath),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF file not found'),
          backgroundColor: ModernInvoiceDesign.error,
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
    return Container(
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: ModernInvoiceDesign.primary,
          size: 20,
        ),
        tooltip: tooltip,
        padding: const EdgeInsets.all(ModernInvoiceDesign.space2),
      ),
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
