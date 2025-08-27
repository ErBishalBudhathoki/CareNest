const { MongoClient, ObjectId } = require('mongodb');
require('dotenv').config();

async function checkAndFixUser() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    const user = await db.collection('login').findOne({ email: 'test@tester.com' });
    console.log('User data for test@tester.com:');
    console.log(JSON.stringify(user, null, 2));
    
    // Check if there are any organizations
    const organizations = await db.collection('organizations').find({}).toArray();
    console.log('\nAvailable organizations:');
    console.log(JSON.stringify(organizations, null, 2));
    
    if (organizations.length > 0 && user && !user.organizationId) {
      // Assign the first organization to the test user
      const firstOrg = organizations[0];
      const updateResult = await db.collection('login').updateOne(
        { email: 'test@tester.com' },
        { 
          $set: { 
            organizationId: firstOrg._id.toString(),
            organizationName: firstOrg.name
          } 
        }
      );
      
      console.log('\nUpdated user with organizationId:', updateResult);
      
      // Verify the update
      const updatedUser = await db.collection('login').findOne({ email: 'test@tester.com' });
      console.log('\nUpdated user data:');
      console.log(JSON.stringify(updatedUser, null, 2));
    }
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

checkAndFixUser();