const express = require('express');
const clientController = require('../controllers/clientController');
const router = express.Router();

/**
 * Add client with organization context
 * POST /addClient
 */
router.post('/addClient', clientController.addClient);

/**
 * Get clients for organization (legacy endpoint)
 * GET /clients/:organizationId
 */
router.get('/clients/:organizationId', clientController.getClients);

/**
 * Get all clients (simple endpoint for backward compatibility)
 * GET /getClients
 */
router.get('/getClients', clientController.getClients);

/**
 * Get multiple clients by email list
 * GET /getMultipleClients/:emails
 */
router.get('/getMultipleClients/:emails', clientController.getMultipleClients);

/**
 * Assign client to user with schedule
 * POST /assignClientToUser
 */
router.post('/assignClientToUser', clientController.assignClientToUser);

/**
 * Get user assignments
 * GET /getUserAssignments/:userEmail
 */
router.get('/getUserAssignments/:userEmail', clientController.getUserAssignments);

module.exports = router;