const { MongoClient } = require('mongodb');
const bcrypt = require('bcrypt');
const crypto = require('crypto');
const { getDatabase } = require('../config/database');
const auditService = require('./auditService');

class AuthService {
  constructor() {
    this.db = null;
  }

  async getDb() {
    if (!this.db) {
      this.db = await getDatabase();
    }
    return this.db;
  }

  /**
   * Check if email exists in the system
   * @param {string} email - User email
   * @returns {Object} - User data if exists, null otherwise
   */
  async checkEmailExists(email) {
    try {
      const db = await this.getDb();
      const user = await db.collection('login').findOne({ email: email });
      return user;
    } catch (error) {
      throw new Error(`Error checking email: ${error.message}`);
    }
  }

  /**
   * Get client details by email
   * @param {string} email - Client email
   * @returns {Object} - Client data if exists, null otherwise
   */
  async getClientDetails(email) {
    try {
      const db = await this.getDb();
      const client = await db.collection('clients').findOne({ email: email });
      return client;
    } catch (error) {
      throw new Error(`Error getting client details: ${error.message}`);
    }
  }

  /**
   * Validate organization code
   * @param {string} organizationCode - Organization code to validate
   * @returns {Object} - Organization data if valid, null otherwise
   */
  async validateOrganizationCode(organizationCode) {
    try {
      const db = await this.getDb();
      const organization = await db.collection('organizations').findOne({ 
        organizationCode: organizationCode 
      });
      return organization;
    } catch (error) {
      throw new Error(`Error validating organization code: ${error.message}`);
    }
  }

  /**
   * Validate organization ID
   * @param {string} organizationId - Organization ID to validate
   * @returns {Object} - Organization data if valid, null otherwise
   */
  async validateOrganizationId(organizationId) {
    try {
      const db = await this.getDb();
      const organization = await db.collection('organizations').findOne({ 
        _id: new MongoClient.ObjectId(organizationId) 
      });
      return organization;
    } catch (error) {
      throw new Error(`Error validating organization ID: ${error.message}`);
    }
  }

  /**
   * Create new user account
   * @param {Object} userData - User registration data
   * @returns {Object} - Created user data
   */
  async createUser(userData) {
    try {
      const db = await this.getDb();
      
      // Generate salt and hash password
      const salt = crypto.randomBytes(16).toString('hex');
      const hashedPassword = bcrypt.hashSync(userData.password, 10);
      
      const newUser = {
        email: userData.email,
        password: hashedPassword,
        salt: salt,
        firstName: userData.firstName,
        lastName: userData.lastName,
        organizationCode: userData.organizationCode,
        organizationId: userData.organizationId,
        role: userData.role || 'user',
        createdAt: new Date(),
        lastLogin: null,
        isActive: true
      };
      
      const result = await db.collection('login').insertOne(newUser);
      
      // Create audit trail
      await auditService.createAuditTrail({
        action: 'USER_CREATED',
        userId: result.insertedId.toString(),
        userEmail: userData.email,
        organizationId: userData.organizationId,
        details: {
          email: userData.email,
          firstName: userData.firstName,
          lastName: userData.lastName,
          role: userData.role
        },
        timestamp: new Date()
      });
      
      return { ...newUser, _id: result.insertedId };
    } catch (error) {
      throw new Error(`Error creating user: ${error.message}`);
    }
  }

  /**
   * Authenticate user login
   * @param {string} email - User email
   * @param {string} password - User password
   * @returns {Object} - User data if authentication successful
   */
  async authenticateUser(email, password) {
    try {
      const db = await this.getDb();
      const user = await db.collection('login').findOne({ email: email });
      
      if (!user) {
        throw new Error('User not found');
      }
      
      if (!user.isActive) {
        throw new Error('User account is deactivated');
      }
      
      // Verify password
      const isPasswordValid = bcrypt.compareSync(password, user.password);
      if (!isPasswordValid) {
        throw new Error('Invalid password');
      }
      
      // Update last login
      await db.collection('login').updateOne(
        { email: email },
        { $set: { lastLogin: new Date() } }
      );
      
      // Get organization details
      const organization = await db.collection('organizations').findOne({
        _id: new MongoClient.ObjectId(user.organizationId)
      });
      
      // Create audit trail
      await auditService.createAuditTrail({
        action: 'USER_LOGIN',
        userId: user._id.toString(),
        userEmail: email,
        organizationId: user.organizationId,
        details: {
          loginTime: new Date(),
          ipAddress: null // Will be set by controller
        },
        timestamp: new Date()
      });
      
      return {
        user: {
          _id: user._id,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          role: user.role,
          organizationId: user.organizationId,
          lastLogin: new Date()
        },
        organization: organization
      };
    } catch (error) {
      throw new Error(`Authentication failed: ${error.message}`);
    }
  }

  /**
   * Get user photo data
   * @param {string} email - User email
   * @returns {Object} - Photo data if exists
   */
  async getUserPhoto(email) {
    try {
      const db = await this.getDb();
      const user = await db.collection('login').findOne(
        { email: email },
        { projection: { photo: 1 } }
      );
      
      if (!user || !user.photo) {
        return null;
      }
      
      return user.photo;
    } catch (error) {
      throw new Error(`Error getting user photo: ${error.message}`);
    }
  }

  /**
   * Upload user photo
   * @param {string} email - User email
   * @param {Buffer} photoData - Photo buffer data
   * @param {string} contentType - Photo content type
   * @returns {boolean} - Success status
   */
  async uploadUserPhoto(email, photoData, contentType) {
    try {
      const db = await this.getDb();
      
      const result = await db.collection('login').updateOne(
        { email: email },
        {
          $set: {
            photo: {
              data: photoData,
              contentType: contentType,
              uploadedAt: new Date()
            }
          }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('User not found');
      }
      
      // Create audit trail
      const user = await this.checkEmailExists(email);
      await auditService.createAuditTrail({
        action: 'PHOTO_UPLOADED',
        userId: user._id.toString(),
        userEmail: email,
        organizationId: user.organizationId,
        details: {
          contentType: contentType,
          size: photoData.length
        },
        timestamp: new Date()
      });
      
      return true;
    } catch (error) {
      throw new Error(`Error uploading photo: ${error.message}`);
    }
  }

  /**
   * Get user password salt
   * @param {string} email - User email
   * @returns {string} - Password salt
   */
  async getUserSalt(email) {
    try {
      const db = await this.getDb();
      const user = await db.collection('login').findOne(
        { email: email },
        { projection: { password: 1 } }
      );
      
      if (!user) {
        throw new Error('User not found');
      }
      
      // Extract salt from stored password (last 64 characters)
      // Password format: hash(64 chars) + salt(64 chars)
      if (!user.password || user.password.length < 64) {
        throw new Error('Invalid password format');
      }
      
      const salt = user.password.slice(-64); // Last 64 characters
      return salt;
    } catch (error) {
      throw new Error(`Error getting user salt: ${error.message}`);
    }
  }

  /**
   * Generate and store OTP for password reset
   * @param {string} email - User email
   * @returns {string} - Generated OTP
   */
  async generateOTP(email) {
    try {
      const db = await this.getDb();
      const user = await this.checkEmailExists(email);
      
      if (!user) {
        throw new Error('User not found');
      }
      
      // Generate 6-digit OTP
      const otp = Math.floor(100000 + Math.random() * 900000).toString();
      const otpExpiry = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes
      
      await db.collection('login').updateOne(
        { email: email },
        {
          $set: {
            otp: otp,
            otpExpiry: otpExpiry,
            otpUsed: false
          }
        }
      );
      
      // Create audit trail
      await auditService.createAuditTrail({
        action: 'OTP_GENERATED',
        userId: user._id.toString(),
        userEmail: email,
        organizationId: user.organizationId,
        details: {
          otpExpiry: otpExpiry
        },
        timestamp: new Date()
      });
      
      return otp;
    } catch (error) {
      throw new Error(`Error generating OTP: ${error.message}`);
    }
  }

  /**
   * Verify OTP for password reset
   * @param {string} email - User email
   * @param {string} otp - OTP to verify
   * @returns {boolean} - Verification status
   */
  async verifyOTP(email, otp) {
    try {
      const db = await this.getDb();
      const user = await db.collection('login').findOne({ email: email });
      
      if (!user) {
        throw new Error('User not found');
      }
      
      if (!user.otp || user.otpUsed) {
        throw new Error('No valid OTP found');
      }
      
      if (new Date() > user.otpExpiry) {
        throw new Error('OTP has expired');
      }
      
      if (user.otp !== otp) {
        throw new Error('Invalid OTP');
      }
      
      // Mark OTP as used
      await db.collection('login').updateOne(
        { email: email },
        { $set: { otpUsed: true } }
      );
      
      // Create audit trail
      await auditService.createAuditTrail({
        action: 'OTP_VERIFIED',
        userId: user._id.toString(),
        userEmail: email,
        organizationId: user.organizationId,
        details: {},
        timestamp: new Date()
      });
      
      return true;
    } catch (error) {
      throw new Error(`OTP verification failed: ${error.message}`);
    }
  }

  /**
   * Update user password
   * @param {string} email - User email
   * @param {string} newPassword - New password
   * @returns {boolean} - Update status
   */
  async updatePassword(email, newPassword) {
    try {
      const db = await this.getDb();
      const user = await this.checkEmailExists(email);
      
      if (!user) {
        throw new Error('User not found');
      }
      
      // Generate new salt and hash password
      const salt = crypto.randomBytes(16).toString('hex');
      const hashedPassword = bcrypt.hashSync(newPassword, 10);
      
      await db.collection('login').updateOne(
        { email: email },
        {
          $set: {
            password: hashedPassword,
            salt: salt,
            passwordUpdatedAt: new Date()
          },
          $unset: {
            otp: '',
            otpExpiry: '',
            otpUsed: ''
          }
        }
      );
      
      // Create audit trail
      await auditService.createAuditTrail({
        action: 'PASSWORD_UPDATED',
        userId: user._id.toString(),
        userEmail: email,
        organizationId: user.organizationId,
        details: {
          passwordUpdatedAt: new Date()
        },
        timestamp: new Date()
      });
      
      return true;
    } catch (error) {
      throw new Error(`Error updating password: ${error.message}`);
    }
  }

  /**
   * Get user initial data
   * @param {string} email - User email
   * @returns {Object} - User initial data
   */
  async getInitData(email) {
    try {
      const db = await this.getDb();
      const user = await db.collection('login').findOne({ 
        email: email,
        isActive: true 
      });
      
      if (!user) {
        throw new Error('User not found');
      }
      
      // Get organization details if user belongs to one
      let organizationDetails = null;
      if (user.organizationId) {
        organizationDetails = await db.collection('organizations').findOne({ 
          _id: new MongoClient.ObjectId(user.organizationId) 
        });
      }
      
      return {
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        role: user.role,
        organizationId: user.organizationId,
        organization: organizationDetails ? {
          id: organizationDetails._id.toString(),
          name: organizationDetails.name,
          code: organizationDetails.organizationCode
        } : null
      };
      
    } catch (error) {
      throw new Error(`Error getting user initial data: ${error.message}`);
    }
  }
}

module.exports = new AuthService();