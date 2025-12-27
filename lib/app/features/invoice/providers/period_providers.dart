import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/invoice/repositories/period_config_repository.dart';
import 'package:carenest/app/features/invoice/services/date_period_service.dart';
import 'package:carenest/app/features/invoice/services/date_parser_service.dart';

/// Provider for PeriodConfigRepository
final periodConfigRepositoryProvider = Provider<PeriodConfigRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PeriodConfigRepository(prefs);
});

/// Provider for DatePeriodService
final datePeriodServiceProvider = Provider<DatePeriodService>((ref) {
  final repo = ref.watch(periodConfigRepositoryProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  final pref = prefs.getDateFormatPreference();
  final preferUs = pref == 'mdy';
  final parser = DateParserService(preferUsFormat: preferUs);
  return DatePeriodService(repo, parser);
});

/// Provider for DateParserService (exposed for optional direct use)
final dateParserServiceProvider = Provider<DateParserService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final pref = prefs.getDateFormatPreference();
  final preferUs = pref == 'mdy';
  return DateParserService(preferUsFormat: preferUs);
});