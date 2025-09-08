const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function debugUserFields() {
  const client = new MongoClient(uri);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    // Check in Invoice database, login collection
    const invoiceDb = client.db('Invoice');
    const loginCollection = invoiceDb.collection('login');
    
    // Get the user and show all field names
    const user = await loginCollection.findOne({ email: 'test@tester.com' });
    
    if (user) {
      console.log('User found with email field');
      console.log('All field names:', Object.keys(user));
      console.log('Email field value:', user.email);
    } else {
      console.log('User NOT found with email field, trying other email fields...');
      
      // Try different email field names
      const userByEmailAddress = await loginCollection.findOne({ emailAddress: 'test@tester.com' });
      if (userByEmailAddress) {
        console.log('User found with emailAddress field');
        console.log('All field names:', Object.keys(userByEmailAddress));
        return;
      }
      
      const userByUserEmail = await loginCollection.findOne({ userEmail: 'test@tester.com' });
      if (userByUserEmail) {
        console.log('User found with userEmail field');
        console.log('All field names:', Object.keys(userByUserEmail));
        return;
      }
      
      // Get any user to see the structure
      const anyUser = await loginCollection.findOne({});
      if (anyUser) {
        console.log('Sample user structure:');
        console.log('All field names:', Object.keys(anyUser));
        console.log('Sample user data (first 500 chars):', JSON.stringify(anyUser, null, 2).substring(0, 500));
      }
    }
    
  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    await client.close();
  }
}

debugUserFields();