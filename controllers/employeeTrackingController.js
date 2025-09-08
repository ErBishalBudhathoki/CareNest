const employeeTrackingService = require('../services/employeeTrackingService');
const logger = require('../config/logger');

class EmployeeTrackingController {
  /**
   * Get comprehensive employee tracking data for an organization
   * GET /api/employee-tracking/:organizationId
   */
  static async getEmployeeTrackingData(req, res) {
    try {
      const { organizationId } = req.params;
      
      // Validate organization ID
      if (!organizationId || organizationId.trim() === '') {
        return res.status(400).json({
          success: false,
          message: 'Organization ID is required'
        });
      }
      
      logger.debug('Getting employee tracking data', {
      organizationId
    });
      
      // Get employee tracking data from service
       const trackingData = await employeeTrackingService.getEmployeeTrackingData(organizationId);
      
      logger.debug('Employee tracking data retrieved', {
      organizationId,
      totalEmployees: trackingData.totalEmployees,
      currentlyWorking: trackingData.currentlyWorking.length,
      notCurrentlyWorking: trackingData.notCurrentlyWorking.length
    });
      
      res.json({
        success: true,
        data: trackingData
      });
      
    } catch (error) {
      logger.error('Employee tracking data fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId
    });
      
      // Handle specific error types
      if (error.message === 'Organization ID is required') {
        return res.status(400).json({
          success: false,
          message: error.message
        });
      }
      
      res.status(500).json({
        success: false,
        message: 'Failed to get employee tracking data',
        error: error.message
      });
    }
  }
}

module.exports = EmployeeTrackingController;