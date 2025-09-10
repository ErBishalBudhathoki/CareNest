const jwt = require('jsonwebtoken');
let rateLimit;
try {
  // Use express-rate-limit if available
  // eslint-disable-next-line global-require
  rateLimit = require('express-rate-limit');
} catch (e) {
  // Fallback no-op limiter to avoid runtime crashes if dependency isn't installed
  rateLimit = function () {
    return (req, res, next) => next();
  };
}
const { createLogger } = require('../utils/logger');
const SecureErrorHandler = require('../utils/errorHandler');
const InputValidator = require('../utils/inputValidator');
const { securityMonitor } = require('../utils/securityMonitor');

const logger = createLogger('AuthMiddleware');

/**
 * Secure authentication middleware with comprehensive security features
 * Provides JWT token validation, rate limiting, and security logging
 */
class AuthMiddleware {
  // Rate limiting store for failed authentication attempts
  static failedAttempts = new Map();
  static blockedIPs = new Map();

  /**
   * Main authentication middleware
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   * @param {Function} next - Express next function
   */
  static async authenticateUser(req, res, next) {
    try {
      // Check if IP is blocked
      if (AuthMiddleware.isIPBlocked(req.ip)) {
        logger.security('Blocked IP attempted access', { ip: req.ip, path: req.path });
        return res.status(429).json(
          SecureErrorHandler.createErrorResponse(
            'Too many failed attempts. Access temporarily blocked.',
            429,
            'IP_BLOCKED'
          )
        );
      }

      // Extract token from Authorization header
      const authHeader = req.headers.authorization;
      if (!authHeader || !authHeader.startsWith('Bearer ')) {
        AuthMiddleware.recordFailedAttempt(req.ip);
        logger.security('Missing or invalid authorization header', { 
          ip: req.ip, 
          path: req.path,
          userAgent: req.get('User-Agent')
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            401,
            'MISSING_TOKEN'
          )
        );
      }

      const token = authHeader.substring(7); // Remove 'Bearer ' prefix

      // Validate token format
      if (!token || typeof token !== 'string' || token.length > 1000) {
        AuthMiddleware.recordFailedAttempt(req.ip);
        logger.security('Invalid token format', { ip: req.ip, path: req.path });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            401,
            'INVALID_TOKEN_FORMAT'
          )
        );
      }

      // Verify JWT token using the same private key as login endpoint
      const privateKey = process.env.JWT_SECRET || process.env.PRIVATE_KEY;
      if (!privateKey) {
        logger.error('JWT secret not configured');
        return res.status(500).json(
          SecureErrorHandler.createErrorResponse(
            'Server configuration error. Please contact administrator.',
            500,
            'MISSING_JWT_SECRET'
          )
        );
      }
      const decoded = jwt.verify(token, privateKey, {
        issuer: 'invoice-app',
        audience: 'invoice-app-users'
      });

      // Validate decoded token structure
      if (!decoded.userId || !decoded.email) {
        AuthMiddleware.recordFailedAttempt(req.ip);
        logger.security('Invalid token payload', { 
          ip: req.ip, 
          path: req.path,
          tokenPayload: { userId: decoded.userId, email: decoded.email }
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            401,
            'INVALID_TOKEN_PAYLOAD'
          )
        );
      }

      // Validate user ID format
      const userIdValidation = InputValidator.validateObjectId(decoded.userId);
      if (!userIdValidation.isValid) {
        AuthMiddleware.recordFailedAttempt(req.ip);
        logger.security('Invalid user ID in token', { 
          ip: req.ip, 
          path: req.path,
          userId: decoded.userId
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            401,
            'INVALID_USER_ID'
          )
        );
      }

      // Validate email format
      const emailValidation = InputValidator.validateEmail(decoded.email);
      if (!emailValidation.isValid) {
        AuthMiddleware.recordFailedAttempt(req.ip);
        logger.security('Invalid email in token', { 
          ip: req.ip, 
          path: req.path,
          email: decoded.email
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            401,
            'INVALID_EMAIL'
          )
        );
      }

      // Check token expiration (additional check)
      if (decoded.exp && decoded.exp < Math.floor(Date.now() / 1000)) {
        AuthMiddleware.recordFailedAttempt(req.ip);
        logger.security('Expired token used', { 
          ip: req.ip, 
          path: req.path,
          userId: decoded.userId,
          expiredAt: new Date(decoded.exp * 1000)
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            'Session expired. Please log in again.',
            401,
            'TOKEN_EXPIRED'
          )
        );
      }

      // Reset failed attempts on successful authentication
      AuthMiddleware.resetFailedAttempts(req.ip);

      // Add user info to request object
      req.user = {
        userId: userIdValidation.sanitized,
        email: emailValidation.sanitized,
        roles: decoded.roles || ['user'],
        organizationId: decoded.organizationId,
        iat: decoded.iat,
        exp: decoded.exp
      };

      // Log successful authentication
      logger.info('User authenticated successfully', {
        userId: req.user.userId,
        email: req.user.email,
        ip: req.ip,
        path: req.path,
        userAgent: req.get('User-Agent')
      });

      next();
    } catch (error) {
      AuthMiddleware.recordFailedAttempt(req.ip);
      
      if (error.name === 'JsonWebTokenError') {
        logger.security('Invalid JWT token', { 
          ip: req.ip, 
          path: req.path,
          error: error.message
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            'Authentication failed. Please log in again.',
            401,
            'INVALID_TOKEN'
          )
        );
      }

      if (error.name === 'TokenExpiredError') {
        logger.security('Expired JWT token', { 
          ip: req.ip, 
          path: req.path,
          expiredAt: error.expiredAt
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            'Session expired. Please log in again.',
            401,
            'TOKEN_EXPIRED'
          )
        );
      }
      
      if (error.name === 'NotBeforeError') {
        logger.security('Token not yet valid', { 
          ip: req.ip, 
          path: req.path,
          date: error.date
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            'Authentication token not yet valid.',
            401,
            'TOKEN_NOT_ACTIVE'
          )
        );
      }
      
      if (error.name === 'InvalidAudienceError' || error.name === 'InvalidIssuerError') {
        logger.security('Token validation error', { 
          ip: req.ip, 
          path: req.path,
          error: error.message
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid authentication token.',
            401,
            'TOKEN_VALIDATION_ERROR'
          )
        );
      }

      logger.error('Authentication error', {
        error: error.message,
        stack: error.stack,
        ip: req.ip,
        path: req.path
      });

      return res.status(500).json(
        SecureErrorHandler.createErrorResponse(
          'An error occurred during authentication. Please try again.',
          500,
          'AUTH_ERROR'
        )
      );
    }
  }

  /**
   * Role-based authorization middleware
   * @param {Array} allowedRoles - Array of allowed roles
   * @returns {Function} Express middleware function
   */
  static requireRoles(allowedRoles = []) {
    return (req, res, next) => {
      if (!req.user) {
        logger.security('Authorization check without authentication', { 
          ip: req.ip, 
          path: req.path 
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            401,
            'NOT_AUTHENTICATED'
          )
        );
      }

      const userRoles = req.user.roles || [];
      const hasRequiredRole = allowedRoles.some(role => userRoles.includes(role));

      if (!hasRequiredRole) {
        logger.security('Insufficient permissions', {
          userId: req.user.userId,
          userRoles,
          requiredRoles: allowedRoles,
          ip: req.ip,
          path: req.path
        });
        return res.status(403).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_FORBIDDEN_ERROR,
            403,
            'INSUFFICIENT_PERMISSIONS'
          )
        );
      }

      next();
    };
  }

  /**
   * Records failed authentication attempts for rate limiting
   * @param {string} ip - IP address
   */
  static recordFailedAttempt(ip) {
    const now = Date.now();
    const windowMs = 15 * 60 * 1000; // 15 minutes
    const maxAttempts = 5;

    if (!AuthMiddleware.failedAttempts.has(ip)) {
      AuthMiddleware.failedAttempts.set(ip, []);
    }

    const attempts = AuthMiddleware.failedAttempts.get(ip);
    
    // Remove attempts older than the window
    const recentAttempts = attempts.filter(timestamp => now - timestamp < windowMs);
    recentAttempts.push(now);
    
    AuthMiddleware.failedAttempts.set(ip, recentAttempts);

    // Block IP if too many attempts
    if (recentAttempts.length >= maxAttempts) {
      const blockDuration = 60 * 60 * 1000; // 1 hour
      AuthMiddleware.blockedIPs.set(ip, now + blockDuration);
      
      // Keep security monitor in sync for visibility and unified management
      try {
        securityMonitor.blockIP(ip, 'Too many failed authentication attempts', blockDuration);
      } catch (e) {
        logger.warn('Failed to sync block with securityMonitor', { error: e.message });
      }
      
      logger.security('IP blocked due to failed attempts', {
        ip,
        attemptCount: recentAttempts.length,
        blockDuration: blockDuration / 1000 / 60 + ' minutes'
      });
    }
  }

  /**
   * Resets failed attempts for an IP
   * @param {string} ip - IP address
   */
  static resetFailedAttempts(ip) {
    AuthMiddleware.failedAttempts.delete(ip);
    AuthMiddleware.blockedIPs.delete(ip);
  }

  /**
   * Checks if an IP is currently blocked
   * @param {string} ip - IP address
   * @returns {boolean} True if IP is blocked
   */
  static isIPBlocked(ip) {
    const blockExpiry = AuthMiddleware.blockedIPs.get(ip);
    if (!blockExpiry) return false;

    if (Date.now() > blockExpiry) {
      AuthMiddleware.blockedIPs.delete(ip);
      return false;
    }

    return true;
  }

  /**
   * Cleanup expired blocks and failed attempts
   */
  static cleanup() {
    const now = Date.now();
    const windowMs = 15 * 60 * 1000; // 15 minutes

    // Clean up expired blocks
    for (const [ip, blockExpiry] of AuthMiddleware.blockedIPs.entries()) {
      if (now > blockExpiry) {
        AuthMiddleware.blockedIPs.delete(ip);
      }
    }

    // Clean up old failed attempts
    for (const [ip, attempts] of AuthMiddleware.failedAttempts.entries()) {
      const recentAttempts = attempts.filter(timestamp => now - timestamp < windowMs);
      if (recentAttempts.length === 0) {
        AuthMiddleware.failedAttempts.delete(ip);
      } else {
        AuthMiddleware.failedAttempts.set(ip, recentAttempts);
      }
    }
  }

  /**
   * Optional middleware for API key authentication
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   * @param {Function} next - Express next function
   */
  static authenticateAPIKey(req, res, next) {
    const apiKey = req.headers['x-api-key'];
    
    if (!apiKey) {
      logger.security('Missing API key', { ip: req.ip, path: req.path });
      return res.status(401).json(
        SecureErrorHandler.createErrorResponse(
          'API key required',
          401,
          'MISSING_API_KEY'
        )
      );
    }

    // Validate API key format and check against allowed keys
    const validAPIKeys = (process.env.VALID_API_KEYS || '').split(',');
    
    if (!validAPIKeys.includes(apiKey)) {
      AuthMiddleware.recordFailedAttempt(req.ip);
      logger.security('Invalid API key', { ip: req.ip, path: req.path });
      return res.status(401).json(
        SecureErrorHandler.createErrorResponse(
          'Invalid API key',
          401,
          'INVALID_API_KEY'
        )
      );
    }

    next();
  }

  // Admin helper methods for visibility and control
  static getBlockedIPsAdmin() {
    return Array.from(AuthMiddleware.blockedIPs.entries()).map(([ip, expiresAt]) => ({
      ip,
      expiresAt: new Date(expiresAt).toISOString()
    }));
  }

  static unblockIPAdmin(ip) {
    return AuthMiddleware.blockedIPs.delete(ip);
  }

  static getFailedAttemptsSnapshot() {
    const snapshot = [];
    for (const [ip, attempts] of AuthMiddleware.failedAttempts.entries()) {
      snapshot.push({
        ip,
        attempts: attempts.length,
        lastAttemptAt: attempts.length ? new Date(attempts[attempts.length - 1]).toISOString() : null
      });
    }
    return snapshot;
  }
}

// Cleanup expired records every 5 minutes
setInterval(() => {
  AuthMiddleware.cleanup();
}, 5 * 60 * 1000);

/**
 * Rate limiting middleware factory
 * Creates rate limiters for different endpoints with specific error codes
 */
// Centralized rate limit configurations
const RATE_LIMIT_CONFIGS = {
  login: { windowMs: 15 * 60 * 1000, max: 5, message: 'Too many login attempts' },
  register: { windowMs: 60 * 60 * 1000, max: 3, message: 'Too many registration attempts' },
  verify: { windowMs: 15 * 60 * 1000, max: 3, message: 'Too many verification attempts' },
  forgot: { windowMs: 15 * 60 * 1000, max: 3, message: 'Too many password reset requests' },
  reset: { windowMs: 15 * 60 * 1000, max: 3, message: 'Too many password reset attempts' },
  update: { windowMs: 15 * 60 * 1000, max: 10, message: 'Too many update requests' },
  'change-password': { windowMs: 15 * 60 * 1000, max: 3, message: 'Too many password change attempts' },
  refresh: { windowMs: 15 * 60 * 1000, max: 10, message: 'Too many token refresh requests' },
  delete: { windowMs: 60 * 60 * 1000, max: 2, message: 'Too many account deletion attempts' },
  resend: { windowMs: 15 * 60 * 1000, max: 3, message: 'Too many resend requests' },
  admin: { windowMs: 15 * 60 * 1000, max: 20, message: 'Too many admin requests' },
  default: { windowMs: 15 * 60 * 1000, max: 10, message: 'Too many requests' }
};

function rateLimitMiddleware(type) {
  const configs = RATE_LIMIT_CONFIGS;

  const config = configs[type] || configs.default;

  return rateLimit({
    windowMs: config.windowMs,
    max: config.max,
    message: {
      success: false,
      message: config.message,
      errorCode: 'RATE_LIMIT_EXCEEDED',
      timestamp: new Date().toISOString()
    },
    standardHeaders: true,
    legacyHeaders: false,
    handler: (req, res) => {
      logger.security('Rate limit exceeded', {
        ip: req.ip,
        path: req.path,
        type: type,
        userAgent: req.get('User-Agent')
      });
      
      // Record in securityMonitor for centralized visibility and history (if available)
      if (typeof securityMonitor !== 'undefined' && securityMonitor && typeof securityMonitor.recordRateLimitViolation === 'function') {
        try {
          securityMonitor.recordRateLimitViolation({
            ip: req.ip,
            endpoint: req.path,
            attempts: req.rateLimit && (req.rateLimit.current || req.rateLimit.requestCount),
            limit: req.rateLimit && (req.rateLimit.limit || config.max)
          });
        } catch (e) {
          logger.warn('Failed to record rate limit violation in securityMonitor', { error: e.message });
        }
      }
      
      res.status(429).json({
        success: false,
        message: config.message,
        errorCode: 'RATE_LIMIT_EXCEEDED',
        timestamp: new Date().toISOString()
      });
    }
  });
}

module.exports = {
  authenticateUser: AuthMiddleware.authenticateUser,
  requireRoles: AuthMiddleware.requireRoles,
  authenticateAPIKey: AuthMiddleware.authenticateAPIKey,
  rateLimitMiddleware,
  rateLimit: rateLimitMiddleware,
  // admin helpers
  getAuthBlockedIPs: AuthMiddleware.getBlockedIPsAdmin,
  unblockAuthIP: AuthMiddleware.unblockIPAdmin,
  getFailedAttemptsSnapshot: AuthMiddleware.getFailedAttemptsSnapshot,
  getRateLimitConfigs: () => {
    const sanitized = {};
    for (const [key, cfg] of Object.entries(RATE_LIMIT_CONFIGS)) {
      sanitized[key] = { windowMs: cfg.windowMs, max: cfg.max };
    }
    return sanitized;
  }
};