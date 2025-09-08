/**
 * Error handling middleware
 * Centralizes error processing and response formatting
 */

/**
 * Global error handler middleware
 * Should be placed at the end of middleware stack
 */
function errorHandler(err, req, res, next) {
  console.error('Error occurred:', {
    message: err.message,
    stack: err.stack,
    url: req.originalUrl,
    method: req.method,
    body: req.body,
    timestamp: new Date().toISOString()
  });
  
  // Default error response
  let statusCode = 500;
  let message = 'Internal server error';
  let details = null;
  
  // Handle specific error types
  if (err.name === 'ValidationError') {
    statusCode = 400;
    message = 'Validation error';
    details = err.details || err.message;
  } else if (err.name === 'MongoError' || err.name === 'MongoServerError') {
    statusCode = 500;
    message = 'Database error';
    
    // Handle duplicate key errors
    if (err.code === 11000) {
      statusCode = 409;
      message = 'Duplicate entry';
      details = 'A record with this information already exists';
    }
  } else if (err.name === 'CastError') {
    statusCode = 400;
    message = 'Invalid ID format';
  } else if (err.name === 'JsonWebTokenError') {
    statusCode = 401;
    message = 'Invalid token';
  } else if (err.name === 'TokenExpiredError') {
    statusCode = 401;
    message = 'Token expired';
  } else if (err.statusCode || err.status) {
    statusCode = err.statusCode || err.status;
    message = err.message;
  }
  
  // Don't expose internal error details in production
  if (process.env.NODE_ENV === 'production') {
    if (statusCode === 500) {
      message = 'Internal server error';
      details = null;
    }
  } else {
    // In development, include stack trace
    details = details || err.stack;
  }
  
  res.status(statusCode).json({
    success: false,
    message: message,
    ...(details && { details: details }),
    timestamp: new Date().toISOString()
  });
}

/**
 * 404 Not Found handler
 * Should be placed before the error handler
 */
function notFoundHandler(req, res, next) {
  const error = new Error(`Route not found: ${req.method} ${req.originalUrl}`);
  error.statusCode = 404;
  next(error);
}

/**
 * Async error wrapper
 * Wraps async route handlers to catch errors automatically
 */
function asyncHandler(fn) {
  return (req, res, next) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
}

/**
 * Custom error class for application-specific errors
 */
class AppError extends Error {
  constructor(message, statusCode = 500, details = null) {
    super(message);
    this.statusCode = statusCode;
    this.details = details;
    this.name = 'AppError';
    
    Error.captureStackTrace(this, this.constructor);
  }
}

/**
 * Validation error helper
 */
function createValidationError(message, details = null) {
  const error = new AppError(message, 400, details);
  error.name = 'ValidationError';
  return error;
}

/**
 * Database error helper
 */
function createDatabaseError(message, details = null) {
  const error = new AppError(message, 500, details);
  error.name = 'DatabaseError';
  return error;
}

/**
 * Authentication error helper
 */
function createAuthError(message = 'Authentication required') {
  return new AppError(message, 401);
}

/**
 * Authorization error helper
 */
function createAuthorizationError(message = 'Access denied') {
  return new AppError(message, 403);
}

/**
 * Not found error helper
 */
function createNotFoundError(message = 'Resource not found') {
  return new AppError(message, 404);
}

/**
 * Conflict error helper
 */
function createConflictError(message = 'Resource conflict') {
  return new AppError(message, 409);
}

/**
 * Rate limit error helper
 */
function createRateLimitError(message = 'Too many requests') {
  return new AppError(message, 429);
}

module.exports = {
  errorHandler,
  notFoundHandler,
  asyncHandler,
  AppError,
  createValidationError,
  createDatabaseError,
  createAuthError,
  createAuthorizationError,
  createNotFoundError,
  createConflictError,
  createRateLimitError
};