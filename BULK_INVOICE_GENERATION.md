# Bulk Invoice Generation with Pre-configured Pricing

This document describes the implementation of bulk invoice generation functionality that allows organizations to generate multiple invoices simultaneously using pre-configured pricing rules.

## Overview

The bulk invoice generation feature enables organizations to:
- Generate invoices for multiple clients in a single operation
- Apply pre-configured pricing automatically without manual prompts
- Process large batches efficiently with batch processing
- Maintain audit trails for bulk operations
- Handle errors gracefully with detailed reporting

## Features

### 1. Batch Processing
- Process multiple clients simultaneously
- Configurable batch sizes for optimal performance
- Progress tracking and reporting
- Error isolation (one failed invoice doesn't stop the batch)

### 2. Pre-configured Pricing
- Automatic pricing lookup from organization-specific rules
- Hierarchical pricing resolution:
  1. Organization + Client specific pricing
  2. Organization + State specific pricing
  3. Organization default pricing
  4. NDIS standard pricing (fallback)
- No manual price prompts required

### 3. Comprehensive Error Handling
- Individual client error tracking
- Detailed error messages and codes
- Partial success handling
- Rollback capabilities for critical failures

### 4. Audit and Compliance
- Complete audit trail for bulk operations
- NDIS compliance validation
- Expense inclusion with proper categorization
- Detailed reporting and statistics

## Implementation Details

### Modified Files

#### 1. `invoice_generation_service.js`
- **New Methods Added:**
  - `generateBulkInvoices()` - Main bulk generation orchestrator
  - `generateSingleInvoiceForBulk()` - Individual invoice generation within bulk process
  - `validateBulkGenerationParams()` - Input validation for bulk operations
  - `getPricingForItem()` - Hierarchical pricing lookup
  - `getNdisStandardPricing()` - NDIS standard pricing fallback

#### 2. `invoice_generation_endpoints.js`
- **New Endpoint:** `POST /api/invoice/generate-bulk-invoices`
- Input validation and sanitization
- Audit logging for bulk operations
- Error handling and response formatting

#### 3. `server.js`
- Route registration for bulk invoice generation endpoint
- Import statements for new functionality

### API Endpoint

#### POST /api/invoice/generate-bulk-invoices

**Request Body:**
```json
{
  "organizationId": "org_12345",
  "userEmail": "user@example.com",
  "clients": [
    {
      "clientEmail": "client1@example.com",
      "startDate": "2024-01-01",
      "endDate": "2024-01-31"
    },
    {
      "clientEmail": "client2@example.com",
      "startDate": "2024-01-01",
      "endDate": "2024-01-31"
    }
  ]
}
```

**Response Format:**
```json
{
  "success": true,
  "results": [
    {
      "clientEmail": "client1@example.com",
      "success": true,
      "invoice": {
        "lineItems": [...],
        "summary": {
          "totalAmount": 1250.00,
          "serviceAmount": 1200.00,
          "expenseAmount": 50.00,
          "totalItems": 15,
          "serviceItems": 12,
          "expenseItems": 3
        },
        "metadata": {
          "generatedAt": "2024-01-15T10:30:00Z",
          "generatedBy": "user@example.com",
          "organizationId": "org_12345",
          "clientEmail": "client1@example.com",
          "dateRange": {
            "startDate": "2024-01-01",
            "endDate": "2024-01-31"
          },
          "pricingApplied": "pre-configured",
          "ndisCompliant": true
        }
      }
    },
    {
      "clientEmail": "client2@example.com",
      "success": false,
      "error": "No worked time data found for the specified period",
      "errorCode": "NO_DATA"
    }
  ],
  "summary": {
    "totalClients": 2,
    "successfulInvoices": 1,
    "failedInvoices": 1,
    "totalProcessingTime": "2.5s",
    "batchSize": 10
  },
  "auditId": "audit_67890"
}
```

## Pricing Resolution Logic

The system uses a hierarchical approach to resolve pricing:

```javascript
// 1. Organization + Client specific
const clientSpecific = await pricing.findOne({
  organizationId,
  clientEmail,
  supportItemNumber,
  isApproved: true
});

// 2. Organization + State specific
const stateSpecific = await pricing.findOne({
  organizationId,
  supportItemNumber,
  state,
  providerType,
  isApproved: true
});

// 3. Organization default
const orgDefault = await pricing.findOne({
  organizationId,
  supportItemNumber,
  isApproved: true
});

// 4. NDIS standard pricing (fallback)
const ndisStandard = getNdisStandardPricing(supportItemNumber);
```

## Usage Examples

### Basic Bulk Generation
```javascript
const response = await fetch('/api/invoice/generate-bulk-invoices', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    organizationId: 'org_12345',
    userEmail: 'manager@example.com',
    clients: [
      {
        clientEmail: 'client1@example.com',
        startDate: '2024-01-01',
        endDate: '2024-01-31'
      },
      {
        clientEmail: 'client2@example.com',
        startDate: '2024-01-01',
        endDate: '2024-01-31'
      }
    ]
  })
});

const result = await response.json();
console.log(`Generated ${result.summary.successfulInvoices} invoices successfully`);
```

### Processing Results
```javascript
result.results.forEach(clientResult => {
  if (clientResult.success) {
    console.log(`✅ Invoice generated for ${clientResult.clientEmail}`);
    console.log(`   Total: $${clientResult.invoice.summary.totalAmount}`);
    console.log(`   Items: ${clientResult.invoice.summary.totalItems}`);
  } else {
    console.log(`❌ Failed for ${clientResult.clientEmail}: ${clientResult.error}`);
  }
});
```

## Testing

A comprehensive test suite is available in `test_bulk_invoice_generation.js`:

```bash
# Run bulk invoice generation tests
node backend/test_bulk_invoice_generation.js
```

### Test Coverage
- **Input Validation:** Tests parameter validation and error handling
- **Pricing Lookup:** Tests hierarchical pricing resolution
- **Bulk Processing:** Tests multi-client invoice generation
- **Error Handling:** Tests partial failures and error isolation
- **Data Integration:** Tests with realistic test data including expenses

## Configuration

### Environment Variables
```bash
# MongoDB connection for pricing and client data
MONGODB_URI=mongodb://localhost:27017/invoice_system

# Batch processing configuration
BULK_INVOICE_BATCH_SIZE=10
BULK_INVOICE_TIMEOUT=300000  # 5 minutes
```

### Database Collections Used
- `clients` - Client information and NDIS details
- `clientAssignments` - User-client relationships
- `workedTime` - Time tracking data for services
- `expenses` - Approved expenses for inclusion
- `pricing` - Organization-specific pricing rules
- `auditLogs` - Audit trail for bulk operations

## Error Handling

### Common Error Codes
- `VALIDATION_ERROR` - Invalid input parameters
- `NO_DATA` - No worked time or assignment data found
- `PRICING_ERROR` - Unable to resolve pricing for items
- `DATABASE_ERROR` - Database connection or query issues
- `TIMEOUT_ERROR` - Processing timeout exceeded

### Error Recovery
- Individual client failures don't stop batch processing
- Detailed error messages for troubleshooting
- Audit logs for tracking and debugging
- Retry mechanisms for transient failures

## Performance Considerations

### Optimization Strategies
1. **Batch Processing:** Process clients in configurable batches
2. **Connection Pooling:** Reuse database connections
3. **Parallel Processing:** Process independent clients simultaneously
4. **Caching:** Cache pricing rules and client data
5. **Indexing:** Ensure proper database indexes for queries

### Monitoring
- Processing time tracking
- Success/failure rate monitoring
- Resource usage monitoring
- Audit log analysis

## Security Considerations

### Access Control
- Organization-level access restrictions
- User permission validation
- Audit logging for compliance

### Data Protection
- Input sanitization and validation
- SQL injection prevention
- Sensitive data handling

## Future Enhancements

### Planned Features
1. **Scheduled Bulk Generation:** Automated recurring bulk invoice generation
2. **Advanced Filtering:** More sophisticated client selection criteria
3. **Export Integration:** Direct export to accounting systems
4. **Real-time Progress:** WebSocket-based progress updates
5. **Template Support:** Customizable invoice templates for bulk generation

### Performance Improvements
1. **Streaming Processing:** Handle very large client lists
2. **Distributed Processing:** Multi-server bulk processing
3. **Advanced Caching:** Redis-based caching for pricing rules
4. **Queue Management:** Background job processing with queues

## Integration Points

### Existing Systems
- **Invoice Generation Service:** Leverages existing single invoice logic
- **Pricing Management:** Uses organization pricing rules
- **Expense Management:** Includes approved expenses automatically
- **Audit System:** Comprehensive audit trail integration

### External Systems
- **NDIS Price Guide:** Fallback pricing from official NDIS rates
- **Accounting Software:** Export capabilities for generated invoices
- **Notification System:** Bulk operation completion notifications

## Troubleshooting

### Common Issues

1. **No Pricing Found**
   - Verify organization has pricing rules configured
   - Check NDIS item numbers are valid
   - Ensure pricing rules are approved

2. **Timeout Errors**
   - Reduce batch size
   - Check database performance
   - Verify network connectivity

3. **Partial Failures**
   - Review individual client error messages
   - Check client assignment data
   - Verify worked time data exists

### Debug Mode
Enable detailed logging by setting:
```bash
DEBUG_BULK_INVOICE=true
```

This provides:
- Detailed processing logs
- Timing information
- Database query logs
- Error stack traces

## Support

For issues or questions regarding bulk invoice generation:
1. Check the test suite for examples
2. Review audit logs for detailed error information
3. Consult the API documentation for parameter requirements
4. Contact the development team with specific error codes and audit IDs