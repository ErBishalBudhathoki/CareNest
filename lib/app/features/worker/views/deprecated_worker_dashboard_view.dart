import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/app/features/worker/viewmodels/worker_dashboard_viewmodel.dart';
import 'package:carenest/app/features/worker/views/widgets/worker_shift_card.dart';
import 'package:carenest/app/features/worker/views/widgets/worker_action_grid.dart';
import 'package:carenest/app/features/worker/views/widgets/worker_status_card.dart';
import 'package:carenest/app/features/worker/views/worker_shift_history_view.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/expenses/views/quick_expense_capture_view.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class DeprecatedWorkerDashboardView extends ConsumerWidget {
  const DeprecatedWorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(workerDashboardViewModelProvider);
    final currentUserAsync = ref.watch(currentUserProvider);
    final currentUser = currentUserAsync.value;

    void openScanInvoice() {
      final orgId = currentUser?.organizationId ?? '';
      final email = currentUser?.email ?? '';
      if (orgId.isEmpty || email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Organization details are not available yet.'),
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              QuickExpenseCaptureView(adminEmail: email, organizationId: orgId),
        ),
      );
    }

    return Scaffold(
      backgroundColor: BauhausTheme.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.workerDashboardTitle,
          style: BauhausTheme.headerStyle,
        ),
        backgroundColor: BauhausTheme.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: BauhausTheme.black),
        actions: [
          IconButton(
            tooltip: 'Scan Invoice',
            icon: const Icon(
              Icons.document_scanner_outlined,
              color: BauhausTheme.black,
            ),
            onPressed: openScanInvoice,
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: BauhausTheme.black),
            onPressed: () =>
                ref.read(workerDashboardViewModelProvider.notifier).refresh(),
          ),
        ],
      ),
      body: dashboardState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: BauhausTheme.blue),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Error: $err',
            style: BauhausTheme.bodyStyle.copyWith(color: BauhausTheme.red),
          ),
        ),
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emergency Banners
              if (data.activeBroadcasts.isNotEmpty)
                _buildEmergencyBanners(context, data.activeBroadcasts),

              // Status Card (Clock In/Out)
              WorkerStatusCard(activeTimer: data.activeTimer),
              const SizedBox(height: 24),

              // Next Shift Section
              Text(
                AppLocalizations.of(context)!.nextShiftCaps,
                style: BauhausTheme.subHeaderStyle,
              ),
              const SizedBox(height: 12),
              if (data.nextShift != null)
                WorkerShiftCard(shift: data.nextShift!)
              else
                _buildEmptyShiftCard(context),

              const SizedBox(height: 24),

              // Past Assigned Shifts Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PAST ASSIGNED SHIFTS',
                    style: BauhausTheme.subHeaderStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WorkerShiftHistoryView(),
                        ),
                      );
                    },
                    child: Text(
                      'VIEW ALL',
                      style: BauhausTheme.labelStyle.copyWith(
                        color: BauhausTheme.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (data.pastAssignedShifts.isEmpty)
                _buildEmptyHistoryCard(context)
              else
                for (final shift in data.pastAssignedShifts.take(3))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: WorkerShiftCard(shift: shift),
                  ),

              const SizedBox(height: 24),

              // Quick Actions
              Text(
                AppLocalizations.of(context)!.actionsCaps,
                style: BauhausTheme.subHeaderStyle,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: openScanInvoice,
                  icon: const Icon(
                    Icons.document_scanner_outlined,
                    color: BauhausTheme.white,
                  ),
                  label: const Text(
                    'Scan Invoice',
                    style: TextStyle(color: BauhausTheme.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BauhausTheme.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const WorkerActionGrid(),

              const SizedBox(height: 24),

              // Recent Expenses
              Text(
                AppLocalizations.of(context)!.recentExpensesCaps,
                style: BauhausTheme.subHeaderStyle,
              ),
              const SizedBox(height: 12),
              if (data.recentExpenses.isEmpty)
                Text(
                  AppLocalizations.of(context)!.noRecentExpenses,
                  style: BauhausTheme.bodyStyle.copyWith(color: Colors.grey),
                )
              else
                for (var e in data.recentExpenses)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.all(12),
                    decoration: BauhausTheme.blockDecoration.copyWith(
                      border: Border.all(color: BauhausTheme.black, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.category, style: BauhausTheme.labelStyle),
                            Text(
                              e.date.toIso8601String().split('T')[0],
                              style: BauhausTheme.bodyStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${e.amount.toStringAsFixed(2)}',
                          style: BauhausTheme.subHeaderStyle,
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyBanners(
    BuildContext context,
    List<dynamic> broadcasts,
  ) {
    return Column(
      children: broadcasts.map((b) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE63946), // Strong Red
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(4, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'EMERGENCY ALERT',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                b.message,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to acknowledge could be added here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'ACKNOWLEDGE',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyShiftCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BauhausTheme.blockDecoration,
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.noUpcomingShifts,
          style: BauhausTheme.bodyStyle,
        ),
      ),
    );
  }

  Widget _buildEmptyHistoryCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BauhausTheme.blockDecoration,
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.noHistorySubtitle,
          style: BauhausTheme.bodyStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
