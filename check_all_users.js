require('dotenv').config();
const { MongoClient } = require('mongodb');
const crypto = require('crypto');

async function checkAllUsers() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const users = await db.collection('login').find({}).toArray();
    
    console.log(`Found ${users.length} users in the login collection:`);
    
    users.forEach((user, index) => {
      console.log(`\n=== User ${index + 1} ===`);
      console.log('Email:', user.email);
      console.log('Password length:', user.password ? user.password.length : 'undefined');
      console.log('Salt length:', user.salt ? user.salt.length : 'undefined');
      console.log('Password:', user.password);
      console.log('Salt:', user.salt);
      
      // Check if this might be a simple password
      if (user.password && user.password.length < 20) {
        console.log('⚠️  This looks like a plain text password!');
      }
      
      // Check if password and salt are the same
      if (user.password === user.salt) {
        console.log('⚠️  Password and salt are identical!');
      }
    });
    
    // Also check if there are users in other collections
    console.log('\n=== Checking other collections ===');
    const collections = await db.listCollections().toArray();
    console.log('Available collections:', collections.map(c => c.name));
    
    // Check if there's a users collection
    if (collections.some(c => c.name === 'users')) {
      const usersInUsersCollection = await db.collection('users').find({}).toArray();
      console.log(`\nFound ${usersInUsersCollection.length} users in the 'users' collection:`);
      usersInUsersCollection.forEach((user, index) => {
        console.log(`User ${index + 1}:`, {
          email: user.email,
          hasPassword: !!user.password,
          hasSalt: !!user.salt
        });
      });
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

checkAllUsers();