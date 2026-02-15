import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/app/features/worker/viewmodels/worker_dashboard_viewmodel.dart';
import 'package:carenest/app/features/worker/views/widgets/worker_shift_card.dart';
import 'package:carenest/app/features/worker/views/widgets/worker_action_grid.dart';
import 'package:carenest/app/features/worker/views/widgets/worker_status_card.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class WorkerDashboardView extends ConsumerWidget {
  const WorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(workerDashboardViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausTheme.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.workerDashboardTitle, style: BauhausTheme.headerStyle),
        backgroundColor: BauhausTheme.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: BauhausTheme.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: BauhausTheme.black),
            onPressed: () => ref.read(workerDashboardViewModelProvider.notifier).refresh(),
          ),
        ],
      ),
      body: dashboardState.when(
        loading: () => const Center(child: CircularProgressIndicator(color: BauhausTheme.blue)),
        error: (err, stack) => Center(child: Text('Error: $err', style: BauhausTheme.bodyStyle.copyWith(color: BauhausTheme.red))),
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Card (Clock In/Out)
              WorkerStatusCard(activeTimer: data.activeTimer),
              const SizedBox(height: 24),
              
              // Next Shift Section
              Text(AppLocalizations.of(context)!.nextShiftCaps, style: BauhausTheme.subHeaderStyle),
              const SizedBox(height: 12),
              if (data.nextShift != null)
                WorkerShiftCard(shift: data.nextShift!)
              else
                _buildEmptyShiftCard(context),
                
              const SizedBox(height: 24),
              
              // Quick Actions
              Text(AppLocalizations.of(context)!.actionsCaps, style: BauhausTheme.subHeaderStyle),
              const SizedBox(height: 12),
              const WorkerActionGrid(),

               const SizedBox(height: 24),
               
               // Recent Expenses
               Text(AppLocalizations.of(context)!.recentExpensesCaps, style: BauhausTheme.subHeaderStyle),
               const SizedBox(height: 12),
               if (data.recentExpenses.isEmpty)
                 Text(AppLocalizations.of(context)!.noRecentExpenses, style: BauhausTheme.bodyStyle.copyWith(color: Colors.grey))
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
                           Text(e.date.toIso8601String().split('T')[0], style: BauhausTheme.bodyStyle.copyWith(fontSize: 12)),
                         ],
                       ),
                       Text('\$${e.amount.toStringAsFixed(2)}', style: BauhausTheme.subHeaderStyle),
                     ],
                   ),
                 ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyShiftCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BauhausTheme.blockDecoration,
      child: Center(
        child: Text(AppLocalizations.of(context)!.noUpcomingShifts, style: BauhausTheme.bodyStyle),
      ),
    );
  }
}
