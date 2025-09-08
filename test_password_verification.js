require('dotenv').config({ path: './.env' });
const { verifyPassword } = require('./utils/cryptoHelpers');
const { MongoClient } = require('mongodb');

async function testPasswordVerification() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    const db = client.db('Invoice');
    const user = await db.collection('login').findOne({ email: 'test@tester.com' });
    
    if (user) {
      console.log('Testing password verification...');
      console.log('Stored password:', user.password);
      console.log('Password length:', user.password.length);
      
      // Test with the raw password
      const rawPassword = '111111';
      console.log('\nTesting with raw password:', rawPassword);
      const isValidRaw = await verifyPassword(rawPassword, user.password);
      console.log('Raw password verification result:', isValidRaw);
      
      // Test with the frontend-hashed password
      const frontendHashedPassword = 'REDACTEDREDACTED';
      console.log('\nTesting with frontend-hashed password:', frontendHashedPassword);
      const isValidFrontend = await verifyPassword(frontendHashedPassword, user.password);
      console.log('Frontend-hashed password verification result:', isValidFrontend);
      
      // Let's also test the hash generation manually
      const crypto = require('crypto');
      const salt = user.password.substring(64); // Last 64 chars
      const hash = user.password.substring(0, 64); // First 64 chars
      
      console.log('\nManual verification:');
      console.log('Extracted salt:', salt);
      console.log('Extracted hash:', hash);
      
      // Test with raw password
      const manualHashRaw = crypto.pbkdf2Sync(rawPassword, salt, 10000, 64, 'sha512').toString('hex');
      console.log('Manual hash (raw password):', manualHashRaw);
      console.log('Manual verification (raw):', hash === manualHashRaw);
      
      // Test with frontend-hashed password
      const manualHashFrontend = crypto.pbkdf2Sync(frontendHashedPassword, salt, 10000, 64, 'sha512').toString('hex');
      console.log('Manual hash (frontend password):', manualHashFrontend);
      console.log('Manual verification (frontend):', hash === manualHashFrontend);
      
    } else {
      console.log('User not found');
    }
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

testPasswordVerification();