# Invoice Management System - Backend Documentation

## Overview

This documentation provides comprehensive technical information about the Invoice Management System backend. The system is built with Node.js and Express.js, designed to support NDIS service providers in managing clients, tracking time, managing expenses, and generating invoices.

## Quick Start

### Prerequisites
- Node.js 16+ 
- MongoDB 4.4+
- Firebase project for authentication

### Installation
```bash
# Install dependencies
npm install

# Set up environment variables
cp .env.example .env
# Edit .env with your configuration

# Start the server
npm start
```

## Documentation Structure

### 📋 Core Documentation
- **[Overview](./overview.md)** - System purpose, user flows, and architecture summary
- **[API Documentation](./api/)** - Complete API endpoint documentation
- **[File Map](./file_map.md)** - Codebase structure and ownership
- **[Configuration](./configuration.md)** - Environment variables and settings

### 🏗️ Architecture
- **[C4 Context Diagram](./architecture/c4_context.mmd)** - System context and external dependencies
- **[C4 Container Diagram](./architecture/c4_container.mmd)** - High-level container architecture
- **[C4 Component Diagram](./architecture/c4_component.mmd)** - Internal component structure
- **[Deployment Diagram](./architecture/deployment_diagram.mmd)** - Deployment and infrastructure
- **[Data Flow Diagram](./architecture/data_flow_diagram.mmd)** - Data movement through the system

### 🔄 Sequence Flows
- **[Login Flow](./sequence_flows/login_sequence.mmd)** - Authentication and authorization
- **[Invoice Generation](./sequence_flows/invoice_generation_sequence.mmd)** - Billing and invoice creation
- **[Time Tracking](./sequence_flows/time_tracking_sequence.mmd)** - Employee time management
- **[Expense Management](./sequence_flows/expense_management_sequence.mmd)** - Expense tracking and approval
- **[Client Management](./sequence_flows/client_management_sequence.mmd)** - Client onboarding and management

### 📚 Operations
- **[Deployment Guide](./operations/deployment.md)** - How to deploy the application
- **[Troubleshooting](./operations/troubleshooting.md)** - Common issues and solutions
- **[Maintenance](./operations/maintenance.md)** - Regular maintenance tasks
- **[Monitoring](./operations/monitoring.md)** - System monitoring and alerts

### 📊 Development
- **[Development Setup](./development/setup.md)** - Local development environment
- **[Testing Guide](./development/testing.md)** - Testing strategies and tools
- **[Code Standards](./development/standards.md)** - Coding conventions and best practices
- **[Contributing](./development/contributing.md)** - How to contribute to the project

### 📝 Tracking
- **[Documentation Index](./tracking/docs_index.json)** - Searchable documentation index
- **[Open Questions](./tracking/open_questions.md)** - Unresolved technical questions
- **[TODO Items](./tracking/todo.md)** - Pending documentation tasks
- **[Change Log](./tracking/changelog.md)** - Documentation change history

## Key Features

### 🔐 Authentication & Authorization
- Firebase Authentication integration
- Role-based access control (Admin, Employee)
- JWT token management
- Session management

### 👥 Client Management
- NDIS participant onboarding
- Client-employee assignments
- Document management
- Custom pricing profiles

### ⏱️ Time Tracking
- Real-time timer functionality
- Manual time entry
- Employee monitoring dashboard
- Automated notifications

### 💰 Expense Management
- Receipt capture and storage
- Approval workflows
- Recurring expense automation
- Budget monitoring

### 📄 Invoice Generation
- NDIS-compliant invoicing
- Bulk invoice generation
- PDF generation and storage
- Invoice status tracking

### 💲 Pricing Management
- NDIS support item integration
- Custom pricing rules
- Rate validation
- Pricing history

## Technology Stack

- **Runtime**: Node.js 16+
- **Framework**: Express.js
- **Database**: MongoDB with Mongoose ODM
- **Authentication**: Firebase Auth
- **File Storage**: Local file system / Cloud storage
- **PDF Generation**: Custom PDF service
- **API Documentation**: OpenAPI/Swagger

## Architecture Patterns

### Layered Architecture
- **Routes**: HTTP request handling and routing
- **Controllers**: Request validation and response formatting
- **Services**: Business logic and data processing
- **Models**: Data access and MongoDB interactions
- **Middleware**: Cross-cutting concerns (auth, logging, validation)
- **Utilities**: Shared helper functions

### Key Design Principles
- **Separation of Concerns**: Clear boundaries between layers
- **Single Responsibility**: Each module has one clear purpose
- **Dependency Injection**: Services are injected into controllers
- **Error Handling**: Centralized error management
- **Logging**: Comprehensive audit trail

## Getting Help

### Documentation Issues
If you find issues with this documentation:
1. Check the [Open Questions](./tracking/open_questions.md) for known gaps
2. Review the [TODO Items](./tracking/todo.md) for planned improvements
3. Create an issue in the project repository

### Development Support
For development questions:
1. Review the [Troubleshooting Guide](./operations/troubleshooting.md)
2. Check the [API Documentation](./api/) for endpoint details
3. Consult the [Development Setup](./development/setup.md) for environment issues

### System Operations
For operational issues:
1. Follow the [Troubleshooting Guide](./operations/troubleshooting.md)
2. Check system [Monitoring](./operations/monitoring.md) dashboards
3. Review [Maintenance](./operations/maintenance.md) procedures

## Contributing to Documentation

This documentation is maintained alongside the codebase. When making changes:

1. **Update relevant documentation** when modifying code
2. **Follow the documentation standards** outlined in [Code Standards](./development/standards.md)
3. **Update the documentation index** in [docs_index.json](./tracking/docs_index.json)
4. **Add entries to the changelog** in [changelog.md](./tracking/changelog.md)

---

**Last Updated**: January 2025  
**Version**: 1.0.0  
**Maintainer**: Development Team