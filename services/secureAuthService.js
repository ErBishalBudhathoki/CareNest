const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const { createLogger } = require('../utils/logger');
const SecureErrorHandler = require('../utils/errorHandler');
const InputValidator = require('../utils/inputValidator');
const { generateOTP, verifyOTP, hashPassword } = require('../utils/cryptoHelpers');
const securityMonitor = require('../utils/securityMonitor');

const logger = createLogger('SecureAuthService');
const uri = process.env.MONGODB_URI;

/**
 * Secure Authentication Service
 * Handles authentication business logic with comprehensive security measures
 */
class SecureAuthService {
  /**
   * Check if email exists in the system
   */
  static async checkEmailExists(email) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');
      
      const user = await usersCollection.findOne(
        { email },
        { projection: { _id: 1 } }
      );
      
      return !!user;
    } catch (error) {
      logger.error('Error checking email existence', {
        error: error.message,
        email
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Get user by email
   */
  static async getUserByEmail(email) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');
      
      const user = await usersCollection.findOne({ email });
      return user;
    } catch (error) {
      logger.error('Error getting user by email', {
        error: error.message,
        email
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Get user by ID
   */
  static async getUserById(userId) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');
      
      const user = await usersCollection.findOne(
        { userId },
        { projection: { password: 0, loginAttempts: 0, lockUntil: 0 } }
      );
      
      return user;
    } catch (error) {
      logger.error('Error getting user by ID', {
        error: error.message,
        userId
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Create new user
   */
  static async createUser(userData) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');
      
      // Check if user already exists
      const existingUser = await usersCollection.findOne({ email: userData.email });
      if (existingUser) {
        throw new Error('User with this email already exists');
      }
      
      // Hash password
      const hashedPassword = await hashPassword(userData.password);
      
      // Create user object
      const newUser = {
        userId: new ObjectId().toString(),
        email: userData.email,
        password: hashedPassword,
        firstName: userData.firstName,
        lastName: userData.lastName,
        phone: userData.phone || null,
        organizationCode: userData.organizationCode || null,
        organizationId: userData.organizationId || null,
        roles: userData.roles || ['user'],
        isActive: true,
        isEmailVerified: false,
        createdAt: new Date(),
        updatedAt: new Date(),
        lastLogin: null,
        loginAttempts: 0,
        lockUntil: null
      };
      
      const result = await usersCollection.insertOne(newUser);
      
      logger.info('User created successfully', {
        userId: newUser.userId,
        email: newUser.email
      });
      
      // Return user without password
      const { password, ...userWithoutPassword } = newUser;
      return userWithoutPassword;
    } catch (error) {
      logger.error('Error creating user', {
        error: error.message,
        email: userData.email
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Update user information
   */
  static async updateUser(userId, updateData) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const usersCollection = db.collection('users');
      
      // Add updated timestamp
      updateData.updatedAt = new Date();
      
      const result = await usersCollection.updateOne(
        { userId },
        { $set: updateData }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('User not found');
      }
      
      logger.info('User updated successfully', {
        userId,
        updatedFields: Object.keys(updateData)
      });
      
      return result;
    } catch (error) {
      logger.error('Error updating user', {
        error: error.message,
        userId
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Authenticate user with email and password
   */
  static async authenticateUser(email, password) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const usersCollection = db.collection('users');
      
      // Find user
      const user = await usersCollection.findOne({ email });
      
      if (!user) {
        throw new Error('Invalid credentials');
      }
      
      // Check if account is locked
      if (user.lockUntil && user.lockUntil > new Date()) {
        throw new Error('Account is temporarily locked');
      }
      
      // Check if account is active
      if (!user.isActive) {
        throw new Error('Account is deactivated');
      }
      
      // Verify password
      const isPasswordValid = await bcrypt.compare(password, user.password);
      
      if (!isPasswordValid) {
        // Increment login attempts
        const loginAttempts = (user.loginAttempts || 0) + 1;
        const maxAttempts = 5;
        const lockDuration = 30 * 60 * 1000; // 30 minutes
        
        const updateData = {
          loginAttempts,
          updatedAt: new Date()
        };
        
        // Lock account if too many attempts
        if (loginAttempts >= maxAttempts) {
          updateData.lockUntil = new Date(Date.now() + lockDuration);
          updateData.loginAttempts = 0;
          
          // Record account lockout
          securityMonitor.recordSecurityEvent('ACCOUNT_LOCKED', {
            email,
            userId: user.userId,
            attempts: loginAttempts,
            lockDuration: lockDuration / 1000 / 60 // minutes
          });
        }
        
        await usersCollection.updateOne(
          { userId: user.userId },
          { $set: updateData }
        );
        
        // Record failed login attempt
        securityMonitor.recordFailedLogin(email, 'invalid_password');
        
        throw new Error('Invalid credentials');
      }
      
      // Reset login attempts on successful login
      await usersCollection.updateOne(
        { userId: user.userId },
        { 
          $set: { 
            loginAttempts: 0,
            lastLogin: new Date(),
            updatedAt: new Date()
          },
          $unset: { lockUntil: 1 }
        }
      );
      
      // Record successful login
      securityMonitor.recordSuccessfulLogin(email, {
        userId: user.userId,
        organizationId: user.organizationId
      });
      
      // Return user without password
      const { password: userPassword, loginAttempts, lockUntil, ...userWithoutPassword } = user;
      return userWithoutPassword;
    } catch (error) {
      logger.error('Error authenticating user', {
        error: error.message,
        email
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Generate JWT token for user
   */
  static generateToken(user) {
    try {
      const tokenPayload = {
        userId: user.userId,
        email: user.email,
        roles: user.roles || ['user'],
        organizationId: user.organizationId
      };
      
      const token = jwt.sign(
        tokenPayload,
        process.env.JWT_SECRET,
        { 
          expiresIn: process.env.JWT_EXPIRES_IN || '24h',
          issuer: 'invoice-app',
          audience: 'invoice-app-users'
        }
      );
      
      return token;
    } catch (error) {
      logger.error('Error generating token', {
        error: error.message,
        userId: user.userId
      });
      throw error;
    }
  }

  /**
   * Verify JWT token
   */
  static verifyToken(token) {
    try {
      const decoded = jwt.verify(
        token,
        process.env.JWT_SECRET,
        {
          issuer: 'invoice-app',
          audience: 'invoice-app-users'
        }
      );
      
      return decoded;
    } catch (error) {
      logger.error('Error verifying token', {
        error: error.message
      });
      throw error;
    }
  }

  /**
   * Update user password
   */
  static async updatePassword(userId, newPassword) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const usersCollection = db.collection('users');
      
      // Hash new password
      const hashedPassword = await hashPassword(newPassword);
      
      const result = await usersCollection.updateOne(
        { userId },
        { 
          $set: { 
            password: hashedPassword,
            updatedAt: new Date(),
            loginAttempts: 0
          },
          $unset: { lockUntil: 1 }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('User not found');
      }
      
      logger.info('Password updated successfully', { userId });
      
      return result;
    } catch (error) {
      logger.error('Error updating password', {
        error: error.message,
        userId
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Verify user email
   */
  static async verifyEmail(email) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const usersCollection = db.collection('users');
      
      const result = await usersCollection.updateOne(
        { email },
        { 
          $set: { 
            isEmailVerified: true,
            updatedAt: new Date()
          }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('User not found');
      }
      
      logger.info('Email verified successfully', { email });
      
      return result;
    } catch (error) {
      logger.error('Error verifying email', {
        error: error.message,
        email
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Lock user account
   */
  static async lockAccount(userId, lockDuration = 30 * 60 * 1000) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const usersCollection = db.collection('users');
      
      const result = await usersCollection.updateOne(
        { userId },
        { 
          $set: { 
            lockUntil: new Date(Date.now() + lockDuration),
            updatedAt: new Date()
          }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('User not found');
      }
      
      logger.info('Account locked successfully', { userId, lockDuration });
      
      return result;
    } catch (error) {
      logger.error('Error locking account', {
        error: error.message,
        userId
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Unlock user account
   */
  static async unlockAccount(userId) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const usersCollection = db.collection('users');
      
      const result = await usersCollection.updateOne(
        { userId },
        { 
          $set: { 
            loginAttempts: 0,
            updatedAt: new Date()
          },
          $unset: { lockUntil: 1 }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('User not found');
      }
      
      logger.info('Account unlocked successfully', { userId });
      
      return result;
    } catch (error) {
      logger.error('Error unlocking account', {
        error: error.message,
        userId
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Deactivate user account
   */
  static async deactivateAccount(userId) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const usersCollection = db.collection('users');
      
      const result = await usersCollection.updateOne(
        { userId },
        { 
          $set: { 
            isActive: false,
            updatedAt: new Date()
          }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('User not found');
      }
      
      logger.info('Account deactivated successfully', { userId });
      
      return result;
    } catch (error) {
      logger.error('Error deactivating account', {
        error: error.message,
        userId
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Activate user account
   */
  static async activateAccount(userId) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const usersCollection = db.collection('users');
      
      const result = await usersCollection.updateOne(
        { userId },
        { 
          $set: { 
            isActive: true,
            updatedAt: new Date()
          }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('User not found');
      }
      
      logger.info('Account activated successfully', { userId });
      
      return result;
    } catch (error) {
      logger.error('Error activating account', {
        error: error.message,
        userId
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Get user activity logs
   */
  static async getUserActivityLogs(userId, limit = 50) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const logsCollection = db.collection('userActivityLogs');
      
      const logs = await logsCollection
        .find({ userId })
        .sort({ timestamp: -1 })
        .limit(limit)
        .toArray();
      
      return logs;
    } catch (error) {
      logger.error('Error getting user activity logs', {
        error: error.message,
        userId
      });
      throw error;
    } finally {
      await client.close();
    }
  }

  /**
   * Log user activity
   */
  static async logUserActivity(userId, activity, metadata = {}) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      await client.connect();
      const db = client.db('invoiceApp');
      const logsCollection = db.collection('userActivityLogs');
      
      const logEntry = {
        userId,
        activity,
        metadata,
        timestamp: new Date(),
        ip: metadata.ip || null,
        userAgent: metadata.userAgent || null
      };
      
      await logsCollection.insertOne(logEntry);
      
      logger.info('User activity logged', {
        userId,
        activity
      });
    } catch (error) {
      logger.error('Error logging user activity', {
        error: error.message,
        userId,
        activity
      });
      // Don't throw error for logging failures
    } finally {
      await client.close();
    }
  }
}

module.exports = SecureAuthService;