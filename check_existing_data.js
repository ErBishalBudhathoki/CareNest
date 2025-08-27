const { MongoClient } = require('mongodb');
require('dotenv').config();

async function checkExistingData() {
  let client;
  
  try {
    console.log('Checking existing data in MongoDB...');
    
    // Connect to MongoDB
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check all users
    console.log('\n=== All Users in Login Collection ===');
    const users = await db.collection('login').find({}).toArray();
    console.log(`Found ${users.length} users:`);
    users.forEach((user, index) => {
      console.log(`${index + 1}. Email: ${user.email}, Role: ${user.role || 'N/A'}, OrganizationId: ${user.organizationId || 'N/A'}`);
    });
    
    // Check all clients
    console.log('\n=== All Clients in Clients Collection ===');
    const clients = await db.collection('clients').find({}).toArray();
    console.log(`Found ${clients.length} clients:`);
    clients.forEach((client, index) => {
      console.log(`${index + 1}. Email: ${client.clientEmail}, Name: ${client.clientFirstName} ${client.clientLastName}, Active: ${client.isActive}, OrganizationId: ${client.organizationId || 'N/A'}`);
    });
    
    // Check all assignments
    console.log('\n=== All Assignments in ClientAssignments Collection ===');
    const assignments = await db.collection('clientAssignments').find({}).toArray();
    console.log(`Found ${assignments.length} assignments:`);
    assignments.forEach((assignment, index) => {
      console.log(`${index + 1}. User: ${assignment.userEmail}, Client: ${assignment.clientEmail}, Active: ${assignment.isActive}, Created: ${assignment.createdAt}`);
    });
    
    // Check organizations
    console.log('\n=== All Organizations ===');
    const organizations = await db.collection('organizations').find({}).toArray();
    console.log(`Found ${organizations.length} organizations:`);
    organizations.forEach((org, index) => {
      console.log(`${index + 1}. Name: ${org.name}, Code: ${org.code}, Owner: ${org.ownerEmail}`);
    });
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

checkExistingData();