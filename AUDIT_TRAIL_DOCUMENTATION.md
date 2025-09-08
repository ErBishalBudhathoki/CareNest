# Audit Trail Service Documentation

## Overview

The Audit Trail Service provides comprehensive logging and tracking functionality for all critical operations in the invoice management system. It automatically captures user actions, data changes, and system events for compliance, security, and debugging purposes.

## Features

### Core Functionality
- **Automatic Logging**: Integrated with pricing and expense endpoints
- **Manual Logging**: API endpoint for custom audit entries
- **Comprehensive Tracking**: Before/after values, user actions, timestamps
- **Authentication**: Organization-level access control
- **Export Capabilities**: JSON and CSV formats for compliance reporting
- **Statistics**: Audit analytics and reporting

### Supported Actions
- `CREATE` - Entity creation
- `UPDATE` - Entity modification
- `DELETE` - Entity deletion
- `APPROVE` - Approval workflow actions
- `REJECT` - Rejection workflow actions
- `LOGIN` - User authentication
- `LOGOUT` - User session termination
- `EXPORT` - Data export operations
- `IMPORT` - Data import operations
- `VIEW` - Data access operations

### Tracked Entities
- `pricing` - Custom pricing records
- `expense` - Expense records
- `invoice` - Invoice records
- `user` - User accounts
- `organization` - Organization data
- `client` - Client information
- `assignment` - Work assignments

## API Endpoints

### 1. Get Audit Metadata
```http
GET /api/audit/metadata
```
Returns available audit actions and entity types.

**Response:**
```json
{
  "statusCode": 200,
  "message": "Audit metadata retrieved successfully",
  "data": {
    "actions": {
      "CREATE": "CREATE",
      "UPDATE": "UPDATE",
      "DELETE": "DELETE",
      "APPROVE": "APPROVE",
      "REJECT": "REJECT",
      "LOGIN": "LOGIN",
      "LOGOUT": "LOGOUT",
      "EXPORT": "EXPORT",
      "IMPORT": "IMPORT",
      "VIEW": "VIEW"
    },
    "entityTypes": {
      "PRICING": "pricing",
      "EXPENSE": "expense",
      "INVOICE": "invoice",
      "USER": "user",
      "ORGANIZATION": "organization",
      "CLIENT": "client",
      "ASSIGNMENT": "assignment"
    }
  }
}
```

### 2. Create Manual Audit Log
```http
POST /api/audit/log
```

**Required Parameters:**
- `action` (string) - Audit action type
- `entityType` (string) - Type of entity being audited
- `entityId` (string) - Unique identifier of the entity
- `userEmail` (string) - Email of the user performing the action
- `organizationId` (string) - Organization identifier

**Optional Parameters:**
- `oldValues` (object) - Previous state of the entity
- `newValues` (object) - New state of the entity
- `reason` (string) - Reason for the action
- `metadata` (object) - Additional context information

**Example Request:**
```bash
curl -X POST http://localhost:8080/api/audit/log \
  -H "Content-Type: application/json" \
  -d '{
    "action": "CREATE",
    "entityType": "pricing",
    "entityId": "pricing-123",
    "userEmail": "admin@company.com",
    "organizationId": "org-456",
    "newValues": {
      "supportItemNumber": "01_001_0117_1_1",
      "customPrice": 150.00,
      "pricingType": "custom"
    },
    "reason": "Custom pricing created for special client"
  }'
```

### 3. Get Entity Audit History
```http
GET /api/audit/entity/:entityType/:entityId?organizationId=:orgId&userEmail=:email
```

Retrieves audit history for a specific entity.

### 4. Get Organization Audit Logs
```http
GET /api/audit/organization/:organizationId?userEmail=:email&limit=:limit&skip=:skip
```

Retrieves audit logs for an entire organization with pagination.

### 5. Get Audit Statistics
```http
GET /api/audit/statistics/:organizationId?userEmail=:email
```

Provides audit analytics and statistics.

### 6. Export Audit Logs
```http
GET /api/audit/export/:organizationId?userEmail=:email&format=:format
```

Exports audit logs in JSON or CSV format.

## Authentication Requirements

### User-Organization Validation
All audit endpoints require valid user-organization relationships. Users must exist in the `login` collection with:
- `email` - User's email address
- `organizationId` - Organization identifier
- Active status

### Creating Test Users
For testing purposes, use the provided script:
```bash
node backend/create_audit_test_user.js
```

This creates a test user with:
- Email: `test@example.com`
- Organization ID: `test-org-123`
- Role: `admin`

## Automatic Integration

### Pricing Endpoints
Audit logging is automatically integrated into:
- `POST /api/pricing/create` - Logs pricing creation
- `PUT /api/pricing/:id` - Logs pricing updates
- `DELETE /api/pricing/:id` - Logs pricing deletion
- `PUT /api/pricing/:id/approval` - Logs approval workflow

### Expense Endpoints
Audit logging is automatically integrated into:
- `POST /api/expenses/create` - Logs expense creation
- `PUT /api/expenses/:id` - Logs expense updates
- `DELETE /api/expenses/:id` - Logs expense deletion
- `PUT /api/expenses/:id/approval` - Logs approval workflow

## Data Structure

### Audit Log Entry
```json
{
  "_id": "ObjectId",
  "action": "CREATE",
  "entityType": "pricing",
  "entityId": "pricing-123",
  "userEmail": "user@company.com",
  "organizationId": "org-456",
  "timestamp": "2025-07-06T14:40:10.000Z",
  "oldValues": {},
  "newValues": {
    "supportItemNumber": "01_001_0117_1_1",
    "customPrice": 150.00
  },
  "reason": "Custom pricing created",
  "metadata": {
    "ipAddress": "127.0.0.1",
    "userAgent": "curl/8.7.1",
    "supportItemName": "Personal Care"
  }
}
```

## Security Features

### Data Sanitization
- Automatic removal of sensitive fields (passwords, tokens)
- Configurable field exclusion
- Safe handling of nested objects

### Access Control
- Organization-level isolation
- User authentication validation
- Role-based access (admin privileges for exports)

### Data Retention
- Configurable retention policies
- Automatic cleanup of old audit logs
- Compliance with data protection regulations

## Testing

### Running Tests
```bash
node backend/test_audit_trail.js
```

### Test Coverage
- Manual audit log creation
- Metadata retrieval
- Pricing integration
- Expense integration
- Organization logs
- Statistics
- Export functionality

## Error Handling

### Common Error Responses

**400 Bad Request**
```json
{
  "statusCode": 400,
  "message": "Missing required fields: action, entityType, entityId, userEmail, organizationId"
}
```

**403 Forbidden**
```json
{
  "statusCode": 403,
  "message": "Access denied: User not found in organization"
}
```

**500 Internal Server Error**
```json
{
  "statusCode": 500,
  "message": "Internal server error",
  "error": "Database connection failed"
}
```

## Performance Considerations

### Database Indexing
Recommended indexes for optimal performance:
```javascript
// Compound index for organization queries
db.auditLogs.createIndex({ "organizationId": 1, "timestamp": -1 })

// Index for entity-specific queries
db.auditLogs.createIndex({ "entityType": 1, "entityId": 1, "timestamp": -1 })

// Index for user activity queries
db.auditLogs.createIndex({ "userEmail": 1, "timestamp": -1 })
```

### Pagination
All list endpoints support pagination:
- `limit` - Maximum number of records (default: 100)
- `skip` - Number of records to skip (default: 0)
- `sortBy` - Field to sort by (default: timestamp)
- `sortOrder` - Sort direction (default: -1 for descending)

## Compliance Features

### Audit Trail Requirements
- **Immutable Records**: Audit logs cannot be modified after creation
- **Complete Tracking**: All CRUD operations are logged
- **User Attribution**: Every action is tied to a specific user
- **Timestamp Accuracy**: Precise timestamps for all events
- **Data Integrity**: Before/after values for change tracking

### Export Capabilities
- **JSON Format**: Machine-readable for automated processing
- **CSV Format**: Human-readable for manual review
- **Filtered Exports**: Date ranges and entity type filtering
- **Bulk Export**: Organization-wide data export

## Troubleshooting

### Common Issues

1. **403 Access Denied**
   - Verify user exists in organization
   - Check email and organizationId parameters
   - Ensure user is active

2. **Audit Logs Not Created**
   - Check database connectivity
   - Verify audit service integration
   - Review error logs for exceptions

3. **Performance Issues**
   - Implement recommended database indexes
   - Use pagination for large datasets
   - Consider archiving old audit logs

### Debug Mode
Enable detailed logging by setting environment variable:
```bash
DEBUG=audit:* node backend/server.js
```

## Future Enhancements

### Planned Features
- Real-time audit notifications
- Advanced filtering and search
- Audit log encryption
- Integration with external SIEM systems
- Automated compliance reporting
- Audit log visualization dashboard

### Configuration Options
- Configurable retention periods
- Custom field sanitization rules
- Webhook notifications for critical events
- Integration with external audit systems