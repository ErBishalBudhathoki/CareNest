import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/viewmodels/automatic_invoice_viewmodel.dart';
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
  double _taxRate = 0.10;
  bool _validatePrices = true;
  bool _allowPriceCapOverride = false;
  bool _includeDetailedPricingInfo = true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadOrganizationId();
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
}
