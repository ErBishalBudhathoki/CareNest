const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function resetLoginAttempts() {
  const client = new MongoClient(uri);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const loginCollection = db.collection('login');
    
    // Reset login attempts and unlock account for test user
    const result = await loginCollection.updateOne(
      { email: 'test@tester.com' },
      { 
        $unset: { 
          loginAttempts: "",
          lockedUntil: "",
          lastFailedLogin: ""
        }
      }
    );
    
    console.log('Reset result:', result);
    
    // Verify the user status
    const user = await loginCollection.findOne({ email: 'test@tester.com' });
    console.log('User after reset:');
    console.log('- loginAttempts:', user.loginAttempts);
    console.log('- lockedUntil:', user.lockedUntil);
    console.log('- lastFailedLogin:', user.lastFailedLogin);
    
  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    await client.close();
  }
}

resetLoginAttempts();