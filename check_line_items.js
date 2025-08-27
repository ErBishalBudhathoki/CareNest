const { MongoClient, ServerApiVersion } = require('mongodb');
const dotenv = require('dotenv');

// Load environment variables
dotenv.config();

// MongoDB connection URI
const uri = process.env.MONGODB_URI;
console.log('MongoDB URI available:', !!uri);

async function checkLineItems() {
  let client;
  
  try {
    console.log('Connecting to MongoDB...');
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    console.log('Connected to MongoDB');
    
    const db = client.db("Invoice");
    console.log('Using database: Invoice');
    
    // Check if lineItems collection exists
    const collections = await db.listCollections().toArray();
    console.log('Available collections:', collections.map(c => c.name));
    
    const lineItemsCollection = collections.find(c => c.name === 'lineItems');
    console.log('lineItems collection exists:', !!lineItemsCollection);
    
    if (lineItemsCollection) {
      // Find all line items
      const lineItems = await db.collection("lineItems")
        .find({})
        .limit(5)
        .toArray();
      
      console.log('Line items found:', lineItems.length);
      if (lineItems.length > 0) {
        console.log('Sample line item:', JSON.stringify(lineItems[0], null, 2));
      } else {
        console.log('No line items found in the collection');
      }
    }
    
  } catch (error) {
    console.error('Error checking line items:', error);
  } finally {
    if (client) {
      await client.close();
      console.log('MongoDB connection closed');
    }
  }
}

checkLineItems();