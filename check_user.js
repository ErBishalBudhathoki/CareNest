const { MongoClient } = require('mongodb');
require('dotenv').config();

async function checkAllAdmins() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    const db = client.db('Invoice');
    // List all admin users
    const admins = await db.collection('login').find({ role: 'admin' }).toArray();
    if (admins.length === 0) {
      console.log('No admin users found in login collection.');
    } else {
      admins.forEach(admin => {
        console.log('Admin:', {
          email: admin.email,
          organizationId: admin.organizationId,
          organizationName: admin.organizationName
        });
      });
    }
    // List all FCM tokens for admin users
    const adminEmails = admins.map(a => a.email);
    if (adminEmails.length > 0) {
      const tokens = await db.collection('fcmTokens').find({ userEmail: { $in: adminEmails } }).toArray();
      tokens.forEach(token => {
        console.log('FCM Token:', {
          userEmail: token.userEmail,
          organizationId: token.organizationId,
          fcmToken: token.fcmToken
        });
      });
    }
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

checkAllAdmins();