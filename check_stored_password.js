require('dotenv').config();
const { MongoClient } = require('mongodb');
const argon2 = require('argon2');

async function checkStoredPassword() {
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
      console.log('Password length:', user.password ? user.password.length : 'undefined');
      
      // Check if it's an Argon2 hash
      const isArgon2Hash = user.password && user.password.startsWith('$argon2');
      console.log('Is Argon2 hash:', isArgon2Hash);
      
      if (isArgon2Hash) {
        // Try to verify with Argon2
        try {
          const isValid = await argon2.verify(user.password, '111111');
          console.log('Argon2 verification with "111111":', isValid);
        } catch (error) {
          console.log('Argon2 verification error:', error.message);
        }
      } else {
        console.log('Password is not an Argon2 hash - it appears to be a different format');
      }
    } else {
      console.log('User not found');
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

checkStoredPassword();