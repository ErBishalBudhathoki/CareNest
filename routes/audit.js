const express = require('express');
const router = express.Router();
const {
  getEntityAuditHistory,
  getOrganizationAuditLogs,
  getAuditStatistics,
  createManualAuditLog,
  getAuditMetadata,
  exportAuditLogs
} = require('../services/auditService');
const logger = require('../config/logger');

// Get audit history for a specific entity
router.get('/api/audit/entity/:entityType/:entityId', async (req, res) => {
  try {
    const { entityType, entityId } = req.params;
    const { page = 1, limit = 50 } = req.query;
    
    const result = await getEntityAuditHistory(entityType, entityId, {
      page: parseInt(page),
      limit: parseInt(limit)
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Audit logs fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.query.organizationId,
      entityType: req.query.entityType,
      entityId: req.query.entityId
    });
    res.status(500).json({ error: 'Failed to fetch entity audit history' });
  }
});

// Get audit logs for an organization
router.get('/api/audit/organization/:organizationId', async (req, res) => {
  try {
    const { organizationId } = req.params;
    const {
      page = 1,
      limit = 50,
      action,
      entityType,
      userId,
      startDate,
      endDate
    } = req.query;
    
    const result = await getOrganizationAuditLogs(organizationId, {
      page: parseInt(page),
      limit: parseInt(limit),
      action,
      entityType,
      userId,
      startDate,
      endDate
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Audit logs fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.query.organizationId,
      entityType: req.query.entityType,
      entityId: req.query.entityId
    });
    res.status(500).json({ error: 'Failed to fetch organization audit logs' });
  }
});

// Get audit statistics
router.get('/api/audit/stats/:organizationId', async (req, res) => {
  try {
    const { organizationId } = req.params;
    const { startDate, endDate } = req.query;
    
    const stats = await getAuditStatistics(organizationId, {
      startDate,
      endDate
    });
    
    res.json(stats);
  } catch (error) {
    logger.error('Audit logs fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.query.organizationId,
      entityType: req.query.entityType,
      entityId: req.query.entityId
    });
    res.status(500).json({ error: 'Failed to fetch audit statistics' });
  }
});

// Create a manual audit log entry
router.post('/api/audit/manual', async (req, res) => {
  try {
    const {
      organizationId,
      userId,
      action,
      entityType,
      entityId,
      description,
      metadata
    } = req.body;
    
    const result = await createManualAuditLog({
      organizationId,
      userId,
      action,
      entityType,
      entityId,
      description,
      metadata
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Audit logs fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.query.organizationId,
      entityType: req.query.entityType,
      entityId: req.query.entityId
    });
    res.status(500).json({ error: 'Failed to create manual audit log' });
  }
});

// Get audit metadata (actions, entity types, etc.)
router.get('/api/audit/metadata', async (req, res) => {
  try {
    const metadata = await getAuditMetadata();
    res.json(metadata);
  } catch (error) {
    logger.error('Audit logs fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.query.organizationId,
      entityType: req.query.entityType,
      entityId: req.query.entityId
    });
    res.status(500).json({ error: 'Failed to fetch audit metadata' });
  }
});

// Export audit logs
router.post('/api/audit/export', async (req, res) => {
  try {
    const {
      organizationId,
      format = 'csv',
      filters = {},
      startDate,
      endDate
    } = req.body;
    
    const result = await exportAuditLogs(organizationId, {
      format,
      filters,
      startDate,
      endDate
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Audit logs fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.query.organizationId,
      entityType: req.query.entityType,
      entityId: req.query.entityId
    });
    res.status(500).json({ error: 'Failed to export audit logs' });
  }
});

module.exports = router;