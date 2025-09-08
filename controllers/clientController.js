const clientService = require('../services/clientService');
const logger = require('../config/logger');

class ClientController {
  async addClient(req, res) {
    try {
      const result = await clientService.addClient(req.body);
      res.status(201).json({
        statusCode: 201,
        ...result
      });
    } catch (error) {
      logger.error('Client creation failed', {
        error: error.message,
        stack: error.stack,
        organizationId: req.body.organizationId,
        clientName: req.body.name
      });
      
      if (error.message === 'User not authorized for this organization') {
        return res.status(403).json({
          statusCode: 403,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error adding client"
      });
    }
  }

  async getClients(req, res) {
    try {
      const { organizationId } = req.query;
      const { userEmail } = req.body;
      
      const result = await clientService.getClients(organizationId, userEmail);
      res.status(200).json({
        statusCode: 200,
        ...result
      });
    } catch (error) {
      logger.error('Clients fetch failed', {
        error: error.message,
        stack: error.stack,
        organizationId: req.query.organizationId
      });
      
      if (error.message === 'User not authorized for this organization') {
        return res.status(403).json({
          statusCode: 403,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error retrieving clients"
      });
    }
  }

  async getClientById(req, res) {
    try {
      const { clientId } = req.params;
      const { organizationId } = req.query;
      const { userEmail } = req.body;
      
      const result = await clientService.getClientById(clientId, organizationId, userEmail);
      res.status(200).json({
        statusCode: 200,
        ...result
      });
    } catch (error) {
      logger.error('Client fetch failed', {
        error: error.message,
        stack: error.stack,
        clientId: req.params.clientId
      });
      
      if (error.message === 'User not authorized for this organization') {
        return res.status(403).json({
          statusCode: 403,
          message: error.message
        });
      }
      
      if (error.message === 'Client not found') {
        return res.status(404).json({
          statusCode: 404,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error retrieving client"
      });
    }
  }

  async updateClient(req, res) {
    try {
      const { clientId } = req.params;
      const { organizationId, userEmail, ...updateData } = req.body;
      
      const result = await clientService.updateClient(clientId, updateData, organizationId, userEmail);
      res.status(200).json({
        statusCode: 200,
        ...result
      });
    } catch (error) {
      logger.error('Client update failed', {
        error: error.message,
        stack: error.stack,
        clientId: req.params.clientId
      });
      
      if (error.message === 'User not authorized for this organization') {
        return res.status(403).json({
          statusCode: 403,
          message: error.message
        });
      }
      
      if (error.message === 'Client not found') {
        return res.status(404).json({
          statusCode: 404,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error updating client"
      });
    }
  }

  async deleteClient(req, res) {
    try {
      const { clientId } = req.params;
      const { organizationId, userEmail } = req.body;
      
      const result = await clientService.deleteClient(clientId, organizationId, userEmail);
      res.status(200).json({
        statusCode: 200,
        ...result
      });
    } catch (error) {
      logger.error('Client deletion failed', {
        error: error.message,
        stack: error.stack,
        clientId: req.params.clientId
      });
      
      if (error.message === 'User not authorized for this organization') {
        return res.status(403).json({
          statusCode: 403,
          message: error.message
        });
      }
      
      if (error.message === 'Client not found') {
        return res.status(404).json({
          statusCode: 404,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error deleting client"
      });
    }
  }

  async getClientPricing(req, res) {
    try {
      const { clientId } = req.params;
      const { organizationId } = req.query;
      const { userEmail } = req.body;
      
      const result = await clientService.getClientPricing(clientId, organizationId, userEmail);
      res.status(200).json({
        statusCode: 200,
        ...result
      });
    } catch (error) {
      logger.error('Client pricing fetch failed', {
        error: error.message,
        stack: error.stack,
        clientId: req.params.clientId
      });
      
      if (error.message === 'User not authorized for this organization') {
        return res.status(403).json({
          statusCode: 403,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error retrieving client pricing"
      });
    }
  }

  async updateClientPricing(req, res) {
    try {
      const { clientId } = req.params;
      const { organizationId, userEmail, ...pricingData } = req.body;
      
      const result = await clientService.updateClientPricing(clientId, pricingData, organizationId, userEmail);
      res.status(200).json({
        statusCode: 200,
        ...result
      });
    } catch (error) {
      logger.error('Client pricing update failed', {
        error: error.message,
        stack: error.stack,
        clientId: req.params.clientId
      });
      
      if (error.message === 'User not authorized for this organization') {
        return res.status(403).json({
          statusCode: 403,
          message: error.message
        });
      }
      
      res.status(500).json({
        statusCode: 500,
        message: "Error updating client pricing"
      });
    }
  }

  async getMultipleClients(req, res) {
    try {
      const { emails } = req.params;
      
      const clients = await clientService.getMultipleClients(emails);
      
      // Return clients as array (expected by frontend)
      res.status(200).json(clients);
    } catch (error) {
      logger.error('Multiple clients fetch failed', {
        error: error.message,
        stack: error.stack,
        emails: req.params.emails
      });
      res.status(500).json({
        success: false,
        message: "Error getting clients",
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  }

  async assignClientToUser(req, res) {
    try {
      const { 
        userEmail, 
        clientEmail, 
        dateList, 
        startTimeList, 
        endTimeList, 
        breakList, 
        ndisItem, 
        highIntensityList, 
        customPricing, 
        scheduleWithNdisItems 
      } = req.body;
      
      // Validate required fields
      if (!userEmail || !clientEmail || !dateList || !startTimeList || !endTimeList || !breakList || !highIntensityList) {
        return res.status(400).json({
          success: false,
          message: 'Missing required fields: userEmail, clientEmail, dateList, startTimeList, endTimeList, breakList, highIntensityList'
        });
      }
      
      // Validate array lengths match
      if (dateList.length !== startTimeList.length || dateList.length !== endTimeList.length || 
          dateList.length !== breakList.length || dateList.length !== highIntensityList.length) {
        return res.status(400).json({
          success: false,
          message: 'All arrays (dateList, startTimeList, endTimeList, breakList, highIntensityList) must have the same length'
        });
      }
      
      // If scheduleWithNdisItems is provided, validate it matches the array lengths
      if (scheduleWithNdisItems && scheduleWithNdisItems.length !== dateList.length) {
        return res.status(400).json({
          success: false,
          message: 'scheduleWithNdisItems array must have the same length as other schedule arrays'
        });
      }
      
      const result = await clientService.assignClientToUser(req.body);
      
      res.status(200).json(result);
    } catch (error) {
      logger.error('Client assignment failed', {
        error: error.message,
        stack: error.stack,
        userEmail: req.body.userEmail,
        clientEmail: req.body.clientEmail
      });
      
      if (error.message && error.message.includes('not found')) {
        res.status(404).json({ 
          success: false, 
          message: error.message 
        });
      } else {
        res.status(500).json({
          success: false,
          message: "Error assigning client",
          error: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
      }
    }
  }

  async getUserAssignments(req, res) {
    try {
      const { userEmail } = req.params;
      
      const assignments = await clientService.getUserAssignments(userEmail);
      
      res.status(200).json({
        success: true,
        assignments: assignments
      });
    } catch (error) {
      logger.error('User assignments fetch failed', {
        error: error.message,
        stack: error.stack,
        userEmail: req.params.userEmail
      });
      res.status(500).json({
        success: false,
        error: 'Failed to get user assignments'
      });
    }
  }
}

module.exports = new ClientController();