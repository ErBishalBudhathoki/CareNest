/**
 * API Usage Monitoring Endpoints
 * 
 * Provides comprehensive API usage analytics including:
 * - API call statistics and usage patterns
 * - Rate limit monitoring and management
 * - Real-time user connection tracking
 * - Security API call logging and analysis
 */

const { MongoClient } = require('mongodb');
const logger = require('../config/logger');
const { apiUsageMonitor } = require('../utils/apiUsageMonitor');
const { getAuthBlockedIPs, unblockAuthIP, getFailedAttemptsSnapshot, getRateLimitConfigs } = require('../middleware/auth');

/**
 * Get comprehensive API usage analytics
 * GET /api/analytics/api-usage/:organizationId
 */
async function getApiUsageAnalytics(req, res) {
  try {
    const { organizationId } = req.params;
    const { startDate, endDate, userId, endpoint } = req.query;

    if (!organizationId) {
      return res.status(400).json({ success: false, message: 'Organization ID is required' });
    }

    // Build in-memory dataset from live ApiUsageMonitor history (newest first)
    const rawHistory = apiUsageMonitor.getHistory(1000) || [];
    let apiUsageData = rawHistory.map(h => ({
      endpoint: h.path,
      statusCode: h.status,
      responseTime: h.durationMs,
      timestamp: new Date(h.ts),
      userId: h.userId || null,
      ip: h.ip || null
    }));

    // Apply optional filters
    if (startDate && endDate) {
      const start = new Date(startDate);
      const end = new Date(endDate);
      apiUsageData = apiUsageData.filter(x => x.timestamp >= start && x.timestamp <= end);
    }
    if (userId) {
      apiUsageData = apiUsageData.filter(x => x.userId === userId);
    }
    if (endpoint) {
      apiUsageData = apiUsageData.filter(x => x.endpoint === endpoint);
    }

    // Security info from auth middleware
    const blockedIPs = getAuthBlockedIPs();
    const failedAttempts = getFailedAttemptsSnapshot();

    // Active connections = list of current SSE clients connected to ApiUsageMonitor
    const activeConnections = apiUsageMonitor.getActiveConnections();

    // Calculate metrics and patterns from in-memory data
    const metrics = calculateApiUsageMetrics(apiUsageData);
    const trends = calculateApiUsageTrendsFromHistory(apiUsageData);
    const endpointPatterns = getEndpointUsagePatternsFromHistory(apiUsageData);
    const userPatterns = getUserUsagePatternsFromHistory(apiUsageData);

    logger.business('API Usage Analytics Accessed (live)', {
      event: 'api_usage_analytics_accessed',
      organizationId,
      userEmail: req.user?.email || 'system',
      dateRange: { startDate, endDate },
      filters: { userId, endpoint },
      metrics: {
        totalApiCalls: metrics.totalCalls,
        successRate: metrics.successRate,
        avgResponseTime: metrics.responseTime.average
      },
      timestamp: new Date().toISOString()
    });

    res.status(200).json({
      success: true,
      message: 'API usage analytics retrieved successfully',
      data: {
        metrics,
        trends,
        endpointPatterns,
        userPatterns,
        security: { blockedIPs, failedAttempts, activeConnections },
        summary: {
          totalApiCalls: metrics.totalCalls,
          dateRange: { startDate, endDate },
          organizationId,
          generatedAt: new Date().toISOString()
        }
      }
    });
  } catch (error) {
    console.error('Error in getApiUsageAnalytics (live):', error);
    res.status(500).json({ success: false, message: 'Error retrieving API usage analytics', error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error' });
  }
}

/**
 * Get real-time API usage dashboard
 * GET /api/analytics/api-usage/realtime/:organizationId
 */
async function getRealTimeApiUsage(req, res) {
  try {
    const { organizationId } = req.params;
    if (!organizationId) {
      return res.status(400).json({ success: false, message: 'Organization ID is required' });
    }

    const realTimeData = apiUsageMonitor.getSummary();
    const activeConnections = apiUsageMonitor.getActiveConnections();

    res.status(200).json({
      success: true,
      message: 'Real-time API usage data retrieved successfully',
      data: {
        realTime: realTimeData,
        activeConnections,
        recentViolations: [],
        timestamp: new Date().toISOString()
      }
    });
  } catch (error) {
    console.error('Error in getRealTimeApiUsage (live):', error);
    res.status(500).json({ success: false, message: 'Error retrieving real-time API usage data', error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error' });
  }
}

/**
 * Unblock IP address (admin function)
 * POST /api/analytics/api-usage/unblock-ip
 */
async function unblockIpAddress(req, res) {
  try {
    const { ipAddress } = req.body;
    if (!ipAddress) {
      return res.status(400).json({ success: false, message: 'IP address is required' });
    }

    const success = unblockAuthIP(ipAddress);

    logger.security('IP Address Unblocked', {
      event: 'ip_unblocked',
      ipAddress,
      unblockedBy: req.user?.email || 'system',
      timestamp: new Date().toISOString()
    });

    res.status(200).json({ success: true, message: success ? 'IP address unblocked successfully' : 'IP address was not blocked', data: { ipAddress, unblocked: success } });
  } catch (error) {
    console.error('Error in unblockIpAddress:', error);
    res.status(500).json({ success: false, message: 'Error unblocking IP address', error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error' });
  }
}

/**
 * Get rate limit configuration
 * GET /api/analytics/api-usage/rate-limits
 */
async function getRateLimitConfig(req, res) {
  try {
    const configs = getRateLimitConfigs();

    res.status(200).json({
      success: true,
      message: 'Rate limit configuration retrieved successfully',
      data: configs
    });
    
  } catch (error) {
    console.error('Error in getRateLimitConfig:', error);
    
    res.status(500).json({
      success: false,
      message: 'Error retrieving rate limit configuration',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  }
}

/**
 * Calculate comprehensive API usage metrics
 */
function calculateApiUsageMetrics(apiUsageData) {
  const totalCalls = apiUsageData.length;
  const successfulCalls = apiUsageData.filter(call => call.statusCode >= 200 && call.statusCode < 300).length;
  const failedCalls = apiUsageData.filter(call => call.statusCode >= 400).length;
  
  const successRate = (successfulCalls / Math.max(totalCalls, 1)) * 100;
  const failureRate = (failedCalls / Math.max(totalCalls, 1)) * 100;
  
  const responseTimes = apiUsageData.map(call => call.responseTime || 0).filter(time => time > 0);
  const avgResponseTime = responseTimes.length > 0 ? 
    responseTimes.reduce((sum, time) => sum + time, 0) / responseTimes.length : 0;
  
  const maxResponseTime = responseTimes.length > 0 ? Math.max(...responseTimes) : 0;
  const minResponseTime = responseTimes.length > 0 ? Math.min(...responseTimes) : 0;
  
  // Group by endpoint
  const endpointStats = {};
  apiUsageData.forEach(call => {
    if (!endpointStats[call.endpoint]) {
      endpointStats[call.endpoint] = { count: 0, totalTime: 0, successCount: 0 };
    }
    endpointStats[call.endpoint].count++;
    endpointStats[call.endpoint].totalTime += call.responseTime || 0;
    if (call.statusCode >= 200 && call.statusCode < 300) {
      endpointStats[call.endpoint].successCount++;
    }
  });
  
  // Calculate endpoint averages
  Object.keys(endpointStats).forEach(endpoint => {
    endpointStats[endpoint].avgTime = endpointStats[endpoint].totalTime / Math.max(endpointStats[endpoint].count, 1);
    endpointStats[endpoint].successRate = (endpointStats[endpoint].successCount / Math.max(endpointStats[endpoint].count, 1)) * 100;
  });
  
  return {
    totalCalls,
    successfulCalls,
    failedCalls,
    successRate,
    failureRate,
    responseTime: {
      average: avgResponseTime,
      maximum: maxResponseTime,
      minimum: minResponseTime
    },
    endpointStats,
    mostFrequentEndpoint: Object.keys(endpointStats).reduce((max, current) => 
      endpointStats[current].count > endpointStats[max].count ? current : max, Object.keys(endpointStats)[0]
    )
  };
}

/**
 * Calculate API usage trends over time
 */
async function calculateApiUsageTrends(db, organizationId, startDate, endDate) {
  const pipeline = [
    {
      $match: {
        organizationId,
        ...(startDate && endDate ? {
          timestamp: {
            $gte: new Date(startDate),
            $lte: new Date(endDate)
          }
        } : {})
      }
    },
    {
      $group: {
        _id: {
          year: { $year: '$timestamp' },
          month: { $month: '$timestamp' },
          day: { $dayOfMonth: '$timestamp' },
          hour: { $hour: '$timestamp' }
        },
        count: { $sum: 1 },
        totalResponseTime: { $sum: '$responseTime' },
        successCount: {
          $sum: {
            $cond: [
              { $and: [
                { $gte: ['$statusCode', 200] },
                { $lt: ['$statusCode', 300] }
              ]},
              1,
              0
            ]
          }
        }
      }
    },
    {
      $sort: { '_id.year': 1, '_id.month': 1, '_id.day': 1, '_id.hour': 1 }
    }
  ];
  
  const trends = await db.collection('apiUsageLogs').aggregate(pipeline).toArray();
  
  return {
    hourlyTrends: trends,
    summary: {
      peakHour: trends.reduce((max, current) => current.count > max.count ? current : max, trends[0]),
      totalHours: trends.length,
      avgCallsPerHour: trends.reduce((sum, t) => sum + t.count, 0) / Math.max(trends.length, 1),
      successRate: trends.reduce((sum, t) => sum + t.successCount, 0) / Math.max(trends.reduce((sum, t) => sum + t.count, 0), 1) * 100
    }
  };
}

/**
 * Get endpoint-specific usage patterns
 */
async function getEndpointUsagePatterns(db, organizationId, startDate, endDate) {
  const pipeline = [
    {
      $match: {
        organizationId,
        ...(startDate && endDate ? {
          timestamp: {
            $gte: new Date(startDate),
            $lte: new Date(endDate)
          }
        } : {})
      }
    },
    {
      $group: {
        _id: '$endpoint',
        count: { $sum: 1 },
        totalResponseTime: { $sum: '$responseTime' },
        successCount: {
          $sum: {
            $cond: [
              { $and: [
                { $gte: ['$statusCode', 200] },
                { $lt: ['$statusCode', 300] }
              ]},
              1,
              0
            ]
          }
        },
        errorCount: {
          $sum: {
            $cond: [
              { $gte: ['$statusCode', 400] },
              1,
              0
            ]
          }
        }
      }
    },
    {
      $sort: { count: -1 }
    }
  ];
  
  const patterns = await db.collection('apiUsageLogs').aggregate(pipeline).toArray();
  
  return patterns.map(pattern => ({
    endpoint: pattern._id,
    totalCalls: pattern.count,
    avgResponseTime: pattern.totalResponseTime / Math.max(pattern.count, 1),
    successRate: (pattern.successCount / Math.max(pattern.count, 1)) * 100,
    errorRate: (pattern.errorCount / Math.max(pattern.count, 1)) * 100,
    performance: pattern.totalResponseTime / Math.max(pattern.count, 1) < 100 ? 'good' : 
                 pattern.totalResponseTime / Math.max(pattern.count, 1) < 500 ? 'average' : 'poor'
  }));
}

/**
 * Get user-specific usage patterns
 */
async function getUserUsagePatterns(db, organizationId, startDate, endDate) {
  const pipeline = [
    {
      $match: {
        organizationId,
        userId: { $exists: true, $ne: null },
        ...(startDate && endDate ? {
          timestamp: {
            $gte: new Date(startDate),
            $lte: new Date(endDate)
          }
        } : {})
      }
    },
    {
      $group: {
        _id: '$userId',
        count: { $sum: 1 },
        totalResponseTime: { $sum: '$responseTime' },
        endpoints: { $addToSet: '$endpoint' },
        lastActivity: { $max: '$timestamp' },
        successCount: {
          $sum: {
            $cond: [
              { $and: [
                { $gte: ['$statusCode', 200] },
                { $lt: ['$statusCode', 300] }
              ]},
              1,
              0
            ]
          }
        }
      }
    },
    {
      $sort: { count: -1 }
    }
  ];
  
  const patterns = await db.collection('apiUsageLogs').aggregate(pipeline).toArray();
  
  return patterns.map(pattern => ({
    userId: pattern._id,
    totalCalls: pattern.count,
    avgResponseTime: pattern.totalResponseTime / Math.max(pattern.count, 1),
    successRate: (pattern.successCount / Math.max(pattern.count, 1)) * 100,
    endpointsUsed: pattern.endpoints.length,
    lastActivity: pattern.lastActivity,
    activityLevel: pattern.count > 1000 ? 'high' : pattern.count > 100 ? 'medium' : 'low'
  }));
}

/**
 * Server-Sent Events (SSE) endpoint for real-time API usage streaming
 * GET /api/analytics/api-usage/stream/:organizationId
 */
async function streamApiUsageEvents(req, res) {
  try {
    const { organizationId } = req.params;
    if (!organizationId) {
      return res.status(400).json({ success: false, message: 'Organization ID is required' });
    }

    // SSE headers
    res.setHeader('Content-Type', 'text/event-stream');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Connection', 'keep-alive');
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Cache-Control');

    // Initial event and summary
    const initial = apiUsageMonitor.getSummary();
    res.write(`event: ready\n`);
    res.write(`data: ${JSON.stringify({ message: 'SSE connected', initial, organizationId })}\n\n`);

    // Register client to live ApiUsageMonitor
    const cleanup = apiUsageMonitor.addSSEClient(res, { ip: req.ip, userId: req.user?.id || req.user?.userId || null, email: req.user?.email || null });
    
    // Cleanup on disconnect
    req.on('close', () => {
      cleanup();
      try { res.end(); } catch (_) {}
    });
  } catch (error) {
    console.error('Error in streamApiUsageEvents (live):', error);
    if (!res.headersSent) {
      res.status(500).json({ success: false, message: 'Error establishing SSE connection', error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error' });
    }
  }
}

module.exports = {
  getApiUsageAnalytics,
  getRealTimeApiUsage,
  unblockIpAddress,
  getRateLimitConfig,
  streamApiUsageEvents
};

// Helper: calculate trends from in-memory history
function calculateApiUsageTrendsFromHistory(data) {
  if (!data || !data.length) {
    return { hourlyTrends: [], summary: { peakHour: null, totalHours: 0, avgCallsPerHour: 0, successRate: 0 } };
  }
  const buckets = new Map();
  for (const d of data) {
    const dt = d.timestamp instanceof Date ? d.timestamp : new Date(d.timestamp);
    const key = `${dt.getUTCFullYear()}-${dt.getUTCMonth()+1}-${dt.getUTCDate()}-${dt.getUTCHours()}`;
    let b = buckets.get(key);
    if (!b) {
      b = { _id: { year: dt.getUTCFullYear(), month: dt.getUTCMonth()+1, day: dt.getUTCDate(), hour: dt.getUTCHours() }, count: 0, totalResponseTime: 0, successCount: 0 };
      buckets.set(key, b);
    }
    b.count += 1;
    b.totalResponseTime += d.responseTime || 0;
    if (d.statusCode >= 200 && d.statusCode < 300) b.successCount += 1;
  }
  const trends = Array.from(buckets.values()).sort((a,b) => (
    a._id.year - b._id.year || a._id.month - b._id.month || a._id.day - b._id.day || a._id.hour - b._id.hour
  ));
  const totalCalls = trends.reduce((s,t)=>s+t.count,0);
  const peakHour = trends.reduce((max, cur) => (!max || cur.count > max.count) ? cur : max, null);
  const avgCallsPerHour = trends.length ? totalCalls / trends.length : 0;
  const successRate = totalCalls ? (trends.reduce((s,t)=>s+t.successCount,0) / totalCalls) * 100 : 0;
  return { hourlyTrends: trends, summary: { peakHour, totalHours: trends.length, avgCallsPerHour, successRate } };
}

// Helper: endpoint patterns from in-memory history
function getEndpointUsagePatternsFromHistory(data) {
  const stats = new Map();
  for (const d of data || []) {
    const key = d.endpoint || '/';
    let s = stats.get(key);
    if (!s) { s = { count: 0, totalResponseTime: 0, successCount: 0, errorCount: 0 }; stats.set(key, s); }
    s.count += 1;
    s.totalResponseTime += d.responseTime || 0;
    if (d.statusCode >= 200 && d.statusCode < 300) s.successCount += 1;
    if (d.statusCode >= 400) s.errorCount += 1;
  }
  return Array.from(stats.entries()).sort((a,b)=>b[1].count - a[1].count).map(([endpoint, s]) => ({
    endpoint,
    totalCalls: s.count,
    avgResponseTime: s.count ? s.totalResponseTime / s.count : 0,
    successRate: s.count ? (s.successCount / s.count) * 100 : 0,
    errorRate: s.count ? (s.errorCount / s.count) * 100 : 0,
    performance: (s.count ? s.totalResponseTime / s.count : 0) < 100 ? 'good' : (s.count ? s.totalResponseTime / s.count : 0) < 500 ? 'average' : 'poor'
  }));
}

// Helper: user patterns from in-memory history
function getUserUsagePatternsFromHistory(data) {
  const stats = new Map();
  for (const d of data || []) {
    const uid = d.userId || 'anonymous';
    let s = stats.get(uid);
    if (!s) { 
      s = { 
        userId: uid,
        userEmail: d.userEmail || null,
        count: 0, 
        totalResponseTime: 0, 
        successCount: 0, 
        endpoints: new Set(), 
        lastActivity: null 
      }; 
      stats.set(uid, s); 
    }
    // Update email if available and not already set
    if (d.userEmail && !s.userEmail) {
      s.userEmail = d.userEmail;
    }
    s.count += 1;
    s.totalResponseTime += d.responseTime || 0;
    if (d.statusCode >= 200 && d.statusCode < 300) s.successCount += 1;
    if (d.endpoint) s.endpoints.add(d.endpoint);
    const ts = d.timestamp instanceof Date ? d.timestamp : new Date(d.timestamp);
    if (!s.lastActivity || ts > s.lastActivity) s.lastActivity = ts;
  }
  return Array.from(stats.values()).sort((a,b)=>b.count - a.count).map((s) => ({
    userId: s.userId,
    userEmail: s.userEmail,
    totalCalls: s.count,
    avgResponseTime: s.count ? s.totalResponseTime / s.count : 0,
    successRate: s.count ? (s.successCount / s.count) * 100 : 0,
    endpointsUsed: s.endpoints.size,
    lastActivity: s.lastActivity,
    activityLevel: s.count > 1000 ? 'high' : s.count > 100 ? 'medium' : 'low'
  }));
}