import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/client_portal/views/client_invoice_detail_view.dart';
import 'package:carenest/app/features/invoice/viewmodels/payment_viewmodel.dart';
import 'package:carenest/app/features/invoice/viewmodels/stripe_dashboard_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/user_messages.dart';
import 'package:carenest/app/shared/widgets/app_snack_bars.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// In-app Stripe revenue dashboard for organisation billing staff.
///
/// Read-only overview of the linked Stripe account (health, balance, payouts,
/// revenue, payments, refunds/disputes), plus a dev-gated refund action.
/// Opened from Payment Settings' "View Stripe Dashboard" button.
class StripeDashboardView extends ConsumerStatefulWidget {
  const StripeDashboardView({super.key});

  @override
  ConsumerState<StripeDashboardView> createState() =>
      _StripeDashboardViewState();
}

class _StripeDashboardViewState extends ConsumerState<StripeDashboardView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final orgId = _resolveOrganizationId();
      if (orgId != null) _invalidateAll(orgId);
    }
  }

  String? _resolveOrganizationId() {
    final fromOrg = ref.read(organizationProvider).currentOrganization?.id;
    if (fromOrg != null && fromOrg.trim().isNotEmpty) return fromOrg.trim();
    try {
      final fromProvider = ref.read(app_providers.organizationIdProvider);
      if (fromProvider != null && fromProvider.trim().isNotEmpty) {
        return fromProvider.trim();
      }
    } catch (_) {}
    try {
      final fromPrefs = ref
          .read(app_providers.sharedPreferencesProvider)
          .getOrganizationId();
      if (fromPrefs != null && fromPrefs.trim().isNotEmpty) {
        return fromPrefs.trim();
      }
    } catch (_) {}
    return null;
  }

  void _invalidateAll(String organizationId) {
    ref.invalidate(stripeDashboardOverviewProvider(organizationId));
    ref.invalidate(stripeDashboardBalanceProvider(organizationId));
    ref.invalidate(stripeDashboardPayoutsProvider(organizationId));
    ref.invalidate(stripeDashboardRevenueProvider(organizationId));
    ref.invalidate(stripeDashboardPaymentsProvider(organizationId));
    ref.invalidate(stripeDashboardRiskProvider(organizationId));
  }

  Future<void> _refresh(String organizationId) async {
    _invalidateAll(organizationId);
    try {
      await ref.read(stripeDashboardOverviewProvider(organizationId).future);
    } catch (_) {
      if (mounted) {
        showErrorSnack(
          context,
          AppLocalizations.of(context)!.stripeDashboardRefreshFailed,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final organizationId = _resolveOrganizationId();

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          l10n.stripeDashboardTitle,
          style: BauhausDesign.getTextTheme(
            context,
          ).displaySmall?.copyWith(color: BauhausDesign.textDark),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(color: BauhausDesign.neutral, height: 2.0),
        ),
      ),
      body: organizationId == null
          ? Center(
              child: Text(
                l10n.stripeDashboardRefreshFailed,
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
              ),
            )
          : RefreshIndicator(
              color: BauhausDesign.secondary,
              onRefresh: () => _refresh(organizationId),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.stripeDashboardSubtitle,
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildOverview(context, organizationId),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildBalance(context, organizationId),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildRevenue(context, organizationId),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildPayments(context, organizationId),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildPayouts(context, organizationId),
                    const SizedBox(height: BauhausDesign.space4),
                    _buildRisk(context, organizationId),
                  ],
                ),
              ),
            ),
    );
  }

  // ---------- shared widgets ----------

  Widget _sectionCard({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          child,
        ],
      ),
    );
  }

  Widget _badge(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Text(
        text,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
          color: BauhausDesign.textDark,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _loadingBox() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(BauhausDesign.space4),
        child: CircularProgressIndicator(color: BauhausDesign.secondary),
      ),
    );
  }

  Widget _errorBox(BuildContext context, Object error, VoidCallback onRetry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          friendlyStripeError(error),
          style: BauhausDesign.getTextTheme(
            context,
          ).bodySmall?.copyWith(color: BauhausDesign.error),
        ),
        const SizedBox(height: BauhausDesign.space2),
        InkWell(
          onTap: onRetry,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space2,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
            ),
            child: Text(
              AppLocalizations.of(context)!.retryButton,
              style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _money(dynamic amount, [String currency = 'AUD']) {
    final value = double.tryParse('$amount') ?? 0;
    return '$currency ${value.toStringAsFixed(2)}';
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
      case 'succeeded':
        return BauhausDesign.success;
      case 'partial':
      case 'pending':
      case 'in_transit':
        return BauhausDesign.warning;
      case 'overdue':
      case 'failed':
      case 'needs_response':
      case 'lost':
        return BauhausDesign.error;
      default:
        return BauhausDesign.surfaceOffWhite;
    }
  }

  String _statusLabel(AppLocalizations l10n, String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return l10n.stripePaid;
      case 'partial':
        return l10n.stripePartial;
      case 'pending':
        return l10n.stripePendingStatus;
      case 'overdue':
        return l10n.stripeOverdue;
      case 'refunded':
        return l10n.stripeRefunded;
      default:
        return status.toUpperCase();
    }
  }

  // ---------- section 1: account health ----------

  Widget _buildOverview(BuildContext context, String organizationId) {
    final l10n = AppLocalizations.of(context)!;
    final overview = ref.watch(stripeDashboardOverviewProvider(organizationId));
    return overview.when(
      loading: () => _sectionCard(
        context: context,
        title: l10n.stripeAccountHealth,
        child: _loadingBox(),
      ),
      error: (e, _) => _sectionCard(
        context: context,
        title: l10n.stripeAccountHealth,
        child: _errorBox(
          context,
          e,
          () => ref.invalidate(stripeDashboardOverviewProvider(organizationId)),
        ),
      ),
      data: (data) {
        final charges = data['chargesEnabled'] == true;
        final payouts = data['payoutsEnabled'] == true;
        final details = data['detailsSubmitted'] == true;
        final requirements =
            (data['requirementsDue'] as List?)?.cast<Map>() ?? [];
        return _sectionCard(
          context: context,
          title: l10n.stripeAccountHealth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((data['businessName'] as String?)?.isNotEmpty == true)
                Text(
                  '${data['businessName']}',
                  style: BauhausDesign.getTextTheme(context).titleMedium
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              if ((data['email'] as String?)?.isNotEmpty == true)
                Text(
                  '${data['email']}',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                ),
              const SizedBox(height: BauhausDesign.space3),
              Wrap(
                spacing: BauhausDesign.space2,
                runSpacing: BauhausDesign.space2,
                children: [
                  _badge(
                    context,
                    charges
                        ? l10n.stripeChargesEnabled
                        : l10n.stripeChargesDisabled,
                    charges ? BauhausDesign.success : BauhausDesign.error,
                  ),
                  _badge(
                    context,
                    payouts
                        ? l10n.stripePayoutsEnabled
                        : l10n.stripePayoutsDisabled,
                    payouts ? BauhausDesign.success : BauhausDesign.warning,
                  ),
                  _badge(
                    context,
                    details
                        ? l10n.stripeDetailsDone
                        : l10n.stripeDetailsPending,
                    details ? BauhausDesign.success : BauhausDesign.warning,
                  ),
                ],
              ),
              if (requirements.isNotEmpty) ...[
                const SizedBox(height: BauhausDesign.space3),
                Text(
                  l10n.stripeRequirementsTitle,
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                for (final req in requirements)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 16,
                          color: BauhausDesign.warning,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${req['label'] ?? req['code']}',
                            style: BauhausDesign.getTextTheme(context).bodySmall
                                ?.copyWith(color: BauhausDesign.textDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: BauhausDesign.space2),
                InkWell(
                  onTap: () => _relaunchOnboarding(organizationId),
                  child: Container(
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: BauhausDesign.secondary,
                      border: Border.all(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                      boxShadow: const [BauhausDesign.shadowHardSm],
                    ),
                    child: Text(
                      l10n.stripeCompleteVerification,
                      style: BauhausDesign.getTextTheme(context).labelLarge
                          ?.copyWith(
                            color: BauhausDesign.surfaceLight,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                ),
              ] else ...[
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  l10n.stripeRequirementsNone,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<void> _relaunchOnboarding(String organizationId) async {
    try {
      final url = await ref
          .read(paymentViewModelProvider.notifier)
          .createOnboardingLink(organizationId);
      final uri = Uri.tryParse(url);
      if (uri == null ||
          !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch Stripe URL');
      }
      if (mounted) {
        showInfoSnack(
          context,
          AppLocalizations.of(context)!.stripeVerificationLaunched,
        );
      }
    } catch (e) {
      if (mounted) showErrorSnack(context, friendlyStripeError(e));
    }
  }

  // ---------- section 2: balance ----------

  Widget _buildBalance(BuildContext context, String organizationId) {
    final l10n = AppLocalizations.of(context)!;
    final balance = ref.watch(stripeDashboardBalanceProvider(organizationId));
    final payouts = ref.watch(stripeDashboardPayoutsProvider(organizationId));
    return _sectionCard(
      context: context,
      title: l10n.stripeBalance,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          balance.when(
            loading: () => _loadingBox(),
            error: (e, _) => _errorBox(
              context,
              e,
              () => ref.invalidate(
                stripeDashboardBalanceProvider(organizationId),
              ),
            ),
            data: (data) => Column(
              children: [
                _balanceRow(
                  context,
                  l10n.stripeAvailable,
                  data['available'],
                  BauhausDesign.success,
                ),
                const SizedBox(height: BauhausDesign.space2),
                _balanceRow(
                  context,
                  l10n.stripePending,
                  data['pending'],
                  BauhausDesign.warning,
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          payouts.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (data) {
              final list = (data['payouts'] as List?) ?? [];
              final next = list.cast<Map?>().firstWhere(
                (p) =>
                    p?['status'] == 'pending' || p?['status'] == 'in_transit',
                orElse: () => null,
              );
              if (next == null) {
                return Text(
                  l10n.stripeNoPayouts,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                );
              }
              return Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceOffWhite,
                  border: Border.all(color: BauhausDesign.neutral, width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule, color: BauhausDesign.secondary),
                    const SizedBox(width: BauhausDesign.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.stripeNextPayout,
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  color: BauhausDesign.textMuted,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            _money(next['amount'], '${next['currency']}'),
                            style: BauhausDesign.getTextTheme(context)
                                .titleMedium
                                ?.copyWith(
                                  color: BauhausDesign.textDark,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ],
                      ),
                    ),
                    _badge(
                      context,
                      '${next['status']}'.toUpperCase(),
                      BauhausDesign.warning,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _balanceRow(
    BuildContext context,
    String label,
    dynamic entries,
    Color color,
  ) {
    final list = (entries as List?) ?? [];
    final aud = list.cast<Map?>().firstWhere(
      (e) => '${e?['currency']}'.toUpperCase() == 'AUD',
      orElse: () => list.isNotEmpty ? list.first : null,
    );
    final currency = aud == null ? 'AUD' : '${aud['currency']}'.toUpperCase();
    final amount = aud == null ? 0 : aud['amount'];
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Text(
            label,
            style: BauhausDesign.getTextTheme(
              context,
            ).bodyMedium?.copyWith(color: BauhausDesign.textDark),
          ),
        ),
        Text(
          _money(amount, currency),
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  // ---------- section 3: revenue chart ----------

  Widget _buildRevenue(BuildContext context, String organizationId) {
    final l10n = AppLocalizations.of(context)!;
    final revenue = ref.watch(stripeDashboardRevenueProvider(organizationId));
    return revenue.when(
      loading: () => _sectionCard(
        context: context,
        title: l10n.stripeRevenue30d,
        child: _loadingBox(),
      ),
      error: (e, _) => _sectionCard(
        context: context,
        title: l10n.stripeRevenue30d,
        child: _errorBox(
          context,
          e,
          () => ref.invalidate(stripeDashboardRevenueProvider(organizationId)),
        ),
      ),
      data: (data) {
        final series = (data['series'] as List? ?? []).cast<Map>();
        final maxY = series.fold<double>(
          0,
          (m, e) => (double.tryParse('${e['total']}') ?? 0) > m
              ? (double.tryParse('${e['total']}') ?? 0)
              : m,
        );
        return _sectionCard(
          context: context,
          title: l10n.stripeRevenue30d,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _money(data['total'], '${data['currency'] ?? 'AUD'}'),
                style: BauhausDesign.getTextTheme(context).displaySmall
                    ?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              Text(
                '${data['invoiceCount'] ?? 0} ${l10n.stripeRevenueInvoices}',
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
              ),
              const SizedBox(height: BauhausDesign.space3),
              SizedBox(
                height: 180,
                child: BarChart(
                  BarChartData(
                    maxY: maxY <= 0 ? 10 : maxY * 1.15,
                    barTouchData: BarTouchData(enabled: true),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            final i = value.toInt();
                            if (i < 0 || i >= series.length || i % 5 != 0) {
                              return const SizedBox.shrink();
                            }
                            final day = '${series[i]['date']}'.split('-');
                            return Text(
                              '${day[2]}/${day[1]}',
                              style: const TextStyle(fontSize: 9),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: [
                      for (var i = 0; i < series.length; i++)
                        BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY:
                                  double.tryParse('${series[i]['total']}') ?? 0,
                              color: BauhausDesign.secondary,
                              width: 6,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------- section 4: recent payments (+ dev refund) ----------

  Widget _buildPayments(BuildContext context, String organizationId) {
    final l10n = AppLocalizations.of(context)!;
    final payments = ref.watch(stripeDashboardPaymentsProvider(organizationId));
    final overview = ref.watch(stripeDashboardOverviewProvider(organizationId));
    final refundsEnabled = overview.asData?.value['refundsEnabled'] == true;
    return payments.when(
      loading: () => _sectionCard(
        context: context,
        title: l10n.stripeRecentPayments,
        child: _loadingBox(),
      ),
      error: (e, _) => _sectionCard(
        context: context,
        title: l10n.stripeRecentPayments,
        child: _errorBox(
          context,
          e,
          () => ref.invalidate(stripeDashboardPaymentsProvider(organizationId)),
        ),
      ),
      data: (data) {
        final list = data;
        if (list.isEmpty) {
          return _sectionCard(
            context: context,
            title: l10n.stripeRecentPayments,
            child: Text(
              l10n.stripeNoPayments,
              style: BauhausDesign.getTextTheme(
                context,
              ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
            ),
          );
        }
        return _sectionCard(
          context: context,
          title: l10n.stripeRecentPayments,
          child: Column(
            children: [
              for (final payment in list)
                _paymentRow(context, organizationId, payment, refundsEnabled),
            ],
          ),
        );
      },
    );
  }

  Widget _paymentRow(
    BuildContext context,
    String organizationId,
    Map payment,
    bool refundsEnabled,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final canRefund =
        refundsEnabled &&
        (payment['status'] == 'paid' || payment['status'] == 'partial') &&
        (double.tryParse('${payment['paidAmount']}') ?? 0) > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space2),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${payment['invoiceNumber']} · ${payment['clientName']}',
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              _badge(
                context,
                _statusLabel(l10n, '${payment['status']}'),
                _statusColor('${payment['status']}'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${l10n.stripePaid}: ${_money(payment['paidAmount'])} · '
                  '${l10n.stripeStatus}: ${_money(payment['balanceDue'])}',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                ),
              ),
              Text(
                _money(payment['totalAmount']),
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          if (canRefund) ...[
            const SizedBox(height: BauhausDesign.space2),
            InkWell(
              onTap: () => _showRefundDialog(
                context,
                organizationId,
                '${payment['invoiceId']}',
                '${payment['invoiceNumber']}',
                double.tryParse('${payment['paidAmount']}') ?? 0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                  vertical: BauhausDesign.space2,
                ),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceLight,
                  border: Border.all(color: BauhausDesign.error, width: 2),
                ),
                child: Text(
                  l10n.stripeRefund,
                  style: BauhausDesign.getTextTheme(context).labelMedium
                      ?.copyWith(
                        color: BauhausDesign.error,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showRefundDialog(
    BuildContext context,
    String organizationId,
    String invoiceId,
    String invoiceNumber,
    double paidAmount,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        title: Text('${l10n.stripeRefundTitle} $invoiceNumber'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.stripePaid}: ${_money(paidAmount)}',
              style: BauhausDesign.getTextTheme(
                dialogContext,
              ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
            ),
            const SizedBox(height: BauhausDesign.space2),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: BauhausDesign.inputDecoration(
                l10n.stripeRefundAmountHint,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.stripeRefundCancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.error,
              foregroundColor: BauhausDesign.surfaceWhite,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.stripeRefundConfirm),
          ),
        ],
      ),
    );
    final raw = controller.text.trim();
    controller.dispose();
    if (confirmed != true || !mounted) return;
    final amount = raw.isEmpty ? null : double.tryParse(raw);
    if (raw.isNotEmpty && (amount == null || amount <= 0)) {
      showErrorSnack(context, l10n.stripeRefundFailed);
      return;
    }
    try {
      await ref
          .read(stripeDashboardViewModelProvider.notifier)
          .issueRefund(
            organizationId: organizationId,
            invoiceId: invoiceId,
            amount: amount,
          );
      if (mounted) showSuccessSnack(context, l10n.stripeRefundIssued);
    } catch (e) {
      if (mounted) showErrorSnack(context, friendlyStripeError(e));
    }
  }

  // ---------- section 5: payout history ----------

  Widget _buildPayouts(BuildContext context, String organizationId) {
    final l10n = AppLocalizations.of(context)!;
    final payouts = ref.watch(stripeDashboardPayoutsProvider(organizationId));
    return payouts.when(
      loading: () => _sectionCard(
        context: context,
        title: l10n.stripePayoutHistory,
        child: _loadingBox(),
      ),
      error: (e, _) => _sectionCard(
        context: context,
        title: l10n.stripePayoutHistory,
        child: _errorBox(
          context,
          e,
          () => ref.invalidate(stripeDashboardPayoutsProvider(organizationId)),
        ),
      ),
      data: (data) {
        final list = (data['payouts'] as List? ?? []).cast<Map>();
        final bank = data['bankLabel'] as String?;
        return _sectionCard(
          context: context,
          title: l10n.stripePayoutHistory,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (bank != null)
                Text(
                  '${l10n.stripeBankLabel}: $bank',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                ),
              if (bank != null) const SizedBox(height: BauhausDesign.space2),
              if (list.isEmpty)
                Text(
                  l10n.stripeNoPayouts,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                ),
              for (final payout in list)
                Container(
                  margin: const EdgeInsets.only(bottom: BauhausDesign.space2),
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _money(payout['amount'], '${payout['currency']}'),
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(
                                    color: BauhausDesign.textDark,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            if (payout['arrivalDate'] != null)
                              Text(
                                '${payout['arrivalDate']}'.split('T').first,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: BauhausDesign.textMuted),
                              ),
                            if (payout['failureMessage'] != null)
                              Text(
                                '${payout['failureMessage']}',
                                style: BauhausDesign.getTextTheme(context)
                                    .bodySmall
                                    ?.copyWith(color: BauhausDesign.error),
                              ),
                          ],
                        ),
                      ),
                      _badge(
                        context,
                        '${payout['status']}'.toUpperCase(),
                        _statusColor('${payout['status']}'),
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

  // ---------- section 6: refunds & disputes ----------

  Widget _buildRisk(BuildContext context, String organizationId) {
    final l10n = AppLocalizations.of(context)!;
    final risk = ref.watch(stripeDashboardRiskProvider(organizationId));
    return risk.when(
      loading: () => _sectionCard(
        context: context,
        title: l10n.stripeRiskTitle,
        child: _loadingBox(),
      ),
      error: (e, _) => _sectionCard(
        context: context,
        title: l10n.stripeRiskTitle,
        child: _errorBox(
          context,
          e,
          () => ref.invalidate(stripeDashboardRiskProvider(organizationId)),
        ),
      ),
      data: (data) {
        final refunds = (data['refunds'] as List? ?? []).cast<Map>();
        final disputes = (data['disputes'] as List? ?? []).cast<Map>();
        if (refunds.isEmpty && disputes.isEmpty) {
          return _sectionCard(
            context: context,
            title: l10n.stripeRiskTitle,
            child: Text(
              l10n.stripeRiskEmpty,
              style: BauhausDesign.getTextTheme(
                context,
              ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
            ),
          );
        }
        return _sectionCard(
          context: context,
          title: l10n.stripeRiskTitle,
          child: Column(
            children: [
              for (final item in [...disputes, ...refunds])
                _riskRow(context, item),
            ],
          ),
        );
      },
    );
  }

  Widget _riskRow(BuildContext context, Map item) {
    final l10n = AppLocalizations.of(context)!;
    final isDispute = item['kind'] == 'dispute';
    final invoiceId = item['invoiceId'] as String?;
    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space2),
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isDispute ? Icons.gavel : Icons.undo,
                size: 18,
                color: isDispute ? BauhausDesign.error : BauhausDesign.warning,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  '${isDispute ? 'DISPUTE' : 'REFUND'} · '
                  '${item['invoiceNumber'] ?? item['id']}',
                  style: BauhausDesign.getTextTheme(context).bodyMedium
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Text(
                _money(item['amount'], '${item['currency'] ?? 'AUD'}'),
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${item['reason'] ?? item['status'] ?? ''}'
                  '${item['dueBy'] != null ? ' · ${l10n.stripeDisputeRespondBy} ${'${item['dueBy']}'.split('T').first}' : ''}',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                ),
              ),
              _badge(
                context,
                '${item['status']}'.toUpperCase(),
                _statusColor('${item['status']}'),
              ),
            ],
          ),
          if (invoiceId != null) ...[
            const SizedBox(height: BauhausDesign.space2),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ClientInvoiceDetailView(invoiceId: invoiceId),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: BauhausDesign.space3,
                  vertical: BauhausDesign.space2,
                ),
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: Text(
                  l10n.stripeViewInvoice,
                  style: BauhausDesign.getTextTheme(context).labelMedium
                      ?.copyWith(
                        color: BauhausDesign.surfaceLight,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
