Rates come from NDIS item pricing lookups (custom only). NDIS caps are never used as the rate. When no base price exists, rates currently fall back to a default weekday rate of $30.00 until service rate management is fully integrated.
The PDF’s “Rates” column uses item['rate'] computed during invoice data processing. If base pricing isn’t found for an NDIS item, multiple parts of the code fall back to $30.00.
Where Rates Come From

Bulk pricing lookup
Calls api/pricing/bulk-lookup to fetch rates for many NDIS item numbers at once.
Data is cached and then used to set the rate for each line.
Code: lib/backend/api_method.dart → getBulkPricingLookup(...) and lib/app/features/invoice/services/enhanced_invoice_service.dart lines ~1100–1160.
Custom pricing
Client-specific custom price: custom-price-client/:ndisItemNumber/:clientId
Organization-wide custom price: custom-price-organization/:ndisItemNumber
Code: lib/backend/api_method.dart → getCustomPriceForClient(...), getCustomPriceForOrganization(...)
Standard price (base price metadata only)
Fetched via standard-price/:ndisItemNumber for metadata (state-specific price caps, item name). This endpoint now returns `price: null` and surfaces `priceCap` for validation only; it does not provide a billable rate.
Code: lib/backend/api_method.dart → getStandardPrice(...)
Price caps
Fetched via ndis-price-cap/:ndisItemNumber
Code: lib/backend/api_method.dart → getNdisItemPriceCap(...)
How The Rate Is Chosen (Resolution Order)

With a valid NDIS item number:
Use cached bulk pricing if present:
customPrice > 0 → use as rate
Else no auto rate is available from caps; use prompts to collect a base price or fallback to $30.00 (temporary until service rate management is fully integrated)
Code: lib/app/features/invoice/utils/invoice_data_processor.dart → _getEnhancedPricing(...) returns 30.0 on miss; lib/app/features/invoice/services/enhanced_invoice_service.dart uses `suggestedPrice` from custom pricing then falls back to internal `_getSuggestedPrice` when standard price is null.
Without an NDIS item number:
Use weekday/weekend/holiday fallback from helpers:
Weekday: $30.00
Weekend: $40.00
Holiday: $50.00
Code: lib/app/features/invoice/utils/invoice_helpers.dart → getRate(...) hard-coded examples
Why You’re Seeing Mostly $30

Missing or unknown NDIS item numbers in the schedule/doc, so the helper defaults kick in.
Bulk pricing lookup returns no entry for many items (e.g., not configured in backend for your org), so _getEnhancedPricing falls back to 30.0.
Standard-price endpoint now returns null for `price` and is used for validation metadata and manual prompts only; invoice auto-rate requires custom pricing or service rate configuration.
Where the PDF Reads the Rate

The “Rates” column is rendered from item['rate'] during PDF generation.
Code: lib/app/features/invoice/services/invoice_pdf_generator_service.dart
Uses '\$${_getSafeDouble(item['rate']).toStringAsFixed(2)}'
Totals are computed as hours × rate
Key Code References

Rate calculation per item:
lib/app/features/invoice/utils/invoice_data_processor.dart
Database path: lines ~440–520
Calculated path: lines ~520–620
Uses _getEnhancedPricing(...) or falls back to helpers
Fallback example: getRate(...) in lib/app/features/invoice/utils/invoice_helpers.dart with 30.0 for weekdays
Pricing data loading and cache:
lib/app/features/invoice/utils/invoice_data_processor.dart lines ~70–130 and ~210–260
lib/app/features/invoice/services/enhanced_invoice_service.dart lines ~1100–1160
Pricing checks and prompts (when missing):
lib/app/features/invoice/services/enhanced_invoice_service.dart lines ~1356–1510
Prompts use suggested price (custom → org → standard), but the PDF “Rate” still comes from items built earlier unless you approve prompts.
How to Get Correct Rates Instead of $30

Ensure NDIS item numbers are present in the schedule entries and in the legacy mapping:
Items without ndisItemNumber fall back to weekday/weekend/holiday rates.
Confirm organizationId is passed to generation:
enhanced_invoice_generation_view.dart extracts and passes it (lines ~1361–1376).
automatic_invoice_generation_view.dart loads it from SharedPreferences (lines ~85–93).
Configure custom pricing in the backend so api/pricing/bulk-lookup returns entries for all items used:
Once the bulk lookup returns `customPrice`, that value will populate the “Rates” column. Caps are read-only metadata and not used for rates.
Use the NDIS Pricing Management view to set custom prices for items your org uses:
Screen: lib/app/features/pricing/views/ndis_pricing_management_view.dart
This saves via saveCustomPriceForClient/Organization and feeds the bulk lookup. Price caps are read-only and should not be edited.

Plan: Service Rate Management Integration

- Introduce a `serviceRates` model for base, weekend, and holiday rates by service type and organization; optionally support client-specific overrides.
- Backend: add CRUD endpoints under `/api/service-rates` to manage base rates; keep `supportItems` caps read-only.
- Frontend: wire the Service Rate Management UI to these endpoints; use service rates as fallback when custom pricing is missing.
- Enhanced invoice generation: update `EnhancedInvoiceService` to prefer `customPrice`, then service-rate fallback, otherwise prompt for manual price; never use caps as rate.
Clarifications

Do you want me to change the fallback behavior so that when bulk lookup misses, we call getStandardPrice per item and use that instead of $30.00?
Should the weekday/weekend/holiday defaults be replaced by state-based NDIS standard prices even when ndisItemNumber is missing?
If you share a specific invoice or the set of NDIS item numbers that show $30, I can trace which items are missing from bulk lookup and propose a targeted fix.

If we are looking for ndisItems collectin then that collection does not exist.

There are two collections that is into pricing:

a. custompricing where custom pricing for ndis item can be set by admin for specific supportItemNumber whcih looks like:

{"_id":{"$oid":"6889065e7bb576509bbd0f9b"},"organizationId":"6846b040808f01d85897bbd8","supportItemNumber":"01_020_0120_1_1","supportItemName":"House Cleaning And Other Household Activities","pricingType":"fixed","customPrice":{"$numberInt":"49"},"multiplier":null,"clientId":null,"clientSpecific":false,"ndisCompliant":true,"exceedsNdisCap":false,"approvalStatus":"approved","effectiveDate":{"$date":{"$numberLong":"1753810526184"}},"expiryDate":null,"createdBy":"test1@tester.com","createdAt":{"$date":{"$numberLong":"1753810526184"}},"updatedBy":"test1@tester.com","updatedAt":{"$date":{"$numberLong":"1753859124724"}},"isActive":true,"version":{"$numberInt":"2"},"auditTrail":[{"action":"created","performedBy":"test1@tester.com","timestamp":{"$date":{"$numberLong":"1753810526184"}},"changes":"Custom pricing created: 40 (fixed)"},{"action":"updated","performedBy":"test1@tester.com","timestamp":{"$date":{"$numberLong":"1753859124713"}},"changes":"Price updated from 40 to 49 (custom)"},{"action":"updated","performedBy":"test1@tester.com","timestamp":{"$date":{"$numberLong":"1753859124724"}},"changes":"Price updated from 40 to 49 (custom)"}]}

b. Another collection is supportItems, which has many data objects but for now we can focus on supportItemNumber and priceCaps objects and in pricceCaps it has 2 objects that is standard and highIntensity, if the supportItemName contains label "High Intensity" then we need to take consideration of highIntensity object price. But the priceCaps are not to use for "Rates" PriceCaps is there to make sure the rate i never greater than that price as this is the max price one can chaarge for that specific supportItemNumber and supportItemName whcih lloks like:

{"_id":{"$oid":"686a7f438d3ef180a52827a5"},"supportItemNumber":"01_403_0104_1_1","supportItemName":"Assistance With Self-Care Activities - High Intensity - Sunday","registrationGroup":{"number":"0104","name":"High Intensity Daily Personal Activities"},"supportCategory":{"number":"1","name":"Assistance with Daily Life (Includes SIL)"},"unit":"H","quoteRequired":false,"startDate":{"$date":{"$numberLong":"1656633600000"}},"endDate":{"$date":{"$numberLong":"253402214400000"}},"supportType":"Price Limited Supports","rules":{"allowNonFaceToFace":true,"allowProviderTravel":true,"allowShortNoticeCancellation":true,"ndiaRequiresQuote":false,"isIrregularSupport":false},"priceCaps":{"standard":{"ACT":{"$numberDouble":"122.14"},"NSW":{"$numberDouble":"122.14"},"NT":{"$numberDouble":"122.14"},"QLD":{"$numberDouble":"122.14"},"SA":{"$numberDouble":"122.14"},"TAS":{"$numberDouble":"122.14"},"VIC":{"$numberDouble":"122.14"},"WA":{"$numberDouble":"122.14"}},"highIntensity":{"ACT":{"$numberDouble":"183.21"},"NSW":{"$numberDouble":"183.21"},"NT":{"$numberDouble":"183.21"},"QLD":{"$numberDouble":"183.21"},"SA":{"$numberDouble":"183.21"},"TAS":{"$numberDouble":"183.21"},"VIC":{"$numberDouble":"183.21"},"WA":{"$numberDouble":"183.21"}}}}

Also custom pricing can be linked to organisation as well as client.

We have a service rate management UI whcih should be used to define service based rate as shown in attached image. It contains base rate, weekend rate, holdiay rate for service type personal care. Right now this UI is hard coded and not used.

NDIS pricing managemnt UI loads lis of all the supportItemsName and its supportItemNumber along with priceCaps price whcih can be edited to set a custom pricing. So I have doubt in this also as priceCaps is something that should not be changed


Also when admin assign employee to clients there is a button to select NDIS Item where list of all NDIS item is generated and at that time only for that specific item name and number custom pricing can be set whcih will beset for the whole organistion although attacching that pricie to that specific client would be great as well.

Now look into this detail and create a prooper plan to resolve all this issue and have correct Rates for each individual supportItemsName and supportItemsNumber.