const express = require('express');
const organizationController = require('../controllers/organizationController');
const router = express.Router();

/**
 * Create a new organization
 * POST /organization/create
 */
router.post('/create', organizationController.createOrganization);

/**
 * Create a new organization (legacy endpoint)
 * POST /createOrganization
 */
router.post('/createOrganization', organizationController.createOrganizationLegacy);

/**
 * Verify organization code
 * POST /organization/verify-code
 */
router.post('/verify-code', organizationController.verifyOrganizationCode);

/**
 * Verify organization code (frontend endpoint)
 * GET /organization/verify/:organizationCode
 */
router.get('/verify/:organizationCode', organizationController.verifyOrganizationCodeGet);

/**
 * Verify organization code (legacy endpoint)
 * GET /verifyOrganizationCode/:code
 */
router.get('/verifyOrganizationCode/:code', organizationController.verifyOrganizationCodeLegacy);

/**
 * Get organization details
 * GET /organization/:organizationId
 */
router.get('/:organizationId', organizationController.getOrganizationById);

/**
 * Get organization members
 * GET /organization/:organizationId/members
 */
router.get('/:organizationId/members', organizationController.getOrganizationMembers);

/**
 * Get organization businesses
 * GET /organization/:organizationId/businesses
 */
router.get('/:organizationId/businesses', organizationController.getOrganizationBusinesses);

/**
 * Get organization clients
 * GET /organization/:organizationId/clients
 */
router.get('/:organizationId/clients', organizationController.getOrganizationClients);

/**
 * Get organization employees
 * GET /organization/:organizationId/employees
 */
router.get('/:organizationId/employees', organizationController.getOrganizationEmployees);

module.exports = router;