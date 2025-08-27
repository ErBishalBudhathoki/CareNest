const { MongoClient } = require('mongodb');
require('dotenv').config();

async function checkActualAssignments() {
  let client;
  
  try {
    console.log('Checking actual assignment data in MongoDB...');
    
    // Connect to MongoDB
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check all assignments
    console.log('\n=== All Assignments ===');
    const allAssignments = await db.collection('clientAssignments').find({}).toArray();
    console.log(`Found ${allAssignments.length} total assignments:`);
    allAssignments.forEach((assignment, index) => {
      console.log(`${index + 1}. User: ${assignment.userEmail}, Client: ${assignment.clientEmail}`);
      console.log(`   Active: ${assignment.isActive}, Created: ${assignment.createdAt}`);
      console.log(`   Schedule: ${JSON.stringify(assignment.schedule || assignment.dateList)}`);
      console.log('---');
    });
    
    // Check for assignments that might match the UI data
    console.log('\n=== Looking for Recent Assignments ===');
    const recentAssignments = await db.collection('clientAssignments').find({
      createdAt: { $gte: new Date(Date.now() - 24 * 60 * 60 * 1000) } // Last 24 hours
    }).toArray();
    
    console.log(`Found ${recentAssignments.length} assignments in the last 24 hours:`);
    recentAssignments.forEach((assignment, index) => {
      console.log(`${index + 1}. User: ${assignment.userEmail}, Client: ${assignment.clientEmail}`);
      console.log(`   Schedule: ${JSON.stringify(assignment.schedule || assignment.dateList)}`);
      console.log(`   Full assignment:`, JSON.stringify(assignment, null, 2));
      console.log('---');
    });
    
    // Check for users that might be 'Test1'
    console.log('\n=== Looking for Test1 User ===');
    const test1Users = await db.collection('login').find({
      $or: [
        { email: /test1/i },
        { firstName: /test1/i },
        { lastName: /test1/i },
        { email: /test/i }
      ]
    }).toArray();
    
    console.log(`Found ${test1Users.length} users matching 'test1' pattern:`);
    test1Users.forEach((user, index) => {
      console.log(`${index + 1}. Email: ${user.email}, Name: ${user.firstName} ${user.lastName}`);
    });
    
    // Check for clients that might be 'Abc'
    console.log('\n=== Looking for Abc Client ===');
    const abcClients = await db.collection('clients').find({
      $or: [
        { clientEmail: /abc/i },
        { clientFirstName: /abc/i },
        { clientLastName: /abc/i }
      ]
    }).toArray();
    
    console.log(`Found ${abcClients.length} clients matching 'abc' pattern:`);
    abcClients.forEach((client, index) => {
      console.log(`${index + 1}. Email: ${client.clientEmail}, Name: ${client.clientFirstName} ${client.clientLastName}`);
    });
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

checkActualAssignments();