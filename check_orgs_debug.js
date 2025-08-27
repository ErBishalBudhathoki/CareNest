const { MongoClient } = require('mongodb');
require('dotenv').config();

const client = new MongoClient(process.env.MONGODB_URI);

async function checkOrgs() {
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('invoice');
    
    // Check available organization IDs in login collection
    const loginOrgs = await db.collection('login').distinct('organizationId');
    console.log('\nAvailable organization IDs in login collection:', loginOrgs);
    
    // Check organization IDs with assignments
    const assignmentOrgs = await db.collection('clientAssignments').distinct('organizationId');
    console.log('\nOrganization IDs with assignments:', assignmentOrgs);
    
    // Check some sample users
    const sampleUsers = await db.collection('login').find({}).limit(5).toArray();
    console.log('\nSample users:');
    sampleUsers.forEach((user, index) => {
      console.log(`${index + 1}. Email: ${user.email}, OrgID: ${user.organizationId}, Name: ${user.userName}`);
      console.log(`   Has profileImage: ${user.profileImage ? 'YES' : 'NO'}`);
    });
    
    // Check some sample assignments
    const sampleAssignments = await db.collection('clientAssignments').find({}).limit(5).toArray();
    console.log('\nSample assignments:');
    sampleAssignments.forEach((assignment, index) => {
      console.log(`${index + 1}. User: ${assignment.userEmail}, Client: ${assignment.clientEmail}, OrgID: ${assignment.organizationId}`);
    });
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

checkOrgs();