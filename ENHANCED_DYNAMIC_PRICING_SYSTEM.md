# Enhanced Dynamic Price Lookup System

## Overview

The Enhanced Dynamic Price Lookup System implements a comprehensive pricing hierarchy with integrated NDIS compliance validation for invoice generation. This system ensures accurate, compliant, and traceable pricing for all NDIS support items.

## Pricing Hierarchy

The system follows a strict priority order for price lookup:

1. **Client-Specific Pricing** (Highest Priority)
   - Custom pricing configured specifically for a client
   - Requires approval and NDIS compliance validation
   - Stored in `customPricing` collection with `clientId` field

2. **Organization Pricing** (Medium Priority)
   - Custom pricing configured at organization level
   - Applied when no client-specific pricing exists
   - Stored in `customPricing` collection without `clientId` field

3. **NDIS Standard Pricing** (Lowest Priority)
   - Official NDIS price caps and standard rates
   - State-specific and provider-type-specific pricing
   - Always NDIS compliant by definition

## Enhanced Features

### 1. NDIS Compliance Validation

- **Real-time Validation**: All custom pricing is validated against current NDIS price caps
- **State-Specific Caps**: Supports different price caps for different states
- **Provider Type Support**: Handles standard and high-intensity provider pricing
- **Compliance Reporting**: Detailed validation results with specific compliance issues

### 2. Comprehensive Price Information

Each pricing lookup returns:

```javascript
{
  price: 150.00,
  source: 'client-specific', // 'client-specific', 'organization', 'ndis-standard'
  isCustom: true,
  ndisCompliant: true,
  exceedsNdisCap: false,
  priceCap: 180.00,
  validationDetails: {
    isValid: true,
    status: 'valid',
    priceCap: 180.00,
    // ... additional validation details
  },
  supportItemDetails: {
    supportItemName: 'Personal Care/Personal Activity',
    supportType: 'Core',
    unit: 'Hour',
    quoteRequired: false
  }
}
```

### 3. Enhanced Validation System

The system includes comprehensive validation for:

- **Price Cap Compliance**: Ensures custom pricing doesn't exceed NDIS caps
- **Missing Pricing**: Identifies items without pricing information
- **Invalid Quantities**: Validates line item quantities
- **Custom Pricing Approval**: Checks approval status for custom pricing
- **Data Integrity**: Validates all pricing-related data

## API Enhancements

### Enhanced Endpoints

#### 1. Generate Invoice Line Items
```
POST /api/invoice/generate-line-items
```

**Enhanced Response:**
```javascript
{
  "success": true,
  "data": {
    "lineItems": [...],
    "validation": {
      "isValid": true,
      "totalItems": 15,
      "validItems": 14,
      "invalidItems": 1,
      "errors": ["Item 01_011_0107_1_1: Price exceeds NDIS cap"],
      "warnings": ["Item 01_015_0107_1_1: Custom pricing compliance issue"]
    },
    "summary": {
      "totalItems": 15,
      "validItems": 14,
      "invalidItems": 1,
      "totalAmount": 2450.00,
      "ndisCompliant": false
    }
  }
}
```

#### 2. Get Invoice Preview
```
GET /api/invoice/preview
```

**Enhanced Response:**
```javascript
{
  "success": true,
  "data": {
    "preview": [...], // First 10 items
    "validation": {
      "isValid": false,
      "errors": ["Item 01_011_0107_1_1: Price exceeds NDIS cap"],
      "warnings": ["Item 01_015_0107_1_1: Custom pricing compliance issue"],
      "summary": {
        "totalItems": 15,
        "validItems": 14,
        "invalidItems": 1
      }
    },
    "summary": {
      "totalItems": 15,
      "validItems": 14,
      "invalidItems": 1,
      "ndisCompliant": false,
      "complianceIssues": {
        "errors": 1,
        "warnings": 1
      }
    }
  }
}
```

#### 3. Validate Invoice Generation Data
```
POST /api/invoice/validate-generation-data
```

**Enhanced Request:**
```javascript
{
  "organizationId": "org123",
  "clientId": "client456",
  "startDate": "2024-01-01",
  "endDate": "2024-01-31",
  "validatePricing": true // New parameter
}
```

**Enhanced Response:**
```javascript
{
  "success": true,
  "data": {
    "hasAssignments": true,
    "assignmentCount": 3,
    "estimatedLineItems": 15,
    "pricingValidation": {
      "isValid": false,
      "totalItems": 15,
      "validItems": 14,
      "invalidItems": 1,
      "errorCount": 1,
      "warningCount": 1,
      "ndisCompliant": false
    },
    "recommendations": [
      {
        "type": "error",
        "message": "1 pricing issues found",
        "action": "Review custom pricing and NDIS compliance before generating invoice"
      }
    ]
  }
}
```

## Implementation Details

### Core Service Method

```javascript
async getPricingForItem(ndisItemNumber, organizationId, clientId, state = 'NSW', providerType = 'standard') {
  // 1. Check client-specific pricing with validation
  // 2. Check organization pricing with validation
  // 3. Fall back to NDIS standard pricing
  // 4. Return comprehensive pricing information
}
```

### Validation Integration

```javascript
async validateInvoiceLineItems(lineItems) {
  // Comprehensive validation including:
  // - Price cap compliance
  // - Missing pricing detection
  // - Custom pricing approval status
  // - Data integrity checks
}
```

## Benefits

### 1. Enhanced Compliance
- **Real-time NDIS Validation**: Immediate feedback on pricing compliance
- **Audit Trail**: Complete tracking of pricing decisions and validations
- **Risk Mitigation**: Prevents non-compliant invoices from being generated

### 2. Improved Accuracy
- **State-Specific Pricing**: Accurate pricing based on service location
- **Provider Type Support**: Correct pricing for different provider categories
- **Comprehensive Validation**: Multiple layers of data validation

### 3. Better User Experience
- **Clear Feedback**: Detailed validation results and recommendations
- **Proactive Warnings**: Early detection of pricing issues
- **Actionable Insights**: Specific guidance for resolving issues

### 4. Operational Efficiency
- **Automated Validation**: Reduces manual review requirements
- **Batch Processing**: Efficient validation of multiple line items
- **Integration Ready**: Seamless integration with existing workflows

## Error Handling

The system provides comprehensive error handling:

- **Pricing Errors**: Clear messages for pricing-related issues
- **Validation Errors**: Detailed validation failure information
- **System Errors**: Graceful handling of technical failures
- **Fallback Mechanisms**: Safe defaults when primary systems fail

## Security Considerations

- **Access Control**: Pricing information access based on user permissions
- **Audit Logging**: Complete audit trail for all pricing operations
- **Data Validation**: Input validation to prevent malicious data
- **Error Sanitization**: Safe error messages without sensitive information

## Performance Optimizations

- **Caching**: Intelligent caching of NDIS pricing data
- **Batch Operations**: Efficient processing of multiple items
- **Database Indexing**: Optimized queries for pricing lookups
- **Async Processing**: Non-blocking validation operations

## Future Enhancements

1. **Machine Learning Integration**: Predictive pricing recommendations
2. **Advanced Analytics**: Pricing trend analysis and reporting
3. **Real-time NDIS Updates**: Automatic synchronization with NDIS pricing changes
4. **Multi-Currency Support**: Support for different currencies and regions
5. **Advanced Approval Workflows**: Complex approval processes for custom pricing

## Migration and Deployment

The enhanced system is backward compatible and includes:

- **Gradual Migration**: Phased rollout of new features
- **Data Migration**: Safe migration of existing pricing data
- **Testing Framework**: Comprehensive testing for all pricing scenarios
- **Monitoring**: Real-time monitoring of pricing system performance

## Conclusion

The Enhanced Dynamic Price Lookup System provides a robust, compliant, and efficient solution for NDIS invoice pricing. It ensures accuracy, maintains compliance, and provides clear feedback to users while supporting the complex requirements of NDIS service delivery.