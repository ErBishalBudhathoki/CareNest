/**
 * Price Prompt Service
 * Handles missing price prompts during single invoice generation
 * Task 2.3: Create price prompt system for missing prices
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const logger = require('./config/logger');
const uri = process.env.MONGODB_URI;

class PricePromptService {
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
   * Create a price prompt for missing pricing
   */
  async createPricePrompt(promptData) {
    try {
      await this.connect();

      const prompt = {
        _id: new ObjectId(),
        ndisItemNumber: promptData.ndisItemNumber,
        itemDescription: promptData.itemDescription,
        organizationId: promptData.organizationId,
        clientId: promptData.clientId,
        userEmail: promptData.userEmail,
        clientEmail: promptData.clientEmail,
        quantity: promptData.quantity,
        unit: promptData.unit,
        suggestedPrice: promptData.suggestedPrice || 0,
        priceCap: promptData.priceCap,
        state: promptData.state || 'NSW',
        providerType: promptData.providerType || 'standard',
        status: 'pending',
        createdAt: new Date(),
        updatedAt: new Date(),
        metadata: {
          invoiceGenerationContext: true,
          lineItemIndex: promptData.lineItemIndex,
          sessionId: promptData.sessionId
        }
      };

      const result = await this.db.collection('pricePrompts').insertOne(prompt);
      
      return {
        success: true,
        promptId: result.insertedId,
        prompt: prompt
      };
    } catch (error) {
      logger.error('Error creating price prompt', {
        error: error.message,
        stack: error.stack,
        promptData
      });
      throw error;
    }
  }

  /**
   * Resolve a price prompt with user-provided pricing
   */
  async resolvePricePrompt(promptId, resolution) {
    try {
      await this.connect();

      const updateData = {
        status: 'resolved',
        resolvedAt: new Date(),
        updatedAt: new Date(),
        resolution: {
          providedPrice: resolution.providedPrice,
          saveAsCustomPricing: resolution.saveAsCustomPricing || false,
          applyToClient: resolution.applyToClient || false,
          applyToOrganization: resolution.applyToOrganization || false,
          notes: resolution.notes || ''
        }
      };

      const result = await this.db.collection('pricePrompts').updateOne(
        { _id: new ObjectId(promptId) },
        { $set: updateData }
      );

      if (result.matchedCount === 0) {
        throw new Error('Price prompt not found');
      }

      // If user wants to save as custom pricing, create the custom pricing entry
      if (resolution.saveAsCustomPricing) {
        await this.saveAsCustomPricing(promptId, resolution);
      }

      return {
        success: true,
        message: 'Price prompt resolved successfully'
      };
    } catch (error) {
      logger.error('Error resolving price prompt', {
        error: error.message,
        stack: error.stack,
        promptId,
        resolution
      });
      throw error;
    }
  }

  /**
   * Save resolved price as custom pricing
   */
  async saveAsCustomPricing(promptId, resolution) {
    try {
      const prompt = await this.db.collection('pricePrompts').findOne({
        _id: new ObjectId(promptId)
      });

      if (!prompt) {
        throw new Error('Price prompt not found');
      }

      // Determine if this is client-specific pricing
      const isClientSpecific = resolution.applyToClient || false;
      const targetClientId = isClientSpecific ? prompt.clientId : null;
      
      // Build the query to check for existing custom pricing
      const duplicateCheckQuery = {
        organizationId: prompt.organizationId,
        supportItemNumber: prompt.ndisItemNumber,
        clientSpecific: isClientSpecific,
        isActive: true
      };
      
      // Only add clientId to query if it's client-specific pricing
      if (isClientSpecific) {
        duplicateCheckQuery.clientId = targetClientId;
      } else {
        // For organization-level pricing, ensure clientId is null
        duplicateCheckQuery.clientId = null;
      }
      
      logger.debug('Checking for duplicate custom pricing', {
          query: duplicateCheckQuery
        });
      
      const existingCustomPricing = await this.db.collection('customPricing').findOne(duplicateCheckQuery);

      if (existingCustomPricing) {
        // Check if the price is different before updating
        const newPrice = resolution.providedPrice;
        const existingPrice = existingCustomPricing.customPrice;
        
        if (newPrice !== existingPrice) {
          // Update existing custom pricing with new price
          await this.db.collection('customPricing').updateOne(
            { _id: existingCustomPricing._id },
            {
              $set: {
                customPrice: newPrice,
                updatedBy: prompt.userEmail,
                updatedAt: new Date(),
                version: (existingCustomPricing.version || 1) + 1,
                source: 'price_prompt',
                metadata: {
                  originalPromptId: promptId,
                  notes: resolution.notes
                }
              },
              $push: {
                auditTrail: {
                  action: 'updated_via_prompt',
                  performedBy: prompt.userEmail,
                  timestamp: new Date(),
                  changes: `Price updated from ${existingPrice} to ${newPrice} via price prompt`,
                  promptId: promptId
                }
              }
            }
          );
          logger.info('Updated existing custom pricing', {
            ndisItemNumber: prompt.ndisItemNumber,
            oldPrice: existingPrice,
            newPrice: newPrice
          });
        } else {
          logger.info('Custom pricing already exists with same price, skipping duplicate', {
            ndisItemNumber: prompt.ndisItemNumber,
            price: newPrice
          });
        }
      } else {
        // Create new custom pricing record
        const customPricingData = {
          _id: new ObjectId(),
          organizationId: prompt.organizationId,
          supportItemNumber: prompt.ndisItemNumber,
          supportItemName: prompt.ndisItemName || 'Unknown Item',
          pricingType: 'fixed',
          customPrice: resolution.providedPrice,
          multiplier: null,
          clientId: targetClientId,
          clientSpecific: isClientSpecific,
          ndisCompliant: true,
          exceedsNdisCap: false,
          approvalStatus: 'approved',
          effectiveDate: new Date(),
          expiryDate: null,
          createdBy: prompt.userEmail,
          createdAt: new Date(),
          updatedBy: prompt.userEmail,
          updatedAt: new Date(),
          isActive: true,
          version: 1,
          source: 'price_prompt',
          metadata: {
            originalPromptId: promptId,
            notes: resolution.notes
          },
          auditTrail: [{
            action: 'created_via_prompt',
            performedBy: prompt.userEmail,
            timestamp: new Date(),
            changes: `Custom pricing created: ${resolution.providedPrice} via price prompt`,
            promptId: promptId
          }]
        };

        // Create the custom pricing entry
        await this.db.collection('customPricing').insertOne(customPricingData);
        logger.info('Created new custom pricing', {
          ndisItemNumber: prompt.ndisItemNumber,
          clientSpecific: isClientSpecific,
          clientId: targetClientId
        });
      }

      return {
        success: true,
        message: 'Custom pricing saved successfully'
      };
    } catch (error) {
        logger.error('Error saving custom pricing', {
          error: error.message,
          stack: error.stack,
          promptData: prompt
        });
      throw error;
    }
  }

  /**
   * Get pending price prompts for a session
   */
  async getPendingPrompts(sessionId) {
    try {
      await this.connect();

      const prompts = await this.db.collection('pricePrompts').find({
        'metadata.sessionId': sessionId,
        status: 'pending'
      }).sort({ createdAt: 1 }).toArray();

      return {
        success: true,
        prompts: prompts
      };
    } catch (error) {
      logger.error('Error getting pending prompts', {
        error: error.message,
        stack: error.stack,
        sessionId
      });
      throw error;
    }
  }

  /**
   * Cancel a price prompt
   */
  async cancelPricePrompt(promptId) {
    try {
      await this.connect();

      const result = await this.db.collection('pricePrompts').updateOne(
        { _id: new ObjectId(promptId) },
        { 
          $set: { 
            status: 'cancelled',
            cancelledAt: new Date(),
            updatedAt: new Date()
          }
        }
      );

      if (result.matchedCount === 0) {
        throw new Error('Price prompt not found');
      }

      return {
        success: true,
        message: 'Price prompt cancelled successfully'
      };
    } catch (error) {
      logger.error('Error cancelling price prompt', {
        error: error.message,
        stack: error.stack,
        promptId
      });
      throw error;
    }
  }

  /**
   * Validate price prompt data
   */
  validatePromptData(promptData) {
    const errors = [];

    if (!promptData.ndisItemNumber) {
      errors.push('NDIS item number is required');
    }

    if (!promptData.organizationId) {
      errors.push('Organization ID is required');
    }

    if (!promptData.userEmail) {
      errors.push('User email is required');
    }

    if (!promptData.clientEmail) {
      errors.push('Client email is required');
    }

    if (!promptData.sessionId) {
      errors.push('Session ID is required');
    }

    if (promptData.quantity && (isNaN(promptData.quantity) || promptData.quantity <= 0)) {
      errors.push('Quantity must be a positive number');
    }

    return errors;
  }

  /**
   * Validate price resolution data
   */
  validateResolutionData(resolution) {
    const errors = [];

    if (!resolution.providedPrice) {
      errors.push('Provided price is required');
    }

    if (isNaN(resolution.providedPrice) || resolution.providedPrice < 0) {
      errors.push('Provided price must be a valid positive number');
    }

    return errors;
  }
}

module.exports = PricePromptService;