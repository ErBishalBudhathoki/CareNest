require('dotenv').config();
const { MongoClient } = require('mongodb');
const crypto = require('crypto');

async function testConcatenatedHash() {
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
      
      // The pattern seems to be: password = hash + salt (concatenated)
      // Let's check if the last 64 characters of password match the salt
      const passwordLength = user.password.length;
      const saltLength = user.salt.length;
      
      console.log('\n=== Analyzing concatenation pattern ===');
      
      // Check if password ends with salt
      const passwordEndsWithSalt = user.password.endsWith(user.salt);
      console.log('Password ends with salt:', passwordEndsWithSalt);
      
      if (passwordEndsWithSalt) {
        // Extract the hash part (everything except the salt at the end)
        const hashPart = user.password.substring(0, passwordLength - saltLength);
        console.log('Extracted hash part:', hashPart);
        console.log('Hash part length:', hashPart.length);
        
        // Now test if this hash matches any common password + salt combinations
        const testPasswords = ['111111', 'test', 'password', 'test@tester.com', 'tester'];
        
        console.log('\n=== Testing passwords against extracted hash ===');
        
        for (const testPwd of testPasswords) {
          console.log(`\nTesting password: "${testPwd}"`);
          
          // Test different hash combinations with salt
          const sha256WithSalt = crypto.createHash('sha256').update(testPwd + user.salt).digest('hex');
          const saltWithSha256 = crypto.createHash('sha256').update(user.salt + testPwd).digest('hex');
          const sha256Only = crypto.createHash('sha256').update(testPwd).digest('hex');
          
          console.log(`SHA-256(password + salt): ${sha256WithSalt}`);
          console.log(`SHA-256(salt + password): ${saltWithSha256}`);
          console.log(`SHA-256(password): ${sha256Only}`);
          
          console.log(`Hash part matches SHA-256(password + salt): ${hashPart === sha256WithSalt}`);
          console.log(`Hash part matches SHA-256(salt + password): ${hashPart === saltWithSha256}`);
          console.log(`Hash part matches SHA-256(password): ${hashPart === sha256Only}`);
          
          if (hashPart === sha256WithSalt || hashPart === saltWithSha256 || hashPart === sha256Only) {
            console.log(`\n🎉 FOUND MATCH! Password is: "${testPwd}"`);
            console.log(`Hash method: ${hashPart === sha256WithSalt ? 'SHA-256(password + salt)' : hashPart === saltWithSha256 ? 'SHA-256(salt + password)' : 'SHA-256(password)'}`);
            
            // Verify the full concatenated format
            const expectedFullPassword = hashPart + user.salt;
            console.log(`Expected full password: ${expectedFullPassword}`);
            console.log(`Actual full password:   ${user.password}`);
            console.log(`Full password matches: ${expectedFullPassword === user.password}`);
            break;
          }
        }
      }
      
      // Also check if password starts with salt
      const passwordStartsWithSalt = user.password.startsWith(user.salt);
      console.log('\nPassword starts with salt:', passwordStartsWithSalt);
      
      if (passwordStartsWithSalt) {
        const hashPart = user.password.substring(saltLength);
        console.log('Hash part (after salt):', hashPart);
        
        // Test the same passwords
        for (const testPwd of ['111111', 'test', 'password']) {
          const sha256WithSalt = crypto.createHash('sha256').update(testPwd + user.salt).digest('hex');
          const saltWithSha256 = crypto.createHash('sha256').update(user.salt + testPwd).digest('hex');
          const sha256Only = crypto.createHash('sha256').update(testPwd).digest('hex');
          
          if (hashPart === sha256WithSalt || hashPart === saltWithSha256 || hashPart === sha256Only) {
            console.log(`\n🎉 FOUND MATCH (salt first)! Password is: "${testPwd}"`);
            break;
          }
        }
      }
      
    } else {
      console.log('User not found or missing password/salt');
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

testConcatenatedHash();