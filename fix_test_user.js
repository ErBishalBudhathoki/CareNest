const { MongoClient, ObjectId } = require('mongodb');
require('dotenv').config();

async function fixTestUser() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    // Find the organization owned by test@tester.com
    const userOrg = await db.collection('organizations').findOne({ ownerEmail: 'test@tester.com' });
    
    if (userOrg) {
      console.log('Found organization for test@tester.com:', userOrg.name, userOrg._id.toString());
      
      // Update the user with their organization
      const updateResult = await db.collection('login').updateOne(
        { email: 'test@tester.com' },
        { 
          $set: { 
            organizationId: userOrg._id.toString(),
            organizationName: userOrg.name
          } 
        }
      );
      
      console.log('Update result:', updateResult.modifiedCount, 'documents modified');
      
      // Verify the update
      const updatedUser = await db.collection('login').findOne({ email: 'test@tester.com' });
      console.log('Updated user organizationId:', updatedUser.organizationId);
      console.log('Updated user organizationName:', updatedUser.organizationName);
    } else {
      console.log('No organization found for test@tester.com');
    }
    
    await client.close();
    console.log('Database connection closed');
  } catch (error) {
    console.error('Error:', error);
  }
}

fixTestUser();