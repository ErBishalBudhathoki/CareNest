const { MongoClient } = require('mongodb');
require('dotenv').config();

const client = new MongoClient(process.env.MONGODB_URI);

async function createTestData() {
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    console.log('Creating test data...');
    
    // Create test users with profile images
    const testUser1 = {
      email: 'bishal@test.com',
      userName: 'bishal bud',
      organizationId: 'org_2VmJQRFrGbPXc6x1',
      profileImage: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==',
      role: 'employee',
      createdAt: new Date()
    };
    
    const testUser2 = {
      email: 'test@test.com',
      userName: 'test test',
      organizationId: 'org_2VmJQRFrGbPXc6x1',
      profileImage: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==',
      role: 'employee',
      createdAt: new Date()
    };
    
    await db.collection('login').insertMany([testUser1, testUser2]);
    console.log('Test users created');
    
    // Create test assignment
    const testAssignment = {
      userEmail: 'bishal@test.com',
      clientEmail: 'client@test.com',
      organizationId: 'org_2VmJQRFrGbPXc6x1',
      status: 'active',
      assignmentId: 'assign_123',
      createdAt: new Date()
    };
    
    await db.collection('clientAssignments').insertOne(testAssignment);
    console.log('Test assignment created');
    
    // Verify the data was created
    const userCount = await db.collection('login').countDocuments({organizationId: 'org_2VmJQRFrGbPXc6x1'});
    const assignmentCount = await db.collection('clientAssignments').countDocuments({organizationId: 'org_2VmJQRFrGbPXc6x1'});
    
    console.log(`Created ${userCount} users and ${assignmentCount} assignments`);
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
    console.log('Test data creation complete');
  }
}

createTestData();