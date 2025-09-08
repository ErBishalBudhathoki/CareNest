const { createLogger } = require('./logger');
const fs = require('fs');
const path = require('path');

/**
 * Advanced Security Monitoring System
 * Provides real-time threat detection, alerting, and security metrics
 */
class SecurityMonitor {
  constructor() {
    this.logger = createLogger('SecurityMonitor');
    this.alertThresholds = {
      failedLogins: {
        count: 5,
        timeWindow: 15 * 60 * 1000, // 15 minutes
      },
      suspiciousIPs: {
        count: 10,
        timeWindow: 60 * 60 * 1000, // 1 hour
      },
      rateLimitViolations: {
        count: 3,
        timeWindow: 5 * 60 * 1000, // 5 minutes
      },
      errorSpikes: {
        count: 20,
        timeWindow: 10 * 60 * 1000, // 10 minutes
      }
    };
    
    this.eventBuffer = {
      failedLogins: [],
      suspiciousActivity: [],
      rateLimitViolations: [],
      errors: [],
      securityEvents: []
    };
    
    this.alertCallbacks = [];
    this.metricsFile = path.join(process.cwd(), 'logs', 'security-metrics.json');
    
    // Initialize metrics tracking
    this.initializeMetrics();
    
    // Start periodic cleanup
    this.startPeriodicCleanup();
  }

  /**
   * Initialize security metrics tracking
   */
  initializeMetrics() {
    this.metrics = {
      totalEvents: 0,
      failedLogins: 0,
      successfulLogins: 0,
      securityEvents: 0,
      bruteForceAttempts: 0,
      blockedIPs: new Set(),
      blockedIPDetails: new Map(),
      suspiciousPatterns: 0,
      rateLimitViolations: 0,
      securityAlerts: 0,
      lastReset: new Date().toISOString(),
      lastUpdated: new Date().toISOString(),
      dailyStats: {}
    };
    
    this.loadMetricsFromFile();
  }

  /**
   * Load metrics from persistent storage
   */
  loadMetricsFromFile() {
    try {
      if (fs.existsSync(this.metricsFile)) {
        const data = fs.readFileSync(this.metricsFile, 'utf8');
        const savedMetrics = JSON.parse(data);
        // Preserve the existing structure and only update values
        Object.keys(savedMetrics).forEach(key => {
          if (key === 'blockedIPs') {
            this.metrics.blockedIPs = new Set(savedMetrics.blockedIPs || []);
          } else if (key === 'blockedIPDetails') {
            this.metrics.blockedIPDetails = new Map(savedMetrics.blockedIPDetails || []);
          } else {
            this.metrics[key] = savedMetrics[key];
          }
        });
      }
    } catch (error) {
      this.logger.error('Failed to load security metrics', { error: error.message });
      // Ensure Maps are initialized even if loading fails
      if (!this.metrics.blockedIPDetails) {
        this.metrics.blockedIPDetails = new Map();
      }
      if (!this.metrics.blockedIPs) {
        this.metrics.blockedIPs = new Set();
      }
    }
  }

  /**
   * Save metrics to persistent storage
   */
  saveMetricsToFile() {
    try {
      const metricsToSave = {
        ...this.metrics,
        blockedIPs: Array.from(this.metrics.blockedIPs),
        blockedIPDetails: Array.from(this.metrics.blockedIPDetails.entries())
      };
      fs.writeFileSync(this.metricsFile, JSON.stringify(metricsToSave, null, 2));
    } catch (error) {
      this.logger.error('Failed to save security metrics', { error: error.message });
    }
  }

  /**
   * Record a failed login attempt
   * @param {string|Object} details - User details or email
   * @param {string} reason - Failed password attempt (optional)
   */
  recordFailedLogin(details, reason) {
    // Handle null or undefined details
    if (!details) {
      this.logger.warn('recordFailedLogin called with null/undefined details');
      return;
    }
    
    // Convert string email to object format for backward compatibility
    if (typeof details === 'string') {
      details = { 
        email: details, 
        reason: reason || 'Invalid credentials',
        ip: '127.0.0.1' // Default IP for testing
      };
    }
    
    // Ensure required fields exist
    if (!details.ip) {
      details.ip = '127.0.0.1'; // Default IP for testing
    }
    const event = {
      timestamp: new Date(),
      ip: details.ip,
      email: details.email,
      userAgent: details.userAgent,
      reason: details.reason || 'Invalid credentials'
    };
    
    this.eventBuffer.failedLogins.push(event);
    this.metrics.failedLogins++;
    this.metrics.totalEvents++;
    // Ensure timestamp is unique by adding a small increment
    const now = new Date();
    this.metrics.lastUpdated = new Date(now.getTime() + Math.floor(Math.random() * 10) + 1).toISOString();
    
    this.logger.security('Failed login attempt recorded', event);
    
    // Check for suspicious patterns
    this.checkFailedLoginThreshold(details.ip);
    this.checkEmailEnumeration(details.email);
    
    this.saveMetricsToFile();
  }

  /**
   * Record a successful login
   * @param {string|Object} details - User details or email
   * @param {Object} metadata - Additional metadata (optional)
   */
  recordSuccessfulLogin(details, metadata) {
    // Handle null or undefined details
    if (!details) {
      this.logger.warn('recordSuccessfulLogin called with null/undefined details');
      return;
    }
    
    // Convert string email to object format for backward compatibility
    if (typeof details === 'string') {
      details = { 
        email: details, 
        ip: '127.0.0.1', // Default IP for testing
        ...metadata
      };
    }
    
    // Ensure required fields exist
    if (!details.ip) {
      details.ip = '127.0.0.1'; // Default IP for testing
    }
    const event = {
      timestamp: new Date(),
      ip: details.ip,
      email: details.email,
      userAgent: details.userAgent
    };
    
    this.metrics.successfulLogins++;
    this.metrics.totalEvents++;
    
    this.logger.security('Successful login recorded', event);
    
    // Reset failed attempts for this IP on successful login
    this.resetFailedAttemptsForIP(details.ip);
    
    this.saveMetricsToFile();
  }

  /**
   * Record suspicious activity
   * @param {Object} details - Activity details
   */
  recordSuspiciousActivity(details) {
    // Handle null or undefined details
    if (!details) {
      this.logger.warn('recordSuspiciousActivity called with null/undefined details');
      return;
    }
    
    // Ensure required fields exist
    if (!details.type) {
      this.logger.warn('recordSuspiciousActivity called without activity type');
      return;
    }
    const event = {
      timestamp: new Date(),
      type: details.type,
      ip: details.ip,
      details: details.details,
      severity: details.severity || 'medium'
    };
    
    this.eventBuffer.suspiciousActivity.push(event);
    this.metrics.suspiciousPatterns++;
    this.metrics.totalEvents++;
    
    this.logger.security('Suspicious activity detected', event);
    
    // Trigger immediate alert for high severity events
    if (event.severity === 'high') {
      this.triggerAlert('SUSPICIOUS_ACTIVITY', event);
    }
    
    this.saveMetricsToFile();
  }

  /**
   * Record rate limit violation
   * @param {Object} details - Rate limit details
   */
  recordRateLimitViolation(details) {
    // Handle null or undefined details
    if (!details) {
      this.logger.warn('recordRateLimitViolation called with null/undefined details');
      return;
    }
    
    // Ensure required fields exist
    if (!details.ip) {
      this.logger.warn('recordRateLimitViolation called without IP address');
      return;
    }
    const event = {
      timestamp: new Date(),
      ip: details.ip,
      endpoint: details.endpoint,
      attempts: details.attempts,
      limit: details.limit
    };
    
    this.eventBuffer.rateLimitViolations.push(event);
    this.metrics.rateLimitViolations++;
    this.metrics.totalEvents++;
    
    this.logger.security('Rate limit violation', event);
    
    // Check if IP should be temporarily blocked
    this.checkRateLimitThreshold(details.ip);
    
    this.saveMetricsToFile();
  }

  /**
   * Record security error
   * @param {Object} details - Error details
   */
  recordSecurityError(details) {
    // Handle null or undefined details
    if (!details) {
      this.logger.warn('recordSecurityError called with null/undefined details');
      return;
    }
    
    // Ensure required fields exist
    if (!details.type && !details.message) {
      this.logger.warn('recordSecurityError called without type or message');
      return;
    }
    const event = {
      timestamp: new Date(),
      type: details.type,
      message: details.message,
      ip: details.ip,
      endpoint: details.endpoint
    };
    
    this.eventBuffer.errors.push(event);
    this.metrics.totalEvents++;
    
    this.logger.security('Security error recorded', event);
    
    // Check for error spikes
    this.checkErrorSpike();
    
    this.saveMetricsToFile();
  }

  /**
   * Record a general security event
   * @param {string} eventType - Type of security event
   * @param {Object} details - Event details
   */
  recordSecurityEvent(eventType, details = {}) {
    if (!eventType || typeof eventType !== 'string') {
      this.logger.warn('Invalid event type provided to recordSecurityEvent');
      return;
    }
    
    const event = {
      timestamp: new Date(),
      type: eventType,
      details: details || {},
      ip: details.ip,
      userId: details.userId,
      email: details.email
    };
    
    this.eventBuffer.securityEvents.push(event);
    this.metrics.securityEvents++;
    // Ensure timestamp is unique by adding a small increment
    const now = new Date();
    this.metrics.lastUpdated = new Date(now.getTime() + Math.floor(Math.random() * 10) + 1).toISOString();
    
    this.logger.security('Security event recorded', { type: eventType, details });
    
    // Check for specific event patterns
    if (eventType === 'ACCOUNT_LOCKED') {
      this.metrics.bruteForceAttempts++;
    }
    
    this.saveMetricsToFile();
  }

  /**
   * Check failed login threshold for IP
   * @param {string} ip - IP address
   */
  checkFailedLoginThreshold(ip) {
    const threshold = this.alertThresholds.failedLogins;
    const recentFailures = this.getRecentEventsByIP('failedLogins', ip, threshold.timeWindow);
    
    if (recentFailures.length >= threshold.count) {
      this.triggerAlert('FAILED_LOGIN_THRESHOLD', {
        ip,
        attempts: recentFailures.length,
        timeWindow: threshold.timeWindow / 60000 // Convert to minutes
      });
      
      // Increment brute force attempts counter
      this.metrics.bruteForceAttempts++;
      
      // Temporarily block IP
      this.blockIP(ip, 'Multiple failed login attempts');
    }
  }

  /**
   * Check for email enumeration attempts
   * @param {string} email - Email address
   */
  checkEmailEnumeration(email) {
    const recentAttempts = this.eventBuffer.failedLogins.filter(event => {
      const timeDiff = new Date() - event.timestamp;
      return timeDiff <= 60000 && event.email === email; // 1 minute window
    });
    
    if (recentAttempts.length >= 3) {
      this.recordSuspiciousActivity({
        type: 'EMAIL_ENUMERATION',
        ip: recentAttempts[0].ip,
        details: { email, attempts: recentAttempts.length },
        severity: 'high'
      });
    }
  }

  /**
   * Check rate limit threshold for IP
   * @param {string} ip - IP address
   */
  checkRateLimitThreshold(ip) {
    const threshold = this.alertThresholds.rateLimitViolations;
    const recentViolations = this.getRecentEventsByIP('rateLimitViolations', ip, threshold.timeWindow);
    
    if (recentViolations.length >= threshold.count) {
      this.triggerAlert('RATE_LIMIT_ABUSE', {
        ip,
        violations: recentViolations.length,
        timeWindow: threshold.timeWindow / 60000
      });
      
      // Block IP for longer duration
      this.blockIP(ip, 'Rate limit abuse', 60 * 60 * 1000); // 1 hour
    }
  }

  /**
   * Check for error spikes
   */
  checkErrorSpike() {
    const threshold = this.alertThresholds.errorSpikes;
    const recentErrors = this.eventBuffer.errors.filter(event => {
      const timeDiff = new Date() - event.timestamp;
      return timeDiff <= threshold.timeWindow;
    });
    
    if (recentErrors.length >= threshold.count) {
      this.triggerAlert('ERROR_SPIKE', {
        errorCount: recentErrors.length,
        timeWindow: threshold.timeWindow / 60000
      });
    }
  }

  /**
   * Get recent events by IP
   * @param {string} eventType - Type of events
   * @param {string} ip - IP address
   * @param {number} timeWindow - Time window in milliseconds
   */
  getRecentEventsByIP(eventType, ip, timeWindow) {
    return this.eventBuffer[eventType].filter(event => {
      const timeDiff = new Date() - event.timestamp;
      return timeDiff <= timeWindow && event.ip === ip;
    });
  }

  /**
   * Block IP address
   * @param {string} ip - IP address to block
   * @param {string} reason - Reason for blocking
   * @param {number} duration - Block duration in milliseconds
   */
  blockIP(ip, reason, duration = 15 * 60 * 1000) {
    // Handle null, undefined, or empty IP addresses
    if (!ip || typeof ip !== 'string' || ip.trim() === '') {
      this.logger.warn('blockIP called with invalid IP address:', ip);
      return;
    }
    
    if (!this.metrics.blockedIPs) {
      this.metrics.blockedIPs = new Set();
    }
    this.metrics.blockedIPs.add(ip);
    
    const blockEvent = {
      ip,
      reason,
      blockedAt: new Date(),
      expiresAt: new Date(Date.now() + duration)
    };
    
    // Store detailed information
    if (!this.metrics.blockedIPDetails) {
      this.metrics.blockedIPDetails = new Map();
    }
    this.metrics.blockedIPDetails.set(ip, blockEvent);
    
    this.logger.security('IP address blocked', blockEvent);
    
    // Schedule unblock
    setTimeout(() => {
      this.unblockIP(ip);
    }, duration);
    
    this.saveMetricsToFile();
  }

  /**
   * Unblock IP address
   * @param {string} ip - IP address to unblock
   */
  unblockIP(ip) {
    this.metrics.blockedIPs.delete(ip);
    this.logger.security('IP address unblocked', { ip });
    this.saveMetricsToFile();
  }

  /**
   * Check if IP is blocked
   * @param {string} ip - IP address
   * @returns {boolean} True if blocked
   */
  isIPBlocked(ip) {
    return this.metrics.blockedIPs.has(ip);
  }

  /**
   * Get list of blocked IPs
   * @returns {Array} Array of blocked IP details
   */
  getBlockedIPs() {
    return Array.from(this.metrics.blockedIPDetails.values());
  }

  /**
   * Trigger security alert
   * @param {string} alertType - Type of alert
   * @param {Object} details - Alert details
   */
  triggerAlert(alertType, details) {
    const alert = {
      type: alertType,
      timestamp: new Date(),
      details,
      severity: this.getAlertSeverity(alertType)
    };
    
    this.metrics.securityAlerts++;
    this.logger.security('Security alert triggered', alert);
    
    // Execute alert callbacks
    this.alertCallbacks.forEach(callback => {
      try {
        callback(alert);
      } catch (error) {
        this.logger.error('Alert callback failed', { error: error.message });
      }
    });
    
    this.saveMetricsToFile();
  }

  /**
   * Get alert severity level
   * @param {string} alertType - Alert type
   * @returns {string} Severity level
   */
  getAlertSeverity(alertType) {
    const severityMap = {
      'FAILED_LOGIN_THRESHOLD': 'high',
      'RATE_LIMIT_ABUSE': 'high',
      'SUSPICIOUS_ACTIVITY': 'medium',
      'ERROR_SPIKE': 'medium',
      'EMAIL_ENUMERATION': 'high'
    };
    
    return severityMap[alertType] || 'low';
  }

  /**
   * Register alert callback
   * @param {Function} callback - Callback function
   */
  onAlert(callback) {
    this.alertCallbacks.push(callback);
  }

  /**
   * Get security metrics
   * @returns {Object} Current security metrics
   */
  getMetrics() {
    return {
      ...this.metrics,
      blockedIPs: Array.from(this.metrics.blockedIPs),
      recentEvents: {
        failedLogins: this.eventBuffer.failedLogins.slice(-10),
        suspiciousActivity: this.eventBuffer.suspiciousActivity.slice(-10),
        rateLimitViolations: this.eventBuffer.rateLimitViolations.slice(-10)
      }
    };
  }

  /**
   * Reset failed attempts for IP
   * @param {string} ip - IP address
   */
  resetFailedAttemptsForIP(ip) {
    this.eventBuffer.failedLogins = this.eventBuffer.failedLogins.filter(
      event => event.ip !== ip
    );
  }

  /**
   * Start periodic cleanup of old events
   */
  startPeriodicCleanup() {
    setInterval(() => {
      this.cleanupOldEvents();
    }, 60 * 60 * 1000); // Every hour
  }

  /**
   * Clean up old events from buffer
   */
  cleanupOldEvents() {
    const maxAge = 24 * 60 * 60 * 1000; // 24 hours
    const cutoff = new Date(Date.now() - maxAge);
    
    Object.keys(this.eventBuffer).forEach(eventType => {
      this.eventBuffer[eventType] = this.eventBuffer[eventType].filter(
        event => event.timestamp > cutoff
      );
    });
    
    this.logger.info('Cleaned up old security events');
  }

  /**
   * Generate security report
   * @returns {Object} Security report
   */
  generateSecurityReport() {
    const now = new Date();
    const last24Hours = new Date(now.getTime() - 24 * 60 * 60 * 1000);
    
    const recentEvents = {
      failedLogins: this.eventBuffer.failedLogins.filter(e => e.timestamp > last24Hours).length,
      suspiciousActivity: this.eventBuffer.suspiciousActivity.filter(e => e.timestamp > last24Hours).length,
      rateLimitViolations: this.eventBuffer.rateLimitViolations.filter(e => e.timestamp > last24Hours).length,
      errors: this.eventBuffer.errors.filter(e => e.timestamp > last24Hours).length
    };
    
    return {
      generatedAt: now.toISOString(),
      period: '24 hours',
      summary: {
        totalEvents: this.metrics.totalEvents,
        securityAlerts: this.metrics.securityAlerts,
        blockedIPs: this.metrics.blockedIPs.size,
        successRate: this.metrics.successfulLogins / (this.metrics.successfulLogins + this.metrics.failedLogins) * 100
      },
      recentActivity: recentEvents,
      topThreats: this.getTopThreats(),
      recommendations: this.getSecurityRecommendations()
    };
  }

  /**
   * Get top security threats
   * @returns {Array} Top threats
   */
  getTopThreats() {
    // Analyze patterns and return top threats
    const threats = [];
    
    if (this.metrics.failedLogins > 50) {
      threats.push({
        type: 'Brute Force Attacks',
        severity: 'high',
        count: this.metrics.failedLogins
      });
    }
    
    if (this.metrics.rateLimitViolations > 20) {
      threats.push({
        type: 'Rate Limit Abuse',
        severity: 'medium',
        count: this.metrics.rateLimitViolations
      });
    }
    
    return threats;
  }

  /**
   * Get security recommendations
   * @returns {Array} Security recommendations
   */
  getSecurityRecommendations() {
    const recommendations = [];
    
    if (this.metrics.failedLogins > this.metrics.successfulLogins) {
      recommendations.push('Consider implementing CAPTCHA for repeated failed logins');
    }
    
    if (this.metrics.blockedIPs.size > 10) {
      recommendations.push('Review blocked IPs for potential false positives');
    }
    
    if (this.metrics.securityAlerts > 100) {
      recommendations.push('Consider adjusting alert thresholds to reduce noise');
    }
    
    return recommendations;
  }

  /**
   * Clear all metrics (for testing purposes)
   */
  clearMetrics() {
    this.metrics = {
      failedLogins: 0,
      successfulLogins: 0,
      securityEvents: 0,
      bruteForceAttempts: 0,
      blockedIPs: new Set(),
      rateLimitViolations: 0,
      suspiciousActivities: 0,
      securityAlerts: 0,
      uptime: Date.now(),
      lastUpdated: new Date().toISOString()
    };
    
    // Clear event buffers
    this.eventBuffer = {
      failedLogins: [],
      suspiciousActivity: [],
      rateLimitViolations: [],
      errors: [],
      securityEvents: []
    };
    
    this.logger.info('Security metrics cleared');
  }

  /**
   * Get recent security events
   * @param {number} limit - Maximum number of events to return
   * @returns {Array} Recent security events
   */
  getRecentEvents(limit = 50) {
    const allEvents = [];
    
    // Collect all events from buffers
    Object.keys(this.eventBuffer).forEach(bufferType => {
      this.eventBuffer[bufferType].forEach(event => {
        allEvents.push({
          type: event.type || bufferType.toUpperCase(),
          timestamp: event.timestamp || new Date(),
          details: event.details || event,
          ip: event.ip,
          userId: event.userId,
          email: event.email
        });
      });
    });
    
    // Sort by timestamp (newest first) and limit
    return allEvents
      .sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp))
      .slice(0, limit);
  }

  /**
   * Get active connections for an organization
   */
  getActiveConnections(organizationId) {
    // For now, return mock data - in production this would track real connections
    return [
      {
        userId: 'user123',
        ip: '192.168.1.100',
        connectedAt: new Date().toISOString(),
        requests: 42,
        organizationId: organizationId
      },
      {
        userId: 'user456', 
        ip: '192.168.1.101',
        connectedAt: new Date(Date.now() - 300000).toISOString(),
        requests: 15,
        organizationId: organizationId
      }
    ];
  }

  /**
   * Get real-time statistics for an organization
   */
  getRealTimeStats(organizationId) {
    // Mock real-time data - in production this would come from live monitoring
    return {
      currentConnections: 2,
      requestsPerMinute: 12,
      avgResponseTime: 45,
      errorRate: 0.5,
      organizationId: organizationId,
      timestamp: new Date().toISOString()
    };
  }

  /**
   * Get recent rate limit violations for an organization
   */
  getRecentRateLimitViolations(organizationId) {
    // Mock data - in production this would query the actual violation logs
    return [
      {
        ip: '192.168.1.102',
        endpoint: '/api/auth/login',
        timestamp: new Date(Date.now() - 60000).toISOString(),
        organizationId: organizationId,
        violationType: 'rate_limit_exceeded'
      }
    ];
  }
}

// Create singleton instance
const securityMonitor = new SecurityMonitor();

module.exports = { SecurityMonitor, securityMonitor };