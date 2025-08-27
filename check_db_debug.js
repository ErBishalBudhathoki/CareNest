const { MongoClient } = require('mongodb');
require('dotenv').config();

const client = new MongoClient(process.env.MONGODB_URI);

async function checkDB() {
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('invoice');
    
    // List all collections
    const collections = await db.listCollections().toArray();
    console.log('\nAvailable collections:', collections.map(c => c.name));
    
    // Count documents in each collection
    for (const col of collections) {
      const count = await db.collection(col.name).countDocuments();
      console.log(`${col.name}: ${count} documents`);
      
      // Show sample documents for non-empty collections
      if (count > 0) {
        const sample = await db.collection(col.name).findOne();
        console.log(`  Sample document:`, JSON.stringify(sample, null, 2));
      }
    }
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

checkDB();