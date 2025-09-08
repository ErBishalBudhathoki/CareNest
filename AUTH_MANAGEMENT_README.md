# Authentication Management Tools

This document provides information about the authentication management tools created to help resolve authentication and rate limiting issues in the invoice application.

## Overview

These tools were created to address issues with:
- Missing auth tokens in login responses
- Rate limiting (HTTP 429) errors
- Authentication (HTTP 401) errors

## Available Scripts

### 1. Reset Login Attempts

Resets login attempts for users who are locked out due to too many failed login attempts.

```bash
# Reset for a specific user
node reset_login_attempt.js user@example.com

# Reset for all users
node reset_login_attempt.js --all
```

### 2. Reset Rate Limits

Resets rate limiting for IP addresses that are blocked due to too many failed attempts.

```bash
# Reset for a specific IP
node reset_rate_limits.js 192.168.1.1

# Reset for all IPs
node reset_rate_limits.js --all
```

### 3. Check User Password

Checks the stored password format for a user in the database to help understand how passwords are stored.

```bash
# Check for a specific user
node check_user_password.js user@example.com
```

### 4. Test Login

Tests the login functionality to ensure authentication is working properly.

```bash
# Test with default credentials
node test_login.js

# Test with specific credentials
node test_login.js user@example.com password
```

### 5. Restart Server

Restarts the backend server to apply changes.

```bash
./restart_server.sh
```

## Authentication Flow

The authentication flow has been fixed to properly include JWT tokens in the login response:

1. Client requests salt for user email
2. Server returns salt
3. Client hashes password with salt
4. Client sends login request with email and hashed password
5. Server verifies password and returns JWT token
6. Client stores token and uses it for authenticated requests

## Rate Limiting

Rate limiting has been implemented to prevent brute force attacks:

- Login attempts are tracked per user and IP
- Too many failed attempts will lock the account temporarily
- Administrators can reset rate limits using the provided scripts

## Security Dashboard

A security dashboard is available at `/api/security/dashboard` for administrators to monitor and manage authentication and rate limiting.

## Troubleshooting

If you encounter authentication issues:

1. Check if the user account is locked (use `reset_login_attempt.js`)
2. Check if the IP is rate limited (use `reset_rate_limits.js`)
3. Verify the password format (use `check_user_password.js`)
4. Test the login flow (use `test_login.js`)
5. Restart the server if needed (use `restart_server.sh`)

## Notes

- The JWT token is now properly included in the login response
- The authentication middleware has been updated to properly validate tokens
- Rate limiting can be reset through the security dashboard or using the provided scripts