const express = require('express');
const router = express.Router();
const { ObjectId } = require('mongodb');
const { getDb } = require('../config/database');
const logger = require('../config/logger');
const {
  generateInvoiceLineItems,
  generateBulkInvoices,
  validateExistingInvoiceLineItems,
  validatePriceRealTime,
  getInvoiceValidationReport,
  generateInvoicePreview
} = require('../services/invoiceGenerationService');

// Generate invoice line items
router.post('/api/invoice-generation/line-items', async (req, res) => {
  try {
    const {
      organizationId,
      clientId,
      startDate,
      endDate,
      includeExpenses = false,
      validatePrices = true
    } = req.body;
    
    const result = await generateInvoiceLineItems({
      organizationId,
      clientId,
      startDate,
      endDate,
      includeExpenses,
      validatePrices
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Invoice line items generation failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      clientId,
      startDate,
      endDate,
      includeExpenses,
      validatePrices
    });
    res.status(500).json({ error: 'Failed to generate invoice line items' });
  }
});

// Generate bulk invoices
router.post('/api/invoice-generation/bulk', async (req, res) => {
  try {
    const {
      organizationId,
      clientIds,
      startDate,
      endDate,
      options = {}
    } = req.body;
    
    const result = await generateBulkInvoices({
      organizationId,
      clientIds,
      startDate,
      endDate,
      options
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Bulk invoices generation failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      clientIds,
      startDate,
      endDate,
      options
    });
    res.status(500).json({ error: 'Failed to generate bulk invoices' });
  }
});

// Validate existing invoice line items
router.post('/api/invoice-generation/validate', async (req, res) => {
  try {
    const { invoiceLineItems } = req.body;
    const result = await validateExistingInvoiceLineItems(invoiceLineItems);
    res.json(result);
  } catch (error) {
    logger.error('Invoice line items validation failed', {
      error: error.message,
      stack: error.stack,
      lineItemsCount: invoiceLineItems?.length
    });
    res.status(500).json({ error: 'Failed to validate invoice line items' });
  }
});

// Real-time price validation
router.post('/api/invoice-generation/validate-price', async (req, res) => {
  try {
    const {
      supportItemNumber,
      price,
      organizationId,
      clientId,
      serviceDate
    } = req.body;
    
    const result = await validatePriceRealTime({
      supportItemNumber,
      price,
      organizationId,
      clientId,
      serviceDate
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Real-time price validation failed', {
      error: error.message,
      stack: error.stack,
      supportItemNumber,
      price,
      organizationId,
      clientId,
      serviceDate
    });
    res.status(500).json({ error: 'Failed to validate price in real-time' });
  }
});

// Get invoice validation report
router.get('/api/invoice-generation/validation-report/:organizationId', async (req, res) => {
  try {
    const { organizationId } = req.params;
    const { startDate, endDate } = req.query;
    
    const report = await getInvoiceValidationReport(organizationId, {
      startDate,
      endDate
    });
    
    res.json(report);
  } catch (error) {
    logger.error('Invoice validation report fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      startDate,
      endDate
    });
    res.status(500).json({ error: 'Failed to fetch invoice validation report' });
  }
});

// Generate invoice preview
router.post('/api/invoice-generation/preview', async (req, res) => {
  try {
    const {
      organizationId,
      clientId,
      startDate,
      endDate,
      includeExpenses = false
    } = req.body;
    
    const preview = await generateInvoicePreview({
      organizationId,
      clientId,
      startDate,
      endDate,
      includeExpenses
    });
    
    res.json(preview);
  } catch (error) {
    logger.error('Invoice preview generation failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      clientId,
      startDate,
      endDate,
      includeExpenses
    });
    res.status(500).json({ error: 'Failed to generate invoice preview' });
  }
});

// Get assigned client data (direct MongoDB query endpoint)
router.get('/assigned-client-data', async (req, res) => {
  try {
    const db = getDb();
    const { organizationId, startDate, endDate } = req.query;
    
    if (!organizationId) {
      return res.status(400).json({ error: 'organizationId is required' });
    }
    
    // Build match criteria
    const matchCriteria = {
      organizationId: new ObjectId(organizationId),
      isActive: true
    };
    
    // Add date filtering if provided
    if (startDate || endDate) {
      matchCriteria.createdAt = {};
      if (startDate) {
        matchCriteria.createdAt.$gte = new Date(startDate);
      }
      if (endDate) {
        matchCriteria.createdAt.$lte = new Date(endDate);
      }
    }
    
    // Aggregate client assignments with client and user details
    const assignments = await db.collection('clientAssignments').aggregate([
      { $match: matchCriteria },
      {
        $lookup: {
          from: 'clients',
          localField: 'clientEmail',
          foreignField: 'email',
          as: 'clientDetails'
        }
      },
      {
        $lookup: {
          from: 'login',
          localField: 'userEmail',
          foreignField: 'email',
          as: 'userDetails'
        }
      },
      {
        $unwind: {
          path: '$clientDetails',
          preserveNullAndEmptyArrays: true
        }
      },
      {
        $unwind: {
          path: '$userDetails',
          preserveNullAndEmptyArrays: true
        }
      },
      {
        $project: {
          _id: 1,
          clientEmail: 1,
          userEmail: 1,
          organizationId: 1,
          isActive: 1,
          createdAt: 1,
          updatedAt: 1,
          schedule: 1,
          'clientDetails.firstName': 1,
          'clientDetails.lastName': 1,
          'clientDetails.ndisNumber': 1,
          'clientDetails.supportCategory': 1,
          'userDetails.firstName': 1,
          'userDetails.lastName': 1,
          'userDetails.role': 1
        }
      },
      { $sort: { createdAt: -1 } }
    ]).toArray();
    
    res.json({
      success: true,
      data: assignments,
      total: assignments.length
    });
  } catch (error) {
    logger.error('Assigned client data fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      startDate,
      endDate
    });
    res.status(500).json({ error: 'Failed to fetch assigned client data' });
  }
});

module.exports = router;