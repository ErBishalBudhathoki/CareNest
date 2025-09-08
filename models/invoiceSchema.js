/**
 * Invoice Schema Definition
 * Defines the structure for invoice documents in MongoDB
 * Supports multi-tenant organization isolation and comprehensive invoice management
 */

const invoiceSchema = {
  // Core identification
  _id: 'ObjectId', // MongoDB ObjectId
  invoiceNumber: 'String', // Unique invoice identifier
  organizationId: 'String', // Required for multi-tenant isolation
  
  // Client information
  clientId: 'String',
  clientEmail: 'String',
  clientName: 'String',
  
  // Invoice content
  lineItems: [{
    _id: 'ObjectId',
    supportItemNumber: 'String',
    supportItemName: 'String',
    price: 'Number',
    quantity: 'Number',
    unit: 'String',
    totalPrice: 'Number',
    date: 'Date',
    organizationId: 'String'
  }],
  
  // Financial summary
  financialSummary: {
    subtotal: 'Number',
    taxAmount: 'Number',
    discountAmount: 'Number',
    expenseAmount: 'Number',
    totalAmount: 'Number',
    currency: 'String', // Default: 'AUD'
    exchangeRate: 'Number', // Default: 1.0
    paymentTerms: 'Number', // Days
    dueDate: 'Date'
  },
  
  // Invoice metadata
  metadata: {
    invoiceType: 'String', // 'service', 'expense', 'mixed'
    generationMethod: 'String', // 'manual', 'automatic', 'scheduled'
    templateUsed: 'String',
    customizations: ['String'],
    tags: ['String'],
    category: 'String',
    priority: 'String', // 'low', 'normal', 'high', 'urgent'
    internalNotes: 'String'
  },
  
  // Compliance tracking
  compliance: {
    ndisCompliant: 'Boolean',
    validationPassed: 'Boolean',
    validationErrors: ['String'],
    auditRequired: 'Boolean',
    complianceNotes: 'String',
    lastComplianceCheck: 'Date',
    complianceOfficer: 'String'
  },
  
  // Delivery information
  delivery: {
    method: 'String', // 'email', 'postal', 'portal', 'api'
    status: 'String', // 'pending', 'sent', 'delivered', 'failed'
    sentDate: 'Date',
    deliveredDate: 'Date',
    recipientEmail: 'String',
    deliveryAttempts: 'Number',
    lastAttemptDate: 'Date',
    deliveryNotes: 'String'
  },
  
  // Payment tracking
  payment: {
    status: 'String', // 'pending', 'partial', 'paid', 'overdue', 'cancelled'
    method: 'String', // 'bank_transfer', 'credit_card', 'cash', 'cheque'
    paidAmount: 'Number',
    paidDate: 'Date',
    transactionReference: 'String',
    paymentNotes: 'String',
    remindersSent: 'Number',
    lastReminderDate: 'Date',
    writeOffAmount: 'Number',
    writeOffReason: 'String'
  },
  
  // Workflow status
  workflow: {
    status: 'String', // 'draft', 'pending_approval', 'approved', 'generated', 'sent', 'paid', 'cancelled'
    approvalRequired: 'Boolean',
    approvedBy: 'String',
    approvalDate: 'Date',
    rejectionReason: 'String',
    workflowNotes: 'String',
    currentStep: 'String',
    nextAction: 'String'
  },
  
  // Audit trail
  auditTrail: {
    createdBy: 'String',
    createdAt: 'Date',
    updatedBy: 'String',
    updatedAt: 'Date',
    version: 'Number',
    changeHistory: [{
      timestamp: 'Date',
      userId: 'String',
      action: 'String',
      changes: 'Object',
      reason: 'String'
    }]
  },
  
  // Sharing and access control
  sharing: {
    isShared: 'Boolean',
    sharedWith: ['String'], // Array of email addresses
    shareToken: 'String', // Unique token for secure sharing
    shareExpiryDate: 'Date',
    sharePermissions: 'String', // 'view', 'download'
    shareHistory: [{
      sharedWith: 'String',
      sharedBy: 'String',
      sharedAt: 'Date',
      accessCount: 'Number',
      lastAccessed: 'Date'
    }]
  },
  
  // Deletion tracking (soft delete)
  deletion: {
    isDeleted: 'Boolean',
    deletedBy: 'String',
    deletedAt: 'Date',
    deletionReason: 'String',
    canRestore: 'Boolean',
    permanentDeletionDate: 'Date'
  }
};

/**
 * Invoice Status Enums
 */
const InvoiceStatus = {
  DRAFT: 'draft',
  PENDING_APPROVAL: 'pending_approval',
  APPROVED: 'approved',
  GENERATED: 'generated',
  SENT: 'sent',
  DELIVERED: 'delivered',
  PAID: 'paid',
  OVERDUE: 'overdue',
  CANCELLED: 'cancelled',
  DELETED: 'deleted'
};

/**
 * Payment Status Enums
 */
const PaymentStatus = {
  PENDING: 'pending',
  PARTIAL: 'partial',
  PAID: 'paid',
  OVERDUE: 'overdue',
  CANCELLED: 'cancelled',
  REFUNDED: 'refunded'
};

/**
 * Delivery Status Enums
 */
const DeliveryStatus = {
  PENDING: 'pending',
  SENT: 'sent',
  DELIVERED: 'delivered',
  FAILED: 'failed',
  BOUNCED: 'bounced'
};

/**
 * Invoice Type Enums
 */
const InvoiceType = {
  SERVICE: 'service',
  EXPENSE: 'expense',
  MIXED: 'mixed',
  RECURRING: 'recurring'
};

/**
 * Database Indexes for Performance
 */
const invoiceIndexes = [
  { organizationId: 1 }, // Primary filter for multi-tenancy
  { organizationId: 1, 'workflow.status': 1 }, // Status filtering
  { organizationId: 1, clientEmail: 1 }, // Client-specific invoices
  { organizationId: 1, 'auditTrail.createdAt': -1 }, // Recent invoices
  { organizationId: 1, 'payment.status': 1 }, // Payment status filtering
  { organizationId: 1, 'financialSummary.dueDate': 1 }, // Due date sorting
  { invoiceNumber: 1 }, // Unique invoice lookup
  { 'sharing.shareToken': 1 }, // Shared invoice access
  { 'deletion.isDeleted': 1, organizationId: 1 } // Exclude deleted invoices
];

/**
 * Validation Rules
 */
const validationRules = {
  required: ['organizationId', 'clientEmail', 'lineItems'],
  organizationId: {
    type: 'string',
    minLength: 3,
    pattern: /^[a-zA-Z0-9_-]+$/
  },
  clientEmail: {
    type: 'string',
    format: 'email'
  },
  lineItems: {
    type: 'array',
    minItems: 1,
    items: {
      required: ['supportItemNumber', 'price', 'quantity']
    }
  },
  'financialSummary.totalAmount': {
    type: 'number',
    minimum: 0
  }
};

module.exports = {
  invoiceSchema,
  InvoiceStatus,
  PaymentStatus,
  DeliveryStatus,
  InvoiceType,
  invoiceIndexes,
  validationRules
};