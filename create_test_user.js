const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function createTestUser() {
  const client = await MongoClient.connect(uri);
  const db = client.db('Invoice');
  
  await db.collection('login').insertOne({
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@test.com',
    organizationId: 'org123',
    profileImage: 'https://example.com/profile.jpg',
    isActive: true,
    createdAt: new Date()
  });
  
  console.log('Test user created successfully');
  await client.close();
}

createTestUser().catch(console.error);