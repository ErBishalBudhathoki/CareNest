const { MongoClient } = require('mongodb');
require('dotenv').config();

async function checkMatchingAssignments() {
  let client;
  
  try {
    console.log('Checking for assignments between actual users and clients...');
    
    // Connect to MongoDB
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check for assignments with test1@tester.com and abc@abc.com
    console.log('\n=== Checking test1@tester.com -> abc@abc.com ===');
    const assignment1 = await db.collection('clientAssignments').find({
      userEmail: 'test1@tester.com',
      clientEmail: 'abc@abc.com'
    }).toArray();
    
    console.log(`Found ${assignment1.length} assignments:`);
    assignment1.forEach((assignment, index) => {
      console.log(`${index + 1}. Assignment:`, JSON.stringify(assignment, null, 2));
    });
    
    // Check for assignments with any test user and abc client
    console.log('\n=== Checking any test user -> abc@abc.com ===');
    const assignment2 = await db.collection('clientAssignments').find({
      userEmail: { $regex: /test/i },
      clientEmail: 'abc@abc.com'
    }).toArray();
    
    console.log(`Found ${assignment2.length} assignments:`);
    assignment2.forEach((assignment, index) => {
      console.log(`${index + 1}. User: ${assignment.userEmail}, Client: ${assignment.clientEmail}`);
      console.log(`   Schedule: ${JSON.stringify(assignment.schedule || assignment.dateList)}`);
      console.log(`   Created: ${assignment.createdAt}`);
    });
    
    // Check what the UI might be looking for - assignments with specific schedule
    console.log('\n=== Checking for 2025-06-19 assignments ===');
    const assignment3 = await db.collection('clientAssignments').find({
      $or: [
        { 'schedule.date': '2025-06-19' },
        { 'dateList': { $in: ['2025-06-19'] } }
      ]
    }).toArray();
    
    console.log(`Found ${assignment3.length} assignments for 2025-06-19:`);
    assignment3.forEach((assignment, index) => {
      console.log(`${index + 1}. User: ${assignment.userEmail}, Client: ${assignment.clientEmail}`);
      console.log(`   Full assignment:`, JSON.stringify(assignment, null, 2));
    });
    
    // Check the user and client details
    console.log('\n=== User Details ===');
    const user = await db.collection('login').findOne({ email: 'test1@tester.com' });
    if (user) {
      console.log('User test1@tester.com details:');
      console.log(`  Name: ${user.firstName} ${user.lastName}`);
      console.log(`  Organization ID: ${user.organizationId}`);
      console.log(`  Active: ${user.isActive}`);
    }
    
    console.log('\n=== Client Details ===');
    const clientRecord = await db.collection('clients').findOne({ clientEmail: 'abc@abc.com' });
    if (clientRecord) {
      console.log('Client abc@abc.com details:');
      console.log(`  Name: ${clientRecord.clientFirstName} ${clientRecord.clientLastName}`);
      console.log(`  Organization ID: ${clientRecord.organizationId}`);
      console.log(`  Active: ${clientRecord.isActive}`);
    }
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

checkMatchingAssignments();