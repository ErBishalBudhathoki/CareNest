const { createLogger } = require('./logger');
const logger = createLogger('InputValidator');

/**
 * Comprehensive input validation and sanitization utility
 * Provides security-focused validation for all user inputs
 */
class InputValidator {
  // Common regex patterns
  static EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  static PHONE_REGEX = /^[\+]?[1-9]?\d{1,14}$/;
  static OBJECTID_REGEX = /^[0-9a-fA-F]{24}$/;
  static ALPHANUMERIC_REGEX = /^[a-zA-Z0-9]+$/;
  static NAME_REGEX = /^[a-zA-Z\s'-]{2,50}$/;
  static ORG_CODE_REGEX = /^[A-Z0-9]{6,12}$/;
  static OTP_REGEX = /^\d{6}$/;

  // Dangerous patterns to detect
  static SUSPICIOUS_PATTERNS = [
    /<script[^>]*>.*?<\/script>/gi,
    /javascript:/gi,
    /on\w+\s*=/gi,
    /\$\(.*\)/gi,
    /eval\s*\(/gi,
    /document\./gi,
    /window\./gi,
    /alert\s*\(/gi,
    /confirm\s*\(/gi,
    /prompt\s*\(/gi
  ];

  // Common weak passwords
  static WEAK_PASSWORDS = [
    'password', '123456', 'password123', 'admin', 'qwerty',
    'letmein', 'welcome', 'monkey', '1234567890', 'abc123'
  ];

  /**
   * Validates email format and checks for suspicious patterns
   * @param {string} email - Email to validate
   * @returns {Object} Validation result
   */
  static validateEmail(email) {
    if (!email || typeof email !== 'string') {
      return { isValid: false, error: 'Email is required and must be a string' };
    }

    const trimmedEmail = email.trim().toLowerCase();
    
    if (trimmedEmail.length > 254) {
      return { isValid: false, error: 'Email is too long' };
    }

    if (!this.EMAIL_REGEX.test(trimmedEmail)) {
      return { isValid: false, error: 'Invalid email format' };
    }

    if (this.containsSuspiciousPatterns(trimmedEmail)) {
      logger.security('Suspicious email pattern detected', { email: trimmedEmail });
      return { isValid: false, error: 'Invalid email format' };
    }

    return { isValid: true, sanitized: trimmedEmail };
  }

  /**
   * Validates password strength and security
   * @param {string} password - Password to validate
   * @returns {Object} Validation result
   */
  static validatePassword(password) {
    if (!password || typeof password !== 'string') {
      return { isValid: false, error: 'Password is required and must be a string' };
    }

    if (password.length < 8) {
      return { isValid: false, error: 'Password must be at least 8 characters long' };
    }

    if (password.length > 128) {
      return { isValid: false, error: 'Password is too long' };
    }

    // Check for common weak passwords
    if (this.WEAK_PASSWORDS.includes(password.toLowerCase())) {
      return { isValid: false, error: 'Password is too common. Please choose a stronger password' };
    }

    // Check password complexity
    const hasUppercase = /[A-Z]/.test(password);
    const hasLowercase = /[a-z]/.test(password);
    const hasNumbers = /\d/.test(password);
    const hasSpecialChars = /[!@#$%^&*(),.?":{}|<>]/.test(password);

    const complexityScore = [hasUppercase, hasLowercase, hasNumbers, hasSpecialChars].filter(Boolean).length;

    if (complexityScore < 3) {
      return { 
        isValid: false, 
        error: 'Password must contain at least 3 of: uppercase letters, lowercase letters, numbers, special characters' 
      };
    }

    return { isValid: true };
  }

  /**
   * Validates and sanitizes name fields
   * @param {string} name - Name to validate
   * @returns {Object} Validation result
   */
  static validateName(name) {
    if (!name || typeof name !== 'string') {
      return { isValid: false, error: 'Name is required and must be a string' };
    }

    const trimmedName = name.trim();
    
    if (trimmedName.length < 2 || trimmedName.length > 50) {
      return { isValid: false, error: 'Name must be between 2 and 50 characters' };
    }

    if (!this.NAME_REGEX.test(trimmedName)) {
      return { isValid: false, error: 'Name contains invalid characters' };
    }

    if (this.containsSuspiciousPatterns(trimmedName)) {
      logger.security('Suspicious name pattern detected', { name: trimmedName });
      return { isValid: false, error: 'Name contains invalid characters' };
    }

    return { isValid: true, sanitized: this.sanitizeString(trimmedName) };
  }

  /**
   * Validates organization code format
   * @param {string} orgCode - Organization code to validate
   * @returns {Object} Validation result
   */
  static validateOrganizationCode(orgCode) {
    if (!orgCode || typeof orgCode !== 'string') {
      return { isValid: false, error: 'Organization code is required and must be a string' };
    }

    const trimmedCode = orgCode.trim().toUpperCase();
    
    if (!this.ORG_CODE_REGEX.test(trimmedCode)) {
      return { isValid: false, error: 'Invalid organization code format' };
    }

    return { isValid: true, sanitized: trimmedCode };
  }

  /**
   * Validates OTP format
   * @param {string} otp - OTP to validate
   * @returns {Object} Validation result
   */
  static validateOTP(otp) {
    if (!otp || typeof otp !== 'string') {
      return { isValid: false, error: 'OTP is required and must be a string' };
    }

    const trimmedOTP = otp.trim();
    
    if (!this.OTP_REGEX.test(trimmedOTP)) {
      return { isValid: false, error: 'OTP must be exactly 6 digits' };
    }

    return { isValid: true, sanitized: trimmedOTP };
  }

  /**
   * Validates MongoDB ObjectId format
   * @param {string} id - ID to validate
   * @returns {Object} Validation result
   */
  static validateObjectId(id) {
    if (!id || typeof id !== 'string') {
      return { isValid: false, error: 'ID is required and must be a string' };
    }

    const trimmedId = id.trim();
    
    if (!this.OBJECTID_REGEX.test(trimmedId)) {
      return { isValid: false, error: 'Invalid ID format' };
    }

    return { isValid: true, sanitized: trimmedId };
  }

  /**
   * Validates user roles
   * @param {Array} roles - Roles to validate
   * @returns {Object} Validation result
   */
  static validateRoles(roles) {
    const validRoles = ['user', 'admin', 'moderator', 'employee', 'manager'];
    
    if (!Array.isArray(roles)) {
      return { isValid: false, error: 'Roles must be an array' };
    }

    if (roles.length === 0) {
      return { isValid: false, error: 'At least one role is required' };
    }

    for (const role of roles) {
      if (typeof role !== 'string' || !validRoles.includes(role.toLowerCase())) {
        return { isValid: false, error: `Invalid role: ${role}` };
      }
    }

    return { isValid: true, sanitized: roles.map(role => role.toLowerCase()) };
  }

  /**
   * Checks if input contains suspicious patterns
   * @param {string} input - Input to check
   * @returns {boolean} True if suspicious patterns found
   */
  static containsSuspiciousPatterns(input) {
    return this.SUSPICIOUS_PATTERNS.some(pattern => pattern.test(input));
  }

  /**
   * Sanitizes string input to prevent XSS
   * @param {string} input - Input to sanitize
   * @returns {string} Sanitized input
   */
  static sanitizeString(input) {
    if (typeof input !== 'string') {
      return input;
    }

    return input
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#x27;')
      .replace(/\//g, '&#x2F;')
      .replace(/\\/g, '&#x5C;')
      .trim();
  }

  /**
   * Validates request body size
   * @param {Object} body - Request body
   * @param {number} maxSize - Maximum size in bytes
   * @returns {Object} Validation result
   */
  static validateRequestSize(body, maxSize = 1024 * 1024) { // 1MB default
    const bodySize = JSON.stringify(body).length;
    
    if (bodySize > maxSize) {
      return { isValid: false, error: 'Request body too large' };
    }

    return { isValid: true };
  }

  /**
   * General field validation method
   * @param {Object} fields - Fields to validate
   * @param {Object} rules - Validation rules
   * @returns {Object} Validation result
   */
  static validateFields(fields, rules) {
    const errors = {};
    const sanitized = {};

    for (const [fieldName, fieldValue] of Object.entries(fields)) {
      const rule = rules[fieldName];
      if (!rule) continue;

      let result;
      switch (rule.type) {
        case 'email':
          result = this.validateEmail(fieldValue);
          break;
        case 'password':
          result = this.validatePassword(fieldValue);
          break;
        case 'name':
          result = this.validateName(fieldValue);
          break;
        case 'orgCode':
          result = this.validateOrganizationCode(fieldValue);
          break;
        case 'otp':
          result = this.validateOTP(fieldValue);
          break;
        case 'objectId':
          result = this.validateObjectId(fieldValue);
          break;
        case 'roles':
          result = this.validateRoles(fieldValue);
          break;
        default:
          result = { isValid: true, sanitized: this.sanitizeString(fieldValue) };
      }

      if (!result.isValid) {
        errors[fieldName] = result.error;
      } else if (result.sanitized !== undefined) {
        sanitized[fieldName] = result.sanitized;
      }
    }

    return {
      isValid: Object.keys(errors).length === 0,
      errors,
      sanitized
    };
  }
}

module.exports = InputValidator;