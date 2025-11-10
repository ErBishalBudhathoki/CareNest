/**
 * Price Validation Service
 * Validates pricing against NDIS caps and business rules
 * Provides comprehensive price validation for custom pricing and invoice generation
 */

const { MongoClient, ServerApiVersion } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const uri = process.env.MONGODB_URI;

/**
 * Validation result structure
 * @typedef {Object} ValidationResult
 * @property {boolean} isValid - Whether the price is valid
 * @property {string} status - 'valid', 'exceeds_cap', 'no_cap_found', 'quotable_support', 'invalid_item'
 * @property {number|null} priceCap - The applicable price cap
 * @property {number|null} proposedPrice - The price being validated
 * @property {string} message - Human-readable validation message
 * @property {Object} supportItem - The NDIS support item details
 * @property {Object} validationDetails - Additional validation context
 */

/**
 * Price Validation Service Class
 */
class PriceValidationService {
  constructor() {
    this.client = null;
    this.db = null;
  }

  /**
   * Initialize database connection
   */
  async connect() {
    if (!this.client) {
      this.client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
      await this.client.connect();
      this.db = this.client.db('Invoice');
    }
  }

  /**
   * Close database connection
   */
  async disconnect() {
    if (this.client) {
      await this.client.close();
      this.client = null;
      this.db = null;
    }
  }

  /**
   * Validate a single price against NDIS caps
   * @param {string} supportItemNumber - NDIS support item number
   * @param {number} proposedPrice - Price to validate
   * @param {string} state - Australian state/territory (ACT, NSW, NT, QLD, SA, TAS, VIC, WA)
   * @param {string} providerType - Provider type ('standard' or 'highIntensity')
   * @param {Date} serviceDate - Date of service (for validity period check)
   * @returns {Promise<ValidationResult>} Validation result
   */
  async validatePrice(supportItemNumber, proposedPrice, state = 'NSW', providerType = 'standard', serviceDate = new Date()) {
    try {
      await this.connect();

      // Input validation
      if (!supportItemNumber || typeof proposedPrice !== 'number' || proposedPrice < 0) {
        return {
          isValid: false,
          status: 'invalid_input',
          priceCap: null,
          proposedPrice,
          message: 'Invalid input parameters',
          supportItem: null,
          validationDetails: {
            error: 'Invalid support item number or proposed price'
          }
        };
      }

      // Normalize state code
      const normalizedState = state.toUpperCase();
      const validStates = ['ACT', 'NSW', 'NT', 'QLD', 'SA', 'TAS', 'VIC', 'WA'];
      if (!validStates.includes(normalizedState)) {
        return {
          isValid: false,
          status: 'invalid_state',
          priceCap: null,
          proposedPrice,
          message: `Invalid state code: ${state}. Must be one of: ${validStates.join(', ')}`,
          supportItem: null,
          validationDetails: {
            validStates
          }
        };
      }

      // Find support item
      const supportItem = await this.db.collection('supportItems').findOne({
        supportItemNumber: supportItemNumber
      });

      if (!supportItem) {
        return {
          isValid: false,
          status: 'invalid_item',
          priceCap: null,
          proposedPrice,
          message: `Support item not found: ${supportItemNumber}`,
          supportItem: null,
          validationDetails: {
            searchedItemNumber: supportItemNumber
          }
        };
      }

      // Check service date validity
      const dateValidation = this.validateServiceDate(supportItem, serviceDate);
      if (!dateValidation.isValid) {
        return {
          isValid: false,
          status: 'invalid_date',
          priceCap: null,
          proposedPrice,
          message: dateValidation.message,
          supportItem,
          validationDetails: {
            serviceDate,
            validPeriod: {
              start: supportItem.startDate,
              end: supportItem.endDate
            }
          }
        };
      }

      // Check if item requires quotes (no price caps)
      if (supportItem.quoteRequired || supportItem.supportType === 'Quotable Supports') {
        return {
          isValid: true,
          status: 'quotable_support',
          priceCap: null,
          proposedPrice,
          message: 'This support item requires a quote - no price cap validation needed',
          supportItem,
          validationDetails: {
            requiresQuote: true,
            supportType: supportItem.supportType
          }
        };
      }

      // Get price cap for the specified provider type and state
      const priceCap = this.getPriceCap(supportItem, normalizedState, providerType);

      if (priceCap === null) {
        return {
          isValid: false,
          status: 'no_cap_found',
          priceCap: null,
          proposedPrice,
          message: `No price cap found for ${supportItemNumber} in ${normalizedState} for ${providerType} providers`,
          supportItem,
          validationDetails: {
            state: normalizedState,
            providerType,
            availableCaps: supportItem.priceCaps
          }
        };
      }

      // Validate price against cap
      const isValid = proposedPrice <= priceCap;
      const status = isValid ? 'valid' : 'exceeds_cap';
      const message = isValid 
        ? `Price $${proposedPrice.toFixed(2)} is within the NDIS cap of $${priceCap.toFixed(2)}`
        : `Price $${proposedPrice.toFixed(2)} exceeds the NDIS cap of $${priceCap.toFixed(2)} by $${(proposedPrice - priceCap).toFixed(2)}`;

      return {
        isValid,
        status,
        priceCap,
        proposedPrice,
        message,
        supportItem,
        validationDetails: {
          state: normalizedState,
          providerType,
          exceedsBy: isValid ? 0 : proposedPrice - priceCap,
          compliancePercentage: (priceCap / proposedPrice * 100).toFixed(2)
        }
      };

    } catch (error) {
      return {
        isValid: false,
        status: 'validation_error',
        priceCap: null,
        proposedPrice,
        message: `Validation error: ${error.message}`,
        supportItem: null,
        validationDetails: {
          error: error.message,
          stack: error.stack
        }
      };
    }
  }

  /**
   * Validate multiple prices in batch
   * @param {Array} priceValidations - Array of validation requests
   * @returns {Promise<Array<ValidationResult>>} Array of validation results
   */
  async validatePricesBatch(priceValidations) {
    const results = [];
    
    for (const validation of priceValidations) {
      const result = await this.validatePrice(
        validation.supportItemNumber,
        validation.proposedPrice,
        validation.state,
        validation.providerType,
        validation.serviceDate
      );
      results.push({
        ...result,
        requestId: validation.requestId || null
      });
    }
    
    return results;
  }

  /**
   * Get price cap for a support item
   * @param {Object} supportItem - Support item document
   * @param {string} state - State code
   * @param {string} providerType - Provider type
   * @returns {number|null} Price cap or null if not found
   */
  getPriceCap(supportItem, state, providerType) {
    if (!supportItem.priceCaps || !supportItem.priceCaps[providerType]) {
      return null;
    }
    
    return supportItem.priceCaps[providerType][state] || null;
  }

  /**
   * Validate service date against support item validity period
   * @param {Object} supportItem - Support item document
   * @param {Date} serviceDate - Service date to validate
   * @returns {Object} Validation result with isValid and message
   */
  validateServiceDate(supportItem, serviceDate) {
    const startDate = new Date(supportItem.startDate);
    const endDate = new Date(supportItem.endDate);
    const service = new Date(serviceDate);

    if (service < startDate) {
      return {
        isValid: false,
        message: `Service date ${service.toISOString().split('T')[0]} is before the support item start date ${startDate.toISOString().split('T')[0]}`
      };
    }

    if (service > endDate && endDate.getFullYear() !== 9999) {
      return {
        isValid: false,
        message: `Service date ${service.toISOString().split('T')[0]} is after the support item end date ${endDate.toISOString().split('T')[0]}`
      };
    }

    return {
      isValid: true,
      message: 'Service date is within valid period'
    };
  }

  /**
   * Get all available price caps for a support item
   * @param {string} supportItemNumber - NDIS support item number
   * @returns {Promise<Object|null>} Price caps object or null if not found
   */
  async getPriceCaps(supportItemNumber) {
    try {
      await this.connect();
      
      const supportItem = await this.db.collection('supportItems').findOne(
        { supportItemNumber },
        { projection: { priceCaps: 1, supportItemName: 1, supportType: 1, quoteRequired: 1 } }
      );
      
      return supportItem;
    } catch (error) {
      console.error('Error getting price caps:', error);
      return null;
    }
  }

  /**
   * Check if a support item requires quotes
   * @param {string} supportItemNumber - NDIS support item number
   * @returns {Promise<boolean>} True if quotes are required
   */
  async requiresQuote(supportItemNumber) {
    try {
      await this.connect();
      
      const supportItem = await this.db.collection('supportItems').findOne(
        { supportItemNumber },
        { projection: { quoteRequired: 1, supportType: 1 } }
      );
      
      if (!supportItem) return false;
      
      return supportItem.quoteRequired || supportItem.supportType === 'Quotable Supports';
    } catch (error) {
      console.error('Error checking quote requirement:', error);
      return false;
    }
  }

  /**
   * Get validation summary for multiple items
   * @param {Array} validationResults - Array of validation results
   * @returns {Object} Summary statistics
   */
  getValidationSummary(validationResults) {
    const summary = {
      total: validationResults.length,
      valid: 0,
      exceedsCap: 0,
      quotableSupports: 0,
      invalidItems: 0,
      errors: 0,
      totalExcessAmount: 0,
      averageComplianceRate: 0
    };

    let complianceSum = 0;
    let complianceCount = 0;

    validationResults.forEach(result => {
      switch (result.status) {
        case 'valid':
          summary.valid++;
          break;
        case 'exceeds_cap':
          summary.exceedsCap++;
          summary.totalExcessAmount += result.validationDetails.exceedsBy || 0;
          break;
        case 'quotable_support':
          summary.quotableSupports++;
          break;
        case 'invalid_item':
          summary.invalidItems++;
          break;
        default:
          summary.errors++;
      }

      if (result.validationDetails && result.validationDetails.compliancePercentage) {
        complianceSum += parseFloat(result.validationDetails.compliancePercentage);
        complianceCount++;
      }
    });

    if (complianceCount > 0) {
      summary.averageComplianceRate = (complianceSum / complianceCount).toFixed(2);
    }

    return summary;
  }
}

// Export singleton instance
const priceValidationService = new PriceValidationService();

module.exports = {
  PriceValidationService,
  priceValidationService
};