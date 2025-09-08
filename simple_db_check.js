require('dotenv').config();
const { MongoClient, ServerApiVersion } = require('mongodb');

const uri = process.env.MONGODB_URI;

async function checkDB() {
  let client;
  
  try {
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check test@test.com
    const testUser = await db.collection('login').findOne({ email: 'test@test.com' });
    console.log('\n=== test@test.com ===');
    if (testUser) {
      console.log('Found user:', testUser.email);
      console.log('Has profileImage:', !!testUser.profileImage);
      console.log('Has photoData:', !!testUser.photoData);
      if (testUser.profileImage && typeof testUser.profileImage === 'string') {
        console.log('ProfileImage length:', testUser.profileImage.length);
        console.log('ProfileImage preview:', testUser.profileImage.substring(0, 100));
      }
    } else {
      console.log('User not found');
    }
    
    // Check test1@tester.com
    const test1User = await db.collection('login').findOne({ email: 'test1@tester.com' });
    console.log('\n=== test1@tester.com ===');
    if (test1User) {
      console.log('Found user:', test1User.email);
      console.log('Has profileImage:', !!test1User.profileImage);
      console.log('Has photoData:', !!test1User.photoData);
      if (test1User.profileImage && typeof test1User.profileImage === 'string') {
        console.log('ProfileImage length:', test1User.profileImage.length);
        console.log('ProfileImage preview:', test1User.profileImage.substring(0, 100));
      }
    } else {
      console.log('User not found');
    }
    
  } catch (error) {
    console.error('Error:', error.message);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

checkDB();