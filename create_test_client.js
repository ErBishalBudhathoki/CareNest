const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';

async function createTestClient() {
  const client = new MongoClient(uri);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check if client already exists
    const existingClient = await db.collection('login').findOne({ email: 'abc@abc.com' });
    
    if (existingClient) {
      console.log('Test client abc@abc.com already exists');
      console.log('Existing client:', JSON.stringify(existingClient, null, 2));
      return;
    }
    
    // Create test client record
    const testClient = {
      email: 'abc@abc.com',
      firstName: 'Test',
      lastName: 'Client',
      businessName: 'Test Business ABC',
      abn: '12345678901',
      role: 'client',
      organizationId: 'test_org_001',
      isActive: true,
      createdAt: new Date(),
      updatedAt: new Date()
    };
    
    // Insert the test client
    const result = await db.collection('login').insertOne(testClient);
    console.log('Test client created successfully:');
    console.log('Inserted ID:', result.insertedId);
    console.log('Client data:', JSON.stringify(testClient, null, 2));
    
    // Also create a client assignment record if needed
    const assignmentExists = await db.collection('clientAssignments').findOne({
      clientEmail: 'abc@abc.com'
    });
    
    if (!assignmentExists) {
      const testAssignment = {
        userEmail: 'test@employee.com', // You may need to adjust this
        clientEmail: 'abc@abc.com',
        clientId: result.insertedId.toString(),
        organizationId: 'test_org_001',
        isActive: true,
        schedule: [
          {
            date: '2025-01-06',
            startTime: '09:00',
            endTime: '17:00',
            break: 'yes'
          }
        ],
        createdAt: new Date()
      };
      
      const assignmentResult = await db.collection('clientAssignments').insertOne(testAssignment);
      console.log('Test client assignment created:', assignmentResult.insertedId);
    }
    
  } catch (error) {
    console.error('Error creating test client:', error);
  } finally {
    await client.close();
    console.log('Database connection closed');
  }
}

// Run the script
if (require.main === module) {
  createTestClient();
}

module.exports = { createTestClient };