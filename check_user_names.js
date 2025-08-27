const { MongoClient, ServerApiVersion } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function checkUserNames() {
  let client;
  
  try {
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    console.log('=== Checking user names in login collection ===');
    
    // Check test@tester.com
    const testUser = await db.collection("login").findOne({
      email: "test@tester.com"
    });
    
    console.log('\ntest@tester.com user data:');
    if (testUser) {
      console.log('firstName:', testUser.firstName);
      console.log('lastName:', testUser.lastName);
      console.log('name:', testUser.name);
      console.log('email:', testUser.email);
      console.log('organizationId:', testUser.organizationId);
    } else {
      console.log('User not found');
    }
    
    // Check test1@tester.com
    const test1User = await db.collection("login").findOne({
      email: "test1@tester.com"
    });
    
    console.log('\ntest1@tester.com user data:');
    if (test1User) {
      console.log('firstName:', test1User.firstName);
      console.log('lastName:', test1User.lastName);
      console.log('name:', test1User.name);
      console.log('email:', test1User.email);
      console.log('organizationId:', test1User.organizationId);
    } else {
      console.log('User not found');
    }
    
    // Check if there are any assignments for these users
    console.log('\n=== Checking assignments ===');
    
    const assignments = await db.collection("clientAssignments").find({
      $or: [
        { userEmail: "test@tester.com" },
        { userEmail: "test1@tester.com" }
      ]
    }).toArray();
    
    console.log(`Found ${assignments.length} assignments`);
    assignments.forEach((assignment, index) => {
      console.log(`\nAssignment ${index + 1}:`);
      console.log('userEmail:', assignment.userEmail);
      console.log('userName:', assignment.userName);
      console.log('organizationId:', assignment.organizationId);
      console.log('isActive:', assignment.isActive);
    });
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

checkUserNames();