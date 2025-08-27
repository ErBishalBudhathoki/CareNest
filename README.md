# Multi-Tenant Invoice Backend Server

This is a Node.js Express server implementing a multi-tenant solution for an invoice management system. The server supports organization-based user management with role-based access control.

## Features

### Multi-Tenant Architecture
- **Organization-based tenancy**: Each organization has its own isolated data
- **Role-based access control**: Admin (business owners) and normal users (employees)
- **Secure data isolation**: Users can only access data within their organization
- **Organization codes**: Secure invitation system for employees

### Core Functionality
- User authentication and authorization
- Organization management
- Business management
- Client management
- OTP-based email verification
- Password management
- Timer functionality

## Setup Instructions

### Prerequisites
- Node.js (v14 or higher)
- MongoDB database
- Email service for OTP (configured in environment variables)

### Installation

1. **Install dependencies**:
   ```bash
   npm install
   ```

2. **Environment Configuration**:
   Create a `.env` file based on `.env.example`:
   ```bash
   cp .env.example .env
   ```

3. **Configure Environment Variables**:
   Edit `.env` file with your actual values:
   ```env
   MONGODB_URI=mongodb://localhost:27017/your-database
   PORT=3000
   EMAIL_FOR_OTP=your-email@gmail.com
   EMAIL_PASSWORD=your-app-password
   JWT_SECRET=your-jwt-secret-key
   ENCRYPTION_KEY=your-32-character-encryption-key
   NODE_ENV=development
   ```

4. **Start the server**:
   ```bash
   npm start
   ```

## API Endpoints

### Organization Management

#### Create Organization
```http
POST /organization/create
Content-Type: application/json

{
  "organizationName": "My Company",
  "ownerEmail": "owner@company.com"
}
```

#### Verify Organization Code
```http
POST /organization/verify-code
Content-Type: application/json

{
  "organizationCode": "ABC123"
}
```

#### Get Organization Details
```http
GET /organization/{organizationId}
```

#### Get Organization Members
```http
GET /organization/{organizationId}/members
```

#### Get Organization Businesses
```http
GET /organization/{organizationId}/businesses
```

#### Get Organization Clients
```http
GET /organization/{organizationId}/clients
```

### User Management

#### User Signup
```http
POST /signup/{email}
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Doe",
  "password": "hashedPassword",
  "salt": "saltValue",
  "abn": "12345678901",
  "role": "admin", // or "normal"
  "organizationId": "optional-for-employees",
  "organizationCode": "optional-for-employees"
}
```

#### User Login
```http
POST /login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "hashedPassword"
}
```

#### Check Email Availability
```http
GET /checkEmail/{email}
```

### Business Management

#### Add Business
```http
POST /addBusiness
Content-Type: application/json

{
  "businessName": "My Business",
  "businessEmail": "business@example.com",
  "businessPhone": "+1234567890",
  "businessAddress": "123 Main St",
  "businessCity": "City",
  "businessState": "State",
  "businessZip": "12345",
  "businessABN": "12345678901",
  "organizationId": "optional",
  "userEmail": "user@example.com"
}
```

### Client Management

#### Add Client
```http
POST /addClient
Content-Type: application/json

{
  "clientFirstName": "Jane",
  "clientLastName": "Smith",
  "clientEmail": "client@example.com",
  "clientPhone": "+1234567890",
  "clientAddress": "456 Oak St",
  "clientCity": "City",
  "clientState": "State",
  "clientZip": "12345",
  "businessName": "Associated Business",
  "organizationId": "optional",
  "userEmail": "user@example.com"
}
```

#### Get Clients by Organization
```http
GET /getClientsByOrganizationId/{organizationId}
```

#### Get All Clients
```http
GET /getAllClients
```

### Client Assignment Management

#### Assign Client to User
```http
POST /assignClientToUser
Content-Type: application/json

{
  "userEmail": "user@example.com",
  "clientEmail": "client@example.com",
  "dateList": ["2024-01-15", "2024-01-16"],
  "startTimeList": ["09:00", "10:00"],
  "endTimeList": ["17:00", "18:00"],
  "breakList": ["60", "45"]
}
```

#### Get User Assignments
```http
GET /getUserAssignments/{userEmail}
```

#### Remove Client Assignment
```http
DELETE /removeClientAssignment
Content-Type: application/json

{
  "userEmail": "user@example.com",
  "clientEmail": "client@example.com"
}
```

### Security & OTP

#### Send OTP
```http
POST /sendOTP
Content-Type: application/json

{
  "email": "user@example.com",
  "clientEncryptionKey": "encryption-key"
}
```

#### Verify OTP
```http
POST /verifyOTP
Content-Type: application/json

{
  "userOTP": "123456",
  "userVerificationKey": "verification-key",
  "generatedOTP": "123456",
  "encryptVerificationKey": "encrypted-key"
}
```

#### Update Password
```http
POST /updatePassword
Content-Type: application/json

{
  "email": "user@example.com",
  "newPassword": "newHashedPassword"
}
```

## Multi-Tenant Implementation Details

### Data Isolation
- All business data is associated with an `organizationId`
- Users can only access data within their organization
- Database queries include organization context for data filtering

### Role-Based Access
- **Admin Role**: Business owners who can create organizations and manage all data
- **Normal Role**: Employees who can access organization data but with limited permissions

### Organization Workflow
1. **Business Owner Signup**: Creates new organization automatically
2. **Employee Signup**: Joins existing organization using invitation code
3. **Data Access**: All operations are scoped to user's organization

### Security Features
- Password hashing with Argon2 and salt
- OTP-based email verification
- JWT token-based authentication
- Encryption for sensitive data
- Organization code-based secure invitations

## Database Collections

### organizations
```javascript
{
  _id: ObjectId,
  name: String,
  code: String, // Unique invitation code
  ownerEmail: String,
  createdAt: Date,
  isActive: Boolean,
  settings: {
    allowEmployeeInvites: Boolean,
    maxEmployees: Number
  }
}
```

### clientAssignments
```javascript
{
  _id: ObjectId,
  userEmail: String,
  clientEmail: String,
  dateList: [String],
  startTimeList: [String],
  endTimeList: [String],
  breakList: [String],
  organizationId: String,
  createdAt: Date,
  isActive: Boolean
}
```

### login (users)
```javascript
{
  _id: ObjectId,
  firstName: String,
  lastName: String,
  email: String,
  password: String, // Hashed
  salt: String,
  abn: String,
  role: String, // "admin" or "normal"
  organizationId: String,
  createdAt: Date,
  isActive: Boolean
}
```

### businesses
```javascript
{
  _id: ObjectId,
  businessName: String,
  businessEmail: String,
  businessPhone: String,
  businessAddress: String,
  businessCity: String,
  businessState: String,
  businessZip: String,
  businessABN: String,
  organizationId: String,
  createdBy: String,
  createdAt: Date,
  isActive: Boolean
}
```

### clients
```javascript
{
  _id: ObjectId,
  clientFirstName: String,
  clientLastName: String,
  clientEmail: String,
  clientPhone: String,
  clientAddress: String,
  clientCity: String,
  clientState: String,
  clientZip: String,
  businessName: String,
  organizationId: String,
  createdBy: String,
  createdAt: Date,
  isActive: Boolean
}
```

## Development

### Running in Development Mode
```bash
npm run dev
```

### Testing
```bash
npm test
```

### Deployment
The server includes serverless deployment support. Configure your deployment platform accordingly.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.