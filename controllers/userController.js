const userService = require('../services/userService');
const logger = require('../config/logger');

class UserController {
  /**
   * Get all users
   * GET /getUsers/
   */
  async getAllUsers(req, res) {
    try {
      const users = await userService.getAllUsers();
      res.status(200).json(users);
    } catch (error) {
      logger.error('Error fetching users', {
        error: error.message,
        stack: error.stack
      });
      res.status(500).json({ error: "Internal server error" });
    }
  }

  /**
   * Get all employees for a specific organization
   * GET /organization/:organizationId/employees
   */
  async getOrganizationEmployees(req, res) {
    try {
      const { organizationId } = req.params;
      
      const employees = await userService.getOrganizationEmployees(organizationId);
      
      if (employees.length > 0) {
        res.status(200).json({
          success: true,
          employees: employees
        });
      } else {
        res.status(404).json({
          success: false,
          message: "No users (employees) were found for this organization."
        });
      }
    } catch (error) {
      logger.error('Error fetching organization employees', {
        error: error.message,
        stack: error.stack,
        organizationId: req.params.organizationId
      });
      res.status(500).json({
        success: false,
        message: "Error fetching employees"
      });
    }
  }

  /**
   * Fix client organizationId for existing records
   * POST /fixClientOrganizationId
   */
  async fixClientOrganizationId(req, res) {
    try {
      const { userEmail, organizationId } = req.body;
      
      if (!userEmail || !organizationId) {
        return res.status(400).json({
          success: false,
          error: 'userEmail and organizationId are required'
        });
      }
      
      const result = await userService.fixClientOrganizationId(userEmail, organizationId);
      
      res.status(200).json({
        success: true,
        message: 'Organization ID fixed successfully',
        clientsUpdated: result.clientsUpdated,
        assignmentsUpdated: result.assignmentsUpdated
      });
    } catch (error) {
      logger.error('Error fixing organizationId', {
        error: error.message,
        stack: error.stack
      });
      
      if (error.message === 'User not authorized for this organization') {
        res.status(403).json({
          success: false,
          error: error.message
        });
      } else {
        res.status(500).json({
          success: false,
          error: 'Failed to fix organization ID'
        });
      }
    }
  }
}

module.exports = new UserController();