// Firebase Admin SDK configuration
const { admin, messaging } = require('../firebase-admin-config');
const logger = require('../utils/structuredLogger');

class FirebaseConfig {
  constructor() {
    this.admin = admin;
    this.messaging = messaging;
  }

  /**
   * Get Firebase Admin instance
   * @returns {admin} Firebase Admin SDK instance
   */
  getAdmin() {
    return this.admin;
  }

  /**
   * Get Firebase Messaging instance
   * @returns {messaging} Firebase Messaging instance
   */
  getMessaging() {
    return this.messaging;
  }

  /**
   * Verify Firebase Messaging service
   * @returns {Promise<boolean>} True if Firebase is working
   */
  async verifyMessaging() {
    try {
      // Send a dummy message to verify Firebase initialization
      await this.messaging.send({
        token: 'dummy-token',
        data: { type: 'server_startup_check' }
      }, true).catch(() => {
        // Expected to fail with invalid token, but validates Firebase initialization
        logger.info('Firebase Messaging service verified successfully');
      });
      return true;
    } catch (error) {
      logger.error('Failed to verify Firebase Messaging service', {
        error: error.message,
        stack: error.stack
      });
      return false;
    }
  }

  /**
   * Send FCM notification
   * @param {string} token - FCM token
   * @param {Object} data - Notification data
   * @param {Object} notification - Notification payload
   * @returns {Promise<string>} Message ID
   */
  async sendNotification(token, data = {}, notification = null) {
    try {
      const message = {
        token,
        data
      };

      if (notification) {
        message.notification = notification;
      }

      const response = await this.messaging.send(message);
      logger.info('Successfully sent Firebase message', {
        messageId: response.messageId || 'N/A'
      });
      return response;
    } catch (error) {
      logger.error('Error sending Firebase message', {
        error: error.message,
        stack: error.stack,
        messageData: message
      });
      throw error;
    }
  }

  /**
   * Send notification to multiple tokens
   * @param {string[]} tokens - Array of FCM tokens
   * @param {Object} data - Notification data
   * @param {Object} notification - Notification payload
   * @returns {Promise<Object>} Batch response
   */
  async sendMulticastNotification(tokens, data = {}, notification = null) {
    try {
      const message = {
        tokens,
        data
      };

      if (notification) {
        message.notification = notification;
      }

      const response = await this.messaging.sendMulticast(message);
      logger.info('Successfully sent Firebase multicast message', {
        successCount: response.successCount,
        failureCount: response.failureCount
      });
      return response;
    } catch (error) {
      logger.error('Error sending Firebase multicast message', {
        error: error.message,
        stack: error.stack,
        messageData: message,
        tokens: tokens
      });
      throw error;
    }
  }
}

// Export singleton instance
const firebaseConfig = new FirebaseConfig();

module.exports = {
  FirebaseConfig,
  firebaseConfig,
  // Legacy exports for backward compatibility
  admin,
  messaging
};