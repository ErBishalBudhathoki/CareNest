require('dotenv').config();
const { MongoClient, ServerApiVersion } = require('mongodb');

// IMPORTANT: Replace with your MongoDB connection string if not using an environment variable
// or ensure MONGO_URI is set in your environment.
const uri = process.env.MONGODB_URI; // Default to localhost if not set

async function createTextIndex() {
  const client = new MongoClient(uri, {
    serverApi: {
      version: ServerApiVersion.v1,
      strict: false, // Changed from true to false
      deprecationErrors: true,
    }
  });

  try {
    // Connect the client to the server (optional starting in v4.7)
    await client.connect();
    console.log("Connected successfully to MongoDB server");

    const db = client.db('Invoice'); // Replace 'Invoice' if your database name is different
    const supportItemsCollection = db.collection('supportItems');

    console.log("Creating text index on 'supportItems' collection for fields 'supportItemName' and 'supportItemNumber'...");
    
    // The line from server.js:L3845
    await supportItemsCollection.createIndex({ supportItemName: 'text', supportItemNumber: 'text' });

    console.log("Text index created successfully (or already existed).");

  } catch (error) {
    console.error('Error creating text index:', error);
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
    console.log("MongoDB connection closed.");
  }
}

createTextIndex().catch(console.error);