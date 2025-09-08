const { MongoClient } = require('mongodb');
const crypto = require('crypto');
const argon2 = require('argon2');

// Load environment variables
require('dotenv').config({ path: './.env' });

async function fixPasswordVerification() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
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
    
    console.log('Current user data:');
    console.log('Email:', user.email);
    console.log('Password (hex):', user.password);
    console.log('Salt (hex):', user.salt);
    console.log('Password length:', user.password ? user.password.length : 'null');
    
    const testPassword = 'testPassword123';
    
    // The issue is that the password field contains hash+salt concatenated (128 chars)
    // But we also have a separate salt field
    // The verifyPassword function gets confused by this
    
    // Let's extract the correct hash from the concatenated password
    if (user.password.length === 128) {
      const hashPart = user.password.substring(0, 64);
      const saltPart = user.password.substring(64);
      
      console.log('\nExtracting from concatenated password:');
      console.log('Hash part:', hashPart);
      console.log('Salt part:', saltPart);
      console.log('Separate salt field:', user.salt);
      console.log('Salt parts match:', saltPart === user.salt);
      
      // Update the user record to have just the hash in the password field
      // This way the verifyPassword function will work correctly
      const updateResult = await collection.updateOne(
        { email: 'test@tester.com' },
        { 
          $set: { 
            password: hashPart,  // Just the hash part
            salt: user.salt      // Keep the salt as is
          } 
        }
      );
      
      console.log('\nUpdate result:');
      console.log('Matched count:', updateResult.matchedCount);
      console.log('Modified count:', updateResult.modifiedCount);
      
      // Verify the update
      const updatedUser = await collection.findOne({ email: 'test@tester.com' });
      console.log('\nUpdated user data:');
      console.log('Password (hex):', updatedUser.password);
      console.log('Salt (hex):', updatedUser.salt);
      console.log('Password length:', updatedUser.password.length);
      
      // Now test the verification with the corrected data
      console.log('\n=== Testing verification with corrected data ===');
      
      // Manual Argon2 verification with corrected hash
      const saltBuffer = Buffer.from(updatedUser.salt, 'hex');
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
      console.log('Stored hash (hex):', updatedUser.password);
      console.log('Hashes match:', computedHashHex === updatedUser.password);
      
    } else {
      console.log('Password is not in concatenated format (length != 128)');
    }
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

fixPasswordVerification();