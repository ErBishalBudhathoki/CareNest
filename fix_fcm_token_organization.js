const { MongoClient, ServerApiVersion } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

/**
 * Script to fix FCM tokens that are missing organizationId
 * This ensures proper notification filtering by organization
 */
async function fixFcmTokenOrganization() {
  let client;
  
  try {
    console.log('Connecting to MongoDB...');
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    console.log('Connected successfully');
    
    const db = client.db('Invoice');
    
    // Get all users with their organizationId
    console.log('\n=== Fetching all users with organizationId ===');
    const users = await db.collection('login').find({}, {
      projection: { email: 1, organizationId: 1, role: 1 }
    }).toArray();
    
    console.log(`Found ${users.length} users`);
    
    // Check FCM tokens without organizationId
    console.log('\n=== Checking FCM tokens without organizationId ===');
    const tokensWithoutOrgId = await db.collection('fcmTokens').find({
      $or: [
        { organizationId: { $exists: false } },
        { organizationId: null },
        { organizationId: '' }
      ]
    }).toArray();
    
    console.log(`Found ${tokensWithoutOrgId.length} FCM tokens without organizationId`);
    
    if (tokensWithoutOrgId.length > 0) {
      console.log('Tokens without organizationId:');
      tokensWithoutOrgId.forEach(token => {
        console.log(`- User: ${token.userEmail}, Token: ${token.fcmToken ? token.fcmToken.substring(0, 20) + '...' : 'NULL'}`);
      });
    }
    
    // Fix FCM tokens by adding organizationId from user data
    console.log('\n=== Fixing FCM tokens ===');
    let fixedCount = 0;
    
    for (const user of users) {
      if (user.organizationId) {
        const result = await db.collection('fcmTokens').updateMany(
          { 
            userEmail: user.email,
            $or: [
              { organizationId: { $exists: false } },
              { organizationId: null },
              { organizationId: '' }
            ]
          },
          { 
            $set: { 
              organizationId: user.organizationId,
              updatedAt: new Date()
            } 
          }
        );
        
        if (result.modifiedCount > 0) {
          console.log(`Fixed ${result.modifiedCount} FCM token(s) for user: ${user.email} (${user.role}) -> organizationId: ${user.organizationId}`);
          fixedCount += result.modifiedCount;
        }
      } else {
        console.log(`Warning: User ${user.email} has no organizationId`);
      }
    }
    
    console.log(`\n=== Summary ===`);
    console.log(`Total FCM tokens fixed: ${fixedCount}`);
    
    // Verify the fix
    console.log('\n=== Verification ===');
    const remainingTokensWithoutOrgId = await db.collection('fcmTokens').find({
      $or: [
        { organizationId: { $exists: false } },
        { organizationId: null },
        { organizationId: '' }
      ]
    }).toArray();
    
    console.log(`Remaining FCM tokens without organizationId: ${remainingTokensWithoutOrgId.length}`);
    
    if (remainingTokensWithoutOrgId.length > 0) {
      console.log('Remaining problematic tokens:');
      remainingTokensWithoutOrgId.forEach(token => {
        console.log(`- User: ${token.userEmail}, Token: ${token.fcmToken ? token.fcmToken.substring(0, 20) + '...' : 'NULL'}`);
      });
    }
    
    // Show final statistics
    console.log('\n=== Final Statistics ===');
    const totalTokens = await db.collection('fcmTokens').countDocuments();
    const tokensWithOrgId = await db.collection('fcmTokens').countDocuments({
      organizationId: { $exists: true, $ne: null, $ne: '' }
    });
    
    console.log(`Total FCM tokens: ${totalTokens}`);
    console.log(`FCM tokens with organizationId: ${tokensWithOrgId}`);
    console.log(`FCM tokens without organizationId: ${totalTokens - tokensWithOrgId}`);
    
  } catch (error) {
    console.error('Error fixing FCM token organization:', error);
  } finally {
    if (client) {
      await client.close();
      console.log('\nDatabase connection closed');
    }
  }
}

// Run the script
fixFcmTokenOrganization();