# Core Documentation

This directory contains core technical documentation for the Invoice Management System backend.

## Contents

### 📋 System Analysis
- **[Inventory](./inventory.md)** - Complete list of implemented features and components
- **[File Map](./file_map.md)** - Detailed file structure and code ownership
- **[Dependencies](./dependencies.md)** - External libraries and their usage

### ⚙️ Configuration
- **[Environment Variables](./environment.md)** - All environment configuration options
- **[Database Schema](./database_schema.md)** - MongoDB collections and data models
- **[Firebase Configuration](./firebase_config.md)** - Firebase Auth and storage setup

### 🏗️ Architecture
- **[Design Patterns](./design_patterns.md)** - Architectural patterns and principles
- **[Data Models](./data_models.md)** - Entity relationships and data structures
- **[Security Model](./security_model.md)** - Authentication, authorization, and security measures

### 🔄 Processes
- **[Business Logic](./business_logic.md)** - Core business rules and workflows
- **[Integration Points](./integration_points.md)** - External system integrations
- **[Background Jobs](./background_jobs.md)** - Scheduled tasks and async processing

### 📊 Monitoring
- **[Logging Strategy](./logging_strategy.md)** - Logging levels, formats, and destinations
- **[Error Handling](./error_handling.md)** - Error classification and handling patterns
- **[Performance Metrics](./performance_metrics.md)** - Key performance indicators and monitoring

## Quick Reference

### System Overview
The Invoice Management System is a Node.js/Express.js backend that provides:
- **Authentication**: Firebase Auth integration
- **Data Storage**: MongoDB with Mongoose ODM
- **File Storage**: Local file system with Multer
- **API**: RESTful endpoints with JWT authentication
- **Architecture**: Controller-Service-Route pattern

### Key Technologies
- **Runtime**: Node.js 18+
- **Framework**: Express.js 4.x
- **Database**: MongoDB 6.x
- **Authentication**: Firebase Auth
- **File Upload**: Multer
- **Validation**: Express Validator
- **Documentation**: JSDoc

### Project Structure
```
backend/
├── config/           # Configuration files
├── controllers/      # HTTP request handlers
├── services/         # Business logic layer
├── routes/          # API route definitions
├── middleware/      # Custom middleware
├── models/          # Data models (if using Mongoose)
├── utils/           # Utility functions
├── uploads/         # File upload storage
├── docs/            # Documentation
└── server.js        # Application entry point
```

### Development Workflow
1. **Setup**: Install dependencies and configure environment
2. **Development**: Use nodemon for auto-restart during development
3. **Testing**: Run tests with npm test
4. **Documentation**: Update docs when making changes
5. **Deployment**: Build and deploy to production environment

### Getting Started
1. Review the [Inventory](./inventory.md) to understand what's implemented
2. Check [Environment Variables](./environment.md) for configuration
3. Examine [File Map](./file_map.md) to understand code organization
4. Read [API Documentation](../api/README.md) for endpoint details

---

**Note**: This documentation is maintained alongside code changes. When modifying the system, please update the relevant documentation files.