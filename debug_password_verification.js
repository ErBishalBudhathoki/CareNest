const { MongoClient } = require('mongodb');
const { verifyPassword } = require('./utils/cryptoHelpers');
const argon2 = require('argon2');

async function debugPasswordVerification() {
  const client = new MongoClient(process.env.MONGODB_URI || 'mongodb://localhost:27017');
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const collection = db.collection('login');
    
    // Find the test user
    const user = await collection.findOne({ email: 'test@tester.com' });
    
    if (!user) {
      console.log('User not found');
      return;
    }
    
    console.log('User found:');
    console.log('Email:', user.email);
    console.log('Password (hex):', user.password);
    console.log('Salt (hex):', user.salt);
    console.log('Password length:', user.password ? user.password.length : 'null');
    console.log('Salt length:', user.salt ? user.salt.length : 'null');
    
    const testPassword = 'testPassword123';
    console.log('\nTesting password:', testPassword);
    
    // Test 1: Using the verifyPassword function from cryptoHelpers
    console.log('\n=== Test 1: Using cryptoHelpers.verifyPassword ===');
    const result1 = await verifyPassword(testPassword, user.password, user.salt);
    console.log('Result:', result1);
    
    // Test 2: Manual Argon2 verification
    console.log('\n=== Test 2: Manual Argon2 verification ===');
    try {
      const saltBuffer = Buffer.from(user.salt, 'hex');
      console.log('Salt buffer length:', saltBuffer.length);
      
      // Recreate the hash using the same parameters as Flutter
      const computedHash = await argon2.hash(testPassword, {
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
      console.log('Computed hash (hex):', computedHashHex);
      console.log('Stored password (hex):', user.password);
      
      // Check if they match
      const match = computedHashHex === user.password;
      console.log('Hashes match:', match);
      
      // Also check if the stored password contains hash+salt
      if (user.password.length === 128) {
        const storedHashHex = user.password.substring(0, 64);
        const storedSaltHex = user.password.substring(64);
        console.log('\nChecking concatenated format:');
        console.log('Stored hash part:', storedHashHex);
        console.log('Stored salt part:', storedSaltHex);
        console.log('Provided salt:', user.salt);
        console.log('Salt parts match:', storedSaltHex === user.salt);
        console.log('Hash parts match:', storedHashHex === computedHashHex);
      }
      
    } catch (error) {
      console.error('Manual Argon2 verification error:', error);
    }
    
    // Test 3: Check if password is actually hash+salt concatenated
    console.log('\n=== Test 3: Check concatenated format ===');
    if (user.password.length === 128) {
      const hashPart = user.password.substring(0, 64);
      const saltPart = user.password.substring(64);
      
      console.log('Hash part from password:', hashPart);
      console.log('Salt part from password:', saltPart);
      console.log('Separate salt field:', user.salt);
      console.log('Salt parts match:', saltPart === user.salt);
      
      // Try verification with just the hash part
      const result3 = await verifyPassword(testPassword, hashPart, user.salt);
      console.log('Verification with hash part only:', result3);
    }
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

// Load environment variables
require('dotenv').config({ path: './.env' });
debugPasswordVerification();