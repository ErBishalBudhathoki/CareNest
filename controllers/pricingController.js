const pricingService = require('../services/pricingService');
const logger = require('../config/logger');

class PricingController {
  /**
   * Create custom pricing
   * POST /api/pricing
   */
  async createCustomPricing(req, res) {
    try {
      const { organizationId, userEmail } = req.body;

      // Validate required fields
      if (!organizationId || !userEmail) {
        return res.status(400).json({
          statusCode: 400,
          message: 'organizationId and userEmail are required'
        });
      }

      // Validate user authorization
      const isAuthorized = await pricingService.validateUserAuthorization(userEmail, organizationId);
      if (!isAuthorized) {
        return res.status(403).json({
          statusCode: 403,
          message: 'User not authorized for this organization'
        });
      }

      const pricingData = {
        organizationId,
        supportItemNumber: req.body.supportItemNumber,
        supportItemName: req.body.supportItemName,
        pricingType: req.body.pricingType,
        customPrice: req.body.customPrice,
        multiplier: req.body.multiplier,
        clientId: req.body.clientId,
        clientSpecific: req.body.clientSpecific,
        ndisCompliant: req.body.ndisCompliant,
        exceedsNdisCap: req.body.exceedsNdisCap,
        effectiveDate: req.body.effectiveDate,
        expiryDate: req.body.expiryDate
      };

      const result = await pricingService.createCustomPricing(pricingData, userEmail);

      res.status(201).json({
        statusCode: 201,
        message: 'Custom pricing created successfully',
        data: result
      });
    } catch (error) {
      logger.error('Error creating custom pricing', {
      error: error.message,
      stack: error.stack,
      pricingData: req.body
    });
      res.status(500).json({
        statusCode: 500,
        message: error.message || 'Error creating custom pricing'
      });
    }
  }

  /**
   * Get organization pricing
   * GET /api/pricing/organization/:organizationId
   */
  async getOrganizationPricing(req, res) {
    try {
      const { organizationId } = req.params;
      const {
        page,
        limit,
        search,
        clientSpecific,
        approvalStatus,
        sortBy,
        sortOrder
      } = req.query;

      const options = {
        page: parseInt(page) || 1,
        limit: parseInt(limit) || 50,
        search,
        clientSpecific: clientSpecific !== undefined ? clientSpecific === 'true' : undefined,
        approvalStatus,
        sortBy,
        sortOrder
      };

      const result = await pricingService.getOrganizationPricing(organizationId, options);

      res.status(200).json({
        statusCode: 200,
        data: result.pricing,
        pagination: result.pagination
      });
    } catch (error) {
      logger.error('Error getting organization pricing', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId
    });
      res.status(500).json({
        statusCode: 500,
        message: 'Error retrieving organization pricing'
      });
    }
  }

  /**
   * Get pricing by ID
   * GET /api/pricing/:id
   */
  async getPricingById(req, res) {
    try {
      const { id } = req.params;

      const pricing = await pricingService.getPricingById(id);

      if (!pricing) {
        return res.status(404).json({
          statusCode: 404,
          message: 'Pricing record not found'
        });
      }

      res.status(200).json({
        statusCode: 200,
        data: pricing
      });
    } catch (error) {
      logger.error('Error getting pricing by ID', {
      error: error.message,
      stack: error.stack,
      pricingId: req.params.id
    });
      res.status(500).json({
        statusCode: 500,
        message: 'Error retrieving pricing record'
      });
    }
  }

  /**
   * Update custom pricing
   * PUT /api/pricing/:id
   */
  async updateCustomPricing(req, res) {
    try {
      const { id } = req.params;
      const { userEmail } = req.body;

      if (!userEmail) {
        return res.status(400).json({
          statusCode: 400,
          message: 'userEmail is required'
        });
      }

      const updateData = {
        supportItemName: req.body.supportItemName,
        pricingType: req.body.pricingType,
        customPrice: req.body.customPrice,
        multiplier: req.body.multiplier,
        clientId: req.body.clientId,
        clientSpecific: req.body.clientSpecific,
        ndisCompliant: req.body.ndisCompliant,
        exceedsNdisCap: req.body.exceedsNdisCap,
        effectiveDate: req.body.effectiveDate,
        expiryDate: req.body.expiryDate
      };

      const result = await pricingService.updateCustomPricing(id, updateData, userEmail);

      res.status(200).json({
        statusCode: 200,
        message: 'Custom pricing updated successfully',
        data: result
      });
    } catch (error) {
      logger.error('Error updating custom pricing', {
      error: error.message,
      stack: error.stack,
      pricingId: req.params.id,
      updateData: req.body
    });
      res.status(500).json({
        statusCode: 500,
        message: error.message || 'Error updating custom pricing'
      });
    }
  }

  /**
   * Delete custom pricing
   * DELETE /api/pricing/:id
   */
  async deleteCustomPricing(req, res) {
    try {
      const { id } = req.params;
      const { userEmail } = req.body;

      if (!userEmail) {
        return res.status(400).json({
          statusCode: 400,
          message: 'userEmail is required'
        });
      }

      const success = await pricingService.deleteCustomPricing(id, userEmail);

      if (!success) {
        return res.status(404).json({
          statusCode: 404,
          message: 'Pricing record not found or already deleted'
        });
      }

      res.status(200).json({
        statusCode: 200,
        message: 'Custom pricing deleted successfully'
      });
    } catch (error) {
      logger.error('Error deleting custom pricing', {
      error: error.message,
      stack: error.stack,
      pricingId: req.params.id
    });
      res.status(500).json({
        statusCode: 500,
        message: error.message || 'Error deleting custom pricing'
      });
    }
  }

  /**
   * Update pricing approval status
   * PUT /api/pricing/:id/approval
   */
  async updatePricingApproval(req, res) {
    try {
      const { id } = req.params;
      const { approvalStatus, userEmail } = req.body;

      if (!approvalStatus || !userEmail) {
        return res.status(400).json({
          statusCode: 400,
          message: 'approvalStatus and userEmail are required'
        });
      }

      if (!['pending', 'approved', 'rejected'].includes(approvalStatus)) {
        return res.status(400).json({
          statusCode: 400,
          message: 'Invalid approval status. Must be pending, approved, or rejected'
        });
      }

      const result = await pricingService.updatePricingApproval(id, approvalStatus, userEmail);

      res.status(200).json({
        statusCode: 200,
        message: 'Pricing approval status updated successfully',
        data: result
      });
    } catch (error) {
      logger.error('Error updating pricing approval', {
      error: error.message,
      stack: error.stack,
      pricingId: req.params.id,
      approvalData: req.body
    });
      res.status(500).json({
        statusCode: 500,
        message: error.message || 'Error updating pricing approval'
      });
    }
  }

  /**
   * Get pricing lookup for a single item
   * GET /api/pricing/lookup
   */
  async getPricingLookup(req, res) {
    try {
      const { organizationId, supportItemNumber, clientId } = req.query;

      if (!organizationId || !supportItemNumber) {
        return res.status(400).json({
          statusCode: 400,
          message: 'organizationId and supportItemNumber are required'
        });
      }

      const result = await pricingService.getPricingLookup(organizationId, supportItemNumber, clientId);

      if (!result) {
        return res.status(404).json({
          statusCode: 404,
          message: 'No pricing found for this support item'
        });
      }

      res.status(200).json({
        statusCode: 200,
        data: result
      });
    } catch (error) {
      logger.error('Error getting pricing lookup', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId,
      ndisItemNumber: req.params.ndisItemNumber
    });
      res.status(500).json({
        statusCode: 500,
        message: 'Error retrieving pricing information'
      });
    }
  }

  /**
   * Get bulk pricing lookup
   * POST /api/pricing/bulk-lookup
   */
  async getBulkPricingLookup(req, res) {
    try {
      const { organizationId, supportItemNumbers, clientId } = req.body;

      if (!organizationId || !supportItemNumbers || !Array.isArray(supportItemNumbers)) {
        return res.status(400).json({
          statusCode: 400,
          message: 'organizationId and supportItemNumbers array are required'
        });
      }

      const result = await pricingService.getBulkPricingLookup(organizationId, supportItemNumbers, clientId);

      res.status(200).json({
        statusCode: 200,
        data: result.data,
        metadata: result.metadata
      });
    } catch (error) {
      logger.error('Error getting bulk pricing lookup', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId,
      ndisItemNumbers: req.body.ndisItemNumbers
    });
      res.status(500).json({
        statusCode: 500,
        message: 'Error retrieving bulk pricing information'
      });
    }
  }

  /**
   * Bulk import pricing
   * POST /api/pricing/bulk-import
   */
  async bulkImportPricing(req, res) {
    try {
      const { organizationId, pricingRecords, userEmail, importNotes } = req.body;

      if (!organizationId || !pricingRecords || !Array.isArray(pricingRecords) || !userEmail) {
        return res.status(400).json({
          statusCode: 400,
          message: 'organizationId, pricingRecords array, and userEmail are required'
        });
      }

      // Validate user authorization
      const isAuthorized = await pricingService.validateUserAuthorization(userEmail, organizationId);
      if (!isAuthorized) {
        return res.status(403).json({
          statusCode: 403,
          message: 'User not authorized for this organization'
        });
      }

      const results = await pricingService.bulkImportPricing(organizationId, pricingRecords, userEmail, importNotes);

      res.status(200).json({
        statusCode: 200,
        message: 'Bulk import completed',
        results
      });
    } catch (error) {
      logger.error('Error bulk importing pricing', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId,
      pricingData: req.body.pricingData
    });
      res.status(500).json({
        statusCode: 500,
        message: 'Error performing bulk import'
      });
    }
  }
}

module.exports = new PricingController();