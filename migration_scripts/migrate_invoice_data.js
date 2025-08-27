const { MongoClient } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

/**
 * Migration script to enhance historical invoice data for the enhanced pricing system
 * This script updates existing invoices to be compatible with new pricing and expense structures
 */

async function migrateInvoiceData() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    console.log('🔄 Starting invoice data migration...');
    
    // Step 1: Migrate Line Items Collection
    console.log('\n📋 Migrating line items...');
    
    const lineItemsCollection = db.collection('lineItems');
    const lineItemCount = await lineItemsCollection.countDocuments();
    
    console.log(`Found ${lineItemCount} line items`);
    
    let enhancedLineItemCount = 0;
    let errorLineItemCount = 0;
    
    if (lineItemCount > 0) {
      const lineItemCursor = lineItemsCollection.find({});
      
      while (await lineItemCursor.hasNext()) {
        const lineItem = await lineItemCursor.next();
        
        try {
          const updates = {};
          let needsUpdate = false;
          
          // Ensure organizationId exists
          if (!lineItem.organizationId) {
            updates.organizationId = 'default_org_001';
            needsUpdate = true;
          }
          
          // Add pricing metadata
          if (!lineItem.pricingMetadata) {
            updates.pricingMetadata = {
              pricingSource: 'legacy', // legacy, custom, standard, override
              originalPrice: lineItem.price || 0,
              appliedMultiplier: 1.0,
              customPricingApplied: false,
              pricingRuleId: null,
              priceCalculationMethod: 'manual',
              discountApplied: 0,
              priceOverrideReason: '',
              approvedBy: null,
              approvalDate: null
            };
            needsUpdate = true;
          }
          
          // Add NDIS compliance information
          if (!lineItem.ndisCompliance) {
            updates.ndisCompliance = {
              isNdisCompliant: lineItem.supportItemNumber ? true : false,
              supportItemNumber: lineItem.supportItemNumber || null,
              supportItemName: lineItem.supportItemName || lineItem.description,
              registrationGroup: null,
              supportCategory: null,
              priceLimitApplied: false,
              quotaManaged: false,
              unitOfSupport: lineItem.unit || 'hour',
              validationStatus: 'pending',
              validationErrors: []
            };
            needsUpdate = true;
          }
          
          // Add service delivery information
          if (!lineItem.serviceDelivery) {
            updates.serviceDelivery = {
              serviceDate: lineItem.date || new Date(),
              serviceStartTime: null,
              serviceEndTime: null,
              actualDuration: lineItem.quantity || 0,
              scheduledDuration: lineItem.quantity || 0,
              serviceLocation: 'client_home',
              serviceType: 'direct_support',
              serviceNotes: lineItem.notes || '',
              attendanceConfirmed: false,
              qualityAssurance: {
                reviewed: false,
                reviewedBy: null,
                reviewDate: null,
                qualityScore: null,
                issues: []
              }
            };
            needsUpdate = true;
          }
          
          // Add financial tracking
          if (!lineItem.financialTracking) {
            const totalAmount = (lineItem.price || 0) * (lineItem.quantity || 0);
            updates.financialTracking = {
              unitPrice: lineItem.price || 0,
              quantity: lineItem.quantity || 0,
              subtotal: totalAmount,
              taxAmount: 0,
              totalAmount: totalAmount,
              currency: 'AUD',
              exchangeRate: 1.0,
              costCenter: '',
              projectCode: '',
              budgetCode: '',
              invoiceStatus: 'generated',
              paymentStatus: 'pending'
            };
            needsUpdate = true;
          }
          
          // Add audit trail
          if (!lineItem.auditTrail) {
            updates.auditTrail = {
              createdAt: lineItem.createdAt || new Date(),
              createdBy: lineItem.employeeId || 'system',
              lastModifiedAt: lineItem.updatedAt || new Date(),
              lastModifiedBy: 'migration_script',
              modifications: [],
              approvalHistory: [],
              migrationNotes: 'Enhanced during invoice data migration'
            };
            needsUpdate = true;
          }
          
          // Add data quality indicators
          if (!lineItem.dataQuality) {
            const missingFields = [];
            if (!lineItem.supportItemNumber) missingFields.push('supportItemNumber');
            if (!lineItem.clientId) missingFields.push('clientId');
            if (!lineItem.employeeId) missingFields.push('employeeId');
            
            updates.dataQuality = {
              completenessScore: Math.max(0, 100 - (missingFields.length * 20)),
              missingFields: missingFields,
              validationErrors: [],
              dataSource: 'legacy_migration',
              lastValidated: new Date(),
              requiresReview: missingFields.length > 0
            };
            needsUpdate = true;
          }
          
          // Ensure proper timestamps
          if (!lineItem.createdAt) {
            updates.createdAt = new Date();
            needsUpdate = true;
          }
          
          if (!lineItem.updatedAt) {
            updates.updatedAt = new Date();
            needsUpdate = true;
          }
          
          if (needsUpdate) {
            updates.migrationEnhanced = {
              enhancedAt: new Date(),
              enhancedBy: 'invoice_migration_script',
              version: '1.0',
              fieldsAdded: Object.keys(updates).filter(key => key !== 'migrationEnhanced')
            };
            
            await lineItemsCollection.updateOne(
              { _id: lineItem._id },
              { $set: updates }
            );
            
            enhancedLineItemCount++;
            
            if (enhancedLineItemCount % 100 === 0) {
              console.log(`Enhanced ${enhancedLineItemCount} line items...`);
            }
          }
          
        } catch (error) {
          console.error(`❌ Error enhancing line item ${lineItem._id}:`, error.message);
          errorLineItemCount++;
        }
      }
    }
    
    // Step 2: Create or enhance invoices collection
    console.log('\n🧾 Processing invoices collection...');
    
    const invoicesCollection = db.collection('invoices');
    let invoiceCount = 0;
    
    try {
      invoiceCount = await invoicesCollection.countDocuments();
      console.log(`Found ${invoiceCount} existing invoices`);
    } catch (error) {
      console.log('Invoices collection does not exist, will be created when needed');
    }
    
    let enhancedInvoiceCount = 0;
    
    if (invoiceCount > 0) {
      const invoiceCursor = invoicesCollection.find({});
      
      while (await invoiceCursor.hasNext()) {
        const invoice = await invoiceCursor.next();
        
        try {
          const updates = {};
          let needsUpdate = false;
          
          // Ensure organizationId exists
          if (!invoice.organizationId) {
            updates.organizationId = 'default_org_001';
            needsUpdate = true;
          }
          
          // Add invoice metadata
          if (!invoice.metadata) {
            updates.metadata = {
              invoiceType: 'service', // service, expense, mixed
              generationMethod: 'manual', // manual, automatic, scheduled
              templateUsed: 'standard',
              customizations: [],
              tags: [],
              category: 'support_services',
              priority: 'normal',
              internalNotes: ''
            };
            needsUpdate = true;
          }
          
          // Add financial summary
          if (!invoice.financialSummary) {
            const lineItems = invoice.lineItems || [];
            const subtotal = lineItems.reduce((sum, item) => sum + ((item.price || 0) * (item.quantity || 0)), 0);
            
            updates.financialSummary = {
              subtotal: subtotal,
              taxAmount: 0,
              discountAmount: 0,
              expenseAmount: 0,
              totalAmount: subtotal,
              currency: 'AUD',
              exchangeRate: 1.0,
              paymentTerms: 30,
              dueDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000) // 30 days from now
            };
            needsUpdate = true;
          }
          
          // Add compliance tracking
          if (!invoice.compliance) {
            updates.compliance = {
              ndisCompliant: true,
              validationPassed: false,
              validationErrors: [],
              auditRequired: false,
              complianceNotes: '',
              lastComplianceCheck: new Date(),
              complianceOfficer: null
            };
            needsUpdate = true;
          }
          
          // Add delivery information
          if (!invoice.delivery) {
            updates.delivery = {
              method: 'email', // email, postal, portal, api
              status: 'pending', // pending, sent, delivered, failed
              sentDate: null,
              deliveredDate: null,
              recipientEmail: invoice.clientEmail || '',
              deliveryAttempts: 0,
              lastAttemptDate: null,
              deliveryNotes: ''
            };
            needsUpdate = true;
          }
          
          // Add payment tracking
          if (!invoice.payment) {
            updates.payment = {
              status: 'pending', // pending, partial, paid, overdue, cancelled
              method: null, // bank_transfer, credit_card, cash, cheque
              paidAmount: 0,
              paidDate: null,
              transactionReference: '',
              paymentNotes: '',
              remindersSent: 0,
              lastReminderDate: null,
              writeOffAmount: 0,
              writeOffReason: ''
            };
            needsUpdate = true;
          }
          
          // Add workflow status
          if (!invoice.workflow) {
            updates.workflow = {
              status: 'generated', // draft, pending_approval, approved, generated, sent, paid, cancelled
              approvalRequired: false,
              approvedBy: null,
              approvalDate: null,
              rejectionReason: '',
              workflowNotes: '',
              currentStep: 'completed',
              nextAction: 'send_to_client'
            };
            needsUpdate = true;
          }
          
          if (needsUpdate) {
            updates.migrationEnhanced = {
              enhancedAt: new Date(),
              enhancedBy: 'invoice_migration_script',
              version: '1.0'
            };
            
            await invoicesCollection.updateOne(
              { _id: invoice._id },
              { $set: updates }
            );
            
            enhancedInvoiceCount++;
          }
          
        } catch (error) {
          console.error(`❌ Error enhancing invoice ${invoice._id}:`, error.message);
        }
      }
    }
    
    // Step 3: Create indexes for enhanced invoice data
    console.log('\n📋 Creating indexes for enhanced invoice data...');
    
    const indexesToCreate = [
      {
        collection: 'lineItems',
        keys: { organizationId: 1, clientId: 1, 'serviceDelivery.serviceDate': -1 },
        options: { name: 'lineitem_org_client_date_idx' }
      },
      {
        collection: 'lineItems',
        keys: { 'ndisCompliance.supportItemNumber': 1, 'ndisCompliance.isNdisCompliant': 1 },
        options: { name: 'lineitem_ndis_compliance_idx' }
      },
      {
        collection: 'lineItems',
        keys: { 'pricingMetadata.pricingSource': 1, 'pricingMetadata.customPricingApplied': 1 },
        options: { name: 'lineitem_pricing_metadata_idx' }
      },
      {
        collection: 'lineItems',
        keys: { 'financialTracking.invoiceStatus': 1, 'financialTracking.paymentStatus': 1 },
        options: { name: 'lineitem_financial_status_idx' }
      },
      {
        collection: 'lineItems',
        keys: { 'dataQuality.requiresReview': 1, 'dataQuality.completenessScore': 1 },
        options: { name: 'lineitem_data_quality_idx' }
      },
      {
        collection: 'invoices',
        keys: { organizationId: 1, clientId: 1, 'workflow.status': 1, createdAt: -1 },
        options: { name: 'invoice_org_client_status_idx' }
      },
      {
        collection: 'invoices',
        keys: { 'payment.status': 1, 'financialSummary.dueDate': 1 },
        options: { name: 'invoice_payment_due_idx' }
      },
      {
        collection: 'invoices',
        keys: { 'delivery.status': 1, 'delivery.method': 1, 'delivery.sentDate': -1 },
        options: { name: 'invoice_delivery_idx' }
      },
      {
        collection: 'invoices',
        keys: { 'compliance.ndisCompliant': 1, 'compliance.validationPassed': 1 },
        options: { name: 'invoice_compliance_idx' }
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
    
    // Step 4: Data quality analysis
    console.log('\n🔍 Performing data quality analysis...');
    
    const qualityMetrics = {
      lineItemsWithMissingClients: await lineItemsCollection.countDocuments({ clientId: { $exists: false } }),
      lineItemsWithMissingEmployees: await lineItemsCollection.countDocuments({ employeeId: { $exists: false } }),
      lineItemsWithMissingSupportItems: await lineItemsCollection.countDocuments({ supportItemNumber: { $exists: false } }),
      lineItemsWithZeroPrice: await lineItemsCollection.countDocuments({ price: { $lte: 0 } }),
      lineItemsRequiringReview: await lineItemsCollection.countDocuments({ 'dataQuality.requiresReview': true })
    };
    
    console.log('Data Quality Metrics:');
    Object.entries(qualityMetrics).forEach(([metric, count]) => {
      console.log(`- ${metric}: ${count}`);
    });
    
    // Step 5: Generate migration report
    console.log('\n📈 Invoice Data Migration Summary:');
    console.log(`- Line items processed: ${lineItemCount}`);
    console.log(`- Line items enhanced: ${enhancedLineItemCount}`);
    console.log(`- Line item errors: ${errorLineItemCount}`);
    console.log(`- Invoices processed: ${invoiceCount}`);
    console.log(`- Invoices enhanced: ${enhancedInvoiceCount}`);
    console.log(`- Indexes created: ${indexCount}`);
    
    // Step 6: Verify migration results
    const enhancedLineItems = await lineItemsCollection.countDocuments({
      'migrationEnhanced.enhancedBy': 'invoice_migration_script'
    });
    
    const lineItemsWithPricing = await lineItemsCollection.countDocuments({
      pricingMetadata: { $exists: true }
    });
    
    const lineItemsWithCompliance = await lineItemsCollection.countDocuments({
      ndisCompliance: { $exists: true }
    });
    
    const ndisCompliantItems = await lineItemsCollection.countDocuments({
      'ndisCompliance.isNdisCompliant': true
    });
    
    console.log('\n🔍 Verification:');
    console.log(`- Line items enhanced by migration: ${enhancedLineItems}`);
    console.log(`- Line items with pricing metadata: ${lineItemsWithPricing}`);
    console.log(`- Line items with compliance data: ${lineItemsWithCompliance}`);
    console.log(`- NDIS compliant line items: ${ndisCompliantItems}`);
    
    // Sample enhanced data
    if (enhancedLineItems > 0) {
      console.log('\n📋 Sample enhanced line item:');
      const sampleLineItem = await lineItemsCollection.findOne({
        'migrationEnhanced.enhancedBy': 'invoice_migration_script'
      });
      
      if (sampleLineItem) {
        console.log(JSON.stringify({
          id: sampleLineItem._id,
          organizationId: sampleLineItem.organizationId,
          pricingSource: sampleLineItem.pricingMetadata?.pricingSource,
          ndisCompliant: sampleLineItem.ndisCompliance?.isNdisCompliant,
          completenessScore: sampleLineItem.dataQuality?.completenessScore,
          enhancedFields: sampleLineItem.migrationEnhanced?.fieldsAdded?.length || 0
        }, null, 2));
      }
    }
    
  } catch (error) {
    console.error('Error during invoice migration:', error);
    throw error;
  } finally {
    await client.close();
    console.log('\nMongoDB connection closed');
  }
}

// Run the migration if this file is executed directly
if (require.main === module) {
  migrateInvoiceData()
    .then(() => {
      console.log('\n✅ Invoice data migration completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Invoice migration failed:', error);
      process.exit(1);
    });
}

module.exports = { migrateInvoiceData };