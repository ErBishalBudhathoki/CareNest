# Enhanced Invoice Generation - Database Migration Scripts

This directory contains migration scripts for setting up the enhanced invoice generation system with custom pricing and expense management capabilities.

## Overview

The enhanced invoice generation system introduces two new database collections:
- **`customPricing`**: Manages organization and client-specific pricing with NDIS compliance
- **`expenses`**: Tracks manual expenses, recurring expenses, and expense approvals

## Migration Scripts

### Core Migration Files

1. **`create_custom_pricing_collection.js`**
   - Creates the `customPricing` collection with proper schema validation
   - Sets up indexes for efficient querying
   - Supports multi-tenant pricing with client-specific overrides
   - Includes NDIS compliance validation

2. **`create_expenses_collection.js`**
   - Creates the `expenses` collection with comprehensive expense tracking
   - Supports manual and recurring expenses
   - Includes approval workflows and receipt management
   - Tracks expense categories and client/employee associations

3. **`migrate_user_organization_data.js`**
   - Enhances user and organization data with pricing and expense management fields
   - Adds permissions, preferences, and activity tracking
   - Creates default organization if none exists
   - Sets up proper role-based access controls

4. **`migrate_client_data.js`**
   - Enhances client data with pricing preferences and compliance settings
   - Adds NDIS compliance tracking and billing preferences
   - Updates client assignments with service delivery details
   - Creates indexes for efficient client data querying

5. **`migrate_ndis_data.js`**
   - Updates NDIS support items with enhanced pricing validation and metadata
   - Adds search optimization and compliance fields
   - Incorporates updates from NDIS.csv if available
   - Creates indexes for NDIS data performance

6. **`migrate_invoice_data.js`**
   - Enhances historical invoice and line item data for new pricing system
   - Adds pricing metadata, NDIS compliance, and audit trails
   - Updates invoices with workflow status and payment tracking
   - Performs data quality analysis and creates performance indexes

7. **`migrate_existing_pricing.js`**
   - Migrates existing invoice pricing data to the new `customPricing` collection
   - Analyzes historical pricing patterns
   - Creates audit trails for migrated data
   - Optional migration for existing systems

8. **`run_all_migrations.js`**
   - Master migration script that runs all migrations in correct order
   - Provides status checking and error handling
   - Includes comprehensive logging and progress tracking

## Quick Start

### Prerequisites

1. Ensure your `.env` file is configured with `MONGODB_URI`
2. Make sure MongoDB is running and accessible
3. Backup your existing database (recommended)

### Running Migrations

```bash
# Navigate to the migration scripts directory
cd backend/migration_scripts

# Run all migrations
node run_all_migrations.js

# Or explicitly run migrations
node run_all_migrations.js migrate
```

### Checking Migration Status

```bash
# Check if migrations have been applied
node run_all_migrations.js status
```

### Getting Help

```bash
# Show available commands
node run_all_migrations.js help
```

## Individual Migration Scripts

You can also run individual migration scripts if needed:

```bash
# Create collections
node create_custom_pricing_collection.js
node create_expenses_collection.js

# Migrate core data
node migrate_user_organization_data.js
node migrate_client_data.js
node migrate_ndis_data.js
node migrate_invoice_data.js

# Migrate pricing data (should be run last)
node migrate_existing_pricing.js
```

### Migration Order

The migrations should be run in this specific order for optimal results:

1. **Collection Creation** - Creates the necessary collections and indexes
2. **User & Organization Data** - Sets up organizational structure and permissions
3. **Client Data** - Enhances client information with pricing preferences
4. **NDIS Data** - Updates support item information
5. **Invoice Data** - Enhances historical invoice and line item data
6. **Pricing Data** - Migrates pricing patterns (depends on enhanced data from previous steps)

## Database Schema Details

### customPricing Collection

```javascript
{
  _id: ObjectId,
  organizationId: ObjectId,        // Multi-tenant support
  supportItemNumber: String,       // NDIS support item reference
  clientId: ObjectId,             // Optional: client-specific pricing
  pricingType: String,            // 'multiplier' or 'fixed'
  multiplier: Number,             // For multiplier-based pricing
  fixedPrice: Number,             // For fixed pricing
  effectiveDate: Date,            // When pricing becomes active
  expiryDate: Date,              // Optional: when pricing expires
  isActive: Boolean,             // Current status
  approvalStatus: String,         // 'pending', 'approved', 'rejected'
  approvedBy: ObjectId,          // Admin who approved
  approvedAt: Date,              // Approval timestamp
  createdBy: ObjectId,           // User who created
  createdAt: Date,               // Creation timestamp
  updatedAt: Date,               // Last update timestamp
  notes: String,                 // Optional notes
  auditTrail: Array              // Change history
}
```

### expenses Collection

```javascript
{
  _id: ObjectId,
  organizationId: ObjectId,       // Multi-tenant support
  expenseType: String,           // 'manual', 'recurring', 'transportation'
  category: String,              // Expense category
  amount: Number,                // Expense amount
  description: String,           // Expense description
  date: Date,                    // Expense date
  clientId: ObjectId,           // Associated client
  employeeId: ObjectId,         // Employee who incurred expense
  receiptUrl: String,           // Receipt file URL
  receiptMetadata: Object,      // Receipt file details
  approvalStatus: String,       // 'pending', 'approved', 'rejected'
  approvedBy: ObjectId,         // Admin who approved
  approvedAt: Date,             // Approval timestamp
  isRecurring: Boolean,         // Recurring expense flag
  recurringConfig: Object,      // Recurring settings
  nextOccurrence: Date,         // Next recurring date
  parentExpenseId: ObjectId,    // For recurring expense instances
  invoiceId: ObjectId,          // Associated invoice
  isIncludedInInvoice: Boolean, // Invoice inclusion status
  createdBy: ObjectId,          // User who created
  createdAt: Date,              // Creation timestamp
  updatedAt: Date,              // Last update timestamp
  tags: Array,                  // Expense tags
  metadata: Object              // Additional data
}
```

## Indexes Created

### customPricing Indexes
- `{ organizationId: 1, supportItemNumber: 1, clientId: 1 }` - Unique pricing lookup
- `{ organizationId: 1, isActive: 1 }` - Active pricing queries
- `{ organizationId: 1, approvalStatus: 1 }` - Approval workflow queries
- `{ effectiveDate: 1, expiryDate: 1 }` - Date range queries

### expenses Indexes
- `{ organizationId: 1, date: -1 }` - Date-based queries
- `{ organizationId: 1, clientId: 1, employeeId: 1 }` - Client/employee filtering
- `{ organizationId: 1, expenseType: 1, category: 1 }` - Category filtering
- `{ organizationId: 1, approvalStatus: 1 }` - Approval workflow
- `{ organizationId: 1, isRecurring: 1, nextOccurrence: 1 }` - Recurring expenses
- `{ organizationId: 1, invoiceId: 1, isIncludedInInvoice: 1 }` - Invoice association

## Data Quality and Validation

Each migration script includes:
- **Data validation and error handling** - Comprehensive error catching and reporting
- **Progress reporting and logging** - Detailed progress updates and completion summaries
- **Rollback capabilities** - Safe migration practices with duplicate prevention
- **Performance optimization** - Proper indexing and batch processing
- **Data quality analysis** - Completeness scoring and missing field detection
- **Audit trails** - Migration metadata and change tracking
- **Verification steps** - Post-migration data integrity checks

## Migration Features

### Enhanced Data Structures
- **Multi-tenant support** - Organization-based data isolation
- **Role-based permissions** - Granular access control for pricing and expenses
- **NDIS compliance tracking** - Automated compliance validation
- **Audit trails** - Complete change history and approval workflows
- **Data quality metrics** - Automated data completeness and validation scoring

### Performance Optimizations
- **Strategic indexing** - Optimized database queries for common operations
- **Batch processing** - Efficient handling of large datasets
- **Memory management** - Cursor-based iteration for large collections
- **Error resilience** - Graceful handling of individual record failures

### Backward Compatibility
- **Non-destructive migrations** - Original data is preserved
- **Incremental enhancement** - Only adds new fields, doesn't modify existing ones
- **Safe re-execution** - Migrations can be run multiple times safely
- **Legacy data support** - Maintains compatibility with existing invoice generation

## Error Handling

The migration scripts include comprehensive error handling:

- **Connection Errors**: Automatic retry with exponential backoff
- **Schema Validation**: Detailed error messages for invalid data
- **Index Creation**: Graceful handling of existing indexes
- **Data Migration**: Transaction support for data consistency

## Rollback Strategy

While these scripts create new collections and don't modify existing data, you can rollback by:

1. **Drop New Collections**:
   ```javascript
   // In MongoDB shell or script
   db.customPricing.drop();
   db.expenses.drop();
   ```

2. **Restore from Backup** (if you created one before migration)

## Troubleshooting

### Common Issues

1. **Connection Timeout**
   - Check MongoDB URI in `.env` file
   - Ensure MongoDB service is running
   - Verify network connectivity

2. **Permission Errors**
   - Ensure database user has create collection permissions
   - Check if user can create indexes

3. **Existing Data Conflicts**
   - Review existing collection names
   - Check for naming conflicts

4. **Memory Issues**
   - For large datasets, consider running migrations during off-peak hours
   - Monitor system resources during migration

### Debug Mode

To run migrations with detailed logging:

```bash
# Set debug environment variable
DEBUG=migration:* node run_all_migrations.js
```

## Next Steps After Migration

1. **Backend API Development**
   - Implement pricing management endpoints
   - Create expense management endpoints
   - Add NDIS compliance validation

2. **Frontend Integration**
   - Update invoice generation screens
   - Add pricing management interface
   - Implement expense tracking UI

3. **Testing**
   - Unit tests for new collections
   - Integration tests for pricing logic
   - End-to-end testing for invoice generation

4. **Documentation**
   - API documentation for new endpoints
   - User guides for new features
   - Admin documentation for pricing management

## Support

For issues or questions regarding the migration scripts:

1. Check the console output for detailed error messages
2. Review the database logs for connection issues
3. Verify the `.env` configuration
4. Ensure all prerequisites are met

## Version History

- **v1.0.0**: Initial migration scripts for enhanced invoice generation
  - customPricing collection creation
  - expenses collection creation
  - Existing data migration support
  - Comprehensive error handling and logging