require('dotenv').config({ path: './.env' });
const { MongoClient } = require('mongodb');
const { verifyPassword } = require('./utils/cryptoHelpers');

async function testArgon2Verification() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Testing Argon2 password verification...');
    
    const db = client.db('Invoice');
    const collection = db.collection('login');
    
    // Get the test user
    const user = await collection.findOne({ email: 'test@tester.com' });
    
    if (!user) {
      console.log('User not found');
      return;
    }
    
    console.log('User email:', user.email);
    console.log('Stored password (hex):', user.password);
    console.log('Stored salt (hex):', user.salt);
    
    const password = '111111';
    console.log('\nTesting with password:', password);
    
    // Test with the updated verifyPassword function
    console.log('\n=== ARGON2 VERIFICATION ATTEMPT ===');
    const isValid = await verifyPassword(password, user.password, user.salt);
    console.log('Password verification result:', isValid);
    
    if (isValid) {
      console.log('✅ Password verification successful!');
    } else {
      console.log('❌ Password verification failed');
      
      // Let's manually test the exact scenario
      console.log('\n=== MANUAL VERIFICATION DEBUG ===');
      
      // Extract hash and salt from stored password
      const storedHashHex = user.password.substring(0, 64);
      const storedSaltHex = user.password.substring(64);
      
      console.log('Extracted hash (64 chars):', storedHashHex);
      console.log('Extracted salt (64 chars):', storedSaltHex);
      console.log('Provided salt matches extracted:', storedSaltHex === user.salt);
      
      // Check if hash is actually 63 characters
      if (storedHashHex.length === 63) {
        console.log('✅ Hash is 63 characters - this should trigger truncated comparison');
      } else {
        console.log('❌ Hash is not 63 characters, length:', storedHashHex.length);
      }
      
      // Test with a different approach - maybe the issue is elsewhere
      console.log('\n=== TESTING DIFFERENT SCENARIOS ===');
      
      // Test 1: Direct hash comparison (first 63 chars)
      const argon2 = require('argon2');
      const saltBuffer = Buffer.from(user.salt, 'hex');
      
      const computedHash = await argon2.hash(password, {
        type: argon2.argon2i,
        memoryCost: 2 ** 16,
        timeCost: 2,
        parallelism: 1,
        salt: saltBuffer,
        hashLength: 32,
        version: 0x10,
        raw: true
      });
      
      const computedHashHex = computedHash.toString('hex');
      console.log('Computed hash (full):', computedHashHex);
      console.log('Computed hash (63 chars):', computedHashHex.substring(0, 63));
      console.log('Stored hash (63 chars):', storedHashHex);
      console.log('Match (63 chars):', computedHashHex.substring(0, 63) === storedHashHex);
    }
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

testArgon2Verification();