const express = require('express');
const router = express.Router();
const logger = require('../config/logger');
const {
  validatePrice,
  validatePriceBatch,
  getPriceCaps,
  isQuoteRequired,
  validateInvoice,
  getPriceValidationStats
} = require('../services/priceValidationService');

// Validate a single price
router.post('/api/price-validation/validate', async (req, res) => {
  try {
    const {
      supportItemNumber,
      price,
      organizationId,
      clientId,
      serviceDate,
      location,
      duration
    } = req.body;
    
    const result = await validatePrice({
      supportItemNumber,
      price,
      organizationId,
      clientId,
      serviceDate,
      location,
      duration
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Price validation failed', {
      error: error.message,
      stack: error.stack,
      supportItemNumber,
      price,
      organizationId,
      clientId,
      serviceDate,
      location,
      duration
    });
    res.status(500).json({ error: 'Failed to validate price' });
  }
});

// Validate multiple prices in batch
router.post('/api/price-validation/validate-batch', async (req, res) => {
  try {
    const { items } = req.body;
    const result = await validatePriceBatch(items);
    res.json(result);
  } catch (error) {
    logger.error('Batch price validation failed', {
      error: error.message,
      stack: error.stack,
      itemCount: items?.length
    });
    res.status(500).json({ error: 'Failed to validate prices in batch' });
  }
});

// Get price caps for a support item
router.get('/api/price-validation/caps/:supportItemNumber', async (req, res) => {
  try {
    const { supportItemNumber } = req.params;
    const { location, serviceDate } = req.query;
    
    const caps = await getPriceCaps(supportItemNumber, {
      location,
      serviceDate
    });
    
    res.json(caps);
  } catch (error) {
    logger.error('Price caps fetch failed', {
      error: error.message,
      stack: error.stack,
      supportItemNumber,
      location,
      serviceDate
    });
    res.status(500).json({ error: 'Failed to fetch price caps' });
  }
});

// Check if quote is required for a support item
router.get('/api/price-validation/quote-required/:supportItemNumber', async (req, res) => {
  try {
    const { supportItemNumber } = req.params;
    const { price, location } = req.query;
    
    const quoteRequired = await isQuoteRequired(supportItemNumber, {
      price: parseFloat(price),
      location
    });
    
    res.json({ quoteRequired });
  } catch (error) {
    logger.error('Quote requirement check failed', {
      error: error.message,
      stack: error.stack,
      supportItemNumber,
      price,
      location
    });
    res.status(500).json({ error: 'Failed to check quote requirement' });
  }
});

// Validate an entire invoice
router.post('/api/price-validation/validate-invoice', async (req, res) => {
  try {
    const { invoiceData } = req.body;
    const result = await validateInvoice(invoiceData);
    res.json(result);
  } catch (error) {
    logger.error('Invoice validation failed', {
      error: error.message,
      stack: error.stack,
      invoiceData: invoiceData ? 'provided' : 'missing'
    });
    res.status(500).json({ error: 'Failed to validate invoice' });
  }
});

// Get price validation statistics
router.get('/api/price-validation/stats', async (req, res) => {
  try {
    const { organizationId, startDate, endDate } = req.query;
    
    const stats = await getPriceValidationStats({
      organizationId,
      startDate,
      endDate
    });
    
    res.json(stats);
  } catch (error) {
    logger.error('Price validation stats fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      startDate,
      endDate
    });
    res.status(500).json({ error: 'Failed to fetch price validation stats' });
  }
});

module.exports = router;