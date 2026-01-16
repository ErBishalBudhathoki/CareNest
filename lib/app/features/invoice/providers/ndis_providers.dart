import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Using keepAlive: true ensures the data is cached for the lifetime of the app
// or until explicitly invalidated.
final ndisItemsProvider =
    FutureProvider.autoDispose<List<NDISItem>>((ref) async {
  // Keep the state alive even if the widget is disposed/screen closed
  ref.keepAlive();

  final matcher = NDISMatcher();
  // We use loadItems which fetches from DB/File and parses
  await matcher.loadItems(forceReload: true);
  return matcher.items;
});

// Provides custom pricing data for an organization
final ndisPricingProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, organizationId) async {
  ref.keepAlive();

  final apiMethod = ApiMethod();
  // Only bulk fetch custom pricing. We do NOT fetch support item details here
  // as the base NDISItem already has standard prices.
  // Ideally, we would need the list of itemNumbers to be efficient, but getBulkPricingLookup
  // usually takes a list. Let's verify how we can get all item numbers or if there's an API
  // to get "all custom pricing" without specifying items.

  // If we need item numbers, we should await the items provider first
  final ndisItems = await ref.watch(ndisItemsProvider.future);
  final allItemNumbers = ndisItems.map((item) => item.itemNumber).toList();

  if (allItemNumbers.isEmpty) return {};

  final bulkPricingData = await apiMethod.getBulkPricingLookup(
    organizationId,
    allItemNumbers,
  );

  return bulkPricingData ?? {};
});
