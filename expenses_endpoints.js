/**
 * Expense Management API Endpoints
 * Provides CRUD operations for the expenses collection
 * Supports receipt management, approval workflows, and expense categorization
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });
const { createAuditLog, AUDIT_ACTIONS, AUDIT_ENTITIES } = require('./audit_trail_service');

const uri = process.env.MONGODB_URI;

/**
 * Create a new expense record
 * POST /api/expenses/create
 */
async function createExpense(req, res) {
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
    } = req.body;

    console.log('=== BACKEND EXPENSE DEBUG: Received request body ===');
    console.log('receiptUrl:', receiptUrl);
    console.log('receiptFiles:', receiptFiles);
    console.log('receiptPhotos:', receiptPhotos);
    console.log('fileDescription:', fileDescription);
    console.log('photoDescription:', photoDescription);

    // Validation
    if (!organizationId || !expenseDate || !amount || !description || !category || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required fields: organizationId, expenseDate, amount, description, category, userEmail'
      });
    }

    if (amount <= 0) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Amount must be greater than 0'
      });
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
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
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

    console.log('=== BACKEND EXPENSE DEBUG: Created expense document ===');
    console.log('expenseDoc.receiptFiles:', expenseDoc.receiptFiles);
    console.log('expenseDoc.receiptPhotos:', expenseDoc.receiptPhotos);
    console.log('expenseDoc.fileDescription:', expenseDoc.fileDescription);
    console.log('expenseDoc.photoDescription:', expenseDoc.photoDescription);

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
      console.error('Error creating audit log for expense creation:', auditError);
      // Don't fail the main operation if audit logging fails
    }

    res.status(201).json({
      statusCode: 201,
      message: 'Expense created successfully',
      expenseId: result.insertedId.toString(),
      approvalRequired: requiresApproval
    });

  } catch (error) {
    console.error('Error creating expense:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error creating expense'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get expenses for an organization
 * GET /api/expenses/organization/:organizationId
 */
async function getOrganizationExpenses(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    console.log('=== BACKEND EXPENSE DEBUG: Received organizationId:', organizationId);
    console.log('=== BACKEND EXPENSE DEBUG: organizationId type:', typeof organizationId);
    
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
    } = req.query;

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Build query
    const query = { organizationId: organizationId, isActive: true };
    console.log('=== BACKEND EXPENSE DEBUG: Query object:', JSON.stringify(query, null, 2));
    
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
      query.isReimbursable = isReimbursable === 'true';
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
    console.log('=== BACKEND EXPENSE DEBUG: Total count found:', totalCount);
    
    // Debug: Let's also check what expenses exist for this organizationId without isActive filter
    const allExpensesForOrg = await db.collection('expenses')
      .find({ organizationId: organizationId })
      .toArray();
    console.log('=== BACKEND EXPENSE DEBUG: All expenses for organizationId (without isActive filter):', allExpensesForOrg.length);
    console.log('=== BACKEND EXPENSE DEBUG: Sample expense records:', JSON.stringify(allExpensesForOrg.slice(0, 2), null, 2));
    
    // Get expense records
    const expenses = await db.collection('expenses')
      .find(query)
      .sort(sort)
      .skip(skip)
      .limit(parseInt(limit))
      .toArray();
    
    console.log('=== BACKEND EXPENSE DEBUG: Filtered expenses found:', expenses.length);
    console.log('=== BACKEND EXPENSE DEBUG: Expense records:', JSON.stringify(expenses, null, 2));

    // Convert relative file paths to full URLs
    const processedExpenses = expenses.map(expense => {
      if (expense.receiptUrl && !expense.receiptUrl.startsWith('http')) {
        const protocol = req.secure || req.headers['x-forwarded-proto'] === 'https' ? 'https' : 'http';
        const host = req.get('host') || `localhost:${process.env.PORT || 8080}`;
        const baseUrl = `${protocol}://${host}`;
        expense.receiptUrl = `${baseUrl}${expense.receiptUrl.startsWith('/') ? expense.receiptUrl : '/' + expense.receiptUrl}`;
        console.log('=== BACKEND EXPENSE DEBUG: Converted receiptUrl to:', expense.receiptUrl);
      }
      return expense;
    });

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

    res.status(200).json({
      statusCode: 200,
      data: processedExpenses,
      summary: summary,
      pagination: {
        currentPage: parseInt(page),
        totalPages: Math.ceil(totalCount / parseInt(limit)),
        totalRecords: totalCount,
        hasNext: skip + processedExpenses.length < totalCount,
        hasPrev: parseInt(page) > 1
      }
    });

  } catch (error) {
    console.error('Error getting organization expenses:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error retrieving expense records'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get specific expense record by ID
 * GET /api/expenses/:expenseId
 */
async function getExpenseById(req, res) {
  let client;
  
  try {
    const { expenseId } = req.params;
    
    if (!ObjectId.isValid(expenseId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid expense ID format'
      });
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    const expense = await db.collection('expenses').findOne({
      _id: new ObjectId(expenseId)
    });

    if (!expense) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Expense record not found'
      });
    }

    // Convert relative file path to full URL
    if (expense.receiptUrl && !expense.receiptUrl.startsWith('http')) {
      const protocol = req.secure || req.headers['x-forwarded-proto'] === 'https' ? 'https' : 'http';
      const host = req.get('host') || `localhost:${process.env.PORT || 8080}`;
      const baseUrl = `${protocol}://${host}`;
      expense.receiptUrl = `${baseUrl}${expense.receiptUrl.startsWith('/') ? expense.receiptUrl : '/' + expense.receiptUrl}`;
      console.log('=== BACKEND EXPENSE DEBUG: Converted single expense receiptUrl to:', expense.receiptUrl);
    }

    res.status(200).json({
      statusCode: 200,
      data: expense
    });

  } catch (error) {
    console.error('Error getting expense by ID:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error retrieving expense record'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Update existing expense record
 * PUT /api/expenses/:expenseId
 */
async function updateExpense(req, res) {
  let client;
  
  try {
    const { expenseId } = req.params;
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
    } = req.body;

    console.log('=== BACKEND UPDATE EXPENSE DEBUG: Received request body ===');
    console.log('receiptUrl:', receiptUrl);
    console.log('receiptFiles:', receiptFiles);
    console.log('receiptPhotos:', receiptPhotos);
    console.log('fileDescription:', fileDescription);
    console.log('photoDescription:', photoDescription);

    if (!ObjectId.isValid(expenseId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid expense ID format'
      });
    }

    if (!userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'userEmail is required'
      });
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
      return res.status(404).json({
        statusCode: 404,
        message: 'Expense record not found'
      });
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
    }

    // Check if expense can be updated (not if already approved and processed)
    if (existingRecord.status === 'processed') {
      return res.status(400).json({
        statusCode: 400,
        message: 'Cannot update processed expense'
      });
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
      return res.status(404).json({
        statusCode: 404,
        message: 'Expense record not found'
      });
    }

    // Create audit log for expense approval status change
    try {
      await createAuditLog({
        action: AUDIT_ACTIONS.APPROVE,
        entityType: AUDIT_ENTITIES.EXPENSE,
        entityId: expenseId,
        userEmail,
        organizationId: existingRecord.organizationId,
        oldValues: { approvalStatus: existingRecord.approvalStatus },
        newValues: { approvalStatus: approvalStatus },
        reason: approvalNotes || `Expense ${approvalStatus}`,
        metadata: {
          previousStatus: existingRecord.approvalStatus,
          newStatus: approvalStatus,
          amount: existingRecord.amount,
          category: existingRecord.category,
          submittedBy: existingRecord.submittedBy
        }
      });
    } catch (auditError) {
      console.error('Error creating audit log for expense approval:', auditError);
      // Don't fail the main operation if audit logging fails
    }

    res.status(200).json({
      statusCode: 200,
      message: 'Expense record updated successfully',
      changesCount: changes.length,
      approvalRequired: updateDoc.requiresApproval
    });

  } catch (error) {
    console.error('Error updating expense:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error updating expense record'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Delete (deactivate) expense record
 * DELETE /api/expenses/:expenseId
 */
async function deleteExpense(req, res) {
  let client;
  
  try {
    const { expenseId } = req.params;
    const { userEmail, deleteReason } = req.body;

    if (!ObjectId.isValid(expenseId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid expense ID format'
      });
    }

    if (!userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'userEmail is required'
      });
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
      return res.status(404).json({
        statusCode: 404,
        message: 'Expense record not found'
      });
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
    }

    // Check if expense can be deleted
    if (existingRecord.status === 'processed') {
      return res.status(400).json({
        statusCode: 400,
        message: 'Cannot delete processed expense'
      });
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
      return res.status(404).json({
        statusCode: 404,
        message: 'Expense record not found'
      });
    }

    res.status(200).json({
      statusCode: 200,
      message: 'Expense record deleted successfully'
    });

  } catch (error) {
    console.error('Error deleting expense:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error deleting expense record'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Update approval status for expense record
 * PUT /api/expenses/:expenseId/approval
 */
async function updateExpenseApproval(req, res) {
  let client;
  
  try {
    const { expenseId } = req.params;
    const { approvalStatus, userEmail, approvalNotes } = req.body;

    if (!ObjectId.isValid(expenseId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid expense ID format'
      });
    }

    if (!approvalStatus || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'approvalStatus and userEmail are required'
      });
    }

    if (!['pending', 'approved', 'rejected'].includes(approvalStatus)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'approvalStatus must be pending, approved, or rejected'
      });
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
      return res.status(404).json({
        statusCode: 404,
        message: 'Expense record not found'
      });
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
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
      return res.status(404).json({
        statusCode: 404,
        message: 'Expense record not found'
      });
    }

    res.status(200).json({
      statusCode: 200,
      message: `Expense ${approvalStatus} successfully`,
      approvalStatus: approvalStatus
    });

  } catch (error) {
    console.error('Error updating expense approval:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error updating approval status'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get expense categories and subcategories
 * GET /api/expenses/categories
 */
async function getExpenseCategories(req, res) {
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

    res.status(200).json({
      statusCode: 200,
      data: categories
    });

  } catch (error) {
    console.error('Error getting expense categories:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error retrieving expense categories'
    });
  }
}

/**
 * Bulk import expense records
 * POST /api/expenses/bulk-import
 */
async function bulkImportExpenses(req, res) {
  let client;
  
  try {
    const { organizationId, expenses, userEmail, importNotes } = req.body;

    if (!organizationId || !expenses || !Array.isArray(expenses) || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'organizationId, expenses array, and userEmail are required'
      });
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
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
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

    res.status(200).json({
      statusCode: 200,
      message: 'Bulk import completed',
      results: results
    });

  } catch (error) {
    console.error('Error bulk importing expenses:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error performing bulk import'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

module.exports = {
  createExpense,
  getOrganizationExpenses,
  getExpenseById,
  updateExpense,
  deleteExpense,
  updateExpenseApproval,
  getExpenseCategories,
  bulkImportExpenses
};