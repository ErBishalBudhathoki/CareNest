const express = require('express');
const { securityMonitor } = require('../utils/securityMonitor');
const { alertingSystem } = require('../utils/alertingSystem');
const { createLogger } = require('../utils/logger');
const { authenticateUser, requireRoles } = require('../middleware/auth');
const rateLimit = require('express-rate-limit');
const { apiUsageMonitor } = require('../utils/apiUsageMonitor');

const router = express.Router();
const logger = createLogger('SecurityDashboard');

// Rate limiting for security dashboard endpoints
const dashboardRateLimit = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests to security dashboard',
  standardHeaders: true,
  legacyHeaders: false
});

// Apply rate limiting to all dashboard routes
router.use(dashboardRateLimit);

// Require authentication and admin role for all security dashboard routes
router.use(authenticateUser);
router.use(requireRoles(['admin']));

/**
 * POST /api/security/dashboard/rate-limit/reset
 * Reset rate limiting for specific IP or user
 */
router.post('/rate-limit/reset', async (req, res) => {
  try {
    const { ip, userId, email, resetAll } = req.body;
    
    // Log the reset attempt
    logger.security('Rate limit reset attempt', {
      adminId: req.user.userId,
      adminEmail: req.user.email,
      targetIp: ip,
      targetUserId: userId,
      targetEmail: email,
      resetAll: resetAll,
      ip: req.ip
    });
    
    // Import auth middleware to access rate limiting functions
    const AuthMiddleware = require('../middleware/auth').AuthMiddleware;
    
    let resetCount = 0;
    
    if (resetAll) {
      // Reset all rate limits - use with caution
      AuthMiddleware.failedAttempts.clear();
      AuthMiddleware.blockedIPs.clear();
      resetCount = 'all';
      
      logger.security('All rate limits reset', {
        adminId: req.user.userId,
        adminEmail: req.user.email,
        ip: req.ip
      });
    } else if (ip) {
      // Reset rate limits for specific IP
      AuthMiddleware.resetFailedAttempts(ip);
      resetCount = 1;
      
      logger.security('IP rate limit reset', {
        adminId: req.user.userId,
        adminEmail: req.user.email,
        targetIp: ip,
        ip: req.ip
      });
    } else {
      // No valid reset parameters
      return res.status(400).json({
        success: false,
        message: 'Missing required parameters. Please provide ip, userId, email, or resetAll.'
      });
    }
    
    res.json({
      success: true,
      message: `Rate limits reset successfully for ${resetCount} entries`,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to reset rate limits', {
      error: error.message,
      userId: req.user.userId,
      ip: req.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to reset rate limits'
    });
  }
});

/**
 * GET /api/security/dashboard/rate-limit/status
 * Get current rate limiting status
 */
router.get('/rate-limit/status', async (req, res) => {
  try {
    // Import auth middleware to access rate limiting data
    const AuthMiddleware = require('../middleware/auth').AuthMiddleware;
    
    // Get blocked IPs
    const blockedIPs = AuthMiddleware.getBlockedIPsAdmin();
    
    // Get failed attempts
    const failedAttempts = AuthMiddleware.getFailedAttemptsSnapshot();
    
    res.json({
      success: true,
      data: {
        blockedIPs,
        failedAttempts,
        totalBlocked: blockedIPs.length,
        totalWithFailedAttempts: failedAttempts.length
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to get rate limit status', {
      error: error.message,
      userId: req.user.userId,
      ip: req.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to get rate limit status'
    });
  }
});


/**
 * GET /api/security/dashboard/metrics
 * Get current security metrics
 */
router.get('/dashboard/metrics', async (req, res) => {
  try {
    const metrics = securityMonitor.getMetrics();
    
    // Log dashboard access
    logger.security('Security dashboard metrics accessed', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      userAgent: req.get('User-Agent')
    });
    
    res.json({
      success: true,
      data: metrics,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to retrieve security metrics', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve security metrics'
    });
  }
});

/**
 * GET /api/security/dashboard/report
 * Generate comprehensive security report
 */
router.get('/dashboard/report', async (req, res) => {
  try {
    const report = securityMonitor.generateSecurityReport();
    
    logger.security('Security report generated', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      reportPeriod: report.period
    });
    
    res.json({
      success: true,
      data: report,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to generate security report', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to generate security report'
    });
  }
});

/**
 * GET /api/security/dashboard/alerts/status
 * Get alerting system status
 */
router.get('/dashboard/alerts/status', async (req, res) => {
  try {
    const status = alertingSystem.getStatus();
    
    logger.security('Alert system status checked', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip
    });
    
    res.json({
      success: true,
      data: status,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to get alert system status', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to get alert system status'
    });
  }
});

/**
 * POST /api/security/dashboard/alerts/test
 * Test alert system
 */
router.post('/dashboard/alerts/test', async (req, res) => {
  try {
    const { channel } = req.body;
    
    await alertingSystem.testAlert(channel);
    
    logger.security('Alert system test triggered', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      channel: channel || 'all'
    });
    
    res.json({
      success: true,
      message: `Test alert sent via ${channel || 'all channels'}`,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to send test alert', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip,
      channel: req.body.channel
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to send test alert',
      error: error.message
    });
  }
});

/**
 * GET /api/security/dashboard/blocked-ips
 * Get list of blocked IP addresses
 */
router.get('/dashboard/blocked-ips', async (req, res) => {
  try {
    const metrics = securityMonitor.getMetrics();
    const blockedIPs = metrics.blockedIPs;
    
    logger.security('Blocked IPs list accessed', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      blockedCount: blockedIPs.length
    });
    
    res.json({
      success: true,
      data: {
        blockedIPs,
        count: blockedIPs.length,
        lastUpdated: new Date().toISOString()
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to retrieve blocked IPs', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve blocked IPs'
    });
  }
});

/**
 * POST /api/security/dashboard/unblock-ip
 * Manually unblock an IP address
 */
router.post('/dashboard/unblock-ip', async (req, res) => {
  try {
    const { ip } = req.body;
    
    if (!ip) {
      return res.status(400).json({
        success: false,
        message: 'IP address is required'
      });
    }
    
    // Validate IP format
    const ipRegex = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
    if (!ipRegex.test(ip)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid IP address format'
      });
    }
    
    // Check if IP is actually blocked
    if (!securityMonitor.isIPBlocked(ip)) {
      return res.status(404).json({
        success: false,
        message: 'IP address is not currently blocked'
      });
    }
    
    // Unblock the IP
    securityMonitor.unblockIP(ip);
    
    logger.security('IP manually unblocked', {
      userId: req.user.id,
      userEmail: req.user.email,
      adminIP: req.ip,
      unblockedIP: ip,
      reason: 'Manual admin action'
    });
    
    res.json({
      success: true,
      message: `IP address ${ip} has been unblocked`,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to unblock IP', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip,
      targetIP: req.body.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to unblock IP address'
    });
  }
});

/**
 * POST /api/security/dashboard/block-ip
 * Manually block an IP address
 */
router.post('/dashboard/block-ip', async (req, res) => {
  try {
    const { ip, reason, duration } = req.body;
    
    if (!ip) {
      return res.status(400).json({
        success: false,
        message: 'IP address is required'
      });
    }
    
    // Validate IP format
    const ipRegex = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
    if (!ipRegex.test(ip)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid IP address format'
      });
    }
    
    // Prevent blocking own IP
    if (ip === req.ip) {
      return res.status(400).json({
        success: false,
        message: 'Cannot block your own IP address'
      });
    }
    
    // Check if IP is already blocked
    if (securityMonitor.isIPBlocked(ip)) {
      return res.status(409).json({
        success: false,
        message: 'IP address is already blocked'
      });
    }
    
    const blockDuration = duration || 60 * 60 * 1000; // Default 1 hour
    const blockReason = reason || 'Manual admin block';
    
    // Block the IP
    securityMonitor.blockIP(ip, blockReason, blockDuration);
    
    logger.security('IP manually blocked', {
      userId: req.user.id,
      userEmail: req.user.email,
      adminIP: req.ip,
      blockedIP: ip,
      reason: blockReason,
      duration: blockDuration
    });
    
    res.json({
      success: true,
      message: `IP address ${ip} has been blocked`,
      details: {
        ip,
        reason: blockReason,
        duration: blockDuration,
        expiresAt: new Date(Date.now() + blockDuration).toISOString()
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to block IP', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip,
      targetIP: req.body.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to block IP address'
    });
  }
});

/**
 * GET /api/security/dashboard/events/recent
 * Get recent security events
 */
router.get('/dashboard/events/recent', async (req, res) => {
  try {
    const { limit = 50, type, severity } = req.query;
    const metrics = securityMonitor.getMetrics();
    
    let events = [];
    
    // Combine all recent events
    if (metrics.recentEvents) {
      Object.entries(metrics.recentEvents).forEach(([eventType, eventList]) => {
        eventList.forEach(event => {
          events.push({
            ...event,
            eventType
          });
        });
      });
    }
    
    // Filter by type if specified
    if (type) {
      events = events.filter(event => event.eventType === type);
    }
    
    // Filter by severity if specified
    if (severity) {
      events = events.filter(event => event.severity === severity);
    }
    
    // Sort by timestamp (newest first)
    events.sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));
    
    // Limit results
    events = events.slice(0, parseInt(limit));
    
    logger.security('Recent security events accessed', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      eventCount: events.length,
      filters: { type, severity, limit }
    });
    
    res.json({
      success: true,
      data: {
        events,
        count: events.length,
        filters: { type, severity, limit: parseInt(limit) }
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to retrieve recent events', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve recent events'
    });
  }
});

/**
 * GET /api/security/dashboard/health
 * Get security system health status
 */
router.get('/dashboard/health', async (req, res) => {
  try {
    const metrics = securityMonitor.getMetrics();
    const alertStatus = alertingSystem.getStatus();
    
    const health = {
      overall: 'healthy',
      components: {
        securityMonitor: {
          status: 'healthy',
          totalEvents: metrics.totalEvents,
          lastActivity: new Date().toISOString()
        },
        alertingSystem: {
          status: alertStatus.channels.email.configured || alertStatus.channels.webhook.configured ? 'healthy' : 'degraded',
          emailChannel: alertStatus.channels.email.configured ? 'configured' : 'not configured',
          webhookChannel: alertStatus.channels.webhook.configured ? 'configured' : 'not configured',
          queueSize: alertStatus.queue.pending
        },
        rateLimiting: {
          status: 'healthy',
          blockedIPs: metrics.blockedIPs.length
        }
      },
      metrics: {
        uptime: process.uptime(),
        memoryUsage: process.memoryUsage(),
        timestamp: new Date().toISOString()
      }
    };
    
    // Determine overall health
    const componentStatuses = Object.values(health.components).map(c => c.status);
    if (componentStatuses.includes('critical')) {
      health.overall = 'critical';
    } else if (componentStatuses.includes('degraded')) {
      health.overall = 'degraded';
    }
    
    logger.security('Security system health checked', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      overallHealth: health.overall
    });
    
    res.json({
      success: true,
      data: health,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to check security system health', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });
    
    res.status(500).json({
      success: false,
      message: 'Failed to check security system health'
    });
  }
});

/**
 * GET /api/security/api-usage/summary
 * Get summarized API usage stats
 */
router.get('/api-usage/summary', async (req, res) => {
  try {
    const summary = apiUsageMonitor.getSummary();

    logger.security('API usage summary accessed', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip
    });

    res.json({
      success: true,
      data: summary,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to retrieve API usage summary', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });

    res.status(500).json({
      success: false,
      message: 'Failed to retrieve API usage summary'
    });
  }
});

/**
 * GET /api/security/api-usage/history?limit=100
 * Get recent API request history
 */
router.get('/api-usage/history', async (req, res) => {
  try {
    const limit = Math.max(1, Math.min(parseInt(req.query.limit || '100', 10), 1000));
    const history = apiUsageMonitor.getHistory(limit);

    logger.security('API usage history accessed', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      limit
    });

    res.json({
      success: true,
      data: { history, count: history.length },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to retrieve API usage history', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });

    res.status(500).json({
      success: false,
      message: 'Failed to retrieve API usage history'
    });
  }
});

/**
 * GET /api/security/api-usage/endpoints
 * List endpoint stats (optionally top N)
 */
router.get('/api-usage/endpoints', async (req, res) => {
  try {
    const top = Math.max(1, Math.min(parseInt(req.query.top || '50', 10), 500));
    const endpoints = apiUsageMonitor.getEndpoints();
    const sorted = endpoints.sort((a, b) => b.count - a.count).slice(0, top);

    logger.security('API usage endpoints accessed', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      top
    });

    res.json({
      success: true,
      data: { endpoints: sorted, total: endpoints.length },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    logger.error('Failed to retrieve endpoint stats', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });

    res.status(500).json({
      success: false,
      message: 'Failed to retrieve endpoint stats'
    });
  }
});

/**
 * GET /api/security/api-usage/stream
 * Server-Sent Events (SSE) stream for real-time API usage updates
 */
router.get('/api-usage/stream', async (req, res) => {
  try {
    // Set SSE headers
    res.setHeader('Content-Type', 'text/event-stream');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Connection', 'keep-alive');

    // Send initial heartbeat and summary
    const initial = apiUsageMonitor.getSummary();
    res.write(`event: ready\n`);
    res.write(`data: ${JSON.stringify({ message: 'SSE connected', initial })}\n\n`);

    // Register client
    const cleanup = apiUsageMonitor.addSSEClient(res, { ip: req.ip, userId: req.user?.id || req.user?.userId || null });

    logger.security('API usage SSE stream started', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip
    });

    // Clean up on client disconnect
    req.on('close', () => {
      cleanup();
      logger.security('API usage SSE stream closed', {
        userId: req.user.id,
        userEmail: req.user.email,
        ip: req.ip
      });
    });
  } catch (error) {
    logger.error('Failed to start SSE stream', {
      error: error.message,
      userId: req.user.id,
      ip: req.ip
    });
    res.status(500).json({ success: false, message: 'Failed to start SSE stream' });
  }
});

/**
 * GET /api/security/api-usage/top-ips?top=50
 * List top IPs by request count (and error rate)
 */
router.get('/api-usage/top-ips', async (req, res) => {
  try {
    const top = Math.max(1, Math.min(parseInt(req.query.top || '50', 10), 500));
    const ips = apiUsageMonitor.getTopIPs(top);

    logger.security('API usage top IPs accessed', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      top
    });

    res.json({ success: true, data: { ips, count: ips.length }, timestamp: new Date().toISOString() });
  } catch (error) {
    logger.error('Failed to retrieve top IPs', { error: error.message, userId: req.user.id, ip: req.ip });
    res.status(500).json({ success: false, message: 'Failed to retrieve top IPs' });
  }
});

/**
 * GET /api/security/api-usage/top-users?top=50
 * List top users by request count (and error rate)
 */
router.get('/api-usage/top-users', async (req, res) => {
  try {
    const top = Math.max(1, Math.min(parseInt(req.query.top || '50', 10), 500));
    const users = apiUsageMonitor.getTopUsers(top);

    logger.security('API usage top users accessed', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip,
      top
    });

    res.json({ success: true, data: { users, count: users.length }, timestamp: new Date().toISOString() });
  } catch (error) {
    logger.error('Failed to retrieve top users', { error: error.message, userId: req.user.id, ip: req.ip });
    res.status(500).json({ success: false, message: 'Failed to retrieve top users' });
  }
});

/**
 * POST /api/security/api-usage/reset
 * Reset all API usage stats (admin only)
 */
router.post('/api-usage/reset', async (req, res) => {
  try {
    apiUsageMonitor.reset();

    logger.security('API usage stats reset', {
      userId: req.user.id,
      userEmail: req.user.email,
      ip: req.ip
    });

    res.json({ success: true, message: 'API usage stats reset', timestamp: new Date().toISOString() });
  } catch (error) {
    logger.error('Failed to reset API usage stats', { error: error.message, userId: req.user.id, ip: req.ip });
    res.status(500).json({ success: false, message: 'Failed to reset API usage stats' });
  }
});

/**
 * Reset API usage stats for a specific user
 * POST /api/security/api-usage/reset-user
 */
router.post('/api-usage/reset-user', async (req, res) => {
  try {
    const { userId } = req.body;
    
    if (!userId) {
      return res.status(400).json({ success: false, message: 'User ID is required' });
    }
    
    const result = apiUsageMonitor.reset(userId);
    
    if (result) {
      logger.security('API usage stats reset for specific user', {
        targetUserId: userId,
        requestedByUserId: req.user.id,
        requestedByEmail: req.user.email,
        ip: req.ip
      });
      
      res.json({ 
        success: true, 
        message: `API usage stats reset for user ${userId}`, 
        timestamp: new Date().toISOString() 
      });
    } else {
      res.status(404).json({ 
        success: false, 
        message: `User ${userId} not found in API usage stats` 
      });
    }
  } catch (error) {
    logger.error('Failed to reset API usage stats for user', { 
      error: error.message, 
      userId: req.user.id, 
      ip: req.ip 
    });
    res.status(500).json({ success: false, message: 'Failed to reset API usage stats for user' });
  }
});

module.exports = router;