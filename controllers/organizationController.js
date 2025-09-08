const organizationService = require('../services/organizationService');
const logger = require('../config/logger');

class OrganizationController {
  async createOrganization(req, res) {
    try {
      const { organizationName, ownerEmail } = req.body;
      
      if (!organizationName || !ownerEmail) {
        return res.status(400).json({
          message: "Organization name and owner email are required"
        });
      }
      
      const result = await organizationService.createOrganization({
        organizationName,
        ownerEmail
      });
      
      res.status(200).json({
        message: "Organization created successfully",
        ...result
      });
    } catch (error) {
      logger.error('Error creating organization', {
        error: error.message,
        stack: error.stack,
        organizationData: req.body
      });
      
      if (error.message === 'Organization name already exists') {
        return res.status(400).json({
          message: error.message
        });
      }
      
      res.status(500).json({
        message: "Error creating organization"
      });
    }
  }

  async createOrganizationLegacy(req, res) {
    try {
      const { organizationName, ownerFirstName, ownerLastName, ownerEmail } = req.body;
      
      if (!organizationName || !ownerEmail) {
        return res.status(400).json({
          statusCode: 400,
          message: "Organization name and owner email are required"
        });
      }
      
      const result = await organizationService.createOrganization({
        organizationName,
        ownerEmail,
        ownerFirstName,
        ownerLastName
      });
      
      res.status(200).json({
        statusCode: 200,
        message: "Organization created successfully",
        ...result
      });
    } catch (error) {
      logger.error('Error creating organization', {
        error: error.message,
        stack: error.stack,
        organizationData: req.body
      });
      
      if (error.message === 'Organization name already exists') {
        return res.status(409).json({
          statusCode: 409,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error creating organization"
      });
    }
  }

  async verifyOrganizationCode(req, res) {
    try {
      const { organizationCode } = req.body;
      
      if (!organizationCode) {
        return res.status(400).json({
          message: "Organization code is required"
        });
      }
      
      const organization = await organizationService.verifyOrganizationCode(organizationCode);
      
      if (organization) {
        res.status(200).json({
          message: "Organization code is valid",
          ...organization
        });
      } else {
        res.status(404).json({
          message: "Invalid organization code"
        });
      }
    } catch (error) {
      logger.error('Error verifying organization code', {
        error: error.message,
        stack: error.stack,
        organizationCode: req.body.organizationCode
      });
      res.status(500).json({
        message: "Error verifying organization code"
      });
    }
  }

  async verifyOrganizationCodeGet(req, res) {
    try {
      const { organizationCode } = req.params;
      
      if (!organizationCode) {
        return res.status(400).json({
          success: false,
          statusCode: 400,
          message: "Organization code is required"
        });
      }
      
      const organization = await organizationService.verifyOrganizationCode(organizationCode);
      
      if (organization) {
        res.status(200).json({
          success: true,
          statusCode: 200,
          message: "Organization code verified",
          organizationId: organization.organizationId,
          organizationName: organization.organizationName
        });
      } else {
        res.status(404).json({
          success: false,
          statusCode: 404,
          message: "Invalid organization code"
        });
      }
    } catch (error) {
      logger.error('Error verifying organization code', {
        error: error.message,
        stack: error.stack,
        organizationCode: req.params.organizationCode
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error verifying organization code"
      });
    }
  }

  async verifyOrganizationCodeLegacy(req, res) {
    try {
      const { code } = req.params;
      
      if (!code) {
        return res.status(400).json({
          success: false,
          statusCode: 400,
          message: "Organization code is required"
        });
      }
      
      const organization = await organizationService.verifyOrganizationCode(code);
      
      if (organization) {
        res.status(200).json({
          success: true,
          statusCode: 200,
          message: "Organization code verified",
          organizationId: organization.organizationId,
          organizationName: organization.organizationName
        });
      } else {
        res.status(404).json({
          success: false,
          statusCode: 404,
          message: "Invalid organization code"
        });
      }
    } catch (error) {
      logger.error('Error verifying organization code', {
        error: error.message,
        stack: error.stack,
        organizationCode: req.params.code
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error verifying organization code"
      });
    }
  }

  async getOrganizationById(req, res) {
    try {
      const { organizationId } = req.params;
      
      if (!organizationId) {
        return res.status(400).json({
          statusCode: 400,
          message: "Organization ID is required"
        });
      }
      
      const organization = await organizationService.getOrganizationById(organizationId);
      
      if (organization) {
        res.status(200).json({
          statusCode: 200,
          organization: organization
        });
      } else {
        res.status(404).json({
          statusCode: 404,
          message: "Organization not found"
        });
      }
    } catch (error) {
      logger.error('Error getting organization', {
        error: error.message,
        stack: error.stack,
        organizationId: req.params.organizationId
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error getting organization"
      });
    }
  }

  async getOrganizationMembers(req, res) {
    try {
      const { organizationId } = req.params;
      
      if (!organizationId) {
        return res.status(400).json({
          statusCode: 400,
          message: "Organization ID is required"
        });
      }
      
      const members = await organizationService.getOrganizationMembers(organizationId);
      
      res.status(200).json({
        statusCode: 200,
        members: members
      });
    } catch (error) {
      logger.error('Error getting organization members', {
        error: error.message,
        stack: error.stack,
        organizationId: req.params.organizationId
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error getting organization members"
      });
    }
  }

  async getOrganizationBusinesses(req, res) {
    try {
      const { organizationId } = req.params;
      
      if (!organizationId) {
        return res.status(400).json({
          statusCode: 400,
          message: "Organization ID is required"
        });
      }
      
      const businesses = await organizationService.getOrganizationBusinesses(organizationId);
      
      res.status(200).json({
        statusCode: 200,
        businesses: businesses
      });
    } catch (error) {
      logger.error('Error getting organization businesses', {
        error: error.message,
        stack: error.stack,
        organizationId: req.params.organizationId
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error getting organization businesses"
      });
    }
  }

  async getOrganizationClients(req, res) {
    try {
      const { organizationId } = req.params;
      
      if (!organizationId) {
        return res.status(400).json({
          statusCode: 400,
          message: "Organization ID is required"
        });
      }
      
      const clients = await organizationService.getOrganizationClients(organizationId);
      
      res.status(200).json({
        statusCode: 200,
        clients: clients
      });
    } catch (error) {
      logger.error('Error getting organization clients', {
        error: error.message,
        stack: error.stack,
        organizationId: req.params.organizationId
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error getting organization clients"
      });
    }
  }

  async getOrganizationEmployees(req, res) {
    try {
      const { organizationId } = req.params;
      
      if (!organizationId) {
        return res.status(400).json({
          statusCode: 400,
          message: "Organization ID is required"
        });
      }
      
      const employees = await organizationService.getOrganizationEmployees(organizationId);
      
      res.status(200).json({
        statusCode: 200,
        employees: employees
      });
    } catch (error) {
      logger.error('Error getting organization employees', {
        error: error.message,
        stack: error.stack,
        organizationId: req.params.organizationId
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error getting organization employees"
      });
    }
  }
}

module.exports = new OrganizationController();