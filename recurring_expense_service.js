/**
 * Recurring Expense Automation Service
 * Handles automated creation and management of recurring expenses
 * Supports multiple frequencies: daily, weekly, monthly, yearly
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });
const { createAuditLog, AUDIT_ACTIONS, AUDIT_ENTITIES } = require('./audit_trail_service');

const uri = process.env.MONGODB_URI;

/**
 * Calculate next occurrence date based on frequency and interval
 * @param {Date} currentDate - Current occurrence date
 * @param {string} frequency - 'daily', 'weekly', 'monthly', 'yearly'
 * @param {number} interval - Interval multiplier (e.g., every 2 weeks)
 * @returns {Date} Next occurrence date
 */
function calculateNextOccurrence(currentDate, frequency, interval = 1) {
  const nextDate = new Date(currentDate);
  
  switch (frequency) {
    case 'daily':
      nextDate.setDate(nextDate.getDate() + interval);
      break;
    case 'weekly':
      nextDate.setDate(nextDate.getDate() + (7 * interval));
      break;
    case 'monthly':
      nextDate.setMonth(nextDate.getMonth() + interval);
      break;
    case 'yearly':
      nextDate.setFullYear(nextDate.getFullYear() + interval);
      break;
    default:
      throw new Error(`Unsupported frequency: ${frequency}`);
  }
  
  return nextDate;
}

/**
 * Check if a recurring expense should be created
 * @param {Object} recurringExpense - Recurring expense template
 * @returns {boolean} Whether to create the expense
 */
function shouldCreateRecurringExpense(recurringExpense) {
  const now = new Date();
  const nextOccurrence = new Date(recurringExpense.recurringConfig.nextOccurrence);
  
  // Check if it's time to create the expense
  if (nextOccurrence > now) {
    return false;
  }
  
  // Check if we've reached the end date
  if (recurringExpense.recurringConfig.endDate) {
    const endDate = new Date(recurringExpense.recurringConfig.endDate);
    if (now > endDate) {
      return false;
    }
  }
  
  // Check if we've reached max occurrences
  if (recurringExpense.recurringConfig.maxOccurrences) {
    const currentCount = recurringExpense.recurringConfig.currentOccurrence || 0;
    if (currentCount >= recurringExpense.recurringConfig.maxOccurrences) {
      return false;
    }
  }
  
  return true;
}

/**
 * Create a new expense instance from a recurring template
 * @param {Object} recurringExpense - Recurring expense template
 * @param {Date} occurrenceDate - Date for this occurrence
 * @returns {Object} New expense instance
 */
function createExpenseInstance(recurringExpense, occurrenceDate) {
  const expenseInstance = {
    ...recurringExpense,
    _id: new ObjectId(),
    expenseDate: occurrenceDate,
    isRecurring: false,
    isRecurringInstance: true,
    parentExpenseId: recurringExpense._id,
    recurringConfig: null,
    approvalStatus: recurringExpense.approvalRequired ? 'pending' : 'approved',
    includedInInvoice: false,
    invoiceId: null,
    invoiceDate: null,
    createdAt: new Date(),
    updatedAt: new Date(),
    createdBy: 'system_recurring_automation'
  };
  
  // Remove fields that shouldn't be copied
  delete expenseInstance.nextOccurrence;
  
  return expenseInstance;
}

/**
 * Process all due recurring expenses for an organization
 * @param {string} organizationId - Organization ID
 * @returns {Object} Processing results
 */
async function processRecurringExpenses(organizationId = null) {
  let client;
  const results = {
    processed: 0,
    created: 0,
    updated: 0,
    errors: [],
    details: []
  };
  
  try {
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
    
    // Build query for recurring expenses
    const query = {
      isRecurring: true,
      isActive: true,
      isDeleted: false,
      'recurringConfig.nextOccurrence': { $lte: new Date() }
    };
    
    if (organizationId) {
      query.organizationId = organizationId;
    }
    
    const recurringExpenses = await expensesCollection.find(query).toArray();
    
    console.log(`Found ${recurringExpenses.length} due recurring expenses`);
    
    for (const recurringExpense of recurringExpenses) {
      try {
        results.processed++;
        
        if (!shouldCreateRecurringExpense(recurringExpense)) {
          results.details.push({
            expenseId: recurringExpense._id,
            action: 'skipped',
            reason: 'Not due or expired'
          });
          continue;
        }
        
        // Create new expense instance
        const occurrenceDate = new Date(recurringExpense.recurringConfig.nextOccurrence);
        const expenseInstance = createExpenseInstance(recurringExpense, occurrenceDate);
        
        // Insert the new expense instance
        await expensesCollection.insertOne(expenseInstance);
        results.created++;
        
        // Calculate next occurrence
        const nextOccurrence = calculateNextOccurrence(
          occurrenceDate,
          recurringExpense.recurringConfig.frequency,
          recurringExpense.recurringConfig.interval || 1
        );
        
        // Update the recurring expense template
        const updateData = {
          'recurringConfig.nextOccurrence': nextOccurrence,
          'recurringConfig.currentOccurrence': (recurringExpense.recurringConfig.currentOccurrence || 0) + 1,
          updatedAt: new Date(),
          updatedBy: 'system_recurring_automation'
        };
        
        // Check if this was the last occurrence
        if (recurringExpense.recurringConfig.maxOccurrences &&
            updateData['recurringConfig.currentOccurrence'] >= recurringExpense.recurringConfig.maxOccurrences) {
          updateData.isActive = false;
        }
        
        // Check if we've passed the end date
        if (recurringExpense.recurringConfig.endDate &&
            nextOccurrence > new Date(recurringExpense.recurringConfig.endDate)) {
          updateData.isActive = false;
        }
        
        await expensesCollection.updateOne(
          { _id: recurringExpense._id },
          { $set: updateData }
        );
        results.updated++;
        
        // Create audit log for the new expense instance
        await createAuditLog({
          action: AUDIT_ACTIONS.CREATE,
          entityType: AUDIT_ENTITIES.EXPENSE,
          entityId: expenseInstance._id.toString(),
          userEmail: 'system_recurring_automation',
          organizationId: recurringExpense.organizationId,
          newValues: {
            amount: expenseInstance.amount,
            description: expenseInstance.description,
            category: expenseInstance.category,
            expenseDate: expenseInstance.expenseDate,
            isRecurringInstance: true,
            parentExpenseId: recurringExpense._id.toString()
          },
          reason: 'Automated recurring expense creation',
          metadata: {
            frequency: recurringExpense.recurringConfig.frequency,
            interval: recurringExpense.recurringConfig.interval,
            occurrenceNumber: updateData['recurringConfig.currentOccurrence']
          }
        });
        
        results.details.push({
          expenseId: recurringExpense._id,
          newInstanceId: expenseInstance._id,
          action: 'created',
          nextOccurrence: nextOccurrence,
          occurrenceNumber: updateData['recurringConfig.currentOccurrence']
        });
        
      } catch (error) {
        console.error(`Error processing recurring expense ${recurringExpense._id}:`, error);
        results.errors.push({
          expenseId: recurringExpense._id,
          error: error.message
        });
      }
    }
    
    return results;
    
  } catch (error) {
    console.error('Error in processRecurringExpenses:', error);
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Create a new recurring expense template
 * @param {Object} expenseData - Expense data with recurring configuration
 * @returns {Object} Created recurring expense
 */
async function createRecurringExpense(expenseData) {
  let client;
  
  try {
    // Validate recurring configuration
    if (!expenseData.recurringConfig || !expenseData.recurringConfig.frequency) {
      throw new Error('Recurring configuration with frequency is required');
    }
    
    const validFrequencies = ['daily', 'weekly', 'monthly', 'yearly'];
    if (!validFrequencies.includes(expenseData.recurringConfig.frequency)) {
      throw new Error(`Invalid frequency. Must be one of: ${validFrequencies.join(', ')}`);
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
    
    // Calculate first occurrence
    const startDate = expenseData.expenseDate ? new Date(expenseData.expenseDate) : new Date();
    const nextOccurrence = calculateNextOccurrence(
      startDate,
      expenseData.recurringConfig.frequency,
      expenseData.recurringConfig.interval || 1
    );
    
    // Prepare recurring expense document
    const recurringExpense = {
      ...expenseData,
      _id: new ObjectId(),
      isRecurring: true,
      isRecurringInstance: false,
      recurringConfig: {
        frequency: expenseData.recurringConfig.frequency,
        interval: expenseData.recurringConfig.interval || 1,
        endDate: expenseData.recurringConfig.endDate || null,
        nextOccurrence: nextOccurrence,
        maxOccurrences: expenseData.recurringConfig.maxOccurrences || null,
        currentOccurrence: 0
      },
      approvalStatus: 'approved', // Recurring templates are pre-approved
      includedInInvoice: false,
      invoiceId: null,
      createdAt: new Date(),
      updatedAt: new Date(),
      isActive: true,
      isDeleted: false
    };
    
    // Insert the recurring expense template
    await expensesCollection.insertOne(recurringExpense);
    
    // Create audit log
    await createAuditLog({
      action: AUDIT_ACTIONS.CREATE,
      entityType: AUDIT_ENTITIES.EXPENSE,
      entityId: recurringExpense._id.toString(),
      userEmail: expenseData.createdBy || 'system',
      organizationId: expenseData.organizationId,
      newValues: {
        amount: recurringExpense.amount,
        description: recurringExpense.description,
        category: recurringExpense.category,
        isRecurring: true,
        frequency: recurringExpense.recurringConfig.frequency,
        interval: recurringExpense.recurringConfig.interval,
        nextOccurrence: recurringExpense.recurringConfig.nextOccurrence
      },
      reason: 'Recurring expense template created',
      metadata: {
        endDate: recurringExpense.recurringConfig.endDate,
        maxOccurrences: recurringExpense.recurringConfig.maxOccurrences
      }
    });
    
    return recurringExpense;
    
  } catch (error) {
    console.error('Error creating recurring expense:', error);
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Update a recurring expense template
 * @param {string} expenseId - Recurring expense ID
 * @param {Object} updateData - Update data
 * @returns {Object} Update result
 */
async function updateRecurringExpense(expenseId, updateData) {
  let client;
  
  try {
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
    
    // Get current recurring expense
    const currentExpense = await expensesCollection.findOne({
      _id: new ObjectId(expenseId),
      isRecurring: true
    });
    
    if (!currentExpense) {
      throw new Error('Recurring expense not found');
    }
    
    // Prepare update data
    const update = {
      ...updateData,
      updatedAt: new Date()
    };
    
    // If recurring config is being updated, recalculate next occurrence
    if (updateData.recurringConfig) {
      const newConfig = { ...currentExpense.recurringConfig, ...updateData.recurringConfig };
      
      if (newConfig.frequency !== currentExpense.recurringConfig.frequency ||
          newConfig.interval !== currentExpense.recurringConfig.interval) {
        // Recalculate next occurrence with new frequency/interval
        const currentNext = new Date(currentExpense.recurringConfig.nextOccurrence);
        newConfig.nextOccurrence = calculateNextOccurrence(
          currentNext,
          newConfig.frequency,
          newConfig.interval || 1
        );
      }
      
      update.recurringConfig = newConfig;
    }
    
    // Update the recurring expense
    const result = await expensesCollection.updateOne(
      { _id: new ObjectId(expenseId) },
      { $set: update }
    );
    
    // Create audit log
    await createAuditLog({
      action: AUDIT_ACTIONS.UPDATE,
      entityType: AUDIT_ENTITIES.EXPENSE,
      entityId: expenseId,
      userEmail: updateData.updatedBy || 'system',
      organizationId: currentExpense.organizationId,
      oldValues: {
        amount: currentExpense.amount,
        description: currentExpense.description,
        recurringConfig: currentExpense.recurringConfig
      },
      newValues: {
        amount: update.amount || currentExpense.amount,
        description: update.description || currentExpense.description,
        recurringConfig: update.recurringConfig || currentExpense.recurringConfig
      },
      reason: 'Recurring expense template updated'
    });
    
    return result;
    
  } catch (error) {
    console.error('Error updating recurring expense:', error);
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Deactivate a recurring expense (stop future occurrences)
 * @param {string} expenseId - Recurring expense ID
 * @param {string} userEmail - User performing the action
 * @returns {Object} Deactivation result
 */
async function deactivateRecurringExpense(expenseId, userEmail) {
  let client;
  
  try {
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
    
    // Get current recurring expense
    const currentExpense = await expensesCollection.findOne({
      _id: new ObjectId(expenseId),
      isRecurring: true
    });
    
    if (!currentExpense) {
      throw new Error('Recurring expense not found');
    }
    
    // Deactivate the recurring expense
    const result = await expensesCollection.updateOne(
      { _id: new ObjectId(expenseId) },
      {
        $set: {
          isActive: false,
          updatedAt: new Date(),
          updatedBy: userEmail
        }
      }
    );
    
    // Create audit log
    await createAuditLog({
      action: AUDIT_ACTIONS.UPDATE,
      entityType: AUDIT_ENTITIES.EXPENSE,
      entityId: expenseId,
      userEmail: userEmail,
      organizationId: currentExpense.organizationId,
      oldValues: { isActive: true },
      newValues: { isActive: false },
      reason: 'Recurring expense deactivated'
    });
    
    return result;
    
  } catch (error) {
    console.error('Error deactivating recurring expense:', error);
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get recurring expenses for an organization
 * @param {string} organizationId - Organization ID
 * @param {Object} options - Query options
 * @returns {Array} Recurring expenses
 */
async function getRecurringExpenses(organizationId, options = {}) {
  let client;
  
  try {
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
    
    const query = {
      organizationId: organizationId,
      isRecurring: true,
      isDeleted: false
    };
    
    if (options.isActive !== undefined) {
      query.isActive = options.isActive;
    }
    
    const expenses = await expensesCollection
      .find(query)
      .sort({ createdAt: -1 })
      .limit(options.limit || 100)
      .skip(options.skip || 0)
      .toArray();
    
    return expenses;
    
  } catch (error) {
    console.error('Error getting recurring expenses:', error);
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get statistics for recurring expenses
 * @param {string} organizationId - Organization ID
 * @returns {Object} Statistics
 */
async function getRecurringExpenseStats(organizationId) {
  let client;
  
  try {
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
    
    const pipeline = [
      {
        $match: {
          organizationId: organizationId,
          isRecurring: true,
          isDeleted: false
        }
      },
      {
        $group: {
          _id: null,
          totalRecurring: { $sum: 1 },
          activeRecurring: {
            $sum: { $cond: [{ $eq: ['$recurringConfig.isActive', true] }, 1, 0] }
          },
          totalMonthlyAmount: {
            $sum: {
              $cond: [
                { $and: [{ $eq: ['$recurringConfig.isActive', true] }, { $eq: ['$recurringConfig.frequency', 'monthly'] }] },
                '$amount',
                0
              ]
            }
          },
          byFrequency: {
            $push: {
              frequency: '$recurringConfig.frequency',
              amount: '$amount',
              isActive: '$recurringConfig.isActive'
            }
          }
        }
      }
    ];
    
    const result = await expensesCollection.aggregate(pipeline).toArray();
    
    if (result.length === 0) {
      return {
        totalRecurring: 0,
        activeRecurring: 0,
        totalMonthlyAmount: 0,
        byFrequency: {}
      };
    }
    
    const stats = result[0];
    
    // Process frequency breakdown
    const frequencyStats = {};
    stats.byFrequency.forEach(item => {
      if (!frequencyStats[item.frequency]) {
        frequencyStats[item.frequency] = { count: 0, activeCount: 0, totalAmount: 0 };
      }
      frequencyStats[item.frequency].count++;
      if (item.isActive) {
        frequencyStats[item.frequency].activeCount++;
        frequencyStats[item.frequency].totalAmount += item.amount;
      }
    });
    
    return {
      totalRecurring: stats.totalRecurring,
      activeRecurring: stats.activeRecurring,
      totalMonthlyAmount: stats.totalMonthlyAmount,
      byFrequency: frequencyStats
    };
    
  } catch (error) {
    console.error('Error getting recurring expense stats:', error);
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

module.exports = {
  processRecurringExpenses,
  createRecurringExpense,
  updateRecurringExpense,
  deactivateRecurringExpense,
  getRecurringExpenses,
  getRecurringExpenseStats,
  calculateNextOccurrence,
  shouldCreateRecurringExpense
};