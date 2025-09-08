/**
 * Backward Compatibility Endpoints
 * API endpoints for handling legacy invoice data and migration
 * Task 2.7: Implement backward compatibility for existing invoice data
 */

const BackwardCompatibilityService = require('./services/backwardCompatibilityService');
const { ObjectId } = require('mongodb');

/**
 * Process legacy invoice data
 * POST /api/invoice/process-legacy
 */
async function processLegacyInvoice(req, res) {
  const service = new BackwardCompatibilityService();
  
  try {
    const { invoiceData, options = {} } = req.body;
    
    if (!invoiceData) {
      return res.status(400).json({
        success: false,
        error: 'Invoice data is required'
      });
    }

    const result = await service.processLegacyInvoice(invoiceData);
    
    if (result.success) {
      res.json({
        success: true,
        message: 'Legacy invoice processed successfully',
        data: result.transformedInvoice,
        validation: result.validation,
        metadata: result.metadata
      });
    } else {
      res.status(422).json({
        success: false,
        error: 'Failed to process legacy invoice',
        details: result.error,
        originalData: options.includeOriginal ? result.originalData : undefined
      });
    }
  } catch (error) {
    console.error('Error in processLegacyInvoice endpoint:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error',
      message: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Validate legacy invoice compatibility
 * POST /api/invoice/validate-legacy
 */
async function validateLegacyCompatibility(req, res) {
  const service = new BackwardCompatibilityService();
  
  try {
    const { invoiceData } = req.body;
    
    if (!invoiceData) {
      return res.status(400).json({
        success: false,
        error: 'Invoice data is required for validation'
      });
    }

    const validation = await service.validateLegacyCompatibility(invoiceData);
    
    res.json({
      success: true,
      validation,
      recommendations: {
        canProcess: validation.isCompatible,
        requiresTransformation: validation.warnings.length > 0,
        criticalIssues: validation.issues.length,
        suggestedActions: validation.recommendations
      }
    });
  } catch (error) {
    console.error('Error in validateLegacyCompatibility endpoint:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error',
      message: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Transform legacy invoice to modern format
 * POST /api/invoice/transform-legacy
 */
async function transformLegacyInvoice(req, res) {
  const service = new BackwardCompatibilityService();
  
  try {
    const { invoiceData, preserveOriginal = false } = req.body;
    
    if (!invoiceData) {
      return res.status(400).json({
        success: false,
        error: 'Invoice data is required for transformation'
      });
    }

    // First validate compatibility
    const validation = await service.validateLegacyCompatibility(invoiceData);
    
    if (!validation.isCompatible) {
      return res.status(422).json({
        success: false,
        error: 'Invoice data is not compatible for transformation',
        validation,
        issues: validation.issues
      });
    }

    // Transform the invoice
    const transformedInvoice = await service.transformLegacyInvoice(invoiceData);
    
    const response = {
      success: true,
      message: 'Invoice transformed successfully',
      transformedInvoice,
      validation,
      metadata: {
        transformedAt: new Date(),
        hasWarnings: validation.warnings.length > 0,
        warningCount: validation.warnings.length
      }
    };

    if (preserveOriginal) {
      response.originalInvoice = invoiceData;
    }

    res.json(response);
  } catch (error) {
    console.error('Error in transformLegacyInvoice endpoint:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error',
      message: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Migrate legacy invoices in batch
 * POST /api/invoice/migrate-legacy-batch
 */
async function migrateLegacyInvoicesBatch(req, res) {
  const service = new BackwardCompatibilityService();
  
  try {
    const {
      batchSize = 100,
      dryRun = false,
      skipAlreadyMigrated = true
    } = req.body;

    // Validate batch size
    if (batchSize > 1000) {
      return res.status(400).json({
        success: false,
        error: 'Batch size cannot exceed 1000 invoices'
      });
    }

    const migrationStats = await service.migrateLegacyInvoices({
      batchSize,
      dryRun,
      skipAlreadyMigrated
    });
    
    res.json({
      success: true,
      message: dryRun ? 'Dry run completed' : 'Migration completed',
      stats: migrationStats,
      summary: {
        successRate: migrationStats.totalProcessed > 0 ? 
          (migrationStats.successful / migrationStats.totalProcessed * 100).toFixed(2) + '%' : '0%',
        failureRate: migrationStats.totalProcessed > 0 ? 
          (migrationStats.failed / migrationStats.totalProcessed * 100).toFixed(2) + '%' : '0%',
        isDryRun: dryRun
      }
    });
  } catch (error) {
    console.error('Error in migrateLegacyInvoicesBatch endpoint:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error',
      message: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Get legacy data statistics
 * GET /api/invoice/legacy-stats
 */
async function getLegacyDataStats(req, res) {
  const service = new BackwardCompatibilityService();
  
  try {
    const stats = await service.getLegacyDataStats();
    
    res.json({
      success: true,
      stats,
      insights: {
        migrationProgress: stats.totalInvoices > 0 ? 
          (stats.migratedInvoices / stats.totalInvoices * 100).toFixed(2) + '%' : '0%',
        legacyPercentage: stats.totalInvoices > 0 ? 
          (stats.legacyInvoices / stats.totalInvoices * 100).toFixed(2) + '%' : '0%',
        needsAttention: stats.legacyInvoices > 0 || stats.unmappedItems > 0,
        recommendations: [
          stats.legacyInvoices > 0 ? `${stats.legacyInvoices} invoices need migration` : null,
          stats.unmappedItems > 0 ? `${stats.unmappedItems} line items need NDIS mapping` : null
        ].filter(Boolean)
      }
    });
  } catch (error) {
    console.error('Error in getLegacyDataStats endpoint:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error',
      message: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Map legacy item to NDIS format
 * POST /api/invoice/map-legacy-item
 */
async function mapLegacyItemToNdis(req, res) {
  const service = new BackwardCompatibilityService();
  
  try {
    const { legacyItem } = req.body;
    
    if (!legacyItem || !legacyItem.description) {
      return res.status(400).json({
        success: false,
        error: 'Legacy item with description is required'
      });
    }

    const mappedItem = await service.mapLegacyItemToNdis(legacyItem);
    
    if (mappedItem) {
      res.json({
        success: true,
        message: 'Legacy item mapped successfully',
        originalItem: legacyItem,
        mappedItem,
        confidence: mappedItem.ndisItemNumber !== '01_999_0199_1_1' ? 'high' : 'low'
      });
    } else {
      res.json({
        success: false,
        message: 'Could not map legacy item to NDIS format',
        originalItem: legacyItem,
        suggestion: 'Manual mapping may be required'
      });
    }
  } catch (error) {
    console.error('Error in mapLegacyItemToNdis endpoint:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error',
      message: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Check invoice backward compatibility
 * GET /api/invoice/:invoiceId/compatibility
 */
async function checkInvoiceCompatibility(req, res) {
  const service = new BackwardCompatibilityService();
  
  try {
    const { invoiceId } = req.params;
    
    if (!ObjectId.isValid(invoiceId)) {
      return res.status(400).json({
        success: false,
        error: 'Invalid invoice ID format'
      });
    }

    await service.connect();
    const invoice = await service.db.collection('invoices').findOne({
      _id: new ObjectId(invoiceId)
    });
    
    if (!invoice) {
      return res.status(404).json({
        success: false,
        error: 'Invoice not found'
      });
    }

    const validation = await service.validateLegacyCompatibility(invoice);
    
    res.json({
      success: true,
      invoiceId,
      compatibility: {
        isModernFormat: invoice.version && invoice.version >= '2.0',
        isLegacyFormat: !invoice.version || invoice.version < '2.0',
        needsMigration: !validation.isCompatible || validation.warnings.length > 0,
        validation
      },
      recommendations: {
        action: !validation.isCompatible ? 'migration_required' : 
                validation.warnings.length > 0 ? 'migration_recommended' : 'no_action_needed',
        priority: !validation.isCompatible ? 'high' : 
                 validation.warnings.length > 3 ? 'medium' : 'low'
      }
    });
  } catch (error) {
    console.error('Error in checkInvoiceCompatibility endpoint:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error',
      message: error.message
    });
  } finally {
    await service.disconnect();
  }
}

module.exports = {
  processLegacyInvoice,
  validateLegacyCompatibility,
  transformLegacyInvoice,
  migrateLegacyInvoicesBatch,
  getLegacyDataStats,
  mapLegacyItemToNdis,
  checkInvoiceCompatibility
};