const express = require('express');
const EmployeeTrackingController = require('../controllers/employeeTrackingController');
const router = express.Router();

/**
 * Employee Tracking API Endpoint
 * GET /api/employee-tracking/:organizationId
 * 
 * This endpoint provides comprehensive employee tracking data including:
 * - Currently working employees (active timers)
 * - Worked time records with shift details
 * - Employee assignments and client information
 */
router.get('/api/employee-tracking/:organizationId', EmployeeTrackingController.getEmployeeTrackingData);

module.exports = router;