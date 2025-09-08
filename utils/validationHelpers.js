/**
 * Validation helper functions
 */

/**
 * Validate email format
 * @param {string} email - Email to validate
 * @returns {boolean} True if valid email format
 */
function isValidEmail(email) {
  if (!email || typeof email !== 'string') {
    return false;
  }
  
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email.trim());
}

/**
 * Validate phone number format (Australian format)
 * @param {string} phone - Phone number to validate
 * @returns {boolean} True if valid phone format
 */
function isValidPhone(phone) {
  if (!phone || typeof phone !== 'string') {
    return false;
  }
  
  // Remove all non-digit characters
  const cleanPhone = phone.replace(/\D/g, '');
  
  // Australian phone numbers: 10 digits starting with 04 for mobile, or 8-10 digits for landline
  return /^(04\d{8}|[2-9]\d{7,9})$/.test(cleanPhone);
}

/**
 * Validate ABN (Australian Business Number)
 * @param {string} abn - ABN to validate
 * @returns {boolean} True if valid ABN
 */
function isValidABN(abn) {
  if (!abn || typeof abn !== 'string') {
    return false;
  }
  
  // Remove spaces and hyphens
  const cleanABN = abn.replace(/[\s-]/g, '');
  
  // Must be 11 digits
  if (!/^\d{11}$/.test(cleanABN)) {
    return false;
  }
  
  // ABN checksum validation
  const weights = [10, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
  let sum = 0;
  
  for (let i = 0; i < 11; i++) {
    let digit = parseInt(cleanABN[i]);
    if (i === 0) {
      digit -= 1; // Subtract 1 from first digit
    }
    sum += digit * weights[i];
  }
  
  return sum % 89 === 0;
}

/**
 * Validate NDIS participant number
 * @param {string} participantNumber - NDIS participant number to validate
 * @returns {boolean} True if valid format
 */
function isValidNDISParticipantNumber(participantNumber) {
  if (!participantNumber || typeof participantNumber !== 'string') {
    return false;
  }
  
  // NDIS participant numbers are typically 9 digits
  const cleanNumber = participantNumber.replace(/\D/g, '');
  return /^\d{9}$/.test(cleanNumber);
}

/**
 * Validate support item number format
 * @param {string} supportItemNumber - Support item number to validate
 * @returns {boolean} True if valid format
 */
function isValidSupportItemNumber(supportItemNumber) {
  if (!supportItemNumber || typeof supportItemNumber !== 'string') {
    return false;
  }
  
  // Support item numbers are typically in format like "01_001_0103_1_1"
  const pattern = /^\d{2}_\d{3}_\d{4}_\d+_\d+$/;
  return pattern.test(supportItemNumber.trim());
}

/**
 * Validate price value
 * @param {number|string} price - Price to validate
 * @returns {boolean} True if valid price
 */
function isValidPrice(price) {
  if (price === null || price === undefined || price === '') {
    return false;
  }
  
  const numPrice = parseFloat(price);
  return !isNaN(numPrice) && numPrice >= 0 && numPrice <= 999999.99;
}

/**
 * Validate date string
 * @param {string} dateString - Date string to validate
 * @returns {boolean} True if valid date
 */
function isValidDate(dateString) {
  if (!dateString || typeof dateString !== 'string') {
    return false;
  }
  
  const date = new Date(dateString);
  return date instanceof Date && !isNaN(date.getTime());
}

/**
 * Validate MongoDB ObjectId format
 * @param {string} id - ID to validate
 * @returns {boolean} True if valid ObjectId format
 */
function isValidObjectId(id) {
  if (!id || typeof id !== 'string') {
    return false;
  }
  
  return /^[0-9a-fA-F]{24}$/.test(id);
}

/**
 * Validate organization code format
 * @param {string} code - Organization code to validate
 * @returns {boolean} True if valid format
 */
function isValidOrganizationCode(code) {
  if (!code || typeof code !== 'string') {
    return false;
  }
  
  // Organization codes are typically 6-8 uppercase alphanumeric characters
  return /^[A-Z0-9]{6,8}$/.test(code.trim());
}

/**
 * Validate password strength
 * @param {string} password - Password to validate
 * @returns {Object} Validation result with isValid and requirements
 */
function validatePassword(password) {
  if (!password || typeof password !== 'string') {
    return {
      isValid: false,
      requirements: {
        minLength: false,
        hasUppercase: false,
        hasLowercase: false,
        hasNumber: false,
        hasSpecialChar: false
      }
    };
  }
  
  const requirements = {
    minLength: password.length >= 8,
    hasUppercase: /[A-Z]/.test(password),
    hasLowercase: /[a-z]/.test(password),
    hasNumber: /\d/.test(password),
    hasSpecialChar: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
  };
  
  const isValid = Object.values(requirements).every(req => req);
  
  return {
    isValid,
    requirements
  };
}

/**
 * Validate required fields in an object
 * @param {Object} data - Data object to validate
 * @param {Array<string>} requiredFields - Array of required field names
 * @returns {Object} Validation result with isValid and missingFields
 */
function validateRequiredFields(data, requiredFields) {
  if (!data || typeof data !== 'object' || !Array.isArray(requiredFields)) {
    return {
      isValid: false,
      missingFields: requiredFields || []
    };
  }
  
  const missingFields = requiredFields.filter(field => {
    const value = data[field];
    return value === null || value === undefined || value === '';
  });
  
  return {
    isValid: missingFields.length === 0,
    missingFields
  };
}

/**
 * Sanitize string input
 * @param {string} input - Input string to sanitize
 * @returns {string} Sanitized string
 */
function sanitizeString(input) {
  if (!input || typeof input !== 'string') {
    return '';
  }
  
  return input
    .trim()
    .replace(/[<>"'&]/g, '') // Remove potentially dangerous characters
    .substring(0, 1000); // Limit length
}

/**
 * Validate file upload
 * @param {Object} file - File object to validate
 * @param {Object} options - Validation options
 * @returns {Object} Validation result
 */
function validateFileUpload(file, options = {}) {
  const {
    maxSize = 10 * 1024 * 1024, // 10MB default
    allowedTypes = ['image/jpeg', 'image/png', 'image/heif', 'application/pdf'],
    allowedExtensions = ['.jpg', '.jpeg', '.png', '.heif', '.pdf']
  } = options;
  
  if (!file) {
    return {
      isValid: false,
      error: 'No file provided'
    };
  }
  
  // Check file size
  if (file.size > maxSize) {
    return {
      isValid: false,
      error: `File size exceeds maximum allowed size of ${maxSize / (1024 * 1024)}MB`
    };
  }
  
  // Check MIME type
  if (!allowedTypes.includes(file.mimetype)) {
    return {
      isValid: false,
      error: `File type ${file.mimetype} is not allowed`
    };
  }
  
  // Check file extension
  const fileExtension = '.' + file.originalname.split('.').pop().toLowerCase();
  if (!allowedExtensions.includes(fileExtension)) {
    return {
      isValid: false,
      error: `File extension ${fileExtension} is not allowed`
    };
  }
  
  return {
    isValid: true
  };
}

module.exports = {
  isValidEmail,
  isValidPhone,
  isValidABN,
  isValidNDISParticipantNumber,
  isValidSupportItemNumber,
  isValidPrice,
  isValidDate,
  isValidObjectId,
  isValidOrganizationCode,
  validatePassword,
  validateRequiredFields,
  sanitizeString,
  validateFileUpload
};