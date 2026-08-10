import 'package:flutter/material.dart';
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
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'MILEAGE SETTINGS',
          style: textTheme.displaySmall?.copyWith(
            color: BauhausDesign.textDark,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.neutral),
      ),
      body: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BauhausDesign.cardDecoration.copyWith(
                color: BauhausDesign.accent,
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: BauhausDesign.textDark),
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
                color: BauhausDesign.neutral,
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
                  color: BauhausDesign.textDark,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: BauhausDesign.surfaceLight,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: const BorderSide(
                      color: BauhausDesign.neutral,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: const BorderSide(
                      color: BauhausDesign.neutral,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: const BorderSide(
                      color: BauhausDesign.textDark,
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
                      foregroundColor: BauhausDesign.textLight,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(
                          color: BauhausDesign.neutral,
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
                    ? const CircularProgressIndicator(
                        color: BauhausDesign.textLight,
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
