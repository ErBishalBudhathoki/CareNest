/**
 * System Health Monitoring Middleware
 * 
 * This middleware tracks system performance metrics including:
 * - Memory usage
 * - CPU utilization
 * - Request/response timing
 * - Network latency
 */

const logger = require('../config/logger');
const os = require('os');
const process = require('process');

// Track system metrics
let systemMetrics = {
  startTime: Date.now(),
  requestCount: 0,
  errorCount: 0,
  totalResponseTime: 0
};

/**
 * System health monitoring middleware
 */
const systemHealthMiddleware = (req, res, next) => {
  const startTime = Date.now();
  const requestId = Math.random().toString(36).substr(2, 9);
  
  // Increment request counter
  systemMetrics.requestCount++;
  
  // Get memory usage
  const memoryUsage = process.memoryUsage();
  
  // Get CPU usage
  const cpuUsage = process.cpuUsage();
  
  // Get system load
  const loadAverage = os.loadavg();
  
  // Log request start
  logger.business('Request Started', {
    event: 'request_started',
    requestId: requestId,
    method: req.method,
    url: req.url,
    userAgent: req.get('User-Agent'),
    ip: req.ip,
    timestamp: new Date().toISOString()
  });
  
  // Override res.end to capture response metrics
  const originalEnd = res.end;
  res.end = function(chunk, encoding) {
    const endTime = Date.now();
    const responseTime = endTime - startTime;
    
    // Update system metrics
    systemMetrics.totalResponseTime += responseTime;
    
    if (res.statusCode >= 400) {
      systemMetrics.errorCount++;
    }
    
    // Get updated memory usage
    const endMemoryUsage = process.memoryUsage();
    
    // Calculate memory delta
    const memoryDelta = {
      rss: endMemoryUsage.rss - memoryUsage.rss,
      heapUsed: endMemoryUsage.heapUsed - memoryUsage.heapUsed,
      heapTotal: endMemoryUsage.heapTotal - memoryUsage.heapTotal,
      external: endMemoryUsage.external - memoryUsage.external
    };
    
    // Log comprehensive request metrics
    logger.business('Request Completed', {
      event: 'request_completed',
      requestId: requestId,
      request: {
        method: req.method,
        url: req.url,
        statusCode: res.statusCode,
        responseTime: responseTime
      },
      systemHealth: {
        memory: {
          rss: Math.round(endMemoryUsage.rss / 1024 / 1024), // MB
          heapUsed: Math.round(endMemoryUsage.heapUsed / 1024 / 1024), // MB
          heapTotal: Math.round(endMemoryUsage.heapTotal / 1024 / 1024), // MB
          external: Math.round(endMemoryUsage.external / 1024 / 1024), // MB
          delta: {
            rss: Math.round(memoryDelta.rss / 1024), // KB
            heapUsed: Math.round(memoryDelta.heapUsed / 1024), // KB
            heapTotal: Math.round(memoryDelta.heapTotal / 1024), // KB
            external: Math.round(memoryDelta.external / 1024) // KB
          }
        },
        cpu: {
          user: cpuUsage.user,
          system: cpuUsage.system
        },
        system: {
          loadAverage1m: loadAverage[0],
          loadAverage5m: loadAverage[1],
          loadAverage15m: loadAverage[2],
          uptime: os.uptime(),
          freeMemory: Math.round(os.freemem() / 1024 / 1024), // MB
          totalMemory: Math.round(os.totalmem() / 1024 / 1024) // MB
        }
      },
      performance: {
        isFast: responseTime < 100,
        isModerate: responseTime >= 100 && responseTime < 500,
        isSlow: responseTime >= 500,
        isError: res.statusCode >= 400,
        isServerError: res.statusCode >= 500
      },
      aggregateMetrics: {
        totalRequests: systemMetrics.requestCount,
        totalErrors: systemMetrics.errorCount,
        averageResponseTime: Math.round(systemMetrics.totalResponseTime / systemMetrics.requestCount),
        errorRate: (systemMetrics.errorCount / systemMetrics.requestCount * 100).toFixed(2),
        uptime: Math.round((Date.now() - systemMetrics.startTime) / 1000) // seconds
      },
      timestamp: new Date().toISOString()
    });
    
    // Call original end method
    originalEnd.call(this, chunk, encoding);
  };
  
  next();
};

/**
 * Get current system health snapshot
 */
const getSystemHealthSnapshot = () => {
  const memoryUsage = process.memoryUsage();
  const cpuUsage = process.cpuUsage();
  const loadAverage = os.loadavg();
  
  return {
    timestamp: new Date().toISOString(),
    memory: {
      rss: Math.round(memoryUsage.rss / 1024 / 1024), // MB
      heapUsed: Math.round(memoryUsage.heapUsed / 1024 / 1024), // MB
      heapTotal: Math.round(memoryUsage.heapTotal / 1024 / 1024), // MB
      external: Math.round(memoryUsage.external / 1024 / 1024), // MB
      arrayBuffers: Math.round(memoryUsage.arrayBuffers / 1024 / 1024) // MB
    },
    cpu: {
      user: cpuUsage.user,
      system: cpuUsage.system
    },
    system: {
      loadAverage1m: loadAverage[0],
      loadAverage5m: loadAverage[1],
      loadAverage15m: loadAverage[2],
      uptime: os.uptime(),
      freeMemory: Math.round(os.freemem() / 1024 / 1024), // MB
      totalMemory: Math.round(os.totalmem() / 1024 / 1024), // MB
      memoryUsagePercent: ((os.totalmem() - os.freemem()) / os.totalmem() * 100).toFixed(2)
    },
    application: {
      totalRequests: systemMetrics.requestCount,
      totalErrors: systemMetrics.errorCount,
      averageResponseTime: systemMetrics.requestCount > 0 ? Math.round(systemMetrics.totalResponseTime / systemMetrics.requestCount) : 0,
      errorRate: systemMetrics.requestCount > 0 ? (systemMetrics.errorCount / systemMetrics.requestCount * 100).toFixed(2) : 0,
      uptime: Math.round((Date.now() - systemMetrics.startTime) / 1000) // seconds
    }
  };
};

/**
 * Log periodic system health metrics
 */
const logPeriodicHealthMetrics = () => {
  const healthSnapshot = getSystemHealthSnapshot();
  
  logger.business('System Health Snapshot', {
    event: 'system_health_snapshot',
    ...healthSnapshot,
    alerts: {
      highMemoryUsage: parseFloat(healthSnapshot.system.memoryUsagePercent) > 80,
      highLoadAverage: healthSnapshot.system.loadAverage1m > os.cpus().length,
      highErrorRate: parseFloat(healthSnapshot.application.errorRate) > 5,
      slowAverageResponse: healthSnapshot.application.averageResponseTime > 1000
    }
  });
};

// Log system health every 5 minutes
setInterval(logPeriodicHealthMetrics, 5 * 60 * 1000);

module.exports = {
  systemHealthMiddleware,
  getSystemHealthSnapshot,
  logPeriodicHealthMetrics
};