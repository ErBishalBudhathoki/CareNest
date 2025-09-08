const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function checkUserInDatabases() {
  const client = new MongoClient(uri);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    // Check in Invoice database, login collection
    const invoiceDb = client.db('Invoice');
    const loginCollection = invoiceDb.collection('login');
    const userInLogin = await loginCollection.findOne({ email: 'test@tester.com' });
    
    console.log('User in Invoice.login collection:', userInLogin ? 'FOUND' : 'NOT FOUND');
    if (userInLogin) {
      console.log('User data:', JSON.stringify(userInLogin, null, 2));
    }
    
    // Check in invoiceApp database, users collection
    const invoiceAppDb = client.db('invoiceApp');
    const usersCollection = invoiceAppDb.collection('users');
    const userInUsers = await usersCollection.findOne({ email: 'test@tester.com' });
    
    console.log('User in invoiceApp.users collection:', userInUsers ? 'FOUND' : 'NOT FOUND');
    if (userInUsers) {
      console.log('User data:', JSON.stringify(userInUsers, null, 2));
    }
    
  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    await client.close();
  }
}

checkUserInDatabases();