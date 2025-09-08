const cors = require('cors');

/**
 * CORS middleware configuration
 */
const corsMiddleware = cors();

/**
 * Custom CORS headers middleware
 */
function customCorsHeaders(req, res, next) {
  res.header("Content-Type", "application/json");
  res.header("Access-Control-Allow-Origin", "*");
  next();
}

module.exports = {
  corsMiddleware,
  customCorsHeaders
};