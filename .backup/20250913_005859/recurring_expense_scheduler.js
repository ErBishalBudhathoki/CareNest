/**
 * Recurring Expense Scheduler Service
 * Automatically processes recurring expenses at regular intervals
 */

const cron = require('node-cron');
const { processRecurringExpenses } = require('./services/recurringExpenseService');
const { createAuditLog, AUDIT_ACTIONS, AUDIT_ENTITIES } = require('./services/auditService');
const { MongoClient, ServerApiVersion } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const uri = process.env.MONGODB_URI;

/**
 * Scheduler configuration
 */
const SCHEDULER_CONFIG = {
  // Run every hour at minute 0 (e.g., 1:00, 2:00, 3:00, etc.)
  HOURLY_CRON: '0 * * * *',
  
  // Run every day at 6:00 AM
  DAILY_CRON: '0 6 * * *',
  
  // Run every Monday at 6:00 AM
  WEEKLY_CRON: '0 6 * * 1',
  
  // Run on the 1st day of every month at 6:00 AM
  MONTHLY_CRON: '0 6 1 * *',
  
  // Default timezone
  TIMEZONE: 'Australia/Sydney'
};

/**
 * Get all organizations that have recurring expenses
 */
async function getOrganizationsWithRecurringExpenses() {
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
    
    // Get distinct organization IDs that have active recurring expenses
    const organizations = await expensesCollection.distinct('organizationId', {
      isRecurring: true,
      isDeleted: false,
      'recurringConfig.isActive': true
    });
    
    return organizations;
    
  } catch (error) {
    console.error('Error getting organizations with recurring expenses:', error);
    return [];
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Process recurring expenses for all organizations
 */
async function processAllOrganizationsRecurringExpenses() {
  console.log(`[${new Date().toISOString()}] Starting scheduled recurring expense processing...`);
  
  try {
    const organizations = await getOrganizationsWithRecurringExpenses();
    
    if (organizations.length === 0) {
      console.log('No organizations with active recurring expenses found.');
      return;
    }
    
    console.log(`Processing recurring expenses for ${organizations.length} organizations...`);
    
    const results = {
      totalOrganizations: organizations.length,
      successfulOrganizations: 0,
      failedOrganizations: 0,
      totalExpensesProcessed: 0,
      totalExpensesCreated: 0,
      errors: []
    };
    
    // Process each organization
    for (const organizationId of organizations) {
      try {
        console.log(`Processing recurring expenses for organization: ${organizationId}`);
        
        const orgResult = await processRecurringExpenses(organizationId);
        
        results.successfulOrganizations++;
        results.totalExpensesProcessed += orgResult.processed;
        results.totalExpensesCreated += orgResult.created;
        
        // Log successful processing
        await createAuditLog({
          action: AUDIT_ACTIONS.EXPORT, // Using EXPORT as closest action for batch processing
          entityType: AUDIT_ENTITIES.EXPENSE,
          entityId: 'scheduled_recurring_process',
          userEmail: 'system@scheduler',
          organizationId: organizationId,
          newValues: {
            processed: orgResult.processed,
            created: orgResult.created,
            updated: orgResult.updated,
            errors: orgResult.errors.length
          },
          reason: 'Scheduled recurring expenses processing',
          metadata: {
            scheduledAt: new Date(),
            processingType: 'automatic',
            details: orgResult.details
          }
        });
        
        console.log(`Organization ${organizationId}: Processed ${orgResult.processed}, Created ${orgResult.created}`);
        
      } catch (orgError) {
        console.error(`Error processing organization ${organizationId}:`, orgError);
        results.failedOrganizations++;
        results.errors.push({
          organizationId,
          error: orgError.message
        });
      }
    }
    
    console.log(`[${new Date().toISOString()}] Scheduled processing completed:`);
    console.log(`- Organizations processed: ${results.successfulOrganizations}/${results.totalOrganizations}`);
    console.log(`- Total expenses processed: ${results.totalExpensesProcessed}`);
    console.log(`- Total expenses created: ${results.totalExpensesCreated}`);
    
    if (results.errors.length > 0) {
      console.log(`- Errors: ${results.errors.length}`);
      results.errors.forEach(error => {
        console.log(`  - ${error.organizationId}: ${error.error}`);
      });
    }
    
    return results;
    
  } catch (error) {
    console.error('Error in scheduled recurring expense processing:', error);
    throw error;
  }
}

/**
 * Start the recurring expense scheduler
 */
function startRecurringExpenseScheduler() {
  console.log('Starting Recurring Expense Scheduler...');
  
  // Schedule daily processing at 6:00 AM
  const dailyTask = cron.schedule(SCHEDULER_CONFIG.DAILY_CRON, async () => {
    try {
      await processAllOrganizationsRecurringExpenses();
    } catch (error) {
      console.error('Error in scheduled daily recurring expense processing:', error);
    }
  }, {
    scheduled: false,
    timezone: SCHEDULER_CONFIG.TIMEZONE
  });
  
  // Start the scheduled task
  dailyTask.start();
  
  console.log(`Recurring expense scheduler started. Daily processing scheduled at 6:00 AM (${SCHEDULER_CONFIG.TIMEZONE})`);
  
  return {
    dailyTask,
    stop: () => {
      dailyTask.stop();
      console.log('Recurring expense scheduler stopped.');
    },
    status: () => {
      return {
        isRunning: dailyTask.getStatus() === 'scheduled',
        nextExecution: dailyTask.nextDates(1),
        timezone: SCHEDULER_CONFIG.TIMEZONE,
        cronExpression: SCHEDULER_CONFIG.DAILY_CRON
      };
    }
  };
}

/**
 * Start a custom scheduler with specified cron expression
 */
function startCustomScheduler(cronExpression, description = 'Custom recurring expense processing') {
  console.log(`Starting custom recurring expense scheduler: ${description}`);
  console.log(`Cron expression: ${cronExpression}`);
  
  const customTask = cron.schedule(cronExpression, async () => {
    try {
      console.log(`[${new Date().toISOString()}] Running custom scheduled task: ${description}`);
      await processAllOrganizationsRecurringExpenses();
    } catch (error) {
      console.error(`Error in custom scheduled recurring expense processing (${description}):`, error);
    }
  }, {
    scheduled: false,
    timezone: SCHEDULER_CONFIG.TIMEZONE
  });
  
  customTask.start();
  
  console.log(`Custom recurring expense scheduler started: ${description}`);
  
  return {
    task: customTask,
    stop: () => {
      customTask.stop();
      console.log(`Custom recurring expense scheduler stopped: ${description}`);
    },
    status: () => {
      return {
        isRunning: customTask.getStatus() === 'scheduled',
        nextExecution: customTask.nextDates(1),
        timezone: SCHEDULER_CONFIG.TIMEZONE,
        cronExpression: cronExpression,
        description: description
      };
    }
  };
}

/**
 * Get scheduler status and configuration
 */
function getSchedulerInfo() {
  return {
    config: SCHEDULER_CONFIG,
    availableSchedules: {
      hourly: {
        cron: SCHEDULER_CONFIG.HOURLY_CRON,
        description: 'Every hour at minute 0'
      },
      daily: {
        cron: SCHEDULER_CONFIG.DAILY_CRON,
        description: 'Every day at 6:00 AM'
      },
      weekly: {
        cron: SCHEDULER_CONFIG.WEEKLY_CRON,
        description: 'Every Monday at 6:00 AM'
      },
      monthly: {
        cron: SCHEDULER_CONFIG.MONTHLY_CRON,
        description: 'First day of every month at 6:00 AM'
      }
    },
    timezone: SCHEDULER_CONFIG.TIMEZONE
  };
}

/**
 * Manual trigger for testing purposes
 */
async function manualTrigger() {
  console.log('Manual trigger for recurring expense processing...');
  return await processAllOrganizationsRecurringExpenses();
}

/**
 * Validate cron expression
 */
function validateCronExpression(cronExpression) {
  try {
    const task = cron.schedule(cronExpression, () => {}, { scheduled: false });
    task.destroy();
    return { valid: true };
  } catch (error) {
    return { 
      valid: false, 
      error: error.message 
    };
  }
}

module.exports = {
  startRecurringExpenseScheduler,
  startCustomScheduler,
  processAllOrganizationsRecurringExpenses,
  getOrganizationsWithRecurringExpenses,
  getSchedulerInfo,
  manualTrigger,
  validateCronExpression,
  SCHEDULER_CONFIG
};