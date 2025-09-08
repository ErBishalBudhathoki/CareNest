require('dotenv').config();
const { MongoClient } = require('mongodb');
const crypto = require('crypto');

async function testSimpleSHA256() {
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
      
      // Test common passwords with simple SHA-256 (like frontend does)
      const testPasswords = ['111111', 'test', 'password', 'test@tester.com', 'tester', '123456'];
      
      console.log('\n=== Testing simple SHA-256 verification ===');
      
      for (const testPwd of testPasswords) {
        console.log(`\nTesting password: "${testPwd}"`);
        
        // Simple SHA-256 hash like frontend
        const bytes = Buffer.from(testPwd, 'utf8');
        const hash = crypto.createHash('sha256').update(bytes).digest('hex');
        
        console.log('Generated hash:', hash);
        console.log('Stored password:', user.password);
        console.log('Match:', hash === user.password);
        
        if (hash === user.password) {
          console.log(`\n🎉 FOUND THE CORRECT PASSWORD: "${testPwd}"`);
          console.log('The stored password is a simple SHA-256 hash!');
          break;
        }
      }
      
      // Also test if stored password is the hash part of a longer format
      console.log('\n=== Testing if stored password is part of hash+salt format ===');
      if (user.password.length === 128) {
        const hashPart = user.password.substring(0, 64);
        const saltPart = user.password.substring(64);
        console.log('Hash part (first 64 chars):', hashPart);
        console.log('Salt part (last 64 chars):', saltPart);
        
        for (const testPwd of testPasswords) {
          const simpleHash = crypto.createHash('sha256').update(Buffer.from(testPwd, 'utf8')).digest('hex');
          if (simpleHash === hashPart) {
            console.log(`\n🎉 FOUND MATCH IN HASH PART: "${testPwd}"`);
            console.log('The first 64 chars are a simple SHA-256 hash!');
            break;
          }
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

testSimpleSHA256();