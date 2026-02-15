import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import '../viewmodels/compliance_dashboard_viewmodel.dart';

class ComplianceDashboardView extends ConsumerStatefulWidget {
  const ComplianceDashboardView({super.key});

  @override
  ConsumerState<ComplianceDashboardView> createState() =>
      _ComplianceDashboardViewState();
}

class _ComplianceDashboardViewState
    extends ConsumerState<ComplianceDashboardView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(complianceDashboardViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausTheme.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.complianceAuditTitle,
            style: BauhausTheme.headerStyle),
        backgroundColor: BauhausTheme.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausTheme.black),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausTheme.blue))
          : state.error != null
              ? Center(
                  child: Text(state.error!,
                      style: BauhausTheme.bodyStyle
                          .copyWith(color: BauhausTheme.red)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildScoreCard(state.data),
                      const SizedBox(height: 24),
                      Text(AppLocalizations.of(context)!.attentionRequired,
                          style: BauhausTheme.subHeaderStyle),
                      const SizedBox(height: 12),
                      _buildAlertList(state.data),
                    ],
                  ),
                ),
    );
  }

  Widget _buildScoreCard(Map<String, dynamic>? data) {
    final score = data?['complianceScore'] ?? 0;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BauhausTheme.blockDecoration.copyWith(
        color: BauhausTheme.blue,
        border: Border.all(color: BauhausTheme.black, width: 3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.overallScore,
                  style: BauhausTheme.subHeaderStyle
                      .copyWith(color: BauhausTheme.white)),
              Text('$score%',
                  style: BauhausTheme.headerStyle
                      .copyWith(fontSize: 48, color: BauhausTheme.white)),
            ],
          ),
          Icon(
            score > 80 ? Icons.check_circle : Icons.warning,
            size: 64,
            color: BauhausTheme.white,
          )
        ],
      ),
    );
  }

  Widget _buildAlertList(Map<String, dynamic>? data) {
    final expiring = data?['expiringDocs'] as List<dynamic>? ?? [];
    final expired = data?['expiredDocs'] as List<dynamic>? ?? [];

    if (expiring.isEmpty && expired.isEmpty) {
      return Text(AppLocalizations.of(context)!.allDocumentsUpToDate,
          style: BauhausTheme.bodyStyle);
    }

    return Column(
      children: [
        ...expired.map((doc) => _buildAlertItem(doc, isExpired: true)),
        ...expiring.map((doc) => _buildAlertItem(doc, isExpired: false)),
      ],
    );
  }

  Widget _buildAlertItem(dynamic doc, {required bool isExpired}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BauhausTheme.blockDecoration.copyWith(
        border: Border.all(
            color: isExpired ? BauhausTheme.red : BauhausTheme.yellow,
            width: 2),
      ),
      child: Row(
        children: [
          Icon(
            isExpired ? Icons.error : Icons.warning,
            color: isExpired ? BauhausTheme.red : BauhausTheme.yellow,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc['documentType'] ?? 'Document',
                    style: BauhausTheme.subHeaderStyle.copyWith(fontSize: 16)),
                Text(
                    AppLocalizations.of(context)!.expiresLabel(
                        doc['expiryDate']?.toString().split('T')[0] ?? ''),
                    style: BauhausTheme.bodyStyle),
              ],
            ),
          ),
          if (isExpired)
            Text(AppLocalizations.of(context)!.expiredCaps,
                style:
                    BauhausTheme.labelStyle.copyWith(color: BauhausTheme.red)),
        ],
      ),
    );
  }
}
