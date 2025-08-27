const { MongoClient, ServerApiVersion } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function cleanupDuplicatePricing() {
  let client;
  
  try {
    console.log('Connecting to MongoDB...');
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');
    
    console.log('Finding duplicate custom pricing records...');
    
    // Aggregate to find duplicates based on organizationId, supportItemNumber, clientSpecific, and clientId
    const duplicates = await db.collection('customPricing').aggregate([
      {
        $match: {
          isActive: true
        }
      },
      {
        $group: {
          _id: {
            organizationId: '$organizationId',
            supportItemNumber: '$supportItemNumber',
            clientSpecific: '$clientSpecific',
            clientId: '$clientId'
          },
          count: { $sum: 1 },
          records: { $push: { _id: '$_id', createdAt: '$createdAt', customPrice: '$customPrice' } }
        }
      },
      {
        $match: {
          count: { $gt: 1 }
        }
      }
    ]).toArray();
    
    console.log(`Found ${duplicates.length} groups of duplicate records`);
    
    let totalRemoved = 0;
    const removedRecords = [];
    
    for (const duplicate of duplicates) {
      // Sort records by createdAt descending (newest first)
      const sortedRecords = duplicate.records.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
      
      // Keep the newest record, remove the rest
      const recordsToRemove = sortedRecords.slice(1);
      
      console.log(`\nDuplicate group for organizationId: ${duplicate._id.organizationId}, supportItemNumber: ${duplicate._id.supportItemNumber}`);
      console.log(`  Client specific: ${duplicate._id.clientSpecific}, clientId: ${duplicate._id.clientId}`);
      console.log(`  Keeping newest record: ${sortedRecords[0]._id} (created: ${sortedRecords[0].createdAt}, price: ${sortedRecords[0].customPrice})`);
      console.log(`  Removing ${recordsToRemove.length} duplicate(s):`);
      
      for (const record of recordsToRemove) {
        console.log(`    - ${record._id} (created: ${record.createdAt}, price: ${record.customPrice})`);
        removedRecords.push({
          _id: record._id,
          organizationId: duplicate._id.organizationId,
          supportItemNumber: duplicate._id.supportItemNumber,
          clientSpecific: duplicate._id.clientSpecific,
          clientId: duplicate._id.clientId,
          createdAt: record.createdAt,
          customPrice: record.customPrice
        });
      }
      
      // Remove duplicate records
      const idsToRemove = recordsToRemove.map(r => r._id);
      const deleteResult = await db.collection('customPricing').deleteMany({
        _id: { $in: idsToRemove }
      });
      
      totalRemoved += deleteResult.deletedCount;
      console.log(`  Removed ${deleteResult.deletedCount} records`);
    }
    
    console.log(`\n=== CLEANUP SUMMARY ===`);
    console.log(`Total duplicate groups found: ${duplicates.length}`);
    console.log(`Total records removed: ${totalRemoved}`);
    
    if (removedRecords.length > 0) {
      console.log(`\n=== REMOVED RECORDS LOG ===`);
      removedRecords.forEach((record, index) => {
        console.log(`${index + 1}. ID: ${record._id}`);
        console.log(`   Organization: ${record.organizationId}`);
        console.log(`   Support Item: ${record.supportItemNumber}`);
        console.log(`   Client Specific: ${record.clientSpecific}`);
        console.log(`   Client ID: ${record.clientId}`);
        console.log(`   Created: ${record.createdAt}`);
        console.log(`   Price: ${record.customPrice}`);
        console.log('');
      });
    }
    
    console.log('Cleanup completed successfully!');
    
  } catch (error) {
    console.error('Error during cleanup:', error);
    process.exit(1);
  } finally {
    if (client) {
      await client.close();
      console.log('Database connection closed.');
    }
  }
}

// Run the cleanup
cleanupDuplicatePricing();