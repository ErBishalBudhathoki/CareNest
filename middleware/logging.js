const { v4: uuidv4 } = require('uuid');
const logger = require('../config/logger');

/**
 * Request and Response Logging Middleware
 * Logs all incoming requests and outgoing responses with timing information
 */
function loggingMiddleware(req, res, next) {
  const start = Date.now();
  const requestId = uuidv4().slice(0, 8);
  
  // Extract user information from request
  const userId = req.user?.userId || req.body?.userId || req.query?.userId || req.headers['x-user-id'];
  const organizationId = req.user?.organizationId || req.body?.organizationId || req.query?.organizationId || req.headers['x-organization-id'];
  
  // Log request
  logger.request(req, {
    requestId,
    userId,
    organizationId,
    headers: req.headers,
    query: req.query,
    body: req.body
  });
  
  // Capture the original methods
  const originalSend = res.send;
  const originalJson = res.json;
  const originalEnd = res.end;
  
  // Override send
  res.send = function(body) {
    const duration = Date.now() - start;
    const userId = req.user?.userId || req.body?.userId || req.query?.userId || req.headers['x-user-id'];
    const organizationId = req.user?.organizationId || req.body?.organizationId || req.query?.organizationId || req.headers['x-organization-id'];
    
    logger.response(req, res, duration, {
       requestId,
       userId,
       organizationId,
       body: body
     });
    return originalSend.apply(res, arguments);
  };
  
  // Override json
  res.json = function(body) {
    const duration = Date.now() - start;
    const userId = req.user?.userId || req.body?.userId || req.query?.userId || req.headers['x-user-id'];
    const organizationId = req.user?.organizationId || req.body?.organizationId || req.query?.organizationId || req.headers['x-organization-id'];
    
    logger.response(req, res, duration, {
       requestId,
       userId,
       organizationId,
       body: body
     });
    return originalJson.apply(res, arguments);
  };
  
  // Override end
  res.end = function(chunk) {
    const duration = Date.now() - start;
    const userId = req.user?.userId || req.body?.userId || req.query?.userId || req.headers['x-user-id'];
    const organizationId = req.user?.organizationId || req.body?.organizationId || req.query?.organizationId || req.headers['x-organization-id'];
    
    logger.response(req, res, duration, {
       requestId,
       userId,
       organizationId,
       body: chunk
     });
    return originalEnd.apply(res, arguments);
  };
  
  next();
}

/**
 * Silent logging middleware that logs at debug level only
 * Use this version when you want minimal logging
 */
function silentLoggingMiddleware(req, res, next) {
  const start = Date.now();
  const requestId = uuidv4().slice(0, 8);
  
  // Log request at debug level
  logger.debug('HTTP Request (Silent)', {
    requestId,
    method: req.method,
    url: req.originalUrl,
    query: req.query,
    bodyKeys: Object.keys(req.body)
  });
  
  // Capture the original methods
  const originalSend = res.send;
  const originalJson = res.json;
  const originalEnd = res.end;
  
  // Override send
  res.send = function(body) {
    const duration = Date.now() - start;
    logger.debug('HTTP Response (Silent)', {
      requestId,
      statusCode: res.statusCode,
      duration,
      hasBody: !!body
    });
    return originalSend.apply(res, arguments);
  };
  
  // Override json
  res.json = function(body) {
    const duration = Date.now() - start;
    logger.debug('HTTP Response (Silent)', {
      requestId,
      statusCode: res.statusCode,
      duration,
      hasBody: !!body
    });
    return originalJson.apply(res, arguments);
  };
  
  // Override end
  res.end = function(chunk) {
    const duration = Date.now() - start;
    logger.debug('HTTP Response (Silent)', {
      requestId,
      statusCode: res.statusCode,
      duration,
      hasBody: !!(chunk && typeof chunk !== 'function')
    });
    return originalEnd.apply(res, arguments);
  };
  
  next();
}

module.exports = {
  loggingMiddleware,
  silentLoggingMiddleware
};