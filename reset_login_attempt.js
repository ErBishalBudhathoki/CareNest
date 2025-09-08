/**
 * Reset Login Attempts Script
 * 
 * This script resets login attempts for users who are locked out due to too many failed login attempts.
 * It can reset attempts for a specific user by email or reset all locked accounts.
 */

const { MongoClient, ServerApiVersion } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });

// Get command line arguments
const args = process.argv.slice(2);
const email = args[0]; // Optional: specific user email to reset
const resetAll = args.includes('--all');

// MongoDB connection URI
const uri = process.env.MONGODB_URI;

async function resetLoginAttempts() {
  const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const usersCollection = db.collection('login');
    
    let query = {};
    let updateResult;
    
    if (email && !resetAll) {
      // Reset for specific user
      query = { email: email };
      updateResult = await usersCollection.updateOne(
        query,
        { 
          $set: { 
            loginAttempts: 0,
            lockUntil: null
          }
        }
      );
      
      if (updateResult.matchedCount === 0) {
        console.log(`No user found with email: ${email}`);
      } else if (updateResult.modifiedCount === 0) {
        console.log(`User ${email} found but no changes were needed`);
      } else {
        console.log(`Successfully reset login attempts for user: ${email}`);
      }
    } else if (resetAll) {
      // Reset for all users with login attempts > 0 or lockUntil set
      query = { 
        $or: [
          { loginAttempts: { $gt: 0 } },
          { lockUntil: { $ne: null } }
        ]
      };
      
      updateResult = await usersCollection.updateMany(
        query,
        { 
          $set: { 
            loginAttempts: 0,
            lockUntil: null
          }
        }
      );
      
      console.log(`Reset login attempts for ${updateResult.modifiedCount} users`);
    } else {
      console.log('Usage: node reset_login_attempt.js [email] [--all]');
      console.log('  - Provide an email to reset a specific user');
      console.log('  - Use --all flag to reset all locked accounts');
    }
  } catch (error) {
    console.error('Error resetting login attempts:', error);
  } finally {
    await client.close();
    console.log('Disconnected from MongoDB');
  }
}

resetLoginAttempts();