# Localization Configuration
# Add to pubspec.yaml under flutter: section

# flutter:
#   generate: true
#
# Also add to dependencies:
#   flutter_localizations:
#     sdk: flutter
#   intl: ^0.19.0

# Create l10n.yaml file in project root with:
# arb-dir: lib/l10n
# template-arb-file: app_en.arb
# output-localization-file: app_localizations.dart
# output-dir: lib/generated/l10n

# After setup, run:
# flutter gen-l10n

# Usage in MaterialApp:
# MaterialApp(
#   localizationsDelegates: AppLocalizations.localizationsDelegates,
#   supportedLocales: AppLocalizations.supportedLocales,
#   ...
# )

# Usage in widgets:
# import 'package:carenest/generated/l10n/app_localizations.dart';
# final l10n = AppLocalizations.of(context)!;
# Text(l10n.loginTitle)  // Returns 'WELCOME BACK'
