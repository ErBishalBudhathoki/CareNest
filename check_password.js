const { MongoClient } = require('mongodb');
const bcrypt = require('bcrypt');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function checkPassword() {
  const client = new MongoClient(uri);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const loginCollection = db.collection('login');
    
    // Get the user
    const user = await loginCollection.findOne({ email: 'test@tester.com' });
    
    if (user) {
      console.log('User found:');
      console.log('- Email:', user.email);
      console.log('- Password hash:', user.password);
      console.log('- Salt:', user.salt);
      console.log('- isActive:', user.isActive);
      
      // Test password verification
      const testPassword = '111111';
      console.log('\nTesting password:', testPassword);
      
      try {
        const isValid = await bcrypt.compare(testPassword, user.password);
        console.log('bcrypt.compare result:', isValid);
      } catch (error) {
        console.log('bcrypt.compare error:', error.message);
      }
      
      // Also test if the password is stored as plain text
      console.log('Plain text comparison:', testPassword === user.password);
      
      // Test with salt if it exists
      if (user.salt) {
        console.log('\nTesting with salt...');
        const saltedPassword = testPassword + user.salt;
        console.log('Salted password:', saltedPassword);
        
        try {
          const isSaltedValid = await bcrypt.compare(saltedPassword, user.password);
          console.log('bcrypt.compare with salt result:', isSaltedValid);
        } catch (error) {
          console.log('bcrypt.compare with salt error:', error.message);
        }
      }
      
    } else {
      console.log('User not found');
    }
    
  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    await client.close();
  }
}

checkPassword();