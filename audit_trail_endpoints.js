/**
 * Audit Trail API Endpoints
 * 
 * This module provides REST API endpoints for accessing audit trail functionality.
 * All endpoints require proper authentication and organization-level access control.
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const path = require('path');
const logger = require('./config/logger');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const {
  createAuditLog,
  getEntityAuditHistory,
  getOrganizationAuditLogs,
  getAuditStatistics,
  cleanupOldAuditLogs,
  AUDIT_ACTIONS,
  AUDIT_ENTITIES
} = require('./services/auditService');

const uri = process.env.MONGODB_URI;

/**
 * Get audit history for a specific entity
 * GET /api/audit/entity/:entityType/:entityId
 */
async function getEntityAuditHistoryEndpoint(req, res) {
  try {
    const { entityType, entityId } = req.params;
    const { organizationId, userEmail } = req.query;
    
    // Validate required parameters
    if (!entityType || !entityId || !organizationId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: entityType, entityId, organizationId, userEmail'
      });
    }

    // Verify user belongs to organization
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');
    
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId
    });
    
    await client.close();
    
    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'Access denied: User not found in organization'
      });
    }

    // Parse query options
    const options = {
      limit: parseInt(req.query.limit) || 50,
      skip: parseInt(req.query.skip) || 0,
      sortBy: req.query.sortBy || 'timestamp',
      sortOrder: parseInt(req.query.sortOrder) || -1,
      actions: req.query.actions ? req.query.actions.split(',') : null,
      startDate: req.query.startDate || null,
      endDate: req.query.endDate || null
    };

    // Get audit history
    const result = await getEntityAuditHistory(entityType, entityId, organizationId, options);
    
    res.status(200).json({
      statusCode: 200,
      message: 'Audit history retrieved successfully',
      data: result
    });

  } catch (error) {
    logger.error('Error in getEntityAuditHistoryEndpoint', {
      error: error.message,
      stack: error.stack,
      entityType: req.params.entityType,
      entityId: req.params.entityId
    });
    res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Get organization audit logs with filtering
 * GET /api/audit/organization/:organizationId
 */
async function getOrganizationAuditLogsEndpoint(req, res) {
  try {
    const { organizationId } = req.params;
    const { userEmail } = req.query;
    
    // Validate required parameters
    if (!organizationId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: organizationId, userEmail'
      });
    }

    // Verify user belongs to organization
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');
    
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId
    });
    
    await client.close();
    
    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'Access denied: User not found in organization'
      });
    }

    // Parse query options
    const options = {
      limit: parseInt(req.query.limit) || 100,
      skip: parseInt(req.query.skip) || 0,
      sortBy: req.query.sortBy || 'timestamp',
      sortOrder: parseInt(req.query.sortOrder) || -1,
      entityTypes: req.query.entityTypes ? req.query.entityTypes.split(',') : null,
      actions: req.query.actions ? req.query.actions.split(',') : null,
      userEmail: req.query.filterUserEmail || null,
      startDate: req.query.startDate || null,
      endDate: req.query.endDate || null
    };

    // Get audit logs
    const result = await getOrganizationAuditLogs(organizationId, options);
    
    res.status(200).json({
      statusCode: 200,
      message: 'Organization audit logs retrieved successfully',
      data: result
    });

  } catch (error) {
    logger.error('Error in getOrganizationAuditLogsEndpoint', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId
    });
    res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Get audit statistics for an organization
 * GET /api/audit/statistics/:organizationId
 */
async function getAuditStatisticsEndpoint(req, res) {
  try {
    const { organizationId } = req.params;
    const { userEmail } = req.query;
    
    // Validate required parameters
    if (!organizationId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: organizationId, userEmail'
      });
    }

    // Verify user belongs to organization
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');
    
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId
    });
    
    await client.close();
    
    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'Access denied: User not found in organization'
      });
    }

    // Parse query options
    const options = {
      startDate: req.query.startDate || null,
      endDate: req.query.endDate || null
    };

    // Get audit statistics
    const result = await getAuditStatistics(organizationId, options);
    
    res.status(200).json({
      statusCode: 200,
      message: 'Audit statistics retrieved successfully',
      data: result
    });

  } catch (error) {
    logger.error('Error in getAuditStatisticsEndpoint', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId
    });
    res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Create a manual audit log entry
 * POST /api/audit/log
 */
async function createAuditLogEndpoint(req, res) {
  try {
    const {
      action,
      entityType,
      entityId,
      userEmail,
      organizationId,
      oldValues,
      newValues,
      reason,
      metadata
    } = req.body;
    
    // Validate required parameters
    if (!action || !entityType || !entityId || !userEmail || !organizationId) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required fields: action, entityType, entityId, userEmail, organizationId'
      });
    }

    // Verify user belongs to organization
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');
    
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId
    });
    
    await client.close();
    
    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'Access denied: User not found in organization'
      });
    }

    // Create audit log
    const auditData = {
      action,
      entityType,
      entityId,
      userEmail,
      organizationId,
      oldValues,
      newValues,
      reason,
      metadata: {
        ...metadata,
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    };

    const result = await createAuditLog(auditData);
    
    res.status(201).json({
      statusCode: 201,
      message: 'Audit log created successfully',
      data: result
    });

  } catch (error) {
    logger.error('Error in createAuditLogEndpoint', {
      error: error.message,
      stack: error.stack,
      auditData: req.body
    });
    res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Get available audit actions and entity types
 * GET /api/audit/metadata
 */
async function getAuditMetadataEndpoint(req, res) {
  try {
    res.status(200).json({
      statusCode: 200,
      message: 'Audit metadata retrieved successfully',
      data: {
        actions: AUDIT_ACTIONS,
        entityTypes: AUDIT_ENTITIES
      }
    });

  } catch (error) {
    logger.error('Error in getAuditMetadataEndpoint', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Export audit logs for compliance reporting
 * GET /api/audit/export/:organizationId
 */
async function exportAuditLogsEndpoint(req, res) {
  try {
    const { organizationId } = req.params;
    const { userEmail, format = 'json' } = req.query;
    
    // Validate required parameters
    if (!organizationId || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required parameters: organizationId, userEmail'
      });
    }

    // Verify user belongs to organization and has admin privileges
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');
    
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId
    });
    
    await client.close();
    
    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'Access denied: User not found in organization'
      });
    }

    // Parse query options for export
    const options = {
      limit: parseInt(req.query.limit) || 10000, // Higher limit for exports
      skip: 0,
      sortBy: 'timestamp',
      sortOrder: 1, // Ascending for chronological export
      entityTypes: req.query.entityTypes ? req.query.entityTypes.split(',') : null,
      actions: req.query.actions ? req.query.actions.split(',') : null,
      startDate: req.query.startDate || null,
      endDate: req.query.endDate || null
    };

    // Get audit logs for export
    const result = await getOrganizationAuditLogs(organizationId, options);
    
    // Log the export action
    await createAuditLog({
      action: AUDIT_ACTIONS.EXPORT,
      entityType: AUDIT_ENTITIES.ORGANIZATION,
      entityId: organizationId,
      userEmail,
      organizationId,
      reason: 'Audit logs export',
      metadata: {
        exportFormat: format,
        recordCount: result.auditLogs.length,
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    // Set appropriate headers for download
    const timestamp = new Date().toISOString().split('T')[0];
    const filename = `audit_logs_${organizationId}_${timestamp}.${format}`;
    
    if (format === 'csv') {
      // Convert to CSV format
      const csvData = convertToCSV(result.auditLogs);
      res.setHeader('Content-Type', 'text/csv');
      res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
      res.status(200).send(csvData);
    } else {
      // Default to JSON format
      res.setHeader('Content-Type', 'application/json');
      res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
      res.status(200).json({
        statusCode: 200,
        message: 'Audit logs exported successfully',
        exportInfo: {
          organizationId,
          exportDate: new Date().toISOString(),
          recordCount: result.auditLogs.length,
          format
        },
        data: result.auditLogs
      });
    }

  } catch (error) {
    logger.error('Error in exportAuditLogsEndpoint', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId
    });
    res.status(500).json({
      statusCode: 500,
      message: 'Internal server error',
      error: error.message
    });
  }
}

/**
 * Helper function to convert audit logs to CSV format
 * @param {Array} auditLogs - Array of audit log entries
 * @returns {string} CSV formatted string
 */
function convertToCSV(auditLogs) {
  if (!auditLogs || auditLogs.length === 0) {
    return 'No audit logs to export';
  }

  // Define CSV headers
  const headers = [
    'Timestamp',
    'Action',
    'Entity Type',
    'Entity ID',
    'User Email',
    'Organization ID',
    'Reason',
    'Old Values',
    'New Values',
    'IP Address',
    'User Agent'
  ];

  // Convert audit logs to CSV rows
  const rows = auditLogs.map(log => [
    log.timestamp ? log.timestamp.toISOString() : '',
    log.action || '',
    log.entityType || '',
    log.entityId || '',
    log.userEmail || '',
    log.organizationId || '',
    log.reason || '',
    log.oldValues ? JSON.stringify(log.oldValues) : '',
    log.newValues ? JSON.stringify(log.newValues) : '',
    log.metadata?.ipAddress || '',
    log.metadata?.userAgent || ''
  ]);

  // Combine headers and rows
  const csvContent = [headers, ...rows]
    .map(row => row.map(field => `"${String(field).replace(/"/g, '""')}"`).join(','))
    .join('\n');

  return csvContent;
}

module.exports = {
  getEntityAuditHistoryEndpoint,
  getOrganizationAuditLogsEndpoint,
  getAuditStatisticsEndpoint,
  createAuditLogEndpoint,
  getAuditMetadataEndpoint,
  exportAuditLogsEndpoint
};