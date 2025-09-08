const appointmentService = require('../services/appointmentService');
const logger = require('../config/logger');

/**
 * Controller for handling appointment-related HTTP requests
 */
class AppointmentController {
  /**
   * Load appointments for a user
   * GET /loadAppointments/:email
   */
  static async loadAppointments(req, res) {
    try {
      const { email } = req.params;
      
      if (!email) {
        return res.status(400).json({
          success: false,
          error: 'Email parameter is required',
          data: []
        });
      }
      
      const appointments = await AppointmentService.loadAppointments(email);
      
      res.status(200).json({
        success: true,
        data: appointments
      });
    } catch (error) {
      logger.error('Error loading appointments', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId
    });
      res.status(500).json({
        success: false,
        error: 'Failed to load appointments',
        data: []
      });
    }
  }

  /**
   * Get appointment details for a specific user and client
   * GET /loadAppointmentDetails/:userEmail/:clientEmail
   */
  static async loadAppointmentDetails(req, res) {
    try {
      const { userEmail, clientEmail } = req.params;
      
      if (!userEmail || !clientEmail) {
        return res.status(400).json({
          success: false,
          error: 'Both userEmail and clientEmail parameters are required'
        });
      }
      
      const appointmentDetails = await AppointmentService.loadAppointmentDetails(userEmail, clientEmail);
      
      res.status(200).json({
        success: true,
        data: appointmentDetails
      });
    } catch (error) {
      logger.error('Error loading appointment details', {
      error: error.message,
      stack: error.stack,
      appointmentId: req.params.appointmentId
    });
      
      if (error.message === 'No appointment found for this user-client combination') {
        return res.status(404).json({
          success: false,
          error: error.message
        });
      }
      
      res.status(500).json({
        success: false,
        error: 'Failed to load appointment details'
      });
    }
  }

  /**
   * Get all assignments for an organization
   * GET /getOrganizationAssignments/:organizationId
   */
  static async getOrganizationAssignments(req, res) {
    try {
      const { organizationId } = req.params;
      
      if (!organizationId) {
        return res.status(400).json({
          success: false,
          error: 'Organization ID parameter is required'
        });
      }
      
      const assignments = await AppointmentService.getOrganizationAssignments(organizationId);
      
      res.status(200).json({
        success: true,
        assignments: assignments
      });
    } catch (error) {
      logger.error('Error getting organization assignments', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId
    });
      res.status(500).json({
        success: false,
        error: 'Failed to get organization assignments'
      });
    }
  }

  /**
   * Remove client assignment
   * DELETE /removeClientAssignment
   */
  static async removeClientAssignment(req, res) {
    try {
      const { userEmail, clientEmail } = req.body;
      
      if (!userEmail || !clientEmail) {
        return res.status(400).json({
          success: false,
          error: 'Both userEmail and clientEmail are required'
        });
      }
      
      const result = await AppointmentService.removeClientAssignment(userEmail, clientEmail);
      
      res.status(200).json(result);
    } catch (error) {
      logger.error('Error removing assignment', {
      error: error.message,
      stack: error.stack,
      assignmentId: req.params.assignmentId
    });
      
      if (error.message === 'Assignment not found') {
        return res.status(404).json({
          success: false,
          error: error.message
        });
      }
      
      res.status(500).json({
        success: false,
        error: 'Failed to remove assignment'
      });
    }
  }

  /**
   * Set worked time for a client
   * POST /setWorkedTime
   */
  static async setWorkedTime(req, res) {
    try {
      const {
        'User-Email': userEmail,
        'Client-Email': clientEmail,
        'TimeList': timeList,
        shiftIndex
      } = req.body;
      
      const workedTimeData = {
        userEmail,
        clientEmail,
        timeList,
        shiftIndex
      };
      
      const result = await AppointmentService.setWorkedTime(workedTimeData);
      
      res.status(200).json(result);
    } catch (error) {
      logger.error('Error saving worked time', {
      error: error.message,
      stack: error.stack,
      workedTimeData: req.body
    });
      
      if (error.message.includes('Missing required fields') || error.message === 'Assigned client not found') {
        return res.status(400).json({
          success: false,
          message: error.message
        });
      }
      
      res.status(500).json({ 
        success: false,
        message: 'Error saving worked time: ' + error.message
      });
    }
  }
}

module.exports = AppointmentController;