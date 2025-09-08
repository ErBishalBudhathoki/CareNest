# API Surface Documentation

This document provides a comprehensive overview of all API endpoints available in the Invoice Management System backend.

## Overview

The backend exposes **95+ REST API endpoints** organized into the following functional areas:

- **Authentication & User Management** (12 endpoints)
- **Organization Management** (8 endpoints) 
- **Client Management** (10 endpoints)
- **Business Management** (3 endpoints)
- **Timer & Employee Tracking** (8 endpoints)
- **Invoice Generation** (12 endpoints)
- **Custom Pricing** (10 endpoints)
- **Expense Management** (8 endpoints)
- **Price Validation** (6 endpoints)
- **Audit Trail** (6 endpoints)
- **Recurring Expenses** (7 endpoints)
- **Price Prompts** (6 endpoints)
- **Backward Compatibility** (7 endpoints)
- **File Upload & Utilities** (5 endpoints)
- **Support Items** (2 endpoints)
- **Notifications** (3 endpoints)
- **Holidays** (4 endpoints)

## Base URL

```
Production: https://your-production-domain.com
Development: http://localhost:8080
```

## Authentication

Most endpoints require authentication via:
- `userEmail` parameter
- `organizationId` parameter
- Some endpoints use middleware authentication (see `auth.js` middleware)

## API Endpoints

### Authentication & User Management

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/checkEmail/:email` | Check if email exists | No |
| GET | `/getClientDetails/:email` | Get client details by email | No |
| POST | `/signup/:email` | User registration | No |
| POST | `/login` | User authentication | No |
| GET | `/getUserPhoto/:email` | Get user profile photo | No |
| GET | `/initData/:email` | Get user initialization data | No |
| POST | `/uploadPhoto` | Upload user profile photo | Yes |
| POST | `/getSalt` | Get password salt for hashing | No |
| POST | `/sendOTP` | Send OTP for password reset | No |
| POST | `/verifyOTP` | Verify OTP code | No |
| POST | `/updatePassword` | Update user password | Yes |
| GET | `/getUsers/` | Get all users | Yes |

### Organization Management

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/organization/create` | Create new organization | No |
| POST | `/createOrganization` | Alternative organization creation | No |
| POST | `/organization/verify-code` | Verify organization code | No |
| GET | `/organization/verify/:organizationCode` | Verify organization by code | No |
| GET | `/verifyOrganizationCode/:code` | Alternative code verification | No |
| GET | `/organization/:organizationId` | Get organization details | Yes |
| GET | `/organization/:organizationId/members` | Get organization members | Yes |
| GET | `/organization/:organizationId/employees` | Get organization employees | Yes |

### Client Management

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/addClient` | Add new client | Yes |
| GET | `/organization/:organizationId/clients` | Get organization clients | Yes |
| GET | `/clients/:organizationId` | Alternative client listing | Yes |
| GET | `/getClients` | Get clients (legacy) | Yes |
| GET | `/getMultipleClients/:emails` | Get multiple clients by emails | Yes |
| POST | `/assignClientToUser` | Assign client to user | Yes |
| GET | `/getUserAssignments/:userEmail` | Get user's client assignments | Yes |
| GET | `/getOrganizationAssignments/:organizationId` | Get organization assignments | Yes |
| DELETE | `/removeClientAssignment` | Remove client assignment | Yes |
| POST | `/fixClientOrganizationId` | Fix client organization ID | Yes |

### Business Management

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/addBusiness` | Add new business | Yes |
| GET | `/businesses/:organizationId` | Get organization businesses | Yes |
| GET | `/organization/:organizationId/businesses` | Alternative business listing | Yes |

### Timer & Employee Tracking

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/startTimer` | Start work timer | Yes |
| POST | `/stopTimer` | Stop work timer | Yes |
| POST | `/startTimerWithTracking` | Start timer with tracking | Yes |
| POST | `/stopTimerWithTracking` | Stop timer with tracking | Yes |
| GET | `/getActiveTimers/:organizationId` | Get active timers | Yes |
| POST | `/setWorkedTime` | Set worked time manually | Yes |
| GET | `/getWorkedTime/:userEmail/:clientEmail` | Get worked time records | Yes |
| GET | `/getEmployeeTrackingData/:organizationId` | Get employee tracking data | Yes |

### Invoice Generation

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/invoice/generate-line-items` | Generate invoice line items | Yes |
| POST | `/api/invoice/generate-bulk-invoices` | Generate bulk invoices | Yes |
| POST | `/api/invoice/validate-line-items` | Validate existing line items | Yes |
| POST | `/api/invoice/validate-pricing-realtime` | Real-time pricing validation | Yes |
| POST | `/api/invoice/validation-report` | Get validation report | Yes |
| GET | `/api/invoice/preview/:userEmail/:clientEmail` | Get invoice preview | Yes |
| GET | `/assigned-client-data` | Get assigned client data | Yes |
| GET | `/api/invoice/available-assignments/:userEmail` | Get available assignments | Yes |
| POST | `/api/invoice/validate-generation-data` | Validate generation data | Yes |
| GET | `/getLineItems/` | Get line items (legacy) | Yes |
| GET | `/loadAppointments/:email` | Load appointments | Yes |
| GET | `/loadAppointmentDetails/:userEmail/:clientEmail` | Load appointment details | Yes |

### Custom Pricing

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/pricing/create` | Create custom pricing | Yes |
| GET | `/api/pricing/organization/:organizationId` | Get organization pricing | Yes |
| GET | `/api/pricing/:pricingId` | Get pricing by ID | Yes |
| PUT | `/api/pricing/:pricingId` | Update custom pricing | Yes |
| DELETE | `/api/pricing/:pricingId` | Delete custom pricing | Yes |
| PUT | `/api/pricing/:pricingId/approval` | Update pricing approval | Yes |
| GET | `/api/pricing/lookup/:organizationId/:supportItemNumber` | Pricing lookup | Yes |
| POST | `/api/pricing/bulk-lookup` | Bulk pricing lookup | Yes |
| POST | `/api/pricing/bulk-import` | Bulk import pricing | Yes |
| GET | `/custom-price-organization/:ndisItemNumber` | Get org custom price (legacy) | Yes |
| GET | `/custom-price-client/:ndisItemNumber/:clientId` | Get client custom price (legacy) | Yes |
| POST | `/save-custom-price-organization` | Save org custom price (legacy) | Yes |
| POST | `/save-custom-price-client` | Save client custom price (legacy) | Yes |

### Expense Management

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/expenses/create` | Create expense | Yes |
| GET | `/api/expenses/categories` | Get expense categories | Yes |
| GET | `/api/expenses/organization/:organizationId` | Get organization expenses | Yes |
| GET | `/api/expenses/:expenseId` | Get expense by ID | Yes |
| PUT | `/api/expenses/:expenseId` | Update expense | Yes |
| DELETE | `/api/expenses/:expenseId` | Delete expense | Yes |
| PUT | `/api/expenses/:expenseId/approval` | Update expense approval | Yes |
| POST | `/api/expenses/bulk-import` | Bulk import expenses | Yes |

### Price Validation

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/price-validation/validate` | Validate single price | Yes |
| POST | `/api/price-validation/validate-batch` | Validate multiple prices | Yes |
| GET | `/api/price-validation/caps/:supportItemNumber` | Get price caps | Yes |
| GET | `/api/price-validation/quote-required/:supportItemNumber` | Check if quote required | Yes |
| POST | `/api/price-validation/validate-invoice` | Validate invoice prices | Yes |
| GET | `/api/price-validation/stats` | Get validation statistics | Yes |

### Audit Trail

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/api/audit/entity/:entityType/:entityId` | Get entity audit history | Yes |
| GET | `/api/audit/organization/:organizationId` | Get organization audit logs | Yes |
| GET | `/api/audit/statistics/:organizationId` | Get audit statistics | Yes |
| POST | `/api/audit/log` | Create audit log entry | Yes |
| GET | `/api/audit/metadata` | Get audit metadata | Yes |
| GET | `/api/audit/export/:organizationId` | Export audit logs | Yes |

### Recurring Expenses

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/recurring-expenses/process` | Process recurring expenses | Yes |
| POST | `/api/recurring-expenses/create` | Create recurring expense | Yes |
| GET | `/api/recurring-expenses/organization/:organizationId` | Get organization recurring expenses | Yes |
| GET | `/api/recurring-expenses/:expenseId` | Get recurring expense by ID | Yes |
| PUT | `/api/recurring-expenses/:expenseId` | Update recurring expense | Yes |
| PUT | `/api/recurring-expenses/:expenseId/deactivate` | Deactivate recurring expense | Yes |
| GET | `/api/recurring-expenses/statistics/:organizationId` | Get recurring expense statistics | Yes |

### Price Prompts

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/invoice/price-prompt/create` | Create price prompt | Yes |
| POST | `/api/invoice/price-prompt/resolve` | Resolve price prompt | Yes |
| GET | `/api/invoice/price-prompt/pending/:sessionId` | Get pending prompts | Yes |
| POST | `/api/invoice/price-prompt/cancel` | Cancel price prompt | Yes |
| POST | `/api/invoice/generate-with-prompts` | Generate invoice with prompts | Yes |
| POST | `/api/invoice/complete-generation` | Complete invoice generation | Yes |

### Backward Compatibility

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/invoice/process-legacy` | Process legacy invoice | Yes |
| POST | `/api/invoice/validate-legacy` | Validate legacy compatibility | Yes |
| POST | `/api/invoice/transform-legacy` | Transform legacy invoice | Yes |
| POST | `/api/invoice/migrate-legacy-batch` | Migrate legacy invoices batch | Yes |
| GET | `/api/invoice/legacy-stats` | Get legacy data statistics | Yes |
| POST | `/api/invoice/map-legacy-item` | Map legacy item to NDIS | Yes |
| GET | `/api/invoice/:invoiceId/compatibility` | Check invoice compatibility | Yes |

### File Upload & Utilities

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/upload/receipt` | Upload receipt file | Yes |
| POST | `/addUpdateInvoicingEmailDetail` | Add/update invoicing email | Yes |
| POST | `/invoicingEmailDetailKey` | Store invoicing email key | Yes |
| GET | `/getInvoicingEmailDetails` | Get invoicing email details | Yes |
| GET | `/checkInvoicingEmailKey` | Check invoicing email key | Yes |

### Support Items

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/api/support-items/search` | Search support items | Yes |
| GET | `/api/support-items/all` | Get all support items | Yes |

### Notifications

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/registerFcmToken` | Register FCM token | Yes |
| POST | `/sendNotification` | Send notification | Yes |
| POST | `/getEmailDetailToSendEmail` | Get email details for sending | Yes |

### Holidays

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/getHolidays` | Get holidays | Yes |
| POST | `/uploadCSV` | Upload holiday CSV | Yes |
| DELETE | `/deleteHoliday/:id` | Delete holiday | Yes |
| POST | `/addHolidayItem` | Add holiday item | Yes |
| POST | `/check-holidays` | Check holidays | Yes |

### Utility Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | Health check | No |
| GET | `/hello` | Hello world | No |
| POST | `/addNotes` | Add notes | Yes |

## Request/Response Formats

### Standard Response Format

```json
{
  "success": true|false,
  "message": "Description of result",
  "data": {}, // Response data (varies by endpoint)
  "error": "Error message" // Only present on errors
}
```

### Authentication Headers

Most endpoints expect these parameters:

```json
{
  "userEmail": "user@example.com",
  "organizationId": "org_id_here"
}
```

### File Upload Format

File upload endpoints use `multipart/form-data`:

```
Content-Type: multipart/form-data
```

## Error Handling

### HTTP Status Codes

- `200` - Success
- `400` - Bad Request (validation errors)
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Internal Server Error

### Error Response Format

```json
{
  "success": false,
  "message": "Error description",
  "error": "Detailed error message"
}
```

## Rate Limiting

Currently no rate limiting is implemented. Consider adding rate limiting for production use.

## API Versioning

The API uses path-based versioning for newer endpoints:
- `/api/v1/...` - Version 1 (newer endpoints)
- `/...` - Legacy endpoints (no version prefix)

## Security Considerations

1. **Authentication**: Most endpoints require user authentication
2. **Organization Isolation**: Data is isolated by organization ID
3. **Input Validation**: All endpoints validate input parameters
4. **File Upload Security**: File uploads are restricted by type and size
5. **SQL Injection Prevention**: Uses MongoDB with parameterized queries

## Development Notes

### Modular Route Structure

The codebase includes a modular route structure in `/backend/routes/` but these are not currently mounted. All endpoints are defined directly in `server.js`. Consider refactoring to use the modular structure:

- `routes/auth.js` - Authentication routes
- `routes/client.js` - Client management routes  
- `routes/pricing.js` - Pricing routes
- `routes/organization.js` - Organization routes
- etc.

### Endpoint Files

Business logic is separated into endpoint files:

- `pricing_endpoints.js` - Custom pricing logic
- `audit_trail_endpoints.js` - Audit trail logic
- `invoice_generation_endpoints.js` - Invoice generation logic
- `price_validation_endpoints.js` - Price validation logic
- `recurring_expense_endpoints.js` - Recurring expense logic
- `price_prompt_endpoints.js` - Price prompt logic
- `backward_compatibility_endpoints.js` - Legacy compatibility logic

### Database Collections

The API interacts with these MongoDB collections:

- `login` - User accounts
- `organizations` - Organization data
- `clients` - Client information
- `clientAssignments` - User-client assignments
- `customPricing` - Custom pricing rules
- `expenses` - Expense records
- `recurringExpenses` - Recurring expense definitions
- `auditTrail` - Audit log entries
- `workedTime` - Time tracking records
- `invoicingEmailDetails` - Email configuration
- `holidays` - Holiday calendar
- `supportItems` - NDIS support items

## Testing

API endpoints can be tested using:

1. **Postman Collection** - Import the API endpoints
2. **curl commands** - Command line testing
3. **Automated Tests** - Unit and integration tests

### Example curl Command

```bash
curl -X POST http://localhost:8080/api/pricing/create \
  -H "Content-Type: application/json" \
  -d '{
    "organizationId": "org123",
    "supportItemNumber": "01_001_0107_1_1",
    "customPrice": 150.00,
    "pricingType": "fixed"
  }'
```

## Future Improvements

1. **API Documentation**: Generate OpenAPI/Swagger documentation
2. **Rate Limiting**: Implement rate limiting for production
3. **API Versioning**: Standardize API versioning strategy
4. **Modular Routes**: Migrate to modular route structure
5. **Input Validation**: Centralize input validation middleware
6. **Response Standardization**: Standardize all response formats
7. **Authentication Middleware**: Implement centralized auth middleware
8. **Logging**: Add structured logging for all endpoints
9. **Monitoring**: Add endpoint monitoring and metrics
10. **Caching**: Implement caching for frequently accessed data