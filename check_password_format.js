require('dotenv').config({ path: './.env' });
const { MongoClient } = require('mongodb');

async function checkPasswordFormat() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    const db = client.db('Invoice');
    const user = await db.collection('login').findOne({ email: 'test@tester.com' });
    
    if (user) {
      console.log('Password format:', user.password);
      console.log('Password length:', user.password.length);
      console.log('First 64 chars (hash):', user.password.substring(0, 64));
      console.log('Last 64 chars (salt):', user.password.substring(64));
      
      // Check if it's in hash:salt format
      if (user.password.includes(':')) {
        console.log('Password is in hash:salt format');
        const [hash, salt] = user.password.split(':');
        console.log('Hash part:', hash);
        console.log('Salt part:', salt);
      } else {
        console.log('Password is in hash+salt concatenated format');
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

checkPasswordFormat();