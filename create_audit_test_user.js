/**
 * Script to create a test user for audit trail testing
 * This creates the necessary user-organization relationship for testing audit endpoints
 */

const { MongoClient, ServerApiVersion } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const uri = process.env.MONGODB_URI;

async function createTestUser() {
  let client;
  
  try {
    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');
    
    const testUser = {
      email: 'test@example.com',
      organizationId: 'test-org-123',
      name: 'Test User',
      role: 'admin',
      isActive: true,
      createdAt: new Date(),
      updatedAt: new Date()
    };
    
    // Check if user already exists
    const existingUser = await db.collection('login').findOne({
      email: testUser.email,
      organizationId: testUser.organizationId
    });
    
    if (existingUser) {
      console.log('✅ Test user already exists:', testUser.email);
      return;
    }
    
    // Create the test user
    const result = await db.collection('login').insertOne(testUser);
    
    console.log('✅ Test user created successfully:');
    console.log('   Email:', testUser.email);
    console.log('   Organization ID:', testUser.organizationId);
    console.log('   User ID:', result.insertedId);
    
  } catch (error) {
    console.error('❌ Error creating test user:', error);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

// Run the script
if (require.main === module) {
  createTestUser();
}

module.exports = { createTestUser };