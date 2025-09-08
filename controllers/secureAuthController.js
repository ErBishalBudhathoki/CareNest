const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const { createLogger } = require('../utils/logger');
const SecureErrorHandler = require('../utils/errorHandler');
const InputValidator = require('../utils/inputValidator');
const { generateOTP, verifyOTP, hashPassword } = require('../utils/cryptoHelpers');

const logger = createLogger('SecureAuthController');
const uri = process.env.MONGODB_URI;

/**
 * Secure Authentication Controller
 * Handles all authentication operations with comprehensive security measures
 */
class SecureAuthController {
  /**
   * User registration with enhanced security
   */
  static async register(req, res) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      // Validate request body size
      const bodySizeValidation = InputValidator.validateRequestSize(req.body);
      if (!bodySizeValidation.isValid) {
        logger.security('Request body too large', { 
          ip: req.ip, 
          size: JSON.stringify(req.body).length 
        });
        return res.status(413).json(
          SecureErrorHandler.createErrorResponse(
            'Request body too large',
            413,
            'BODY_TOO_LARGE'
          )
        );
      }

      // Extract and validate input
      const { email, password, confirmPassword, firstName, lastName, organizationCode, phone } = req.body;

      // Validate required fields
      if (!email || !password || !confirmPassword || !firstName || !lastName) {
        logger.security('Missing required registration fields', { ip: req.ip, email });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'All required fields must be provided',
            400,
            'MISSING_FIELDS'
          )
        );
      }

      // Validate email
      const emailValidation = InputValidator.validateEmail(email);
      if (!emailValidation.isValid) {
        logger.security('Invalid email format in registration', { ip: req.ip, email });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            emailValidation.message,
            400,
            'INVALID_EMAIL'
          )
        );
      }

      // Validate password
      const passwordValidation = InputValidator.validatePassword(password);
      if (!passwordValidation.isValid) {
        logger.security('Weak password in registration', { ip: req.ip, email: emailValidation.sanitized });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            passwordValidation.message,
            400,
            'WEAK_PASSWORD'
          )
        );
      }

      // Validate password confirmation
      if (password !== confirmPassword) {
        logger.security('Password confirmation mismatch', { ip: req.ip, email: emailValidation.sanitized });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Passwords do not match',
            400,
            'PASSWORD_MISMATCH'
          )
        );
      }

      // Validate names
      const firstNameValidation = InputValidator.validateName(firstName);
      const lastNameValidation = InputValidator.validateName(lastName);
      
      if (!firstNameValidation.isValid || !lastNameValidation.isValid) {
        logger.security('Invalid name format in registration', { ip: req.ip, email: emailValidation.sanitized });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid name format',
            400,
            'INVALID_NAME'
          )
        );
      }

      // Validate phone if provided
      let phoneValidation = { isValid: true, sanitized: null };
      if (phone) {
        phoneValidation = InputValidator.validatePhone(phone);
        if (!phoneValidation.isValid) {
          logger.security('Invalid phone format in registration', { ip: req.ip, email: emailValidation.sanitized });
          return res.status(400).json(
            SecureErrorHandler.createErrorResponse(
              phoneValidation.message,
              400,
              'INVALID_PHONE'
            )
          );
        }
      }

      // Validate organization code if provided
      let orgCodeValidation = { isValid: true, sanitized: null };
      if (organizationCode) {
        orgCodeValidation = InputValidator.validateOrganizationCode(organizationCode);
        if (!orgCodeValidation.isValid) {
          logger.security('Invalid organization code in registration', { ip: req.ip, email: emailValidation.sanitized });
          return res.status(400).json(
            SecureErrorHandler.createErrorResponse(
              orgCodeValidation.message,
              400,
              'INVALID_ORG_CODE'
            )
          );
        }
      }

      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');

      // Check if user already exists
      const existingUser = await usersCollection.findOne({ 
        email: emailValidation.sanitized 
      });
      
      if (existingUser) {
        logger.security('Registration attempt with existing email', { 
          ip: req.ip, 
          email: emailValidation.sanitized 
        });
        return res.status(409).json(
          SecureErrorHandler.createErrorResponse(
            'User with this email already exists',
            409,
            'USER_EXISTS'
          )
        );
      }

      // Hash password
      const hashedPassword = await hashPassword(password);
      
      // Generate user ID
      const userId = new ObjectId().toString();
      
      // Create user object
      const newUser = {
        userId,
        email: emailValidation.sanitized,
        password: hashedPassword,
        firstName: firstNameValidation.sanitized,
        lastName: lastNameValidation.sanitized,
        phone: phoneValidation.sanitized,
        organizationCode: orgCodeValidation.sanitized,
        roles: ['user'],
        isActive: true,
        isEmailVerified: false,
        createdAt: new Date(),
        updatedAt: new Date(),
        lastLogin: null,
        loginAttempts: 0,
        lockUntil: null
      };

      // Insert user
      await usersCollection.insertOne(newUser);

      // Generate email verification OTP
      const otpResult = await generateOTP(emailValidation.sanitized, 'email_verification');
      
      logger.info('User registered successfully', {
        userId,
        email: emailValidation.sanitized,
        ip: req.ip
      });

      res.status(201).json(
        SecureErrorHandler.createSuccessResponse(
          {
            userId,
            email: emailValidation.sanitized,
            firstName: firstNameValidation.sanitized,
            lastName: lastNameValidation.sanitized,
            verificationKey: otpResult.verificationKey
          },
          'User registered successfully. Please verify your email.'
        )
      );

    } catch (error) {
      logger.error('Registration error', {
        error: error.message,
        stack: error.stack,
        ip: req.ip
      });
      
      res.status(500).json(
        SecureErrorHandler.createErrorResponse(
          SecureErrorHandler.GENERIC_SERVER_ERROR,
          500,
          'REGISTRATION_ERROR'
        )
      );
    } finally {
      await client.close();
    }
  }

  /**
   * User login with enhanced security
   */
  static async login(req, res) {
    console.log('=== LOGIN METHOD CALLED ===');
    console.log('Login method called with:', { email: req.body?.email, hasPassword: !!req.body?.password });
    console.log('Request body:', req.body);
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      // Validate request body size
      const bodySizeValidation = InputValidator.validateRequestSize(req.body);
      if (!bodySizeValidation.isValid) {
        logger.security('Request body too large in login', { ip: req.ip });
        return res.status(413).json(
          SecureErrorHandler.createErrorResponse(
            'Request body too large',
            413,
            'BODY_TOO_LARGE'
          )
        );
      }

      const { email, password } = req.body;

      // Validate required fields
      if (!email || !password) {
        logger.security('Missing login credentials', { ip: req.ip, email });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Email and password are required',
            400,
            'MISSING_CREDENTIALS'
          )
        );
      }

      // Validate email format
      const emailValidation = InputValidator.validateEmail(email);
      if (!emailValidation.isValid) {
        logger.security('Invalid email format in login', { ip: req.ip, email });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            400,
            'INVALID_CREDENTIALS'
          )
        );
      }

      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');

      // Find user
      const user = await usersCollection.findOne({ 
        email: emailValidation.sanitized 
      });
      
      if (!user) {
        logger.security('Login attempt with non-existent email', { 
          ip: req.ip, 
          email: emailValidation.sanitized 
        });
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            401,
            'USER_NOT_FOUND'
          )
        );
      }

      // Check if account is locked
      if (user.lockUntil && user.lockUntil > new Date()) {
        logger.security('Login attempt on locked account', { 
          ip: req.ip, 
          email: emailValidation.sanitized,
          lockUntil: user.lockUntil
        });
        return res.status(423).json(
          SecureErrorHandler.createErrorResponse(
            'Account is temporarily locked due to multiple failed login attempts',
            423,
            'ACCOUNT_LOCKED'
          )
        );
      }

      // Check if account is active
      if (!user.isActive) {
        logger.security('Login attempt on inactive account', { 
          ip: req.ip, 
          email: emailValidation.sanitized 
        });
        return res.status(403).json(
          SecureErrorHandler.createErrorResponse(
            'Account is deactivated',
            403,
            'ACCOUNT_DISABLED'
          )
        );
      }

      // Verify password using the correct method from cryptoHelpers
      console.log('About to verify password for user:', user.email);
      const { verifyPassword } = require('../utils/cryptoHelpers');
      console.log('Starting password verification...');
      const isPasswordValid = await verifyPassword(password, user.password, user.salt);
      console.log('Password verification result:', isPasswordValid);
      
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
        }
        
        await usersCollection.updateOne(
          { userId: user.userId },
          { $set: updateData }
        );
        
        logger.security('Failed login attempt', { 
          ip: req.ip, 
          email: emailValidation.sanitized,
          attempts: loginAttempts,
          locked: loginAttempts >= maxAttempts
        });
        
        return res.status(401).json(
          SecureErrorHandler.createErrorResponse(
            SecureErrorHandler.GENERIC_AUTH_ERROR,
            401,
            'INCORRECT_PASSWORD'
          )
        );
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

      // Generate JWT token
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

      logger.info('User logged in successfully', {
        userId: user.userId,
        email: user.email,
        ip: req.ip
      });

      res.status(200).json(
        SecureErrorHandler.createSuccessResponse(
          {
            token,
            user: {
              userId: user.userId,
              email: user.email,
              firstName: user.firstName,
              lastName: user.lastName,
              roles: user.roles,
              organizationId: user.organizationId,
              isEmailVerified: user.isEmailVerified
            }
          },
          'Login successful'
        )
      );

    } catch (error) {
      console.log('LOGIN ERROR DETAILS:', error.message, error.stack);
      logger.error('Login error', {
        error: error.message,
        stack: error.stack,
        ip: req.ip
      });
      
      res.status(500).json(
        SecureErrorHandler.createErrorResponse(
          SecureErrorHandler.GENERIC_SERVER_ERROR,
          500,
          'LOGIN_ERROR'
        )
      );
    } finally {
      await client.close();
    }
  }

  /**
   * Email verification
   */
  static async verifyEmail(req, res) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      const { email, otp, verificationKey } = req.body;

      // Validate required fields
      if (!email || !otp || !verificationKey) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Email, OTP, and verification key are required',
            400,
            'MISSING_FIELDS'
          )
        );
      }

      // Validate email
      const emailValidation = InputValidator.validateEmail(email);
      if (!emailValidation.isValid) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid email format',
            400,
            'INVALID_EMAIL'
          )
        );
      }

      // Validate OTP
      const otpValidation = InputValidator.validateOTP(otp);
      if (!otpValidation.isValid) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid OTP format',
            400,
            'INVALID_OTP'
          )
        );
      }

      // Verify OTP
      const otpVerification = await verifyOTP(otpValidation.sanitized, verificationKey);
      if (!otpVerification.success) {
        logger.security('Failed email verification attempt', { 
          ip: req.ip, 
          email: emailValidation.sanitized 
        });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid or expired OTP',
            400,
            'INVALID_OTP'
          )
        );
      }

      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');

      // Update user email verification status
      const result = await usersCollection.updateOne(
        { email: emailValidation.sanitized },
        { 
          $set: { 
            isEmailVerified: true,
            updatedAt: new Date()
          }
        }
      );

      if (result.matchedCount === 0) {
        return res.status(404).json(
          SecureErrorHandler.createErrorResponse(
            'User not found',
            404,
            'USER_NOT_FOUND'
          )
        );
      }

      logger.info('Email verified successfully', {
        email: emailValidation.sanitized,
        ip: req.ip
      });

      res.status(200).json(
        SecureErrorHandler.createSuccessResponse(
          null,
          'Email verified successfully'
        )
      );

    } catch (error) {
      logger.error('Email verification error', {
        error: error.message,
        stack: error.stack,
        ip: req.ip
      });
      
      res.status(500).json(
        SecureErrorHandler.createErrorResponse(
          SecureErrorHandler.GENERIC_SERVER_ERROR,
          500,
          'VERIFICATION_ERROR'
        )
      );
    } finally {
      await client.close();
    }
  }

  /**
   * Password reset request
   */
  static async requestPasswordReset(req, res) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      const { email } = req.body;

      // Validate email
      const emailValidation = InputValidator.validateEmail(email);
      if (!emailValidation.isValid) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid email format',
            400,
            'INVALID_EMAIL'
          )
        );
      }

      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');

      // Check if user exists
      const user = await usersCollection.findOne({ 
        email: emailValidation.sanitized 
      });
      
      // Always return success to prevent email enumeration
      if (!user) {
        logger.security('Password reset requested for non-existent email', { 
          ip: req.ip, 
          email: emailValidation.sanitized 
        });
      } else {
        // Generate password reset OTP
        const otpResult = await generateOTP(emailValidation.sanitized, 'password_reset');
        
        logger.info('Password reset OTP generated', {
          email: emailValidation.sanitized,
          ip: req.ip
        });
      }

      res.status(200).json(
        SecureErrorHandler.createSuccessResponse(
          null,
          'If an account with this email exists, a password reset code has been sent.'
        )
      );

    } catch (error) {
      logger.error('Password reset request error', {
        error: error.message,
        stack: error.stack,
        ip: req.ip
      });
      
      res.status(500).json(
        SecureErrorHandler.createErrorResponse(
          SecureErrorHandler.GENERIC_SERVER_ERROR,
          500,
          'PASSWORD_RESET_ERROR'
        )
      );
    } finally {
      await client.close();
    }
  }

  /**
   * Password reset confirmation
   */
  static async resetPassword(req, res) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      const { email, otp, verificationKey, newPassword, confirmPassword } = req.body;

      // Validate required fields
      if (!email || !otp || !verificationKey || !newPassword || !confirmPassword) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'All fields are required',
            400,
            'MISSING_FIELDS'
          )
        );
      }

      // Validate email
      const emailValidation = InputValidator.validateEmail(email);
      if (!emailValidation.isValid) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid email format',
            400,
            'INVALID_EMAIL'
          )
        );
      }

      // Validate password
      const passwordValidation = InputValidator.validatePassword(newPassword);
      if (!passwordValidation.isValid) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            passwordValidation.message,
            400,
            'WEAK_PASSWORD'
          )
        );
      }

      // Validate password confirmation
      if (newPassword !== confirmPassword) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Passwords do not match',
            400,
            'PASSWORD_MISMATCH'
          )
        );
      }

      // Validate OTP
      const otpValidation = InputValidator.validateOTP(otp);
      if (!otpValidation.isValid) {
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid OTP format',
            400,
            'INVALID_OTP'
          )
        );
      }

      // Verify OTP
      const otpVerification = await verifyOTP(otpValidation.sanitized, verificationKey);
      if (!otpVerification.success) {
        logger.security('Failed password reset attempt', { 
          ip: req.ip, 
          email: emailValidation.sanitized 
        });
        return res.status(400).json(
          SecureErrorHandler.createErrorResponse(
            'Invalid or expired OTP',
            400,
            'INVALID_OTP'
          )
        );
      }

      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');

      // Hash new password
      const hashedPassword = await hashPassword(newPassword);

      // Update user password
      const result = await usersCollection.updateOne(
        { email: emailValidation.sanitized },
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
        return res.status(404).json(
          SecureErrorHandler.createErrorResponse(
            'User not found',
            404,
            'USER_NOT_FOUND'
          )
        );
      }

      logger.info('Password reset successfully', {
        email: emailValidation.sanitized,
        ip: req.ip
      });

      res.status(200).json(
        SecureErrorHandler.createSuccessResponse(
          null,
          'Password reset successfully'
        )
      );

    } catch (error) {
      logger.error('Password reset error', {
        error: error.message,
        stack: error.stack,
        ip: req.ip
      });
      
      res.status(500).json(
        SecureErrorHandler.createErrorResponse(
          SecureErrorHandler.GENERIC_SERVER_ERROR,
          500,
          'PASSWORD_RESET_ERROR'
        )
      );
    } finally {
      await client.close();
    }
  }

  /**
   * Get user profile
   */
  static async getProfile(req, res) {
    const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    
    try {
      const { userId } = req.user;

      await client.connect();
      const db = client.db('Invoice');
      const usersCollection = db.collection('login');

      const user = await usersCollection.findOne(
        { userId },
        { 
          projection: { 
            password: 0, 
            loginAttempts: 0, 
            lockUntil: 0 
          } 
        }
      );

      if (!user) {
        return res.status(404).json(
          SecureErrorHandler.createErrorResponse(
            'User not found',
            404,
            'USER_NOT_FOUND'
          )
        );
      }

      res.status(200).json(
        SecureErrorHandler.createSuccessResponse(
          user,
          'Profile retrieved successfully'
        )
      );

    } catch (error) {
      logger.error('Get profile error', {
        error: error.message,
        stack: error.stack,
        userId: req.user?.userId,
        ip: req.ip
      });
      
      res.status(500).json(
        SecureErrorHandler.createErrorResponse(
          SecureErrorHandler.GENERIC_SERVER_ERROR,
          500,
          'PROFILE_ERROR'
        )
      );
    } finally {
      await client.close();
    }
  }

  /**
   * Logout user (token blacklisting would be implemented here)
   */
  static async logout(req, res) {
    try {
      // In a production environment, you would blacklist the token here
      // For now, we'll just log the logout event
      
      logger.info('User logged out', {
        userId: req.user?.userId,
        email: req.user?.email,
        ip: req.ip
      });

      res.status(200).json(
        SecureErrorHandler.createSuccessResponse(
          null,
          'Logged out successfully'
        )
      );

    } catch (error) {
      logger.error('Logout error', {
        error: error.message,
        stack: error.stack,
        userId: req.user?.userId,
        ip: req.ip
      });
      
      res.status(500).json(
        SecureErrorHandler.createErrorResponse(
          SecureErrorHandler.GENERIC_SERVER_ERROR,
          500,
          'LOGOUT_ERROR'
        )
      );
    }
  }
}

module.exports = SecureAuthController;