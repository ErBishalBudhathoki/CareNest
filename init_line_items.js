const { MongoClient, ServerApiVersion } = require('mongodb');
const dotenv = require('dotenv');
const logger = require('./utils/structuredLogger');

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
    logger.info('Connecting to MongoDB for line items initialization');
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    logger.info('Connected to MongoDB successfully');
    
    const db = client.db("Invoice");
    
    // Check if lineItems collection exists
    const collections = await db.listCollections().toArray();
    const collectionNames = collections.map(c => c.name);
    
    if (collectionNames.includes('lineItems')) {
      logger.info('lineItems collection already exists, dropping it');
      await db.collection('lineItems').drop();
    }
    
    // Create lineItems collection
    logger.info('Creating lineItems collection');
    await db.createCollection('lineItems');
    
    // Insert sample data
    logger.info('Inserting sample line items');
    const result = await db.collection('lineItems').insertMany(sampleLineItems);
    
    logger.info('Line items inserted successfully', {
      insertedCount: result.insertedCount
    });
    
    // Verify insertion
    const lineItems = await db.collection('lineItems').find({}).toArray();
    logger.info('Line items verification completed', {
      totalLineItems: lineItems.length,
      sampleLineItem: lineItems[0] ? JSON.stringify(lineItems[0], null, 2) : 'No items found'
    });
    
  } catch (error) {
    logger.error('Error initializing line items', {
      error: error.message,
      stack: error.stack
    });
  } finally {
    if (client) {
      await client.close();
      logger.info('MongoDB connection closed');
    }
  }
}

initLineItems();