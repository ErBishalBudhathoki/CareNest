require('dotenv').config();
const { MongoClient } = require('mongodb');
const crypto = require('crypto');

async function testSHA256Login() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const user = await db.collection('login').findOne({ email: 'test@tester.com' });
    
    if (user) {
      console.log('User found:');
      console.log('Email:', user.email);
      console.log('Stored password:', user.password);
      
      // Test SHA-256 hashing like the Flutter app does
      const testPassword = '111111';
      const sha256Hash = crypto.createHash('sha256').update(testPassword).digest('hex');
      console.log('SHA-256 hash of "111111":', sha256Hash);
      
      // Compare with stored password
      const passwordsMatch = user.password === sha256Hash;
      console.log('Passwords match:', passwordsMatch);
      
      if (passwordsMatch) {
        console.log('✅ SUCCESS: The password "111111" correctly matches the stored hash!');
        console.log('The issue is that the backend login endpoint is using bcrypt instead of direct comparison.');
      } else {
        console.log('❌ FAIL: The passwords do not match.');
        console.log('Expected:', sha256Hash);
        console.log('Actual  :', user.password);
      }
    } else {
      console.log('User not found');
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

testSHA256Login();