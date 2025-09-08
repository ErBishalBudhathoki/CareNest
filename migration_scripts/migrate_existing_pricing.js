const { MongoClient } = require('mongodb');
const logger = require('../utils/logger');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

/**
 * Migration script to migrate existing pricing data to the new customPricing collection
 * This script analyzes existing invoice data and creates pricing records based on historical usage
 */

async function migrateExistingPricing() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check if customPricing collection exists
    const collections = await db.listCollections({ name: 'customPricing' }).toArray();
    if (collections.length === 0) {
      console.log('❌ customPricing collection does not exist. Please run create_custom_pricing_collection.js first.');
      return;
    }
    
    logger.info('Starting migration of existing pricing data...');
    
    // Get collections
    const customPricingCollection = db.collection('customPricing');
    const invoicesCollection = db.collection('invoices');
    const lineItemsCollection = db.collection('lineItems');
    const supportItemsCollection = db.collection('supportItems');
    
    // Step 1: Analyze existing invoice data to extract pricing patterns
    console.log('\n📊 Analyzing existing invoice data...');
    
    let invoiceCount = 0;
    let lineItemCount = 0;
    let uniquePricingPatterns = new Map();
    
    try {
      // Check if invoices collection exists
      const invoicesExist = await db.listCollections({ name: 'invoices' }).toArray();
      if (invoicesExist.length > 0) {
        invoiceCount = await invoicesCollection.countDocuments();
        console.log(`Found ${invoiceCount} existing invoices`);
      }
      
      // Check if lineItems collection exists
      const lineItemsExist = await db.listCollections({ name: 'lineItems' }).toArray();
      if (lineItemsExist.length > 0) {
        lineItemCount = await lineItemsCollection.countDocuments();
        console.log(`Found ${lineItemCount} existing line items`);
        
        // Analyze line items for pricing patterns
        const lineItems = await lineItemsCollection.find({}).toArray();
        
        for (const item of lineItems) {
          if (item.organizationId && item.supportItemNumber && item.price) {
            const key = `${item.organizationId}:${item.supportItemNumber}`;
            
            if (!uniquePricingPatterns.has(key)) {
              uniquePricingPatterns.set(key, {
                organizationId: item.organizationId,
                supportItemNumber: item.supportItemNumber,
                supportItemName: item.supportItemName || item.description,
                prices: [],
                clientEmails: new Set()
              });
            }
            
            const pattern = uniquePricingPatterns.get(key);
            pattern.prices.push({
              amount: item.price,
              date: item.createdAt || new Date(),
              clientEmail: item.clientEmail,
              invoiceId: item.invoiceId
            });
            
            if (item.clientEmail) {
              pattern.clientEmails.add(item.clientEmail);
            }
          }
        }
      }
    } catch (error) {
      console.log('No existing invoice/lineItem data found, proceeding with empty migration');
    }
    
    console.log(`Found ${uniquePricingPatterns.size} unique pricing patterns`);
    
    // Step 2: Get NDIS support items for validation
    console.log('\n📋 Loading NDIS support items for validation...');
    
    let supportItems = new Map();
    try {
      const supportItemsExist = await db.listCollections({ name: 'supportItems' }).toArray();
      if (supportItemsExist.length > 0) {
        const items = await supportItemsCollection.find({}).toArray();
        for (const item of items) {
          supportItems.set(item.supportItemNumber, item);
        }
        console.log(`Loaded ${supportItems.size} NDIS support items`);
      }
    } catch (error) {
      console.log('No NDIS support items found, proceeding without validation');
    }
    
    // Step 3: Create pricing records from patterns
    console.log('\n🔄 Creating pricing records...');
    
    let migratedCount = 0;
    let skippedCount = 0;
    
    for (const [key, pattern] of uniquePricingPatterns) {
      try {
        // Calculate most common price for this organization/item combination
        const priceFrequency = new Map();
        for (const priceEntry of pattern.prices) {
          const price = priceEntry.amount;
          priceFrequency.set(price, (priceFrequency.get(price) || 0) + 1);
        }
        
        // Get the most frequently used price
        let mostCommonPrice = 0;
        let maxFrequency = 0;
        for (const [price, frequency] of priceFrequency) {
          if (frequency > maxFrequency) {
            maxFrequency = frequency;
            mostCommonPrice = price;
          }
        }
        
        // Get NDIS item details for validation
        const ndisItem = supportItems.get(pattern.supportItemNumber);
        let ndisCompliant = true;
        let exceedsNdisCap = false;
        
        if (ndisItem && ndisItem.priceCaps) {
          // Check against standard price cap (assuming NSW for migration)
          const standardCap = ndisItem.priceCaps.standard?.NSW || ndisItem.priceCaps.standard?.ACT;
          if (standardCap && mostCommonPrice > standardCap) {
            exceedsNdisCap = true;
            ndisCompliant = false;
          }
        }
        
        // Create organization-wide pricing record
        const pricingRecord = {
          organizationId: pattern.organizationId,
          supportItemNumber: pattern.supportItemNumber,
          supportItemName: pattern.supportItemName || `Support Item ${pattern.supportItemNumber}`,
          
          // Use fixed pricing based on historical data
          pricingType: 'fixed',
          customPrice: {
            amount: mostCommonPrice,
            currency: 'AUD',
            state: 'NSW' // Default state for migration
          },
          
          // No multiplier for migrated data
          multiplier: null,
          
          // Organization-wide pricing (not client-specific)
          clientEmail: null,
          clientSpecific: false,
          
          // Validation results
          ndisCompliant: ndisCompliant,
          exceedsNdisCap: exceedsNdisCap,
          validationNotes: `Migrated from existing invoice data. Used ${maxFrequency} times.`,
          
          // Auto-approve migrated pricing
          approvalStatus: 'approved',
          approvedBy: 'system_migration',
          approvedAt: new Date(),
          rejectionReason: null,
          
          // Set effective dates
          effectiveDate: new Date(),
          expiryDate: new Date('2025-12-31T23:59:59Z'),
          
          // Audit trail
          createdBy: 'system_migration',
          createdAt: new Date(),
          updatedBy: 'system_migration',
          updatedAt: new Date(),
          
          // Active status
          isActive: true,
          
          // Migration metadata
          notes: `Migrated from ${pattern.prices.length} historical invoice entries`,
          tags: ['migrated', 'historical'],
          
          // Version control
          version: 1,
          previousVersionId: null,
          
          // Migration-specific data
          migrationData: {
            sourceType: 'historical_invoices',
            priceFrequency: Object.fromEntries(priceFrequency),
            clientCount: pattern.clientEmails.size,
            usageCount: pattern.prices.length,
            dateRange: {
              earliest: new Date(Math.min(...pattern.prices.map(p => new Date(p.date)))),
              latest: new Date(Math.max(...pattern.prices.map(p => new Date(p.date))))
            }
          }
        };
        
        // Check if pricing record already exists
        const existingRecord = await customPricingCollection.findOne({
          organizationId: pattern.organizationId,
          supportItemNumber: pattern.supportItemNumber,
          clientEmail: null // Organization-wide pricing
        });
        
        if (existingRecord) {
          console.log(`⚠️  Pricing already exists for ${pattern.organizationId}:${pattern.supportItemNumber}`);
          skippedCount++;
        } else {
          await customPricingCollection.insertOne(pricingRecord);
          console.log(`✅ Created pricing for ${pattern.organizationId}:${pattern.supportItemNumber} - $${mostCommonPrice}`);
          migratedCount++;
        }
        
      } catch (error) {
        console.error(`❌ Error migrating pricing for ${key}:`, error.message);
        skippedCount++;
      }
    }
    
    // Step 4: Create summary report
    console.log('\n📈 Migration Summary:');
    console.log(`- Analyzed ${invoiceCount} invoices and ${lineItemCount} line items`);
    console.log(`- Found ${uniquePricingPatterns.size} unique pricing patterns`);
    console.log(`- Successfully migrated ${migratedCount} pricing records`);
    console.log(`- Skipped ${skippedCount} records (already exist or errors)`);
    
    // Step 5: Verify migration results
    const totalCustomPricing = await customPricingCollection.countDocuments();
    const migratedRecords = await customPricingCollection.countDocuments({
      createdBy: 'system_migration'
    });
    
    console.log(`\n🔍 Verification:`);
    console.log(`- Total pricing records in collection: ${totalCustomPricing}`);
    console.log(`- Records created by migration: ${migratedRecords}`);
    
    if (migratedCount > 0) {
      console.log('\n📋 Sample migrated record:');
      const sampleRecord = await customPricingCollection.findOne({
        createdBy: 'system_migration'
      });
      if (sampleRecord) {
        console.log(JSON.stringify({
          organizationId: sampleRecord.organizationId,
          supportItemNumber: sampleRecord.supportItemNumber,
          customPrice: sampleRecord.customPrice,
          migrationData: sampleRecord.migrationData
        }, null, 2));
      }
    }
    
  } catch (error) {
    console.error('Error during pricing migration:', error);
    throw error;
  } finally {
    await client.close();
    console.log('\nMongoDB connection closed');
  }
}

// Run the migration if this file is executed directly
if (require.main === module) {
  migrateExistingPricing()
    .then(() => {
      logger.info('\n✅ Existing pricing migration completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      logger.error('\n❌ Migration failed', {
        error: error.message,
        stack: error.stack
      });
      process.exit(1);
    });
}

module.exports = { migrateExistingPricing };