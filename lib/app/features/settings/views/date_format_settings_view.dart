import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/settings/providers/settings_providers.dart';

/// Screen to configure the user's preferred date format for parsing ambiguous numeric dates.
///
/// Provides two options:
/// - Month/Day/Year (US)
/// - Day/Month/Year
class DateFormatSettingsView extends ConsumerWidget {
  const DateFormatSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(dateFormatSettingsViewModelProvider);
    // Trigger a one-time load when first built, while keeping the view stateless.
    if (!vm.isLoaded && !vm.isLoading) {
      // Schedule asynchronously to avoid side-effects during build.
      Future.microtask(() => ref.read(dateFormatSettingsViewModelProvider).load());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Date Format')),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose how to interpret ambiguous numeric dates (e.g., 1/2/2025).',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  RadioListTile<String>(
                    title: const Text('Month/Day/Year (US)'),
                    value: 'mdy',
                    groupValue: vm.selected,
                    onChanged: (val) => vm.select(val ?? 'mdy'),
                  ),
                  RadioListTile<String>(
                    title: const Text('Day/Month/Year'),
                    value: 'dmy',
                    groupValue: vm.selected,
                    onChanged: (val) => vm.select(val ?? 'dmy'),
                  ),
                  if (vm.errorMessage != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      vm.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: vm.isLoading
                          ? null
                          : () async {
                            await vm.save();
                            if (vm.saveSucceeded && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Date format preference saved'),
                                ),
                              );
                                Navigator.of(context).pop();
                              }
                            },
                      child: vm.isLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}