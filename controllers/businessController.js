const businessService = require('../services/businessService');
const logger = require('../config/logger');

class BusinessController {
  /**
   * Add business with organization context
   * POST /addBusiness
   */
  async addBusiness(req, res) {
    try {
      const { 
        businessName, 
        businessEmail, 
        businessPhone, 
        businessAddress, 
        businessCity, 
        businessState, 
        businessZip,
        organizationId,
        userEmail 
      } = req.body;
      
      // Validate required fields
      if (!businessName || !businessEmail) {
        return res.status(400).json({
          statusCode: 400,
          message: "Business name and email are required"
        });
      }
      
      const businessId = await businessService.addBusiness({
        businessName, 
        businessEmail, 
        businessPhone, 
        businessAddress, 
        businessCity, 
        businessState, 
        businessZip,
        organizationId,
        userEmail
      });
      
      res.status(200).json({
        statusCode: 200,
        message: "Business added successfully",
        businessId: businessId
      });
      
    } catch (error) {
      logger.error('Error adding business', {
        error: error.message,
        stack: error.stack,
        businessData: req.body
      });
      
      if (error.message === 'User not authorized for this organization') {
        return res.status(403).json({
          statusCode: 403,
          message: error.message
        });
      }
      
      if (error.message === 'Business with this name and email already exists') {
        return res.status(409).json({
          statusCode: 409,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error adding business"
      });
    }
  }
  
  /**
   * Get businesses for organization
   * GET /businesses/:organizationId
   */
  async getBusinessesByOrganization(req, res) {
    try {
      const { organizationId } = req.params;
      
      if (!organizationId) {
        return res.status(400).json({
          statusCode: 400,
          message: "Organization ID is required"
        });
      }
      
      const businesses = await businessService.getBusinessesByOrganization(organizationId);
      
      res.status(200).json({
        statusCode: 200,
        businesses: businesses
      });
      
    } catch (error) {
      logger.error('Error getting businesses', {
        error: error.message,
        stack: error.stack,
        organizationId: req.params.organizationId
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error getting businesses"
      });
    }
  }
}

module.exports = new BusinessController();