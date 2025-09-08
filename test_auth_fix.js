require('dotenv').config();
const { MongoClient } = require('mongodb');
const { verifyPassword } = require('./auth_fix');

async function testAuthFix() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const user = await db.collection('login').findOne({ email: 'test@tester.com' });
    
    if (user && user.password) {
      console.log('Testing user:', user.email);
      console.log('Stored password:', user.password);
      console.log('Password length:', user.password.length);
      
      // Test common passwords
      const testPasswords = ['111111', 'test', 'password', 'test@tester.com', 'tester', '123456'];
      
      console.log('\n=== Testing password verification ===');
      
      for (const testPwd of testPasswords) {
        console.log(`\nTesting password: "${testPwd}"`);
        const isValid = await verifyPassword(testPwd, user.password);
        console.log(`Result: ${isValid ? '✅ VALID' : '❌ INVALID'}`);
        
        if (isValid) {
          console.log(`\n🎉 FOUND THE CORRECT PASSWORD: "${testPwd}"`);
          break;
        }
      }
      
    } else {
      console.log('User not found or missing password');
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

testAuthFix();