# Invoice Generation API Documentation

## Task 2.1: clientAssignment-based Item Extraction

This document describes the new invoice generation endpoints that implement **clientAssignment-based item extraction** to replace the previous random algorithm approach.

## Overview

The enhanced invoice generation system now uses intelligent item extraction based on actual client assignments and worked time data, ensuring:

- **Accuracy**: Line items are generated from real assignment schedules and worked time
- **NDIS Compliance**: Uses assigned NDIS item numbers from client assignments
- **Traceability**: Full audit trail of how line items were generated
- **Validation**: Comprehensive data validation before generation

## API Endpoints

### 1. Generate Invoice Line Items

**POST** `/api/invoice/generate-line-items`

Generates invoice line items based on clientAssignment data and worked time.

#### Request Body
```json
{
  "userEmail": "employee@example.com",
  "clientEmail": "client@example.com",
  "startDate": "2024-01-01",
  "endDate": "2024-01-31"
}
```

#### Response
```json
{
  "success": true,
  "message": "Invoice line items generated successfully",
  "data": {
    "lineItems": [
      {
        "itemNumber": "01_011_0107_1_1",
        "itemDescription": "Assistance with self-care activities",
        "quantity": 2.0,
        "unitPrice": 62.17,
        "totalPrice": 124.34,
        "unit": "Hour",
        "date": "2024-01-15",
        "hoursWorked": 2.0,
        "notes": "Morning care assistance",
        "userEmail": "employee@example.com",
        "clientEmail": "client@example.com",
        "organizationId": "...",
        "extractionSource": "clientAssignment",
        "assignmentId": "..."
      }
    ],
    "metadata": {
      "extractionMethod": "clientAssignment-based",
      "assignmentId": "...",
      "totalItems": 1,
      "dateRange": {
        "startDate": "2024-01-01",
        "endDate": "2024-01-31"
      },
      "generatedAt": "2024-01-15T10:30:00Z"
    }
  }
}
```

### 2. Get Invoice Preview

**GET** `/api/invoice/preview/:userEmail/:clientEmail`

Generates a preview of invoice line items without creating audit logs.

#### Query Parameters
- `startDate`: Start date (YYYY-MM-DD)
- `endDate`: End date (YYYY-MM-DD)

#### Example
```
GET /api/invoice/preview/employee@example.com/client@example.com?startDate=2024-01-01&endDate=2024-01-31
```

#### Response
```json
{
  "success": true,
  "message": "Invoice preview generated successfully",
  "data": {
    "lineItems": [...],
    "totals": {
      "totalAmount": 248.68,
      "totalHours": 4.0,
      "totalItems": 2
    },
    "isPreview": true,
    "metadata": {...}
  }
}
```

### 3. Get Available Assignments

**GET** `/api/invoice/available-assignments/:userEmail`

Retrieves all active client assignments for a user that can be used for invoice generation.

#### Response
```json
{
  "success": true,
  "message": "Available assignments retrieved successfully",
  "data": {
    "assignments": [
      {
        "assignmentId": "...",
        "clientEmail": "client@example.com",
        "clientName": "John Doe",
        "organizationId": "...",
        "assignedNdisItemNumber": "01_011_0107_1_1",
        "scheduleCount": 5,
        "createdAt": "2024-01-01T00:00:00Z",
        "hasScheduleData": true
      }
    ],
    "totalCount": 1
  }
}
```

### 4. Validate Invoice Generation Data

**POST** `/api/invoice/validate-generation-data`

Validates that all required data exists for invoice generation.

#### Request Body
```json
{
  "userEmail": "employee@example.com",
  "clientEmail": "client@example.com",
  "startDate": "2024-01-01",
  "endDate": "2024-01-31"
}
```

#### Response
```json
{
  "success": true,
  "message": "Validation completed",
  "data": {
    "validation": {
      "hasAssignment": true,
      "hasClient": true,
      "hasScheduleData": true,
      "hasWorkedTimeData": true,
      "hasNdisItem": true,
      "dateRangeValid": true,
      "canGenerateInvoice": true
    },
    "warnings": [],
    "assignmentDetails": {...},
    "clientDetails": {...}
  }
}
```

## clientAssignment-based Extraction Logic

### 1. Primary Extraction Method: Schedule Data

The system first attempts to extract line items from the `schedule` array in `clientAssignments`:

```javascript
// Example schedule entry
{
  date: "2024-01-15",
  startTime: "09:00",
  endTime: "11:00",
  notes: "Morning care assistance",
  ndisItemNumber: "01_011_0107_1_1"
}
```

**Benefits:**
- Uses pre-planned schedule data
- Includes specific NDIS item numbers
- Maintains consistency with assignment planning

### 2. Fallback Method: Worked Time Data

If no schedule data is available, the system falls back to `workedTime` collection:

```javascript
// Example worked time entry
{
  userEmail: "employee@example.com",
  clientEmail: "client@example.com",
  date: "2024-01-15",
  startTime: "09:00",
  endTime: "11:00",
  totalMinutes: 120,
  notes: "Completed care tasks"
}
```

**Benefits:**
- Uses actual worked time data
- Ensures billing accuracy
- Captures real service delivery

### 3. NDIS Item Assignment

The system uses the `assignedNdisItemNumber` from the client assignment to ensure:
- Correct NDIS item codes
- Proper pricing lookup
- Compliance with client's approved services

### 4. Pricing Calculation

Pricing is determined in this priority order:
1. **Client-specific pricing** (if available)
2. **Organization pricing** (custom rates)
3. **NDIS price caps** (standard rates)

## Key Improvements Over Random Algorithm

| Aspect | Random Algorithm | clientAssignment-based |
|--------|------------------|------------------------|
| **Data Source** | Random selection | Real assignment data |
| **Accuracy** | Unpredictable | Based on actual work |
| **NDIS Compliance** | May use wrong items | Uses assigned items |
| **Traceability** | No audit trail | Full audit logging |
| **Validation** | Minimal checks | Comprehensive validation |
| **Pricing** | Generic rates | Client-specific rates |

## Error Handling

The API provides comprehensive error handling:

### Common Error Responses

#### 400 - Validation Error
```json
{
  "success": false,
  "message": "Validation failed",
  "errors": [
    "userEmail is required",
    "Invalid date format for startDate"
  ]
}
```

#### 404 - Assignment Not Found
```json
{
  "success": false,
  "message": "No active client assignment found",
  "error": "No active assignment found for user employee@example.com and client client@example.com"
}
```

#### 404 - Client Not Found
```json
{
  "success": false,
  "message": "Client not found or inactive",
  "error": "Client not found: client@example.com"
}
```

## Testing

Use the provided test suite to verify the implementation:

```bash
# Run the test suite
node test_invoice_generation.js
```

The test suite validates:
- Data validation functionality
- Available assignments retrieval
- Invoice preview generation
- Line item generation with clientAssignment-based extraction

## Security Considerations

1. **Input Validation**: All inputs are validated for format and content
2. **Authorization**: Endpoints should be protected with proper authentication
3. **Data Access**: Users can only access their own assignments and clients
4. **Audit Logging**: All generation activities are logged for compliance

## Migration from Random Algorithm

To migrate from the random algorithm:

1. **Update Frontend**: Modify invoice generation UI to use new endpoints
2. **Data Migration**: Ensure all client assignments have proper NDIS item assignments
3. **Testing**: Run comprehensive tests to verify functionality
4. **Monitoring**: Monitor generation success rates and error patterns

## Performance Considerations

- **Database Indexing**: Ensure proper indexes on `userEmail`, `clientEmail`, and `isActive` fields
- **Connection Pooling**: Service manages MongoDB connections efficiently
- **Caching**: Consider caching NDIS item data and pricing information
- **Pagination**: Large datasets are handled with appropriate limits

## Future Enhancements

1. **Batch Processing**: Support for generating multiple invoices
2. **Template Support**: Customizable invoice templates
3. **Approval Workflow**: Multi-step approval process
4. **Integration**: Direct integration with accounting systems
5. **Analytics**: Reporting and analytics on invoice generation patterns