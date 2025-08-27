const { MongoClient } = require('mongodb');
require('dotenv').config();

async function fixAdminUser() {
  let client;
  try {
    client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db('Invoice');
    
    // Check and update admin user
    const adminUser = await db.collection('login').findOne({ email: 'test@tester.com' });
    console.log('Current admin user data:', adminUser);
    
    if (!adminUser) {
      console.log('Admin user not found, creating...');
      const result = await db.collection('login').insertOne({
        email: 'test@tester.com',
        role: 'admin',
        organizationId: '6846b040808f01d85897bbd8',
        firstName: 'Test',
        lastName: 'Admin'
      });
      console.log('Created admin user:', result);
    } else if (adminUser.role !== 'admin' || adminUser.organizationId !== '6846b040808f01d85897bbd8') {
      console.log('Updating admin user role and organization...');
      const updateResult = await db.collection('login').updateOne(
        { email: 'test@tester.com' },
        { 
          $set: { 
            role: 'admin',
            organizationId: '6846b040808f01d85897bbd8'
          }
        }
      );
      console.log('Updated admin user:', updateResult);
    }
    
    // Check and update FCM token
    const tokenDoc = await db.collection('fcmTokens').findOne({ userEmail: 'test@tester.com' });
    console.log('Current FCM token data:', tokenDoc);
    
    if (!tokenDoc) {
      console.log('FCM token not found for admin user');
    } else if (!tokenDoc.fcmToken) {
      console.log('FCM token is empty for admin user');
    }
    
    // Verify final state
    const finalAdminUser = await db.collection('login').findOne({ email: 'test@tester.com' });
    const finalTokenDoc = await db.collection('fcmTokens').findOne({ userEmail: 'test@tester.com' });
    
    console.log('\nFinal admin user state:', finalAdminUser);
    console.log('Final FCM token state:', finalTokenDoc);
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (client) await client.close();
  }
}

fixAdminUser();