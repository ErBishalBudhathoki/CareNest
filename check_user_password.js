/**
 * Check User Password Script
 * 
 * This script checks the stored password format for a user in the database
 * to help understand how passwords are stored and how to properly hash them.
 */

const { MongoClient, ServerApiVersion } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });

// Get command line arguments
const args = process.argv.slice(2);
const email = args[0] || 'test@tester.com';

// MongoDB connection URI
const uri = process.env.MONGODB_URI;

async function checkUserPassword() {
  const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const usersCollection = db.collection('login');
    
    // Find the user
    const user = await usersCollection.findOne({ email: email });
    
    if (!user) {
      console.log(`No user found with email: ${email}`);
      return;
    }
    
    console.log('User found:');
    console.log('- ID:', user._id);
    console.log('- Email:', user.email);
    console.log('- First Name:', user.firstName);
    console.log('- Last Name:', user.lastName);
    console.log('- Role:', user.role);
    
    // Check password format
    if (user.password) {
      console.log('\nPassword Information:');
      console.log('- Password Length:', user.password.length);
      console.log('- Password Format:', user.password.length > 100 ? 'Likely hashed with salt' : 'Simple hash or plaintext');
      
      // If the password is likely hashed with salt (length > 100)
      if (user.password.length > 100) {
        // Extract the last 64 characters as salt
        const salt = user.password.substring(user.password.length - 64);
        const hash = user.password.substring(0, user.password.length - 64);
        
        console.log('- Salt (last 64 chars):', salt);
        console.log('- Hash (remaining chars):', hash);
      }
    } else {
      console.log('\nNo password found for user');
    }
    
  } catch (error) {
    console.error('Error checking user password:', error);
  } finally {
    await client.close();
    console.log('\nDisconnected from MongoDB');
  }
}

checkUserPassword();