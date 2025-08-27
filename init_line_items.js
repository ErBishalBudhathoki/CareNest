const { MongoClient, ServerApiVersion } = require('mongodb');
const dotenv = require('dotenv');

// Load environment variables
dotenv.config();

// MongoDB connection URI
const uri = process.env.MONGODB_URI;

// Sample line items data
const sampleLineItems = [
  {
    itemNumber: '01_011_0107_1_1',
    itemDescription: 'Assistance With Self-Care Activities - Standard - Weekday Daytime'
  },
  {
    itemNumber: '01_011_0107_1_1_T',
    itemDescription: 'Assistance With Self-Care Activities - Standard - Weekday Daytime - TTP'
  },
  {
    itemNumber: '01_015_0107_1_1',
    itemDescription: 'Assistance With Self-Care Activities - Standard - Weekday Evening'
  },
  {
    itemNumber: '01_002_0107_1_1',
    itemDescription: 'Assistance With Self-Care Activities - Standard - Weekday Night'
  },
  {
    itemNumber: '01_013_0107_1_1',
    itemDescription: 'Assistance With Self-Care Activities - Standard - Saturday'
  }
];

async function initLineItems() {
  let client;
  
  try {
    console.log('Connecting to MongoDB...');
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    console.log('Connected to MongoDB');
    
    const db = client.db("Invoice");
    
    // Check if lineItems collection exists
    const collections = await db.listCollections().toArray();
    const collectionNames = collections.map(c => c.name);
    
    if (collectionNames.includes('lineItems')) {
      console.log('lineItems collection already exists. Dropping it...');
      await db.collection('lineItems').drop();
    }
    
    // Create lineItems collection
    console.log('Creating lineItems collection...');
    await db.createCollection('lineItems');
    
    // Insert sample data
    console.log('Inserting sample line items...');
    const result = await db.collection('lineItems').insertMany(sampleLineItems);
    
    console.log(`${result.insertedCount} line items inserted successfully`);
    
    // Verify insertion
    const lineItems = await db.collection('lineItems').find({}).toArray();
    console.log('Line items in collection:', lineItems.length);
    console.log('Sample line item:', JSON.stringify(lineItems[0], null, 2));
    
  } catch (error) {
    console.error('Error initializing line items:', error);
  } finally {
    if (client) {
      await client.close();
      console.log('MongoDB connection closed');
    }
  }
}

initLineItems();