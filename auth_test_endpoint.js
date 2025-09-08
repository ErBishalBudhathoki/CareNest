/**
 * Authentication Test Endpoint
 * 
 * This file provides a simple endpoint to test if authentication is working properly.
 * It requires a valid JWT token in the Authorization header.
 */

const express = require('express');
const router = express.Router();
const { authenticateUser } = require('./middleware/auth');
const { createLogger } = require('./utils/logger');

const logger = createLogger('AuthTestEndpoint');

/**
 * GET /auth-test
 * Test if authentication is working properly
 * @access Private
 */
router.get('/', authenticateUser, (req, res) => {
  logger.info('Authentication test endpoint accessed', {
    userId: req.user.userId,
    email: req.user.email,
    ip: req.ip
  });
  
  res.json({
    success: true,
    message: 'Authentication successful',
    user: {
      userId: req.user.userId,
      email: req.user.email,
      roles: req.user.roles,
      organizationId: req.user.organizationId
    },
    timestamp: new Date().toISOString()
  });
});

module.exports = router;