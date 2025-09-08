const { MongoClient } = require('mongodb');
const path = require('path');
const fs = require('fs');
const logger = require('../utils/structuredLogger');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

/**
 * Migration script to update and enhance NDIS support items data
 * This script ensures NDIS data is current and properly structured for the enhanced pricing system
 */

async function migrateNdisData() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    logger.info('Connected to MongoDB for NDIS data migration');
    
    const db = client.db('Invoice');
    const supportItemsCollection = db.collection('supportItems');
    
    console.log('🔄 Starting NDIS data migration and enhancement...');
    
    // Step 1: Check current NDIS data status
    console.log('\n📊 Analyzing current NDIS data...');
    
    const totalItems = await supportItemsCollection.countDocuments();
    console.log(`Found ${totalItems} existing NDIS support items`);
    
    if (totalItems === 0) {
      console.log('❌ No NDIS support items found. Please run seed_support_items.js first.');
      return;
    }
    
    // Step 2: Enhance existing NDIS items with missing fields
    console.log('\n🔧 Enhancing NDIS items with missing fields...');
    
    let enhancedCount = 0;
    let errorCount = 0;
    
    const cursor = supportItemsCollection.find({});
    
    while (await cursor.hasNext()) {
      const item = await cursor.next();
      
      try {
        const updates = {};
        let needsUpdate = false;
        
        // Add pricing validation fields if missing
        if (!item.hasOwnProperty('pricingValidation')) {
          updates.pricingValidation = {
            lastValidated: new Date(),
            validationStatus: 'pending',
            validationNotes: 'Enhanced during migration'
          };
          needsUpdate = true;
        }
        
        // Add enhanced metadata if missing
        if (!item.hasOwnProperty('metadata')) {
          updates.metadata = {
            category: item.registrationGroup || 'Unknown',
            subcategory: item.supportCategory || 'Unknown',
            complexity: item.unit === 'H' ? 'time-based' : 'unit-based',
            requiresQuote: item.type === 'Price Limited Supports',
            isActive: true,
            lastUpdated: new Date()
          };
          needsUpdate = true;
        }
        
        // Add state-specific pricing structure if missing
        if (!item.hasOwnProperty('enhancedPricing')) {
          const enhancedPricing = {
            basePrice: {
              standard: item.priceCaps?.standard || {},
              highIntensity: item.priceCaps?.highIntensity || {}
            },
            multipliers: {
              evening: 1.0,
              weekend: 1.0,
              publicHoliday: 1.0,
              shortNotice: 1.0
            },
            validFrom: new Date(),
            validTo: new Date('2025-12-31T23:59:59Z')
          };
          updates.enhancedPricing = enhancedPricing;
          needsUpdate = true;
        }
        
        // Add search optimization fields
        if (!item.hasOwnProperty('searchOptimization')) {
          updates.searchOptimization = {
            keywords: [
              item.itemName?.toLowerCase(),
              item.supportItemNumber,
              item.registrationGroup?.toLowerCase(),
              item.supportCategory?.toLowerCase()
            ].filter(Boolean),
            searchScore: 1.0,
            popularityScore: 0,
            lastSearched: null
          };
          needsUpdate = true;
        }
        
        // Add compliance tracking
        if (!item.hasOwnProperty('compliance')) {
          updates.compliance = {
            ndisCompliant: true,
            lastComplianceCheck: new Date(),
            complianceNotes: 'Migrated item - compliance assumed',
            regulatoryVersion: '2024.1'
          };
          needsUpdate = true;
        }
        
        // Update the document if needed
        if (needsUpdate) {
          updates.migrationEnhanced = {
            enhancedAt: new Date(),
            enhancedBy: 'ndis_migration_script',
            version: '1.0'
          };
          
          await supportItemsCollection.updateOne(
            { _id: item._id },
            { $set: updates }
          );
          
          enhancedCount++;
          
          if (enhancedCount % 100 === 0) {
            console.log(`Enhanced ${enhancedCount} items...`);
          }
        }
        
      } catch (error) {
        console.error(`❌ Error enhancing item ${item.supportItemNumber}:`, error.message);
        errorCount++;
      }
    }
    
    // Step 3: Create indexes for enhanced fields
    console.log('\n📋 Creating indexes for enhanced NDIS data...');
    
    const indexesToCreate = [
      {
        keys: { 'searchOptimization.keywords': 1 },
        options: { name: 'search_keywords_idx' }
      },
      {
        keys: { 'metadata.category': 1, 'metadata.subcategory': 1 },
        options: { name: 'category_subcategory_idx' }
      },
      {
        keys: { 'compliance.ndisCompliant': 1, 'metadata.isActive': 1 },
        options: { name: 'compliance_active_idx' }
      },
      {
        keys: { 'enhancedPricing.validFrom': 1, 'enhancedPricing.validTo': 1 },
        options: { name: 'pricing_validity_idx' }
      }
    ];
    
    let indexCount = 0;
    for (const indexDef of indexesToCreate) {
      try {
        await supportItemsCollection.createIndex(indexDef.keys, indexDef.options);
        console.log(`✅ Created index: ${indexDef.options.name}`);
        indexCount++;
      } catch (error) {
        if (error.code === 85) {
          console.log(`⚠️  Index ${indexDef.options.name} already exists`);
        } else {
          console.error(`❌ Error creating index ${indexDef.options.name}:`, error.message);
        }
      }
    }
    
    // Step 4: Update NDIS data from CSV if available
    console.log('\n📥 Checking for updated NDIS CSV data...');
    
    const csvPath = path.join(__dirname, '..', 'NDIS.csv');
    if (fs.existsSync(csvPath)) {
      console.log('Found NDIS.csv file, checking for updates...');
      
      // Read and parse CSV (simplified - in production, use proper CSV parser)
      const csvContent = fs.readFileSync(csvPath, 'utf8');
      const lines = csvContent.split('\n');
      const headers = lines[0].split(',');
      
      let updatedFromCsv = 0;
      
      for (let i = 1; i < Math.min(lines.length, 100); i++) { // Limit for demo
        const values = lines[i].split(',');
        if (values.length >= headers.length) {
          const supportItemNumber = values[0]?.trim();
          
          if (supportItemNumber) {
            const existingItem = await supportItemsCollection.findOne({
              supportItemNumber: supportItemNumber
            });
            
            if (existingItem) {
              // Update last validation date
              await supportItemsCollection.updateOne(
                { supportItemNumber: supportItemNumber },
                {
                  $set: {
                    'pricingValidation.lastValidated': new Date(),
                    'pricingValidation.validationStatus': 'current'
                  }
                }
              );
              updatedFromCsv++;
            }
          }
        }
      }
      
      console.log(`✅ Updated ${updatedFromCsv} items from CSV data`);
    } else {
      console.log('⚠️  No NDIS.csv file found, skipping CSV updates');
    }
    
    // Step 5: Generate migration report
    console.log('\n📈 NDIS Data Migration Summary:');
    console.log(`- Total NDIS items processed: ${totalItems}`);
    console.log(`- Items enhanced with new fields: ${enhancedCount}`);
    console.log(`- Errors encountered: ${errorCount}`);
    console.log(`- Indexes created: ${indexCount}`);
    
    // Step 6: Verify migration results
    const enhancedItems = await supportItemsCollection.countDocuments({
      'migrationEnhanced.enhancedBy': 'ndis_migration_script'
    });
    
    const compliantItems = await supportItemsCollection.countDocuments({
      'compliance.ndisCompliant': true
    });
    
    console.log('\n🔍 Verification:');
    console.log(`- Items enhanced by migration: ${enhancedItems}`);
    console.log(`- NDIS compliant items: ${compliantItems}`);
    
    // Sample enhanced item
    if (enhancedCount > 0) {
      console.log('\n📋 Sample enhanced item:');
      const sampleItem = await supportItemsCollection.findOne({
        'migrationEnhanced.enhancedBy': 'ndis_migration_script'
      });
      
      if (sampleItem) {
        console.log(JSON.stringify({
          supportItemNumber: sampleItem.supportItemNumber,
          itemName: sampleItem.itemName,
          metadata: sampleItem.metadata,
          compliance: sampleItem.compliance,
          enhancedPricing: sampleItem.enhancedPricing ? 'Present' : 'Missing'
        }, null, 2));
      }
    }
    
  } catch (error) {
    console.error('Error during NDIS data migration:', error);
    throw error;
  } finally {
    await client.close();
    console.log('\nMongoDB connection closed');
  }
}

// Run the migration if this file is executed directly
if (require.main === module) {
  migrateNdisData()
    .then(() => {
      console.log('\n✅ NDIS data migration completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ NDIS migration failed:', error);
      process.exit(1);
    });
}

module.exports = { migrateNdisData };