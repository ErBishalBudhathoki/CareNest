const { MongoClient } = require('mongodb');
const logger = require('../utils/logger');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

/**
 * Migration script to enhance client data for the enhanced pricing system
 * This script adds necessary fields and structures for client-specific pricing and expense tracking
 */

async function migrateClientData() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    logger.info('🔄 Starting client data migration...');
    
    // Step 1: Migrate Clients Collection
    console.log('\n👥 Migrating client data...');
    
    const clientsCollection = db.collection('clients');
    const clientCount = await clientsCollection.countDocuments();
    
    console.log(`Found ${clientCount} clients`);
    
    let enhancedClientCount = 0;
    let errorClientCount = 0;
    
    if (clientCount > 0) {
      const clientCursor = clientsCollection.find({});
      
      while (await clientCursor.hasNext()) {
        const clientDoc = await clientCursor.next();
        
        try {
          const updates = {};
          let needsUpdate = false;
          
          // Ensure organizationId exists
          if (!clientDoc.organizationId) {
            updates.organizationId = 'default_org_001';
            needsUpdate = true;
          }
          
          // Add pricing preferences
          if (!clientDoc.pricingPreferences) {
            updates.pricingPreferences = {
              preferredState: clientDoc.state || 'NSW',
              preferredProviderType: 'standard',
              customPricingEnabled: true,
              autoApplyCustomPricing: true,
              pricingTier: 'standard', // standard, premium, enterprise
              discountPercentage: 0,
              specialRates: {
                weekendMultiplier: 1.0,
                holidayMultiplier: 1.0,
                afterHoursMultiplier: 1.0
              },
              priceCapOverrides: {
                enabled: false,
                customCaps: {}
              }
            };
            needsUpdate = true;
          }
          
          // Add expense settings
          if (!clientDoc.expenseSettings) {
            updates.expenseSettings = {
              allowExpenseCharges: true,
              requireExpenseApproval: true,
              maxExpensePerItem: 1000,
              maxTotalExpensesPerInvoice: 5000,
              allowedExpenseCategories: [
                'travel',
                'materials',
                'equipment',
                'training',
                'other'
              ],
              autoIncludeInInvoices: false,
              expenseMarkupPercentage: 0,
              requireReceipts: true,
              receiptThreshold: 50 // Require receipts for expenses over $50
            };
            needsUpdate = true;
          }
          
          // Add billing preferences
          if (!clientDoc.billingPreferences) {
            updates.billingPreferences = {
              invoiceFrequency: 'monthly', // weekly, fortnightly, monthly, quarterly
              paymentTerms: 30,
              preferredInvoiceFormat: 'detailed',
              includeExpenseDetails: true,
              includePricingBreakdown: false,
              autoSendInvoices: false,
              invoiceDeliveryMethod: 'email',
              consolidateServices: true,
              separateExpenseInvoices: false
            };
            needsUpdate = true;
          }
          
          // Add compliance and validation settings
          if (!clientDoc.compliance) {
            updates.compliance = {
              ndisParticipant: clientDoc.ndisNumber ? true : false,
              ndisNumber: clientDoc.ndisNumber || null,
              planManaged: false,
              selfManaged: false,
              agencyManaged: true,
              requiresNdisCompliance: clientDoc.ndisNumber ? true : false,
              specialRequirements: [],
              fundingSource: clientDoc.ndisNumber ? 'NDIS' : 'private',
              planExpiryDate: null,
              budgetLimits: {
                enabled: false,
                totalBudget: 0,
                remainingBudget: 0,
                budgetPeriod: 'annual'
              }
            };
            needsUpdate = true;
          }
          
          // Add contact and communication preferences
          if (!clientDoc.communication) {
            updates.communication = {
              primaryContact: {
                name: clientDoc.contactPerson || clientDoc.name,
                email: clientDoc.email,
                phone: clientDoc.phone,
                role: 'primary'
              },
              alternativeContacts: [],
              preferredContactMethod: 'email',
              invoiceContactEmail: clientDoc.email,
              emergencyContact: null,
              communicationNotes: '',
              languagePreference: 'en',
              accessibilityRequirements: []
            };
            needsUpdate = true;
          }
          
          // Add service delivery preferences
          if (!clientDoc.serviceDelivery) {
            updates.serviceDelivery = {
              preferredServiceTimes: {
                weekdays: { start: '09:00', end: '17:00' },
                weekends: { start: '10:00', end: '16:00' },
                holidays: { available: false }
              },
              serviceLocation: {
                type: 'client_home', // client_home, community, center, online
                address: clientDoc.address || '',
                accessInstructions: '',
                parkingAvailable: true,
                publicTransportAccess: true
              },
              specialInstructions: '',
              equipmentRequired: [],
              supportWorkerPreferences: {
                gender: 'no_preference',
                experience: 'any',
                qualifications: [],
                languages: ['en']
              }
            };
            needsUpdate = true;
          }
          
          // Add financial tracking
          if (!clientDoc.financialTracking) {
            updates.financialTracking = {
              totalInvoiced: 0,
              totalPaid: 0,
              outstandingBalance: 0,
              averageInvoiceAmount: 0,
              lastInvoiceDate: null,
              lastPaymentDate: null,
              paymentHistory: [],
              creditLimit: 0,
              paymentMethod: 'bank_transfer',
              accountingReference: clientDoc.clientId || clientDoc._id
            };
            needsUpdate = true;
          }
          
          // Add activity tracking
          if (!clientDoc.activity) {
            updates.activity = {
              firstServiceDate: null,
              lastServiceDate: null,
              totalServicesProvided: 0,
              averageServiceFrequency: 0,
              lastContactDate: new Date(),
              nextScheduledService: null,
              serviceStatus: 'active', // active, inactive, suspended, terminated
              statusReason: '',
              statusChangedDate: new Date()
            };
            needsUpdate = true;
          }
          
          // Add data quality and validation
          if (!clientDoc.dataQuality) {
            updates.dataQuality = {
              completenessScore: 0,
              lastValidated: new Date(),
              validationErrors: [],
              missingFields: [],
              duplicateCheckPassed: true,
              lastUpdatedBy: 'migration_script',
              dataSource: 'legacy_migration'
            };
            needsUpdate = true;
          }
          
          // Ensure proper status and timestamps
          if (!clientDoc.hasOwnProperty('isActive')) {
            updates.isActive = true;
            needsUpdate = true;
          }
          
          if (!clientDoc.createdAt) {
            updates.createdAt = new Date();
            needsUpdate = true;
          }
          
          if (!clientDoc.updatedAt) {
            updates.updatedAt = new Date();
            needsUpdate = true;
          }
          
          // Add migration metadata
          if (needsUpdate) {
            updates.migrationEnhanced = {
              enhancedAt: new Date(),
              enhancedBy: 'client_migration_script',
              version: '1.0',
              fieldsAdded: Object.keys(updates).filter(key => key !== 'migrationEnhanced')
            };
            
            await clientsCollection.updateOne(
              { _id: clientDoc._id },
              { $set: updates }
            );
            
            enhancedClientCount++;
            
            if (enhancedClientCount % 25 === 0) {
              console.log(`Enhanced ${enhancedClientCount} clients...`);
            }
          }
          
        } catch (error) {
          console.error(`❌ Error enhancing client ${clientDoc.name || clientDoc._id}:`, error.message);
          errorClientCount++;
        }
      }
    }
    
    // Step 2: Migrate Client Assignments
    console.log('\n🔗 Migrating client assignments...');
    
    const assignmentsCollection = db.collection('clientAssignments');
    const assignmentCount = await assignmentsCollection.countDocuments();
    
    console.log(`Found ${assignmentCount} client assignments`);
    
    let enhancedAssignmentCount = 0;
    
    if (assignmentCount > 0) {
      const assignmentCursor = assignmentsCollection.find({});
      
      while (await assignmentCursor.hasNext()) {
        const assignment = await assignmentCursor.next();
        
        try {
          const updates = {};
          let needsUpdate = false;
          
          // Ensure organizationId exists
          if (!assignment.organizationId) {
            updates.organizationId = 'default_org_001';
            needsUpdate = true;
          }
          
          // Add assignment-specific pricing
          if (!assignment.pricingOverrides) {
            updates.pricingOverrides = {
              enabled: false,
              customRates: {},
              effectiveFrom: new Date(),
              effectiveTo: null,
              approvedBy: null,
              approvalDate: null,
              reason: ''
            };
            needsUpdate = true;
          }
          
          // Add service delivery details
          if (!assignment.serviceDetails) {
            updates.serviceDetails = {
              serviceType: 'support_work',
              frequency: 'weekly',
              duration: 2, // hours
              startDate: assignment.startDate || new Date(),
              endDate: assignment.endDate || null,
              status: 'active',
              notes: assignment.notes || '',
              specialRequirements: []
            };
            needsUpdate = true;
          }
          
          // Add billing configuration
          if (!assignment.billingConfig) {
            updates.billingConfig = {
              billableToClient: true,
              invoiceFrequency: 'monthly',
              consolidateWithOtherServices: true,
              separateInvoicing: false,
              costCenter: '',
              projectCode: '',
              purchaseOrderNumber: ''
            };
            needsUpdate = true;
          }
          
          // Add timestamps if missing
          if (!assignment.createdAt) {
            updates.createdAt = new Date();
            needsUpdate = true;
          }
          
          if (!assignment.updatedAt) {
            updates.updatedAt = new Date();
            needsUpdate = true;
          }
          
          if (needsUpdate) {
            updates.migrationEnhanced = {
              enhancedAt: new Date(),
              enhancedBy: 'client_migration_script',
              version: '1.0'
            };
            
            await assignmentsCollection.updateOne(
              { _id: assignment._id },
              { $set: updates }
            );
            
            enhancedAssignmentCount++;
          }
          
        } catch (error) {
          console.error(`❌ Error enhancing assignment ${assignment._id}:`, error.message);
        }
      }
    }
    
    // Step 3: Create indexes for enhanced client data
    console.log('\n📋 Creating indexes for enhanced client data...');
    
    const indexesToCreate = [
      {
        collection: 'clients',
        keys: { organizationId: 1, isActive: 1, 'activity.serviceStatus': 1 },
        options: { name: 'client_org_status_idx' }
      },
      {
        collection: 'clients',
        keys: { 'compliance.ndisNumber': 1, 'compliance.requiresNdisCompliance': 1 },
        options: { name: 'client_ndis_compliance_idx' }
      },
      {
        collection: 'clients',
        keys: { 'pricingPreferences.pricingTier': 1, 'pricingPreferences.customPricingEnabled': 1 },
        options: { name: 'client_pricing_preferences_idx' }
      },
      {
        collection: 'clients',
        keys: { 'communication.primaryContact.email': 1, isActive: 1 },
        options: { name: 'client_contact_email_idx' }
      },
      {
        collection: 'clients',
        keys: { 'financialTracking.outstandingBalance': 1, 'financialTracking.lastPaymentDate': -1 },
        options: { name: 'client_financial_tracking_idx' }
      },
      {
        collection: 'clients',
        keys: { 'activity.lastServiceDate': -1, 'activity.serviceStatus': 1 },
        options: { name: 'client_service_activity_idx' }
      },
      {
        collection: 'clientAssignments',
        keys: { organizationId: 1, clientId: 1, employeeId: 1, 'serviceDetails.status': 1 },
        options: { name: 'assignment_org_client_employee_idx' }
      },
      {
        collection: 'clientAssignments',
        keys: { 'serviceDetails.startDate': 1, 'serviceDetails.endDate': 1, 'serviceDetails.status': 1 },
        options: { name: 'assignment_service_dates_idx' }
      },
      {
        collection: 'clientAssignments',
        keys: { 'pricingOverrides.enabled': 1, 'pricingOverrides.effectiveFrom': 1 },
        options: { name: 'assignment_pricing_overrides_idx' }
      }
    ];
    
    let indexCount = 0;
    for (const indexDef of indexesToCreate) {
      try {
        const collection = db.collection(indexDef.collection);
        await collection.createIndex(indexDef.keys, indexDef.options);
        console.log(`✅ Created index: ${indexDef.options.name} on ${indexDef.collection}`);
        indexCount++;
      } catch (error) {
        if (error.code === 85) {
          console.log(`⚠️  Index ${indexDef.options.name} already exists`);
        } else {
          console.error(`❌ Error creating index ${indexDef.options.name}:`, error.message);
        }
      }
    }
    
    // Step 4: Generate migration report
    console.log('\n📈 Client Data Migration Summary:');
    console.log(`- Clients processed: ${clientCount}`);
    console.log(`- Clients enhanced: ${enhancedClientCount}`);
    console.log(`- Client errors: ${errorClientCount}`);
    console.log(`- Assignments processed: ${assignmentCount}`);
    console.log(`- Assignments enhanced: ${enhancedAssignmentCount}`);
    console.log(`- Indexes created: ${indexCount}`);
    
    // Step 5: Verify migration results
    const enhancedClients = await clientsCollection.countDocuments({
      'migrationEnhanced.enhancedBy': 'client_migration_script'
    });
    
    const clientsWithPricing = await clientsCollection.countDocuments({
      pricingPreferences: { $exists: true }
    });
    
    const clientsWithCompliance = await clientsCollection.countDocuments({
      compliance: { $exists: true }
    });
    
    const ndisClients = await clientsCollection.countDocuments({
      'compliance.requiresNdisCompliance': true
    });
    
    console.log('\n🔍 Verification:');
    console.log(`- Clients enhanced by migration: ${enhancedClients}`);
    console.log(`- Clients with pricing preferences: ${clientsWithPricing}`);
    console.log(`- Clients with compliance settings: ${clientsWithCompliance}`);
    console.log(`- NDIS clients identified: ${ndisClients}`);
    
    // Sample enhanced data
    if (enhancedClients > 0) {
      console.log('\n📋 Sample enhanced client:');
      const sampleClient = await clientsCollection.findOne({
        'migrationEnhanced.enhancedBy': 'client_migration_script'
      });
      
      if (sampleClient) {
        console.log(JSON.stringify({
          name: sampleClient.name,
          organizationId: sampleClient.organizationId,
          pricingTier: sampleClient.pricingPreferences?.pricingTier,
          ndisCompliance: sampleClient.compliance?.requiresNdisCompliance,
          serviceStatus: sampleClient.activity?.serviceStatus,
          enhancedFields: sampleClient.migrationEnhanced?.fieldsAdded?.length || 0
        }, null, 2));
      }
    }
    
  } catch (error) {
    console.error('Error during client migration:', error);
    throw error;
  } finally {
    await client.close();
    console.log('\nMongoDB connection closed');
  }
}

// Run the migration if this file is executed directly
if (require.main === module) {
  migrateClientData()
    .then(() => {
      logger.info('\n✅ Client data migration completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      logger.error('\n❌ Client migration failed', {
        error: error.message,
        stack: error.stack
      });
      process.exit(1);
    });
}

module.exports = { migrateClientData };