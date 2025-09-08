# API Documentation

This directory contains comprehensive documentation for all API endpoints in the Invoice Management System.

## API Overview

### Base URL
```
Production: https://api.invoicemanagement.com
Development: http://localhost:3000
```

### Authentication
All API endpoints (except authentication endpoints) require a valid JWT token in the Authorization header:
```
Authorization: Bearer <jwt_token>
```

### Response Format
All API responses follow a consistent format:

#### Success Response
```json
{
  "success": true,
  "data": {
    // Response data
  },
  "message": "Operation completed successfully"
}
```

#### Error Response
```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable error message",
    "details": {
      // Additional error details
    }
  }
}
```

### HTTP Status Codes
- `200` - OK: Request successful
- `201` - Created: Resource created successfully
- `400` - Bad Request: Invalid request data
- `401` - Unauthorized: Authentication required
- `403` - Forbidden: Insufficient permissions
- `404` - Not Found: Resource not found
- `409` - Conflict: Resource conflict
- `422` - Unprocessable Entity: Validation errors
- `500` - Internal Server Error: Server error

## API Modules

### 🔐 Authentication
- **[Auth Endpoints](./auth.md)** - Login, logout, token management

### 👥 User Management
- **[User Endpoints](./users.md)** - User profile and management

### 🏢 Organization Management
- **[Organization Endpoints](./organizations.md)** - Organization settings and management

### 👤 Client Management
- **[Client Endpoints](./clients.md)** - Client onboarding, management, and assignments
- **[Business Profile Endpoints](./business_profiles.md)** - Business profile management

### ⏱️ Time Tracking
- **[Appointment Endpoints](./appointments.md)** - Time tracking, timers, and worked time
- **[Employee Tracking Endpoints](./employee_tracking.md)** - Employee monitoring and reporting

### 💰 Expense Management
- **[Expense Endpoints](./expenses.md)** - Expense tracking and approval
- **[Recurring Expense Endpoints](./recurring_expenses.md)** - Automated recurring expenses

### 📄 Invoice Management
- **[Invoice Generation Endpoints](./invoice_generation.md)** - Invoice creation and management

### 💲 Pricing Management
- **[Pricing Endpoints](./pricing.md)** - Custom pricing and rate management
- **[Price Validation Endpoints](./price_validation.md)** - NDIS rate validation
- **[Price Prompt Endpoints](./price_prompts.md)** - Pricing suggestions and prompts

### 🛠️ Support Items
- **[Support Items Endpoints](./support_items.md)** - NDIS support item management

### 📋 Audit & Logging
- **[Audit Endpoints](./audit.md)** - System audit trails and logging

## Common Request/Response Patterns

### Pagination
Endpoints that return lists support pagination:

**Request Parameters:**
```
GET /api/resource?page=1&limit=20&sort=createdAt&order=desc
```

**Response:**
```json
{
  "success": true,
  "data": {
    "items": [...],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 150,
      "pages": 8,
      "hasNext": true,
      "hasPrev": false
    }
  }
}
```

### Filtering
Many endpoints support filtering:

```
GET /api/resource?status=active&category=support&startDate=2024-01-01&endDate=2024-12-31
```

### File Uploads
File upload endpoints use multipart/form-data:

```javascript
const formData = new FormData();
formData.append('file', fileBlob);
formData.append('metadata', JSON.stringify({...}));

fetch('/api/upload', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer ' + token
  },
  body: formData
});
```

### Date Formats
All dates use ISO 8601 format:
```
2024-01-15T10:30:00.000Z
```

### Error Handling Examples

#### Validation Error (422)
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Request validation failed",
    "details": {
      "fields": {
        "email": "Invalid email format",
        "amount": "Amount must be greater than 0"
      }
    }
  }
}
```

#### Authentication Error (401)
```json
{
  "success": false,
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Authentication token is invalid or expired"
  }
}
```

#### Permission Error (403)
```json
{
  "success": false,
  "error": {
    "code": "FORBIDDEN",
    "message": "Insufficient permissions to access this resource"
  }
}
```

## Rate Limiting

API endpoints are rate limited to prevent abuse:

- **General endpoints**: 100 requests per minute per IP
- **Authentication endpoints**: 10 requests per minute per IP
- **File upload endpoints**: 20 requests per minute per user

Rate limit headers are included in responses:
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640995200
```

## API Versioning

The API uses URL versioning:
```
/api/v1/resource  # Version 1 (current)
/api/v2/resource  # Version 2 (future)
```

Current version: **v1**

## Testing the API

### Using cURL
```bash
# Get auth token
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"password"}'

# Use token in subsequent requests
curl -X GET http://localhost:3000/api/clients \
  -H "Authorization: Bearer <token>"
```

### Using Postman
1. Import the [Postman Collection](./postman_collection.json)
2. Set up environment variables for base URL and auth token
3. Run the authentication request first to get a token
4. Use the token for other requests

### Using JavaScript/Fetch
```javascript
// Login
const loginResponse = await fetch('/api/auth/login', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    email: 'user@example.com',
    password: 'password'
  })
});

const { data } = await loginResponse.json();
const token = data.token;

// Use token for API calls
const clientsResponse = await fetch('/api/clients', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
});
```

## OpenAPI/Swagger Documentation

Interactive API documentation is available at:
- **Development**: http://localhost:3000/api-docs
- **Production**: https://api.invoicemanagement.com/api-docs

The OpenAPI specification file is available at:
- **[openapi.yaml](./openapi.yaml)** - Complete API specification

---

**Note**: This documentation is automatically updated when API changes are made. For the most current information, refer to the interactive Swagger documentation.