const { MongoClient } = require('mongodb');
require('dotenv').config();

const client = new MongoClient(process.env.MONGODB_URI);

async function fixTestData() {
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    console.log('Fixing test data structure...');
    
    // First, let's check what data exists in login collection
    const loginUsers = await db.collection('login').find({
      organizationId: 'org_2VmJQRFrGbPXc6x1'
    }).toArray();
    
    console.log(`Found ${loginUsers.length} users in login collection`);
    
    // Create corresponding users in the 'users' collection that the API expects
    for (const loginUser of loginUsers) {
      const userDoc = {
        email: loginUser.email,
        name: loginUser.userName,
        firstName: loginUser.userName.split(' ')[0],
        lastName: loginUser.userName.split(' ')[1] || '',
        organizationId: loginUser.organizationId,
        profileImage: loginUser.profileImage,
        role: loginUser.role,
        isActive: true,
        createdAt: loginUser.createdAt || new Date()
      };
      
      // Check if user already exists in users collection
      const existingUser = await db.collection('users').findOne({
        email: loginUser.email
      });
      
      if (!existingUser) {
        await db.collection('users').insertOne(userDoc);
        console.log(`Created user in 'users' collection: ${loginUser.email}`);
      } else {
        console.log(`User already exists in 'users' collection: ${loginUser.email}`);
      }
    }
    
    // Update the clientAssignments to have the correct structure
    const assignments = await db.collection('clientAssignments').find({
      organizationId: 'org_2VmJQRFrGbPXc6x1'
    }).toArray();
    
    console.log(`Found ${assignments.length} assignments`);
    
    // Update assignments to have isActive field
    for (const assignment of assignments) {
      await db.collection('clientAssignments').updateOne(
        { _id: assignment._id },
        { 
          $set: { 
            isActive: true,
            userName: assignment.userName || 'Test User'
          } 
        }
      );
    }
    
    // Create a test client if it doesn't exist
    const existingClient = await db.collection('clients').findOne({
      clientEmail: 'client@test.com'
    });
    
    if (!existingClient) {
      const testClient = {
        clientEmail: 'client@test.com',
        clientName: 'Test Client',
        clientAddress: '123 Test Street, Test City',
        organizationId: 'org_2VmJQRFrGbPXc6x1',
        isActive: true,
        createdAt: new Date()
      };
      
      await db.collection('clients').insertOne(testClient);
      console.log('Created test client');
    }
    
    // Verify the fix
    console.log('\n=== Verification ===');
    const userCount = await db.collection('users').countDocuments({
      organizationId: 'org_2VmJQRFrGbPXc6x1'
    });
    const assignmentCount = await db.collection('clientAssignments').countDocuments({
      organizationId: 'org_2VmJQRFrGbPXc6x1',
      isActive: true
    });
    const clientCount = await db.collection('clients').countDocuments({
      organizationId: 'org_2VmJQRFrGbPXc6x1'
    });
    
    console.log(`Users in 'users' collection: ${userCount}`);
    console.log(`Active assignments: ${assignmentCount}`);
    console.log(`Clients: ${clientCount}`);
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
    console.log('\nTest data fix complete');
  }
}

fixTestData();