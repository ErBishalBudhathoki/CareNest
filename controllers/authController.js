const authService = require('../services/authService');
const nodemailer = require('nodemailer');
const logger = require('../config/logger');
const { securityMonitor } = require('../utils/securityMonitor');

class AuthController {
  /**
   * Check if email exists in the system
   */
  async checkEmail(req, res) {
    try {
      const { email } = req.params;
      
      if (!email) {
        return res.status(400).json({ error: 'Email is required' });
      }
      
      const user = await authService.checkEmailExists(email);
      
      if (user) {
        res.json({ exists: true, user: { email: user.email, role: user.role } });
      } else {
        res.json({ exists: false });
      }
    } catch (error) {
      logger.error('Error checking email', {
        error: error.message,
        stack: error.stack,
        email
      });
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  /**
   * Get client details by email
   */
  async getClientDetails(req, res) {
    try {
      const { email } = req.params;
      
      if (!email) {
        return res.status(400).json({ error: 'Email is required' });
      }
      
      const client = await authService.getClientDetails(email);
      
      if (client) {
        res.json({ exists: true, client });
      } else {
        res.json({ exists: false });
      }
    } catch (error) {
      logger.error('Error getting client details', {
        error: error.message,
        stack: error.stack,
        email
      });
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  /**
   * User registration
   */
  async signup(req, res) {
    try {
      const { email } = req.params;
      const { firstName, lastName, password, organizationCode, organizationId, role } = req.body;
      
      // Validate required fields
      if (!email || !firstName || !lastName || !password) {
        return res.status(400).json({ error: 'Missing required fields' });
      }
      
      // Check if email already exists
      const existingUser = await authService.checkEmailExists(email);
      if (existingUser) {
        return res.status(409).json({ error: 'Email already exists' });
      }
      
      // Validate organization
      let organization = null;
      if (organizationCode) {
        organization = await authService.validateOrganizationCode(organizationCode);
        if (!organization) {
          return res.status(400).json({ error: 'Invalid organization code' });
        }
      } else if (organizationId) {
        organization = await authService.validateOrganizationId(organizationId);
        if (!organization) {
          return res.status(400).json({ error: 'Invalid organization ID' });
        }
      } else {
        return res.status(400).json({ error: 'Organization code or ID is required' });
      }
      
      // Create user
      const userData = {
        email,
        firstName,
        lastName,
        password,
        organizationCode: organization.organizationCode,
        organizationId: organization._id.toString(),
        role: role || 'user'
      };
      
      const newUser = await authService.createUser(userData);
      
      res.status(201).json({
        message: 'User created successfully',
        user: {
          _id: newUser._id,
          email: newUser.email,
          firstName: newUser.firstName,
          lastName: newUser.lastName,
          role: newUser.role,
          organizationId: newUser.organizationId
        }
      });
    } catch (error) {
      logger.error('Error during signup', {
        error: error.message,
        stack: error.stack,
        email: req.body.email
      });
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  /**
   * User login
   */
  async login(req, res) {
    try {
      const { email, password } = req.body;
      const clientIP = req.ip || req.connection.remoteAddress;
      const userAgent = req.get('User-Agent');
      
      if (!email || !password) {
        // Record suspicious activity for missing credentials
        securityMonitor.recordSuspiciousActivity({
          type: 'INCOMPLETE_LOGIN_ATTEMPT',
          ip: clientIP,
          details: { missingFields: !email ? 'email' : 'password' },
          severity: 'low'
        });
        return res.status(400).json({ error: 'Email and password are required' });
      }
      
      // Check if IP is blocked
      if (securityMonitor.isIPBlocked(clientIP)) {
        securityMonitor.recordSuspiciousActivity({
          type: 'BLOCKED_IP_ACCESS_ATTEMPT',
          ip: clientIP,
          details: { email, userAgent },
          severity: 'high'
        });
        return res.status(403).json({ error: 'Access denied' });
      }
      
      const authResult = await authService.authenticateUser(email, password);
      
      // Record successful login
      securityMonitor.recordSuccessfulLogin({
        ip: clientIP,
        email,
        userAgent,
        userId: authResult.user._id
      });
      
      res.json({
        message: 'Login successful',
        user: authResult.user,
        organization: authResult.organization
      });
    } catch (error) {
      const clientIP = req.ip || req.connection.remoteAddress;
      const userAgent = req.get('User-Agent');
      
      logger.error('Error during login', {
          error: error.message,
          stack: error.stack,
          email: req.body.email,
          ip: clientIP
        });
      
      if (error.message.includes('User not found') || 
          error.message.includes('Invalid password') ||
          error.message.includes('deactivated')) {
        
        // Record failed login attempt
        securityMonitor.recordFailedLogin({
          ip: clientIP,
          email: req.body.email,
          userAgent,
          reason: error.message.includes('User not found') ? 'User not found' : 
                  error.message.includes('Invalid password') ? 'Invalid password' : 'Account deactivated'
        });
        
        return res.status(401).json({ error: 'Invalid credentials' });
      }
      
      // Record security error for other types of errors
      securityMonitor.recordSecurityError({
        type: 'LOGIN_ERROR',
        message: error.message,
        ip: clientIP,
        endpoint: '/login'
      });
      
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  /**
   * Get user photo
   */
  async getUserPhoto(req, res) {
    try {
      const { email } = req.params;
      
      if (!email) {
        return res.status(400).json({ error: 'Email is required' });
      }
      
      const photo = await authService.getUserPhoto(email);
      
      if (!photo) {
        return res.status(404).json({ error: 'Photo not found' });
      }
      
      res.set('Content-Type', photo.contentType);
      res.send(photo.data);
    } catch (error) {
      logger.error('Error getting user photo', {
        error: error.message,
        stack: error.stack,
        email: req.params.email
      });
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  /**
   * Upload user photo
   */
  async uploadPhoto(req, res) {
    try {
      const { email } = req.body;
      
      if (!email) {
        return res.status(400).json({ error: 'Email is required' });
      }
      
      if (!req.file) {
        return res.status(400).json({ error: 'No photo file provided' });
      }
      
      await authService.uploadUserPhoto(email, req.file.buffer, req.file.mimetype);
      
      res.json({ message: 'Photo uploaded successfully' });
    } catch (error) {
      logger.error('Error uploading photo', {
        error: error.message,
        stack: error.stack,
        email: req.params.email
      });
      
      if (error.message.includes('User not found')) {
        return res.status(404).json({ error: 'User not found' });
      }
      
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  /**
   * Get user password salt
   */
  async getSalt(req, res) {
    try {
      const { email } = req.body;
      
      if (!email) {
        return res.status(400).json({ error: 'Email is required' });
      }
      
      const salt = await authService.getUserSalt(email);
      
      res.json({ salt });
    } catch (error) {
      logger.error('Error getting salt', {
        error: error.message,
        stack: error.stack,
        email: req.params.email
      });
      
      if (error.message.includes('User not found')) {
        return res.status(404).json({ error: 'User not found' });
      }
      
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  /**
   * Send OTP for password reset
   */
  async sendOTP(req, res) {
    try {
      const { email } = req.body;
      
      if (!email) {
        return res.status(400).json({ error: 'Email is required' });
      }
      
      const otp = await authService.generateOTP(email);
      
      // Configure email transporter (you may want to move this to a config file)
      const transporter = nodemailer.createTransporter({
        service: 'gmail', // or your email service
        auth: {
          user: process.env.EMAIL_USER,
          pass: process.env.EMAIL_PASS
        }
      });
      
      // Send OTP email
      const mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: 'Password Reset OTP',
        html: `
          <h2>Password Reset Request</h2>
          <p>Your OTP for password reset is: <strong>${otp}</strong></p>
          <p>This OTP will expire in 10 minutes.</p>
          <p>If you didn't request this, please ignore this email.</p>
        `
      };
      
      await transporter.sendMail(mailOptions);
      
      res.json({ message: 'OTP sent successfully' });
    } catch (error) {
      logger.error('Error sending OTP', {
        error: error.message,
        stack: error.stack,
        email: req.body.email
      });
      
      if (error.message.includes('User not found')) {
        return res.status(404).json({ error: 'User not found' });
      }
      
      res.status(500).json({ error: 'Failed to send OTP' });
    }
  }

  /**
   * Verify OTP
   */
  async verifyOTP(req, res) {
    try {
      const { email, otp } = req.body;
      
      if (!email || !otp) {
        return res.status(400).json({ error: 'Email and OTP are required' });
      }
      
      const isValid = await authService.verifyOTP(email, otp);
      
      if (isValid) {
        res.json({ message: 'OTP verified successfully', valid: true });
      } else {
        res.status(400).json({ error: 'Invalid OTP', valid: false });
      }
    } catch (error) {
      logger.error('Error verifying OTP', {
        error: error.message,
        stack: error.stack,
        email: req.body.email
      });
      
      if (error.message.includes('User not found') ||
          error.message.includes('No valid OTP') ||
          error.message.includes('expired') ||
          error.message.includes('Invalid OTP')) {
        return res.status(400).json({ error: error.message, valid: false });
      }
      
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  /**
   * Update user password
   */
  async updatePassword(req, res) {
    try {
      const result = await authService.updatePassword(req.body);
      res.status(200).json(result);
    } catch (error) {
      logger.error('Error updating password', {
        error: error.message,
        stack: error.stack,
        email: req.body.email
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error updating password"
      });
    }
  }

  async getInitData(req, res) {
    try {
      const { email } = req.params;
      const result = await authService.getInitData(email);
      res.status(200).json(result);
    } catch (error) {
      logger.error('Error getting user init data', {
        error: error.message,
        stack: error.stack,
        email: req.params.email
      });
      res.status(500).json({
        statusCode: 500,
        message: "Error getting user data"
      });
    }
  }
}

module.exports = new AuthController();