require('dotenv').config();
const { MongoClient } = require('mongodb');
const argon2 = require('argon2');
const crypto = require('crypto');

// This script will:
// 1. Create a new user with a known password using proper Argon2 hashing
// 2. Test the verification process
// 3. Show how to fix the authentication system

async function fixAuthSystem() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Test password
    const testPassword = '111111';
    const testEmail = 'test_fixed@tester.com';
    
    console.log('=== Creating properly hashed user ===');
    
    // Generate salt (32 bytes)
    const salt = crypto.randomBytes(32);
    console.log('Generated salt:', salt.toString('hex'));
    
    // Hash password with Argon2 using the same parameters as Flutter
    const argon2Hash = await argon2.hash(testPassword, {
      type: argon2.argon2i,
      memoryCost: 2 ** 16, // 2^16 KB = 64 MB
      timeCost: 2,
      parallelism: 1,
      salt: salt,
      hashLength: 32,
      raw: true // Return raw bytes instead of encoded string
    });
    
    console.log('Argon2 hash (raw bytes):', argon2Hash);
    console.log('Argon2 hash (hex):', argon2Hash.toString('hex'));
    
    // Create the combined format like Flutter does: hashHex + saltHex
    const hashHex = argon2Hash.toString('hex');
    const saltHex = salt.toString('hex');
    const combinedPassword = hashHex + saltHex;
    
    console.log('Hash hex:', hashHex);
    console.log('Salt hex:', saltHex);
    console.log('Combined password:', combinedPassword);
    
    // Insert the user
    await db.collection('login').deleteOne({ email: testEmail }); // Remove if exists
    await db.collection('login').insertOne({
      email: testEmail,
      password: combinedPassword,
      salt: saltHex,
      createdAt: new Date()
    });
    
    console.log('✅ User created with proper Argon2 hash');
    
    // Now test verification
    console.log('\n=== Testing verification ===');
    
    const storedUser = await db.collection('login').findOne({ email: testEmail });
    if (storedUser) {
      console.log('Retrieved user:', {
        email: storedUser.email,
        passwordLength: storedUser.password.length,
        saltLength: storedUser.salt.length
      });
      
      // Extract hash and salt from stored password
      const storedHashHex = storedUser.password.substring(0, 64);
      const storedSaltHex = storedUser.password.substring(64);
      
      console.log('Stored hash hex:', storedHashHex);
      console.log('Stored salt hex:', storedSaltHex);
      console.log('Salt matches:', storedSaltHex === storedUser.salt);
      
      // Convert back to bytes for verification
      const storedHashBytes = Buffer.from(storedHashHex, 'hex');
      const storedSaltBytes = Buffer.from(storedSaltHex, 'hex');
      
      // Verify the password
      const isValid = await argon2.verify(
        storedHashBytes.toString('base64'), // Argon2 expects base64
        testPassword,
        {
          type: argon2.argon2i,
          memoryCost: 2 ** 16,
          timeCost: 2,
          parallelism: 1,
          salt: storedSaltBytes
        }
      );
      
      console.log('Password verification result:', isValid);
      
      // Alternative verification method - hash the input password and compare
      const inputHash = await argon2.hash(testPassword, {
        type: argon2.argon2i,
        memoryCost: 2 ** 16,
        timeCost: 2,
        parallelism: 1,
        salt: storedSaltBytes,
        hashLength: 32,
        raw: true
      });
      
      const inputHashHex = inputHash.toString('hex');
      console.log('Input hash hex:', inputHashHex);
      console.log('Hashes match:', inputHashHex === storedHashHex);
      
      if (inputHashHex === storedHashHex) {
        console.log('\n🎉 SUCCESS! Password verification works!');
        console.log('\n=== How to fix the backend ===');
        console.log('1. Install argon2: npm install argon2');
        console.log('2. Update login endpoint to extract hash and salt from password');
        console.log('3. Use argon2.hash() to hash input password with stored salt');
        console.log('4. Compare the resulting hash with stored hash');
        console.log('\nExample code:');
        console.log(`
const storedHashHex = user.password.substring(0, 64);
const storedSaltHex = user.password.substring(64);
const storedSaltBytes = Buffer.from(storedSaltHex, 'hex');

const inputHash = await argon2.hash(inputPassword, {
  type: argon2.argon2i,
  memoryCost: 2 ** 16,
  timeCost: 2,
  parallelism: 1,
  salt: storedSaltBytes,
  hashLength: 32,
  raw: true
});

const isValid = inputHash.toString('hex') === storedHashHex;
`);
      }
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

fixAuthSystem();