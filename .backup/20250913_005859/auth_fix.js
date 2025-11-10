const argon2 = require('argon2');
const crypto = require('crypto');

/**
 * Verify Argon2 password hash
 * @param {string} inputPassword - The password to verify
 * @param {string} storedPassword - The stored password (hashHex + saltHex)
 * @returns {boolean} - True if password is valid
 */
async function verifyArgon2Password(inputPassword, storedPassword) {
  try {
    // Extract hash and salt from stored password
    // Format: hashHex (64 chars) + saltHex (64 chars) = 128 chars total
    if (storedPassword.length !== 128) {
      console.log('Invalid stored password format');
      return false;
    }
    
    const storedHashHex = storedPassword.substring(0, 64);
    const storedSaltHex = storedPassword.substring(64);
    
    // Convert salt from hex to bytes
    const storedSaltBytes = Buffer.from(storedSaltHex, 'hex');
    
    // Hash the input password with the same parameters used in Flutter
    const inputHash = await argon2.hash(inputPassword, {
      type: argon2.argon2i,
      memoryCost: 2 ** 16, // 2^16 KB = 64 MB (same as Flutter memoryPowerOf2: 16)
      timeCost: 2,         // Same as Flutter iterations: 2
      parallelism: 1,      // Default
      salt: storedSaltBytes,
      hashLength: 32,      // 32 bytes = 64 hex chars
      raw: true           // Return raw bytes
    });
    
    // Convert to hex and compare
    const inputHashHex = inputHash.toString('hex');
    
    console.log('Stored hash:', storedHashHex);
    console.log('Input hash: ', inputHashHex);
    console.log('Hashes match:', inputHashHex === storedHashHex);
    
    return inputHashHex === storedHashHex;
    
  } catch (error) {
    console.error('Error verifying Argon2 password:', error);
    return false;
  }
}

/**
 * Verify SHA-256 password hash (for web fallback)
 * @param {string} inputPassword - The password to verify
 * @param {string} storedPassword - The stored password (hashHex + saltHex)
 * @returns {boolean} - True if password is valid
 */
function verifySHA256Password(inputPassword, storedPassword) {
  try {
    // Extract hash and salt from stored password
    if (storedPassword.length !== 128) {
      console.log('Invalid stored password format for SHA-256');
      return false;
    }
    
    const storedHashHex = storedPassword.substring(0, 64);
    const storedSaltHex = storedPassword.substring(64);
    
    // Convert salt from hex to bytes
    const storedSaltBytes = Buffer.from(storedSaltHex, 'hex');
    
    // Create SHA-256 hash with password + salt (same as Flutter web)
    const combined = Buffer.concat([
      Buffer.from(inputPassword, 'utf8'),
      storedSaltBytes
    ]);
    
    const inputHash = crypto.createHash('sha256').update(combined).digest('hex');
    
    console.log('SHA-256 stored hash:', storedHashHex);
    console.log('SHA-256 input hash: ', inputHash);
    console.log('SHA-256 hashes match:', inputHash === storedHashHex);
    
    return inputHash === storedHashHex;
    
  } catch (error) {
    console.error('Error verifying SHA-256 password:', error);
    return false;
  }
}

/**
 * Universal password verification function
 * Tries both Argon2 and SHA-256 verification
 * @param {string} inputPassword - The password to verify
 * @param {string} storedPassword - The stored password (hashHex + saltHex)
 * @returns {boolean} - True if password is valid
 */
async function verifyPassword(inputPassword, storedPassword) {
  // First try Argon2 (used by mobile app)
  const argon2Valid = await verifyArgon2Password(inputPassword, storedPassword);
  if (argon2Valid) {
    console.log('Password verified with Argon2');
    return true;
  }
  
  // Then try SHA-256 (used by web app)
  const sha256Valid = verifySHA256Password(inputPassword, storedPassword);
  if (sha256Valid) {
    console.log('Password verified with SHA-256');
    return true;
  }
  
  console.log('Password verification failed with both methods');
  return false;
}

module.exports = {
  verifyArgon2Password,
  verifySHA256Password,
  verifyPassword
};