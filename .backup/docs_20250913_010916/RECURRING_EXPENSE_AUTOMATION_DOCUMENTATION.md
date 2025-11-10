# Recurring Expense Automation Service Documentation

## Overview

The Recurring Expense Automation Service is a comprehensive system that automatically creates and manages recurring expenses based on predefined templates. This service is part of Task 1.7 implementation and provides automated expense generation, scheduling, and management capabilities.

## Core Components

### 1. Recurring Expense Service (`backend/recurring_expense_service.js`)
The main service module that handles all recurring expense operations.

### 2. Recurring Expense Endpoints (`backend/recurring_expense_endpoints.js`)
REST API endpoints for managing recurring expenses.

### 3. Recurring Expense Scheduler (`backend/recurring_expense_scheduler.js`)
Scheduler service using node-cron for automated processing.

### 4. Test Suite (`backend/test_recurring_expenses.js`)
Comprehensive testing for all recurring expense functionality.

## Key Features

### Automated Expense Creation
- **Frequency Support**: Daily, weekly, monthly, yearly
- **Custom Intervals**: Support for custom intervals (e.g., every 2 weeks, every 3 months)
- **End Date Control**: Optional end dates for recurring expenses
- **Occurrence Limits**: Maximum number of occurrences
- **Smart Scheduling**: Automatic calculation of next occurrence dates

### Template Management
- **Create Templates**: Define recurring expense templates with all necessary details
- **Update Templates**: Modify existing templates with automatic recalculation
- **Deactivate Templates**: Safely disable recurring expenses
- **Retrieve Templates**: Query and filter recurring expense templates

### Scheduling & Automation
- **Daily Scheduler**: Automatic processing at 6:00 AM daily
- **Custom Scheduling**: Support for custom cron expressions
- **Manual Triggers**: On-demand processing capabilities
- **Multi-Organization**: Process all organizations or specific ones

### Audit Trail Integration
- **Automatic Logging**: All operations are logged to audit trail
- **Detailed Tracking**: Track creation, updates, and processing
- **System Attribution**: Scheduled operations attributed to system user

## API Endpoints

### Process Due Expenses
```http
POST /api/recurring-expenses/process
Content-Type: application/json

{
  "organizationId": "org-123" // Optional, processes all if not provided
}
```

**Response:**
```json
{
  "success": true,
  "processed": 5,
  "created": 3,
  "updated": 2,
  "errors": []
}
```

### Create Recurring Expense Template
```http
POST /api/recurring-expenses
Content-Type: application/json

{
  "organizationId": "org-123",
  "clientId": "client-456",
  "expenseType": "recurring",
  "category": "utilities",
  "subcategory": "internet",
  "description": "Monthly internet bill",
  "amount": 89.99,
  "currency": "AUD",
  "supportItemNumber": "UT001",
  "supportItemName": "Internet Service",
  "isReimbursable": false,
  "requiresApproval": true,
  "recurringConfig": {
    "frequency": "monthly",
    "interval": 1,
    "startDate": "2024-01-01",
    "endDate": null,
    "maxOccurrences": null,
    "isActive": true
  },
  "notes": "Monthly internet service charge",
  "createdBy": "user@example.com"
}
```

### Get Recurring Expenses
```http
GET /api/recurring-expenses/{organizationId}?active=true&frequency=monthly&limit=10&offset=0
```

### Update Recurring Expense
```http
PUT /api/recurring-expenses/{expenseId}
Content-Type: application/json

{
  "amount": 99.99,
  "description": "Updated monthly internet bill",
  "recurringConfig": {
    "frequency": "monthly",
    "interval": 1,
    "isActive": true
  },
  "updatedBy": "user@example.com"
}
```

### Deactivate Recurring Expense
```http
DELETE /api/recurring-expenses/{expenseId}
Content-Type: application/json

{
  "userEmail": "user@example.com",
  "reason": "Service discontinued"
}
```

### Get Statistics
```http
GET /api/recurring-expenses/{organizationId}/stats
```

**Response:**
```json
{
  "totalRecurring": 15,
  "activeRecurring": 12,
  "totalMonthlyAmount": 1250.00,
  "byFrequency": {
    "monthly": {
      "count": 8,
      "activeCount": 7,
      "totalAmount": 890.00
    },
    "weekly": {
      "count": 4,
      "activeCount": 3,
      "totalAmount": 240.00
    }
  }
}
```

## Recurring Configuration Schema

```javascript
{
  frequency: 'daily' | 'weekly' | 'monthly' | 'yearly',
  interval: Number, // e.g., 1 for every month, 2 for every 2 months
  startDate: Date, // When recurring should start
  endDate: Date | null, // Optional end date
  nextOccurrence: Date, // Calculated next occurrence
  maxOccurrences: Number | null, // Optional maximum occurrences
  currentOccurrence: Number, // Current occurrence count
  isActive: Boolean // Whether the recurring expense is active
}
```

## Frequency Calculations

### Daily
- **Formula**: `currentDate + (interval * days)`
- **Example**: Every 2 days = current date + 2 days

### Weekly
- **Formula**: `currentDate + (interval * 7 days)`
- **Example**: Every 2 weeks = current date + 14 days

### Monthly
- **Formula**: `currentDate + (interval * months)`
- **Example**: Every 3 months = current date + 3 months
- **Note**: Handles month-end dates properly (e.g., Jan 31 → Feb 28/29)

### Yearly
- **Formula**: `currentDate + (interval * years)`
- **Example**: Every 2 years = current date + 2 years
- **Note**: Handles leap years correctly

## Scheduler Configuration

### Default Schedule
- **Daily Processing**: 6:00 AM (Australia/Sydney timezone)
- **Cron Expression**: `0 6 * * *`

### Custom Scheduling
```javascript
const scheduler = startCustomScheduler('0 */6 * * *', 'Every 6 hours processing');
```

### Manual Processing
```javascript
const result = await manualTrigger();
console.log(`Processed ${result.totalExpensesCreated} new expenses`);
```

## Security Features

### Authentication
- All endpoints require valid user authentication
- Organization-based access control
- User email validation against organization membership

### Data Validation
- Required field validation
- Amount and date format validation
- Frequency and interval validation
- Organization and client ID validation

### Audit Logging
- All operations logged with user attribution
- Detailed before/after values for updates
- System operations clearly marked
- Timestamp and reason tracking

## Error Handling

### Common Error Responses

#### 400 Bad Request
```json
{
  "error": "Missing required fields",
  "details": ["organizationId", "amount", "recurringConfig"]
}
```

#### 403 Forbidden
```json
{
  "error": "User not authorized for this organization"
}
```

#### 404 Not Found
```json
{
  "error": "Recurring expense not found"
}
```

#### 500 Internal Server Error
```json
{
  "error": "Database connection failed",
  "details": "Connection timeout"
}
```

## Performance Considerations

### Database Optimization
- Indexed fields: `organizationId`, `isRecurring`, `recurringConfig.isActive`
- Efficient queries using compound indexes
- Pagination support for large datasets

### Processing Efficiency
- Batch processing for multiple organizations
- Parallel processing where possible
- Error isolation (one failed organization doesn't stop others)

### Memory Management
- Connection pooling for database operations
- Proper cleanup of resources
- Streaming for large result sets

## Testing

### Test Coverage
- ✅ Create recurring expense templates
- ✅ Retrieve recurring expenses with filters
- ✅ Process due recurring expenses
- ✅ Update recurring expense templates
- ✅ Get recurring expense statistics
- ✅ Deactivate recurring expenses
- ✅ Scheduler functions and validation
- ✅ Error handling and edge cases

### Running Tests
```bash
# Run all tests
node backend/test_recurring_expenses.js

# Run specific test
node backend/test_recurring_expenses.js testCreateRecurringExpense
```

## Integration with Existing Systems

### Expense Management
- Seamless integration with existing expense endpoints
- Maintains all existing expense fields and validation
- Compatible with approval workflows

### Invoice Generation
- Recurring expenses can be included in invoices
- Automatic categorization and client assignment
- Support for reimbursable and non-reimbursable expenses

### Audit Trail
- All recurring expense operations logged
- Integration with existing audit trail service
- Detailed tracking of automated vs manual operations

## Troubleshooting

### Common Issues

#### Recurring Expenses Not Processing
1. Check if scheduler is running
2. Verify `nextOccurrence` dates are in the past
3. Ensure `isActive` is true in `recurringConfig`
4. Check for database connection issues

#### Incorrect Next Occurrence Calculation
1. Verify frequency and interval values
2. Check timezone settings
3. Validate start date format
4. Review month-end date handling

#### Authentication Errors
1. Verify user exists in organization
2. Check organization ID format
3. Validate user email format
4. Ensure proper request headers

### Debug Mode
```javascript
// Enable detailed logging
process.env.DEBUG_RECURRING_EXPENSES = 'true';
```

## Future Enhancements

### Planned Features
- **Business Day Handling**: Skip weekends and holidays
- **Prorated Amounts**: Handle partial periods
- **Currency Conversion**: Multi-currency support
- **Notification System**: Email alerts for processed expenses
- **Advanced Scheduling**: Complex scheduling rules
- **Bulk Operations**: Import/export recurring expense templates

### API Versioning
- Current version: v1
- Backward compatibility maintained
- Deprecation notices for breaking changes

## Dependencies

### Required Packages
- `node-cron`: ^3.0.3 - Cron job scheduling
- `mongodb`: ^6.0.0 - Database operations
- `express`: ^4.18.0 - Web framework
- `dotenv`: ^16.0.0 - Environment configuration

### Installation
```bash
npm install node-cron mongodb express dotenv
```

## Configuration

### Environment Variables
```bash
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/
SCHEDULER_TIMEZONE=Australia/Sydney
DEBUG_RECURRING_EXPENSES=false
```

### Server Integration
The recurring expense endpoints are automatically integrated into the main server (`backend/server.js`) and available at:
- Base URL: `/api/recurring-expenses`
- All endpoints follow RESTful conventions
- CORS enabled for cross-origin requests

---

**Task 1.7 Status**: ✅ **COMPLETED**

The recurring expense automation service has been successfully implemented with:
- ✅ Core service functionality
- ✅ REST API endpoints
- ✅ Automated scheduling
- ✅ Comprehensive testing
- ✅ Audit trail integration
- ✅ Error handling and validation
- ✅ Documentation and examples

The service is ready for production use and provides a robust foundation for automated recurring expense management.