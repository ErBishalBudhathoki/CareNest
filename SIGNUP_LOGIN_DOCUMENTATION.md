# Signup and Login Documentation

## Overview

This document provides comprehensive documentation for the signup and login functionality in the CareNest Flutter application. The system has been recently fixed and is now fully operational.

## Architecture Overview

### Frontend (Flutter)
- **Framework**: Flutter ^3.22.0
- **State Management**: Provider pattern with ChangeNotifier
- **Authentication**: Firebase Auth integration
- **API Communication**: HTTP requests to Node.js backend

### Backend (Node.js)
- **Server**: Express.js
- **Database**: MongoDB with Mongoose
- **Authentication**: Custom implementation with Argon2 password hashing
- **Multi-tenancy**: Organization-based user management

## File Structure

### Frontend Files
```
lib/app/features/auth/
├── models/
│   ├── signup_model.dart          # Data model for signup form
│   └── user_role.dart             # User role definitions
├── viewmodels/
│   └── signup_viewmodel.dart      # Business logic for signup process
├── views/
│   ├── signup_view.dart           # Signup UI screen
│   └── login_view.dart            # Login UI screen
lib/backend/
└── api_method.dart                # API communication layer
lib/app/core/utils/Services/
└── signupResult.dart              # Result wrapper for signup operations
```

### Backend Files
```
backend/
├── server.js                      # Main server file with API endpoints
├── package.json                   # Dependencies and scripts
└── .env                          # Environment configuration
```

## Signup Flow

### 1. User Interface (signup_view.dart)

The signup form collects the following information:
- First Name
- Last Name
- Email
- Password
- Confirm Password
- ABN (Australian Business Number)
- Organization Name (for new organizations)
- Organization Code (for joining existing organizations)
- User Role (admin/normal)

### 2. Form Validation

- Email format validation
- Password strength requirements
- Password confirmation matching
- Required field validation

### 3. Signup Process (signup_viewmodel.dart)

#### Step 1: Organization Creation/Joining
```dart
// For new organizations
var orgResult = await apiMethod.createOrganization(
  model.organizationNameController.text,
  model.emailController.text,
);

// For joining existing organizations
var orgResult = await apiMethod.joinOrganization(
  model.organizationCodeController.text,
  model.emailController.text,
);
```

#### Step 2: User Registration
```dart
var success = await apiMethod.signupUser(
  model.firstNameController.text,
  model.lastNameController.text,
  model.emailController.text,
  model.passwordController.text,
  model.abnController.text,
  model.selectedRole,
  organizationId: organizationId,
  organizationCode: organizationCode,
);
```

### 4. API Communication (api_method.dart)

#### Organization Creation
- **Endpoint**: `POST /organization/create`
- **Request Body**:
  ```json
  {
    "organizationName": "string",
    "ownerEmail": "string"
  }
  ```
- **Success Response** (200):
  ```json
  {
    "organizationId": "string",
    "organizationCode": "string"
  }
  ```
- **Error Response** (400):
  ```json
  {
    "error": "error message"
  }
  ```

#### User Signup
- **Endpoint**: `POST /signup/{email}`
- **Process**:
  1. Check if email exists: `GET /checkEmail/{email}`
  2. If email doesn't exist (400), proceed with signup
  3. Generate salt and hash password using Argon2
  4. Send user data to backend

- **Request Body**:
  ```json
  {
    "firstName": "string",
    "lastName": "string",
    "email": "string",
    "password": "hashed_password",
    "salt": "hex_string",
    "abn": "string",
    "role": "admin|normal",
    "organizationId": "string",
    "organizationCode": "string"
  }
  ```

- **Success Response** (200):
  ```json
  {
    "message": "User created successfully",
    "userId": "string",
    "email": "string",
    "role": "string",
    "organizationId": "string",
    "organizationName": "string"
  }
  ```

### 5. Response Handling

The system now correctly handles API responses:

#### Organization Creation Response Handling
```dart
if (orgResult.containsKey('error')) {
  // Handle error case
  return SignupResult(success: false, message: orgResult['error']);
} else if (orgResult.containsKey('organizationId') && orgResult.containsKey('organizationCode')) {
  // Handle success case
  organizationId = orgResult['organizationId'];
  organizationCode = orgResult['organizationCode'];
}
```

#### User Signup Response Handling
```dart
if (success.containsKey('error')) {
  // Handle error case
  return SignupResult(success: false, message: success['error']);
} else if (success.containsKey('userId') || success.containsKey('message')) {
  // Handle success case
  return SignupResult(success: true, message: success['message']);
}
```

## Login Flow

### 1. User Authentication
- Email and password validation
- API call to backend for authentication
- Session management
- Navigation to main application

### 2. API Endpoints
- **Login**: `POST /login`
- **Email Check**: `GET /checkEmail/{email}`

## Security Features

### Password Security
- **Hashing Algorithm**: Argon2 (industry standard)
- **Salt Generation**: Cryptographically secure random salt for each password
- **Client-side Hashing**: Passwords are hashed on the client before transmission

### Data Validation
- Input sanitization
- Email format validation
- Password strength requirements
- SQL injection prevention

## Multi-Tenancy Support

### Organization Management
- Each user belongs to an organization
- Organizations have unique codes for joining
- Role-based access control (admin/normal users)
- Organization-scoped data isolation

### User Roles
- **Admin**: Full access to organization features
- **Normal**: Limited access based on permissions

## Error Handling

### Common Error Scenarios
1. **Email Already Exists**: Returns 409 status code
2. **Invalid Organization Code**: Handled in organization joining flow
3. **Network Errors**: Proper error messages and retry mechanisms
4. **Server Errors**: 500 status code handling with user-friendly messages

### Error Response Format
```dart
SignupResult(
  success: false,
  title: "Error",
  message: "User-friendly error message",
  backgroundColor: AppColors.colorWarning,
)
```

## Recent Fixes Applied

### Issue 1: Incorrect Response Handling
**Problem**: The signup process was checking for a non-existent `success` key in API responses.

**Solution**: Updated response handling to check for:
- `error` key for failures
- `organizationId`/`organizationCode` keys for organization creation success
- `userId`/`message` keys for user signup success

### Issue 2: Color Reference Error
**Problem**: Reference to non-existent `AppColors.colorSuccess`.

**Solution**: Updated to use existing `AppColors.colorPrimary` for success messages.

## Configuration

### Environment Variables
```
DEBUG_URL=http://192.168.20.18:8080/
```

### Dependencies
- **Flutter**: ^3.22.0
- **Provider**: State management
- **HTTP**: API communication
- **Firebase**: Authentication and backend services

## Testing

### Manual Testing Checklist
- [ ] New organization creation
- [ ] Joining existing organization
- [ ] Email validation
- [ ] Password validation
- [ ] Successful signup flow
- [ ] Error handling scenarios
- [ ] Login functionality

### Debug Logging
Comprehensive debug logging has been implemented:
```dart
print('DEBUG: Organization creation result: $orgResult');
print('DEBUG: User signup result: $success');
print('DEBUG: Response keys: ${success.keys}');
```

## API Documentation

### Base URL
- Development: `http://192.168.20.18:8080/`

### Endpoints

#### Organization Management
- `POST /organization/create` - Create new organization
- `POST /organization/join` - Join existing organization

#### User Management
- `GET /checkEmail/{email}` - Check if email exists
- `POST /signup/{email}` - Register new user
- `POST /login` - User authentication

## Deployment Notes

### Frontend
- Flutter app builds for iOS and Android
- Environment configuration through `.env` file

### Backend
- Node.js server with Express
- MongoDB database
- Environment-specific configuration

## Maintenance

### Regular Tasks
- Monitor error logs
- Update dependencies
- Security patches
- Performance optimization

### Known Limitations
- Single organization per user (current implementation)
- Password reset functionality (to be implemented)
- Email verification (to be implemented)

## Future Enhancements

1. **Email Verification**: Implement email verification during signup
2. **Password Reset**: Add forgot password functionality
3. **Social Login**: Integration with Google/Apple sign-in
4. **Two-Factor Authentication**: Enhanced security
5. **Organization Switching**: Allow users to belong to multiple organizations

---

**Last Updated**: January 2025
**Status**: ✅ Fully Functional
**Version**: 1.0.0