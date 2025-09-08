/**
 * Prometheus Metrics Endpoints
 * 
 * This module provides Prometheus-compatible metrics endpoints for monitoring
 * system health, business metrics, and application performance.
 */

const express = require('express');
const router = express.Router();
const { getSystemHealthSnapshot } = require('../middleware/systemHealth');
const logger = require('../config/logger');
const { MongoClient, ServerApiVersion } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../../.env') });

const uri = process.env.MONGODB_URI;

/**
 * Convert metrics to Prometheus format
 */
function formatPrometheusMetrics(metrics) {
  let output = '';
  
  // System metrics
  output += `# HELP nodejs_memory_rss_bytes Process resident memory size in bytes\n`;
  output += `# TYPE nodejs_memory_rss_bytes gauge\n`;
  output += `nodejs_memory_rss_bytes ${metrics.memory.rss * 1024 * 1024}\n\n`;
  
  output += `# HELP nodejs_memory_heap_used_bytes Process heap memory used in bytes\n`;
  output += `# TYPE nodejs_memory_heap_used_bytes gauge\n`;
  output += `nodejs_memory_heap_used_bytes ${metrics.memory.heapUsed * 1024 * 1024}\n\n`;
  
  output += `# HELP nodejs_memory_heap_total_bytes Process heap memory total in bytes\n`;
  output += `# TYPE nodejs_memory_heap_total_bytes gauge\n`;
  output += `nodejs_memory_heap_total_bytes ${metrics.memory.heapTotal * 1024 * 1024}\n\n`;
  
  output += `# HELP system_memory_usage_percent System memory usage percentage\n`;
  output += `# TYPE system_memory_usage_percent gauge\n`;
  output += `system_memory_usage_percent ${metrics.system.memoryUsagePercent}\n\n`;
  
  output += `# HELP system_load_average_1m System load average over 1 minute\n`;
  output += `# TYPE system_load_average_1m gauge\n`;
  output += `system_load_average_1m ${metrics.system.loadAverage1m}\n\n`;
  
  output += `# HELP system_load_average_5m System load average over 5 minutes\n`;
  output += `# TYPE system_load_average_5m gauge\n`;
  output += `system_load_average_5m ${metrics.system.loadAverage5m}\n\n`;
  
  output += `# HELP system_load_average_15m System load average over 15 minutes\n`;
  output += `# TYPE system_load_average_15m gauge\n`;
  output += `system_load_average_15m ${metrics.system.loadAverage15m}\n\n`;
  
  // Application metrics
  output += `# HELP http_requests_total Total number of HTTP requests\n`;
  output += `# TYPE http_requests_total counter\n`;
  output += `http_requests_total ${metrics.application.totalRequests}\n\n`;
  
  output += `# HELP http_request_errors_total Total number of HTTP request errors\n`;
  output += `# TYPE http_request_errors_total counter\n`;
  output += `http_request_errors_total ${metrics.application.totalErrors}\n\n`;
  
  output += `# HELP http_request_duration_ms Average HTTP request duration in milliseconds\n`;
  output += `# TYPE http_request_duration_ms gauge\n`;
  output += `http_request_duration_ms ${metrics.application.averageResponseTime}\n\n`;
  
  output += `# HELP http_request_error_rate HTTP request error rate percentage\n`;
  output += `# TYPE http_request_error_rate gauge\n`;
  output += `http_request_error_rate ${metrics.application.errorRate}\n\n`;
  
  output += `# HELP process_uptime_seconds Process uptime in seconds\n`;
  output += `# TYPE process_uptime_seconds gauge\n`;
  output += `process_uptime_seconds ${metrics.application.uptime}\n\n`;
  
  return output;
}

/**
 * Get business metrics from database
 */
async function getBusinessMetrics() {
  const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
  
  try {
    await client.connect();
    const db = client.db('Invoice');
    
    // Get total organizations
    const totalOrganizations = await db.collection('organizations').countDocuments();
    
    // Get total users
    const totalUsers = await db.collection('login').countDocuments();
    
    // Get total clients
    const totalClients = await db.collection('clients').countDocuments();
    
    // Get total assignments
    const totalAssignments = await db.collection('clientAssignments').countDocuments();
    
    // Get active assignments (today)
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    
    const activeAssignments = await db.collection('clientAssignments').countDocuments({
      date: {
        $gte: today.toISOString().split('T')[0],
        $lt: tomorrow.toISOString().split('T')[0]
      }
    });
    
    // Get recent invoices (last 30 days)
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    
    const recentInvoices = await db.collection('invoices').countDocuments({
      createdAt: { $gte: thirtyDaysAgo }
    });
    
    return {
      totalOrganizations,
      totalUsers,
      totalClients,
      totalAssignments,
      activeAssignments,
      recentInvoices
    };
    
  } finally {
    await client.close();
  }
}

/**
 * Format business metrics for Prometheus
 */
function formatBusinessMetrics(metrics) {
  let output = '';
  
  output += `# HELP invoice_organizations_total Total number of organizations\n`;
  output += `# TYPE invoice_organizations_total gauge\n`;
  output += `invoice_organizations_total ${metrics.totalOrganizations}\n\n`;
  
  output += `# HELP invoice_users_total Total number of users\n`;
  output += `# TYPE invoice_users_total gauge\n`;
  output += `invoice_users_total ${metrics.totalUsers}\n\n`;
  
  output += `# HELP invoice_clients_total Total number of clients\n`;
  output += `# TYPE invoice_clients_total gauge\n`;
  output += `invoice_clients_total ${metrics.totalClients}\n\n`;
  
  output += `# HELP invoice_assignments_total Total number of assignments\n`;
  output += `# TYPE invoice_assignments_total gauge\n`;
  output += `invoice_assignments_total ${metrics.totalAssignments}\n\n`;
  
  output += `# HELP invoice_assignments_active Active assignments today\n`;
  output += `# TYPE invoice_assignments_active gauge\n`;
  output += `invoice_assignments_active ${metrics.activeAssignments}\n\n`;
  
  output += `# HELP invoice_invoices_recent Recent invoices (last 30 days)\n`;
  output += `# TYPE invoice_invoices_recent gauge\n`;
  output += `invoice_invoices_recent ${metrics.recentInvoices}\n\n`;
  
  return output;
}

/**
 * Main Prometheus metrics endpoint
 * GET /metrics
 */
router.get('/metrics', async (req, res) => {
  try {
    const systemHealth = getSystemHealthSnapshot();
    const businessMetrics = await getBusinessMetrics();
    
    let output = '';
    output += formatPrometheusMetrics(systemHealth);
    output += formatBusinessMetrics(businessMetrics);
    
    res.set('Content-Type', 'text/plain; version=0.0.4; charset=utf-8');
    res.send(output);
    
    // Log metrics access
    logger.business('Prometheus Metrics Accessed', {
      event: 'prometheus_metrics_accessed',
      timestamp: new Date().toISOString(),
      ip: req.ip,
      userAgent: req.get('User-Agent')
    });
    
  } catch (error) {
    console.error('Error generating metrics:', error);
    res.status(500).send('Error generating metrics');
  }
});

/**
 * System health metrics endpoint
 * GET /api/metrics/system
 */
router.get('/api/metrics/system', async (req, res) => {
  try {
    const systemHealth = getSystemHealthSnapshot();
    const output = formatPrometheusMetrics(systemHealth);
    
    res.set('Content-Type', 'text/plain; version=0.0.4; charset=utf-8');
    res.send(output);
    
    // Log system metrics access
    logger.business('System Metrics Accessed', {
      event: 'system_metrics_accessed',
      timestamp: new Date().toISOString(),
      ip: req.ip,
      userAgent: req.get('User-Agent')
    });
    
  } catch (error) {
    console.error('Error generating system metrics:', error);
    res.status(500).send('Error generating system metrics');
  }
});

/**
 * Business metrics endpoint
 * GET /api/metrics/business
 */
router.get('/api/metrics/business', async (req, res) => {
  try {
    const businessMetrics = await getBusinessMetrics();
    const output = formatBusinessMetrics(businessMetrics);
    
    res.set('Content-Type', 'text/plain; version=0.0.4; charset=utf-8');
    res.send(output);
    
    // Log business metrics access
    logger.business('Business Metrics Accessed', {
      event: 'business_metrics_accessed',
      timestamp: new Date().toISOString(),
      ip: req.ip,
      userAgent: req.get('User-Agent')
    });
    
  } catch (error) {
    console.error('Error generating business metrics:', error);
    res.status(500).send('Error generating business metrics');
  }
});

module.exports = router;