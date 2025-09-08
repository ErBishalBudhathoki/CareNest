require('dotenv').config();
const { MongoClient } = require('mongodb');
const crypto = require('crypto');

async function analyzePasswordHash() {
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
      console.log('Stored salt:', user.salt);
      console.log('Password length:', user.password.length);
      console.log('Salt length:', user.salt ? user.salt.length : 'undefined');
      
      // The stored password appears to be 128 characters, which suggests it might be:
      // 1. SHA-512 (128 hex chars = 64 bytes)
      // 2. SHA-256 + salt concatenated
      // 3. Some other custom hashing
      
      console.log('\n=== Testing different password combinations ===');
      
      // Test common passwords
      const testPasswords = ['111111', 'test', 'password', 'test@tester.com', 'tester'];
      
      for (const testPwd of testPasswords) {
        console.log(`\nTesting password: "${testPwd}"`);
        
        // Test SHA-256
        const sha256 = crypto.createHash('sha256').update(testPwd).digest('hex');
        console.log(`SHA-256: ${sha256}`);
        console.log(`SHA-256 matches: ${sha256 === user.password}`);
        
        // Test SHA-512
        const sha512 = crypto.createHash('sha512').update(testPwd).digest('hex');
        console.log(`SHA-512: ${sha512}`);
        console.log(`SHA-512 matches: ${sha512 === user.password}`);
        
        // Test SHA-256 with salt
        if (user.salt) {
          const sha256WithSalt = crypto.createHash('sha256').update(testPwd + user.salt).digest('hex');
          console.log(`SHA-256 + salt: ${sha256WithSalt}`);
          console.log(`SHA-256 + salt matches: ${sha256WithSalt === user.password}`);
          
          const saltWithSha256 = crypto.createHash('sha256').update(user.salt + testPwd).digest('hex');
          console.log(`Salt + SHA-256: ${saltWithSha256}`);
          console.log(`Salt + SHA-256 matches: ${saltWithSha256 === user.password}`);
        }
      }
      
      // Check if the stored password might be the salt + hash concatenated
      if (user.salt && user.password.length === 128) {
        console.log('\n=== Checking if password is salt + hash concatenated ===');
        const saltLength = user.salt.length;
        const possibleHash = user.password.substring(saltLength);
        const possibleSaltFromPassword = user.password.substring(0, saltLength);
        
        console.log(`Salt from DB: ${user.salt}`);
        console.log(`Possible salt from password: ${possibleSaltFromPassword}`);
        console.log(`Possible hash part: ${possibleHash}`);
        console.log(`Salt matches: ${user.salt === possibleSaltFromPassword}`);
      }
      
    } else {
      console.log('User not found');
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

analyzePasswordHash();