const { MongoClient } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

/**
 * Migration script to create the expenses collection with proper schema and indexes
 * This collection stores manual expenses, recurring expenses, and expense tracking data
 */

async function createExpensesCollection() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check if collection already exists
    const collections = await db.listCollections({ name: 'expenses' }).toArray();
    if (collections.length > 0) {
      console.log('expenses collection already exists');
      return;
    }
    
    // Create the expenses collection
    await db.createCollection('expenses');
    console.log('Created expenses collection');
    
    // Create indexes for efficient querying
    const expensesCollection = db.collection('expenses');
    
    // Compound index for organization and date-based queries
    await expensesCollection.createIndex(
      { organizationId: 1, expenseDate: -1 },
      { name: 'org_date_idx' }
    );
    
    // Compound index for client and employee expense tracking
    await expensesCollection.createIndex(
      { organizationId: 1, clientEmail: 1, employeeEmail: 1 },
      { name: 'client_employee_idx' }
    );
    
    // Index for expense categories and types
    await expensesCollection.createIndex(
      { organizationId: 1, category: 1, expenseType: 1 },
      { name: 'category_type_idx' }
    );
    
    // Index for approval workflow
    await expensesCollection.createIndex(
      { organizationId: 1, approvalStatus: 1 },
      { name: 'approval_status_idx' }
    );
    
    // Index for recurring expenses
    await expensesCollection.createIndex(
      { organizationId: 1, isRecurring: 1, nextOccurrence: 1 },
      { name: 'recurring_expenses_idx' }
    );
    
    // Index for invoice inclusion tracking
    await expensesCollection.createIndex(
      { organizationId: 1, includedInInvoice: 1, invoiceId: 1 },
      { name: 'invoice_inclusion_idx' }
    );
    
    console.log('Created indexes for expenses collection');
    
    // Insert sample document to demonstrate schema
    const sampleExpense = {
      _id: null, // Will be auto-generated
      organizationId: 'sample_org_id',
      
      // Basic expense information
      expenseType: 'manual', // 'manual', 'transportation', 'recurring'
      category: 'transportation', // 'transportation', 'materials', 'equipment', 'other'
      customCategory: null, // For 'other' category
      
      // Expense details
      description: 'Travel to client location',
      amount: 25.50,
      currency: 'AUD',
      expenseDate: new Date(),
      
      // Client and employee association
      clientEmail: 'client@example.com',
      clientName: 'John Doe',
      employeeEmail: 'employee@example.com',
      employeeName: 'Jane Smith',
      
      // Receipt and documentation
      receipt: {
        hasReceipt: true,
        receiptUrl: '/uploads/receipts/receipt_123.jpg',
        receiptFileName: 'fuel_receipt.jpg',
        uploadedAt: new Date()
      },
      
      // Recurring expense configuration
      isRecurring: false,
      recurringConfig: {
        frequency: null, // 'daily', 'weekly', 'monthly', 'yearly'
        interval: null, // Number (e.g., every 2 weeks = frequency: 'weekly', interval: 2)
        endDate: null, // When to stop recurring
        nextOccurrence: null, // Next scheduled occurrence
        maxOccurrences: null, // Maximum number of occurrences
        currentOccurrence: null // Current occurrence count
      },
      
      // Approval workflow
      approvalStatus: 'pending', // 'pending', 'approved', 'rejected'
      approvalRequired: true,
      approvedBy: null,
      approvedAt: null,
      rejectionReason: null,
      
      // Invoice integration
      includedInInvoice: false,
      invoiceId: null,
      invoiceDate: null,
      
      // Predefined transportation expenses
      transportationDetails: {
        fromAddress: '123 Start St, Sydney NSW',
        toAddress: '456 End St, Sydney NSW',
        distance: 15.2, // kilometers
        ratePerKm: 0.85, // AUD per kilometer
        calculatedAmount: 12.92 // distance * ratePerKm
      },
      
      // Custom expense fields
      customFields: {
        projectCode: null,
        costCenter: null,
        reference: null
      },
      
      // Audit trail
      createdBy: 'employee@example.com',
      createdAt: new Date(),
      updatedBy: 'employee@example.com',
      updatedAt: new Date(),
      
      // Status and flags
      isActive: true,
      isDeleted: false,
      
      // Additional metadata
      notes: 'Travel expense for client visit',
      tags: ['travel', 'client-visit'],
      
      // Version control
      version: 1,
      previousVersionId: null,
      
      // Compliance and validation
      taxDeductible: true,
      gstIncluded: true,
      gstAmount: 2.32,
      
      // Parent expense (for recurring expenses)
      parentExpenseId: null, // Links to the original recurring expense
      isRecurringInstance: false // True if this is an instance of a recurring expense
    };
    
    // Note: We're not inserting the sample document to avoid test data in production
    console.log('Sample document schema:');
    console.log(JSON.stringify(sampleExpense, null, 2));
    
    console.log('\n=== expenses Collection Schema ===');
    console.log('Fields:');
    console.log('- organizationId: String (required) - Multi-tenant isolation');
    console.log('- expenseType: String (required) - "manual", "transportation", "recurring"');
    console.log('- category: String (required) - Expense category');
    console.log('- description: String (required) - Expense description');
    console.log('- amount: Number (required) - Expense amount');
    console.log('- expenseDate: Date (required) - When expense occurred');
    console.log('- clientEmail: String (required) - Associated client');
    console.log('- employeeEmail: String (required) - Employee who incurred expense');
    console.log('- receipt: Object - Receipt information and file details');
    console.log('- isRecurring: Boolean - Whether this is a recurring expense');
    console.log('- recurringConfig: Object - Recurring expense configuration');
    console.log('- approvalStatus: String - Approval workflow status');
    console.log('- includedInInvoice: Boolean - Whether included in an invoice');
    console.log('- transportationDetails: Object - Transportation-specific details');
    console.log('- customFields: Object - Additional custom fields');
    console.log('- createdBy/updatedBy: String - Audit trail');
    console.log('- isActive: Boolean - Active status');
    console.log('- version: Number - Version control');
    
    console.log('\nIndexes created:');
    console.log('- org_date_idx: organizationId + expenseDate (desc)');
    console.log('- client_employee_idx: organizationId + clientEmail + employeeEmail');
    console.log('- category_type_idx: organizationId + category + expenseType');
    console.log('- approval_status_idx: organizationId + approvalStatus');
    console.log('- recurring_expenses_idx: organizationId + isRecurring + nextOccurrence');
    console.log('- invoice_inclusion_idx: organizationId + includedInInvoice + invoiceId');
    
  } catch (error) {
    console.error('Error creating expenses collection:', error);
    throw error;
  } finally {
    await client.close();
    console.log('\nMongoDB connection closed');
  }
}

// Run the migration if this file is executed directly
if (require.main === module) {
  createExpensesCollection()
    .then(() => {
      console.log('\n✅ expenses collection migration completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Migration failed:', error);
      process.exit(1);
    });
}

module.exports = { createExpensesCollection };