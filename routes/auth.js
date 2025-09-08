const express = require('express');
const SecureAuthController = require('../controllers/secureAuthController');
const { authenticateUser, rateLimitMiddleware } = require('../middleware/auth');
const InputValidator = require('../utils/inputValidator');
const SecureErrorHandler = require('../utils/errorHandler');
const { createLogger } = require('../utils/logger');
const { securityMonitor } = require('../utils/securityMonitor');

const router = express.Router();
const logger = createLogger('AuthRoutes');

/**
 * Authentication Routes
 * All routes include comprehensive security measures
 */

/**
 * @route POST /api/auth/register
 * @desc Register a new user
 * @access Public
 */
router.post('/register', 
  rateLimitMiddleware('register'),
  async (req, res) => {
    try {
      const result = await SecureAuthController.register(req, res);
      return result;
    } catch (error) {
      logger.error('Registration route error', {
        error: error.message,
        email: req.body?.email
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/login
 * @desc Authenticate user and return token
 * @access Public
 */
router.post('/login',
  rateLimitMiddleware('login'),

  async (req, res) => {
    try {
      const result = await SecureAuthController.login(req, res);
      return result;
    } catch (error) {
      logger.error('Login route error', {
        error: error.message,
        email: req.body?.email
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/secure-login
 * @desc Secure authenticate user and return token (enhanced security)
 * @access Public
 */
router.post('/secure-login',
  rateLimitMiddleware('login'),

  async (req, res) => {
    try {
      const result = await SecureAuthController.login(req, res);
      return result;
    } catch (error) {
      logger.error('Secure login route error', {
        error: error.message,
        email: req.body?.email
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/verify-email
 * @desc Verify user email with OTP
 * @access Public
 */
router.post('/verify-email',
  rateLimitMiddleware('verify'),

  async (req, res) => {
    try {
      const result = await SecureAuthController.verifyEmail(req, res);
      return result;
    } catch (error) {
      logger.error('Email verification route error', {
        error: error.message,
        email: req.body?.email
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/forgot-password
 * @desc Send password reset OTP
 * @access Public
 */
router.post('/forgot-password',
  rateLimitMiddleware('forgot'),

  async (req, res) => {
    try {
      const result = await SecureAuthController.forgotPassword(req, res);
      return result;
    } catch (error) {
      logger.error('Forgot password route error', {
        error: error.message,
        email: req.body?.email
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/reset-password
 * @desc Reset password with OTP
 * @access Public
 */
router.post('/reset-password',
  rateLimitMiddleware('reset'),

  async (req, res) => {
    try {
      const result = await SecureAuthController.resetPassword(req, res);
      return result;
    } catch (error) {
      logger.error('Reset password route error', {
        error: error.message,
        email: req.body?.email
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route GET /api/auth/profile
 * @desc Get user profile
 * @access Private
 */
router.get('/profile',
  authenticateUser,
  async (req, res) => {
    try {
      const result = await SecureAuthController.getProfile(req, res);
      return result;
    } catch (error) {
      logger.error('Get profile route error', {
        error: error.message,
        userId: req.user?.userId
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route PUT /api/auth/profile
 * @desc Update user profile
 * @access Private
 */
router.put('/profile',
  authenticateUser,
  rateLimitMiddleware('update'),

  async (req, res) => {
    try {
      const result = await SecureAuthController.updateProfile(req, res);
      return result;
    } catch (error) {
      logger.error('Update profile route error', {
        error: error.message,
        userId: req.user?.userId
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/change-password
 * @desc Change user password
 * @access Private
 */
router.post('/change-password',
  authenticateUser,
  rateLimitMiddleware('change-password'),

  async (req, res) => {
    try {
      const result = await SecureAuthController.changePassword(req, res);
      return result;
    } catch (error) {
      logger.error('Change password route error', {
        error: error.message,
        userId: req.user?.userId
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/logout
 * @desc Logout user
 * @access Private
 */
router.post('/logout',
  authenticateUser,
  async (req, res) => {
    try {
      const result = await SecureAuthController.logout(req, res);
      return result;
    } catch (error) {
      logger.error('Logout route error', {
        error: error.message,
        userId: req.user?.userId
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/refresh-token
 * @desc Refresh JWT token
 * @access Private
 */
router.post('/refresh-token',
  authenticateUser,
  rateLimitMiddleware('refresh'),
  async (req, res) => {
    try {
      const result = await SecureAuthController.refreshToken(req, res);
      return result;
    } catch (error) {
      logger.error('Refresh token route error', {
        error: error.message,
        userId: req.user?.userId
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route GET /api/auth/verify-token
 * @desc Verify JWT token validity
 * @access Private
 */
router.get('/verify-token',
  authenticateUser,
  async (req, res) => {
    try {
      const result = await SecureAuthController.verifyToken(req, res);
      return result;
    } catch (error) {
      logger.error('Verify token route error', {
        error: error.message,
        userId: req.user?.userId
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route DELETE /api/auth/account
 * @desc Deactivate user account
 * @access Private
 */
router.delete('/account',
  authenticateUser,
  rateLimitMiddleware('delete'),
  async (req, res) => {
    try {
      const result = await SecureAuthController.deactivateAccount(req, res);
      return result;
    } catch (error) {
      logger.error('Deactivate account route error', {
        error: error.message,
        userId: req.user?.userId
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route GET /api/auth/activity-logs
 * @desc Get user activity logs
 * @access Private
 */
router.get('/activity-logs',
  authenticateUser,
  async (req, res) => {
    try {
      const result = await SecureAuthController.getActivityLogs(req, res);
      return result;
    } catch (error) {
      logger.error('Get activity logs route error', {
        error: error.message,
        userId: req.user?.userId
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/resend-verification
 * @desc Resend email verification OTP
 * @access Public
 */
router.post('/resend-verification',
  rateLimitMiddleware('resend'),

  async (req, res) => {
    try {
      const result = await SecureAuthController.resendVerification(req, res);
      return result;
    } catch (error) {
      logger.error('Resend verification route error', {
        error: error.message,
        email: req.body?.email
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/unlock-account
 * @desc Unlock user account (admin only)
 * @access Private (Admin)
 */
router.post('/unlock-account',
  authenticateUser,
  rateLimitMiddleware('admin'),

  async (req, res) => {
    try {
      // Check if user has admin role
      if (!req.user.roles.includes('admin')) {
        return SecureErrorHandler.sendError(res, 'Insufficient permissions', 403);
      }
      
      const result = await SecureAuthController.unlockAccount(req, res);
      return result;
    } catch (error) {
      logger.error('Unlock account route error', {
        error: error.message,
        adminUserId: req.user?.userId,
        targetEmail: req.body?.email
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * @route POST /api/auth/security-log
 * @desc Ingest security event logs from mobile clients for monitoring
 * @access Public (rate-limited)
 */
router.post('/security-log',
  rateLimitMiddleware('security-log'),
  async (req, res) => {
    try {
      const { event, timestamp, data } = req.body || {};

      if (!event || typeof event !== 'string') {
        return SecureErrorHandler.sendError(res, 'Invalid security event payload: missing "event"', 400);
      }

      // Normalize event type for internal metrics while preserving original
      const normalizedEvent = String(event).replace(/[-\s]+/g, '_').toUpperCase();

      // Extract request context
      const ip = (req.headers['x-forwarded-for']?.toString().split(',')[0] || req.ip || '').trim();
      const userAgent = req.headers['user-agent'];

      const details = {
        ...((typeof data === 'object' && data) || {}),
        originalEvent: event,
        timestamp: timestamp || new Date().toISOString(),
        ip,
        userAgent,
      };

      // Record the security event
      securityMonitor.recordSecurityEvent(normalizedEvent, details);

      logger.security('Security log ingested', {
        event: normalizedEvent,
        ip,
        hasData: !!data,
      });

      return res.status(200).json({
        success: true,
        message: 'Security log recorded',
      });
    } catch (error) {
      logger.error('Security log ingestion error', {
        error: error.message,
        body: req.body,
      });
      return SecureErrorHandler.handleError(error, res);
    }
  }
);

/**
 * Health check endpoint
 */
router.get('/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    service: 'Authentication Service',
    timestamp: new Date().toISOString()
  });
});

// Error handling middleware for this router
router.use((error, req, res, next) => {
  logger.error('Auth router error', {
    error: error.message,
    stack: error.stack,
    path: req.path,
    method: req.method
  });
  
  return SecureErrorHandler.handleError(error, res);
});

module.exports = router;