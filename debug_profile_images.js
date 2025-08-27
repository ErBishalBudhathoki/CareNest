require('dotenv').config({ path: __dirname + '/.env' });
const { MongoClient, ServerApiVersion } = require('mongodb');

async function debugProfileImages() {
  let client;
  
  try {
    console.log('Connecting to MongoDB...');
    console.log('MONGODB_URI:', process.env.MONGODB_URI);
    client = await MongoClient.connect(process.env.MONGODB_URI, {
      serverApi: ServerApiVersion.v1
    });
    console.log('Connected successfully');
    
    const db = client.db('Invoice');
    
    // Check test@test.com
    console.log('\n=== Checking test@test.com ===');
    const testUser = await db.collection('login').findOne({ email: 'test@test.com' });
    
    if (testUser) {
      console.log('User found:', testUser.email);
      console.log('profileImage exists:', testUser.profileImage ? 'YES' : 'NO');
      console.log('photoData exists:', testUser.photoData ? 'YES' : 'NO');
      
      if (testUser.profileImage) {
        console.log('profileImage type:', typeof testUser.profileImage);
        console.log('profileImage length:', testUser.profileImage.length);
        console.log('profileImage starts with data:image:', testUser.profileImage.indexOf('data:image') === 0);
        console.log('First 100 chars:', testUser.profileImage.substring(0, 100));
      }
    } else {
      console.log('test@test.com not found');
    }
    
    // Check test1@tester.com
    console.log('\n=== Checking test1@tester.com ===');
    const test1User = await db.collection('login').findOne({ email: 'test1@tester.com' });
    
    if (test1User) {
      console.log('User found:', test1User.email);
      console.log('profileImage exists:', test1User.profileImage ? 'YES' : 'NO');
      console.log('photoData exists:', test1User.photoData ? 'YES' : 'NO');
      
      if (test1User.profileImage) {
        console.log('profileImage type:', typeof test1User.profileImage);
        console.log('profileImage length:', test1User.profileImage.length);
        console.log('profileImage starts with data:image:', test1User.profileImage.indexOf('data:image') === 0);
        console.log('First 100 chars:', test1User.profileImage.substring(0, 100));
      }
    } else {
      console.log('test1@tester.com not found');
    }
    
  } catch (error) {
    console.error('Error occurred:', error);
  } finally {
    if (client) {
      await client.close();
      console.log('\nConnection closed');
    }
  }
}

debugProfileImages();