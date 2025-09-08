const express = require('express');
const router = express.Router();
const logger = require('../config/logger');

// Import pricing controller
const pricingController = require('../controllers/pricingController');

// ===== CUSTOM PRICING API ENDPOINTS =====

/**
 * Create a new custom pricing record
 * POST /api/pricing/create
 */
router.post('/api/pricing/create', pricingController.createCustomPricing);

/**
 * Get pricing records for an organization
 * GET /api/pricing/organization/:organizationId
 */
router.get('/api/pricing/organization/:organizationId', pricingController.getOrganizationPricing);

/**
 * Get specific pricing record by ID
 * GET /api/pricing/:pricingId
 */
router.get('/api/pricing/:pricingId', pricingController.getPricingById);

/**
 * Update existing pricing record
 * PUT /api/pricing/:pricingId
 */
router.put('/api/pricing/:pricingId', pricingController.updateCustomPricing);

/**
 * Delete (deactivate) pricing record
 * DELETE /api/pricing/:pricingId
 */
router.delete('/api/pricing/:pricingId', pricingController.deleteCustomPricing);

/**
 * Update approval status for pricing record
 * PUT /api/pricing/:pricingId/approval
 */
router.put('/api/pricing/:pricingId/approval', pricingController.updatePricingApproval);

/**
 * Get pricing lookup for invoice generation
 * GET /api/pricing/lookup/:organizationId/:supportItemNumber
 */
router.get('/api/pricing/lookup/:organizationId/:supportItemNumber', pricingController.getPricingLookup);

/**
 * Get bulk pricing lookup for multiple NDIS items
 * POST /api/pricing/bulk-lookup
 */
router.post('/api/pricing/bulk-lookup', pricingController.getBulkPricingLookup);

/**
 * Bulk import pricing records
 * POST /api/pricing/bulk-import
 */
router.post('/api/pricing/bulk-import', pricingController.bulkImportPricing);

/**
 * Get custom price for organization (legacy endpoint)
 * GET /custom-price-organization/:ndisItemNumber
 */
router.get('/custom-price-organization/:ndisItemNumber', async (req, res) => {
  try {
    const { ndisItemNumber } = req.params;
    const organizationId = req.headers['organization-id'];
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required in headers'
      });
    }

    // Use the new pricing lookup endpoint
    const lookupReq = {
      params: { organizationId, supportItemNumber: ndisItemNumber },
      query: {} // No clientId for organization-level pricing
    };
    
    const mockRes = {
      status: (code) => ({
        json: (data) => {
          if (code === 200 && data.data && data.data.customPrice) {
            res.json({
              success: true,
              price: data.data.customPrice
            });
          } else {
            res.json({
              success: false,
              price: null
            });
          }
        }
      })
    };
    
    await pricingController.getPricingLookup(lookupReq, mockRes);
  } catch (error) {
    logger.error('Organization custom price fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      ndisItemNumber
    });
    res.status(500).json({
      success: false,
      message: 'Error retrieving custom price'
    });
  }
});

/**
 * Get custom price for client (legacy endpoint)
 * GET /custom-price-client/:ndisItemNumber/:clientId
 */
router.get('/custom-price-client/:ndisItemNumber/:clientId', async (req, res) => {
  try {
    const { ndisItemNumber, clientId } = req.params;
    const organizationId = req.headers['organization-id'];
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required in headers'
      });
    }

    // Use the new pricing lookup endpoint
    const lookupReq = {
      params: { organizationId, supportItemNumber: ndisItemNumber },
      query: { clientId } // Include clientId for client-specific pricing
    };
    
    const mockRes = {
      status: (code) => ({
        json: (data) => {
          if (code === 200 && data.data && data.data.customPrice) {
            res.json({
              success: true,
              price: data.data.customPrice
            });
          } else {
            res.json({
              success: false,
              price: null
            });
          }
        }
      })
    };
    
    await pricingController.getPricingLookup(lookupReq, mockRes);
  } catch (error) {
    logger.error('Client custom price fetch failed', {
      error: error.message,
      stack: error.stack,
      clientId,
      ndisItemNumber
    });
    res.status(500).json({
      success: false,
      message: 'Error retrieving custom price'
    });
  }
});

/**
 * Save custom price for organization (legacy endpoint)
 * POST /save-custom-price-organization
 */
router.post('/save-custom-price-organization', async (req, res) => {
  try {
    const { ndisItemNumber, price, notes, metadata } = req.body;
    
    // Get user info from session or token (simplified for now)
    const userEmail = req.headers['user-email'] || 'system@example.com';
    const organizationId = req.headers['organization-id'] || metadata?.organizationId;
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required'
      });
    }
    
    // Transform to new API format
    const transformedReq = {
      ...req,
      body: {
        organizationId: organizationId,
        supportItemNumber: ndisItemNumber,
        supportItemName: metadata?.supportItemName || `Item ${ndisItemNumber}`,
        pricingType: 'fixed',
        customPrice: price,
        clientSpecific: false,
        ndisCompliant: true,
        exceedsNdisCap: false,
        userEmail: userEmail,
        notes: notes
      }
    };
    
    await pricingController.createCustomPricing(transformedReq, res);
  } catch (error) {
    logger.error('Organization custom price save failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      ndisItemNumber
    });
    res.status(500).json({
      success: false,
      message: 'Error saving custom price'
    });
  }
});

/**
 * Save custom price for client (legacy endpoint)
 * POST /save-custom-price-client
 */
router.post('/save-custom-price-client', async (req, res) => {
  try {
    const { ndisItemNumber, clientId, price, notes, metadata } = req.body;
    
    // Get user info from session or token (simplified for now)
    const userEmail = req.headers['user-email'] || 'system@example.com';
    const organizationId = req.headers['organization-id'] || metadata?.organizationId;
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required'
      });
    }
    
    // Transform to new API format
    const transformedReq = {
      ...req,
      body: {
        organizationId: organizationId,
        supportItemNumber: ndisItemNumber,
        supportItemName: metadata?.supportItemName || `Item ${ndisItemNumber}`,
        pricingType: 'fixed',
        customPrice: price,
        clientId: clientId,
        clientSpecific: true,
        ndisCompliant: true,
        exceedsNdisCap: false,
        userEmail: userEmail,
        notes: notes
      }
    };
    
    await pricingController.createCustomPricing(transformedReq, res);
  } catch (error) {
    logger.error('Client custom price save failed', {
      error: error.message,
      stack: error.stack,
      clientId,
      ndisItemNumber
    });
    res.status(500).json({
      success: false,
      message: 'Error saving custom price'
    });
  }
});

module.exports = router;