require('dotenv').config({ path: './.env' });
const { MongoClient } = require('mongodb');

async function checkUserCreationMethod() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    const db = client.db('Invoice');
    const user = await db.collection('login').findOne({ email: 'test@tester.com' });
    
    if (user) {
      console.log('User found:');
      console.log('Email:', user.email);
      console.log('Password field:', user.password);
      console.log('Password length:', user.password ? user.password.length : 'undefined');
      console.log('Salt field:', user.salt);
      console.log('Salt length:', user.salt ? user.salt.length : 'undefined');
      console.log('Created at:', user.createdAt);
      console.log('Role:', user.role);
      
      // Check if password and salt are stored separately or concatenated
      if (user.salt && user.password) {
        console.log('\nPassword and salt are stored as separate fields');
        console.log('This suggests the user was created via the signup endpoint');
        console.log('Frontend likely used Argon2 hashing');
      } else if (user.password && user.password.length === 128) {
        console.log('\nPassword appears to be concatenated hash+salt (128 chars)');
        console.log('This suggests manual creation or different hashing method');
      }
      
    } else {
      console.log('User not found');
    }
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

checkUserCreationMethod();