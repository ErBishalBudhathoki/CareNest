/**
 * Backward Compatibility Service
 * Handles legacy invoice data formats and ensures seamless integration
 * Task 2.7: Implement backward compatibility for existing invoice data
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const uri = process.env.MONGODB_URI;

class BackwardCompatibilityService {
  constructor() {
    this.client = null;
    this.db = null;
  }

  async connect() {
    if (!this.client) {
      this.client = await MongoClient.connect(uri, {
        serverApi: ServerApiVersion.v1
      });
      this.db = this.client.db('Invoice');
    }
  }

  async disconnect() {
    if (this.client) {
      await this.client.close();
      this.client = null;
      this.db = null;
    }
  }

  /**
   * Transform legacy invoice data to new format
   * Handles old invoice structures and converts them to current schema
   */
  async transformLegacyInvoice(legacyInvoice) {
    try {
      const transformedInvoice = {
        ...legacyInvoice,
        // Ensure required fields exist
        organizationId: legacyInvoice.organizationId || 'legacy_org_001',
        version: '2.0', // Mark as transformed
        transformedAt: new Date(),
        legacyFormat: true,
        
        // Transform pricing metadata if missing
        pricingMetadata: legacyInvoice.pricingMetadata || {
          source: 'legacy',
          appliedAt: legacyInvoice.createdAt || new Date(),
          version: '1.0',
          isLegacy: true
        },
        
        // Ensure audit trail exists
        auditTrail: legacyInvoice.auditTrail || {
          createdAt: legacyInvoice.createdAt || new Date(),
          createdBy: legacyInvoice.createdBy || 'legacy_system',
          actions: [{
            action: 'legacy_import',
            timestamp: new Date(),
            user: 'system',
            details: 'Imported from legacy format'
          }]
        }
      };

      // Transform line items if they exist
      if (legacyInvoice.lineItems && Array.isArray(legacyInvoice.lineItems)) {
        transformedInvoice.lineItems = await this.transformLegacyLineItems(legacyInvoice.lineItems);
      }

      return transformedInvoice;
    } catch (error) {
      console.error('Error transforming legacy invoice:', error);
      throw new Error(`Failed to transform legacy invoice: ${error.message}`);
    }
  }

  /**
   * Transform legacy line items to new format
   * Ensures all required fields are present and properly formatted
   */
  async transformLegacyLineItems(legacyLineItems) {
    const transformedItems = [];

    for (const item of legacyLineItems) {
      const transformedItem = {
        ...item,
        // Ensure required fields
        id: item.id || item._id || new ObjectId().toString(),
        ndisItemNumber: item.ndisItemNumber || item.itemNumber || 'LEGACY_ITEM',
        description: item.description || 'Legacy line item',
        quantity: item.quantity || 1,
        unitPrice: item.unitPrice || item.price || 0,
        totalPrice: item.totalPrice || (item.quantity * item.unitPrice) || 0,
        unit: item.unit || 'each',
        
        // Add pricing metadata if missing
        pricingMetadata: item.pricingMetadata || {
          source: 'legacy',
          appliedAt: new Date(),
          version: '1.0',
          isLegacy: true,
          originalPrice: item.unitPrice || item.price || 0
        },
        
        // Mark as legacy
        isLegacy: true,
        transformedAt: new Date()
      };

      // Validate NDIS item number format
      if (transformedItem.ndisItemNumber === 'LEGACY_ITEM') {
        // Try to map legacy item to NDIS format
        const mappedItem = await this.mapLegacyItemToNdis(item);
        if (mappedItem) {
          transformedItem.ndisItemNumber = mappedItem.ndisItemNumber;
          transformedItem.description = mappedItem.description;
        }
      }

      transformedItems.push(transformedItem);
    }

    return transformedItems;
  }

  /**
   * Map legacy item descriptions to NDIS item numbers
   * Uses fuzzy matching to find appropriate NDIS items
   */
  async mapLegacyItemToNdis(legacyItem) {
    try {
      await this.connect();
      
      // Try to find matching NDIS item by description
      const supportItems = await this.db.collection('supportItems').find({
        $or: [
          { 'Support Item Name': { $regex: legacyItem.description, $options: 'i' } },
          { 'Support Item Number': legacyItem.ndisItemNumber || legacyItem.itemNumber }
        ]
      }).limit(1).toArray();

      if (supportItems.length > 0) {
        const supportItem = supportItems[0];
        return {
          ndisItemNumber: supportItem['Support Item Number'],
          description: supportItem['Support Item Name']
        };
      }

      // Default fallback for unmapped items
      return {
        ndisItemNumber: '01_999_0199_1_1', // Generic support item
        description: `Legacy Item: ${legacyItem.description || 'Unknown service'}`
      };
    } catch (error) {
      console.error('Error mapping legacy item to NDIS:', error);
      return null;
    }
  }

  /**
   * Validate legacy invoice data compatibility
   * Checks if legacy data can be safely processed by new system
   */
  async validateLegacyCompatibility(invoiceData) {
    const validation = {
      isCompatible: true,
      issues: [],
      warnings: [],
      recommendations: []
    };

    try {
      // Check for required fields
      if (!invoiceData.userEmail && !invoiceData.employeeEmail) {
        validation.issues.push('Missing user/employee email');
        validation.isCompatible = false;
      }

      if (!invoiceData.clientEmail && !invoiceData.clientId) {
        validation.issues.push('Missing client identification');
        validation.isCompatible = false;
      }

      // Check line items format
      if (invoiceData.lineItems && Array.isArray(invoiceData.lineItems)) {
        for (let i = 0; i < invoiceData.lineItems.length; i++) {
          const item = invoiceData.lineItems[i];
          
          if (!item.description && !item.ndisItemNumber) {
            validation.issues.push(`Line item ${i + 1}: Missing description and NDIS item number`);
            validation.isCompatible = false;
          }
          
          if (!item.quantity || item.quantity <= 0) {
            validation.warnings.push(`Line item ${i + 1}: Invalid or missing quantity`);
          }
          
          if (!item.unitPrice && !item.price) {
            validation.warnings.push(`Line item ${i + 1}: Missing price information`);
          }
        }
      }

      // Check for deprecated fields
      const deprecatedFields = ['oldPricingStructure', 'legacyItemCodes', 'oldClientFormat'];
      deprecatedFields.forEach(field => {
        if (invoiceData[field]) {
          validation.warnings.push(`Deprecated field detected: ${field}`);
          validation.recommendations.push(`Consider migrating data from ${field} to new format`);
        }
      });

      // Check date formats
      if (invoiceData.startDate && isNaN(new Date(invoiceData.startDate))) {
        validation.issues.push('Invalid start date format');
        validation.isCompatible = false;
      }

      if (invoiceData.endDate && isNaN(new Date(invoiceData.endDate))) {
        validation.issues.push('Invalid end date format');
        validation.isCompatible = false;
      }

    } catch (error) {
      validation.issues.push(`Validation error: ${error.message}`);
      validation.isCompatible = false;
    }

    return validation;
  }

  /**
   * Process legacy invoice for modern system
   * Handles the complete transformation and validation process
   */
  async processLegacyInvoice(legacyInvoiceData) {
    try {
      // First validate compatibility
      const validation = await this.validateLegacyCompatibility(legacyInvoiceData);
      
      if (!validation.isCompatible) {
        throw new Error(`Legacy invoice incompatible: ${validation.issues.join(', ')}`);
      }

      // Transform to modern format
      const transformedInvoice = await this.transformLegacyInvoice(legacyInvoiceData);
      
      // Add processing metadata
      transformedInvoice.backwardCompatibility = {
        processedAt: new Date(),
        originalFormat: 'legacy',
        transformationVersion: '1.0',
        validationWarnings: validation.warnings,
        recommendations: validation.recommendations
      };

      return {
        success: true,
        transformedInvoice,
        validation,
        metadata: {
          processingTime: new Date(),
          transformationApplied: true,
          legacyFieldsDetected: validation.warnings.length > 0
        }
      };
    } catch (error) {
      console.error('Error processing legacy invoice:', error);
      return {
        success: false,
        error: error.message,
        originalData: legacyInvoiceData
      };
    }
  }

  /**
   * Migrate legacy invoice collection
   * Batch process existing invoices to ensure compatibility
   */
  async migrateLegacyInvoices(options = {}) {
    try {
      await this.connect();
      
      const {
        batchSize = 100,
        dryRun = false,
        skipAlreadyMigrated = true
      } = options;

      const migrationStats = {
        totalProcessed: 0,
        successful: 0,
        failed: 0,
        skipped: 0,
        errors: []
      };

      // Find invoices that need migration
      const query = skipAlreadyMigrated ? 
        { $or: [{ version: { $exists: false } }, { version: { $lt: '2.0' } }] } : 
        {};

      const invoiceCount = await this.db.collection('invoices').countDocuments(query);
      console.log(`Found ${invoiceCount} invoices to migrate`);

      const cursor = this.db.collection('invoices').find(query).batchSize(batchSize);
      
      while (await cursor.hasNext()) {
        const invoice = await cursor.next();
        migrationStats.totalProcessed++;

        try {
          const result = await this.processLegacyInvoice(invoice);
          
          if (result.success) {
            if (!dryRun) {
              // Update the invoice in database
              await this.db.collection('invoices').updateOne(
                { _id: invoice._id },
                { $set: result.transformedInvoice }
              );
            }
            migrationStats.successful++;
          } else {
            migrationStats.failed++;
            migrationStats.errors.push({
              invoiceId: invoice._id,
              error: result.error
            });
          }
        } catch (error) {
          migrationStats.failed++;
          migrationStats.errors.push({
            invoiceId: invoice._id,
            error: error.message
          });
        }

        // Progress logging
        if (migrationStats.totalProcessed % 50 === 0) {
          console.log(`Processed ${migrationStats.totalProcessed}/${invoiceCount} invoices`);
        }
      }

      return migrationStats;
    } catch (error) {
      console.error('Error during legacy invoice migration:', error);
      throw error;
    }
  }

  /**
   * Get legacy data statistics
   * Provides insights into legacy data that needs attention
   */
  async getLegacyDataStats() {
    try {
      await this.connect();
      
      const stats = {
        totalInvoices: 0,
        legacyInvoices: 0,
        migratedInvoices: 0,
        unmappedItems: 0,
        deprecatedFields: [],
        compatibilityIssues: []
      };

      // Count total invoices
      stats.totalInvoices = await this.db.collection('invoices').countDocuments();
      
      // Count legacy invoices (no version or version < 2.0)
      stats.legacyInvoices = await this.db.collection('invoices').countDocuments({
        $or: [{ version: { $exists: false } }, { version: { $lt: '2.0' } }]
      });
      
      // Count migrated invoices
      stats.migratedInvoices = await this.db.collection('invoices').countDocuments({
        version: { $gte: '2.0' }
      });
      
      // Count line items with legacy markers
      stats.unmappedItems = await this.db.collection('lineItems').countDocuments({
        ndisItemNumber: 'LEGACY_ITEM'
      });

      return stats;
    } catch (error) {
      console.error('Error getting legacy data stats:', error);
      throw error;
    }
  }
}

module.exports = BackwardCompatibilityService;