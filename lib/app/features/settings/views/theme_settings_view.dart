import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/theme_providers.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';

class ThemeSettingsView extends ConsumerWidget {
  const ThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        title: const Text(
          'THEME',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: 0.5,
            color: BauhausDesign.textDark,
          ),
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: BauhausDesign.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, color: BauhausDesign.neutral, thickness: 2),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: BauhausDesign.neutral,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: BauhausDesign.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: BauhausDesign.accent),
                    ),
                    child: const Icon(Icons.palette_outlined,
                        color: BauhausDesign.accent),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Choose your preferred appearance mode.',
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: BauhausDesign.textDark,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text(
              'APPEARANCE',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
            ),
            const SizedBox(height: 16),

            _buildOptionCard(
              context,
              title: 'Light Mode',
              icon: Icons.light_mode_outlined,
              isSelected: currentMode == ThemeMode.light,
              onTap: () =>
                  ref.read(themeModeProvider.notifier).setMode(ThemeMode.light),
            ),
            const SizedBox(height: 16),
            _buildOptionCard(
              context,
              title: 'Dark Mode',
              icon: Icons.dark_mode_outlined,
              isSelected: currentMode == ThemeMode.dark,
              onTap: () =>
                  ref.read(themeModeProvider.notifier).setMode(ThemeMode.dark),
            ),
            const SizedBox(height: 16),
            _buildOptionCard(
              context,
              title: 'System Default',
              icon: Icons.settings_brightness_outlined,
              isSelected: currentMode == ThemeMode.system,
              onTap: () => ref
                  .read(themeModeProvider.notifier)
                  .setMode(ThemeMode.system),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? BauhausDesign.primary
                : BauhausDesign.neutral.withOpacity(0.3),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: BauhausDesign.neutral,
                    offset: Offset(4, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? BauhausDesign.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color:
                    isSelected ? BauhausDesign.primary : BauhausDesign.neutral,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: BauhausDesign.getTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? BauhausDesign.textDark
                          : BauhausDesign.neutral,
                      fontSize: 16,
                    ),
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: BauhausDesign.primary,
                  border: Border.all(color: BauhausDesign.primary),
                ),
                child: const Icon(Icons.check,
                    size: 16, color: BauhausDesign.textLight),
              ),
          ],
        ),
      ),
    );
  }
}
