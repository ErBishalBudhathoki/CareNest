/**
 * Price Validation API Endpoints
 * Provides REST API endpoints for NDIS price validation service
 */

const { priceValidationService } = require('./price_validation_service');

/**
 * Validate a single price against NDIS caps
 * POST /api/price-validation/validate
 */
async function validatePrice(req, res) {
  try {
    const {
      supportItemNumber,
      proposedPrice,
      state = 'NSW',
      providerType = 'standard',
      serviceDate = new Date()
    } = req.body;

    // Input validation
    if (!supportItemNumber) {
      return res.status(400).json({
        success: false,
        error: 'Support item number is required'
      });
    }

    if (typeof proposedPrice !== 'number' || proposedPrice < 0) {
      return res.status(400).json({
        success: false,
        error: 'Valid proposed price is required'
      });
    }

    const validationResult = await priceValidationService.validatePrice(
      supportItemNumber,
      proposedPrice,
      state,
      providerType,
      new Date(serviceDate)
    );

    res.json({
      success: true,
      data: validationResult
    });

  } catch (error) {
    console.error('Error validating price:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error during price validation'
    });
  }
}

/**
 * Validate multiple prices in batch
 * POST /api/price-validation/validate-batch
 */
async function validatePricesBatch(req, res) {
  try {
    const { validations } = req.body;

    if (!Array.isArray(validations) || validations.length === 0) {
      return res.status(400).json({
        success: false,
        error: 'Validations array is required and must not be empty'
      });
    }

    if (validations.length > 100) {
      return res.status(400).json({
        success: false,
        error: 'Maximum 100 validations allowed per batch request'
      });
    }

    // Validate each request in the batch
    for (let i = 0; i < validations.length; i++) {
      const validation = validations[i];
      if (!validation.supportItemNumber || typeof validation.proposedPrice !== 'number') {
        return res.status(400).json({
          success: false,
          error: `Invalid validation request at index ${i}: supportItemNumber and proposedPrice are required`
        });
      }
    }

    const results = await priceValidationService.validatePricesBatch(validations);
    const summary = priceValidationService.getValidationSummary(results);

    res.json({
      success: true,
      data: {
        results,
        summary
      }
    });

  } catch (error) {
    console.error('Error validating prices batch:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error during batch price validation'
    });
  }
}

/**
 * Get price caps for a support item
 * GET /api/price-validation/caps/:supportItemNumber
 */
async function getPriceCaps(req, res) {
  try {
    const { supportItemNumber } = req.params;

    if (!supportItemNumber) {
      return res.status(400).json({
        success: false,
        error: 'Support item number is required'
      });
    }

    const priceCaps = await priceValidationService.getPriceCaps(supportItemNumber);

    if (!priceCaps) {
      return res.status(404).json({
        success: false,
        error: 'Support item not found'
      });
    }

    res.json({
      success: true,
      data: priceCaps
    });

  } catch (error) {
    console.error('Error getting price caps:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error while retrieving price caps'
    });
  }
}

/**
 * Check if a support item requires quotes
 * GET /api/price-validation/quote-required/:supportItemNumber
 */
async function checkQuoteRequired(req, res) {
  try {
    const { supportItemNumber } = req.params;

    if (!supportItemNumber) {
      return res.status(400).json({
        success: false,
        error: 'Support item number is required'
      });
    }

    const requiresQuote = await priceValidationService.requiresQuote(supportItemNumber);

    res.json({
      success: true,
      data: {
        supportItemNumber,
        requiresQuote
      }
    });

  } catch (error) {
    console.error('Error checking quote requirement:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error while checking quote requirement'
    });
  }
}

/**
 * Validate pricing for invoice line items
 * POST /api/price-validation/validate-invoice
 */
async function validateInvoiceLineItems(req, res) {
  try {
    const { lineItems, defaultState = 'NSW', defaultProviderType = 'standard' } = req.body;

    if (!Array.isArray(lineItems) || lineItems.length === 0) {
      return res.status(400).json({
        success: false,
        error: 'Line items array is required and must not be empty'
      });
    }

    // Transform line items to validation requests
    const validations = lineItems.map((item, index) => ({
      requestId: item.id || `line_${index}`,
      supportItemNumber: item.supportItemNumber || item.itemCode,
      proposedPrice: item.unitPrice || item.price,
      state: item.state || defaultState,
      providerType: item.providerType || defaultProviderType,
      serviceDate: item.serviceDate || new Date(),
      quantity: item.quantity || 1,
      description: item.description || item.itemName
    }));

    const results = await priceValidationService.validatePricesBatch(validations);
    const summary = priceValidationService.getValidationSummary(results);

    // Calculate total amounts and compliance
    let totalInvoiceAmount = 0;
    let totalCompliantAmount = 0;
    let hasNonCompliantItems = false;

    const enhancedResults = results.map(result => {
      const lineItem = lineItems.find((item, index) => 
        (item.id && item.id === result.requestId) || 
        result.requestId === `line_${index}`
      );
      
      const quantity = lineItem?.quantity || 1;
      const lineTotal = result.proposedPrice * quantity;
      const compliantLineTotal = result.priceCap ? Math.min(result.proposedPrice, result.priceCap) * quantity : lineTotal;
      
      totalInvoiceAmount += lineTotal;
      totalCompliantAmount += compliantLineTotal;
      
      if (!result.isValid && result.status === 'exceeds_cap') {
        hasNonCompliantItems = true;
      }

      return {
        ...result,
        lineItem: {
          quantity,
          lineTotal,
          compliantLineTotal,
          excessAmount: lineTotal - compliantLineTotal
        }
      };
    });

    res.json({
      success: true,
      data: {
        results: enhancedResults,
        summary: {
          ...summary,
          totalInvoiceAmount,
          totalCompliantAmount,
          totalExcessAmount: totalInvoiceAmount - totalCompliantAmount,
          hasNonCompliantItems,
          compliancePercentage: ((totalCompliantAmount / totalInvoiceAmount) * 100).toFixed(2)
        }
      }
    });

  } catch (error) {
    console.error('Error validating invoice line items:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error during invoice validation'
    });
  }
}

/**
 * Get validation statistics and insights
 * GET /api/price-validation/stats
 */
async function getValidationStats(req, res) {
  try {
    // This could be enhanced to pull from a validation history collection
    // For now, return basic service information
    res.json({
      success: true,
      data: {
        serviceStatus: 'active',
        supportedStates: ['ACT', 'NSW', 'NT', 'QLD', 'SA', 'TAS', 'VIC', 'WA'],
        supportedProviderTypes: ['standard', 'highIntensity'],
        features: [
          'Single price validation',
          'Batch price validation',
          'Invoice line item validation',
          'Price cap lookup',
          'Quote requirement checking',
          'Service date validation',
          'Compliance reporting'
        ],
        lastUpdated: new Date().toISOString()
      }
    });

  } catch (error) {
    console.error('Error getting validation stats:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error while retrieving validation statistics'
    });
  }
}

module.exports = {
  validatePrice,
  validatePricesBatch,
  getPriceCaps,
  checkQuoteRequired,
  validateInvoiceLineItems,
  getValidationStats
};