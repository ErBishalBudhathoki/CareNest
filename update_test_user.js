const { MongoClient } = require('mongodb');
require('dotenv').config();

async function updateTestUser() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const collection = db.collection('login');
    
    const hashedPassword = 'REDACTEDREDACTED';
    const salt = 'REDACTED';
    
    const result = await collection.updateOne(
      { email: 'test@tester.com' },
      { 
        $set: { 
          password: hashedPassword,
          salt: salt
        }
      }
    );
    
    console.log('Update result:', result);
    
    if (result.matchedCount === 0) {
      console.log('No user found with email test@tester.com');
      // Let's check what users exist
      const users = await collection.find({}).toArray();
      console.log('Existing users:', users.map(u => ({ email: u.email, _id: u._id })));
    } else if (result.modifiedCount === 1) {
      console.log('Successfully updated test user credentials');
    } else {
      console.log('User found but not modified (maybe same values)');
    }
    
  } catch (error) {
    console.error('Error updating test user:', error);
  } finally {
    await client.close();
    console.log('Database connection closed');
  }
}

updateTestUser();