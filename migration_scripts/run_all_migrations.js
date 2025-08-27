const { createCustomPricingCollection } = require('./create_custom_pricing_collection');
const { createExpensesCollection } = require('./create_expenses_collection');
const { migrateExistingPricing } = require('./migrate_existing_pricing');
const { migrateNdisData } = require('./migrate_ndis_data');
const { migrateUserOrganizationData } = require('./migrate_user_organization_data');
const { migrateClientData } = require('./migrate_client_data');
const { migrateInvoiceData } = require('./migrate_invoice_data');

/**
 * Master migration script that runs all database migrations in the correct order
 * This ensures proper setup of the enhanced invoice generation system
 */

async function runAllMigrations() {
  console.log('🚀 Starting Enhanced Invoice Generation Database Migrations');
  console.log('=' .repeat(60));
  
  const startTime = Date.now();
  let successCount = 0;
  let failureCount = 0;
  
  const migrations = [
    {
      name: 'Create customPricing Collection',
      description: 'Creates the customPricing collection with proper schema and indexes',
      function: createCustomPricingCollection,
      required: true
    },
    {
      name: 'Create expenses Collection', 
      description: 'Creates the expenses collection with proper schema and indexes',
      function: createExpensesCollection,
      required: true
    },
    {
      name: 'Migrate User and Organization Data',
      description: 'Enhances user and organization data with pricing and expense management fields',
      function: migrateUserOrganizationData,
      required: false
    },
    {
      name: 'Migrate Client Data',
      description: 'Enhances client data with pricing preferences and compliance settings',
      function: migrateClientData,
      required: false
    },
    {
      name: 'Migrate NDIS Data',
      description: 'Updates NDIS support items with enhanced pricing validation and metadata',
      function: migrateNdisData,
      required: false
    },
    {
      name: 'Migrate Invoice Data',
      description: 'Enhances historical invoice and line item data for new pricing system',
      function: migrateInvoiceData,
      required: false
    },
    {
      name: 'Migrate Existing Pricing Data',
      description: 'Migrates existing invoice pricing data to the new customPricing collection',
      function: migrateExistingPricing,
      required: false // Optional - only if there's existing data
    }
  ];
  
  for (let i = 0; i < migrations.length; i++) {
    const migration = migrations[i];
    console.log(`\n📦 Step ${i + 1}/${migrations.length}: ${migration.name}`);
    console.log(`   ${migration.description}`);
    console.log('-'.repeat(50));
    
    try {
      await migration.function();
      console.log(`✅ ${migration.name} completed successfully`);
      successCount++;
    } catch (error) {
      console.error(`❌ ${migration.name} failed:`, error.message);
      failureCount++;
      
      if (migration.required) {
        console.error('🛑 This is a required migration. Stopping execution.');
        throw new Error(`Required migration failed: ${migration.name}`);
      } else {
        console.log('⚠️  This is an optional migration. Continuing with next step.');
      }
    }
  }
  
  const endTime = Date.now();
  const duration = ((endTime - startTime) / 1000).toFixed(2);
  
  console.log('\n' + '='.repeat(60));
  console.log('📊 Migration Summary');
  console.log('='.repeat(60));
  console.log(`✅ Successful migrations: ${successCount}`);
  console.log(`❌ Failed migrations: ${failureCount}`);
  console.log(`⏱️  Total duration: ${duration} seconds`);
  
  if (failureCount === 0) {
    console.log('\n🎉 All migrations completed successfully!');
    console.log('\n📋 Next Steps:');
    console.log('1. Update your backend server.js to include new API endpoints');
    console.log('2. Implement pricing and expense management endpoints');
    console.log('3. Update frontend to use new pricing and expense features');
    console.log('4. Test the enhanced invoice generation functionality');
  } else {
    console.log('\n⚠️  Some migrations failed. Please review the errors above.');
    if (successCount > 0) {
      console.log('✅ Successfully completed migrations can be used immediately.');
    }
  }
  
  console.log('\n📚 Documentation:');
  console.log('- customPricing collection: Stores organization and client-specific pricing');
  console.log('- expenses collection: Stores manual expenses and recurring expense tracking');
  console.log('- Migration logs: Check console output for detailed information');
  
  return {
    success: failureCount === 0,
    successCount,
    failureCount,
    duration
  };
}

/**
 * Function to check migration status
 */
async function checkMigrationStatus() {
  const { MongoClient } = require('mongodb');
  const path = require('path');
  require('dotenv').config({ path: path.join(__dirname, '..', '.env') });
  
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    const db = client.db('Invoice');
    
    console.log('🔍 Checking migration status...');
    console.log('-'.repeat(40));
    
    // Check customPricing collection
    const customPricingExists = await db.listCollections({ name: 'customPricing' }).toArray();
    const customPricingCount = customPricingExists.length > 0 ? await db.collection('customPricing').countDocuments() : 0;
    console.log(`📊 customPricing collection: ${customPricingExists.length > 0 ? '✅ EXISTS' : '❌ MISSING'} (${customPricingCount} documents)`);
    
    // Check expenses collection
    const expensesExists = await db.listCollections({ name: 'expenses' }).toArray();
    const expensesCount = expensesExists.length > 0 ? await db.collection('expenses').countDocuments() : 0;
    console.log(`💰 expenses collection: ${expensesExists.length > 0 ? '✅ EXISTS' : '❌ MISSING'} (${expensesCount} documents)`);
    
    // Check for migrated pricing data
    if (customPricingExists.length > 0) {
      const migratedCount = await db.collection('customPricing').countDocuments({ createdBy: 'system_migration' });
      console.log(`🔄 Migrated pricing records: ${migratedCount}`);
    }
    
    // Check existing collections for reference
    console.log('\n📋 Existing collections:');
    const allCollections = await db.listCollections().toArray();
    for (const collection of allCollections) {
      const count = await db.collection(collection.name).countDocuments();
      console.log(`   - ${collection.name}: ${count} documents`);
    }
    
    return {
      customPricingExists: customPricingExists.length > 0,
      expensesExists: expensesExists.length > 0,
      customPricingCount,
      expensesCount
    };
    
  } catch (error) {
    console.error('Error checking migration status:', error);
    throw error;
  } finally {
    await client.close();
  }
}

// Command line interface
if (require.main === module) {
  const args = process.argv.slice(2);
  const command = args[0] || 'migrate';
  
  switch (command) {
    case 'migrate':
    case 'run':
      runAllMigrations()
        .then((result) => {
          process.exit(result.success ? 0 : 1);
        })
        .catch((error) => {
          console.error('\n💥 Migration process failed:', error.message);
          process.exit(1);
        });
      break;
      
    case 'status':
    case 'check':
      checkMigrationStatus()
        .then(() => {
          console.log('\n✅ Status check completed');
          process.exit(0);
        })
        .catch((error) => {
          console.error('\n❌ Status check failed:', error.message);
          process.exit(1);
        });
      break;
      
    case 'help':
    case '--help':
    case '-h':
      console.log('\n📖 Enhanced Invoice Generation Migration Tool');
      console.log('=' .repeat(50));
      console.log('Usage: node run_all_migrations.js [command]');
      console.log('\nCommands:');
      console.log('  migrate, run    Run all migrations (default)');
      console.log('  status, check   Check migration status');
      console.log('  help           Show this help message');
      console.log('\nExamples:');
      console.log('  node run_all_migrations.js');
      console.log('  node run_all_migrations.js migrate');
      console.log('  node run_all_migrations.js status');
      process.exit(0);
      break;
      
    default:
      console.error(`❌ Unknown command: ${command}`);
      console.log('Use "node run_all_migrations.js help" for usage information.');
      process.exit(1);
  }
}

module.exports = {
  runAllMigrations,
  checkMigrationStatus
};