const express = require('express');
const userController = require('../controllers/userController');
const router = express.Router();

/**
 * Get all users
 * GET /getUsers/
 */
router.get("/getUsers/", userController.getAllUsers);

/**
 * Get all users (employees) for a specific organization
 * GET /organization/:organizationId/employees
 */
router.get("/organization/:organizationId/employees", userController.getOrganizationEmployees);

/**
 * Fix client organizationId for existing records
 * POST /fixClientOrganizationId
 */
router.post('/fixClientOrganizationId', userController.fixClientOrganizationId);

module.exports = router;