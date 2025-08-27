const { MongoClient } = require('mongodb');

const uri = 'mongodb://localhost:27017';
const client = new MongoClient(uri);

async function checkCollections() {
  try {
    await client.connect();
    const db = client.db('Invoice');
    
    // List all collections
    const collections = await db.listCollections().toArray();
    console.log('Available collections:');
    collections.forEach(col => console.log('- ' + col.name));
    
    // Check document counts
    const usersCount = await db.collection('users').countDocuments();
    const loginCount = await db.collection('login').countDocuments();
    
    console.log(`\nUsers collection count: ${usersCount}`);
    console.log(`Login collection count: ${loginCount}`);
    
    // Check if test users exist in both collections
    const testUserInUsers = await db.collection('users').findOne({email: 'test@tester.com'});
    const testUserInLogin = await db.collection('login').findOne({email: 'test@tester.com'});
    
    console.log(`\ntest@tester.com in users collection: ${testUserInUsers ? 'YES' : 'NO'}`);
    console.log(`test@tester.com in login collection: ${testUserInLogin ? 'YES' : 'NO'}`);
    
    if (testUserInLogin) {
      console.log('\nTest user data in login collection:');
      console.log({
        email: testUserInLogin.email,
        firstName: testUserInLogin.firstName,
        lastName: testUserInLogin.lastName,
        hasPhotoData: !!testUserInLogin.photoData,
        hasProfileImage: !!testUserInLogin.profileImage,
        photoDataLength: testUserInLogin.photoData ? testUserInLogin.photoData.length : 0
      });
    }
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

checkCollections();