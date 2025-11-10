# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

CareNest is a comprehensive multi-tenant invoice management Flutter application with a Node.js Express backend. The app provides role-based access control for business owners and employees, featuring secure authentication, client/business management, invoice generation, time tracking, and expense management.

**Key Technologies:**
- Frontend: Flutter with Riverpod state management, GetX for routing
- Backend: Node.js Express with MongoDB
- Authentication: Firebase Auth + custom JWT
- Storage: Firebase Storage, MongoDB for data
- Notifications: Firebase Cloud Messaging
- Architecture: Clean Architecture with MVVM pattern

## Development Commands

### Flutter App

**Basic Development:**
```bash
# Install dependencies
flutter pub get

# Run development flavor
flutter run --flavor development -t lib/main_development.dart

# Run production flavor  
flutter run --flavor production -t lib/main_production.dart

# Run default (development)
flutter run
```

**Building:**
```bash
# Development APK
flutter build apk --flavor development -t lib/main_development.dart

# Production APK
flutter build apk --flavor production -t lib/main_production.dart

# Development App Bundle (for Play Store)
flutter build appbundle --flavor development -t lib/main_development.dart

# Production App Bundle
flutter build appbundle --flavor production -t lib/main_production.dart

# iOS builds
flutter build ios --flavor development -t lib/main_development.dart
flutter build ios --flavor production -t lib/main_production.dart
```

**Testing:**
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/photo_functionality_test.dart
flutter test test/services/enhanced_invoice_service_test.dart

# Generate test coverage
flutter test --coverage
```

**Code Generation:**
```bash
# Generate code (for freezed, json_serializable, etc.)
flutter packages pub run build_runner build

# Watch for changes and auto-generate
flutter packages pub run build_runner watch

# Clean generated files
flutter packages pub run build_runner clean
```

**Linting & Formatting:**
```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Fix formatting issues
dart fix --apply
```

**Icons & Assets:**
```bash
# Generate launcher icons for all flavors
flutter pub run flutter_launcher_icons
```

### Backend Development

**Running Backend:**
```bash
cd backend

# Development mode with nodemon
npm run dev
# or
npm run start:dev

# Production mode
npm run prod
# or  
npm run start:prod

# Basic start
npm start
```

**Health Checks:**
```bash
cd backend

# Check local server
npm run health-check:local

# Check deployed server
npm run health-check
```

## Architecture Overview

### Flutter App Structure

**Core Architecture:**
- **Clean Architecture**: Separation of concerns with data, domain, and presentation layers
- **MVVM Pattern**: ViewModels manage business logic, Views handle UI
- **Dependency Injection**: GetIt service locator pattern
- **State Management**: Riverpod for complex state, Provider for simple cases
- **Routing**: GetX routing with flavor-aware configuration

**Key Directories:**
- `lib/app/features/` - Feature-based modules (auth, invoice, expenses, etc.)
- `lib/app/core/` - Shared business logic, base classes, services
- `lib/app/shared/` - UI components, utilities, constants, themes
- `lib/config/` - Environment configuration, flavor management
- `lib/app/di/` - Dependency injection setup

**Feature Structure Example (`lib/app/features/invoice/`):**
- `models/` - Data models and business entities
- `viewmodels/` - Business logic and state management
- `views/` - UI screens and pages
- `services/` - Feature-specific services
- `repositories/` - Data access layer
- `widgets/` - Reusable UI components

### Backend Structure

**Architecture:**
- **Express.js** server with modular endpoint organization
- **Multi-tenant** architecture with organization-based data isolation
- **MongoDB** with connection pooling and transactions
- **Firebase Admin SDK** for authentication and notifications
- **Security**: Helmet, CORS, rate limiting, input validation

**Key Files:**
- `server.js` - Main server setup and middleware configuration
- `controllers/` - Route handlers for different entities
- `config/` - Database, Firebase, environment, and logger configuration
- `services/` - Business logic services
- `endpoints/` - API endpoint implementations
- `middleware/` - Custom middleware (logging, error tracking, health monitoring)

## Multi-Tenant Architecture

**Organization Isolation:**
- All data operations include `organizationId` filtering
- User authentication validates organization membership
- Invoice generation respects tenant boundaries
- Pricing and NDIS items are organization-specific

**Role-Based Access:**
- **Admin/Business Owner**: Full access to organization data
- **Employee**: Limited access based on assignments and permissions
- Authentication tokens carry role and organization information

## Environment Configuration

**Flavors:**
- **Development**: Uses development Firebase project, debug logging enabled
- **Production**: Uses production Firebase project, optimized for release

**Environment Files:**
- Frontend: `lib/config/env/development.dart` and `lib/config/env/production.dart`
- Backend: `.env.development` and `.env.production`

**Key Environment Variables:**
- `MONGODB_URI` - Database connection string
- Firebase configuration (project IDs, API keys)
- Email service configuration (Nodemailer)
- API base URLs and endpoints

## Key Features & Components

### Invoice Management
- **Automatic generation** based on time tracking and assignments
- **NDIS item integration** with pricing validation
- **PDF generation** with custom templates
- **Email delivery** with customizable templates
- **Multi-photo attachments** for receipts and documentation

### Time Tracking & Assignments
- Real-time clock in/out functionality
- Shift-based assignment management  
- GPS location tracking for on-site verification
- Automatic expense inclusion in invoices

### Expense Management
- Photo-based receipt capture and storage
- Automatic categorization and validation
- Recurring expense automation
- Integration with invoice generation

### Security Features
- **Encryption**: AES-256 for sensitive data, Argon2 for passwords
- **Authentication**: Firebase Auth + JWT tokens
- **Authorization**: Role-based access control (RBAC)
- **Audit Trail**: Comprehensive logging of all user actions
- **Data Validation**: Input sanitization and business rule validation

## Testing Strategy

**Frontend Testing:**
- Unit tests for ViewModels and services
- Widget tests for complex UI components
- Integration tests for critical user flows
- Mock services using Mockito

**Backend Testing:**
- API endpoint testing with request/response validation
- Database operation testing with test collections
- Authentication and authorization testing
- Error handling and edge case testing

## Deployment & CI/CD

**Fastlane Integration:**
```bash
cd android
fastlane deploy_development  # Deploy to internal track
fastlane deploy_production   # Deploy to production track
```

**Version Management:**
- Android version codes auto-increment via Fastlane
- iOS build numbers managed through Xcode/Fastlane
- Version naming follows semantic versioning (YYYY.MM.DD+build)

## Firebase Integration

**Services Used:**
- **Authentication**: User management and secure login
- **Cloud Messaging**: Push notifications for assignments and updates
- **Storage**: File and image storage for receipts and documents
- **App Check**: API protection against abuse

**Configuration:**
- Separate Firebase projects for development and production flavors
- Firebase configuration files are flavor-specific
- FCM tokens managed for multi-device support

## Database Schema Considerations

**MongoDB Collections:**
- `users` - User accounts with organization membership
- `organizations` - Tenant data and configuration
- `invoices` - Generated invoices with line items and metadata
- `assignments` - Work assignments and shift data
- `expenses` - Expense records with photo attachments
- `clients` - Client information per organization
- `pricing` - Custom NDIS pricing per organization

**Data Relationships:**
- Organization-based partitioning for multi-tenancy
- Reference-based relationships using ObjectId
- Embedded documents for performance-critical queries

## Common Development Patterns

**State Management:**
- Use Riverpod providers for complex, async state
- ViewModels extend BaseViewModel for consistent error handling
- UI components subscribe to ViewModels for reactive updates

**API Integration:**
- Centralized ApiMethod class handles HTTP requests
- Automatic token refresh and authentication
- Comprehensive error handling and user feedback

**File Operations:**
- Secure file upload with virus scanning
- Automatic image compression and optimization
- Cloud storage with CDN delivery

## Performance Considerations

**Flutter Optimizations:**
- Image caching with CachedNetworkImage
- Lazy loading for large lists
- Memory management for large datasets
- Background processing for heavy operations

**Backend Optimizations:**
- MongoDB connection pooling
- Query optimization with proper indexing
- Caching for frequently accessed data
- Rate limiting to prevent abuse

## Security Best Practices

- Never expose Firebase configuration in client code
- Use environment variables for sensitive configuration
- Implement proper input validation on both client and server
- Regular security audits and dependency updates
- Encrypt sensitive data before storage
- Implement proper session management and token rotation

## Known Issues & Considerations

- Deep link handling requires app to be initialized before processing
- iOS and Android have different permission handling requirements
- Firebase configuration must match the flavor being built
- Background timer tracking requires proper lifecycle management
- Multi-photo upload can consume significant memory on lower-end devices

