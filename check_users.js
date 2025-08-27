const { MongoClient, ServerApiVersion } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function checkUsers() {
  let client;
  
  try {
    console.log('Connecting to MongoDB...');
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    console.log('Connected successfully');
    
    const db = client.db('Invoice');
    
    // Check test@tester.com
    console.log('\n=== Checking test@tester.com ===');
    const testUser = await db.collection('login').findOne({ email: 'test@tester.com' });
    if (testUser) {
      console.log('User found:');
      console.log('- Name:', testUser.firstName, testUser.lastName);
      console.log('- Has photoData:', !!testUser.photoData);
      console.log('- Has profileImage:', !!testUser.profileImage);
      if (testUser.photoData) {
        console.log('- PhotoData length:', testUser.photoData.length);
        console.log('- PhotoData preview:', testUser.photoData.substring(0, 50) + '...');
      }
    } else {
      console.log('User not found');
    }
    
    // Check test1@tester.com
    console.log('\n=== Checking test1@tester.com ===');
    const test1User = await db.collection('login').findOne({ email: 'test1@tester.com' });
    if (test1User) {
      console.log('User found:');
      console.log('- Name:', test1User.firstName, test1User.lastName);
      console.log('- Has photoData:', !!test1User.photoData);
      console.log('- Has profileImage:', !!test1User.profileImage);
      if (test1User.photoData) {
        console.log('- PhotoData length:', test1User.photoData.length);
        console.log('- PhotoData preview:', test1User.photoData.substring(0, 50) + '...');
      }
    } else {
      console.log('User not found');
    }
    
    // List all users in login collection
    console.log('\n=== All users in login collection ===');
    const allUsers = await db.collection('login').find({}).toArray();
    console.log('Total users:', allUsers.length);
    allUsers.forEach((user, index) => {
      console.log(`${index + 1}. ${user.email} - ${user.firstName} ${user.lastName} - photoData: ${!!user.photoData}`);
    });
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

checkUsers();