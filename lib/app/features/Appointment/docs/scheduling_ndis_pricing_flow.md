# Employee-Client Scheduling and NDIS Item Selection Flow

## Overview

This document outlines the data flow for assigning employees to clients (scheduling) in the application, with a specific focus on how NDIS item selection and pricing mechanisms work. This documentation serves as a reference for developers working on the scheduling and pricing features of the application.

## Table of Contents

1. [Scheduling Flow](#scheduling-flow)
2. [NDIS Item Selection](#ndis-item-selection)
3. [Pricing Mechanism](#pricing-mechanism)
4. [Data Flow Diagram](#data-flow-diagram)

## Scheduling Flow

### Key Components

- **ScheduleAssignment**: Main widget for creating and managing employee-client schedules
- **EnhancedNdisItemSelectionView**: Widget for selecting NDIS items with pricing information
- **ApiMethod**: Backend API interface for retrieving and saving pricing data

### Data Structure

Schedule assignments store the following key data:

- **Date**: The date of the scheduled appointment
- **Start Time**: When the appointment begins
- **End Time**: When the appointment ends
- **Break**: Duration of any breaks during the appointment
- **NDIS Item**: The selected NDIS service item for billing
- **High Intensity**: Flag indicating if high-intensity care is required
- **Custom Pricing**: Optional custom pricing information

### Scheduling Process

1. **Initialization**:
   - The `ScheduleAssignment` widget initializes with empty lists for schedule data
   - Lists include: `dateList`, `startTimeList`, `endTimeList`, `breakList`, `ndisItemList`, `highIntensityList`
   - Custom pricing lists are also initialized: `customPricingSetList`, `customPriceList`, `pricingTypeList`

2. **Adding Schedule Entries**:
   - Users can add multiple schedule entries for different dates/times
   - Each entry requires date, start time, end time, and break duration
   - The widget validates entries for time conflicts using `_hasTimeConflict` and `_hasTimeConflictBetweenSchedules`

3. **Employee-Client Assignment**:
   - The widget receives employee and client information as parameters
   - This information is displayed in the UI and used when submitting the assignment

4. **Schedule Submission**:
   - When the user submits the assignment, the `_submitAssignedAppointment` method is called
   - This method creates a `scheduleWithNdisItems` array containing all schedule entries
   - Each entry includes date, time, break, NDIS item, and custom pricing information
   - The data is sent to the backend via `_apiMethod.assignClientToUserWithScheduleItems()`

5. **Backend Processing**:
   - The backend stores the schedule entries in the database
   - The schedule data is later used for invoice generation and reporting

## NDIS Item Selection

### Selection Process

1. **Initiating Selection**:
   - From the `ScheduleAssignment` widget, users click on the "NDIS Service Item" button
   - This navigates to the `EnhancedNdisItemSelectionView` with relevant parameters:
     - `organizationId`: The organization providing the service
     - `clientId`: The client receiving the service
     - `userState`: The state/territory for pricing rules

2. **Loading NDIS Items**:
   - `EnhancedNdisItemSelectionView` initializes and calls `_initializeUserState()`
   - This retrieves `organizationId` and `userState` from `SharedPreferences` if not provided
   - The `_loadNdisItems()` method is called to fetch all available NDIS items
   - Items are loaded from the backend using API calls

3. **Loading Pricing Data**:
   - After NDIS items are loaded, `_loadPricingData()` is called
   - This method fetches pricing information in two ways:
     - Client-specific pricing via `_apiMethod.getPricingLookup(organizationId, supportItemNumber, clientId)`
     - Organization-wide pricing via `_apiMethod.getSupportItemDetails(supportItemNumbers)`
   - Pricing data is processed in batches to handle large numbers of items

4. **Item Selection**:
   - Users can search for specific NDIS items using the search field
   - The list displays item numbers, names, and pricing information
   - When an item is selected, the user can view standard pricing and any custom pricing

5. **Custom Pricing Options**:
   - Users can override the standard price with a custom price
   - They can select the pricing type (e.g., hourly, daily, fixed)
   - Custom pricing can be saved for future use

6. **Returning Selection Results**:
   - When the user confirms their selection, the widget returns:
     - The selected NDIS item
     - Custom pricing information (if applicable)
     - Pricing type
   - This data is returned to the `ScheduleAssignment` widget

### Integration with Scheduling

1. **Storing Selected Items**:
   - When a user returns from `EnhancedNdisItemSelectionView`, `ScheduleAssignment` stores:
     - The selected NDIS item in `ndisItemList`
     - Custom pricing flag in `customPricingSetList`
     - Custom price value in `customPriceList`
     - Pricing type in `pricingTypeList`
   - Each list is indexed to match the corresponding schedule entry

2. **Displaying Selected Items**:
   - The selected NDIS item is displayed in the schedule card
   - If custom pricing is set, this is also indicated

3. **Editing Selections**:
   - Users can edit a schedule entry to change the NDIS item
   - This reopens the `EnhancedNdisItemSelectionView` with the current selection
   - When a new selection is made, the corresponding lists are updated
4. The selected NDIS item is returned to the `ScheduleAssignment` view along with any custom pricing information

## Pricing Mechanism

### Price Determination

1. **Standard Pricing**:
   - Each NDIS item has a standard price cap set by the NDIS
   - This price varies based on:
     - The specific service item number
     - The state/territory (userState)
     - Whether high-intensity care is required

2. **Custom Pricing**:
   - Organizations can set custom pricing for NDIS items
   - Custom pricing can be:
     - Organization-wide: Applied to all clients
     - Client-specific: Applied only to a particular client
   - Custom pricing is stored in the database and retrieved via API calls

3. **Price Hierarchy**:
   - Client-specific custom pricing takes highest precedence
   - Organization-wide custom pricing takes second precedence
   - Standard NDIS price caps are used if no custom pricing exists

### Custom Pricing Application

1. **Setting Custom Prices**:
   - In the `EnhancedNdisItemSelectionView`, users can override standard prices
   - They enter a custom price and select a pricing type (hourly, daily, fixed)
   - Custom prices can be saved for future use via `_apiMethod.saveAsCustomPricing()`

2. **Retrieving Custom Prices**:
   - When loading NDIS items, the app fetches custom pricing data:
     - Client-specific: `_apiMethod.getPricingLookup(organizationId, supportItemNumber, clientId)`
     - Organization-wide: `_apiMethod.getSupportItemDetails(supportItemNumbers)`
   - The app compares these prices to determine which to display and use

3. **Storing Custom Prices**:
   - Custom prices are stored in the database with:
     - Organization ID
     - Support item number
     - Client ID (if client-specific)
     - Price value
     - Pricing type
     - User email (who created the custom price)

4. **Applying Custom Prices in Scheduling**:
   - When a user selects an NDIS item with custom pricing, the information is stored in:
     - `customPricingSetList`: Boolean flag indicating custom pricing is used
     - `customPriceList`: The custom price value
     - `pricingTypeList`: The type of pricing (hourly, daily, fixed)
   - These values are stored per schedule entry

5. **Backend Processing**:
   - When schedules are submitted, custom pricing information is sent to the backend
   - The backend uses this information when generating invoices
   - The `getPricingForItem` function in the backend determines the final price to apply

### API Methods for Pricing

1. **getSupportItemDetails**:
   - Fetches NDIS support item details and price caps
   - Parameters: Array of support item numbers
   - Returns: Standard pricing information for each item

2. **getPricingLookup**:
   - Retrieves pricing lookup data for an organization and specific support item
   - Parameters: Organization ID, support item number, optional client ID
   - Returns: Custom pricing information if available

3. **getBulkPricingLookup**:
   - Fetches pricing data for multiple NDIS items in a single request
   - Parameters: Organization ID, array of support item numbers, optional client ID
   - Returns: Custom pricing information for multiple items

4. **saveAsCustomPricing**:
   - Saves custom pricing for an NDIS item
   - Parameters: Organization ID, support item number, price, pricing type, user email, optional client ID
   - Returns: Confirmation of saved custom pricing

5. **removeCustomPricing**:
   - Deletes custom pricing for an NDIS item
   - Parameters: Organization ID, support item number, optional client ID
   - Returns: Confirmation of deleted custom pricing

### Data Flow Diagram

```
+---------------------+     +---------------------------+     +----------------------+
|                     |     |                           |     |                      |
| ScheduleAssignment  |     | EnhancedNdisItemSelection|     |     Backend API      |
|                     |     |                           |     |                      |
+----------+----------+     +--------------+------------+     +-----------+----------+
           |                               |                              |
           |                               |                              |
           |  Navigate with params         |                              |
           |  (organizationId,            |                              |
           |   clientId, userState)        |                              |
           +------------------------------>+                              |
           |                               |                              |
           |                               |  Load NDIS Items             |
           |                               +----------------------------->+
           |                               |                              |
           |                               |  Return NDIS Items           |
           |                               +<-----------------------------+
           |                               |                              |
           |                               |  Load Pricing Data           |
           |                               |  (getPricingLookup,          |
           |                               |   getSupportItemDetails)     |
           |                               +----------------------------->+
           |                               |                              |
           |                               |  Return Pricing Data         |
           |                               +<-----------------------------+
           |                               |                              |
           |                               |  User selects NDIS item      |
           |                               |  and sets custom pricing     |
           |                               |                              |
           |                               |  Save Custom Pricing         |
           |                               |  (saveAsCustomPricing)       |
           |                               +----------------------------->+
           |                               |                              |
           |                               |  Confirm Saved               |
           |                               +<-----------------------------+
           |                               |                              |
           |  Return Selected NDIS Item    |                              |
           |  with Custom Pricing          |                              |
           +<------------------------------+                              |
           |                               |                              |
           |  Store in Lists:              |                              |
           |  - ndisItemList               |                              |
           |  - customPricingSetList       |                              |
           |  - customPriceList            |                              |
           |  - pricingTypeList            |                              |
           |                               |                              |
           |  Submit Assignment            |                              |
           |  (assignClientToUserWith      |                              |
           |   ScheduleItems)              |                              |
           +-------------------------------------------------------------->+
           |                               |                              |
           |  Confirm Assignment           |                              |
           +<--------------------------------------------------------------+
           |                               |                              |
```

### Data Flow Description

1. `ScheduleAssignment` navigates to `EnhancedNdisItemSelectionView` passing:
   - `organizationId`: The organization providing the service
   - `clientId`: The client receiving the service
   - `userState`: The state/territory for pricing rules
   - `highIntensity`: Flag indicating if high-intensity care is required

2. `EnhancedNdisItemSelectionView` loads NDIS items from the backend API

3. After loading NDIS items, the view fetches pricing data:
   - Client-specific pricing via `getPricingLookup`
   - Organization-wide pricing via `getSupportItemDetails`
   - High-intensity price caps via `supportItemDetails.priceCaps['highIntensity']`

4. If `highIntensity` is enabled, the view filters NDIS items to show only those with high-intensity pricing

5. The user selects an NDIS item and optionally sets custom pricing

6. If custom pricing is set, it's saved to the backend via `saveAsCustomPricing`

7. The selected NDIS item and pricing information are returned to `ScheduleAssignment`

8. `ScheduleAssignment` stores the selection in its lists:
   - `ndisItemList`: The selected NDIS item
   - `customPricingSetList`: Flag indicating if custom pricing is used
   - `customPriceList`: The custom price value
   - `pricingTypeList`: The type of pricing (hourly, daily, fixed)
   - `highIntensityList`: Flag indicating if high-intensity pricing is applied

9. When the user submits the assignment, all schedule data including NDIS items and pricing is sent to the backend via `assignClientToUserWithScheduleItems`

10. The backend confirms the assignment and stores the data for future use in invoicing and reporting

2. `EnhancedNdisItemSelectionView` loads NDIS items and pricing data:
   - Calls `_initializeUserState()` to retrieve organization and user state information
   - Calls `_loadNdisItems()` to load available NDIS items
   - Calls `_loadPricingData()` to fetch pricing information for the items

3. When a user selects an NDIS item, the view returns:
   - The selected NDIS item object
   - Custom pricing flag (`isCustomPriceSet`)
   - Custom price value (`customPrice`)
   - Pricing type (`pricingType`)

4. `ScheduleAssignment` stores this information for each schedule entry in:
   - `ndisItemList`: List of selected NDIS items
   - `customPricingSetList`: List of flags indicating if custom pricing is set
   - `customPriceList`: List of custom price values
   - `pricingTypeList`: List of pricing types

## Pricing Mechanism

### Pricing Data Sources

The application retrieves pricing data from several sources in the following priority order:

1. **Client-Specific Custom Pricing**: Custom pricing set specifically for a client
2. **Organization-Wide Custom Pricing**: Custom pricing set for the entire organization
3. **High-Intensity Price Caps**: Increased price caps for high-intensity support when enabled
4. **Standard NDIS Price Guide**: Default pricing from the NDIS price guide

### API Methods

The application uses these key API methods for pricing:

- `getPricingLookup(organizationId, supportItemNumber, {clientId})`: Retrieves pricing information for a specific NDIS item, optionally filtered by client
- `getSupportItemDetails(supportItemNumber)`: Gets standard price caps and details for an NDIS item
- `getBulkPricingLookup(organizationId, supportItemNumbers, {clientId})`: Retrieves pricing for multiple NDIS items in a single request
- `saveAsCustomPricing(organizationId, supportItemNumber, price, pricingType, userEmail)`: Saves custom pricing for an NDIS item

### Loading Pricing Data

The `_loadPricingData()` method in `EnhancedNdisItemSelectionView` handles loading pricing data:

1. Retrieves `organizationId` from widget parameter or SharedPreferences
2. Processes NDIS items in batches to avoid overloading the API
3. For each batch:
   - Calls `_apiMethod.getBulkPricingLookup()` to get custom pricing
   - Calls `_apiMethod.getSupportItemDetails()` for standard pricing
4. Identifies items with high-intensity pricing by checking `priceCaps['highIntensity']`
5. Sets `hasHighIntensityPricing` flag for each item that supports high-intensity pricing
6. Filters items based on high-intensity flag if `widget.highIntensity` is enabled
7. Merges the pricing data and updates the UI
8. Maintains high-intensity filtering during search operations in `_filterNdisItems()`

### Custom Pricing Application

When submitting a schedule assignment, custom pricing is included in the data sent to the backend:

1. For each schedule entry, a `customPricing` object is added if available:
   ```json
   {
     "price": 123.45,
     "pricingType": "fixed",
     "isCustom": true
   }
   ```

2. If high-intensity pricing is applied, a `highIntensity` flag is included in the data:
   ```json
   {
     "highIntensity": true
   }
   ```

3. The backend uses this information when generating invoices, applying the pricing in the following order:
   - Custom price if available
   - High-intensity price cap if the `highIntensity` flag is true
   - Standard price as the fallback option

## Data Flow Diagram

```
┌─────────────────┐     ┌───────────────────────────┐     ┌─────────────────┐
│                 │     │                           │     │                 │
│  Schedule       │     │  EnhancedNdisItem         │     │  API Methods    │
│  Assignment     │────▶│  SelectionView           │────▶│                 │
│                 │     │                           │     │                 │
└─────────────────┘     └───────────────────────────┘     └─────────────────┘
        │                           │                             │
        │                           │                             │
        │                           │                             │
        ▼                           ▼                             ▼
┌─────────────────┐     ┌───────────────────────────┐     ┌─────────────────┐
│                 │     │                           │     │                 │
│  Schedule Data  │     │  NDIS Item Selection      │     │  Pricing Data   │
│  - Date         │     │  - Search NDIS items      │     │  - Standard     │
│  - Time         │     │  - Select item            │     │  - Organization │
│  - Break        │     │  - Set custom pricing     │     │  - Client       │
│  - NDIS Item    │     │                           │     │                 │
│                 │     │                           │     │                 │
└─────────────────┘     └───────────────────────────┘     └─────────────────┘
        │                           │                             │
        │                           │                             │
        └───────────────────────────┴─────────────────────────────┘
                                    │
                                    ▼
                          ┌─────────────────────┐
                          │                     │
                          │  Backend API        │
                          │  - Store schedule   │
                          │  - Apply pricing    │
                          │  - Generate invoice │
                          │                     │
                          └─────────────────────┘
```

## Implementation Details

### Schedule Assignment

The `ScheduleAssignment` widget manages multiple schedule entries, each with its own NDIS item and pricing information. When adding a new schedule entry, the widget:

1. Adds the entry to the lists (`dateList`, `startTimeList`, `endTimeList`, etc.)
2. Initializes NDIS item and custom pricing as null
3. Provides a button to select an NDIS item

When submitting the assignment, the widget:

1. Creates a `scheduleWithNdisItems` array containing all schedule entries
2. For each entry, includes the NDIS item and any custom pricing information
3. Sends this data to the backend via `_apiMethod.assignClientToUserWithScheduleItems()`

### NDIS Item Selection

The `EnhancedNdisItemSelectionView` widget provides a searchable list of NDIS items with pricing information. It:

1. Loads NDIS items from the backend or local storage
2. Fetches pricing information for each item
3. Filters items based on high-intensity flag if enabled
   - Sets `hasHighIntensityPricing` flag for items with `priceCaps['highIntensity']` not null
   - Filters `_filteredNdisItems` to only show items with high-intensity pricing when the switch is on
4. Displays the items with their standard and custom prices
5. Allows users to set custom pricing for selected items
6. Maintains high-intensity filtering during search operations
   - The `_filterNdisItems` method applies both search query filtering and high-intensity filtering
   - High-intensity filtering is reapplied after search filtering to ensure consistency

### Invoice Generation

When generating invoices, the backend:

1. Retrieves the schedule entries for the invoice period
2. For each entry, gets the NDIS item and pricing information
3. Applies pricing in the following priority order:
   - Custom pricing if available
   - High-intensity price cap if the `highIntensity` flag is true
   - Standard pricing as the fallback option
4. Calculates the total amount based on hours worked and the applicable rate
5. Includes high-intensity indicators in the invoice for relevant items

## Recent Updates: High-Intensity Filtering Fix

A recent update fixed an issue with high-intensity filtering in the NDIS item selection process:

1. **Issue**: When the high-intensity switch was enabled, selecting the NDIS Item button would still load all items instead of only high-intensity ones, particularly after performing a search.

2. **Root Cause**: The `_filterNdisItems` method was resetting `_filteredNdisItems` back to `_allNdisItems` when a search query was empty, without reapplying the high-intensity filter.

3. **Solution**:
   - Modified the `_filterNdisItems` method to apply both search query filtering and high-intensity filtering
   - Ensured high-intensity filtering is reapplied after search filtering
   - Updated the `_loadPricingData` method to reapply high-intensity filtering after pricing data is loaded

4. **Result**: The high-intensity filter now correctly persists across search operations and data reloading, ensuring only high-intensity items are displayed when the switch is enabled.

### High-Intensity Pricing Flow Diagram

```
┌─────────────────────┐     ┌───────────────────────┐     ┌─────────────────────┐
│                     │     │                       │     │                     │
│  High-Intensity     │     │  NDIS Item            │     │  Pricing            │
│  Switch Enabled     │────▶│  Selection View      │────▶│  Calculation        │
│                     │     │                       │     │                     │
└─────────────────────┘     └───────────────────────┘     └─────────────────────┘
                                       │                             │
                                       │                             │
                                       ▼                             ▼
                            ┌───────────────────────┐     ┌─────────────────────┐
                            │                       │     │                     │
                            │  Filter Items with    │     │  Apply Pricing      │
                            │  High-Intensity      │     │  Priority:          │
                            │  Pricing Available    │     │  1. Custom Price    │
                            │                       │     │  2. High-Intensity  │
                            └───────────────────────┘     │  3. Standard Price  │
                                       │                  │                     │
                                       │                  └─────────────────────┘
                                       ▼                             │
                            ┌───────────────────────┐                │
                            │                       │                │
                            │  Maintain Filter      │                │
                            │  During Search &      │                │
                            │  Data Reloading       │                │
                            │                       │                │
                            └───────────────────────┘                │
                                       │                             │
                                       └─────────────────────────────┘
                                                     │
                                                     ▼
                                        ┌─────────────────────────┐
                                        │                         │
                                        │  Invoice Generation     │
                                        │  with High-Intensity    │
                                        │  Indicators             │
                                        │                         │
                                        └─────────────────────────┘
```

## Conclusion

This document provides an overview of the data flow for employee-client scheduling and NDIS item selection with pricing in the application. For more detailed information, refer to the source code in the relevant files:

- `schedule_assignment.dart`
- `enhanced_ndis_item_selection_view.dart`
- `api_method.dart`