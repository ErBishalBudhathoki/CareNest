const express = require('express');
const businessController = require('../controllers/businessController');
const router = express.Router();

/**
 * Add business with organization context
 * POST /addBusiness
 */
router.post('/addBusiness', businessController.addBusiness);

/**
 * Get businesses for organization
 * GET /businesses/:organizationId
 */
router.get('/businesses/:organizationId', businessController.getBusinessesByOrganization);

module.exports = router;