# Trading Name & Legal Name Persistence Analysis

## Issue Description
Users reported that the "Trading Name" and "Legal Name" fields were not persisting after editing in the Organization Edit view. Specifically, the "Trading Name" appeared as "Updateing Trading Name" (or other stale values) in the details view despite being changed in the edit view.

## Logs Analyzed
- Terminal#822-1038
- Terminal#916-1038
- Terminal#917-1038
- Terminal#918-1038 (User report: "we are sending trading name (put) but not getting trading name (get)")

## Root Cause Analysis

### 1. API Endpoint Mismatch (Critical)
- **Frontend (`api_method.dart`)**: Was sending `PUT` requests to `/organization/:organizationId`.
- **Backend (`server.js`)**: Did not have a route handler for `PUT /organization/:organizationId`. It only had `PUT /organization/:organizationId/details`.
- **Result**: The backend likely returned a 404 Not Found error. The frontend caught this error but did not display it prominently (or the user missed it), leading to the assumption that the save was successful.

### 2. Payload Key Mismatch (Legal Name)
- **Frontend**: Sent the legal name using the key `name`.
- **Backend**: The `PUT .../details` endpoint expected `organizationName` to update the name field.
- **Result**: Even if the endpoint was correct, the Legal Name would not have updated because the backend ignored the `name` key.

### 3. Missing Field in GET Response (Trading Name)
- **Backend**: The `GET /organization/:organizationId` endpoint originally did not include `tradingName` in the response object.
- **Result**: Even if the data was saved to the database, the frontend would never receive it when fetching details, causing it to fallback to the `name` or show "Not set".

## Fixes Applied

### 1. Frontend (`api_method.dart`)
- Updated `updateOrganizationDetails` method to use the correct endpoint:
  ```dart
  // Before
  Uri.parse('${_baseUrl}organization/$organizationId')
  
  // After
  Uri.parse('${_baseUrl}organization/$organizationId/details')
  ```

### 2. Backend (`server.js`)
- **Enhanced PUT Endpoint**: Modified logic to accept both `organizationName` and `name` keys for the legal name update.
  ```javascript
  // New Logic
  const newName = updates.organizationName || updates.name;
  ...((newName) ? { organizationName: newName, name: newName } : {}),
  ```
- **Enhanced GET Endpoint**: Added `tradingName` to the response object.
  ```javascript
  tradingName: organization.tradingName || null,
  ```

## Verification
- Created a reproduction test script (`test_organization_update.js`) that simulated the frontend behavior.
- Verified that `PUT` requests with `{ name, tradingName }` payloads now correctly update the database.
- Verified that `GET` requests return the updated values.
- **Status**: Verified Fixed.

## Recommendations
- Ensure all future frontend API calls match the backend route definitions.
- Consider unifying the backend route structure (e.g., using `routes/organization.js` controller-based routes) instead of defining routes directly in `server.js`.
