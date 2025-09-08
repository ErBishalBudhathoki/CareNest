/**
 * Recurring Expense Automation API Endpoints
 * Provides REST API for managing recurring expenses and automation
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });
const {
  processRecurringExpenses,
  createRecurringExpense,
  updateRecurringExpense,
  deactivateRecurringExpense,
  getRecurringExpenses,
  getRecurringExpenseStats
} = require('./services/recurringExpenseService');
const { createAuditLog, AUDIT_ACTIONS, AUDIT_ENTITIES } = require('./services/auditService');

const uri = process.env.MONGODB_URI;

/**
 * Process all due recurring expenses
 * POST /api/recurring-expenses/process
 */
async function processRecurringExpensesEndpoint(req, res) {
  try {
    const { organizationId, userEmail } = req.body;
    
    // Validation
    if (!userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required field: userEmail'
      });
    }
    
    // Process recurring expenses
    const results = await processRecurringExpenses(organizationId);
    
    // Create audit log for the processing action
    if (organizationId) {
      await createAuditLog({
        action: AUDIT_ACTIONS.EXPORT, // Using EXPORT as closest action for batch processing
        entityType: AUDIT_ENTITIES.EXPENSE,
        entityId: 'recurring_batch_process',
        userEmail: userEmail,
        organizationId: organizationId,
        newValues: {
          processed: results.processed,
          created: results.created,
          updated: results.updated,
          errors: results.errors.length
        },
        reason: 'Recurring expenses batch processing',
        metadata: {
          processedAt: new Date(),
          details: results.details
        }
      });
    }
    
    return res.status(200).json({
      statusCode: 200,
      message: 'Recurring expenses processed successfully',
      data: results
    });
    
  } catch (error) {
    console.error('Error in processRecurringExpensesEndpoint:', error);
    return res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Create a new recurring expense template
 * POST /api/recurring-expenses/create
 */
async function createRecurringExpenseEndpoint(req, res) {
  try {
    const {
      organizationId,
      clientId,
      amount,
      description,
      category,
      subcategory,
      supportItemNumber,
      supportItemName,
      recurringConfig,
      userEmail,
      notes,
      isReimbursable = true,
      requiresApproval = false
    } = req.body;
    
    // Validation
    if (!organizationId || !amount || !description || !category || !userEmail || !recurringConfig) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required fields: organizationId, amount, description, category, userEmail, recurringConfig'
      });
    }
    
    if (!recurringConfig.frequency) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Recurring configuration must include frequency'
      });
    }
    
    const validFrequencies = ['daily', 'weekly', 'monthly', 'yearly'];
    if (!validFrequencies.includes(recurringConfig.frequency)) {
      return res.status(400).json({
        statusCode: 400,
        message: `Invalid frequency. Must be one of: ${validFrequencies.join(', ')}`
      });
    }
    
    if (amount <= 0) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Amount must be greater than 0'
      });
    }
    
    // Prepare expense data
    const expenseData = {
      organizationId,
      clientId,
      expenseType: 'recurring',
      category,
      subcategory,
      customCategory: category === 'other' ? subcategory : null,
      description,
      amount: parseFloat(amount),
      currency: 'AUD',
      expenseDate: new Date(),
      supportItemNumber,
      supportItemName,
      isReimbursable,
      requiresApproval,
      recurringConfig: {
        frequency: recurringConfig.frequency,
        interval: recurringConfig.interval || 1,
        endDate: recurringConfig.endDate ? new Date(recurringConfig.endDate) : null,
        maxOccurrences: recurringConfig.maxOccurrences || null
      },
      notes,
      createdBy: userEmail,
      updatedBy: userEmail
    };
    
    // Create recurring expense
    const recurringExpense = await createRecurringExpense(expenseData);
    
    return res.status(201).json({
      statusCode: 201,
      message: 'Recurring expense created successfully',
      data: {
        recurringExpenseId: recurringExpense._id,
        nextOccurrence: recurringExpense.recurringConfig.nextOccurrence,
        frequency: recurringExpense.recurringConfig.frequency,
        interval: recurringExpense.recurringConfig.interval
      }
    });
    
  } catch (error) {
    console.error('Error in createRecurringExpenseEndpoint:', error);
    return res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Get recurring expenses for an organization
 * GET /api/recurring-expenses/organization/:organizationId
 */
async function getOrganizationRecurringExpensesEndpoint(req, res) {
  try {
    const { organizationId } = req.params;
    const { userEmail, isActive, limit, skip } = req.query;
    
    // Validation
    if (!organizationId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: organizationId, userEmail'
      });
    }
    
    // Verify user belongs to organization
    const client = new MongoClient(uri, {
      serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
      }
    });
    
    await client.connect();
    const db = client.db('Invoice');
    const loginCollection = db.collection('login');
    
    const user = await loginCollection.findOne({
      email: userEmail,
      organizationId: organizationId
    });
    
    if (!user) {
      await client.close();
      return res.status(403).json({
        statusCode: 403,
        message: 'Access denied: User not found in organization'
      });
    }
    
    await client.close();
    
    // Get recurring expenses
    const options = {
      isActive: isActive !== undefined ? isActive === 'true' : undefined,
      limit: limit ? parseInt(limit) : 50,
      skip: skip ? parseInt(skip) : 0
    };
    
    const recurringExpenses = await getRecurringExpenses(organizationId, options);
    
    return res.status(200).json({
      statusCode: 200,
      message: 'Recurring expenses retrieved successfully',
      data: {
        recurringExpenses,
        count: recurringExpenses.length,
        pagination: {
          limit: options.limit,
          skip: options.skip
        }
      }
    });
    
  } catch (error) {
    console.error('Error in getOrganizationRecurringExpensesEndpoint:', error);
    return res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Update a recurring expense template
 * PUT /api/recurring-expenses/:expenseId
 */
async function updateRecurringExpenseEndpoint(req, res) {
  try {
    const { expenseId } = req.params;
    const {
      amount,
      description,
      category,
      subcategory,
      supportItemNumber,
      supportItemName,
      recurringConfig,
      userEmail,
      notes,
      isReimbursable,
      requiresApproval
    } = req.body;
    
    // Validation
    if (!expenseId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: expenseId, userEmail'
      });
    }
    
    if (!ObjectId.isValid(expenseId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid expense ID format'
      });
    }
    
    // Validate recurring config if provided
    if (recurringConfig && recurringConfig.frequency) {
      const validFrequencies = ['daily', 'weekly', 'monthly', 'yearly'];
      if (!validFrequencies.includes(recurringConfig.frequency)) {
        return res.status(400).json({
          statusCode: 400,
          message: `Invalid frequency. Must be one of: ${validFrequencies.join(', ')}`
        });
      }
    }
    
    if (amount !== undefined && amount <= 0) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Amount must be greater than 0'
      });
    }
    
    // Prepare update data
    const updateData = {
      updatedBy: userEmail
    };
    
    if (amount !== undefined) updateData.amount = parseFloat(amount);
    if (description !== undefined) updateData.description = description;
    if (category !== undefined) {
      updateData.category = category;
      updateData.customCategory = category === 'other' ? subcategory : null;
    }
    if (subcategory !== undefined) updateData.subcategory = subcategory;
    if (supportItemNumber !== undefined) updateData.supportItemNumber = supportItemNumber;
    if (supportItemName !== undefined) updateData.supportItemName = supportItemName;
    if (notes !== undefined) updateData.notes = notes;
    if (isReimbursable !== undefined) updateData.isReimbursable = isReimbursable;
    if (requiresApproval !== undefined) updateData.requiresApproval = requiresApproval;
    if (recurringConfig !== undefined) updateData.recurringConfig = recurringConfig;
    
    // Update recurring expense
    const result = await updateRecurringExpense(expenseId, updateData);
    
    if (result.matchedCount === 0) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Recurring expense not found'
      });
    }
    
    return res.status(200).json({
      statusCode: 200,
      message: 'Recurring expense updated successfully',
      data: {
        expenseId: expenseId,
        modifiedCount: result.modifiedCount
      }
    });
    
  } catch (error) {
    console.error('Error in updateRecurringExpenseEndpoint:', error);
    return res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Deactivate a recurring expense (stop future occurrences)
 * PUT /api/recurring-expenses/:expenseId/deactivate
 */
async function deactivateRecurringExpenseEndpoint(req, res) {
  try {
    const { expenseId } = req.params;
    const { userEmail } = req.body;
    
    // Validation
    if (!expenseId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: expenseId, userEmail'
      });
    }
    
    if (!ObjectId.isValid(expenseId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid expense ID format'
      });
    }
    
    // Deactivate recurring expense
    const result = await deactivateRecurringExpense(expenseId, userEmail);
    
    if (result.matchedCount === 0) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Recurring expense not found'
      });
    }
    
    return res.status(200).json({
      statusCode: 200,
      message: 'Recurring expense deactivated successfully',
      data: {
        expenseId: expenseId,
        modifiedCount: result.modifiedCount
      }
    });
    
  } catch (error) {
    console.error('Error in deactivateRecurringExpenseEndpoint:', error);
    return res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Get recurring expense statistics for an organization
 * GET /api/recurring-expenses/statistics/:organizationId
 */
async function getRecurringExpenseStatisticsEndpoint(req, res) {
  try {
    const { organizationId } = req.params;
    const { userEmail } = req.query;
    
    // Validation
    if (!organizationId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: organizationId, userEmail'
      });
    }
    
    // Verify user belongs to organization
    const client = new MongoClient(uri, {
      serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
      }
    });
    
    await client.connect();
    const db = client.db('Invoice');
    const loginCollection = db.collection('login');
    
    const user = await loginCollection.findOne({
      email: userEmail,
      organizationId: organizationId
    });
    
    if (!user) {
      await client.close();
      return res.status(403).json({
        statusCode: 403,
        message: 'Access denied: User not found in organization'
      });
    }
    
    await client.close();
    
    // Get statistics
    const stats = await getRecurringExpenseStats(organizationId);
    
    return res.status(200).json({
      statusCode: 200,
      message: 'Recurring expense statistics retrieved successfully',
      data: stats
    });
    
  } catch (error) {
    console.error('Error in getRecurringExpenseStatisticsEndpoint:', error);
    return res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Get a specific recurring expense by ID
 * GET /api/recurring-expenses/:expenseId
 */
async function getRecurringExpenseByIdEndpoint(req, res) {
  let client;
  
  try {
    const { expenseId } = req.params;
    const { userEmail } = req.query;
    
    // Validation
    if (!expenseId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: expenseId, userEmail'
      });
    }
    
    if (!ObjectId.isValid(expenseId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid expense ID format'
      });
    }
    
    client = new MongoClient(uri, {
      serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
      }
    });
    
    await client.connect();
    const db = client.db('Invoice');
    const expensesCollection = db.collection('expenses');
    const loginCollection = db.collection('login');
    
    // Get the recurring expense
    const recurringExpense = await expensesCollection.findOne({
      _id: new ObjectId(expenseId),
      isRecurring: true,
      isDeleted: false
    });
    
    if (!recurringExpense) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Recurring expense not found'
      });
    }
    
    // Verify user belongs to organization
    const user = await loginCollection.findOne({
      email: userEmail,
      organizationId: recurringExpense.organizationId
    });
    
    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'Access denied: User not found in organization'
      });
    }
    
    // Get instances of this recurring expense
    const instances = await expensesCollection.find({
      parentExpenseId: new ObjectId(expenseId),
      isRecurringInstance: true,
      isDeleted: false
    }).sort({ expenseDate: -1 }).limit(10).toArray();
    
    return res.status(200).json({
      statusCode: 200,
      message: 'Recurring expense retrieved successfully',
      data: {
        recurringExpense,
        recentInstances: instances,
        instanceCount: instances.length
      }
    });
    
  } catch (error) {
    console.error('Error in getRecurringExpenseByIdEndpoint:', error);
    return res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

module.exports = {
  processRecurringExpensesEndpoint,
  createRecurringExpenseEndpoint,
  getOrganizationRecurringExpensesEndpoint,
  updateRecurringExpenseEndpoint,
  deactivateRecurringExpenseEndpoint,
  getRecurringExpenseStatisticsEndpoint,
  getRecurringExpenseByIdEndpoint
};