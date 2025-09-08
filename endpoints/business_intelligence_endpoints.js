/**
 * Business Intelligence Dashboard Endpoints
 * 
 * Provides advanced analytics for business intelligence including:
 * - Revenue forecasting and trend analysis
 * - Client retention and acquisition metrics
 * - Service utilization statistics
 * - Organizational growth analytics
 * - Operational efficiency insights
 * - Performance bottleneck identification
 */

const { MongoClient } = require('mongodb');
const logger = require('../config/logger');
const { createAuditLog } = require('../../audit_trail_endpoints');

/**
 * Get comprehensive business intelligence dashboard
 * GET /api/analytics/business-intelligence/:organizationId
 */
async function getBusinessIntelligenceDashboard(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { startDate, endDate, forecastPeriod = 3, userEmail } = req.query;
    
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
    
    // Get revenue forecasting data
    const revenueForecast = await generateRevenueForecast(db, organizationId, dateFilter, parseInt(forecastPeriod));
    
    // Get client retention analysis
    const clientRetention = await analyzeClientRetention(db, organizationId, dateFilter);
    
    // Get service utilization statistics
    const serviceUtilization = await getServiceUtilizationStats(db, organizationId, dateFilter);
    
    // Get organizational growth metrics
    const organizationalGrowth = await getOrganizationalGrowthMetrics(db, organizationId, dateFilter);
    
    // Get operational efficiency insights
    const operationalEfficiency = await getOperationalEfficiencyInsights(db, organizationId, dateFilter);
    
    // Get performance bottlenecks
    const performanceBottlenecks = await identifyPerformanceBottlenecks(db, organizationId, dateFilter);
    
    // Generate executive summary
    const executiveSummary = generateExecutiveSummary({
      revenueForecast,
      clientRetention,
      serviceUtilization,
      organizationalGrowth,
      operationalEfficiency
    });
    
    // Log dashboard access
    logger.business('Business Intelligence Dashboard Accessed', {
      event: 'bi_dashboard_accessed',
      organizationId,
      userEmail: userEmail || 'system',
      dateRange: { startDate, endDate },
      forecastPeriod: parseInt(forecastPeriod),
      metrics: {
        currentRevenue: revenueForecast.currentPeriod.totalRevenue,
        forecastedRevenue: revenueForecast.forecast.nextPeriodRevenue,
        clientRetentionRate: clientRetention.retentionRate,
        growthRate: organizationalGrowth.revenueGrowthRate
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(200).json({
      success: true,
      message: 'Business intelligence dashboard retrieved successfully',
      data: {
        executiveSummary,
        revenueForecast,
        clientRetention,
        serviceUtilization,
        organizationalGrowth,
        operationalEfficiency,
        performanceBottlenecks,
        metadata: {
          organizationId,
          dateRange: { startDate, endDate },
          forecastPeriod: parseInt(forecastPeriod),
          generatedAt: new Date().toISOString()
        }
      }
    });
    
  } catch (error) {
    console.error('Error in getBusinessIntelligenceDashboard:', error);
    
    logger.business('Business Intelligence Dashboard Error', {
      event: 'bi_dashboard_error',
      organizationId: req.params.organizationId,
      error: {
        message: error.message,
        stack: error.stack
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(500).json({
      success: false,
      message: 'Error retrieving business intelligence dashboard',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get revenue forecasting analysis
 * GET /api/analytics/revenue-forecast/:organizationId
 */
async function getRevenueForecastAnalysis(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { periods = 6, confidence = 0.95 } = req.query;
    
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    const forecast = await generateDetailedRevenueForecast(db, organizationId, parseInt(periods), parseFloat(confidence));
    const seasonality = await analyzeSeasonalityPatterns(db, organizationId);
    const riskFactors = await identifyRevenueRiskFactors(db, organizationId);
    
    logger.business('Revenue Forecast Analysis Generated', {
      event: 'revenue_forecast_generated',
      organizationId,
      forecast: {
        periods: parseInt(periods),
        confidence: parseFloat(confidence),
        nextPeriodRevenue: forecast.predictions[0]?.revenue,
        growthTrend: forecast.trendAnalysis.direction
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(200).json({
      success: true,
      message: 'Revenue forecast analysis generated successfully',
      data: {
        forecast,
        seasonality,
        riskFactors,
        recommendations: generateForecastRecommendations(forecast, seasonality, riskFactors)
      }
    });
    
  } catch (error) {
    console.error('Error in getRevenueForecastAnalysis:', error);
    
    res.status(500).json({
      success: false,
      message: 'Error generating revenue forecast analysis',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get operational efficiency report
 * GET /api/analytics/operational-efficiency/:organizationId
 */
async function getOperationalEfficiencyReport(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { startDate, endDate } = req.query;
    
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
    
    const efficiency = await calculateOperationalEfficiency(db, organizationId, dateFilter);
    const bottlenecks = await identifyOperationalBottlenecks(db, organizationId, dateFilter);
    const optimization = await generateOptimizationSuggestions(efficiency, bottlenecks);
    
    logger.business('Operational Efficiency Report Generated', {
      event: 'operational_efficiency_report',
      organizationId,
      efficiency: {
        overallScore: efficiency.overallEfficiencyScore,
        revenuePerEmployee: efficiency.revenuePerEmployee,
        utilizationRate: efficiency.utilizationRate
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(200).json({
      success: true,
      message: 'Operational efficiency report generated successfully',
      data: {
        efficiency,
        bottlenecks,
        optimization,
        benchmarks: generateEfficiencyBenchmarks(efficiency)
      }
    });
    
  } catch (error) {
    console.error('Error in getOperationalEfficiencyReport:', error);
    
    res.status(500).json({
      success: false,
      message: 'Error generating operational efficiency report',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Generate revenue forecast
 */
async function generateRevenueForecast(db, organizationId, dateFilter, forecastPeriod) {
  // Get historical revenue data
  const historicalData = await db.collection('invoiceLineItems').aggregate([
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
          month: { $month: '$createdAt' }
        },
        revenue: { $sum: '$totalPrice' },
        items: { $sum: 1 },
        hours: { $sum: '$hours' }
      }
    },
    {
      $sort: { '_id.year': 1, '_id.month': 1 }
    }
  ]).toArray();
  
  // Calculate current period metrics
  const currentPeriod = {
    totalRevenue: historicalData.reduce((sum, d) => sum + d.revenue, 0),
    totalItems: historicalData.reduce((sum, d) => sum + d.items, 0),
    totalHours: historicalData.reduce((sum, d) => sum + d.hours, 0),
    avgMonthlyRevenue: historicalData.reduce((sum, d) => sum + d.revenue, 0) / Math.max(historicalData.length, 1)
  };
  
  // Simple linear regression for forecasting
  const forecast = calculateLinearForecast(historicalData, forecastPeriod);
  
  return {
    currentPeriod,
    historicalData,
    forecast,
    trendAnalysis: analyzeTrend(historicalData),
    confidence: calculateForecastConfidence(historicalData)
  };
}

/**
 * Analyze client retention
 */
async function analyzeClientRetention(db, organizationId, dateFilter) {
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
        totalRevenue: { $sum: '$totalPrice' },
        totalActivities: { $sum: 1 }
      }
    }
  ]).toArray();
  
  const now = new Date();
  const thirtyDaysAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
  const ninetyDaysAgo = new Date(now.getTime() - 90 * 24 * 60 * 60 * 1000);
  const oneYearAgo = new Date(now.getTime() - 365 * 24 * 60 * 60 * 1000);
  
  const activeClients = clientActivity.filter(c => c.lastActivity >= thirtyDaysAgo);
  const recentClients = clientActivity.filter(c => c.lastActivity >= ninetyDaysAgo);
  const yearlyClients = clientActivity.filter(c => c.firstActivity >= oneYearAgo);
  
  // Calculate cohort analysis
  const cohortAnalysis = calculateCohortAnalysis(clientActivity);
  
  return {
    totalClients: clientActivity.length,
    activeClients: activeClients.length,
    recentClients: recentClients.length,
    newClients: yearlyClients.length,
    retentionRate: (activeClients.length / Math.max(clientActivity.length, 1)) * 100,
    churnRate: ((clientActivity.length - recentClients.length) / Math.max(clientActivity.length, 1)) * 100,
    avgLifetimeValue: clientActivity.reduce((sum, c) => sum + c.totalRevenue, 0) / Math.max(clientActivity.length, 1),
    cohortAnalysis,
    retentionSegments: {
      highValue: activeClients.filter(c => c.totalRevenue > 1000).length,
      mediumValue: activeClients.filter(c => c.totalRevenue >= 500 && c.totalRevenue <= 1000).length,
      lowValue: activeClients.filter(c => c.totalRevenue < 500).length
    }
  };
}

/**
 * Get service utilization statistics
 */
async function getServiceUtilizationStats(db, organizationId, dateFilter) {
  const serviceStats = await db.collection('invoiceLineItems').aggregate([
    {
      $match: {
        organizationId,
        ...dateFilter
      }
    },
    {
      $group: {
        _id: '$supportItemNumber',
        usage: { $sum: 1 },
        revenue: { $sum: '$totalPrice' },
        hours: { $sum: '$hours' },
        uniqueClients: { $addToSet: '$clientId' },
        avgPrice: { $avg: '$unitPrice' }
      }
    },
    {
      $addFields: {
        supportItemNumber: '$_id',
        clientCount: { $size: '$uniqueClients' },
        revenuePerClient: { $divide: ['$revenue', { $size: '$uniqueClients' }] },
        utilizationScore: {
          $multiply: [
            { $divide: ['$usage', 100] },
            { $divide: ['$revenue', 1000] }
          ]
        }
      }
    },
    {
      $sort: { utilizationScore: -1 }
    }
  ]).toArray();
  
  const totalUsage = serviceStats.reduce((sum, s) => sum + s.usage, 0);
  const totalRevenue = serviceStats.reduce((sum, s) => sum + s.revenue, 0);
  
  return {
    services: serviceStats,
    summary: {
      totalServices: serviceStats.length,
      totalUsage,
      totalRevenue,
      avgUsagePerService: totalUsage / Math.max(serviceStats.length, 1),
      avgRevenuePerService: totalRevenue / Math.max(serviceStats.length, 1),
      topPerformingServices: serviceStats.slice(0, 5),
      underutilizedServices: serviceStats.filter(s => s.utilizationScore < 1)
    }
  };
}

/**
 * Get organizational growth metrics
 */
async function getOrganizationalGrowthMetrics(db, organizationId, dateFilter) {
  // Get monthly growth data
  const monthlyGrowth = await db.collection('invoiceLineItems').aggregate([
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
          month: { $month: '$createdAt' }
        },
        revenue: { $sum: '$totalPrice' },
        clients: { $addToSet: '$clientId' },
        items: { $sum: 1 }
      }
    },
    {
      $addFields: {
        clientCount: { $size: '$clients' }
      }
    },
    {
      $sort: { '_id.year': 1, '_id.month': 1 }
    }
  ]).toArray();
  
  // Calculate growth rates
  const revenueGrowthRate = calculateGrowthRate(monthlyGrowth.map(m => m.revenue));
  const clientGrowthRate = calculateGrowthRate(monthlyGrowth.map(m => m.clientCount));
  const activityGrowthRate = calculateGrowthRate(monthlyGrowth.map(m => m.items));
  
  return {
    monthlyGrowth,
    revenueGrowthRate,
    clientGrowthRate,
    activityGrowthRate,
    growthTrend: {
      revenue: revenueGrowthRate > 5 ? 'strong' : revenueGrowthRate > 0 ? 'moderate' : 'declining',
      clients: clientGrowthRate > 10 ? 'strong' : clientGrowthRate > 0 ? 'moderate' : 'declining',
      activity: activityGrowthRate > 15 ? 'strong' : activityGrowthRate > 0 ? 'moderate' : 'declining'
    },
    projectedGrowth: {
      nextMonthRevenue: monthlyGrowth[monthlyGrowth.length - 1]?.revenue * (1 + revenueGrowthRate / 100),
      nextMonthClients: Math.ceil(monthlyGrowth[monthlyGrowth.length - 1]?.clientCount * (1 + clientGrowthRate / 100))
    }
  };
}

/**
 * Get operational efficiency insights
 */
async function getOperationalEfficiencyInsights(db, organizationId, dateFilter) {
  // Get employee productivity data
  const employeeData = await db.collection('invoiceLineItems').aggregate([
    {
      $match: {
        organizationId,
        ...dateFilter
      }
    },
    {
      $group: {
        _id: '$employeeId',
        revenue: { $sum: '$totalPrice' },
        hours: { $sum: '$hours' },
        items: { $sum: 1 },
        clients: { $addToSet: '$clientId' }
      }
    },
    {
      $addFields: {
        revenuePerHour: { $divide: ['$revenue', '$hours'] },
        clientCount: { $size: '$clients' },
        itemsPerHour: { $divide: ['$items', '$hours'] }
      }
    }
  ]).toArray();
  
  const totalRevenue = employeeData.reduce((sum, e) => sum + e.revenue, 0);
  const totalHours = employeeData.reduce((sum, e) => sum + e.hours, 0);
  const totalEmployees = employeeData.length;
  
  return {
    employeeMetrics: employeeData,
    overallMetrics: {
      totalEmployees,
      totalRevenue,
      totalHours,
      revenuePerEmployee: totalRevenue / Math.max(totalEmployees, 1),
      hoursPerEmployee: totalHours / Math.max(totalEmployees, 1),
      revenuePerHour: totalRevenue / Math.max(totalHours, 1),
      utilizationRate: (totalHours / (totalEmployees * 40 * 4)) * 100 // Assuming 40 hours/week, 4 weeks/month
    },
    efficiency: {
      topPerformers: employeeData.sort((a, b) => b.revenuePerHour - a.revenuePerHour).slice(0, 5),
      avgRevenuePerHour: employeeData.reduce((sum, e) => sum + e.revenuePerHour, 0) / Math.max(employeeData.length, 1),
      overallEfficiencyScore: calculateEfficiencyScore(employeeData)
    }
  };
}

/**
 * Identify performance bottlenecks
 */
async function identifyPerformanceBottlenecks(db, organizationId, dateFilter) {
  const bottlenecks = [];
  
  // Check for low-performing services
  const lowPerformingServices = await db.collection('invoiceLineItems').aggregate([
    {
      $match: {
        organizationId,
        ...dateFilter
      }
    },
    {
      $group: {
        _id: '$supportItemNumber',
        avgRevenue: { $avg: '$totalPrice' },
        usage: { $sum: 1 }
      }
    },
    {
      $match: {
        $or: [
          { avgRevenue: { $lt: 50 } },
          { usage: { $lt: 5 } }
        ]
      }
    }
  ]).toArray();
  
  if (lowPerformingServices.length > 0) {
    bottlenecks.push({
      type: 'low_performing_services',
      severity: 'medium',
      count: lowPerformingServices.length,
      description: `${lowPerformingServices.length} services with low revenue or usage`,
      services: lowPerformingServices.slice(0, 5)
    });
  }
  
  // Check for inactive clients
  const inactiveClients = await db.collection('invoiceLineItems').aggregate([
    {
      $match: {
        organizationId,
        createdAt: { $lt: new Date(Date.now() - 90 * 24 * 60 * 60 * 1000) }
      }
    },
    {
      $group: {
        _id: '$clientId',
        lastActivity: { $max: '$createdAt' },
        totalRevenue: { $sum: '$totalPrice' }
      }
    },
    {
      $match: {
        totalRevenue: { $gt: 500 } // High-value clients
      }
    }
  ]).toArray();
  
  if (inactiveClients.length > 0) {
    bottlenecks.push({
      type: 'inactive_high_value_clients',
      severity: 'high',
      count: inactiveClients.length,
      description: `${inactiveClients.length} high-value clients inactive for 90+ days`,
      potentialRevenueLoss: inactiveClients.reduce((sum, c) => sum + c.totalRevenue, 0)
    });
  }
  
  return bottlenecks;
}

/**
 * Generate executive summary
 */
function generateExecutiveSummary(data) {
  const { revenueForecast, clientRetention, organizationalGrowth, operationalEfficiency } = data;
  
  return {
    keyMetrics: {
      currentRevenue: revenueForecast.currentPeriod.totalRevenue,
      forecastedGrowth: revenueForecast.forecast.growthRate,
      clientRetentionRate: clientRetention.retentionRate,
      operationalEfficiency: operationalEfficiency.efficiency.overallEfficiencyScore
    },
    insights: [
      {
        type: 'revenue',
        message: `Revenue ${revenueForecast.trendAnalysis.direction === 'increasing' ? 'trending upward' : 'needs attention'}`,
        impact: revenueForecast.trendAnalysis.direction === 'increasing' ? 'positive' : 'negative'
      },
      {
        type: 'retention',
        message: `Client retention at ${clientRetention.retentionRate.toFixed(1)}%`,
        impact: clientRetention.retentionRate > 80 ? 'positive' : 'negative'
      },
      {
        type: 'growth',
        message: `${organizationalGrowth.growthTrend.revenue} revenue growth trend`,
        impact: organizationalGrowth.revenueGrowthRate > 0 ? 'positive' : 'negative'
      }
    ],
    recommendations: generateExecutiveRecommendations(data)
  };
}

/**
 * Helper functions for calculations
 */
function calculateLinearForecast(data, periods) {
  if (data.length < 2) {
    return {
      nextPeriodRevenue: data[0]?.revenue || 0,
      growthRate: 0,
      confidence: 'low'
    };
  }
  
  const revenues = data.map(d => d.revenue);
  const n = revenues.length;
  const sumX = (n * (n + 1)) / 2;
  const sumY = revenues.reduce((sum, r) => sum + r, 0);
  const sumXY = revenues.reduce((sum, r, i) => sum + r * (i + 1), 0);
  const sumX2 = (n * (n + 1) * (2 * n + 1)) / 6;
  
  const slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
  const intercept = (sumY - slope * sumX) / n;
  
  const nextPeriodRevenue = slope * (n + 1) + intercept;
  const growthRate = ((nextPeriodRevenue - revenues[n - 1]) / revenues[n - 1]) * 100;
  
  return {
    nextPeriodRevenue,
    growthRate,
    slope,
    intercept,
    confidence: n > 6 ? 'high' : n > 3 ? 'medium' : 'low'
  };
}

function analyzeTrend(data) {
  if (data.length < 3) return { direction: 'insufficient_data', strength: 'unknown' };
  
  const revenues = data.map(d => d.revenue);
  const recent = revenues.slice(-3);
  const earlier = revenues.slice(0, 3);
  
  const recentAvg = recent.reduce((sum, r) => sum + r, 0) / recent.length;
  const earlierAvg = earlier.reduce((sum, r) => sum + r, 0) / earlier.length;
  
  const change = (recentAvg - earlierAvg) / earlierAvg;
  
  return {
    direction: change > 0.1 ? 'increasing' : change < -0.1 ? 'decreasing' : 'stable',
    strength: Math.abs(change) > 0.2 ? 'strong' : Math.abs(change) > 0.1 ? 'moderate' : 'weak',
    changePercentage: change * 100
  };
}

function calculateForecastConfidence(data) {
  const revenues = data.map(d => d.revenue);
  const mean = revenues.reduce((sum, r) => sum + r, 0) / revenues.length;
  const variance = revenues.reduce((sum, r) => sum + Math.pow(r - mean, 2), 0) / revenues.length;
  const coefficient = Math.sqrt(variance) / mean;
  
  return {
    level: coefficient < 0.2 ? 'high' : coefficient < 0.5 ? 'medium' : 'low',
    coefficient,
    dataPoints: revenues.length
  };
}

function calculateCohortAnalysis(clientActivity) {
  // Simple cohort analysis by month
  const cohorts = {};
  
  clientActivity.forEach(client => {
    const cohortMonth = `${client.firstActivity.getFullYear()}-${client.firstActivity.getMonth() + 1}`;
    if (!cohorts[cohortMonth]) {
      cohorts[cohortMonth] = {
        totalClients: 0,
        activeClients: 0,
        totalRevenue: 0
      };
    }
    
    cohorts[cohortMonth].totalClients++;
    cohorts[cohortMonth].totalRevenue += client.totalRevenue;
    
    // Check if client is still active (activity within last 30 days)
    const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
    if (client.lastActivity >= thirtyDaysAgo) {
      cohorts[cohortMonth].activeClients++;
    }
  });
  
  return Object.entries(cohorts).map(([month, data]) => ({
    cohortMonth: month,
    ...data,
    retentionRate: (data.activeClients / data.totalClients) * 100
  }));
}

function calculateGrowthRate(values) {
  if (values.length < 2) return 0;
  
  const recent = values.slice(-3);
  const earlier = values.slice(0, 3);
  
  const recentAvg = recent.reduce((sum, v) => sum + v, 0) / recent.length;
  const earlierAvg = earlier.reduce((sum, v) => sum + v, 0) / earlier.length;
  
  return ((recentAvg - earlierAvg) / earlierAvg) * 100;
}

function calculateEfficiencyScore(employeeData) {
  if (employeeData.length === 0) return 0;
  
  const avgRevenuePerHour = employeeData.reduce((sum, e) => sum + e.revenuePerHour, 0) / employeeData.length;
  const avgItemsPerHour = employeeData.reduce((sum, e) => sum + e.itemsPerHour, 0) / employeeData.length;
  
  // Normalize to 0-100 scale (assuming $50/hour and 2 items/hour as benchmarks)
  const revenueScore = Math.min((avgRevenuePerHour / 50) * 50, 50);
  const productivityScore = Math.min((avgItemsPerHour / 2) * 50, 50);
  
  return revenueScore + productivityScore;
}

function generateExecutiveRecommendations(data) {
  const recommendations = [];
  
  if (data.revenueForecast.trendAnalysis.direction === 'decreasing') {
    recommendations.push({
      priority: 'high',
      category: 'revenue',
      action: 'Investigate revenue decline and implement growth strategies'
    });
  }
  
  if (data.clientRetention.retentionRate < 70) {
    recommendations.push({
      priority: 'high',
      category: 'retention',
      action: 'Focus on client retention initiatives and satisfaction programs'
    });
  }
  
  if (data.operationalEfficiency.efficiency.overallEfficiencyScore < 60) {
    recommendations.push({
      priority: 'medium',
      category: 'efficiency',
      action: 'Review operational processes and employee productivity'
    });
  }
  
  return recommendations;
}

module.exports = {
  getBusinessIntelligenceDashboard,
  getRevenueForecastAnalysis,
  getOperationalEfficiencyReport
};