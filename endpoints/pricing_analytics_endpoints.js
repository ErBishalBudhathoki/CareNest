/**
 * Pricing Analytics Endpoints
 * 
 * Provides comprehensive analytics for pricing patterns including:
 * - Custom vs Standard pricing usage
 * - NDIS compliance rates
 * - Price cap violations
 * - Pricing trends and patterns
 * - Organization-level pricing insights
 */

const { MongoClient } = require('mongodb');
const logger = require('../config/logger');
const { createAuditLog } = require('../../audit_trail_endpoints');

/**
 * Get comprehensive pricing analytics
 * GET /api/analytics/pricing/:organizationId
 */
async function getPricingAnalytics(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { startDate, endDate, clientId, userEmail } = req.query;
    
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
    
    // Build organization filter
    const orgFilter = { organizationId, ...dateFilter };
    if (clientId) {
      orgFilter.clientId = clientId;
    }
    
    // Get custom pricing data
    const customPricing = await db.collection('customPricing').find(orgFilter).toArray();
    
    // Get invoice line items for pricing analysis
    const invoiceItems = await db.collection('invoiceLineItems').find(orgFilter).toArray();
    
    // Get NDIS pricing data for comparison
    const ndisPricing = await db.collection('ndisPricing').find({}).toArray();
    
    // Calculate pricing metrics
    const metrics = calculatePricingMetrics(customPricing, invoiceItems, ndisPricing);
    
    // Get pricing trends
    const trends = await calculatePricingTrends(db, organizationId, startDate, endDate);
    
    // Get client-specific pricing patterns
    const clientPatterns = await getClientPricingPatterns(db, organizationId, startDate, endDate);
    
    // Log analytics access
    logger.business('Pricing Analytics Accessed', {
      event: 'pricing_analytics_accessed',
      organizationId,
      userEmail: userEmail || 'system',
      dateRange: { startDate, endDate },
      filters: { clientId },
      metrics: {
        customPricingCount: customPricing.length,
        invoiceItemsCount: invoiceItems.length,
        totalRevenue: metrics.totalRevenue,
        complianceRate: metrics.complianceRate
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(200).json({
      success: true,
      message: 'Pricing analytics retrieved successfully',
      data: {
        metrics,
        trends,
        clientPatterns,
        summary: {
          totalCustomPricing: customPricing.length,
          totalInvoiceItems: invoiceItems.length,
          dateRange: { startDate, endDate },
          organizationId,
          generatedAt: new Date().toISOString()
        }
      }
    });
    
  } catch (error) {
    console.error('Error in getPricingAnalytics:', error);
    
    logger.business('Pricing Analytics Error', {
      event: 'pricing_analytics_error',
      organizationId: req.params.organizationId,
      error: {
        message: error.message,
        stack: error.stack
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(500).json({
      success: false,
      message: 'Error retrieving pricing analytics',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get pricing compliance report
 * GET /api/analytics/pricing/compliance/:organizationId
 */
async function getPricingComplianceReport(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { startDate, endDate, threshold = 0.95 } = req.query;
    
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    // Get pricing compliance data
    const complianceData = await calculateComplianceMetrics(db, organizationId, startDate, endDate);
    
    // Identify violations and patterns
    const violations = await identifyPricingViolations(db, organizationId, startDate, endDate);
    
    // Generate recommendations
    const recommendations = generateComplianceRecommendations(complianceData, violations, threshold);
    
    logger.business('Pricing Compliance Report Generated', {
      event: 'pricing_compliance_report',
      organizationId,
      complianceData: {
        overallCompliance: complianceData.overallCompliance,
        totalViolations: violations.length,
        criticalViolations: violations.filter(v => v.severity === 'critical').length
      },
      timestamp: new Date().toISOString()
    });
    
    res.status(200).json({
      success: true,
      message: 'Pricing compliance report generated successfully',
      data: {
        compliance: complianceData,
        violations,
        recommendations,
        summary: {
          overallCompliance: complianceData.overallCompliance,
          meetsThreshold: complianceData.overallCompliance >= threshold,
          totalViolations: violations.length,
          generatedAt: new Date().toISOString()
        }
      }
    });
    
  } catch (error) {
    console.error('Error in getPricingComplianceReport:', error);
    
    res.status(500).json({
      success: false,
      message: 'Error generating pricing compliance report',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Calculate comprehensive pricing metrics
 */
function calculatePricingMetrics(customPricing, invoiceItems, ndisPricing) {
  const totalItems = invoiceItems.length;
  const customPricedItems = invoiceItems.filter(item => item.pricingSource === 'custom');
  const standardPricedItems = invoiceItems.filter(item => item.pricingSource === 'standard');
  const ndisPricedItems = invoiceItems.filter(item => item.pricingSource === 'ndis');
  
  const totalRevenue = invoiceItems.reduce((sum, item) => sum + (item.totalPrice || 0), 0);
  const customRevenue = customPricedItems.reduce((sum, item) => sum + (item.totalPrice || 0), 0);
  const standardRevenue = standardPricedItems.reduce((sum, item) => sum + (item.totalPrice || 0), 0);
  const ndisRevenue = ndisPricedItems.reduce((sum, item) => sum + (item.totalPrice || 0), 0);
  
  // Calculate compliance metrics
  const compliantItems = invoiceItems.filter(item => item.isCompliant !== false);
  const complianceRate = (compliantItems.length / Math.max(totalItems, 1)) * 100;
  
  // Calculate average pricing
  const avgCustomPrice = customRevenue / Math.max(customPricedItems.length, 1);
  const avgStandardPrice = standardRevenue / Math.max(standardPricedItems.length, 1);
  const avgNdisPrice = ndisRevenue / Math.max(ndisPricedItems.length, 1);
  
  return {
    // Volume metrics
    totalItems,
    customPricedItems: customPricedItems.length,
    standardPricedItems: standardPricedItems.length,
    ndisPricedItems: ndisPricedItems.length,
    
    // Usage percentages
    customPricingPercentage: (customPricedItems.length / Math.max(totalItems, 1)) * 100,
    standardPricingPercentage: (standardPricedItems.length / Math.max(totalItems, 1)) * 100,
    ndisPricingPercentage: (ndisPricedItems.length / Math.max(totalItems, 1)) * 100,
    
    // Revenue metrics
    totalRevenue,
    customRevenue,
    standardRevenue,
    ndisRevenue,
    
    // Revenue percentages
    customRevenuePercentage: (customRevenue / Math.max(totalRevenue, 1)) * 100,
    standardRevenuePercentage: (standardRevenue / Math.max(totalRevenue, 1)) * 100,
    ndisRevenuePercentage: (ndisRevenue / Math.max(totalRevenue, 1)) * 100,
    
    // Average pricing
    avgCustomPrice,
    avgStandardPrice,
    avgNdisPrice,
    
    // Compliance metrics
    complianceRate,
    compliantItems: compliantItems.length,
    nonCompliantItems: totalItems - compliantItems.length,
    
    // Pricing efficiency
    pricingEfficiency: {
      customVsStandard: avgCustomPrice / Math.max(avgStandardPrice, 1),
      customVsNdis: avgCustomPrice / Math.max(avgNdisPrice, 1),
      revenuePerItem: totalRevenue / Math.max(totalItems, 1)
    }
  };
}

/**
 * Calculate pricing trends over time
 */
async function calculatePricingTrends(db, organizationId, startDate, endDate) {
  const pipeline = [
    {
      $match: {
        organizationId,
        ...(startDate && endDate ? {
          createdAt: {
            $gte: new Date(startDate),
            $lte: new Date(endDate)
          }
        } : {})
      }
    },
    {
      $group: {
        _id: {
          year: { $year: '$createdAt' },
          month: { $month: '$createdAt' },
          pricingSource: '$pricingSource'
        },
        count: { $sum: 1 },
        totalRevenue: { $sum: '$totalPrice' },
        avgPrice: { $avg: '$totalPrice' }
      }
    },
    {
      $sort: { '_id.year': 1, '_id.month': 1 }
    }
  ];
  
  const trends = await db.collection('invoiceLineItems').aggregate(pipeline).toArray();
  
  return {
    monthlyTrends: trends,
    summary: {
      totalMonths: [...new Set(trends.map(t => `${t._id.year}-${t._id.month}`))].length,
      pricingSources: [...new Set(trends.map(t => t._id.pricingSource))],
      trendDirection: calculateTrendDirection(trends)
    }
  };
}

/**
 * Get client-specific pricing patterns
 */
async function getClientPricingPatterns(db, organizationId, startDate, endDate) {
  const pipeline = [
    {
      $match: {
        organizationId,
        ...(startDate && endDate ? {
          createdAt: {
            $gte: new Date(startDate),
            $lte: new Date(endDate)
          }
        } : {})
      }
    },
    {
      $group: {
        _id: {
          clientId: '$clientId',
          pricingSource: '$pricingSource'
        },
        count: { $sum: 1 },
        totalRevenue: { $sum: '$totalPrice' },
        avgPrice: { $avg: '$totalPrice' }
      }
    },
    {
      $group: {
        _id: '$_id.clientId',
        pricingBreakdown: {
          $push: {
            source: '$_id.pricingSource',
            count: '$count',
            revenue: '$totalRevenue',
            avgPrice: '$avgPrice'
          }
        },
        totalItems: { $sum: '$count' },
        totalRevenue: { $sum: '$totalRevenue' }
      }
    }
  ];
  
  const patterns = await db.collection('invoiceLineItems').aggregate(pipeline).toArray();
  
  return patterns.map(pattern => ({
    clientId: pattern._id,
    totalItems: pattern.totalItems,
    totalRevenue: pattern.totalRevenue,
    avgRevenuePerItem: pattern.totalRevenue / Math.max(pattern.totalItems, 1),
    pricingBreakdown: pattern.pricingBreakdown,
    dominantPricingSource: pattern.pricingBreakdown.reduce((max, current) => 
      current.count > max.count ? current : max, pattern.pricingBreakdown[0]
    )?.source
  }));
}

/**
 * Calculate compliance metrics
 */
async function calculateComplianceMetrics(db, organizationId, startDate, endDate) {
  const filter = {
    organizationId,
    ...(startDate && endDate ? {
      createdAt: {
        $gte: new Date(startDate),
        $lte: new Date(endDate)
      }
    } : {})
  };
  
  const totalItems = await db.collection('invoiceLineItems').countDocuments(filter);
  const compliantItems = await db.collection('invoiceLineItems').countDocuments({
    ...filter,
    isCompliant: { $ne: false }
  });
  
  const overallCompliance = (compliantItems / Math.max(totalItems, 1)) * 100;
  
  return {
    totalItems,
    compliantItems,
    nonCompliantItems: totalItems - compliantItems,
    overallCompliance,
    complianceGrade: overallCompliance >= 95 ? 'A' : overallCompliance >= 85 ? 'B' : overallCompliance >= 70 ? 'C' : 'D'
  };
}

/**
 * Identify pricing violations
 */
async function identifyPricingViolations(db, organizationId, startDate, endDate) {
  const filter = {
    organizationId,
    isCompliant: false,
    ...(startDate && endDate ? {
      createdAt: {
        $gte: new Date(startDate),
        $lte: new Date(endDate)
      }
    } : {})
  };
  
  const violations = await db.collection('invoiceLineItems').find(filter).toArray();
  
  return violations.map(violation => ({
    itemId: violation._id,
    clientId: violation.clientId,
    supportItemNumber: violation.supportItemNumber,
    unitPrice: violation.unitPrice,
    violationType: violation.violationType || 'price_cap_exceeded',
    severity: violation.unitPrice > 200 ? 'critical' : violation.unitPrice > 100 ? 'high' : 'medium',
    amount: violation.totalPrice,
    date: violation.createdAt
  }));
}

/**
 * Generate compliance recommendations
 */
function generateComplianceRecommendations(complianceData, violations, threshold) {
  const recommendations = [];
  
  if (complianceData.overallCompliance < threshold * 100) {
    recommendations.push({
      type: 'compliance',
      priority: 'high',
      message: `Compliance rate (${complianceData.overallCompliance.toFixed(2)}%) is below threshold (${(threshold * 100)}%)`,
      action: 'Review and adjust pricing to meet NDIS compliance requirements'
    });
  }
  
  const criticalViolations = violations.filter(v => v.severity === 'critical');
  if (criticalViolations.length > 0) {
    recommendations.push({
      type: 'critical_violations',
      priority: 'urgent',
      message: `${criticalViolations.length} critical pricing violations found`,
      action: 'Immediately review and correct items with prices exceeding $200'
    });
  }
  
  if (violations.length > 10) {
    recommendations.push({
      type: 'volume_violations',
      priority: 'medium',
      message: `High number of violations (${violations.length}) detected`,
      action: 'Consider implementing automated pricing validation'
    });
  }
  
  return recommendations;
}

/**
 * Calculate trend direction
 */
function calculateTrendDirection(trends) {
  if (trends.length < 2) return 'insufficient_data';
  
  const recent = trends.slice(-3);
  const earlier = trends.slice(0, 3);
  
  const recentAvg = recent.reduce((sum, t) => sum + t.totalRevenue, 0) / recent.length;
  const earlierAvg = earlier.reduce((sum, t) => sum + t.totalRevenue, 0) / earlier.length;
  
  if (recentAvg > earlierAvg * 1.1) return 'increasing';
  if (recentAvg < earlierAvg * 0.9) return 'decreasing';
  return 'stable';
}

module.exports = {
  getPricingAnalytics,
  getPricingComplianceReport
};