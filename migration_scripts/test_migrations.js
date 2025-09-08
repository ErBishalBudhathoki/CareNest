const { MongoClient } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

// Import all migration functions
const { createCustomPricingCollection } = require('./create_custom_pricing_collection');
const { createExpensesCollection } = require('./create_expenses_collection');
const { migrateUserOrganizationData } = require('./migrate_user_organization_data');
const { migrateClientData } = require('./migrate_client_data');
const { migrateNdisData } = require('./migrate_ndis_data');
const { migrateInvoiceData } = require('./migrate_invoice_data');
const { migrateExistingPricing } = require('./migrate_existing_pricing');

/**
 * Comprehensive test suite for all migration scripts
 * This script validates that all migrations work correctly and data integrity is maintained
 */

class MigrationTester {
  constructor() {
    this.client = null;
    this.db = null;
    this.testResults = {
      passed: 0,
      failed: 0,
      errors: []
    };
  }

  async connect() {
    this.client = new MongoClient(process.env.MONGODB_URI);
    await this.client.connect();
    this.db = this.client.db('Invoice');
    console.log('Connected to MongoDB for testing');
  }

  async disconnect() {
    if (this.client) {
      await this.client.close();
      console.log('Disconnected from MongoDB');
    }
  }

  async runTest(testName, testFunction) {
    try {
      console.log(`\n🧪 Running test: ${testName}`);
      await testFunction();
      console.log(`✅ Test passed: ${testName}`);
      this.testResults.passed++;
    } catch (error) {
      console.error(`❌ Test failed: ${testName}`);
      console.error(`Error: ${error.message}`);
      this.testResults.failed++;
      this.testResults.errors.push({ test: testName, error: error.message });
    }
  }

  async testCollectionCreation() {
    // Test custom pricing collection creation
    await createCustomPricingCollection();
    const customPricingExists = await this.db.listCollections({ name: 'customPricing' }).hasNext();
    if (!customPricingExists) {
      throw new Error('customPricing collection was not created');
    }

    // Test expenses collection creation
    await createExpensesCollection();
    const expensesExists = await this.db.listCollections({ name: 'expenses' }).hasNext();
    if (!expensesExists) {
      throw new Error('expenses collection was not created');
    }

    // Verify indexes were created
    const customPricingIndexes = await this.db.collection('customPricing').indexes();
    const expensesIndexes = await this.db.collection('expenses').indexes();
    
    if (customPricingIndexes.length < 5) {
      throw new Error('customPricing collection missing expected indexes');
    }
    
    if (expensesIndexes.length < 8) {
      throw new Error('expenses collection missing expected indexes');
    }
  }

  async testUserOrganizationMigration() {
    // Create test data
    const testUser = {
      _id: 'test_user_001',
      email: 'test@example.com',
      role: 'admin',
      createdAt: new Date()
    };

    await this.db.collection('login').insertOne(testUser);

    // Run migration
    await migrateUserOrganizationData();

    // Verify user was enhanced
    const enhancedUser = await this.db.collection('login').findOne({ _id: 'test_user_001' });
    
    if (!enhancedUser.permissions) {
      throw new Error('User permissions were not added');
    }
    
    if (!enhancedUser.organizationId) {
      throw new Error('User organizationId was not set');
    }

    // Verify default organization was created
    const defaultOrg = await this.db.collection('organizations').findOne({ _id: 'default_org_001' });
    
    if (!defaultOrg) {
      throw new Error('Default organization was not created');
    }
    
    if (!defaultOrg.settings?.pricing) {
      throw new Error('Organization pricing settings were not added');
    }

    // Cleanup
    await this.db.collection('login').deleteOne({ _id: 'test_user_001' });
  }

  async testClientDataMigration() {
    // Create test client
    const testClient = {
      _id: 'test_client_001',
      name: 'Test Client',
      email: 'client@example.com',
      state: 'NSW',
      ndisNumber: '12345678',
      createdAt: new Date()
    };

    await this.db.collection('clients').insertOne(testClient);

    // Run migration
    await migrateClientData();

    // Verify client was enhanced
    const enhancedClient = await this.db.collection('clients').findOne({ _id: 'test_client_001' });
    
    if (!enhancedClient.pricingPreferences) {
      throw new Error('Client pricing preferences were not added');
    }
    
    if (!enhancedClient.compliance) {
      throw new Error('Client compliance settings were not added');
    }
    
    if (!enhancedClient.compliance.requiresNdisCompliance) {
      throw new Error('NDIS compliance was not properly detected');
    }

    // Cleanup
    await this.db.collection('clients').deleteOne({ _id: 'test_client_001' });
  }

  async testNdisDataMigration() {
    // Create test NDIS item
    const testNdisItem = {
      _id: 'test_ndis_001',
      supportItemNumber: '01_001_0107_1_1',
      supportItemName: 'Test Support Item',
      unit: 'Hour',
      price: 65.57,
      createdAt: new Date()
    };

    await this.db.collection('ndis').insertOne(testNdisItem);

    // Run migration
    await migrateNdisData();

    // Verify NDIS item was enhanced
    const enhancedNdisItem = await this.db.collection('ndis').findOne({ _id: 'test_ndis_001' });
    
    if (!enhancedNdisItem.pricingValidation) {
      throw new Error('NDIS pricing validation was not added');
    }
    
    if (!enhancedNdisItem.searchOptimization) {
      throw new Error('NDIS search optimization was not added');
    }

    // Cleanup
    await this.db.collection('ndis').deleteOne({ _id: 'test_ndis_001' });
  }

  async testInvoiceDataMigration() {
    // Create test line item
    const testLineItem = {
      _id: 'test_lineitem_001',
      clientId: 'test_client_001',
      employeeId: 'test_employee_001',
      supportItemNumber: '01_001_0107_1_1',
      price: 65.57,
      quantity: 2,
      date: new Date(),
      createdAt: new Date()
    };

    await this.db.collection('lineItems').insertOne(testLineItem);

    // Run migration
    await migrateInvoiceData();

    // Verify line item was enhanced
    const enhancedLineItem = await this.db.collection('lineItems').findOne({ _id: 'test_lineitem_001' });
    
    if (!enhancedLineItem.pricingMetadata) {
      throw new Error('Line item pricing metadata was not added');
    }
    
    if (!enhancedLineItem.ndisCompliance) {
      throw new Error('Line item NDIS compliance was not added');
    }
    
    if (!enhancedLineItem.financialTracking) {
      throw new Error('Line item financial tracking was not added');
    }

    // Cleanup
    await this.db.collection('lineItems').deleteOne({ _id: 'test_lineitem_001' });
  }

  async testExistingPricingMigration() {
    // Create test data for pricing migration
    const testLineItems = [
      {
        _id: 'pricing_test_001',
        organizationId: 'default_org_001',
        clientId: 'test_client_001',
        supportItemNumber: '01_001_0107_1_1',
        price: 65.57,
        quantity: 2,
        date: new Date(),
        createdAt: new Date()
      },
      {
        _id: 'pricing_test_002',
        organizationId: 'default_org_001',
        clientId: 'test_client_001',
        supportItemNumber: '01_001_0107_1_1',
        price: 65.57,
        quantity: 1,
        date: new Date(),
        createdAt: new Date()
      }
    ];

    await this.db.collection('lineItems').insertMany(testLineItems);

    // Create test NDIS item for validation
    const testNdisItem = {
      supportItemNumber: '01_001_0107_1_1',
      supportItemName: 'Test Support Item',
      unit: 'Hour',
      price: 65.57,
      state: 'NSW'
    };

    await this.db.collection('ndis').insertOne(testNdisItem);

    // Run migration
    await migrateExistingPricing();

    // Verify pricing record was created
    const pricingRecord = await this.db.collection('customPricing').findOne({
      organizationId: 'default_org_001',
      supportItemNumber: '01_001_0107_1_1'
    });
    
    if (!pricingRecord) {
      throw new Error('Custom pricing record was not created');
    }
    
    if (pricingRecord.customPrice.amount !== 65.57) {
      throw new Error('Custom pricing amount is incorrect');
    }

    // Cleanup
    await this.db.collection('lineItems').deleteMany({ _id: { $in: ['pricing_test_001', 'pricing_test_002'] } });
    await this.db.collection('ndis').deleteOne({ supportItemNumber: '01_001_0107_1_1' });
    await this.db.collection('customPricing').deleteOne({
      organizationId: 'default_org_001',
      supportItemNumber: '01_001_0107_1_1'
    });
  }

  async testDataIntegrity() {
    // Test that all collections exist
    const collections = await this.db.listCollections().toArray();
    const collectionNames = collections.map(c => c.name);
    
    const requiredCollections = ['customPricing', 'expenses', 'organizations', 'login', 'clients'];
    
    for (const required of requiredCollections) {
      if (!collectionNames.includes(required)) {
        throw new Error(`Required collection ${required} does not exist`);
      }
    }

    // Test that indexes exist
    const customPricingIndexes = await this.db.collection('customPricing').indexes();
    const expensesIndexes = await this.db.collection('expenses').indexes();
    
    if (customPricingIndexes.length < 2) {
      throw new Error('customPricing collection missing indexes');
    }
    
    if (expensesIndexes.length < 2) {
      throw new Error('expenses collection missing indexes');
    }
  }

  async testPerformance() {
    // Test query performance with indexes
    const startTime = Date.now();
    
    // Test customPricing query
    await this.db.collection('customPricing').findOne({
      organizationId: 'default_org_001',
      supportItemNumber: '01_001_0107_1_1'
    });
    
    // Test expenses query
    await this.db.collection('expenses').findOne({
      organizationId: 'default_org_001',
      isActive: true
    });
    
    const endTime = Date.now();
    const queryTime = endTime - startTime;
    
    if (queryTime > 1000) { // 1 second threshold
      throw new Error(`Query performance is poor: ${queryTime}ms`);
    }
    
    console.log(`Query performance test passed: ${queryTime}ms`);
  }

  async runAllTests() {
    console.log('🚀 Starting comprehensive migration tests...');
    
    await this.connect();
    
    try {
      // Test collection creation
      await this.runTest('Collection Creation', () => this.testCollectionCreation());
      
      // Test data migrations
      await this.runTest('User & Organization Migration', () => this.testUserOrganizationMigration());
      await this.runTest('Client Data Migration', () => this.testClientDataMigration());
      await this.runTest('NDIS Data Migration', () => this.testNdisDataMigration());
      await this.runTest('Invoice Data Migration', () => this.testInvoiceDataMigration());
      await this.runTest('Existing Pricing Migration', () => this.testExistingPricingMigration());
      
      // Test data integrity
      await this.runTest('Data Integrity', () => this.testDataIntegrity());
      
      // Test performance
      await this.runTest('Performance', () => this.testPerformance());
      
    } finally {
      await this.disconnect();
    }
    
    // Print test results
    console.log('\n📊 Test Results Summary:');
    console.log(`✅ Tests passed: ${this.testResults.passed}`);
    console.log(`❌ Tests failed: ${this.testResults.failed}`);
    
    if (this.testResults.errors.length > 0) {
      console.log('\n🔍 Failed Test Details:');
      this.testResults.errors.forEach(error => {
        console.log(`- ${error.test}: ${error.error}`);
      });
    }
    
    if (this.testResults.failed === 0) {
      console.log('\n🎉 All migration tests passed successfully!');
      return true;
    } else {
      console.log('\n⚠️  Some migration tests failed. Please review and fix issues.');
      return false;
    }
  }
}

// Run tests if this file is executed directly
if (require.main === module) {
  const tester = new MigrationTester();
  
  tester.runAllTests()
    .then((success) => {
      process.exit(success ? 0 : 1);
    })
    .catch((error) => {
      console.error('\n💥 Test suite failed with error:', error);
      process.exit(1);
    });
}

module.exports = { MigrationTester };