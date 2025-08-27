const { MongoClient } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });

/**
 * Migration script to enhance user and organization data for the enhanced pricing system
 * This script adds necessary fields and structures for multi-tenant pricing and expense management
 */

async function migrateUserOrganizationData() {
  const client = new MongoClient(process.env.MONGODB_URI);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    console.log('🔄 Starting user and organization data migration...');
    
    // Step 1: Migrate Organizations
    console.log('\n🏢 Migrating organization data...');
    
    const organizationsCollection = db.collection('organizations');
    const organizationCount = await organizationsCollection.countDocuments();
    
    console.log(`Found ${organizationCount} organizations`);
    
    if (organizationCount === 0) {
      console.log('⚠️  No organizations found, creating default organization...');
      
      const defaultOrg = {
        _id: 'default_org_001',
        name: 'Default Organization',
        code: 'DEFAULT',
        ownerEmail: 'admin@default.com',
        settings: {
          pricing: {
            defaultState: 'NSW',
            defaultProviderType: 'standard',
            autoApprovalThreshold: 1000,
            requiresApprovalAbove: 5000,
            allowClientSpecificPricing: true,
            allowCustomCategories: true
          },
          expenses: {
            defaultCurrency: 'AUD',
            requireReceipts: true,
            autoIncludeInInvoices: false,
            approvalRequired: true,
            maxExpenseAmount: 10000
          },
          invoicing: {
            defaultPaymentTerms: 30,
            includeExpensesInInvoices: true,
            autoGenerateInvoiceNumbers: true,
            invoicePrefix: 'INV'
          }
        },
        features: {
          customPricing: true,
          expenseManagement: true,
          recurringExpenses: true,
          auditTrail: true,
          bulkOperations: true
        },
        subscription: {
          plan: 'enterprise',
          status: 'active',
          startDate: new Date(),
          endDate: new Date('2025-12-31T23:59:59Z')
        },
        createdAt: new Date(),
        updatedAt: new Date(),
        isActive: true
      };
      
      await organizationsCollection.insertOne(defaultOrg);
      console.log('✅ Created default organization');
    } else {
      // Enhance existing organizations
      let enhancedOrgCount = 0;
      
      const orgCursor = organizationsCollection.find({});
      
      while (await orgCursor.hasNext()) {
        const org = await orgCursor.next();
        
        const updates = {};
        let needsUpdate = false;
        
        // Add pricing settings if missing
        if (!org.settings?.pricing) {
          updates['settings.pricing'] = {
            defaultState: 'NSW',
            defaultProviderType: 'standard',
            autoApprovalThreshold: 1000,
            requiresApprovalAbove: 5000,
            allowClientSpecificPricing: true,
            allowCustomCategories: true
          };
          needsUpdate = true;
        }
        
        // Add expense settings if missing
        if (!org.settings?.expenses) {
          updates['settings.expenses'] = {
            defaultCurrency: 'AUD',
            requireReceipts: true,
            autoIncludeInInvoices: false,
            approvalRequired: true,
            maxExpenseAmount: 10000
          };
          needsUpdate = true;
        }
        
        // Add invoicing settings if missing
        if (!org.settings?.invoicing) {
          updates['settings.invoicing'] = {
            defaultPaymentTerms: 30,
            includeExpensesInInvoices: true,
            autoGenerateInvoiceNumbers: true,
            invoicePrefix: org.code || 'INV'
          };
          needsUpdate = true;
        }
        
        // Add features if missing
        if (!org.features) {
          updates.features = {
            customPricing: true,
            expenseManagement: true,
            recurringExpenses: true,
            auditTrail: true,
            bulkOperations: true
          };
          needsUpdate = true;
        }
        
        // Add subscription info if missing
        if (!org.subscription) {
          updates.subscription = {
            plan: 'standard',
            status: 'active',
            startDate: org.createdAt || new Date(),
            endDate: new Date('2025-12-31T23:59:59Z')
          };
          needsUpdate = true;
        }
        
        // Add timestamps if missing
        if (!org.createdAt) {
          updates.createdAt = new Date();
          needsUpdate = true;
        }
        
        if (!org.updatedAt) {
          updates.updatedAt = new Date();
          needsUpdate = true;
        }
        
        if (!org.hasOwnProperty('isActive')) {
          updates.isActive = true;
          needsUpdate = true;
        }
        
        if (needsUpdate) {
          updates.migrationEnhanced = {
            enhancedAt: new Date(),
            enhancedBy: 'user_org_migration_script',
            version: '1.0'
          };
          
          await organizationsCollection.updateOne(
            { _id: org._id },
            { $set: updates }
          );
          
          enhancedOrgCount++;
        }
      }
      
      console.log(`✅ Enhanced ${enhancedOrgCount} organizations`);
    }
    
    // Step 2: Migrate Users
    console.log('\n👥 Migrating user data...');
    
    const usersCollection = db.collection('login'); // Main user collection
    const userCount = await usersCollection.countDocuments();
    
    console.log(`Found ${userCount} users`);
    
    let enhancedUserCount = 0;
    let errorUserCount = 0;
    
    if (userCount > 0) {
      const userCursor = usersCollection.find({});
      
      while (await userCursor.hasNext()) {
        const user = await userCursor.next();
        
        try {
          const updates = {};
          let needsUpdate = false;
          
          // Ensure organizationId exists
          if (!user.organizationId) {
            updates.organizationId = 'default_org_001';
            needsUpdate = true;
          }
          
          // Add user permissions for pricing and expenses
          if (!user.permissions) {
            const defaultPermissions = {
              pricing: {
                canView: true,
                canCreate: user.role === 'admin' || user.role === 'manager',
                canEdit: user.role === 'admin' || user.role === 'manager',
                canDelete: user.role === 'admin',
                canApprove: user.role === 'admin' || user.role === 'manager',
                maxApprovalAmount: user.role === 'admin' ? 50000 : 10000
              },
              expenses: {
                canView: true,
                canCreate: true,
                canEdit: user.role === 'admin' || user.role === 'manager',
                canDelete: user.role === 'admin',
                canApprove: user.role === 'admin' || user.role === 'manager',
                maxExpenseAmount: user.role === 'admin' ? 10000 : 1000
              },
              invoicing: {
                canGenerate: true,
                canView: true,
                canEdit: user.role === 'admin' || user.role === 'manager',
                canSend: user.role === 'admin' || user.role === 'manager'
              },
              admin: {
                canManageUsers: user.role === 'admin',
                canManageOrganization: user.role === 'admin',
                canViewAuditTrail: user.role === 'admin' || user.role === 'manager',
                canExportData: user.role === 'admin' || user.role === 'manager'
              }
            };
            
            updates.permissions = defaultPermissions;
            needsUpdate = true;
          }
          
          // Add user preferences
          if (!user.preferences) {
            updates.preferences = {
              defaultState: 'NSW',
              defaultCurrency: 'AUD',
              dateFormat: 'DD/MM/YYYY',
              timeFormat: '24h',
              notifications: {
                email: true,
                expenseApprovals: true,
                pricingChanges: user.role === 'admin' || user.role === 'manager',
                invoiceGeneration: true
              },
              dashboard: {
                showPendingApprovals: true,
                showRecentExpenses: true,
                showPricingAlerts: user.role === 'admin' || user.role === 'manager'
              }
            };
            needsUpdate = true;
          }
          
          // Add activity tracking
          if (!user.activity) {
            updates.activity = {
              lastLogin: user.lastLoginAt || new Date(),
              loginCount: 0,
              lastPricingAction: null,
              lastExpenseAction: null,
              lastInvoiceGenerated: null
            };
            needsUpdate = true;
          }
          
          // Add security settings
          if (!user.security) {
            updates.security = {
              twoFactorEnabled: false,
              passwordLastChanged: new Date(),
              accountLocked: false,
              failedLoginAttempts: 0,
              lastPasswordReset: null
            };
            needsUpdate = true;
          }
          
          // Ensure proper role assignment
          if (!user.role) {
            updates.role = 'employee'; // Default role
            needsUpdate = true;
          }
          
          // Add timestamps if missing
          if (!user.createdAt) {
            updates.createdAt = new Date();
            needsUpdate = true;
          }
          
          if (!user.updatedAt) {
            updates.updatedAt = new Date();
            needsUpdate = true;
          }
          
          if (!user.hasOwnProperty('isActive')) {
            updates.isActive = true;
            needsUpdate = true;
          }
          
          if (needsUpdate) {
            updates.migrationEnhanced = {
              enhancedAt: new Date(),
              enhancedBy: 'user_org_migration_script',
              version: '1.0'
            };
            
            await usersCollection.updateOne(
              { _id: user._id },
              { $set: updates }
            );
            
            enhancedUserCount++;
            
            if (enhancedUserCount % 50 === 0) {
              console.log(`Enhanced ${enhancedUserCount} users...`);
            }
          }
          
        } catch (error) {
          console.error(`❌ Error enhancing user ${user.email}:`, error.message);
          errorUserCount++;
        }
      }
    }
    
    // Step 3: Create indexes for enhanced user and organization data
    console.log('\n📋 Creating indexes for enhanced data...');
    
    const indexesToCreate = [
      {
        collection: 'organizations',
        keys: { 'settings.pricing.defaultState': 1, isActive: 1 },
        options: { name: 'org_pricing_state_idx' }
      },
      {
        collection: 'organizations',
        keys: { 'subscription.status': 1, 'subscription.endDate': 1 },
        options: { name: 'org_subscription_idx' }
      },
      {
        collection: 'login',
        keys: { organizationId: 1, role: 1, isActive: 1 },
        options: { name: 'user_org_role_idx' }
      },
      {
        collection: 'login',
        keys: { 'permissions.pricing.canApprove': 1, 'permissions.expenses.canApprove': 1 },
        options: { name: 'user_approval_permissions_idx' }
      },
      {
        collection: 'login',
        keys: { 'activity.lastLogin': -1, isActive: 1 },
        options: { name: 'user_activity_idx' }
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
    console.log('\n📈 User & Organization Migration Summary:');
    console.log(`- Organizations processed: ${organizationCount}`);
    console.log(`- Users processed: ${userCount}`);
    console.log(`- Users enhanced: ${enhancedUserCount}`);
    console.log(`- User errors: ${errorUserCount}`);
    console.log(`- Indexes created: ${indexCount}`);
    
    // Step 5: Verify migration results
    const enhancedOrgs = await organizationsCollection.countDocuments({
      'migrationEnhanced.enhancedBy': 'user_org_migration_script'
    });
    
    const enhancedUsers = await usersCollection.countDocuments({
      'migrationEnhanced.enhancedBy': 'user_org_migration_script'
    });
    
    const usersWithPermissions = await usersCollection.countDocuments({
      permissions: { $exists: true }
    });
    
    console.log('\n🔍 Verification:');
    console.log(`- Organizations enhanced by migration: ${enhancedOrgs}`);
    console.log(`- Users enhanced by migration: ${enhancedUsers}`);
    console.log(`- Users with permissions: ${usersWithPermissions}`);
    
    // Sample enhanced data
    if (enhancedUsers > 0) {
      console.log('\n📋 Sample enhanced user:');
      const sampleUser = await usersCollection.findOne({
        'migrationEnhanced.enhancedBy': 'user_org_migration_script'
      });
      
      if (sampleUser) {
        console.log(JSON.stringify({
          email: sampleUser.email,
          role: sampleUser.role,
          organizationId: sampleUser.organizationId,
          permissions: sampleUser.permissions ? 'Present' : 'Missing',
          preferences: sampleUser.preferences ? 'Present' : 'Missing'
        }, null, 2));
      }
    }
    
  } catch (error) {
    console.error('Error during user/organization migration:', error);
    throw error;
  } finally {
    await client.close();
    console.log('\nMongoDB connection closed');
  }
}

// Run the migration if this file is executed directly
if (require.main === module) {
  migrateUserOrganizationData()
    .then(() => {
      console.log('\n✅ User and organization migration completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ User/organization migration failed:', error);
      process.exit(1);
    });
}

module.exports = { migrateUserOrganizationData };