const express = require('express');
const AppointmentController = require('../controllers/appointmentController');
const { startTimerWithTracking, stopTimerWithTracking, getActiveTimers } = require('../utils/activeTimers');
const router = express.Router();

/**
 * Load appointments for a user
 * GET /loadAppointments/:email
 */
router.get('/loadAppointments/:email', AppointmentController.loadAppointments);

/**
 * Get appointment details for a specific user and client
 * GET /loadAppointmentDetails/:userEmail/:clientEmail
 */
router.get('/loadAppointmentDetails/:userEmail/:clientEmail', AppointmentController.loadAppointmentDetails);

/**
 * Get all assignments for an organization
 * GET /getOrganizationAssignments/:organizationId
 */
router.get('/getOrganizationAssignments/:organizationId', AppointmentController.getOrganizationAssignments);

/**
 * Remove client assignment
 * DELETE /removeClientAssignment
 */
router.delete('/removeClientAssignment', AppointmentController.removeClientAssignment);

// ============================================================================
// TIMER ENDPOINTS
// ============================================================================

// Legacy timer variables (kept for backward compatibility)
let timerInterval;
let timerRunning = false;
let startTime;

/**
 * Start timer (legacy endpoint - redirects to new implementation)
 * POST /startTimer
 */
router.post('/startTimer', async (req, res) => {
  // For backward compatibility, we'll use default values if not provided
  const requestBody = {
    userEmail: req.body.userEmail || 'legacy@user.com',
    clientEmail: req.body.clientEmail || 'legacy@client.com',
    organizationId: req.body.organizationId || 'legacy-org'
  };
  
  // Create a new request object with the body
  const newReq = { body: requestBody };
  
  // Call the new implementation
  await startTimerWithTracking(newReq, res);
});

/**
 * Stop timer (legacy endpoint - redirects to new implementation)
 * POST /stopTimer
 */
router.post('/stopTimer', async (req, res) => {
  // For backward compatibility, we'll use default values if not provided
  const requestBody = {
    userEmail: req.body.userEmail || 'legacy@user.com',
    organizationId: req.body.organizationId || 'legacy-org'
  };
  
  // Create a new request object with the body
  const newReq = { body: requestBody };
  
  // Call the new implementation
  await stopTimerWithTracking(newReq, res);
});

/**
 * Start timer with tracking (new database-backed endpoint)
 * POST /startTimerWithTracking
 */
router.post('/startTimerWithTracking', startTimerWithTracking);

/**
 * Stop timer with tracking (new database-backed endpoint)
 * POST /stopTimerWithTracking
 */
router.post('/stopTimerWithTracking', stopTimerWithTracking);

/**
 * Get active timers for organization
 * GET /getActiveTimers/:organizationId
 */
router.get('/getActiveTimers/:organizationId', getActiveTimers);

/**
 * Set worked time for a client
 * POST /setWorkedTime
 */
router.post('/setWorkedTime', AppointmentController.setWorkedTime);

module.exports = router;