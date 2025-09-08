const { MongoClient, ServerApiVersion } = require('mongodb');
const logger = require('./logger');
const { createAuditLog } = require('../services/auditService');

const uri = process.env.MONGODB_URI;

/**
 * Process custom pricing for clients or organizations
 * @param {Object} pricingData - The pricing data to process
 * @param {string} pricingData.clientId - Client ID (optional)
 * @param {string} pricingData.organizationId - Organization ID (optional)
 * @param {string} pricingData.supportItemNumber - Support item number
 * @param {number} pricingData.price - Custom price
 * @param {string} pricingData.userId - User ID for audit trail
 * @param {string} pricingData.userName - User name for audit trail
 * @returns {Promise<Object>} Result object with success status and data
 */
async function processCustomPricing(pricingData) {
  const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
  
  try {
    await client.connect();
    const db = client.db('invoiceApp');
    const customPricingCollection = db.collection('customPricing');
    
    const { clientId, organizationId, supportItemNumber, price, userId, userName } = pricingData;
    
    // Build query based on whether it's client-specific or organization-level
    const query = {
      supportItemNumber: supportItemNumber
    };
    
    if (clientId) {
      query.clientId = clientId;
    } else if (organizationId) {
      query.organizationId = organizationId;
      query.clientId = { $exists: false }; // Ensure it's organization-level
    }
    
    // Check if custom pricing already exists
    const existingPricing = await customPricingCollection.findOne(query);
    
    if (existingPricing) {
      // Update existing pricing
      const oldPrice = existingPricing.price;
      const updateData = {
        price: price,
        lastModified: new Date(),
        modifiedBy: userId,
        version: (existingPricing.version || 1) + 1
      };
      
      await customPricingCollection.updateOne(
        { _id: existingPricing._id },
        { $set: updateData }
      );
      
      // Create audit log for price update
      await createAuditLog({
        entityType: 'customPricing',
        entityId: existingPricing._id.toString(),
        action: 'update',
        changes: {
          price: { old: oldPrice, new: price }
        },
        userId: userId,
        userName: userName,
        timestamp: new Date()
      });
      
      return {
        success: true,
        action: 'updated',
        data: { ...existingPricing, ...updateData }
      };
    } else {
      // Create new custom pricing
      const newPricing = {
        ...query,
        price: price,
        createdAt: new Date(),
        createdBy: userId,
        lastModified: new Date(),
        modifiedBy: userId,
        version: 1
      };
      
      const result = await customPricingCollection.insertOne(newPricing);
      
      // Create audit log for new pricing
      await createAuditLog({
        entityType: 'customPricing',
        entityId: result.insertedId.toString(),
        action: 'create',
        changes: newPricing,
        userId: userId,
        userName: userName,
        timestamp: new Date()
      });
      
      return {
        success: true,
        action: 'created',
        data: { ...newPricing, _id: result.insertedId }
      };
    }
  } catch (error) {
    logger.error('Error processing custom pricing', {
      error: error.message,
      stack: error.stack,
      pricingData
    });
    return {
      success: false,
      error: error.message
    };
  } finally {
    await client.close();
  }
}

/**
 * Get custom pricing for a specific support item
 * @param {Object} query - Query parameters
 * @param {string} query.clientId - Client ID (optional)
 * @param {string} query.organizationId - Organization ID (optional)
 * @param {string} query.supportItemNumber - Support item number
 * @returns {Promise<Object|null>} Custom pricing data or null if not found
 */
async function getCustomPricing(query) {
  const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
  
  try {
    await client.connect();
    const db = client.db('invoiceApp');
    const customPricingCollection = db.collection('customPricing');
    
    const { clientId, organizationId, supportItemNumber } = query;
    
    // First try to find client-specific pricing
    if (clientId) {
      const clientPricing = await customPricingCollection.findOne({
        clientId: clientId,
        supportItemNumber: supportItemNumber
      });
      
      if (clientPricing) {
        return clientPricing;
      }
    }
    
    // If no client-specific pricing found, try organization-level
    if (organizationId) {
      const orgPricing = await customPricingCollection.findOne({
        organizationId: organizationId,
        supportItemNumber: supportItemNumber,
        clientId: { $exists: false }
      });
      
      return orgPricing;
    }
    
    return null;
  } catch (error) {
    logger.error('Error getting custom pricing', {
      error: error.message,
      stack: error.stack,
      query
    });
    throw error;
  } finally {
    await client.close();
  }
}

/**
 * Delete custom pricing
 * @param {Object} query - Query parameters
 * @param {string} query.clientId - Client ID (optional)
 * @param {string} query.organizationId - Organization ID (optional)
 * @param {string} query.supportItemNumber - Support item number
 * @param {string} userId - User ID for audit trail
 * @param {string} userName - User name for audit trail
 * @returns {Promise<Object>} Result object with success status
 */
async function deleteCustomPricing(query, userId, userName) {
  const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
  
  try {
    await client.connect();
    const db = client.db('invoiceApp');
    const customPricingCollection = db.collection('customPricing');
    
    const { clientId, organizationId, supportItemNumber } = query;
    
    // Build query
    const deleteQuery = {
      supportItemNumber: supportItemNumber
    };
    
    if (clientId) {
      deleteQuery.clientId = clientId;
    } else if (organizationId) {
      deleteQuery.organizationId = organizationId;
      deleteQuery.clientId = { $exists: false };
    }
    
    // Get the pricing before deletion for audit log
    const existingPricing = await customPricingCollection.findOne(deleteQuery);
    
    if (!existingPricing) {
      return {
        success: false,
        error: 'Custom pricing not found'
      };
    }
    
    // Delete the pricing
    await customPricingCollection.deleteOne({ _id: existingPricing._id });
    
    // Create audit log for deletion
    await createAuditLog({
      entityType: 'customPricing',
      entityId: existingPricing._id.toString(),
      action: 'delete',
      changes: existingPricing,
      userId: userId,
      userName: userName,
      timestamp: new Date()
    });
    
    return {
      success: true,
      action: 'deleted',
      data: existingPricing
    };
  } catch (error) {
    logger.error('Error deleting custom pricing', {
      error: error.message,
      stack: error.stack,
      query
    });
    return {
      success: false,
      error: error.message
    };
  } finally {
    await client.close();
  }
}

module.exports = {
  processCustomPricing,
  getCustomPricing,
  deleteCustomPricing
};