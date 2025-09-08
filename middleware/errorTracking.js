/**
 * Enhanced Error Tracking Middleware
 * 
 * This middleware provides comprehensive error tracking including:
 * - Unhandled exceptions and stack traces
 * - Validation failures and input errors
 * - API endpoint specific error rates
 * - Error categorization and patterns
 */

const logger = require('../config/logger');

// Error tracking metrics
let errorMetrics = {
  totalErrors: 0,
  errorsByType: {},
  errorsByEndpoint: {},
  errorsByStatusCode: {},
  validationErrors: 0,
  serverErrors: 0,
  clientErrors: 0
};

/**
 * Enhanced error tracking middleware
 */
const errorTrackingMiddleware = (err, req, res, next) => {
  const errorId = Math.random().toString(36).substr(2, 9);
  const timestamp = new Date().toISOString();
  
  // Increment error counters
  errorMetrics.totalErrors++;
  
  // Categorize error by type
  const errorType = err.constructor.name || 'UnknownError';
  errorMetrics.errorsByType[errorType] = (errorMetrics.errorsByType[errorType] || 0) + 1;
  
  // Categorize error by endpoint
  const endpoint = `${req.method} ${req.route?.path || req.path}`;
  errorMetrics.errorsByEndpoint[endpoint] = (errorMetrics.errorsByEndpoint[endpoint] || 0) + 1;
  
  // Determine status code
  const statusCode = err.statusCode || err.status || 500;
  errorMetrics.errorsByStatusCode[statusCode] = (errorMetrics.errorsByStatusCode[statusCode] || 0) + 1;
  
  // Categorize by error class
  if (statusCode >= 400 && statusCode < 500) {
    errorMetrics.clientErrors++;
  } else if (statusCode >= 500) {
    errorMetrics.serverErrors++;
  }
  
  // Check for validation errors
  const isValidationError = err.name === 'ValidationError' || 
                           err.message.includes('validation') ||
                           err.message.includes('required') ||
                           err.message.includes('invalid') ||
                           statusCode === 400;
  
  if (isValidationError) {
    errorMetrics.validationErrors++;
  }
  
  // Extract stack trace information
  const stackTrace = err.stack ? err.stack.split('\n') : [];
  const errorLocation = stackTrace.length > 1 ? stackTrace[1].trim() : 'Unknown';
  
  // Log comprehensive error details
  logger.business('Application Error', {
    event: 'application_error',
    errorId: errorId,
    error: {
      message: err.message,
      name: err.name,
      type: errorType,
      statusCode: statusCode,
      code: err.code,
      location: errorLocation,
      stack: stackTrace.slice(0, 10) // Limit stack trace length
    },
    request: {
      method: req.method,
      url: req.url,
      path: req.path,
      route: req.route?.path,
      params: req.params,
      query: req.query,
      headers: {
        userAgent: req.get('User-Agent'),
        contentType: req.get('Content-Type'),
        authorization: req.get('Authorization') ? 'Present' : 'Missing'
      },
      ip: req.ip,
      body: req.body ? Object.keys(req.body) : [] // Only log keys, not values for security
    },
    errorCategory: {
      isValidationError: isValidationError,
      isAuthenticationError: statusCode === 401 || err.message.includes('auth'),
      isAuthorizationError: statusCode === 403,
      isNotFoundError: statusCode === 404,
      isServerError: statusCode >= 500,
      isClientError: statusCode >= 400 && statusCode < 500,
      isDatabaseError: err.message.includes('mongo') || err.message.includes('database'),
      isNetworkError: err.message.includes('network') || err.message.includes('timeout'),
      isFileSystemError: err.message.includes('ENOENT') || err.message.includes('file')
    },
    patterns: {
      hasStackTrace: !!err.stack,
      isRecurringError: (errorMetrics.errorsByType[errorType] || 0) > 5,
      isEndpointSpecific: (errorMetrics.errorsByEndpoint[endpoint] || 0) > 3,
      errorFrequency: {
        thisErrorType: errorMetrics.errorsByType[errorType] || 0,
        thisEndpoint: errorMetrics.errorsByEndpoint[endpoint] || 0,
        thisStatusCode: errorMetrics.errorsByStatusCode[statusCode] || 0
      }
    },
    metrics: {
      totalErrors: errorMetrics.totalErrors,
      validationErrors: errorMetrics.validationErrors,
      serverErrors: errorMetrics.serverErrors,
      clientErrors: errorMetrics.clientErrors,
      errorRate: {
        validation: (errorMetrics.validationErrors / errorMetrics.totalErrors * 100).toFixed(2),
        server: (errorMetrics.serverErrors / errorMetrics.totalErrors * 100).toFixed(2),
        client: (errorMetrics.clientErrors / errorMetrics.totalErrors * 100).toFixed(2)
      }
    },
    timestamp: timestamp
  });
  
  // Log critical errors separately
  if (statusCode >= 500) {
    logger.business('Critical Server Error', {
      event: 'critical_server_error',
      errorId: errorId,
      severity: 'HIGH',
      error: {
        message: err.message,
        type: errorType,
        statusCode: statusCode,
        stack: stackTrace.slice(0, 5)
      },
      endpoint: endpoint,
      timestamp: timestamp
    });
  }
  
  // Set response status and send error response
  res.status(statusCode);
  
  // Don't expose internal errors in production
  const isDevelopment = process.env.NODE_ENV === 'development';
  
  const errorResponse = {
    statusCode: statusCode,
    message: isDevelopment ? err.message : getGenericErrorMessage(statusCode),
    errorId: errorId,
    timestamp: timestamp
  };
  
  if (isDevelopment && err.stack) {
    errorResponse.stack = err.stack;
  }
  
  res.json(errorResponse);
};

/**
 * Get generic error message based on status code
 */
const getGenericErrorMessage = (statusCode) => {
  switch (statusCode) {
    case 400:
      return 'Bad Request';
    case 401:
      return 'Unauthorized';
    case 403:
      return 'Forbidden';
    case 404:
      return 'Not Found';
    case 422:
      return 'Validation Error';
    case 429:
      return 'Too Many Requests';
    case 500:
      return 'Internal Server Error';
    case 502:
      return 'Bad Gateway';
    case 503:
      return 'Service Unavailable';
    default:
      return 'An error occurred';
  }
};

/**
 * Validation error handler
 */
const handleValidationError = (req, res, validationErrors) => {
  const errorId = Math.random().toString(36).substr(2, 9);
  
  errorMetrics.totalErrors++;
  errorMetrics.validationErrors++;
  errorMetrics.clientErrors++;
  
  const endpoint = `${req.method} ${req.route?.path || req.path}`;
  errorMetrics.errorsByEndpoint[endpoint] = (errorMetrics.errorsByEndpoint[endpoint] || 0) + 1;
  errorMetrics.errorsByStatusCode[400] = (errorMetrics.errorsByStatusCode[400] || 0) + 1;
  
  logger.business('Validation Error', {
    event: 'validation_error',
    errorId: errorId,
    validationErrors: validationErrors,
    request: {
      method: req.method,
      url: req.url,
      path: req.path,
      body: req.body ? Object.keys(req.body) : [],
      params: req.params,
      query: req.query
    },
    patterns: {
      fieldCount: Array.isArray(validationErrors) ? validationErrors.length : Object.keys(validationErrors || {}).length,
      hasRequiredFieldErrors: JSON.stringify(validationErrors).includes('required'),
      hasFormatErrors: JSON.stringify(validationErrors).includes('format') || JSON.stringify(validationErrors).includes('invalid'),
      hasLengthErrors: JSON.stringify(validationErrors).includes('length') || JSON.stringify(validationErrors).includes('min') || JSON.stringify(validationErrors).includes('max')
    },
    metrics: {
      totalValidationErrors: errorMetrics.validationErrors,
      endpointValidationErrors: errorMetrics.errorsByEndpoint[endpoint] || 0
    },
    timestamp: new Date().toISOString()
  });
  
  res.status(400).json({
    statusCode: 400,
    message: 'Validation Error',
    errors: validationErrors,
    errorId: errorId,
    timestamp: new Date().toISOString()
  });
};

/**
 * Get error metrics summary
 */
const getErrorMetrics = () => {
  return {
    ...errorMetrics,
    topErrorTypes: Object.entries(errorMetrics.errorsByType)
      .sort(([,a], [,b]) => b - a)
      .slice(0, 10),
    topErrorEndpoints: Object.entries(errorMetrics.errorsByEndpoint)
      .sort(([,a], [,b]) => b - a)
      .slice(0, 10),
    timestamp: new Date().toISOString()
  };
};

/**
 * Log periodic error metrics
 */
const logPeriodicErrorMetrics = () => {
  if (errorMetrics.totalErrors > 0) {
    logger.business('Error Metrics Summary', {
      event: 'error_metrics_summary',
      ...getErrorMetrics(),
      alerts: {
        highErrorRate: errorMetrics.totalErrors > 100,
        highValidationErrorRate: (errorMetrics.validationErrors / errorMetrics.totalErrors) > 0.3,
        highServerErrorRate: (errorMetrics.serverErrors / errorMetrics.totalErrors) > 0.1
      }
    });
  }
};

// Log error metrics every 10 minutes
setInterval(logPeriodicErrorMetrics, 10 * 60 * 1000);

module.exports = {
  errorTrackingMiddleware,
  handleValidationError,
  getErrorMetrics,
  logPeriodicErrorMetrics
};