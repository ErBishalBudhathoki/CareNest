require('dotenv').config();
const { MongoClient } = require('mongodb');
const crypto = require('crypto');

async function testArgon2Format() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const user = await db.collection('login').findOne({ email: 'test@tester.com' });
    
    if (user && user.password && user.salt) {
      console.log('User found:');
      console.log('Email:', user.email);
      console.log('Stored password:', user.password);
      console.log('Stored salt:', user.salt);
      console.log('Password length:', user.password.length);
      console.log('Salt length:', user.salt.length);
      
      // Based on the Flutter code, the format is: resultHex + saltHex
      // Where resultHex is 64 chars (32 bytes) and saltHex is 64 chars (32 bytes)
      // Total: 128 characters
      
      console.log('\n=== Analyzing Argon2 format (resultHex + saltHex) ===');
      
      if (user.password.length === 128 && user.salt.length === 64) {
        // Extract the hash part (first 64 characters)
        const hashPart = user.password.substring(0, 64);
        // Extract the salt part (last 64 characters)
        const saltPart = user.password.substring(64);
        
        console.log('Extracted hash part:', hashPart);
        console.log('Extracted salt part:', saltPart);
        console.log('Stored salt:        ', user.salt);
        console.log('Salt parts match:', saltPart === user.salt);
        
        if (saltPart === user.salt) {
          console.log('\n✅ Confirmed: Password format is hashHex + saltHex');
          
          // Now we need to figure out what the original password was
          // Since we can't reverse Argon2, let's try common passwords
          const testPasswords = ['111111', 'test', 'password', 'test@tester.com', 'tester', '123456', 'admin'];
          
          console.log('\n=== Testing passwords against Argon2 hash ===');
          console.log('Note: We cannot reverse Argon2, but we can test common passwords');
          
          // Convert salt from hex to bytes for testing
          const saltBytes = Buffer.from(user.salt, 'hex');
          console.log('Salt as bytes:', saltBytes);
          
          // For now, let's just document what we found
          console.log('\n=== Summary ===');
          console.log('✅ Password format confirmed: Argon2Hash(32 bytes) + Salt(32 bytes)');
          console.log('✅ Both parts are hex-encoded, total 128 characters');
          console.log('✅ Salt part matches the separate salt field');
          console.log('❌ Cannot determine original password without brute force');
          
          // Let's check if there's a pattern in the hash that might give us a clue
          console.log('\n=== Hash Analysis ===');
          console.log('Hash part:', hashPart);
          console.log('Hash starts with:', hashPart.substring(0, 8));
          console.log('Hash ends with:', hashPart.substring(56));
          
          // Check if this might be a simple hash instead of Argon2
          for (const testPwd of testPasswords) {
            const sha256Hash = crypto.createHash('sha256').update(testPwd + user.salt).digest('hex');
            const sha256HashReverse = crypto.createHash('sha256').update(user.salt + testPwd).digest('hex');
            
            if (sha256Hash.substring(0, 64) === hashPart) {
              console.log(`\n🎉 FOUND MATCH! Password is: "${testPwd}" (SHA-256 with salt appended)`);
              break;
            }
            if (sha256HashReverse.substring(0, 64) === hashPart) {
              console.log(`\n🎉 FOUND MATCH! Password is: "${testPwd}" (SHA-256 with salt prepended)`);
              break;
            }
          }
          
        } else {
          console.log('❌ Salt parts do not match - unexpected format');
        }
      } else {
        console.log('❌ Unexpected password or salt length');
      }
      
    } else {
      console.log('User not found or missing password/salt');
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

testArgon2Format();