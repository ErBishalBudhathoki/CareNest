const nodemailer = require('nodemailer');
const { createLogger } = require('./logger');

/**
 * Advanced Alerting System
 * Handles notifications for security events via multiple channels
 */
class AlertingSystem {
  constructor() {
    this.logger = createLogger('AlertingSystem');
    this.channels = {
      email: null,
      webhook: null,
      sms: null
    };
    
    this.alertQueue = [];
    this.isProcessing = false;
    
    // Alert configuration
    this.config = {
      email: {
        enabled: process.env.ALERT_EMAIL_ENABLED === 'true',
        recipients: (process.env.ALERT_EMAIL_RECIPIENTS || '').split(',').filter(Boolean),
        smtp: {
          host: process.env.ALERT_SMTP_HOST,
          port: parseInt(process.env.ALERT_SMTP_PORT) || 587,
          secure: process.env.ALERT_SMTP_SECURE === 'true',
          auth: {
            user: process.env.ALERT_SMTP_USER,
            pass: process.env.ALERT_SMTP_PASS
          }
        }
      },
      webhook: {
        enabled: process.env.ALERT_WEBHOOK_ENABLED === 'true',
        url: process.env.ALERT_WEBHOOK_URL,
        secret: process.env.ALERT_WEBHOOK_SECRET
      },
      rateLimits: {
        email: {
          maxPerHour: 10,
          maxPerDay: 50
        },
        webhook: {
          maxPerHour: 100,
          maxPerDay: 1000
        }
      }
    };
    
    this.sentCounts = {
      email: { hourly: 0, daily: 0, lastReset: { hour: new Date(), day: new Date() } },
      webhook: { hourly: 0, daily: 0, lastReset: { hour: new Date(), day: new Date() } }
    };
    
    this.initializeChannels();
    this.startQueueProcessor();
  }

  /**
   * Update alerting configuration
   * @param {Object} newConfig - New configuration object
   */
  updateConfig(newConfig) {
    try {
      if (!newConfig || typeof newConfig !== 'object') {
        this.logger.warn('Invalid configuration provided to updateConfig');
        return;
      }
      
      // Merge new configuration with existing
      this.config = {
        ...this.config,
        ...newConfig
      };
      
      // Reinitialize channels with new config
      this.initializeChannels();
      
      this.logger.info('Alerting configuration updated successfully');
    } catch (error) {
      this.logger.error('Failed to update alerting configuration', { error: error.message });
    }
  }

  /**
   * Initialize notification channels
   */
  initializeChannels() {
    // Initialize email transporter
    if (this.config.email.enabled && this.config.email.smtp.host) {
      try {
        this.channels.email = nodemailer.createTransporter(this.config.email.smtp);
        this.logger.info('Email alerting channel initialized');
      } catch (error) {
        this.logger.error('Failed to initialize email channel', { error: error.message });
      }
    }
    
    // Initialize webhook channel
    if (this.config.webhook.enabled && this.config.webhook.url) {
      this.channels.webhook = {
        url: this.config.webhook.url,
        secret: this.config.webhook.secret
      };
      this.logger.info('Webhook alerting channel initialized');
    }
  }

  /**
   * Send security alert
   * @param {Object} alert - Alert object from SecurityMonitor
   */
  async sendAlert(alert) {
    try {
      // Add to queue for processing
      this.alertQueue.push({
        ...alert,
        queuedAt: new Date()
      });
      
      this.logger.info('Alert queued for processing', { type: alert.type, severity: alert.severity });
      
      // Process queue if not already processing
      if (!this.isProcessing) {
        this.processAlertQueue();
      }
    } catch (error) {
      this.logger.error('Failed to queue alert', { error: error.message, alert });
    }
  }

  /**
   * Process alert queue
   */
  async processAlertQueue() {
    if (this.isProcessing || this.alertQueue.length === 0) {
      return;
    }
    
    this.isProcessing = true;
    
    try {
      while (this.alertQueue.length > 0) {
        const alert = this.alertQueue.shift();
        await this.processAlert(alert);
        
        // Small delay between alerts to prevent overwhelming
        await this.delay(100);
      }
    } catch (error) {
      this.logger.error('Error processing alert queue', { error: error.message });
    } finally {
      this.isProcessing = false;
    }
  }

  /**
   * Process individual alert
   * @param {Object} alert - Alert to process
   */
  async processAlert(alert) {
    try {
      // Reset rate limit counters if needed
      this.resetRateLimitCounters();
      
      // Determine which channels to use based on severity
      const channels = this.getChannelsForSeverity(alert.severity);
      
      // Send via each enabled channel
      const promises = [];
      
      if (channels.includes('email') && this.canSendEmail()) {
        promises.push(this.sendEmailAlert(alert));
      }
      
      if (channels.includes('webhook') && this.canSendWebhook()) {
        promises.push(this.sendWebhookAlert(alert));
      }
      
      // Wait for all notifications to complete
      const results = await Promise.allSettled(promises);
      
      // Log results
      results.forEach((result, index) => {
        if (result.status === 'rejected') {
          this.logger.error('Alert notification failed', {
            channel: channels[index],
            error: result.reason.message,
            alertType: alert.type
          });
        }
      });
      
    } catch (error) {
      this.logger.error('Failed to process alert', { error: error.message, alert });
    }
  }

  /**
   * Get notification channels for alert severity
   * @param {string} severity - Alert severity
   * @returns {Array} Array of channel names
   */
  getChannelsForSeverity(severity) {
    const channels = [];
    
    switch (severity) {
      case 'high':
        if (this.config.email.enabled) channels.push('email');
        if (this.config.webhook.enabled) channels.push('webhook');
        break;
      case 'medium':
        if (this.config.webhook.enabled) channels.push('webhook');
        break;
      case 'low':
        if (this.config.webhook.enabled) channels.push('webhook');
        break;
    }
    
    return channels;
  }

  /**
   * Send email alert
   * @param {Object} alert - Alert object
   */
  async sendEmailAlert(alert) {
    if (!this.channels.email || !this.config.email.recipients.length) {
      throw new Error('Email channel not configured');
    }
    
    const subject = this.generateEmailSubject(alert);
    const html = this.generateEmailBody(alert);
    
    const mailOptions = {
      from: this.config.email.smtp.auth.user,
      to: this.config.email.recipients.join(','),
      subject,
      html
    };
    
    try {
      await this.channels.email.sendMail(mailOptions);
      this.incrementSentCount('email');
      this.logger.info('Email alert sent successfully', { type: alert.type, recipients: this.config.email.recipients.length });
    } catch (error) {
      this.logger.error('Failed to send email alert', { error: error.message, type: alert.type });
      throw error;
    }
  }

  /**
   * Send webhook alert
   * @param {Object} alert - Alert object
   */
  async sendWebhookAlert(alert) {
    if (!this.channels.webhook) {
      throw new Error('Webhook channel not configured');
    }
    
    const payload = {
      timestamp: alert.timestamp,
      type: alert.type,
      severity: alert.severity,
      details: alert.details,
      source: 'InvoiceApp-SecurityMonitor'
    };
    
    const headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'InvoiceApp-AlertSystem/1.0'
    };
    
    // Add signature if secret is configured
    if (this.channels.webhook.secret) {
      const crypto = require('crypto');
      const signature = crypto
        .createHmac('sha256', this.channels.webhook.secret)
        .update(JSON.stringify(payload))
        .digest('hex');
      headers['X-Signature-SHA256'] = `sha256=${signature}`;
    }
    
    try {
      const fetch = require('node-fetch');
      const response = await fetch(this.channels.webhook.url, {
        method: 'POST',
        headers,
        body: JSON.stringify(payload),
        timeout: 10000
      });
      
      if (!response.ok) {
        throw new Error(`Webhook returned ${response.status}: ${response.statusText}`);
      }
      
      this.incrementSentCount('webhook');
      this.logger.info('Webhook alert sent successfully', { type: alert.type, url: this.channels.webhook.url });
    } catch (error) {
      this.logger.error('Failed to send webhook alert', { error: error.message, type: alert.type });
      throw error;
    }
  }

  /**
   * Generate email subject for alert
   * @param {Object} alert - Alert object
   * @returns {string} Email subject
   */
  generateEmailSubject(alert) {
    const severityEmoji = {
      high: '🚨',
      medium: '⚠️',
      low: 'ℹ️'
    };
    
    const emoji = severityEmoji[alert.severity] || '📢';
    return `${emoji} Security Alert: ${alert.type} [${alert.severity.toUpperCase()}]`;
  }

  /**
   * Generate email body for alert
   * @param {Object} alert - Alert object
   * @returns {string} HTML email body
   */
  generateEmailBody(alert) {
    const formatDetails = (details) => {
      return Object.entries(details)
        .map(([key, value]) => `<li><strong>${key}:</strong> ${value}</li>`)
        .join('');
    };
    
    return `
      <html>
        <body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
          <div style="max-width: 600px; margin: 0 auto; padding: 20px;">
            <div style="background: ${this.getSeverityColor(alert.severity)}; color: white; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
              <h2 style="margin: 0;">Security Alert: ${alert.type}</h2>
              <p style="margin: 5px 0 0 0;">Severity: ${alert.severity.toUpperCase()}</p>
            </div>
            
            <div style="background: #f9f9f9; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
              <h3>Alert Details:</h3>
              <ul>
                <li><strong>Timestamp:</strong> ${alert.timestamp}</li>
                <li><strong>Type:</strong> ${alert.type}</li>
                <li><strong>Severity:</strong> ${alert.severity}</li>
              </ul>
            </div>
            
            ${alert.details ? `
              <div style="background: #fff; border: 1px solid #ddd; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
                <h3>Additional Information:</h3>
                <ul>
                  ${formatDetails(alert.details)}
                </ul>
              </div>
            ` : ''}
            
            <div style="background: #e8f4f8; padding: 15px; border-radius: 5px; border-left: 4px solid #2196F3;">
              <h3>Recommended Actions:</h3>
              <ul>
                ${this.getRecommendedActions(alert.type).map(action => `<li>${action}</li>`).join('')}
              </ul>
            </div>
            
            <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; font-size: 12px; color: #666;">
              <p>This alert was generated by the Invoice App Security Monitoring System.</p>
              <p>Timestamp: ${new Date().toISOString()}</p>
            </div>
          </div>
        </body>
      </html>
    `;
  }

  /**
   * Get color for severity level
   * @param {string} severity - Severity level
   * @returns {string} Color code
   */
  getSeverityColor(severity) {
    const colors = {
      high: '#f44336',
      medium: '#ff9800',
      low: '#2196f3'
    };
    return colors[severity] || '#666';
  }

  /**
   * Get recommended actions for alert type
   * @param {string} alertType - Alert type
   * @returns {Array} Array of recommended actions
   */
  getRecommendedActions(alertType) {
    const actions = {
      'FAILED_LOGIN_THRESHOLD': [
        'Review the IP address for potential brute force attack',
        'Consider temporarily blocking the IP if pattern continues',
        'Check if legitimate user is having password issues',
        'Review authentication logs for additional context'
      ],
      'RATE_LIMIT_ABUSE': [
        'Investigate the source IP for malicious activity',
        'Consider implementing stricter rate limits',
        'Review API usage patterns',
        'Block IP if confirmed malicious'
      ],
      'SUSPICIOUS_ACTIVITY': [
        'Investigate the reported activity immediately',
        'Review related logs and user behavior',
        'Consider escalating to security team',
        'Document findings for future reference'
      ],
      'ERROR_SPIKE': [
        'Check application health and performance',
        'Review error logs for patterns',
        'Investigate potential DDoS or attack',
        'Monitor system resources'
      ],
      'EMAIL_ENUMERATION': [
        'Block the source IP immediately',
        'Review user registration patterns',
        'Consider implementing CAPTCHA',
        'Alert development team about potential data exposure'
      ]
    };
    
    return actions[alertType] || [
      'Review the security event details',
      'Investigate the source and context',
      'Take appropriate remedial action',
      'Document the incident'
    ];
  }

  /**
   * Check if email can be sent (rate limiting)
   * @returns {boolean} True if email can be sent
   */
  canSendEmail() {
    const limits = this.config.rateLimits.email;
    const counts = this.sentCounts.email;
    
    return counts.hourly < limits.maxPerHour && counts.daily < limits.maxPerDay;
  }

  /**
   * Check if webhook can be sent (rate limiting)
   * @returns {boolean} True if webhook can be sent
   */
  canSendWebhook() {
    const limits = this.config.rateLimits.webhook;
    const counts = this.sentCounts.webhook;
    
    return counts.hourly < limits.maxPerHour && counts.daily < limits.maxPerDay;
  }

  /**
   * Increment sent count for channel
   * @param {string} channel - Channel name
   */
  incrementSentCount(channel) {
    if (this.sentCounts[channel]) {
      this.sentCounts[channel].hourly++;
      this.sentCounts[channel].daily++;
    }
  }

  /**
   * Reset rate limit counters if needed
   */
  resetRateLimitCounters() {
    const now = new Date();
    
    Object.keys(this.sentCounts).forEach(channel => {
      const counts = this.sentCounts[channel];
      
      // Reset hourly counter
      if (now - counts.lastReset.hour >= 60 * 60 * 1000) {
        counts.hourly = 0;
        counts.lastReset.hour = now;
      }
      
      // Reset daily counter
      if (now - counts.lastReset.day >= 24 * 60 * 60 * 1000) {
        counts.daily = 0;
        counts.lastReset.day = now;
      }
    });
  }

  /**
   * Start queue processor
   */
  startQueueProcessor() {
    // Process queue every 5 seconds
    setInterval(() => {
      if (!this.isProcessing && this.alertQueue.length > 0) {
        this.processAlertQueue();
      }
    }, 5000);
  }

  /**
   * Delay utility
   * @param {number} ms - Milliseconds to delay
   */
  delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  /**
   * Get alerting system status
   * @returns {Object} Status information
   */
  getStatus() {
    return {
      enabled: true,
      channels: {
        email: {
          enabled: this.config.email.enabled,
          configured: !!this.channels.email,
          recipients: (this.config.email.recipients || []).length
        },
        webhook: {
          enabled: this.config.webhook.enabled,
          configured: !!this.channels.webhook,
          url: this.config.webhook.url ? 'configured' : 'not configured'
        }
      },
      queue: {
        pending: this.alertQueue.length,
        processing: this.isProcessing
      },
      rateLimits: this.sentCounts || {},
      lastAlert: null,
      totalAlerts: 0
    };
  }

  /**
   * Test alert system
   * @param {string} channel - Channel to test (optional)
   */
  async testAlert(channel = null) {
    const testAlert = {
      type: 'SYSTEM_TEST',
      severity: 'low',
      timestamp: new Date(),
      details: {
        message: 'This is a test alert to verify the alerting system is working correctly.',
        testId: Math.random().toString(36).substr(2, 9)
      }
    };
    
    if (channel) {
      // Test specific channel
      if (channel === 'email' && this.channels.email) {
        await this.sendEmailAlert(testAlert);
      } else if (channel === 'webhook' && this.channels.webhook) {
        await this.sendWebhookAlert(testAlert);
      } else {
        throw new Error(`Channel '${channel}' not available`);
      }
    } else {
      // Test all available channels
      await this.sendAlert(testAlert);
    }
    
    this.logger.info('Test alert sent', { channel: channel || 'all' });
  }
}

// Create singleton instance
const alertingSystem = new AlertingSystem();

module.exports = { AlertingSystem, alertingSystem };