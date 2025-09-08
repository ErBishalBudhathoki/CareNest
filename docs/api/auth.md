# Authentication API

Authentication endpoints for user login, logout, and token management.

## Base Path
```
/api/auth
```

## Endpoints

### POST /api/auth/login

Authenticate a user and receive a JWT token.

**Request:**
```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "userpassword"
}
```

**Request Body Schema:**
```json
{
  "email": {
    "type": "string",
    "format": "email",
    "required": true,
    "description": "User's email address"
  },
  "password": {
    "type": "string",
    "minLength": 6,
    "required": true,
    "description": "User's password"
  }
}
```

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "user123",
      "email": "user@example.com",
      "name": "John Doe",
      "role": "employee",
      "organizationId": "org123",
      "permissions": ["read:appointments", "write:expenses"]
    },
    "expiresIn": "24h"
  },
  "message": "Login successful"
}
```

**Error Responses:**

*Invalid Credentials (401):*
```json
{
  "success": false,
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "Invalid email or password"
  }
}
```

*Validation Error (422):*
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Request validation failed",
    "details": {
      "fields": {
        "email": "Valid email is required",
        "password": "Password must be at least 6 characters"
      }
    }
  }
}
```

*Account Locked (423):*
```json
{
  "success": false,
  "error": {
    "code": "ACCOUNT_LOCKED",
    "message": "Account is temporarily locked due to multiple failed login attempts",
    "details": {
      "lockoutExpiresAt": "2024-01-15T11:30:00.000Z"
    }
  }
}
```

---

### POST /api/auth/logout

Logout the current user and invalidate the JWT token.

**Authentication:** Required

**Request:**
```http
POST /api/auth/logout
Authorization: Bearer <jwt_token>
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Logout successful"
}
```

**Error Responses:**

*Unauthorized (401):*
```json
{
  "success": false,
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Authentication token is invalid or expired"
  }
}
```

---

### POST /api/auth/refresh

Refresh an existing JWT token to extend its validity.

**Authentication:** Required

**Request:**
```http
POST /api/auth/refresh
Authorization: Bearer <jwt_token>
```

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiresIn": "24h"
  },
  "message": "Token refreshed successfully"
}
```

**Error Responses:**

*Token Expired (401):*
```json
{
  "success": false,
  "error": {
    "code": "TOKEN_EXPIRED",
    "message": "Token has expired and cannot be refreshed"
  }
}
```

---

### GET /api/auth/me

Get current user information from the JWT token.

**Authentication:** Required

**Request:**
```http
GET /api/auth/me
Authorization: Bearer <jwt_token>
```

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "user123",
      "email": "user@example.com",
      "name": "John Doe",
      "role": "employee",
      "organizationId": "org123",
      "permissions": ["read:appointments", "write:expenses"],
      "profile": {
        "phone": "+1234567890",
        "address": "123 Main St, City, State",
        "emergencyContact": {
          "name": "Jane Doe",
          "phone": "+1234567891"
        }
      },
      "settings": {
        "timezone": "America/New_York",
        "notifications": {
          "email": true,
          "push": true
        }
      },
      "lastLoginAt": "2024-01-15T10:30:00.000Z",
      "createdAt": "2024-01-01T00:00:00.000Z",
      "updatedAt": "2024-01-15T10:30:00.000Z"
    }
  }
}
```

---

### POST /api/auth/forgot-password

Initiate password reset process by sending a reset email.

**Request:**
```http
POST /api/auth/forgot-password
Content-Type: application/json

{
  "email": "user@example.com"
}
```

**Request Body Schema:**
```json
{
  "email": {
    "type": "string",
    "format": "email",
    "required": true,
    "description": "User's email address"
  }
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Password reset email sent successfully"
}
```

**Note:** This endpoint always returns success for security reasons, even if the email doesn't exist.

---

### POST /api/auth/reset-password

Reset password using the token from the reset email.

**Request:**
```http
POST /api/auth/reset-password
Content-Type: application/json

{
  "token": "reset_token_from_email",
  "newPassword": "newpassword123"
}
```

**Request Body Schema:**
```json
{
  "token": {
    "type": "string",
    "required": true,
    "description": "Password reset token from email"
  },
  "newPassword": {
    "type": "string",
    "minLength": 6,
    "required": true,
    "description": "New password"
  }
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Password reset successfully"
}
```

**Error Responses:**

*Invalid Token (400):*
```json
{
  "success": false,
  "error": {
    "code": "INVALID_RESET_TOKEN",
    "message": "Password reset token is invalid or expired"
  }
}
```

---

### POST /api/auth/change-password

Change password for authenticated user.

**Authentication:** Required

**Request:**
```http
POST /api/auth/change-password
Authorization: Bearer <jwt_token>
Content-Type: application/json

{
  "currentPassword": "currentpassword",
  "newPassword": "newpassword123"
}
```

**Request Body Schema:**
```json
{
  "currentPassword": {
    "type": "string",
    "required": true,
    "description": "Current password for verification"
  },
  "newPassword": {
    "type": "string",
    "minLength": 6,
    "required": true,
    "description": "New password"
  }
}
```

**Success Response (200):**
```json
{
  "success": true,
  "message": "Password changed successfully"
}
```

**Error Responses:**

*Invalid Current Password (400):*
```json
{
  "success": false,
  "error": {
    "code": "INVALID_CURRENT_PASSWORD",
    "message": "Current password is incorrect"
  }
}
```

---

## Authentication Flow

### 1. Login Process
```mermaid
sequenceDiagram
    participant Client
    participant API
    participant Firebase
    participant DB
    
    Client->>API: POST /auth/login {email, password}
    API->>Firebase: Verify credentials
    Firebase-->>API: User verified
    API->>DB: Get user profile
    DB-->>API: User data
    API->>API: Generate JWT token
    API-->>Client: {token, user, expiresIn}
```

### 2. Token Usage
```mermaid
sequenceDiagram
    participant Client
    participant API
    participant Middleware
    
    Client->>API: Request with Authorization header
    API->>Middleware: Verify JWT token
    Middleware->>Middleware: Decode & validate token
    alt Token valid
        Middleware-->>API: User context
        API-->>Client: Protected resource
    else Token invalid
        Middleware-->>Client: 401 Unauthorized
    end
```

### 3. Password Reset Flow
```mermaid
sequenceDiagram
    participant User
    participant API
    participant Email
    participant Firebase
    
    User->>API: POST /auth/forgot-password
    API->>Firebase: Generate reset token
    API->>Email: Send reset email
    Email-->>User: Reset email with token
    User->>API: POST /auth/reset-password {token, newPassword}
    API->>Firebase: Verify token & update password
    Firebase-->>API: Password updated
    API-->>User: Success response
```

## Security Considerations

### JWT Token Security
- Tokens expire after 24 hours
- Tokens are signed with a secure secret
- Tokens include user ID, role, and permissions
- Refresh tokens are supported for seamless user experience

### Password Security
- Passwords are hashed using Firebase Auth
- Minimum password length: 6 characters
- Account lockout after 5 failed attempts
- Password reset tokens expire after 1 hour

### Rate Limiting
- Login endpoint: 10 requests per minute per IP
- Password reset: 3 requests per hour per email
- Other auth endpoints: 20 requests per minute per user

### CORS Policy
- Only allowed origins can access the API
- Credentials are included in CORS requests
- Preflight requests are handled appropriately

## Error Codes Reference

| Code | Description | HTTP Status |
|------|-------------|-------------|
| `INVALID_CREDENTIALS` | Wrong email or password | 401 |
| `UNAUTHORIZED` | Missing or invalid token | 401 |
| `TOKEN_EXPIRED` | JWT token has expired | 401 |
| `ACCOUNT_LOCKED` | Too many failed login attempts | 423 |
| `VALIDATION_ERROR` | Request validation failed | 422 |
| `INVALID_RESET_TOKEN` | Password reset token invalid | 400 |
| `INVALID_CURRENT_PASSWORD` | Current password incorrect | 400 |
| `RATE_LIMIT_EXCEEDED` | Too many requests | 429 |

## Testing Examples

### cURL Examples

**Login:**
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123"
  }'
```

**Get User Info:**
```bash
curl -X GET http://localhost:3000/api/auth/me \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

**Change Password:**
```bash
curl -X POST http://localhost:3000/api/auth/change-password \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "currentPassword": "oldpassword",
    "newPassword": "newpassword123"
  }'
```

### JavaScript Examples

**Login and Store Token:**
```javascript
const login = async (email, password) => {
  try {
    const response = await fetch('/api/auth/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ email, password })
    });
    
    const result = await response.json();
    
    if (result.success) {
      localStorage.setItem('authToken', result.data.token);
      return result.data.user;
    } else {
      throw new Error(result.error.message);
    }
  } catch (error) {
    console.error('Login failed:', error);
    throw error;
  }
};
```

**API Request with Token:**
```javascript
const apiRequest = async (url, options = {}) => {
  const token = localStorage.getItem('authToken');
  
  const response = await fetch(url, {
    ...options,
    headers: {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
      ...options.headers
    }
  });
  
  if (response.status === 401) {
    // Token expired, redirect to login
    localStorage.removeItem('authToken');
    window.location.href = '/login';
    return;
  }
  
  return response.json();
};
```