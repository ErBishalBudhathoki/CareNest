const { MongoClient } = require('mongodb');
require('dotenv').config();

const client = new MongoClient(process.env.MONGODB_URI);

async function checkAssignments() {
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('invoice');
    
    // Check assignments for the organization
    const assignments = await db.collection('clientAssignments')
      .find({organizationId: 'org_2VmJQRFrGbPXc6x1'})
      .toArray();
    
    console.log(`\nTotal assignments for org_2VmJQRFrGbPXc6x1: ${assignments.length}`);
    
    assignments.forEach((assignment, index) => {
      console.log(`${index + 1}. User: ${assignment.userEmail}, Client: ${assignment.clientEmail}, Status: ${assignment.status}`);
      console.log(`   Created: ${assignment.createdAt}`);
      console.log(`   Assignment ID: ${assignment.assignmentId}`);
    });
    
    // Also check if there are any users with profile images
    const users = await db.collection('login')
      .find({organizationId: 'org_2VmJQRFrGbPXc6x1'})
      .toArray();
    
    console.log(`\nTotal users for org_2VmJQRFrGbPXc6x1: ${users.length}`);
    
    users.forEach((user, index) => {
      console.log(`${index + 1}. Email: ${user.email}, Name: ${user.userName}`);
      console.log(`   Has profileImage: ${user.profileImage ? 'YES' : 'NO'}`);
      if (user.profileImage) {
        console.log(`   ProfileImage length: ${user.profileImage.length}`);
        console.log(`   ProfileImage starts with: ${user.profileImage.substring(0, 50)}...`);
      }
    });
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

checkAssignments();