/**
 * Audit Trail Service
 * 
 * This service provides comprehensive audit logging functionality for tracking
 * changes to critical data including pricing, expenses, invoices, and user actions.
 * 
 * Features:
 * - Automatic change tracking with before/after values
 * - User action logging with timestamps
 * - Configurable audit levels (CREATE, UPDATE, DELETE, APPROVE, etc.)
 * - Query capabilities for audit history
 * - Data retention policies
 * - Export functionality for compliance reporting
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const path = require('path');
const logger = require('../config/logger');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const uri = process.env.MONGODB_URI;

/**
 * Audit action types for categorizing different operations
 */
const AUDIT_ACTIONS = {
  CREATE: 'CREATE',
  UPDATE: 'UPDATE',
  DELETE: 'DELETE',
  APPROVE: 'APPROVE',
  REJECT: 'REJECT',
  LOGIN: 'LOGIN',
  LOGOUT: 'LOGOUT',
  EXPORT: 'EXPORT',
  IMPORT: 'IMPORT',
  VIEW: 'VIEW'
};

/**
 * Entity types that can be audited
 */
const AUDIT_ENTITIES = {
  PRICING: 'pricing',
  EXPENSE: 'expense',
  INVOICE: 'invoice',
  USER: 'user',
  ORGANIZATION: 'organization',
  CLIENT: 'client',
  ASSIGNMENT: 'assignment'
};

/**
 * Create an audit log entry
 * @param {Object} auditData - The audit data to log
 * @param {string} auditData.action - The action performed (from AUDIT_ACTIONS)
 * @param {string} auditData.entityType - The type of entity (from AUDIT_ENTITIES)
 * @param {string} auditData.entityId - The ID of the entity being audited
 * @param {string} auditData.userEmail - Email of the user performing the action
 * @param {string} auditData.organizationId - Organization ID
 * @param {Object} auditData.oldValues - Previous values (for updates)
 * @param {Object} auditData.newValues - New values (for creates/updates)
 * @param {string} auditData.reason - Reason for the change (optional)
 * @param {Object} auditData.metadata - Additional metadata (optional)
 * @returns {Promise<Object>} The created audit log entry
 */
async function createAuditLog(auditData) {
  let client;
  
  try {
    const {
      action,
      entityType,
      entityId,
      userEmail,
      organizationId,
      oldValues = null,
      newValues = null,
      reason = null,
      metadata = {}
    } = auditData;

    // Validate required fields
    if (!action || !entityType || !entityId || !userEmail || !organizationId) {
      throw new Error('Missing required audit fields: action, entityType, entityId, userEmail, organizationId');
    }

    // Validate action type
    if (!Object.values(AUDIT_ACTIONS).includes(action)) {
      throw new Error(`Invalid audit action: ${action}`);
    }

    // Validate entity type
    if (!Object.values(AUDIT_ENTITIES).includes(entityType)) {
      throw new Error(`Invalid entity type: ${entityType}`);
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Create audit log entry
    const auditEntry = {
      action,
      entityType,
      entityId,
      userEmail,
      organizationId,
      timestamp: new Date(),
      oldValues: oldValues ? sanitizeData(oldValues) : null,
      newValues: newValues ? sanitizeData(newValues) : null,
      reason,
      metadata: {
        ...metadata,
        ipAddress: metadata.ipAddress || null,
        userAgent: metadata.userAgent || null,
        sessionId: metadata.sessionId || null
      },
      createdAt: new Date()
    };

    // Insert audit log
    const result = await db.collection('auditLogs').insertOne(auditEntry);
    
    logger.info('Audit log created', {
      action,
      entityType,
      entityId,
      userEmail,
      organizationId,
      auditId: result.insertedId
    });
    
    return {
      success: true,
      auditId: result.insertedId,
      auditEntry
    };

  } catch (error) {
    logger.error('Audit log creation failed', {
      error: error.message,
      stack: error.stack,
      action,
      entityType,
      entityId,
      userEmail,
      organizationId
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get audit history for a specific entity
 * @param {string} entityType - The type of entity
 * @param {string} entityId - The ID of the entity
 * @param {string} organizationId - Organization ID for security
 * @param {Object} options - Query options
 * @returns {Promise<Array>} Array of audit log entries
 */
async function getEntityAuditHistory(entityType, entityId, organizationId, options = {}) {
  let client;
  
  try {
    const {
      limit = 50,
      skip = 0,
      sortBy = 'timestamp',
      sortOrder = -1,
      actions = null,
      startDate = null,
      endDate = null
    } = options;

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Build query
    const query = {
      entityType,
      entityId,
      organizationId
    };

    // Add action filter if specified
    if (actions && actions.length > 0) {
      query.action = { $in: actions };
    }

    // Add date range filter if specified
    if (startDate || endDate) {
      query.timestamp = {};
      if (startDate) query.timestamp.$gte = new Date(startDate);
      if (endDate) query.timestamp.$lte = new Date(endDate);
    }

    // Execute query
    const auditLogs = await db.collection('auditLogs')
      .find(query)
      .sort({ [sortBy]: sortOrder })
      .skip(skip)
      .limit(limit)
      .toArray();

    // Get total count for pagination
    const totalCount = await db.collection('auditLogs').countDocuments(query);

    return {
      success: true,
      auditLogs,
      pagination: {
        total: totalCount,
        limit,
        skip,
        hasMore: (skip + limit) < totalCount
      }
    };

  } catch (error) {
    logger.error('Audit history fetch failed', {
      error: error.message,
      stack: error.stack,
      entityType,
      entityId,
      organizationId
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get audit logs for an organization with filtering options
 * @param {string} organizationId - Organization ID
 * @param {Object} options - Query options
 * @returns {Promise<Array>} Array of audit log entries
 */
async function getOrganizationAuditLogs(organizationId, options = {}) {
  let client;
  
  try {
    const {
      limit = 100,
      skip = 0,
      sortBy = 'timestamp',
      sortOrder = -1,
      entityTypes = null,
      actions = null,
      userEmail = null,
      startDate = null,
      endDate = null
    } = options;

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Build query
    const query = { organizationId };

    // Add filters
    if (entityTypes && entityTypes.length > 0) {
      query.entityType = { $in: entityTypes };
    }

    if (actions && actions.length > 0) {
      query.action = { $in: actions };
    }

    if (userEmail) {
      query.userEmail = userEmail;
    }

    if (startDate || endDate) {
      query.timestamp = {};
      if (startDate) query.timestamp.$gte = new Date(startDate);
      if (endDate) query.timestamp.$lte = new Date(endDate);
    }

    // Execute query
    const auditLogs = await db.collection('auditLogs')
      .find(query)
      .sort({ [sortBy]: sortOrder })
      .skip(skip)
      .limit(limit)
      .toArray();

    // Get total count for pagination
    const totalCount = await db.collection('auditLogs').countDocuments(query);

    return {
      success: true,
      auditLogs,
      pagination: {
        total: totalCount,
        limit,
        skip,
        hasMore: (skip + limit) < totalCount
      }
    };

  } catch (error) {
    logger.error('Organization audit logs fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get audit statistics for an organization
 * @param {string} organizationId - Organization ID
 * @param {Object} options - Query options
 * @returns {Promise<Object>} Audit statistics
 */
async function getAuditStatistics(organizationId, options = {}) {
  let client;
  
  try {
    const {
      startDate = null,
      endDate = null
    } = options;

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Build base query
    const baseQuery = { organizationId };
    
    if (startDate || endDate) {
      baseQuery.timestamp = {};
      if (startDate) baseQuery.timestamp.$gte = new Date(startDate);
      if (endDate) baseQuery.timestamp.$lte = new Date(endDate);
    }

    // Get statistics using aggregation
    const stats = await db.collection('auditLogs').aggregate([
      { $match: baseQuery },
      {
        $group: {
          _id: null,
          totalActions: { $sum: 1 },
          actionsByType: {
            $push: '$action'
          },
          entitiesByType: {
            $push: '$entityType'
          },
          usersByEmail: {
            $addToSet: '$userEmail'
          }
        }
      }
    ]).toArray();

    // Get action counts
    const actionCounts = await db.collection('auditLogs').aggregate([
      { $match: baseQuery },
      {
        $group: {
          _id: '$action',
          count: { $sum: 1 }
        }
      }
    ]).toArray();

    // Get entity type counts
    const entityCounts = await db.collection('auditLogs').aggregate([
      { $match: baseQuery },
      {
        $group: {
          _id: '$entityType',
          count: { $sum: 1 }
        }
      }
    ]).toArray();

    // Get user activity counts
    const userActivity = await db.collection('auditLogs').aggregate([
      { $match: baseQuery },
      {
        $group: {
          _id: '$userEmail',
          count: { $sum: 1 },
          lastActivity: { $max: '$timestamp' }
        }
      },
      { $sort: { count: -1 } },
      { $limit: 10 }
    ]).toArray();

    const result = stats[0] || { totalActions: 0, usersByEmail: [] };

    return {
      success: true,
      statistics: {
        totalActions: result.totalActions,
        uniqueUsers: result.usersByEmail.length,
        actionCounts: actionCounts.reduce((acc, item) => {
          acc[item._id] = item.count;
          return acc;
        }, {}),
        entityCounts: entityCounts.reduce((acc, item) => {
          acc[item._id] = item.count;
          return acc;
        }, {}),
        topUsers: userActivity
      }
    };

  } catch (error) {
    logger.error('Audit statistics fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Clean up old audit logs based on retention policy
 * @param {number} retentionDays - Number of days to retain logs
 * @returns {Promise<Object>} Cleanup result
 */
async function cleanupOldAuditLogs(retentionDays = 365) {
  let client;
  
  try {
    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Calculate cutoff date
    const cutoffDate = new Date();
    cutoffDate.setDate(cutoffDate.getDate() - retentionDays);

    // Delete old audit logs
    const result = await db.collection('auditLogs').deleteMany({
      timestamp: { $lt: cutoffDate }
    });

    logger.info('Audit logs cleanup completed', {
      deletedCount: result.deletedCount,
      retentionDays,
      cutoffDate
    });

    return {
      success: true,
      deletedCount: result.deletedCount,
      cutoffDate
    };

  } catch (error) {
    logger.error('Audit logs cleanup failed', {
      error: error.message,
      stack: error.stack,
      retentionDays
    });
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Sanitize data to remove sensitive information before logging
 * @param {Object} data - Data to sanitize
 * @returns {Object} Sanitized data
 */
function sanitizeData(data) {
  if (!data || typeof data !== 'object') {
    return data;
  }

  const sensitiveFields = ['password', 'token', 'secret', 'key', 'fcmToken'];
  const sanitized = { ...data };

  // Remove sensitive fields
  sensitiveFields.forEach(field => {
    if (sanitized[field]) {
      sanitized[field] = '[REDACTED]';
    }
  });

  // Recursively sanitize nested objects
  Object.keys(sanitized).forEach(key => {
    if (typeof sanitized[key] === 'object' && sanitized[key] !== null) {
      sanitized[key] = sanitizeData(sanitized[key]);
    }
  });

  return sanitized;
}

/**
 * Helper function to compare objects and get differences
 * @param {Object} oldObj - Original object
 * @param {Object} newObj - Updated object
 * @returns {Object} Object containing only the changed fields
 */
function getObjectDifferences(oldObj, newObj) {
  const differences = {};
  
  // Check for changed or new fields
  Object.keys(newObj).forEach(key => {
    if (JSON.stringify(oldObj[key]) !== JSON.stringify(newObj[key])) {
      differences[key] = {
        old: oldObj[key],
        new: newObj[key]
      };
    }
  });

  // Check for deleted fields
  Object.keys(oldObj).forEach(key => {
    if (!(key in newObj)) {
      differences[key] = {
        old: oldObj[key],
        new: null
      };
    }
  });

  return differences;
}

module.exports = {
  createAuditLog,
  getEntityAuditHistory,
  getOrganizationAuditLogs,
  getAuditStatistics,
  cleanupOldAuditLogs,
  sanitizeData,
  getObjectDifferences,
  AUDIT_ACTIONS,
  AUDIT_ENTITIES
};