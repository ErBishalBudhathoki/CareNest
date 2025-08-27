const { MongoClient } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

/**
 * Migration validation script
 * This script performs comprehensive validation of the migration results
 * and generates a detailed report of the system's readiness for the enhanced pricing system
 */

async function validateMigration() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB for validation');
    
    const db = client.db('Invoice');
    
    console.log('🔍 Starting comprehensive migration validation...');
    
    const validationResults = {
      collections: {},
      indexes: {},
      dataQuality: {},
      compliance: {},
      performance: {},
      readiness: {}
    };
    
    // Step 1: Validate Collections
    console.log('\n📋 Validating collections...');
    
    const requiredCollections = [
      'customPricing',
      'expenses',
      'organizations',
      'login',
      'clients',
      'clientAssignments',
      'lineItems',
      'ndis'
    ];
    
    const existingCollections = await db.listCollections().toArray();
    const existingNames = existingCollections.map(c => c.name);
    
    for (const collectionName of requiredCollections) {
      const exists = existingNames.includes(collectionName);
      const count = exists ? await db.collection(collectionName).countDocuments() : 0;
      
      validationResults.collections[collectionName] = {
        exists,
        documentCount: count,
        status: exists ? 'OK' : 'MISSING'
      };
      
      console.log(`${exists ? '✅' : '❌'} ${collectionName}: ${exists ? `${count} documents` : 'MISSING'}`);
    }
    
    // Step 2: Validate Indexes
    console.log('\n📊 Validating indexes...');
    
    const indexValidations = [
      {
        collection: 'customPricing',
        expectedIndexes: ['org_support_item_idx', 'client_specific_idx', 'approval_status_idx', 'effective_dates_idx']
      },
      {
        collection: 'expenses',
        expectedIndexes: ['org_date_idx', 'client_employee_idx', 'category_type_idx', 'approval_status_idx', 'recurring_idx', 'invoice_inclusion_idx']
      },
      {
        collection: 'organizations',
        expectedIndexes: ['org_pricing_state_idx', 'org_subscription_idx']
      },
      {
        collection: 'login',
        expectedIndexes: ['user_org_role_idx', 'user_approval_permissions_idx', 'user_activity_idx']
      },
      {
        collection: 'clients',
        expectedIndexes: ['client_org_status_idx', 'client_ndis_compliance_idx', 'client_pricing_preferences_idx']
      }
    ];
    
    for (const validation of indexValidations) {
      if (validationResults.collections[validation.collection]?.exists) {
        const indexes = await db.collection(validation.collection).indexes();
        const indexNames = indexes.map(idx => idx.name).filter(name => name !== '_id_');
        
        const missingIndexes = validation.expectedIndexes.filter(expected => 
          !indexNames.some(existing => existing.includes(expected.replace('_idx', '')))
        );
        
        validationResults.indexes[validation.collection] = {
          total: indexNames.length,
          expected: validation.expectedIndexes.length,
          missing: missingIndexes,
          status: missingIndexes.length === 0 ? 'OK' : 'INCOMPLETE'
        };
        
        console.log(`${missingIndexes.length === 0 ? '✅' : '⚠️ '} ${validation.collection}: ${indexNames.length} indexes ${missingIndexes.length > 0 ? `(missing: ${missingIndexes.join(', ')})` : ''}`);
      }
    }
    
    // Step 3: Validate Data Quality
    console.log('\n🔍 Validating data quality...');
    
    // Organizations validation
    const orgsWithSettings = await db.collection('organizations').countDocuments({
      'settings.pricing': { $exists: true },
      'settings.expenses': { $exists: true }
    });
    const totalOrgs = validationResults.collections.organizations.documentCount;
    
    validationResults.dataQuality.organizations = {
      withSettings: orgsWithSettings,
      total: totalOrgs,
      percentage: totalOrgs > 0 ? Math.round((orgsWithSettings / totalOrgs) * 100) : 0,
      status: orgsWithSettings === totalOrgs ? 'OK' : 'INCOMPLETE'
    };
    
    // Users validation
    const usersWithPermissions = await db.collection('login').countDocuments({
      permissions: { $exists: true },
      organizationId: { $exists: true }
    });
    const totalUsers = validationResults.collections.login.documentCount;
    
    validationResults.dataQuality.users = {
      withPermissions: usersWithPermissions,
      total: totalUsers,
      percentage: totalUsers > 0 ? Math.round((usersWithPermissions / totalUsers) * 100) : 0,
      status: usersWithPermissions === totalUsers ? 'OK' : 'INCOMPLETE'
    };
    
    // Clients validation
    const clientsWithPricing = await db.collection('clients').countDocuments({
      pricingPreferences: { $exists: true },
      compliance: { $exists: true }
    });
    const totalClients = validationResults.collections.clients.documentCount;
    
    validationResults.dataQuality.clients = {
      withPricingPreferences: clientsWithPricing,
      total: totalClients,
      percentage: totalClients > 0 ? Math.round((clientsWithPricing / totalClients) * 100) : 0,
      status: clientsWithPricing === totalClients ? 'OK' : 'INCOMPLETE'
    };
    
    // Line items validation
    const lineItemsWithMetadata = await db.collection('lineItems').countDocuments({
      pricingMetadata: { $exists: true },
      ndisCompliance: { $exists: true }
    });
    const totalLineItems = validationResults.collections.lineItems.documentCount;
    
    validationResults.dataQuality.lineItems = {
      withMetadata: lineItemsWithMetadata,
      total: totalLineItems,
      percentage: totalLineItems > 0 ? Math.round((lineItemsWithMetadata / totalLineItems) * 100) : 0,
      status: lineItemsWithMetadata === totalLineItems ? 'OK' : 'INCOMPLETE'
    };
    
    console.log(`✅ Organizations with settings: ${orgsWithSettings}/${totalOrgs} (${validationResults.dataQuality.organizations.percentage}%)`);
    console.log(`✅ Users with permissions: ${usersWithPermissions}/${totalUsers} (${validationResults.dataQuality.users.percentage}%)`);
    console.log(`✅ Clients with pricing preferences: ${clientsWithPricing}/${totalClients} (${validationResults.dataQuality.clients.percentage}%)`);
    console.log(`✅ Line items with metadata: ${lineItemsWithMetadata}/${totalLineItems} (${validationResults.dataQuality.lineItems.percentage}%)`);
    
    // Step 4: Validate NDIS Compliance
    console.log('\n🏥 Validating NDIS compliance...');
    
    const ndisItems = await db.collection('ndis').countDocuments();
    const ndisItemsWithValidation = await db.collection('ndis').countDocuments({
      pricingValidation: { $exists: true }
    });
    
    const ndisClients = await db.collection('clients').countDocuments({
      'compliance.requiresNdisCompliance': true
    });
    
    const ndisCompliantLineItems = await db.collection('lineItems').countDocuments({
      'ndisCompliance.isNdisCompliant': true
    });
    
    validationResults.compliance.ndis = {
      supportItems: ndisItems,
      supportItemsWithValidation: ndisItemsWithValidation,
      ndisClients: ndisClients,
      compliantLineItems: ndisCompliantLineItems,
      validationPercentage: ndisItems > 0 ? Math.round((ndisItemsWithValidation / ndisItems) * 100) : 0,
      status: ndisItemsWithValidation === ndisItems ? 'OK' : 'INCOMPLETE'
    };
    
    console.log(`✅ NDIS support items: ${ndisItems}`);
    console.log(`✅ Support items with validation: ${ndisItemsWithValidation}/${ndisItems} (${validationResults.compliance.ndis.validationPercentage}%)`);
    console.log(`✅ NDIS clients identified: ${ndisClients}`);
    console.log(`✅ NDIS compliant line items: ${ndisCompliantLineItems}`);
    
    // Step 5: Performance Validation
    console.log('\n⚡ Validating performance...');
    
    const performanceTests = [
      {
        name: 'Custom Pricing Query',
        query: () => db.collection('customPricing').findOne({ organizationId: 'default_org_001' })
      },
      {
        name: 'Expense Query',
        query: () => db.collection('expenses').findOne({ organizationId: 'default_org_001' })
      },
      {
        name: 'Client Pricing Query',
        query: () => db.collection('clients').findOne({ 'pricingPreferences.customPricingEnabled': true })
      },
      {
        name: 'Line Item Metadata Query',
        query: () => db.collection('lineItems').findOne({ 'pricingMetadata.pricingSource': 'legacy' })
      }
    ];
    
    for (const test of performanceTests) {
      const startTime = Date.now();
      await test.query();
      const endTime = Date.now();
      const duration = endTime - startTime;
      
      validationResults.performance[test.name] = {
        duration,
        status: duration < 100 ? 'EXCELLENT' : duration < 500 ? 'GOOD' : duration < 1000 ? 'ACCEPTABLE' : 'POOR'
      };
      
      const statusIcon = duration < 100 ? '🚀' : duration < 500 ? '✅' : duration < 1000 ? '⚠️' : '❌';
      console.log(`${statusIcon} ${test.name}: ${duration}ms`);
    }
    
    // Step 6: System Readiness Assessment
    console.log('\n🎯 Assessing system readiness...');
    
    const readinessChecks = {
      collectionsReady: Object.values(validationResults.collections).every(c => c.status === 'OK'),
      indexesReady: Object.values(validationResults.indexes).every(i => i.status === 'OK'),
      dataQualityGood: Object.values(validationResults.dataQuality).every(d => d.percentage >= 90),
      complianceReady: validationResults.compliance.ndis.status === 'OK',
      performanceGood: Object.values(validationResults.performance).every(p => p.status !== 'POOR')
    };
    
    const readinessScore = Object.values(readinessChecks).filter(Boolean).length;
    const totalChecks = Object.keys(readinessChecks).length;
    const readinessPercentage = Math.round((readinessScore / totalChecks) * 100);
    
    validationResults.readiness = {
      score: readinessScore,
      total: totalChecks,
      percentage: readinessPercentage,
      checks: readinessChecks,
      status: readinessPercentage >= 90 ? 'READY' : readinessPercentage >= 70 ? 'MOSTLY_READY' : 'NOT_READY'
    };
    
    console.log(`\n📊 System Readiness: ${readinessScore}/${totalChecks} (${readinessPercentage}%)`);
    Object.entries(readinessChecks).forEach(([check, passed]) => {
      console.log(`${passed ? '✅' : '❌'} ${check}`);
    });
    
    // Step 7: Generate Recommendations
    console.log('\n💡 Recommendations:');
    
    const recommendations = [];
    
    if (!readinessChecks.collectionsReady) {
      recommendations.push('Run missing collection creation scripts');
    }
    
    if (!readinessChecks.indexesReady) {
      recommendations.push('Create missing database indexes for optimal performance');
    }
    
    if (!readinessChecks.dataQualityGood) {
      recommendations.push('Re-run data migration scripts to enhance remaining records');
    }
    
    if (!readinessChecks.complianceReady) {
      recommendations.push('Complete NDIS data migration and validation');
    }
    
    if (!readinessChecks.performanceGood) {
      recommendations.push('Optimize database queries and consider additional indexing');
    }
    
    if (recommendations.length === 0) {
      console.log('🎉 No recommendations - system is ready for production!');
    } else {
      recommendations.forEach((rec, index) => {
        console.log(`${index + 1}. ${rec}`);
      });
    }
    
    // Step 8: Generate Summary Report
    console.log('\n📋 Migration Validation Summary:');
    console.log('=' .repeat(50));
    console.log(`Overall Status: ${validationResults.readiness.status}`);
    console.log(`Readiness Score: ${readinessPercentage}%`);
    console.log('');
    console.log('Collection Status:');
    Object.entries(validationResults.collections).forEach(([name, data]) => {
      console.log(`  ${name}: ${data.status} (${data.documentCount} documents)`);
    });
    console.log('');
    console.log('Data Quality:');
    Object.entries(validationResults.dataQuality).forEach(([name, data]) => {
      console.log(`  ${name}: ${data.percentage}% enhanced`);
    });
    console.log('');
    console.log('NDIS Compliance:');
    console.log(`  Support Items: ${validationResults.compliance.ndis.supportItems}`);
    console.log(`  Validation Coverage: ${validationResults.compliance.ndis.validationPercentage}%`);
    console.log(`  NDIS Clients: ${validationResults.compliance.ndis.ndisClients}`);
    console.log('');
    console.log('Performance:');
    Object.entries(validationResults.performance).forEach(([name, data]) => {
      console.log(`  ${name}: ${data.duration}ms (${data.status})`);
    });
    
    return validationResults;
    
  } catch (error) {
    console.error('Error during migration validation:', error);
    throw error;
  } finally {
    await client.close();
    console.log('\nMongoDB connection closed');
  }
}

// Run validation if this file is executed directly
if (require.main === module) {
  validateMigration()
    .then((results) => {
      const isReady = results.readiness.status === 'READY';
      console.log(`\n${isReady ? '🎉' : '⚠️'} Migration validation ${isReady ? 'completed successfully' : 'completed with issues'}`);
      process.exit(isReady ? 0 : 1);
    })
    .catch((error) => {
      console.error('\n❌ Migration validation failed:', error);
      process.exit(1);
    });
}

module.exports = { validateMigration };