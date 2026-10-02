import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/admin/viewmodels/mileage_settings_view_model.dart';

class MileageSettingsView extends ConsumerStatefulWidget {
  const MileageSettingsView({super.key});

  @override
  ConsumerState<MileageSettingsView> createState() =>
      _MileageSettingsViewState();
}

class _MileageSettingsViewState extends ConsumerState<MileageSettingsView> {
  final _rateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controller with current rate
    final rate = ref.read(mileageSettingsViewModelProvider).reimbursementRate;
    _rateController.text = rate.toString();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(mileageSettingsViewModelProvider);
    final textTheme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'MILEAGE SETTINGS',
          style: textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: Theme.of(context).colorScheme.outline,
            height: 2,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BauhausDesign.cardDecorationFor(
                context,
              ).copyWith(color: BauhausDesign.accent),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Text(
                      'This rate applies to all reimbursable trips (Between Clients & With Client).',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: BauhausDesign.space5),

            // Rate Input
            Text(
              'REIMBURSEMENT RATE (\$ / km)',
              style: textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Container(
              decoration: BoxDecoration(
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: TextField(
                controller: _rateController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(BauhausDesign.space4),
                  suffixText: '/ km',
                ),
              ),
            ),

            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        final rate = double.tryParse(_rateController.text);
                        if (rate != null) {
                          await ref
                              .read(mileageSettingsViewModelProvider.notifier)
                              .updateRate(rate);
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        }
                      },
                style:
                    ElevatedButton.styleFrom(
                      backgroundColor: BauhausDesign.primary,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onInverseSurface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 2,
                        ),
                      ),
                      shadowColor: Colors
                          .transparent, // We use custom shadow via Container if needed, or simple button
                    ).copyWith(
                      // Hack for hard shadow: typically done with a Stack/Container,
                      // but for simplicity we'll just use the bold style.
                    ),
                child: viewModel.isLoading
                    ? CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      )
                    : Text(
                        'SAVE SETTINGS',
                        style: textTheme.labelLarge?.copyWith(
                          fontSize: 18,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
