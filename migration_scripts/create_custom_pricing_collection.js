const { MongoClient } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

/**
 * Migration script to create the customPricing collection with proper schema and indexes
 * This collection stores organization-specific and client-specific pricing for NDIS items
 */

async function createCustomPricingCollection() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check if collection already exists
    const collections = await db.listCollections({ name: 'customPricing' }).toArray();
    if (collections.length > 0) {
      console.log('customPricing collection already exists');
      return;
    }
    
    // Create the customPricing collection
    await db.createCollection('customPricing');
    console.log('Created customPricing collection');
    
    // Create indexes for efficient querying
    const customPricingCollection = db.collection('customPricing');
    
    // Compound index for organization and support item lookup
    await customPricingCollection.createIndex(
      { organizationId: 1, supportItemNumber: 1 },
      { name: 'org_support_item_idx' }
    );
    
    // Compound index for client-specific pricing lookup
    await customPricingCollection.createIndex(
      { organizationId: 1, clientId: 1, supportItemNumber: 1 },
      { name: 'client_specific_pricing_idx' }
    );
    
    // Index for active pricing lookup
    await customPricingCollection.createIndex(
      { isActive: 1, effectiveDate: 1, expiryDate: 1 },
      { name: 'active_pricing_idx' }
    );
    
    // Index for approval workflow
    await customPricingCollection.createIndex(
      { organizationId: 1, approvalStatus: 1 },
      { name: 'approval_workflow_idx' }
    );
    
    console.log('Created indexes for customPricing collection');
    
    // Insert sample document to demonstrate schema
    const samplePricing = {
      _id: null, // Will be auto-generated
      organizationId: 'sample_org_id',
      supportItemNumber: '01_002_01_1_1',
      supportItemName: 'Assistance With Self-Care Activities - Standard - Weekday Daytime',
      
      // Pricing configuration
      pricingType: 'fixed', // 'fixed' or 'multiplier'
      
      // For fixed pricing
      customPrice: {
        amount: 65.00,
        currency: 'AUD',
        state: 'NSW' // State-specific pricing
      },
      
      // For multiplier pricing
      multiplier: {
        factor: 0.95, // 95% of NDIS cap
        basedOn: 'standard' // 'standard' or 'highIntensity'
      },
      
      // Client-specific override (null for organization-wide pricing)
      clientId: null, // If set, this pricing applies only to this client
      clientSpecific: false,
      
      // Validation and compliance
      ndisCompliant: true,
      exceedsNdisCap: false,
      validationNotes: '',
      
      // Approval workflow
      approvalStatus: 'approved', // 'pending', 'approved', 'rejected'
      approvedBy: 'admin@sample.com',
      approvedAt: new Date(),
      rejectionReason: null,
      
      // Effective dates
      effectiveDate: new Date(),
      expiryDate: new Date('2025-12-31T23:59:59Z'),
      
      // Audit trail
      createdBy: 'admin@sample.com',
      createdAt: new Date(),
      updatedBy: 'admin@sample.com',
      updatedAt: new Date(),
      
      // Status
      isActive: true,
      
      // Additional metadata
      notes: 'Sample pricing configuration',
      tags: ['standard', 'self-care'],
      
      // Version control for pricing changes
      version: 1,
      previousVersionId: null
    };
    
    // Note: We're not inserting the sample document to avoid test data in production
    console.log('Sample document schema:');
    console.log(JSON.stringify(samplePricing, null, 2));
    
    console.log('\n=== customPricing Collection Schema ===');
    console.log('Fields:');
    console.log('- organizationId: String (required) - Multi-tenant isolation');
    console.log('- supportItemNumber: String (required) - NDIS support item identifier');
    console.log('- supportItemName: String (required) - Human-readable item name');
    console.log('- pricingType: String (required) - "fixed" or "multiplier"');
    console.log('- customPrice: Object - Fixed price configuration');
    console.log('- multiplier: Object - Multiplier-based pricing configuration');
    console.log('- clientId: String (optional) - For client-specific pricing');
    console.log('- clientSpecific: Boolean - Whether this is client-specific pricing');
    console.log('- ndisCompliant: Boolean - NDIS compliance status');
    console.log('- exceedsNdisCap: Boolean - Whether price exceeds NDIS cap');
    console.log('- approvalStatus: String - Workflow status');
    console.log('- effectiveDate: Date - When pricing becomes active');
    console.log('- expiryDate: Date - When pricing expires');
    console.log('- createdBy/updatedBy: String - Audit trail');
    console.log('- isActive: Boolean - Active status');
    console.log('- version: Number - Version control');
    
    console.log('\nIndexes created:');
    console.log('- org_support_item_idx: organizationId + supportItemNumber');
    console.log('- client_specific_pricing_idx: organizationId + clientId + supportItemNumber');
    console.log('- active_pricing_idx: isActive + effectiveDate + expiryDate');
    console.log('- approval_workflow_idx: organizationId + approvalStatus');
    
  } catch (error) {
    console.error('Error creating customPricing collection:', error);
    throw error;
  } finally {
    await client.close();
    console.log('\nMongoDB connection closed');
  }
}

// Run the migration if this file is executed directly
if (require.main === module) {
  createCustomPricingCollection()
    .then(() => {
      console.log('\n✅ customPricing collection migration completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Migration failed:', error);
      process.exit(1);
    });
}

module.exports = { createCustomPricingCollection };