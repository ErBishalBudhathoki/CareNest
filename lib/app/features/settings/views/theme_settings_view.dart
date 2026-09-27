import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/theme_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class ThemeSettingsView extends ConsumerWidget {
  const ThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.themeAppBarTitle,
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: colorScheme.inverseSurface,
        foregroundColor: colorScheme.onInverseSurface,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: colorScheme.onInverseSurface),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Divider(height: 2, color: colorScheme.outline, thickness: 2),
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
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.zero,
                border: Border.all(color: colorScheme.outline, width: 2.5),
                boxShadow: const [
                  BoxShadow(color: BauhausDesign.neoInk, offset: Offset(4, 4)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: colorScheme.primary),
                    ),
                    child: Icon(
                      Icons.palette_outlined,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.themeInfoMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text(
              AppLocalizations.of(context)!.appearance,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),

            _buildOptionCard(
              context,
              title: AppLocalizations.of(context)!.lightMode,
              icon: Icons.light_mode_outlined,
              isSelected: currentMode == ThemeMode.light,
              onTap: () =>
                  ref.read(themeModeProvider.notifier).setMode(ThemeMode.light),
            ),
            const SizedBox(height: 16),
            _buildOptionCard(
              context,
              title: AppLocalizations.of(context)!.darkMode,
              icon: Icons.dark_mode_outlined,
              isSelected: currentMode == ThemeMode.dark,
              onTap: () =>
                  ref.read(themeModeProvider.notifier).setMode(ThemeMode.dark),
            ),
            const SizedBox(height: 16),
            _buildOptionCard(
              context,
              title: AppLocalizations.of(context)!.systemDefault,
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.zero,
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? const [
                  BoxShadow(color: BauhausDesign.neoInk, offset: Offset(4, 4)),
                ]
              : const [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.zero,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
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
                  color: colorScheme.primary,
                  border: Border.all(color: colorScheme.primary),
                ),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: colorScheme.onPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
