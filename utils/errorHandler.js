const { createLogger } = require('./logger');
const logger = createLogger('ErrorHandler');

/**
 * Secure error handler that prevents sensitive information disclosure
 * Provides generic error messages while maintaining detailed logging
 */
class SecureErrorHandler {
  // Generic error messages that don't expose internal details
  static GENERIC_AUTH_ERROR = 'Authentication failed. Please check your credentials and try again.';
  static GENERIC_NETWORK_ERROR = 'Network error. Please check your connection and try again.';
  static GENERIC_SERVER_ERROR = 'Service temporarily unavailable. Please try again later.';
  static GENERIC_VALIDATION_ERROR = 'Please check your input and try again.';
  static GENERIC_RATE_LIMIT_ERROR = 'Too many requests. Please try again later.';
  static GENERIC_FORBIDDEN_ERROR = 'Access denied. Please contact support if you believe this is an error.';

  /**
   * Sanitizes error messages to prevent information disclosure
   * @param {Error} error - The original error
   * @param {string} context - Context where error occurred
   * @returns {Object} Sanitized error response
   */
  static sanitizeError(error, context = 'Unknown') {
    // Log the actual error for debugging (server-side only)
    logger.error(`Error in ${context}:`, {
      message: error.message,
      stack: error.stack,
      code: error.code,
      timestamp: new Date().toISOString()
    });

    // Determine appropriate generic message based on error type
    let genericMessage = this.GENERIC_SERVER_ERROR;
    let statusCode = 500;

    if (error.name === 'ValidationError' || error.code === 'VALIDATION_ERROR') {
      genericMessage = this.GENERIC_VALIDATION_ERROR;
      statusCode = 400;
    } else if (error.name === 'UnauthorizedError' || error.code === 'UNAUTHORIZED') {
      genericMessage = this.GENERIC_AUTH_ERROR;
      statusCode = 401;
    } else if (error.name === 'ForbiddenError' || error.code === 'FORBIDDEN') {
      genericMessage = this.GENERIC_FORBIDDEN_ERROR;
      statusCode = 403;
    } else if (error.code === 'RATE_LIMIT_EXCEEDED') {
      genericMessage = this.GENERIC_RATE_LIMIT_ERROR;
      statusCode = 429;
    }

    return {
      success: false,
      message: genericMessage,
      statusCode,
      timestamp: new Date().toISOString(),
      // Never include sensitive details in production
      ...(process.env.NODE_ENV === 'development' && {
        debug: {
          originalMessage: error.message,
          errorCode: error.code
        }
      })
    };
  }

  /**
   * Express error handling middleware
   * @param {Error} err - Error object
   * @param {Object} req - Express request object
   * @param {Object} res - Express response object
   * @param {Function} next - Express next function
   */
  static errorHandler(err, req, res, next) {
    const sanitizedError = this.sanitizeError(err, `${req.method} ${req.path}`);
    
    // Log request context for debugging
    logger.error('Request context:', {
      method: req.method,
      path: req.path,
      userAgent: req.get('User-Agent'),
      ip: req.ip,
      timestamp: new Date().toISOString()
    });

    res.status(sanitizedError.statusCode).json(sanitizedError);
  }

  /**
   * Sanitizes user input to prevent XSS and injection attacks
   * @param {string} input - User input to sanitize
   * @returns {string} Sanitized input
   */
  static sanitizeInput(input) {
    if (typeof input !== 'string') {
      return input;
    }

    return input
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#x27;')
      .replace(/\//g, '&#x2F;')
      .replace(/\\/g, '&#x5C;')
      .replace(/\s+/g, ' ')
      .trim();
  }

  /**
   * Creates a standardized success response
   * @param {*} data - Response data
   * @param {string} message - Success message
   * @returns {Object} Standardized success response
   */
  static createSuccessResponse(data, message = 'Operation completed successfully') {
    return {
      success: true,
      message,
      data,
      timestamp: new Date().toISOString()
    };
  }

  /**
   * Creates a standardized error response
   * @param {string} message - Error message
   * @param {number} statusCode - HTTP status code
   * @param {string} code - Error code
   * @returns {Object} Standardized error response
   */
  static createErrorResponse(message, statusCode = 500, code = 'INTERNAL_ERROR') {
    return {
      success: false,
      message,
      statusCode,
      code,
      timestamp: new Date().toISOString()
    };
  }
}

module.exports = SecureErrorHandler;