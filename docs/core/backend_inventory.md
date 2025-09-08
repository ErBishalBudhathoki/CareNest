# Backend System Inventory

## Overview

This document provides a comprehensive inventory of all implemented features, components, and capabilities in the Invoice Management System backend.

**Last Updated:** January 2025  
**System Version:** 1.0.0  
**Database:** MongoDB  
**Runtime:** Node.js 16+  

## Core System Architecture

### Technology Stack
- **Runtime:** Node.js (>=16.0.0)
- **Framework:** Express.js 4.18.2
- **Database:** MongoDB 6.17.0
- **Authentication:** Firebase Admin SDK 12.0.0
- **File Processing:** Multer, XLSX, CSV-Parser
- **Security:** Crypto, UUID, CORS
- **Email:** Nodemailer
- **Deployment:** Serverless-HTTP support

### Project Structure
```
backend/
├── config/           # Configuration files
├── controllers/      # Request handlers
├── middleware/       # Authentication & validation
├── routes/          # API route definitions
├── services/        # Business logic layer
├── utils/           # Helper functions
├── migration_scripts/ # Database setup
├── docs/            # Documentation
└── uploads/         # File storage
```

## Implemented Features

### 1. Authentication & Authorization

**Files:**
- `controllers/authController.js`
- `services/authService.js`
- `routes/auth.js`
- `middleware/auth.js`
- `config/firebase.js`

**Capabilities:**
- Multi-tenant organization support
- Firebase integration for mobile authentication
- Email-based user registration and login
- Organization code validation
- User photo upload and management
- Salt-based password security
- Session management
- Role-based access control

**API Endpoints:**
- `GET /checkEmail/:email` - Check if email exists
- `GET /getClientDetails/:email` - Get client information
- `POST /signup/:email` - User registration with organization
- `POST /login` - User authentication
- `GET /getUserPhoto/:email` - Retrieve user photo
- `GET /initData/:email` - Get user initialization data
- `POST /uploadPhoto` - Upload user photo
- `POST /getSalt` - Get authentication salt

### 2. Organization Management

**Files:**
- `controllers/organizationController.js`
- `services/organizationService.js`
- `routes/organization.js`

**Capabilities:**
- Multi-tenant organization structure
- Organization code generation and validation
- Organization settings and preferences
- User-organization associations
- Organization-level data isolation

### 3. User Management

**Files:**
- `controllers/userController.js`
- `services/userService.js`
- `routes/user.js`

**Capabilities:**
- User profile management
- User-organization relationships
- User permissions and roles
- User activity tracking
- User preferences management

### 4. Client Management

**Files:**
- `controllers/clientController.js`
- `services/clientService.js`
- `routes/client.js`

**Capabilities:**
- Client registration and profile management
- Client-organization associations
- Client assignment to users/employees
- Multiple client retrieval by email list
- Client scheduling and assignment management
- NDIS compliance tracking for clients

**API Endpoints:**
- `POST /addClient` - Add new client
- `GET /clients/:organizationId` - Get organization clients
- `GET /getClients` - Get all clients (backward compatibility)
- `GET /getMultipleClients/:emails` - Get multiple clients by email
- `POST /assignClientToUser` - Assign client to user with schedule
- `GET /getUserAssignments/:userEmail` - Get user assignments

### 5. Custom Pricing System

**Files:**
- `controllers/pricingController.js`
- `services/pricingService.js`
- `routes/pricing.js`
- `pricing_endpoints.js`

**Capabilities:**
- Organization-specific custom pricing
- Client-specific pricing overrides
- NDIS compliance validation
- Price cap checking and enforcement
- Approval workflows for pricing above NDIS caps
- Bulk pricing import/export
- Pricing lookup for invoice generation
- Audit trail for pricing changes

**API Endpoints:**
- `POST /api/pricing/create` - Create custom pricing
- `GET /api/pricing/organization/:organizationId` - Get organization pricing
- `GET /api/pricing/:pricingId` - Get specific pricing record
- `PUT /api/pricing/:pricingId` - Update pricing record
- `DELETE /api/pricing/:pricingId` - Delete/deactivate pricing
- `PUT /api/pricing/:pricingId/approval` - Update approval status
- `GET /api/pricing/lookup/:organizationId/:supportItemNumber` - Pricing lookup
- `POST /api/pricing/bulk-lookup` - Bulk pricing lookup
- `POST /api/pricing/bulk-import` - Bulk pricing import

### 6. Price Validation System

**Files:**
- `price_validation_endpoints.js`
- `price_validation_service.js`

**Capabilities:**
- Real-time price validation against NDIS caps
- Batch price validation
- Quote requirement checking
- Invoice line item validation
- Validation statistics and reporting
- NDIS compliance checking

**API Endpoints:**
- `POST /api/price-validation/validate` - Validate single price
- `POST /api/price-validation/validate-batch` - Batch price validation
- `GET /api/price-validation/price-caps/:supportItemNumber` - Get price caps
- `POST /api/price-validation/check-quote-required` - Check if quote required
- `POST /api/price-validation/validate-invoice-items` - Validate invoice items
- `GET /api/price-validation/stats/:organizationId` - Validation statistics

### 7. Expense Management

**Files:**
- `controllers/expenseController.js` (via services/expenseService.js)
- `services/expenseService.js`
- `routes/expense.js`
- `expenses_endpoints.js`

**Capabilities:**
- Manual expense entry and tracking
- Expense categorization
- Receipt upload and management
- Expense approval workflows
- Client and employee expense association
- Bulk expense import
- Expense reporting and analytics

**API Endpoints:**
- `POST /api/expenses/create` - Create expense
- `GET /api/expenses/organization/:organizationId` - Get organization expenses
- `GET /api/expenses/:expenseId` - Get specific expense
- `PUT /api/expenses/:expenseId` - Update expense
- `DELETE /api/expenses/:expenseId` - Delete expense
- `PUT /api/expenses/:expenseId/approval` - Update approval status
- `GET /api/expenses/categories` - Get expense categories
- `POST /api/expenses/bulk-import` - Bulk expense import

### 8. Recurring Expense Management

**Files:**
- `recurring_expense_endpoints.js`
- `recurring_expense_scheduler.js`

**Capabilities:**
- Automated recurring expense processing
- Flexible scheduling (daily, weekly, monthly, yearly)
- Recurring expense templates
- Automatic expense generation
- Recurring expense statistics
- Background processing scheduler

**API Endpoints:**
- `POST /api/recurring-expenses/process` - Process recurring expenses
- `POST /api/recurring-expenses/create` - Create recurring expense
- `GET /api/recurring-expenses/organization/:organizationId` - Get recurring expenses
- `PUT /api/recurring-expenses/:recurringExpenseId` - Update recurring expense
- `PUT /api/recurring-expenses/:recurringExpenseId/deactivate` - Deactivate
- `GET /api/recurring-expenses/statistics/:organizationId` - Get statistics
- `GET /api/recurring-expenses/:recurringExpenseId` - Get specific recurring expense

### 9. Invoice Generation System

**Files:**
- `controllers/invoiceController.js` (via services)
- `services/invoiceGenerationService.js`
- `routes/invoiceGeneration.js`
- `invoice_generation_endpoints.js`
- `invoice_generation_service.js`

**Capabilities:**
- Client assignment-based invoice generation
- Bulk invoice generation with pre-configured pricing
- Invoice preview and validation
- Real-time pricing integration
- Expense inclusion in invoices
- Invoice line item validation
- NDIS compliance checking
- Invoice generation reporting

**API Endpoints:**
- `POST /api/invoice-generation/generate` - Generate invoice line items
- `POST /api/invoice-generation/preview` - Get invoice preview
- `GET /api/invoice-generation/assignments/:userEmail` - Get available assignments
- `POST /api/invoice-generation/validate` - Validate invoice data
- `POST /api/invoice-generation/bulk-generate` - Generate bulk invoices
- `POST /api/invoice-generation/validate-existing` - Validate existing items
- `POST /api/invoice-generation/validate-pricing` - Real-time pricing validation
- `GET /api/invoice-generation/validation-report/:organizationId` - Validation report

### 10. Price Prompt System

**Files:**
- `price_prompt_endpoints.js`
- `price_prompt_service.js`

**Capabilities:**
- Interactive pricing prompts for non-standard items
- Pricing approval workflows
- Pending prompt management
- Invoice generation with prompts
- Prompt resolution tracking

**API Endpoints:**
- `POST /api/price-prompts/create` - Create price prompt
- `POST /api/price-prompts/resolve` - Resolve price prompt
- `GET /api/price-prompts/pending/:organizationId` - Get pending prompts
- `POST /api/price-prompts/cancel` - Cancel price prompt
- `POST /api/price-prompts/generate-invoice` - Generate invoice with prompts
- `POST /api/price-prompts/complete-invoice` - Complete invoice generation

### 11. Time Tracking & Employee Management

**Files:**
- `controllers/employeeTrackingController.js`
- `services/employeeTrackingService.js`
- `routes/employeeTracking.js`
- `active_timers_endpoints.js`
- `employee_tracking_endpoint.js`

**Capabilities:**
- Real-time time tracking with start/stop functionality
- Active timer management
- Employee work session tracking
- Time tracking analytics
- Integration with invoice generation
- Automated notifications for long shifts

**API Endpoints:**
- `POST /api/employee-tracking/start-timer` - Start work timer
- `POST /api/employee-tracking/stop-timer` - Stop work timer
- `GET /api/employee-tracking/active-timers/:userEmail` - Get active timers
- `GET /api/employee-tracking/sessions/:userEmail` - Get tracking sessions
- `POST /api/employee-tracking/manual-entry` - Manual time entry

### 12. Appointment Management

**Files:**
- `controllers/appointmentController.js`
- `services/appointmentService.js`
- `routes/appointment.js`

**Capabilities:**
- Appointment scheduling and management
- Client-appointment associations
- Appointment status tracking
- Integration with time tracking
- Appointment-based invoice generation

### 13. Business Profile Management

**Files:**
- `controllers/businessController.js`
- `services/businessService.js`
- `routes/business.js`

**Capabilities:**
- Business profile creation and management
- Business settings and preferences
- Business-client relationships
- Business compliance tracking

### 14. Support Items Management

**Files:**
- `controllers/supportItemsController.js`
- `services/supportItemsService.js`
- `routes/supportItems.js`
- `seed_support_items.js`

**Capabilities:**
- NDIS support items catalog
- Support item search and filtering
- Support item pricing information
- Support item compliance data
- Bulk support item import/seeding

### 15. Holiday Management

**Files:**
- `controllers/holidayController.js`
- `services/holidayService.js`
- `routes/holiday.js`
- `holiday.csv`

**Capabilities:**
- Public holiday tracking
- Holiday-based pricing adjustments
- Holiday calendar management
- Holiday impact on scheduling

### 16. Audit Trail System

**Files:**
- `services/auditService.js`
- `audit_trail_endpoints.js`
- `audit_trail_service.js`
- `routes/audit.js`

**Capabilities:**
- Comprehensive audit logging
- User action tracking
- Data change history
- Compliance reporting
- Audit log export (JSON/CSV)
- Audit statistics and analytics

**API Endpoints:**
- `GET /api/audit/entity/:entityType/:entityId` - Get entity audit history
- `GET /api/audit/organization/:organizationId` - Get organization audit logs
- `GET /api/audit/statistics/:organizationId` - Get audit statistics
- `POST /api/audit/log` - Create manual audit log
- `GET /api/audit/metadata` - Get audit metadata
- `GET /api/audit/export/:organizationId` - Export audit logs

### 17. Backward Compatibility System

**Files:**
- `backward_compatibility_endpoints.js`
- `backward_compatibility_service.js`
- `routes/backwardCompatibility.js`

**Capabilities:**
- Legacy invoice processing
- Legacy data transformation
- Compatibility validation
- Legacy data migration
- Legacy item mapping to NDIS

**API Endpoints:**
- `POST /api/backward-compatibility/process-legacy-invoice` - Process legacy invoice
- `POST /api/backward-compatibility/validate-compatibility` - Validate compatibility
- `POST /api/backward-compatibility/transform-legacy` - Transform legacy data
- `POST /api/backward-compatibility/migrate-batch` - Migrate legacy batch
- `GET /api/backward-compatibility/stats/:organizationId` - Get legacy stats
- `POST /api/backward-compatibility/map-legacy-item` - Map legacy item
- `POST /api/backward-compatibility/check-compatibility` - Check compatibility

## Utility Functions

### Crypto Helpers (`utils/cryptoHelpers.js`)
- OTP generation and verification
- Organization code generation
- Encryption key management
- Email OTP sending
- Password hashing utilities

### Date Helpers (`utils/dateHelpers.js`)
- Timestamp formatting
- Australian date formatting
- ISO date conversion
- Date range validation
- Business day calculations

### Validation Helpers (`utils/validationHelpers.js`)
- Email format validation
- Australian phone number validation
- ABN (Australian Business Number) validation
- Data type validation
- Input sanitization

### File Helpers (`utils/fileHelpers.js`)
- File upload handling
- File type validation
- File size management
- File storage utilities

### Pricing Helpers (`utils/pricingHelpers.js`)
- Price calculation utilities
- NDIS compliance checking
- Price formatting
- Currency conversion

### URL Helpers (`utils/urlHelpers.js`)
- URL validation and formatting
- API endpoint construction
- Query parameter handling

## Configuration

### Database Configuration (`config/database.js`)
- MongoDB connection management
- Database instance handling
- Connection pooling
- Error handling

### Firebase Configuration (`config/firebase.js`)
- Firebase Admin SDK setup
- Firebase Messaging configuration
- Push notification handling
- Firebase service verification

### Multer Configuration (`config/multer.js`)
- File upload configuration
- Storage settings
- File filtering
- Upload limits

## Middleware

### Authentication Middleware (`middleware/auth.js`)
- User authentication verification
- Organization access control
- JWT token validation
- Session management

### CORS Middleware (`middleware/cors.js`)
- Cross-origin request handling
- Security headers
- Origin validation

### Error Handler (`middleware/errorHandler.js`)
- Global error handling
- Error logging
- Error response formatting
- Stack trace management

### Logging Middleware (`middleware/logging.js`)
- Request/response logging
- Performance monitoring
- Debug information
- Audit trail integration

## Database Collections

### Core Collections
- `users` - User accounts and profiles
- `organizations` - Organization data and settings
- `clients` - Client information and preferences
- `login` - Authentication data
- `assignments` - Client-user assignments

### Pricing Collections
- `customPricing` - Organization and client-specific pricing
- `supportItems` - NDIS support items catalog
- `priceValidation` - Price validation history

### Invoice Collections
- `invoices` - Generated invoices
- `lineItems` - Invoice line items
- `invoiceGeneration` - Invoice generation history

### Expense Collections
- `expenses` - Manual expenses
- `recurringExpenses` - Recurring expense templates
- `expenseCategories` - Expense categorization

### Tracking Collections
- `employeeTracking` - Time tracking data
- `appointments` - Appointment records
- `activeTimers` - Current active timers

### System Collections
- `auditLogs` - Comprehensive audit trail
- `holidays` - Public holiday data
- `businessProfiles` - Business profile information
- `migrations` - Database migration tracking

## Migration Scripts

### Available Migrations
- `create_custom_pricing_collection.js` - Custom pricing setup
- `create_expenses_collection.js` - Expense management setup
- `migrate_user_organization_data.js` - User/org data enhancement
- `migrate_client_data.js` - Client data enhancement
- `migrate_ndis_data.js` - NDIS data updates
- `migrate_invoice_data.js` - Invoice data enhancement
- `migrate_existing_pricing.js` - Legacy pricing migration
- `run_all_migrations.js` - Master migration runner
- `test_migrations.js` - Migration testing
- `validate_migration.js` - Migration validation

## Environment Variables

### Required Configuration
- `MONGODB_URI` - MongoDB connection string
- `FIREBASE_PROJECT_ID` - Firebase project identifier
- `FIREBASE_PRIVATE_KEY` - Firebase service account key
- `FIREBASE_CLIENT_EMAIL` - Firebase service account email
- `EMAIL_USER` - SMTP email username
- `EMAIL_PASS` - SMTP email password
- `ENCRYPTION_KEY` - Data encryption key
- `JWT_SECRET` - JWT signing secret

### Optional Configuration
- `PORT` - Server port (default: 3000)
- `NODE_ENV` - Environment (development/production)
- `LOG_LEVEL` - Logging level
- `UPLOAD_PATH` - File upload directory
- `MAX_FILE_SIZE` - Maximum upload file size

## API Documentation

### Base URL
- Development: `http://localhost:3000`
- Production: `https://your-domain.com`

### Authentication
- Firebase JWT tokens for mobile authentication
- Organization-based access control
- Role-based permissions

### Response Format
```json
{
  "success": true,
  "data": {},
  "message": "Operation completed successfully",
  "timestamp": "2025-01-05T10:30:00Z"
}
```

### Error Format
```json
{
  "success": false,
  "error": "Error description",
  "code": "ERROR_CODE",
  "timestamp": "2025-01-05T10:30:00Z"
}
```

## Performance & Monitoring

### Database Indexes
- Organization-based data partitioning
- User email indexing
- Support item number indexing
- Date range indexing for time tracking
- Audit log indexing

### Caching Strategy
- Support items caching
- NDIS pricing data caching
- Organization settings caching
- User session caching

### Logging
- Request/response logging
- Error logging with stack traces
- Performance metrics
- Audit trail logging
- Debug information

## Security Features

### Data Protection
- Organization-level data isolation
- Encrypted sensitive data storage
- Secure file upload handling
- Input validation and sanitization

### Authentication Security
- Firebase integration
- JWT token validation
- Session management
- Password hashing with salt

### API Security
- CORS configuration
- Rate limiting (configurable)
- Input validation
- SQL injection prevention
- XSS protection

## Deployment

### Serverless Support
- Serverless-HTTP integration
- AWS Lambda compatibility
- Environment variable configuration
- Cold start optimization

### Traditional Deployment
- Node.js server deployment
- PM2 process management
- Docker containerization support
- Load balancer compatibility

## Testing

### Test Files
- `simple_db_check.js` - Database connectivity test
- `test_migrations.js` - Migration testing
- `validate_migration.js` - Migration validation

### Testing Strategy
- Unit tests for services
- Integration tests for APIs
- Database migration testing
- End-to-end workflow testing

## Documentation

### Available Documentation
- `AUDIT_TRAIL_DOCUMENTATION.md` - Audit system documentation
- `ENHANCED_DYNAMIC_PRICING_SYSTEM.md` - Pricing system documentation
- `FIREBASE_DEPLOYMENT_GUIDE.md` - Firebase deployment guide
- `INVOICE_GENERATION_API.md` - Invoice generation documentation
- `signup_flow_analysis.md` - User signup flow analysis
- `endToEndTechDocPack.md` - Comprehensive technical documentation

### Architecture Documentation
- C4 Context, Container, and Component diagrams
- Data flow diagrams
- Deployment diagrams
- Sequence flow diagrams

## Development Status

### Completed Features ✅
- Multi-tenant authentication system
- Organization and user management
- Client management with assignments
- Custom pricing system with NDIS compliance
- Expense management (manual and recurring)
- Invoice generation with real-time pricing
- Time tracking and employee management
- Comprehensive audit trail
- Price validation and compliance checking
- Backward compatibility for legacy data
- File upload and management
- Database migration system

### In Progress 🚧
- Advanced reporting and analytics
- Mobile push notifications
- Advanced caching implementation
- Performance optimization

### Planned Features 📋
- Advanced workflow automation
- Integration with external accounting systems
- Advanced reporting dashboards
- Mobile offline support
- Advanced security features

## Support & Maintenance

### Monitoring
- Application performance monitoring
- Database performance tracking
- Error rate monitoring
- User activity analytics

### Backup & Recovery
- Automated database backups
- Point-in-time recovery
- Data export capabilities
- Disaster recovery procedures

### Updates & Patches
- Security patch management
- Feature updates
- Database schema updates
- Migration script management

---

**Note:** This inventory reflects the current state of the backend system as of January 2025. For the most up-to-date information, refer to the individual component documentation and code comments.