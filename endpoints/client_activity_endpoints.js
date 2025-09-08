/**
 * Client Activity Tracking Endpoints
 * 
 * Provides comprehensive analytics for client activity patterns including:
 * - Most active clients and service patterns
 * - Client engagement metrics
 * - Service utilization patterns
 * - Revenue per client analysis
 * - Client retention and growth metrics
 */

const { MongoClient } = require('mongodb');
const logger = require('../config/logger');
const { createAuditLog } = require('../../audit_trail_endpoints');

/**
 * Get comprehensive client activity analytics
 * GET /api/analytics/clients/:organizationId
 */
async function getClientActivityAnalytics(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { startDate, endDate, limit = 50, sortBy = 'revenue', userEmail } = req.query;
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required'
      });
    }
    
    // Connect to database
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    // Build date filter
    const dateFilter = {};
    if (startDate && endDate) {
      dateFilter.createdAt = {
        $gte: new Date(startDate),
        $lte: new Date(endDate)
      };
    }
    
    // Get client activity metrics
    const clientMetrics = await getClientMetrics(db, organizationId, dateFilter, limit, sortBy);
    
    // Get service utilization patterns
    const servicePatterns = await getServiceUtilizationPatterns(db, organizationId, dateFilter);
    
    // Get client engagement trends
    const engagementTrends = await getClientEngagementTrends(db, organizationId, dateFilter);
    
    // Get client retention metrics
    const retentionMetrics = await getClientRetentionMetrics(db, organizationId, dateFilter);
    
    // Calculate summary statistics
    const summary = calculateClientSummary(clientMetrics, servicePatterns, engagementTrends);
    
    // Log analytics access
    logger.business('Client Activity Analytics Accessed', {
      event: 'client_activity_analytics_accessed',
      organizationId,
      userEmail: userEmail || 'system',
      dateRange: { startDate, endDate },
      filters: { limit, sortBy },
      metrics: {
        totalClients: clientMetrics.length,
        totalRevenue: summary.totalRevenue,
        avgRevenuePerClient: summary.avgRevenuePerClient,
        mostActiveClient: clientMetrics[0]?.clientId
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(200).json({
      success: true,
      message: 'Client activity analytics retrieved successfully',
      data: {
        clientMetrics,
        servicePatterns,
        engagementTrends,
        retentionMetrics,
        summary,
        metadata: {
          totalClients: clientMetrics.length,
          dateRange: { startDate, endDate },
          sortBy,
          limit: parseInt(limit),
          generatedAt: new Date().toISOString()
        }
      }
    });
    
  } catch (error) {
    console.error('Error in getClientActivityAnalytics:', error);
    
    logger.business('Client Activity Analytics Error', {
      event: 'client_activity_analytics_error',
      organizationId: req.params.organizationId,
      error: {
        message: error.message,
        stack: error.stack
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(500).json({
      success: false,
      message: 'Error retrieving client activity analytics',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get top performing clients
 * GET /api/analytics/clients/top/:organizationId
 */
async function getTopPerformingClients(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { metric = 'revenue', limit = 10, startDate, endDate } = req.query;
    
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    const dateFilter = {};
    if (startDate && endDate) {
      dateFilter.createdAt = {
        $gte: new Date(startDate),
        $lte: new Date(endDate)
      };
    }
    
    const topClients = await getTopClientsByMetric(db, organizationId, dateFilter, metric, parseInt(limit));
    
    logger.business('Top Performing Clients Retrieved', {
      event: 'top_clients_retrieved',
      organizationId,
      metric,
      limit: parseInt(limit),
      topClients: topClients.slice(0, 5).map(c => ({
        clientId: c.clientId,
        value: c[metric]
      })),
      timestamp: new Date().toISOString()
    });
    
    res.status(200).json({
      success: true,
      message: 'Top performing clients retrieved successfully',
      data: {
        topClients,
        metric,
        summary: {
          totalClients: topClients.length,
          topValue: topClients[0]?.[metric] || 0,
          averageValue: topClients.reduce((sum, c) => sum + (c[metric] || 0), 0) / Math.max(topClients.length, 1)
        }
      }
    });
    
  } catch (error) {
    console.error('Error in getTopPerformingClients:', error);
    
    res.status(500).json({
      success: false,
      message: 'Error retrieving top performing clients',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get client service patterns
 * GET /api/analytics/clients/services/:organizationId
 */
async function getClientServicePatterns(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { clientId, startDate, endDate } = req.query;
    
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    const filter = { organizationId };
    if (clientId) filter.clientId = clientId;
    if (startDate && endDate) {
      filter.createdAt = {
        $gte: new Date(startDate),
        $lte: new Date(endDate)
      };
    }
    
    const servicePatterns = await analyzeServicePatterns(db, filter);
    const utilizationMetrics = await calculateServiceUtilization(db, filter);
    
    logger.business('Client Service Patterns Retrieved', {
      event: 'client_service_patterns_retrieved',
      organizationId,
      clientId,
      patterns: {
        totalServices: servicePatterns.length,
        mostUsedService: servicePatterns[0]?.supportItemNumber,
        totalUtilization: utilizationMetrics.totalHours
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(200).json({
      success: true,
      message: 'Client service patterns retrieved successfully',
      data: {
        servicePatterns,
        utilizationMetrics,
        insights: generateServiceInsights(servicePatterns, utilizationMetrics)
      }
    });
    
  } catch (error) {
    console.error('Error in getClientServicePatterns:', error);
    
    res.status(500).json({
      success: false,
      message: 'Error retrieving client service patterns',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get comprehensive client metrics
 */
async function getClientMetrics(db, organizationId, dateFilter, limit, sortBy) {
  const pipeline = [
    {
      $match: {
        organizationId,
        ...dateFilter
      }
    },
    {
      $group: {
        _id: '$clientId',
        totalRevenue: { $sum: '$totalPrice' },
        totalItems: { $sum: 1 },
        totalHours: { $sum: '$hours' },
        avgPricePerItem: { $avg: '$totalPrice' },
        avgHoursPerItem: { $avg: '$hours' },
        firstActivity: { $min: '$createdAt' },
        lastActivity: { $max: '$createdAt' },
        uniqueServices: { $addToSet: '$supportItemNumber' },
        uniqueEmployees: { $addToSet: '$employeeId' }
      }
    },
    {
      $addFields: {
        clientId: '$_id',
        uniqueServiceCount: { $size: '$uniqueServices' },
        uniqueEmployeeCount: { $size: '$uniqueEmployees' },
        activitySpan: {
          $divide: [
            { $subtract: ['$lastActivity', '$firstActivity'] },
            1000 * 60 * 60 * 24 // Convert to days
          ]
        },
        revenuePerDay: {
          $divide: [
            '$totalRevenue',
            {
              $max: [
                {
                  $divide: [
                    { $subtract: ['$lastActivity', '$firstActivity'] },
                    1000 * 60 * 60 * 24
                  ]
                },
                1
              ]
            }
          ]
        }
      }
    },
    {
      $sort: {
        [sortBy === 'revenue' ? 'totalRevenue' : 
         sortBy === 'activity' ? 'totalItems' :
         sortBy === 'hours' ? 'totalHours' : 'totalRevenue']: -1
      }
    },
    {
      $limit: parseInt(limit)
    }
  ];
  
  const metrics = await db.collection('invoiceLineItems').aggregate(pipeline).toArray();
  
  // Enrich with client details
  for (const metric of metrics) {
    const clientDetails = await db.collection('clients').findOne({ _id: metric.clientId });
    if (clientDetails) {
      metric.clientName = clientDetails.clientName;
      metric.clientType = clientDetails.clientType;
      metric.status = clientDetails.status;
    }
  }
  
  return metrics;
}

/**
 * Get service utilization patterns
 */
async function getServiceUtilizationPatterns(db, organizationId, dateFilter) {
  const pipeline = [
    {
      $match: {
        organizationId,
        ...dateFilter
      }
    },
    {
      $group: {
        _id: '$supportItemNumber',
        totalUsage: { $sum: 1 },
        totalRevenue: { $sum: '$totalPrice' },
        totalHours: { $sum: '$hours' },
        uniqueClients: { $addToSet: '$clientId' },
        avgPricePerUnit: { $avg: '$unitPrice' },
        avgHoursPerUnit: { $avg: '$hours' }
      }
    },
    {
      $addFields: {
        supportItemNumber: '$_id',
        uniqueClientCount: { $size: '$uniqueClients' },
        revenuePerClient: {
          $divide: ['$totalRevenue', { $size: '$uniqueClients' }]
        }
      }
    },
    {
      $sort: { totalUsage: -1 }
    },
    {
      $limit: 20
    }
  ];
  
  return await db.collection('invoiceLineItems').aggregate(pipeline).toArray();
}

/**
 * Get client engagement trends
 */
async function getClientEngagementTrends(db, organizationId, dateFilter) {
  const pipeline = [
    {
      $match: {
        organizationId,
        ...dateFilter
      }
    },
    {
      $group: {
        _id: {
          year: { $year: '$createdAt' },
          month: { $month: '$createdAt' },
          clientId: '$clientId'
        },
        monthlyRevenue: { $sum: '$totalPrice' },
        monthlyItems: { $sum: 1 },
        monthlyHours: { $sum: '$hours' }
      }
    },
    {
      $group: {
        _id: {
          year: '$_id.year',
          month: '$_id.month'
        },
        activeClients: { $sum: 1 },
        totalRevenue: { $sum: '$monthlyRevenue' },
        totalItems: { $sum: '$monthlyItems' },
        totalHours: { $sum: '$monthlyHours' },
        avgRevenuePerClient: { $avg: '$monthlyRevenue' }
      }
    },
    {
      $sort: { '_id.year': 1, '_id.month': 1 }
    }
  ];
  
  return await db.collection('invoiceLineItems').aggregate(pipeline).toArray();
}

/**
 * Get client retention metrics
 */
async function getClientRetentionMetrics(db, organizationId, dateFilter) {
  // Get all clients with their first and last activity
  const clientActivity = await db.collection('invoiceLineItems').aggregate([
    {
      $match: {
        organizationId,
        ...dateFilter
      }
    },
    {
      $group: {
        _id: '$clientId',
        firstActivity: { $min: '$createdAt' },
        lastActivity: { $max: '$createdAt' },
        totalActivities: { $sum: 1 }
      }
    }
  ]).toArray();
  
  const now = new Date();
  const thirtyDaysAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
  const ninetyDaysAgo = new Date(now.getTime() - 90 * 24 * 60 * 60 * 1000);
  
  const activeClients = clientActivity.filter(c => c.lastActivity >= thirtyDaysAgo);
  const recentClients = clientActivity.filter(c => c.lastActivity >= ninetyDaysAgo);
  const churnedClients = clientActivity.filter(c => c.lastActivity < ninetyDaysAgo);
  
  return {
    totalClients: clientActivity.length,
    activeClients: activeClients.length,
    recentClients: recentClients.length,
    churnedClients: churnedClients.length,
    retentionRate: (activeClients.length / Math.max(clientActivity.length, 1)) * 100,
    churnRate: (churnedClients.length / Math.max(clientActivity.length, 1)) * 100,
    avgActivitiesPerClient: clientActivity.reduce((sum, c) => sum + c.totalActivities, 0) / Math.max(clientActivity.length, 1)
  };
}

/**
 * Get top clients by specific metric
 */
async function getTopClientsByMetric(db, organizationId, dateFilter, metric, limit) {
  const sortField = {
    revenue: 'totalRevenue',
    activity: 'totalItems',
    hours: 'totalHours',
    services: 'uniqueServiceCount'
  }[metric] || 'totalRevenue';
  
  const pipeline = [
    {
      $match: {
        organizationId,
        ...dateFilter
      }
    },
    {
      $group: {
        _id: '$clientId',
        totalRevenue: { $sum: '$totalPrice' },
        totalItems: { $sum: 1 },
        totalHours: { $sum: '$hours' },
        uniqueServices: { $addToSet: '$supportItemNumber' }
      }
    },
    {
      $addFields: {
        clientId: '$_id',
        uniqueServiceCount: { $size: '$uniqueServices' }
      }
    },
    {
      $sort: { [sortField]: -1 }
    },
    {
      $limit: limit
    }
  ];
  
  return await db.collection('invoiceLineItems').aggregate(pipeline).toArray();
}

/**
 * Analyze service patterns
 */
async function analyzeServicePatterns(db, filter) {
  const pipeline = [
    { $match: filter },
    {
      $group: {
        _id: {
          supportItemNumber: '$supportItemNumber',
          clientId: '$clientId'
        },
        usage: { $sum: 1 },
        totalRevenue: { $sum: '$totalPrice' },
        totalHours: { $sum: '$hours' },
        avgPrice: { $avg: '$unitPrice' }
      }
    },
    {
      $group: {
        _id: '$_id.supportItemNumber',
        clientUsage: {
          $push: {
            clientId: '$_id.clientId',
            usage: '$usage',
            revenue: '$totalRevenue',
            hours: '$totalHours'
          }
        },
        totalUsage: { $sum: '$usage' },
        totalRevenue: { $sum: '$totalRevenue' },
        uniqueClients: { $sum: 1 }
      }
    },
    {
      $sort: { totalUsage: -1 }
    }
  ];
  
  return await db.collection('invoiceLineItems').aggregate(pipeline).toArray();
}

/**
 * Calculate service utilization
 */
async function calculateServiceUtilization(db, filter) {
  const stats = await db.collection('invoiceLineItems').aggregate([
    { $match: filter },
    {
      $group: {
        _id: null,
        totalHours: { $sum: '$hours' },
        totalRevenue: { $sum: '$totalPrice' },
        totalItems: { $sum: 1 },
        avgHoursPerItem: { $avg: '$hours' },
        avgRevenuePerHour: { $avg: { $divide: ['$totalPrice', '$hours'] } }
      }
    }
  ]).toArray();
  
  return stats[0] || {
    totalHours: 0,
    totalRevenue: 0,
    totalItems: 0,
    avgHoursPerItem: 0,
    avgRevenuePerHour: 0
  };
}

/**
 * Calculate client summary
 */
function calculateClientSummary(clientMetrics, servicePatterns, engagementTrends) {
  const totalRevenue = clientMetrics.reduce((sum, c) => sum + (c.totalRevenue || 0), 0);
  const totalHours = clientMetrics.reduce((sum, c) => sum + (c.totalHours || 0), 0);
  const totalItems = clientMetrics.reduce((sum, c) => sum + (c.totalItems || 0), 0);
  
  return {
    totalClients: clientMetrics.length,
    totalRevenue,
    totalHours,
    totalItems,
    avgRevenuePerClient: totalRevenue / Math.max(clientMetrics.length, 1),
    avgHoursPerClient: totalHours / Math.max(clientMetrics.length, 1),
    avgItemsPerClient: totalItems / Math.max(clientMetrics.length, 1),
    topServicesByUsage: servicePatterns.slice(0, 5).map(s => s.supportItemNumber),
    monthlyGrowth: calculateMonthlyGrowth(engagementTrends)
  };
}

/**
 * Generate service insights
 */
function generateServiceInsights(servicePatterns, utilizationMetrics) {
  const insights = [];
  
  if (servicePatterns.length > 0) {
    const topService = servicePatterns[0];
    insights.push({
      type: 'top_service',
      message: `Most utilized service: ${topService.supportItemNumber} with ${topService.totalUsage} uses`,
      value: topService.totalUsage
    });
  }
  
  if (utilizationMetrics.avgRevenuePerHour > 50) {
    insights.push({
      type: 'high_efficiency',
      message: `High revenue efficiency: $${utilizationMetrics.avgRevenuePerHour.toFixed(2)} per hour`,
      value: utilizationMetrics.avgRevenuePerHour
    });
  }
  
  return insights;
}

/**
 * Calculate monthly growth
 */
function calculateMonthlyGrowth(trends) {
  if (trends.length < 2) return 0;
  
  const latest = trends[trends.length - 1];
  const previous = trends[trends.length - 2];
  
  return ((latest.totalRevenue - previous.totalRevenue) / Math.max(previous.totalRevenue, 1)) * 100;
}

module.exports = {
  getClientActivityAnalytics,
  getTopPerformingClients,
  getClientServicePatterns
};