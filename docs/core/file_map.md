# Project File Map & Code Ownership

This document provides a comprehensive overview of the project structure, file organization, and code ownership across the Invoice Management System.

## Project Overview

**Project Type**: Flutter Mobile Application with Node.js Backend  
**Architecture**: Client-Server with MongoDB Database  
**Total Files**: 500+ files across frontend and backend  
**Languages**: Dart (Frontend), JavaScript (Backend), Configuration files

## Root Directory Structure

```
invoice/
├── 📱 Frontend (Flutter App)
├── 🖥️ Backend (Node.js API)
├── 📋 Documentation (Markdown files)
├── ⚙️ Configuration (CI/CD, Environment)
└── 📦 Assets (Images, Fonts, Data)
```

## Detailed File Map

### 🖥️ Backend Structure (`/backend/`)

#### Core Server Files
| File | Purpose | Owner | Lines | Status |
|------|---------|-------|-------|--------|
| `server.js` | Main Express server & API endpoints | Backend Team | 800+ | ✅ Active |
| `package.json` | Node.js dependencies & scripts | DevOps | 50 | ✅ Active |
| `.env.example` | Environment variables template | DevOps | 20 | ✅ Active |

#### Configuration (`/backend/config/`)
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `database.js` | MongoDB connection config | Backend Team | ✅ Active |
| `firebase.js` | Firebase Admin SDK config | Backend Team | ✅ Active |
| `multer.js` | File upload configuration | Backend Team | ✅ Active |

#### Controllers (`/backend/controllers/`)
| File | Purpose | Owner | Features |
|------|---------|-------|----------|
| `authController.js` | Authentication logic | Backend Team | Login, Signup, OTP |
| `clientController.js` | Client management | Backend Team | CRUD, Assignments |
| `organizationController.js` | Organization management | Backend Team | CRUD, Verification |
| `pricingController.js` | Custom pricing logic | Backend Team | NDIS Pricing |
| `appointmentController.js` | Appointment scheduling | Backend Team | Time Management |
| `businessController.js` | Business entity management | Backend Team | Business CRUD |
| `employeeTrackingController.js` | Employee tracking | Backend Team | Time Tracking |
| `holidayController.js` | Holiday management | Backend Team | Calendar |
| `supportItemsController.js` | NDIS support items | Backend Team | Search, Lookup |
| `userController.js` | User management | Backend Team | Profile, Settings |

#### Services (`/backend/services/`)
| File | Purpose | Owner | Complexity |
|------|---------|-------|------------|
| `invoiceGenerationService.js` | Invoice generation logic | Backend Team | High |
| `pricingService.js` | Custom pricing service | Backend Team | High |
| `auditService.js` | Audit trail service | Backend Team | Medium |
| `authService.js` | Authentication service | Backend Team | Medium |
| `expenseService.js` | Expense management | Backend Team | Medium |
| `recurringExpenseService.js` | Recurring expenses | Backend Team | Medium |
| `priceValidationService.js` | Price validation | Backend Team | Medium |
| `backwardCompatibilityService.js` | Legacy support | Backend Team | Medium |
| `clientService.js` | Client operations | Backend Team | Low |
| `organizationService.js` | Organization operations | Backend Team | Low |
| `userService.js` | User operations | Backend Team | Low |
| `businessService.js` | Business operations | Backend Team | Low |
| `employeeTrackingService.js` | Employee tracking | Backend Team | Low |
| `holidayService.js` | Holiday operations | Backend Team | Low |
| `supportItemsService.js` | Support items | Backend Team | Low |
| `appointmentService.js` | Appointment operations | Backend Team | Low |
| `pricePromptService.js` | Price prompts | Backend Team | Low |

#### Routes (`/backend/routes/`) - **Not Currently Used**
| File | Purpose | Status | Notes |
|------|---------|--------|-------|
| `auth.js` | Authentication routes | 🚧 Prepared | Modular structure ready |
| `client.js` | Client routes | 🚧 Prepared | Not mounted in server.js |
| `pricing.js` | Pricing routes | 🚧 Prepared | Future refactoring target |
| `organization.js` | Organization routes | 🚧 Prepared | Modular design |
| `invoiceGeneration.js` | Invoice routes | 🚧 Prepared | Complex logic separated |
| `expense.js` | Expense routes | 🚧 Prepared | Ready for mounting |
| `audit.js` | Audit routes | 🚧 Prepared | Audit trail endpoints |
| `business.js` | Business routes | 🚧 Prepared | Business management |
| `employeeTracking.js` | Employee tracking routes | 🚧 Prepared | Time tracking |
| `holiday.js` | Holiday routes | 🚧 Prepared | Calendar management |
| `appointment.js` | Appointment routes | 🚧 Prepared | Scheduling |
| `supportItems.js` | Support items routes | 🚧 Prepared | NDIS items |
| `user.js` | User routes | 🚧 Prepared | User management |
| `pricePrompt.js` | Price prompt routes | 🚧 Prepared | Price prompting |
| `priceValidation.js` | Price validation routes | 🚧 Prepared | Validation logic |
| `recurringExpense.js` | Recurring expense routes | 🚧 Prepared | Automation |
| `backwardCompatibility.js` | Legacy routes | 🚧 Prepared | Compatibility |

#### Endpoint Files (Active)
| File | Purpose | Owner | API Count |
|------|---------|-------|----------|
| `pricing_endpoints.js` | Custom pricing APIs | Backend Team | 10+ |
| `audit_trail_endpoints.js` | Audit trail APIs | Backend Team | 6+ |
| `invoice_generation_endpoints.js` | Invoice APIs | Backend Team | 12+ |
| `price_validation_endpoints.js` | Validation APIs | Backend Team | 6+ |
| `recurring_expense_endpoints.js` | Recurring expense APIs | Backend Team | 7+ |
| `price_prompt_endpoints.js` | Price prompt APIs | Backend Team | 6+ |
| `backward_compatibility_endpoints.js` | Legacy APIs | Backend Team | 7+ |
| `expenses_endpoints.js` | Expense APIs | Backend Team | 8+ |
| `employee_tracking_endpoint.js` | Employee tracking APIs | Backend Team | 8+ |
| `active_timers_endpoints.js` | Timer APIs | Backend Team | 5+ |

#### Utilities (`/backend/utils/`)
| File | Purpose | Owner | Usage |
|------|---------|-------|-------|
| `cryptoHelpers.js` | Encryption utilities | Backend Team | High |
| `dateHelpers.js` | Date manipulation | Backend Team | High |
| `pricingHelpers.js` | Pricing calculations | Backend Team | High |
| `validationHelpers.js` | Input validation | Backend Team | Medium |
| `fileHelpers.js` | File operations | Backend Team | Medium |
| `urlHelpers.js` | URL utilities | Backend Team | Low |

#### Middleware (`/backend/middleware/`)
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `auth.js` | Authentication middleware | Backend Team | ✅ Active |
| `cors.js` | CORS configuration | Backend Team | ✅ Active |
| `errorHandler.js` | Error handling | Backend Team | ✅ Active |
| `logging.js` | Request logging | Backend Team | ✅ Active |
| `index.js` | Middleware exports | Backend Team | ✅ Active |

#### Migration Scripts (`/backend/migration_scripts/`)
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `run_all_migrations.js` | Master migration script | Backend Team | ✅ Complete |
| `create_custom_pricing_collection.js` | Pricing collection setup | Backend Team | ✅ Complete |
| `create_expenses_collection.js` | Expenses collection setup | Backend Team | ✅ Complete |
| `migrate_client_data.js` | Client data migration | Backend Team | ✅ Complete |
| `migrate_existing_pricing.js` | Pricing data migration | Backend Team | ✅ Complete |
| `migrate_invoice_data.js` | Invoice data migration | Backend Team | ✅ Complete |
| `migrate_ndis_data.js` | NDIS data migration | Backend Team | ✅ Complete |
| `migrate_user_organization_data.js` | User/org migration | Backend Team | ✅ Complete |
| `test_migrations.js` | Migration testing | Backend Team | ✅ Complete |
| `validate_migration.js` | Migration validation | Backend Team | ✅ Complete |

#### Documentation (`/backend/docs/`)
| Directory | Purpose | Owner | Status |
|-----------|---------|-------|--------|
| `core/` | Core documentation | Documentation Team | ✅ Complete |
| `api/` | API documentation | Backend Team | 🚧 In Progress |
| `architecture/` | Architecture diagrams | Architecture Team | ✅ Complete |
| `sequence_flows/` | Sequence diagrams | Architecture Team | ✅ Complete |
| `development/` | Development guides | DevOps Team | 📋 Planned |
| `operations/` | Operational runbooks | DevOps Team | 📋 Planned |
| `tracking/` | Project tracking | Project Management | 📋 Planned |

### 📱 Frontend Structure (`/lib/`)

#### Core Application (`/lib/app/`)

##### Core Framework (`/lib/app/core/`)
| Directory | Purpose | Owner | Components |
|-----------|---------|-------|------------|
| `base/` | Base classes & helpers | Frontend Team | BaseModel, BaseViewModel |
| `enums/` | Application enums | Frontend Team | ViewState |
| `interfaces/` | Interface definitions | Frontend Team | VisibilityToggle |
| `providers/` | State management | Frontend Team | App, Invoice, Notification |
| `services/` | Core services | Frontend Team | Dialog, Navigation, Timer |
| `utils/` | Utility functions | Frontend Team | Permissions, Services |
| `view-models/` | Base view models | Frontend Team | MVVM Pattern |

##### Dependency Injection (`/lib/app/di/`)
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `service_locator.dart` | Service locator pattern | Frontend Team | ✅ Active |

##### Features (`/lib/app/features/`)

###### Authentication (`/lib/app/features/auth/`)
| Directory | Purpose | Owner | Complexity |
|-----------|---------|-------|------------|
| `models/` | Auth data models | Frontend Team | Medium |
| `viewmodels/` | Auth business logic | Frontend Team | High |
| `views/` | Auth UI screens | Frontend Team | High |
| `widgets/` | Auth UI components | Frontend Team | Medium |
| `components/` | Reusable auth components | Frontend Team | Medium |
| `utils/` | Auth utilities | Frontend Team | Low |

###### Invoice Management (`/lib/app/features/invoice/`)
| Directory | Purpose | Owner | Complexity |
|-----------|---------|-------|------------|
| `models/` | Invoice data models | Frontend Team | High |
| `viewmodels/` | Invoice business logic | Frontend Team | Very High |
| `views/` | Invoice UI screens | Frontend Team | Very High |
| `widgets/` | Invoice UI components | Frontend Team | High |
| `controllers/` | Invoice controllers | Frontend Team | High |
| `repositories/` | Data access layer | Frontend Team | High |
| `services/` | Invoice services | Frontend Team | High |
| `domain/` | Domain logic | Frontend Team | High |
| `presentation/` | Presentation layer | Frontend Team | High |
| `utils/` | Invoice utilities | Frontend Team | Medium |

###### Client Management (`/lib/app/features/client/`)
| Directory | Purpose | Owner | Complexity |
|-----------|---------|-------|------------|
| `models/` | Client data models | Frontend Team | Medium |
| `viewmodels/` | Client business logic | Frontend Team | High |
| `views/` | Client UI screens | Frontend Team | High |
| `repositories/` | Client data access | Frontend Team | Medium |
| `providers/` | Client state management | Frontend Team | Medium |

###### Expense Management (`/lib/app/features/expenses/`)
| Directory | Purpose | Owner | Complexity |
|-----------|---------|-------|------------|
| `models/` | Expense data models | Frontend Team | Medium |
| `views/` | Expense UI screens | Frontend Team | High |
| `widgets/` | Expense UI components | Frontend Team | Medium |
| `data/` | Data access layer | Frontend Team | Medium |
| `presentation/` | Presentation layer | Frontend Team | High |
| `providers/` | Expense state management | Frontend Team | Medium |

###### Employee Tracking (`/lib/app/features/employee_tracking/`)
| Directory | Purpose | Owner | Complexity |
|-----------|---------|-------|------------|
| `models/` | Tracking data models | Frontend Team | Medium |
| `viewmodels/` | Tracking business logic | Frontend Team | High |
| `views/` | Tracking UI screens | Frontend Team | High |
| `widgets/` | Tracking UI components | Frontend Team | Medium |
| `repositories/` | Tracking data access | Frontend Team | Medium |

###### Other Features
| Feature | Purpose | Owner | Status |
|---------|---------|-------|--------|
| `admin/` | Admin functionality | Frontend Team | ✅ Active |
| `appointment/` | Appointment scheduling | Frontend Team | ✅ Active |
| `assignment/` | Task assignments | Frontend Team | ✅ Active |
| `assignment_list/` | Assignment listing | Frontend Team | ✅ Active |
| `business/` | Business management | Frontend Team | ✅ Active |
| `clockInandOut/` | Time clock functionality | Frontend Team | ✅ Active |
| `holiday/` | Holiday management | Frontend Team | ✅ Active |
| `home/` | Home dashboard | Frontend Team | ✅ Active |
| `notes/` | Note taking | Frontend Team | ✅ Active |
| `notifications/` | Push notifications | Frontend Team | ✅ Active |
| `organization/` | Organization management | Frontend Team | ✅ Active |
| `photo/` | Photo management | Frontend Team | ✅ Active |
| `pricing/` | Pricing management | Frontend Team | ✅ Active |
| `requests/` | Request management | Frontend Team | ✅ Active |
| `scheduling/` | Scheduling system | Frontend Team | ✅ Active |
| `settings/` | App settings | Frontend Team | ✅ Active |
| `shift_assignment/` | Shift management | Frontend Team | ✅ Active |
| `timesheet/` | Timesheet management | Frontend Team | ✅ Active |

##### Routing (`/lib/app/routes/`)
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `app_pages.dart` | Page definitions | Frontend Team | ✅ Active |
| `app_routes.dart` | Route constants | Frontend Team | ✅ Active |

##### Services (`/lib/app/services/`)
| Directory | Purpose | Owner | Complexity |
|-----------|---------|-------|------------|
| `api/` | API communication | Frontend Team | High |
| `local/` | Local storage | Frontend Team | Medium |
| `notification/` | Notification services | Frontend Team | Medium |
| `notificationservice/` | FCM & local notifications | Frontend Team | High |

##### Shared Components (`/lib/app/shared/`)
| Directory | Purpose | Owner | Usage |
|-----------|---------|-------|-------|
| `constants/` | App constants | Frontend Team | High |
| `providers/` | Shared providers | Frontend Team | High |
| `utils/` | Utility functions | Frontend Team | High |
| `widgets/` | Reusable UI components | Frontend Team | Very High |

#### Configuration (`/lib/config/`)
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `environment.dart` | Environment configuration | Frontend Team | ✅ Active |

#### Main Entry Points
| File | Purpose | Owner | Environment |
|------|---------|-------|-------------|
| `main.dart` | Default entry point | Frontend Team | Development |
| `main_development.dart` | Development entry | Frontend Team | Development |
| `main_production.dart` | Production entry | Frontend Team | Production |

### 📋 Documentation Files (Root)

#### Technical Documentation
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `README.md` | Project overview | Documentation Team | ✅ Complete |
| `TECHNICAL_DOCUMENTATION.md` | Technical specs | Documentation Team | ✅ Complete |
| `DEVELOPER_GUIDE.md` | Development guide | Documentation Team | ✅ Complete |

#### Feature Documentation
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `AUDIT_TRAIL_DOCUMENTATION.md` | Audit trail feature | Backend Team | ✅ Complete |
| `EMPLOYEE_TRACKING_FEATURE_DOCUMENTATION.md` | Employee tracking | Backend Team | ✅ Complete |
| `INVOICE_GENERATION_API.md` | Invoice generation | Backend Team | ✅ Complete |
| `PRICE_VALIDATION_INTEGRATION.md` | Price validation | Backend Team | ✅ Complete |
| `RECURRING_EXPENSE_AUTOMATION_DOCUMENTATION.md` | Recurring expenses | Backend Team | ✅ Complete |
| `ENHANCED_DYNAMIC_PRICING_SYSTEM.md` | Dynamic pricing | Backend Team | ✅ Complete |
| `BACKWARD_COMPATIBILITY_IMPLEMENTATION.md` | Legacy support | Backend Team | ✅ Complete |
| `PRICE_PROMPT_SYSTEM.md` | Price prompting | Backend Team | ✅ Complete |

#### Implementation Documentation
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `BULK_INVOICE_GENERATION.md` | Bulk operations | Backend Team | ✅ Complete |
| `PHOTO_UPLOAD_DOCUMENTATION.md` | Photo features | Frontend Team | ✅ Complete |
| `SIGNUP_LOGIN_DOCUMENTATION.md` | Authentication | Frontend Team | ✅ Complete |
| `TIMER_NOTIFICATION_FIX_DOCUMENTATION.md` | Timer fixes | Frontend Team | ✅ Complete |
| `HYBRID_DEEP_LINKING_DOCUMENTATION.md` | Deep linking | Frontend Team | ✅ Complete |

#### Deployment & CI/CD
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `FLAVOR_CICD_DOCUMENTATION.md` | CI/CD setup | DevOps Team | ✅ Complete |
| `FLAVOR_CONFIG.md` | Build flavors | DevOps Team | ✅ Complete |
| `GOOGLE_PLAY_PUBLISHING_GUIDE.md` | Play Store deployment | DevOps Team | ✅ Complete |
| `GOOGLE_PLAY_API_KEY_GUIDE.md` | API key setup | DevOps Team | ✅ Complete |

### ⚙️ Configuration Files

#### Flutter Configuration
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `pubspec.yaml` | Flutter dependencies | Frontend Team | ✅ Active |
| `pubspec.lock` | Dependency lock file | System | ✅ Active |
| `analysis_options.yaml` | Code analysis rules | Frontend Team | ✅ Active |
| `devtools_options.yaml` | DevTools configuration | Frontend Team | ✅ Active |

#### Platform Configuration

##### Android (`/android/`)
| File/Directory | Purpose | Owner | Status |
|----------------|---------|-------|--------|
| `app/build.gradle` | Android build config | DevOps Team | ✅ Active |
| `build.gradle` | Project build config | DevOps Team | ✅ Active |
| `gradle.properties` | Gradle properties | DevOps Team | ✅ Active |
| `fastlane/` | Deployment automation | DevOps Team | ✅ Active |
| `metadata/` | Play Store metadata | DevOps Team | ✅ Active |

##### iOS (`/ios/`)
| File/Directory | Purpose | Owner | Status |
|----------------|---------|-------|--------|
| `Runner.xcodeproj/` | Xcode project | DevOps Team | ✅ Active |
| `Podfile` | iOS dependencies | DevOps Team | ✅ Active |
| `Flutter/` | Flutter iOS config | DevOps Team | ✅ Active |
| `fastlane/` | iOS deployment | DevOps Team | ✅ Active |

#### CI/CD Configuration
| File | Purpose | Owner | Status |
|------|---------|-------|--------|
| `.github/workflows/flutter_ci.yml` | GitHub Actions CI | DevOps Team | ✅ Active |
| `.gitignore` | Git ignore rules | DevOps Team | ✅ Active |
| `.cursorrules` | Cursor IDE rules | Development Team | ✅ Active |

### 📦 Assets (`/assets/`)

#### Images (`/assets/images/`)
| File | Purpose | Owner | Usage |
|------|---------|-------|-------|
| `Invo.png` | App logo | Design Team | High |
| `splash_screen.png` | Splash screen | Design Team | High |
| `invoice_banner.png` | Invoice banner | Design Team | Medium |
| `client-profile.png` | Client placeholder | Design Team | Medium |
| `placeholder_product.png` | Product placeholder | Design Team | Low |

#### Icons (`/assets/icons/`)
| File | Purpose | Owner | Usage |
|------|---------|-------|-------|
| `app_icon.svg` | Production app icon | Design Team | High |
| `app_icon_dev.svg` | Development app icon | Design Team | High |
| `profile_placeholder.png` | Profile placeholder | Design Team | Medium |

#### Fonts (`/assets/fonts/`)
| File | Purpose | Owner | Usage |
|------|---------|-------|-------|
| `Raleway-VariableFont_wght.ttf` | Primary font | Design Team | High |
| `lato/` | Secondary font family | Design Team | Medium |

#### Data (`/assets/`)
| File | Purpose | Owner | Usage |
|------|---------|-------|-------|
| `ndis_support_items.json` | NDIS support items data | Backend Team | High |

### 🧪 Testing (`/test/`)
| Directory | Purpose | Owner | Status |
|-----------|---------|-------|--------|
| `services/` | Service tests | QA Team | 🚧 In Progress |

## Code Ownership Matrix

### Team Responsibilities

| Team | Primary Responsibilities | File Count | Complexity |
|------|-------------------------|------------|------------|
| **Backend Team** | API development, database, services | 150+ | High |
| **Frontend Team** | Flutter app, UI/UX, mobile features | 300+ | Very High |
| **DevOps Team** | CI/CD, deployment, configuration | 50+ | Medium |
| **Documentation Team** | Technical docs, API docs, guides | 30+ | Medium |
| **Design Team** | UI assets, icons, branding | 20+ | Low |
| **QA Team** | Testing, quality assurance | 10+ | Medium |

### Critical Files (High Impact)

| File | Owner | Impact | Reason |
|------|-------|--------|--------|
| `backend/server.js` | Backend Team | Critical | Main API server |
| `lib/main.dart` | Frontend Team | Critical | App entry point |
| `backend/services/invoiceGenerationService.js` | Backend Team | Critical | Core business logic |
| `lib/app/features/invoice/` | Frontend Team | Critical | Main feature |
| `pubspec.yaml` | Frontend Team | High | Dependencies |
| `backend/package.json` | Backend Team | High | Backend dependencies |
| `.github/workflows/flutter_ci.yml` | DevOps Team | High | CI/CD pipeline |

### Maintenance Priority

#### High Priority (Weekly Review)
- Backend API endpoints
- Invoice generation logic
- Authentication system
- Database migrations
- CI/CD pipeline

#### Medium Priority (Monthly Review)
- UI components
- Documentation
- Configuration files
- Asset management

#### Low Priority (Quarterly Review)
- Legacy compatibility
- Utility functions
- Test files
- Development tools

## Architecture Patterns

### Backend Patterns
- **MVC Pattern**: Controllers, Services, Models
- **Service Layer**: Business logic separation
- **Middleware Pattern**: Request processing
- **Repository Pattern**: Data access abstraction

### Frontend Patterns
- **MVVM Pattern**: Model-View-ViewModel
- **Provider Pattern**: State management
- **Service Locator**: Dependency injection
- **Feature-based Architecture**: Modular organization

## Development Workflow

### File Modification Guidelines

1. **Backend Changes**:
   - Modify service files for business logic
   - Update controllers for API changes
   - Add middleware for cross-cutting concerns
   - Update documentation

2. **Frontend Changes**:
   - Follow feature-based structure
   - Update view models for business logic
   - Modify views for UI changes
   - Update providers for state management

3. **Configuration Changes**:
   - Update environment files
   - Modify CI/CD configurations
   - Update dependency files
   - Document changes

### Code Review Focus Areas

1. **Security**: Authentication, authorization, data validation
2. **Performance**: Database queries, API response times
3. **Maintainability**: Code organization, documentation
4. **Testing**: Unit tests, integration tests
5. **Documentation**: API docs, technical specs

## Future Refactoring Opportunities

### Backend Improvements
1. **Modular Routes**: Migrate from server.js to route files
2. **Middleware Enhancement**: Centralized authentication
3. **Service Optimization**: Performance improvements
4. **API Versioning**: Implement versioning strategy

### Frontend Improvements
1. **State Management**: Optimize provider usage
2. **Component Library**: Standardize UI components
3. **Performance**: Optimize rendering and navigation
4. **Testing**: Increase test coverage

### Documentation Improvements
1. **API Documentation**: Generate OpenAPI specs
2. **Code Documentation**: Inline documentation
3. **Architecture Documentation**: Update diagrams
4. **User Documentation**: End-user guides

## Conclusion

This file map provides a comprehensive overview of the project structure and code ownership. The project follows modern architectural patterns with clear separation of concerns between frontend and backend components. Regular maintenance and refactoring opportunities have been identified to ensure continued code quality and maintainability.

**Last Updated**: January 2025  
**Next Review**: February 2025  
**Maintained By**: Documentation Team