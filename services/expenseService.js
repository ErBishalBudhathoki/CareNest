/**
 * Expense Service
 * Business logic for expense management operations
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const { createAuditLog, AUDIT_ACTIONS, AUDIT_ENTITIES } = require('./auditService');
const logger = require('../config/logger');

const uri = process.env.MONGODB_URI;

/**
 * Create a new expense record
 */
async function createExpense(expenseData) {
  let client;
  
  try {
    const {
      organizationId,
      clientId,
      expenseDate,
      amount,
      description,
      category,
      subcategory,
      supportItemNumber,
      supportItemName,
      receiptUrl,
      receiptMetadata,
      receiptFiles,
      receiptPhotos,
      fileDescription,
      photoDescription,
      isReimbursable = true,
      requiresApproval = false,
      userEmail,
      notes
    } = expenseData;

    // Validation
    if (!organizationId || !expenseDate || !amount || !description || !category || !userEmail) {
      throw new Error('Missing required fields: organizationId, expenseDate, amount, description, category, userEmail');
    }

    if (amount <= 0) {
      throw new Error('Amount must be greater than 0');
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: organizationId
    });

    if (!user) {
      throw new Error('User not authorized for this organization');
    }

    // Create expense document
    const expenseDoc = {
      _id: new ObjectId(),
      organizationId: organizationId,
      clientId: clientId || null,
      expenseDate: new Date(expenseDate),
      amount: parseFloat(amount),
      description: description,
      category: category,
      subcategory: subcategory || null,
      supportItemNumber: supportItemNumber || null,
      supportItemName: supportItemName || null,
      receiptUrl: receiptUrl || null,
      receiptMetadata: receiptMetadata || null,
      receiptFiles: receiptFiles || null,
      receiptPhotos: receiptPhotos || null,
      fileDescription: fileDescription || null,
      photoDescription: photoDescription || null,
      isReimbursable: isReimbursable,
      requiresApproval: requiresApproval,
      approvalStatus: requiresApproval ? 'pending' : 'approved',
      submittedBy: userEmail,
      submittedAt: new Date(),
      createdBy: userEmail,
      createdAt: new Date(),
      updatedBy: userEmail,
      updatedAt: new Date(),
      isActive: true,
      status: 'submitted',
      version: 1,
      notes: notes || null,
      auditTrail: [{
        action: 'created',
        performedBy: userEmail,
        timestamp: new Date(),
        changes: 'Initial expense record creation',
        reason: 'New expense submission'
      }]
    };

    const result = await db.collection('expenses').insertOne(expenseDoc);

    // Create audit log for expense creation
    try {
      await createAuditLog({
        action: AUDIT_ACTIONS.CREATE,
        entityType: AUDIT_ENTITIES.EXPENSE,
        entityId: result.insertedId.toString(),
        userEmail,
        organizationId,
        newValues: expenseDoc,
        reason: 'New expense record created',
        metadata: {
          category,
          subcategory,
          amount,
          isReimbursable,
          requiresApproval
        }
      });
    } catch (auditError) {
      logger.error('Audit log creation failed for expense', {
        error: auditError.message,
        stack: auditError.stack,
        expenseId: result.insertedId.toString(),
        organizationId,
        userEmail
      });
    }

    return {
      statusCode: 201,
      message: 'Expense created successfully',
      data: {
        expenseId: result.insertedId,
        expense: expenseDoc
      }
    };

  } catch (error) {
    logger.error('Expense creation failed', {
      error: error.message,
      stack: error.stack,
      organizationId: expenseData.organizationId,
      userEmail: expenseData.userEmail,
      amount: expenseData.amount
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get expense categories
 */
async function getExpenseCategories() {
  try {
    // Define standard expense categories
    const categories = {
      'travel': {
        name: 'Travel',
        subcategories: ['Transportation', 'Accommodation', 'Meals', 'Parking', 'Tolls']
      },
      'supplies': {
        name: 'Supplies',
        subcategories: ['Office Supplies', 'Medical Supplies', 'Equipment', 'Materials']
      },
      'professional_services': {
        name: 'Professional Services',
        subcategories: ['Consulting', 'Training', 'Legal', 'Accounting', 'IT Services']
      },
      'client_support': {
        name: 'Client Support',
        subcategories: ['Direct Support', 'Therapy', 'Equipment', 'Modifications']
      },
      'administration': {
        name: 'Administration',
        subcategories: ['Communications', 'Utilities', 'Insurance', 'Licenses']
      },
      'other': {
        name: 'Other',
        subcategories: ['Miscellaneous']
      }
    };

    return {
      statusCode: 200,
      data: categories
    };

  } catch (error) {
    logger.error('Expense categories retrieval failed', {
      error: error.message,
      stack: error.stack
    });
    throw error;
  }
}

/**
 * Get expenses for an organization with filtering and pagination
 */
async function getOrganizationExpenses(organizationId, options = {}) {
  let client;
  
  try {
    const { 
      clientId,
      category,
      subcategory,
      status,
      approvalStatus,
      isReimbursable,
      submittedBy,
      startDate,
      endDate,
      minAmount,
      maxAmount,
      page = 1,
      limit = 50,
      search,
      sortBy = 'expenseDate',
      sortOrder = 'desc'
    } = options;

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Build query
    const query = { organizationId: organizationId, isActive: true };
    
    if (clientId) {
      query.clientId = clientId;
    }
    
    if (category) {
      query.category = category;
    }
    
    if (subcategory) {
      query.subcategory = subcategory;
    }
    
    if (status) {
      query.status = status;
    }
    
    if (approvalStatus) {
      query.approvalStatus = approvalStatus;
    }
    
    if (isReimbursable !== undefined) {
      query.isReimbursable = isReimbursable === 'true' || isReimbursable === true;
    }
    
    if (submittedBy) {
      query.submittedBy = submittedBy;
    }
    
    // Date range filter
    if (startDate || endDate) {
      query.expenseDate = {};
      if (startDate) {
        query.expenseDate.$gte = new Date(startDate);
      }
      if (endDate) {
        query.expenseDate.$lte = new Date(endDate);
      }
    }
    
    // Amount range filter
    if (minAmount || maxAmount) {
      query.amount = {};
      if (minAmount) {
        query.amount.$gte = parseFloat(minAmount);
      }
      if (maxAmount) {
        query.amount.$lte = parseFloat(maxAmount);
      }
    }
    
    if (search) {
      query.$or = [
        { description: { $regex: search, $options: 'i' } },
        { supportItemName: { $regex: search, $options: 'i' } },
        { supportItemNumber: { $regex: search, $options: 'i' } },
        { notes: { $regex: search, $options: 'i' } }
      ];
    }

    // Calculate pagination
    const skip = (parseInt(page) - 1) * parseInt(limit);
    
    // Build sort object
    const sort = {};
    sort[sortBy] = sortOrder === 'desc' ? -1 : 1;
    
    // Get total count
    const totalCount = await db.collection('expenses').countDocuments(query);
    
    // Get expense records
    const expenses = await db.collection('expenses')
      .find(query)
      .sort(sort)
      .skip(skip)
      .limit(parseInt(limit))
      .toArray();

    // Calculate summary statistics
    const summaryPipeline = [
      { $match: query },
      {
        $group: {
          _id: null,
          totalAmount: { $sum: '$amount' },
          averageAmount: { $avg: '$amount' },
          reimbursableAmount: {
            $sum: {
              $cond: [{ $eq: ['$isReimbursable', true] }, '$amount', 0]
            }
          },
          pendingApprovalAmount: {
            $sum: {
              $cond: [{ $eq: ['$approvalStatus', 'pending'] }, '$amount', 0]
            }
          }
        }
      }
    ];
    
    const summaryResult = await db.collection('expenses').aggregate(summaryPipeline).toArray();
    const summary = summaryResult[0] || {
      totalAmount: 0,
      averageAmount: 0,
      reimbursableAmount: 0,
      pendingApprovalAmount: 0
    };

    return {
      statusCode: 200,
      data: expenses,
      summary: summary,
      pagination: {
        currentPage: parseInt(page),
        totalPages: Math.ceil(totalCount / parseInt(limit)),
        totalRecords: totalCount,
        hasNext: skip + expenses.length < totalCount,
        hasPrev: parseInt(page) > 1
      }
    };

  } catch (error) {
    logger.error('Organization expenses retrieval failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      filters: options
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get expense by ID
 */
async function getExpenseById(expenseId) {
  let client;
  
  try {
    if (!ObjectId.isValid(expenseId)) {
      throw new Error('Invalid expense ID format');
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    const expense = await db.collection('expenses').findOne({
      _id: new ObjectId(expenseId)
    });

    if (!expense) {
      throw new Error('Expense record not found');
    }

    return {
      statusCode: 200,
      data: expense
    };

  } catch (error) {
    logger.error('Expense retrieval by ID failed', {
      error: error.message,
      stack: error.stack,
      expenseId
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Update existing expense record
 */
async function updateExpense(expenseId, updateData) {
  let client;
  
  try {
    const {
      expenseDate,
      amount,
      description,
      category,
      subcategory,
      supportItemNumber,
      supportItemName,
      receiptUrl,
      receiptMetadata,
      receiptFiles,
      receiptPhotos,
      fileDescription,
      photoDescription,
      isReimbursable,
      requiresApproval,
      notes,
      userEmail,
      updateReason
    } = updateData;

    if (!ObjectId.isValid(expenseId)) {
      throw new Error('Invalid expense ID format');
    }

    if (!userEmail) {
      throw new Error('userEmail is required');
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Get existing record
    const existingRecord = await db.collection('expenses').findOne({
      _id: new ObjectId(expenseId)
    });

    if (!existingRecord) {
      throw new Error('Expense record not found');
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      throw new Error('User not authorized for this organization');
    }

    // Check if expense can be updated (not if already approved and processed)
    if (existingRecord.status === 'processed') {
      throw new Error('Cannot update processed expense');
    }

    // Build update object
    const updateDoc = {
      updatedBy: userEmail,
      updatedAt: new Date(),
      version: existingRecord.version + 1
    };

    // Track changes for audit trail
    const changes = [];
    
    if (expenseDate && new Date(expenseDate).getTime() !== existingRecord.expenseDate.getTime()) {
      updateDoc.expenseDate = new Date(expenseDate);
      changes.push(`expenseDate: ${existingRecord.expenseDate.toISOString()} → ${new Date(expenseDate).toISOString()}`);
    }
    
    if (amount !== undefined && parseFloat(amount) !== existingRecord.amount) {
      updateDoc.amount = parseFloat(amount);
      changes.push(`amount: ${existingRecord.amount} → ${amount}`);
    }
    
    if (description && description !== existingRecord.description) {
      updateDoc.description = description;
      changes.push(`description updated`);
    }
    
    if (category && category !== existingRecord.category) {
      updateDoc.category = category;
      changes.push(`category: ${existingRecord.category} → ${category}`);
    }
    
    if (subcategory !== undefined && subcategory !== existingRecord.subcategory) {
      updateDoc.subcategory = subcategory;
      changes.push(`subcategory: ${existingRecord.subcategory} → ${subcategory}`);
    }
    
    if (supportItemNumber !== undefined && supportItemNumber !== existingRecord.supportItemNumber) {
      updateDoc.supportItemNumber = supportItemNumber;
      changes.push(`supportItemNumber: ${existingRecord.supportItemNumber} → ${supportItemNumber}`);
    }
    
    if (supportItemName !== undefined && supportItemName !== existingRecord.supportItemName) {
      updateDoc.supportItemName = supportItemName;
      changes.push(`supportItemName updated`);
    }
    
    if (receiptUrl !== undefined && receiptUrl !== existingRecord.receiptUrl) {
      updateDoc.receiptUrl = receiptUrl;
      changes.push(`receiptUrl updated`);
    }
    
    if (receiptMetadata !== undefined) {
      updateDoc.receiptMetadata = receiptMetadata;
      changes.push(`receiptMetadata updated`);
    }
    
    if (receiptFiles !== undefined) {
      updateDoc.receiptFiles = receiptFiles;
      changes.push(`receiptFiles updated`);
    }
    
    if (receiptPhotos !== undefined) {
      updateDoc.receiptPhotos = receiptPhotos;
      changes.push(`receiptPhotos updated`);
    }
    
    if (fileDescription !== undefined) {
      updateDoc.fileDescription = fileDescription;
      changes.push(`fileDescription updated`);
    }
    
    if (photoDescription !== undefined) {
      updateDoc.photoDescription = photoDescription;
      changes.push(`photoDescription updated`);
    }
    
    if (isReimbursable !== undefined && isReimbursable !== existingRecord.isReimbursable) {
      updateDoc.isReimbursable = isReimbursable;
      changes.push(`isReimbursable: ${existingRecord.isReimbursable} → ${isReimbursable}`);
    }
    
    if (requiresApproval !== undefined && requiresApproval !== existingRecord.requiresApproval) {
      updateDoc.requiresApproval = requiresApproval;
      // If approval requirement changes, update approval status
      if (requiresApproval && existingRecord.approvalStatus === 'approved') {
        updateDoc.approvalStatus = 'pending';
        changes.push(`approvalStatus: approved → pending (due to approval requirement change)`);
      }
      changes.push(`requiresApproval: ${existingRecord.requiresApproval} → ${requiresApproval}`);
    }
    
    if (notes !== undefined && notes !== existingRecord.notes) {
      updateDoc.notes = notes;
      changes.push(`notes updated`);
    }

    // Add audit trail entry
    const auditEntry = {
      action: 'updated',
      performedBy: userEmail,
      timestamp: new Date(),
      changes: changes.join(', '),
      reason: updateReason || 'No reason provided'
    };

    updateDoc.$push = {
      auditTrail: auditEntry
    };

    // Perform update
    const result = await db.collection('expenses').updateOne(
      { _id: new ObjectId(expenseId) },
      { $set: updateDoc, $push: updateDoc.$push }
    );

    if (result.matchedCount === 0) {
      throw new Error('Expense record not found');
    }

    // Create audit log for expense update
    try {
      await createAuditLog({
        action: AUDIT_ACTIONS.UPDATE,
        entityType: AUDIT_ENTITIES.EXPENSE,
        entityId: expenseId,
        userEmail,
        organizationId: existingRecord.organizationId,
        oldValues: existingRecord,
        newValues: updateDoc,
        reason: updateReason || 'Expense record updated',
        metadata: {
          changesCount: changes.length,
          changes: changes
        }
      });
    } catch (auditError) {
      logger.error('Audit log creation failed for expense update', {
        error: auditError.message,
        stack: auditError.stack,
        expenseId,
        organizationId: existingRecord.organizationId,
        userEmail
      });
    }

    return {
      statusCode: 200,
      message: 'Expense record updated successfully',
      changesCount: changes.length,
      approvalRequired: updateDoc.requiresApproval
    };

  } catch (error) {
    logger.error('Expense update failed', {
      error: error.message,
      stack: error.stack,
      expenseId,
      userEmail: updateData.userEmail
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Delete expense record (soft delete)
 */
async function deleteExpense(expenseId, userEmail, deleteReason) {
  let client;
  
  try {
    if (!ObjectId.isValid(expenseId)) {
      throw new Error('Invalid expense ID format');
    }

    if (!userEmail) {
      throw new Error('userEmail is required');
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Get existing record
    const existingRecord = await db.collection('expenses').findOne({
      _id: new ObjectId(expenseId)
    });

    if (!existingRecord) {
      throw new Error('Expense record not found');
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      throw new Error('User not authorized for this organization');
    }

    // Check if expense can be deleted
    if (existingRecord.status === 'processed') {
      throw new Error('Cannot delete processed expense');
    }

    // Soft delete by setting isActive to false
    const auditEntry = {
      action: 'deleted',
      performedBy: userEmail,
      timestamp: new Date(),
      changes: 'Expense record deactivated',
      reason: deleteReason || 'No reason provided'
    };

    const result = await db.collection('expenses').updateOne(
      { _id: new ObjectId(expenseId) },
      {
        $set: {
          isActive: false,
          status: 'cancelled',
          deletedBy: userEmail,
          deletedAt: new Date(),
          updatedBy: userEmail,
          updatedAt: new Date(),
          version: existingRecord.version + 1
        },
        $push: {
          auditTrail: auditEntry
        }
      }
    );

    if (result.matchedCount === 0) {
      throw new Error('Expense record not found');
    }

    return {
      statusCode: 200,
      message: 'Expense record deleted successfully'
    };

  } catch (error) {
    logger.error('Expense deletion failed', {
      error: error.message,
      stack: error.stack,
      expenseId,
      userEmail
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Update approval status for expense record
 */
async function updateExpenseApproval(expenseId, approvalData) {
  let client;
  
  try {
    const { approvalStatus, userEmail, approvalNotes } = approvalData;

    if (!ObjectId.isValid(expenseId)) {
      throw new Error('Invalid expense ID format');
    }

    if (!approvalStatus || !userEmail) {
      throw new Error('approvalStatus and userEmail are required');
    }

    if (!['pending', 'approved', 'rejected'].includes(approvalStatus)) {
      throw new Error('approvalStatus must be pending, approved, or rejected');
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Get existing record
    const existingRecord = await db.collection('expenses').findOne({
      _id: new ObjectId(expenseId)
    });

    if (!existingRecord) {
      throw new Error('Expense record not found');
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      throw new Error('User not authorized for this organization');
    }

    // Add audit trail entry
    const auditEntry = {
      action: 'approval_updated',
      performedBy: userEmail,
      timestamp: new Date(),
      changes: `approvalStatus: ${existingRecord.approvalStatus} → ${approvalStatus}`,
      reason: approvalNotes || 'No notes provided'
    };

    const updateDoc = {
      approvalStatus: approvalStatus,
      approvedBy: approvalStatus === 'approved' ? userEmail : existingRecord.approvedBy,
      approvedAt: approvalStatus === 'approved' ? new Date() : existingRecord.approvedAt,
      rejectedBy: approvalStatus === 'rejected' ? userEmail : existingRecord.rejectedBy,
      rejectedAt: approvalStatus === 'rejected' ? new Date() : existingRecord.rejectedAt,
      approvalNotes: approvalNotes,
      status: approvalStatus === 'approved' ? 'approved' : (approvalStatus === 'rejected' ? 'rejected' : existingRecord.status),
      updatedBy: userEmail,
      updatedAt: new Date(),
      version: existingRecord.version + 1
    };

    const result = await db.collection('expenses').updateOne(
      { _id: new ObjectId(expenseId) },
      {
        $set: updateDoc,
        $push: {
          auditTrail: auditEntry
        }
      }
    );

    if (result.matchedCount === 0) {
      throw new Error('Expense record not found');
    }

    return {
      statusCode: 200,
      message: `Expense ${approvalStatus} successfully`,
      approvalStatus: approvalStatus
    };

  } catch (error) {
    logger.error('Expense approval update failed', {
      error: error.message,
      stack: error.stack,
      expenseId,
      approvalStatus: approvalData.approvalStatus,
      userEmail: approvalData.userEmail
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Bulk import expense records
 */
async function bulkImportExpenses(importData) {
  let client;
  
  try {
    const { organizationId, expenses, userEmail, importNotes } = importData;

    if (!organizationId || !expenses || !Array.isArray(expenses) || !userEmail) {
      throw new Error('organizationId, expenses array, and userEmail are required');
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: organizationId
    });

    if (!user) {
      throw new Error('User not authorized for this organization');
    }

    const results = {
      successful: 0,
      failed: 0,
      errors: []
    };

    const bulkOps = [];
    
    for (let i = 0; i < expenses.length; i++) {
      const expense = expenses[i];
      
      try {
        // Validate required fields
        if (!expense.expenseDate || !expense.amount || !expense.description || !expense.category) {
          results.failed++;
          results.errors.push({
            row: i + 1,
            error: 'Missing required fields: expenseDate, amount, description, category'
          });
          continue;
        }

        if (expense.amount <= 0) {
          results.failed++;
          results.errors.push({
            row: i + 1,
            error: 'Amount must be greater than 0'
          });
          continue;
        }

        const expenseDoc = {
          _id: new ObjectId(),
          organizationId: organizationId,
          clientId: expense.clientId || null,
          expenseDate: new Date(expense.expenseDate),
          amount: parseFloat(expense.amount),
          description: expense.description,
          category: expense.category,
          subcategory: expense.subcategory || null,
          supportItemNumber: expense.supportItemNumber || null,
          supportItemName: expense.supportItemName || null,
          receiptUrl: expense.receiptUrl || null,
          receiptMetadata: expense.receiptMetadata || null,
          isReimbursable: expense.isReimbursable !== undefined ? expense.isReimbursable : true,
          requiresApproval: expense.requiresApproval || false,
          approvalStatus: expense.requiresApproval ? 'pending' : 'approved',
          submittedBy: userEmail,
          submittedAt: new Date(),
          createdBy: userEmail,
          createdAt: new Date(),
          updatedBy: userEmail,
          updatedAt: new Date(),
          isActive: true,
          status: 'submitted',
          version: 1,
          notes: expense.notes || null,
          auditTrail: [{
            action: 'bulk_imported',
            performedBy: userEmail,
            timestamp: new Date(),
            changes: 'Bulk import',
            reason: importNotes || 'Bulk import operation'
          }]
        };

        bulkOps.push({
          insertOne: {
            document: expenseDoc
          }
        });
        
        results.successful++;
        
      } catch (error) {
        results.failed++;
        results.errors.push({
          row: i + 1,
          error: error.message
        });
      }
    }

    // Execute bulk operations
    if (bulkOps.length > 0) {
      await db.collection('expenses').bulkWrite(bulkOps, { ordered: false });
    }

    return {
      statusCode: 200,
      message: 'Bulk import completed',
      results: results
    };

  } catch (error) {
    logger.error('Bulk expense import failed', {
      error: error.message,
      stack: error.stack,
      organizationId: importData.organizationId,
      userEmail: importData.userEmail,
      expenseCount: importData.expenses?.length
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

module.exports = {
  createExpense,
  getExpenseCategories,
  getOrganizationExpenses,
  getExpenseById,
  updateExpense,
  deleteExpense,
  updateExpenseApproval,
  bulkImportExpenses
};