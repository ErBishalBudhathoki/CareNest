const { MongoClient, ServerApiVersion } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });

console.log('Environment variables loaded from:', path.join(__dirname, '.env'));
console.log('MongoDB URI available:', !!process.env.MONGODB_URI);

const uri = process.env.MONGODB_URI;

async function createTestAdmin() {
  let client;

  try {
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });

    const db = client.db('Invoice');
    
    // Create admin user
    const adminData = {
      email: 'admin@test.com',
      role: 'admin',
      organizationId: '6846b040808f01d85897bbd8', // Using the same org ID as test user
      createdAt: new Date(),
      updatedAt: new Date()
    };

    // Check if admin already exists
    const existingAdmin = await db.collection('users').findOne({
      email: adminData.email
    });

    if (existingAdmin) {
      console.log('Admin user already exists:', existingAdmin);
    } else {
      const result = await db.collection('users').insertOne(adminData);
      console.log('Admin user created:', result.insertedId);
    }

    // Create FCM token for admin
    const fcmTokenData = {
      userEmail: adminData.email,
      organizationId: adminData.organizationId,
      fcmToken: 'test_admin_fcm_token', // Replace with actual FCM token from admin app
      createdAt: new Date(),
      updatedAt: new Date(),
      lastValidated: new Date()
    };

    const existingToken = await db.collection('fcmTokens').findOne({
      userEmail: adminData.email
    });

    if (existingToken) {
      console.log('Admin FCM token already exists:', existingToken);
    } else {
      const tokenResult = await db.collection('fcmTokens').insertOne(fcmTokenData);
      console.log('Admin FCM token created:', tokenResult.insertedId);
    }

  } catch (error) {
    console.error('Error creating test admin:', error);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

createTestAdmin().then(() => console.log('Done'));