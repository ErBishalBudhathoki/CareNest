const express = require('express');
const router = express.Router();
const {
  processLegacyInvoiceData,
  validateLegacyInvoiceData,
  transformLegacyToNewFormat,
  migrateLegacyInvoiceData,
  getLegacyDataStatistics,
  mapLegacyItemsToNDIS,
  checkInvoiceCompatibility
} = require('../services/backwardCompatibilityService');
const logger = require('../config/logger');

// Process legacy invoice data
router.post('/api/backward-compatibility/process', async (req, res) => {
  try {
    const {
      legacyData,
      organizationId,
      transformationRules = {},
      validateAfterProcessing = true
    } = req.body;
    
    const result = await processLegacyInvoiceData({
      legacyData,
      organizationId,
      transformationRules,
      validateAfterProcessing
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Legacy invoice data processing failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to process legacy invoice data' });
  }
});

// Validate legacy invoice data
router.post('/api/backward-compatibility/validate', async (req, res) => {
  try {
    const { legacyData, validationRules = {} } = req.body;
    
    const result = await validateLegacyInvoiceData(legacyData, validationRules);
    res.json(result);
  } catch (error) {
    logger.error('Legacy invoice data validation failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to validate legacy invoice data' });
  }
});

// Transform legacy data to new format
router.post('/api/backward-compatibility/transform', async (req, res) => {
  try {
    const {
      legacyData,
      targetFormat = 'current',
      mappingRules = {},
      preserveOriginal = true
    } = req.body;
    
    const result = await transformLegacyToNewFormat({
      legacyData,
      targetFormat,
      mappingRules,
      preserveOriginal
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Legacy data transformation failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to transform legacy data' });
  }
});

// Migrate legacy invoice data to current system
router.post('/api/backward-compatibility/migrate', async (req, res) => {
  try {
    const {
      organizationId,
      legacyDataSource,
      batchSize = 100,
      dryRun = false,
      migrationOptions = {}
    } = req.body;
    
    const result = await migrateLegacyInvoiceData({
      organizationId,
      legacyDataSource,
      batchSize,
      dryRun,
      migrationOptions
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Legacy invoice data migration failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to migrate legacy invoice data' });
  }
});

// Get legacy data statistics
router.get('/api/backward-compatibility/stats/:organizationId', async (req, res) => {
  try {
    const { organizationId } = req.params;
    const { includeDetails = false } = req.query;
    
    const stats = await getLegacyDataStatistics(organizationId, {
      includeDetails: includeDetails === 'true'
    });
    
    res.json(stats);
  } catch (error) {
    logger.error('Legacy data statistics fetch failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to fetch legacy data statistics' });
  }
});

// Map legacy items to NDIS format
router.post('/api/backward-compatibility/map-to-ndis', async (req, res) => {
  try {
    const {
      legacyItems,
      mappingStrategy = 'automatic',
      fallbackBehavior = 'prompt'
    } = req.body;
    
    const result = await mapLegacyItemsToNDIS({
      legacyItems,
      mappingStrategy,
      fallbackBehavior
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Legacy items to NDIS mapping failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to map legacy items to NDIS' });
  }
});

// Check invoice compatibility with current system
router.post('/api/backward-compatibility/check-compatibility', async (req, res) => {
  try {
    const {
      invoiceData,
      checkLevel = 'basic', // basic, detailed, comprehensive
      includeRecommendations = true
    } = req.body;
    
    const result = await checkInvoiceCompatibility({
      invoiceData,
      checkLevel,
      includeRecommendations
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Invoice compatibility check failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to check invoice compatibility' });
  }
});

module.exports = router;