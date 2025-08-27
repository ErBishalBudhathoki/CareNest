/**
 * Data Migration Script: Fix Expense ClientId Mismatch
 * 
 * This script fixes the issue where expenses have clientEmail as clientId
 * instead of the actual MongoDB ObjectId from the clients collection.
 * 
 * Issue: Invoice generation fails to include approved expenses because
 * it queries expenses using client._id (ObjectId) but expenses have
 * clientEmail (string) stored as clientId.
 */

const { MongoClient, ObjectId } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;

async function fixExpenseClientIds() {
  let client;
  
  try {
    console.log('🔧 Starting expense clientId migration...');
    
    // Connect to MongoDB
    client = new MongoClient(uri, {
      serverApi: {
        version: '1',
        strict: true,
        deprecationErrors: true,
      }
    });
    
    await client.connect();
    const db = client.db('Invoice');
    
    // Get all expenses that have clientId as string (likely clientEmail)
    const expensesWithStringClientId = await db.collection('expenses').find({
      clientId: { $type: 'string', $ne: null },
      isActive: true
    }).toArray();
    
    console.log(`📊 Found ${expensesWithStringClientId.length} expenses with string clientId`);
    
    let fixedCount = 0;
    let notFoundCount = 0;
    
    for (const expense of expensesWithStringClientId) {
      try {
        // Try to find the client by email (assuming clientId contains email)
        const client = await db.collection('clients').findOne({
          clientEmail: expense.clientId,
          isActive: true
        });
        
        if (client) {
          // Update the expense with the correct ObjectId
          await db.collection('expenses').updateOne(
            { _id: expense._id },
            { 
              $set: { 
                clientId: client._id,
                updatedAt: new Date(),
                migrationNote: 'Fixed clientId from email to ObjectId'
              }
            }
          );
          
          console.log(`✅ Fixed expense ${expense._id}: ${expense.clientId} -> ${client._id}`);
          fixedCount++;
        } else {
          console.log(`❌ Client not found for expense ${expense._id} with clientId: ${expense.clientId}`);
          notFoundCount++;
        }
      } catch (error) {
        console.error(`❌ Error processing expense ${expense._id}:`, error.message);
      }
    }
    
    // Also check for expenses with null clientId that have clientEmail
    const expensesWithNullClientId = await db.collection('expenses').find({
      clientId: null,
      clientEmail: { $exists: true, $ne: null },
      isActive: true
    }).toArray();
    
    console.log(`📊 Found ${expensesWithNullClientId.length} expenses with null clientId but have clientEmail`);
    
    for (const expense of expensesWithNullClientId) {
      try {
        const client = await db.collection('clients').findOne({
          clientEmail: expense.clientEmail,
          isActive: true
        });
        
        if (client) {
          await db.collection('expenses').updateOne(
            { _id: expense._id },
            { 
              $set: { 
                clientId: client._id,
                updatedAt: new Date(),
                migrationNote: 'Set clientId from null to ObjectId using clientEmail'
              }
            }
          );
          
          console.log(`✅ Set clientId for expense ${expense._id}: null -> ${client._id}`);
          fixedCount++;
        } else {
          console.log(`❌ Client not found for expense ${expense._id} with clientEmail: ${expense.clientEmail}`);
          notFoundCount++;
        }
      } catch (error) {
        console.error(`❌ Error processing expense ${expense._id}:`, error.message);
      }
    }
    
    console.log('\n📈 Migration Summary:');
    console.log(`✅ Fixed expenses: ${fixedCount}`);
    console.log(`❌ Expenses with missing clients: ${notFoundCount}`);
    console.log(`📊 Total processed: ${fixedCount + notFoundCount}`);
    
    // Verify the fix by checking a sample
    const sampleFixedExpense = await db.collection('expenses').findOne({
      migrationNote: { $exists: true },
      clientId: { $type: 'objectId' }
    });
    
    if (sampleFixedExpense) {
      console.log('\n🔍 Sample fixed expense:');
      console.log(`   Expense ID: ${sampleFixedExpense._id}`);
      console.log(`   Client ID: ${sampleFixedExpense.clientId} (${typeof sampleFixedExpense.clientId})`);
      console.log(`   Migration Note: ${sampleFixedExpense.migrationNote}`);
    }
    
  } catch (error) {
    console.error('❌ Migration failed:', error);
    throw error;
  } finally {
    if (client) {
      await client.close();
    }
  }
}

// Run the migration
if (require.main === module) {
  fixExpenseClientIds()
    .then(() => {
      console.log('\n🎉 Migration completed successfully!');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n💥 Migration failed:', error);
      process.exit(1);
    });
}

module.exports = { fixExpenseClientIds };