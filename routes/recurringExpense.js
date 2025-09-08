const express = require('express');
const router = express.Router();
const {
  processDueRecurringExpenses,
  createRecurringExpenseTemplate,
  getRecurringExpenseTemplates,
  updateRecurringExpenseTemplate,
  deactivateRecurringExpenseTemplate,
  getRecurringExpenseStats
} = require('../services/recurringExpenseService');
const logger = require('../config/logger');

// Process due recurring expenses
router.post('/api/recurring-expenses/process', async (req, res) => {
  try {
    const { organizationId, processDate } = req.body;
    
    const result = await processDueRecurringExpenses({
      organizationId,
      processDate: processDate || new Date()
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Recurring expenses processing failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to process due recurring expenses' });
  }
});

// Create a new recurring expense template
router.post('/api/recurring-expenses/templates', async (req, res) => {
  try {
    const templateData = req.body;
    const result = await createRecurringExpenseTemplate(templateData);
    res.json(result);
  } catch (error) {
    logger.error('Recurring expense template creation failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.body.organizationId
    });
    res.status(500).json({ error: 'Failed to create recurring expense template' });
  }
});

// Get recurring expense templates for an organization
router.get('/api/recurring-expenses/templates/:organizationId', async (req, res) => {
  try {
    const { organizationId } = req.params;
    const { active = true, page = 1, limit = 50 } = req.query;
    
    const result = await getRecurringExpenseTemplates(organizationId, {
      active: active === 'true',
      page: parseInt(page),
      limit: parseInt(limit)
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Recurring expense templates fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId
    });
    res.status(500).json({ error: 'Failed to fetch recurring expense templates' });
  }
});

// Update a recurring expense template
router.put('/api/recurring-expenses/templates/:templateId', async (req, res) => {
  try {
    const { templateId } = req.params;
    const updateData = req.body;
    
    const result = await updateRecurringExpenseTemplate(templateId, updateData);
    res.json(result);
  } catch (error) {
    logger.error('Recurring expense template update failed', {
      error: error.message,
      stack: error.stack,
      templateId: req.params.templateId
    });
    res.status(500).json({ error: 'Failed to update recurring expense template' });
  }
});

// Deactivate a recurring expense template
router.delete('/api/recurring-expenses/templates/:templateId', async (req, res) => {
  try {
    const { templateId } = req.params;
    const { deactivatedBy } = req.body;
    
    const result = await deactivateRecurringExpenseTemplate(templateId, deactivatedBy);
    res.json(result);
  } catch (error) {
    logger.error('Recurring expense template deactivation failed', {
      error: error.message,
      stack: error.stack,
      templateId: req.params.templateId
    });
    res.status(500).json({ error: 'Failed to deactivate recurring expense template' });
  }
});

// Get recurring expense statistics
router.get('/api/recurring-expenses/stats/:organizationId', async (req, res) => {
  try {
    const { organizationId } = req.params;
    const { startDate, endDate } = req.query;
    
    const stats = await getRecurringExpenseStats(organizationId, {
      startDate,
      endDate
    });
    
    res.json(stats);
  } catch (error) {
    logger.error('Recurring expense stats fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId
    });
    res.status(500).json({ error: 'Failed to fetch recurring expense stats' });
  }
});

module.exports = router;