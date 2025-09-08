const crypto = require('crypto');
const logger = require('./logger');
const nodemailer = require('nodemailer');
const argon2 = require('argon2');

// Server encryption key storage
let serverEncryptionKey;

/**
 * Generate a random 6-digit OTP
 * @returns {string} 6-digit OTP
 */
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

/**
 * Generate a random organization code
 * @returns {string} 8-character organization code
 */
function generateOrganizationCode() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  let result = '';
  for (let i = 0; i < 8; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return result;
}

/**
 * Pad a string to the left with a specified character
 * @param {string} str - String to pad
 * @param {number} length - Target length
 * @param {string} char - Character to pad with
 * @returns {string} Padded string
 */
function padLeft(str, length, char) {
  while (str.length < length) {
    str = char + str;
  }
  return str;
}

/**
 * Generate server encryption key
 * @returns {string} Encryption key
 */
function generateEncryptionKey() {
  serverEncryptionKey = crypto.randomBytes(8).toString('hex');
  return serverEncryptionKey;
}

/**
 * Get current server encryption key
 * @returns {string} Current encryption key
 */
function getServerEncryptionKey() {
  return serverEncryptionKey;
}

/**
 * XOR two hex strings of the same length
 * @param {string} a - First hex string
 * @param {string} b - Second hex string
 * @returns {string} XOR result
 */
function xorHex(a, b) {
  let result = '';
  for (let i = 0; i < a.length; i += 2) {
    result += (parseInt(a.substr(i, 2), 16) ^ parseInt(b.substr(i, 2), 16)).toString(16).padStart(2, '0');
  }
  return result;
}

/**
 * Encrypt OTP with timestamp
 * @param {string} otp - OTP to encrypt
 * @param {string} flutterEncryptKey - Flutter encryption key
 * @returns {string} Encrypted data
 */
function encryptOTP(otp, flutterEncryptKey) {
  const IV_LENGTH = 16;
  let iv = crypto.randomBytes(IV_LENGTH);
  let timestamp = padLeft(Date.now().toString(), 13, '0');
  let encryptionKey = generateEncryptionKey();
  
  let combinedKey = (flutterEncryptKey + encryptionKey).slice(0, 32);
  let dataToEncrypt = Buffer.from(timestamp + otp);
  let cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(combinedKey, 'utf-8'), iv);
  let encrypted = Buffer.concat([iv, cipher.update(dataToEncrypt), cipher.final()]);
  
  return encrypted.toString('hex');
}

/**
 * Decrypt OTP and extract timestamp
 * @param {string} encryptedData - Encrypted data
 * @param {string} flutterEncryptKey - Flutter encryption key
 * @param {string} encryptionKey - Server encryption key
 * @returns {object|null} Decrypted data or null
 */
function decryptOTP(encryptedData, flutterEncryptKey, encryptionKey) {
  const IV_LENGTH = 16;

  try {
    let encryptedBuffer = Buffer.from(encryptedData, 'hex');
    let iv = encryptedBuffer.slice(0, IV_LENGTH);
    let encrypted = encryptedBuffer.slice(IV_LENGTH);
    
    const minKeyLength = 16;
    let combinedKey = (
      flutterEncryptKey.padEnd(minKeyLength, '0') +
      encryptionKey.padEnd(minKeyLength, '0')
    ).slice(0, 32);

    let decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(combinedKey, 'utf-8'), iv);
    let decrypted = Buffer.concat([decipher.update(encrypted), decipher.final()]);

    let timestamp = decrypted.slice(0, 13).toString();
    let otp = decrypted.slice(13).toString();

    return { timestamp, otp };
  } catch (error) {
    logger.error('Error in decryptOTP', {
      error: error.message,
      stack: error.stack
    });
    return null;
  }
}

/**
 * Send OTP email
 * @param {string} email - Recipient email
 * @param {string} flutterClientKey - Flutter client key
 * @returns {object} OTP and verification key
 */
async function sendOtpEmail(email, flutterClientKey) {
  const otp = generateOTP();
  const verificationKey = encryptOTP(otp, flutterClientKey);

  const transporter = nodemailer.createTransporter({
    service: 'gmail',
    auth: {
      user: process.env.ADMIN_EMAIL,
      pass: process.env.APP_PASSWORD,
    },
  });

  const mailOptions = {
    from: process.env.ADMIN_EMAIL,
    to: email,
    subject: 'OTP Verification',
    text: `Your OTP code is: ${otp}\n`,
  };

  try {
    await transporter.sendMail(mailOptions);
    return { otp, verificationKey };
  } catch (error) {
    logger.error('Error sending email', {
      error: error.message,
      stack: error.stack
    });
    throw error;
  }
}

/**
 * Verify OTP with timestamp validation
 * @param {string} userOTP - User provided OTP
 * @param {string} userVerificationKey - User verification key
 * @param {string} generatedOTP - Generated OTP
 * @param {string} encryptVerificationKey - Encrypted verification key
 * @param {number} timeLimitSeconds - Time limit in seconds
 * @returns {boolean} Verification result
 */
function verifyOTP(userOTP, userVerificationKey, generatedOTP, encryptVerificationKey, timeLimitSeconds) {
  const isOTPValid = userOTP === generatedOTP;

  if (!isOTPValid) {
    return false;
  }

  const serverGeneratedVerificationKey = serverEncryptionKey;
  const extractedData = decryptOTP(encryptVerificationKey, userVerificationKey, serverGeneratedVerificationKey);
  
  if (extractedData !== null) {
    const { timestamp, otp } = extractedData;
    
    const currentTime = Math.floor(new Date().getTime() / 1000);
    const isTimestampValid = (currentTime - timestamp / 1000) <= timeLimitSeconds;

    if (!isTimestampValid) {
      return false;
    }
    
    if (otp !== userOTP) {
      return false;
    }
    
    return true;
  } else {
    return false;
  }
}

/**
 * Generate a secure random string
 * @param {number} length - Length of the string
 * @returns {string} Random string
 */
function generateSecureRandomString(length = 32) {
  return crypto.randomBytes(length).toString('hex');
}

/**
 * Hash a password using bcrypt-like approach
 * @param {string} password - Password to hash
 * @param {number} saltRounds - Salt rounds (default: 10)
 * @returns {string} Hashed password
 */
function hashPassword(password, saltRounds = 10) {
  const salt = crypto.randomBytes(16).toString('hex');
  const hash = crypto.pbkdf2Sync(password, salt, saltRounds * 1000, 64, 'sha512').toString('hex');
  return `${salt}:${hash}`;
}

/**
 * Verify password against hash
 * @param {string} password - Password to verify
 * @param {string} hashedPassword - Stored hash
 * @param {string} salt - Stored salt (optional, for custom Argon2)
 * @returns {Promise<boolean>} Verification result
 */
async function verifyPassword(password, hashedPassword, salt = null) {
  try {
    // If salt is provided separately, this is custom Argon2 from Flutter frontend
    if (salt && salt.length === 64) {
      // Custom Argon2 verification - recreate the hash using the same parameters as Flutter
      // Flutter uses: Argon2i, iterations=2, memory=2^16=65536, salt from hex
      const saltBuffer = Buffer.from(salt, 'hex');
      
      // Use argon2 to hash the password with the same parameters
      const computedHash = await argon2.hash(password, {
        type: argon2.argon2i,
        memoryCost: 2 ** 16, // 65536
        timeCost: 2,
        parallelism: 1,
        salt: saltBuffer,
        hashLength: 32,
        version: 0x10, // ARGON2_VERSION_10
        raw: true
      });
      
      const computedHashHex = computedHash.toString('hex');
      
      // Check if stored password is hash + salt concatenated (128 chars total)
      if (hashedPassword.length === 128) {
        // Extract the hash part (first 64 chars) and salt part (last 64 chars)
        const storedHashHex = hashedPassword.substring(0, 64);
        const storedSaltHex = hashedPassword.substring(64);
        
        // Verify salt matches
        if (storedSaltHex !== salt) {
          return false;
        }
        
        // Compare the computed hash with the stored hash
        return computedHashHex === storedHashHex;
      }
      
      // Direct comparison if not concatenated
      const expectedHashBuffer = Buffer.from(hashedPassword, 'hex');
      return Buffer.compare(expectedHashBuffer, computedHash) === 0;
    }
    
    // Handle PBKDF2 formats: 'salt:hash' and 'hash+salt' (concatenated)
    let pbkdf2Salt, pbkdf2Hash;
    
    if (hashedPassword.includes(':')) {
      // Format: salt:hash
      [pbkdf2Salt, pbkdf2Hash] = hashedPassword.split(':');
    } else if (hashedPassword.length === 128) {
      // Format: hash+salt (concatenated, 64 chars each)
      pbkdf2Hash = hashedPassword.substring(0, 64);
      pbkdf2Salt = hashedPassword.substring(64);
    } else {
      return false;
    }
    
    const verifyHash = crypto.pbkdf2Sync(password, pbkdf2Salt, 10000, 64, 'sha512').toString('hex');
    return pbkdf2Hash === verifyHash;
  } catch (error) {
    console.error('Password verification error:', error);
    return false;
  }
}

module.exports = {
  generateOTP,
  generateOrganizationCode,
  padLeft,
  generateEncryptionKey,
  getServerEncryptionKey,
  xorHex,
  encryptOTP,
  decryptOTP,
  sendOtpEmail,
  verifyOTP,
  generateSecureRandomString,
  hashPassword,
  verifyPassword
};