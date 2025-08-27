require('dotenv').config({ path: __dirname + '/.env' });
const { MongoClient } = require('mongodb');

async function checkProfileImages() {
  try {
    console.log('MONGODB_URI:', process.env.MONGODB_URI);
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    console.log('Checking profile images for test and test1 users...');
    
    // Check test@tester.com
    const testUser = await db.collection('login').findOne({ email: 'test@tester.com' });
    console.log('\n=== TEST USER (test@tester.com) ===');
    if (testUser) {
      console.log('User found:', {
        email: testUser.email,
        hasProfileImage: !!testUser.profileImage,
        hasPhotoData: !!testUser.photoData,
        profileImageLength: testUser.profileImage ? testUser.profileImage.length : 0,
        photoDataLength: testUser.photoData ? testUser.photoData.length : 0,
        filename: testUser.filename || 'N/A',
        organizationId: testUser.organizationId || 'N/A'
      });
      
      // Show first 100 characters of profileImage if it exists
      if (testUser.profileImage) {
        console.log('ProfileImage preview:', testUser.profileImage.substring(0, 100) + '...');
      }
    } else {
      console.log('User not found');
    }
    
    // Check test1@tester.com
    const test1User = await db.collection('login').findOne({ email: 'test1@tester.com' });
    console.log('\n=== TEST1 USER (test1@tester.com) ===');
    if (test1User) {
      console.log('User found:', {
        email: test1User.email,
        hasProfileImage: !!test1User.profileImage,
        hasPhotoData: !!test1User.photoData,
        profileImageLength: test1User.profileImage ? test1User.profileImage.length : 0,
        photoDataLength: test1User.photoData ? test1User.photoData.length : 0,
        filename: test1User.filename || 'N/A',
        organizationId: test1User.organizationId || 'N/A'
      });
      
      // Show first 100 characters of profileImage if it exists
      if (test1User.profileImage) {
        console.log('ProfileImage preview:', test1User.profileImage.substring(0, 100) + '...');
      }
    } else {
      console.log('User not found');
    }
    
    await client.close();
    console.log('\nConnection closed');
  } catch (error) {
    console.error('Error occurred:', error);
  }
}

checkProfileImages();