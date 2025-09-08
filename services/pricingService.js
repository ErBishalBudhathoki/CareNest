const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const auditService = require('./auditService');
const priceValidationService = require('./priceValidationService');

const uri = process.env.MONGODB_URI;

class PricingService {
  constructor() {
    this.client = null;
  }

  async connect() {
    if (!this.client) {
      this.client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
      await this.client.connect();
    }
    return this.client.db('Invoice');
  }

  async disconnect() {
    if (this.client) {
      await this.client.close();
      this.client = null;
    }
  }

  /**
   * Create custom pricing record
   */
  async createCustomPricing(pricingData, userEmail) {
    const db = await this.connect();
    
    try {
      const {
        organizationId,
        supportItemNumber,
        supportItemName,
        pricingType,
        customPrice,
        multiplier,
        clientId,
        clientSpecific,
        ndisCompliant,
        exceedsNdisCap,
        effectiveDate,
        expiryDate
      } = pricingData;

      // Check for existing pricing
      const duplicateCheckQuery = {
        organizationId,
        supportItemNumber,
        clientSpecific: clientSpecific || false,
        isActive: true
      };

      if (clientSpecific && clientId) {
        duplicateCheckQuery.clientId = clientId;
      } else {
        duplicateCheckQuery.clientId = null;
      }

      const existingPricing = await db.collection('customPricing').findOne(duplicateCheckQuery);
      if (existingPricing) {
        throw new Error('Custom pricing already exists for this support item');
      }

      // Create pricing document
      const pricingDoc = {
        _id: new ObjectId(),
        organizationId,
        supportItemNumber,
        supportItemName,
        pricingType,
        customPrice: pricingType === 'fixed' ? customPrice : null,
        multiplier: pricingType === 'multiplier' ? multiplier : null,
        clientId: clientSpecific ? clientId : null,
        clientSpecific: clientSpecific || false,
        ndisCompliant: ndisCompliant !== undefined ? ndisCompliant : true,
        exceedsNdisCap: exceedsNdisCap || false,
        approvalStatus: exceedsNdisCap ? 'pending' : 'approved',
        effectiveDate: effectiveDate ? new Date(effectiveDate) : new Date(),
        expiryDate: expiryDate ? new Date(expiryDate) : null,
        createdBy: userEmail,
        createdAt: new Date(),
        updatedBy: userEmail,
        updatedAt: new Date(),
        isActive: true,
        version: 1,
        auditTrail: [{
          action: 'created',
          performedBy: userEmail,
          timestamp: new Date(),
          changes: 'Initial creation',
          reason: 'Custom pricing created'
        }]
      };

      const result = await db.collection('customPricing').insertOne(pricingDoc);
      
      // Create audit log
      await auditService.createAuditLog({
        entityType: 'pricing',
        entityId: result.insertedId.toString(),
        action: 'create',
        performedBy: userEmail,
        organizationId,
        details: {
          supportItemNumber,
          supportItemName,
          pricingType,
          price: pricingType === 'fixed' ? customPrice : multiplier,
          clientSpecific: clientSpecific || false
        }
      });

      return { ...pricingDoc, _id: result.insertedId };
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Get organization pricing with pagination and filtering
   */
  async getOrganizationPricing(organizationId, options = {}) {
    const db = await this.connect();
    
    try {
      const {
        page = 1,
        limit = 50,
        search,
        clientSpecific,
        approvalStatus,
        sortBy = 'createdAt',
        sortOrder = 'desc'
      } = options;

      const skip = (page - 1) * limit;
      const query = { organizationId, isActive: true };

      // Add filters
      if (search) {
        query.$or = [
          { supportItemNumber: { $regex: search, $options: 'i' } },
          { supportItemName: { $regex: search, $options: 'i' } }
        ];
      }

      if (clientSpecific !== undefined) {
        query.clientSpecific = clientSpecific;
      }

      if (approvalStatus) {
        query.approvalStatus = approvalStatus;
      }

      const sort = { [sortBy]: sortOrder === 'desc' ? -1 : 1 };

      const [pricing, total] = await Promise.all([
        db.collection('customPricing')
          .find(query)
          .sort(sort)
          .skip(skip)
          .limit(limit)
          .toArray(),
        db.collection('customPricing').countDocuments(query)
      ]);

      return {
        pricing,
        pagination: {
          page,
          limit,
          total,
          pages: Math.ceil(total / limit)
        }
      };
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Get pricing by ID
   */
  async getPricingById(pricingId) {
    const db = await this.connect();
    
    try {
      const pricing = await db.collection('customPricing').findOne({
        _id: new ObjectId(pricingId),
        isActive: true
      });

      return pricing;
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Update custom pricing
   */
  async updateCustomPricing(pricingId, updateData, userEmail) {
    const db = await this.connect();
    
    try {
      const existingPricing = await db.collection('customPricing').findOne({
        _id: new ObjectId(pricingId),
        isActive: true
      });

      if (!existingPricing) {
        throw new Error('Pricing record not found');
      }

      const {
        supportItemName,
        pricingType,
        customPrice,
        multiplier,
        clientId,
        clientSpecific,
        ndisCompliant,
        exceedsNdisCap,
        effectiveDate,
        expiryDate
      } = updateData;

      // Build update object
      const updateObj = {
        updatedBy: userEmail,
        updatedAt: new Date(),
        version: (existingPricing.version || 1) + 1
      };

      // Track changes for audit trail
      const changes = [];
      const auditTrailEntry = {
        action: 'updated',
        performedBy: userEmail,
        timestamp: new Date(),
        reason: 'Pricing update'
      };

      // Update fields and track changes
      if (supportItemName !== undefined && supportItemName !== existingPricing.supportItemName) {
        updateObj.supportItemName = supportItemName;
        changes.push(`supportItemName: ${existingPricing.supportItemName} → ${supportItemName}`);
      }

      if (pricingType !== undefined && pricingType !== existingPricing.pricingType) {
        updateObj.pricingType = pricingType;
        updateObj.customPrice = pricingType === 'fixed' ? customPrice : null;
        updateObj.multiplier = pricingType === 'multiplier' ? multiplier : null;
        changes.push(`pricingType: ${existingPricing.pricingType} → ${pricingType}`);
      } else {
        if (customPrice !== undefined && customPrice !== existingPricing.customPrice) {
          updateObj.customPrice = customPrice;
          changes.push(`customPrice: ${existingPricing.customPrice} → ${customPrice}`);
        }
        if (multiplier !== undefined && multiplier !== existingPricing.multiplier) {
          updateObj.multiplier = multiplier;
          changes.push(`multiplier: ${existingPricing.multiplier} → ${multiplier}`);
        }
      }

      if (clientId !== undefined && clientId !== existingPricing.clientId) {
        updateObj.clientId = clientId;
        changes.push(`clientId: ${existingPricing.clientId} → ${clientId}`);
      }

      if (clientSpecific !== undefined && clientSpecific !== existingPricing.clientSpecific) {
        updateObj.clientSpecific = clientSpecific;
        changes.push(`clientSpecific: ${existingPricing.clientSpecific} → ${clientSpecific}`);
      }

      if (ndisCompliant !== undefined && ndisCompliant !== existingPricing.ndisCompliant) {
        updateObj.ndisCompliant = ndisCompliant;
        changes.push(`ndisCompliant: ${existingPricing.ndisCompliant} → ${ndisCompliant}`);
      }

      if (exceedsNdisCap !== undefined && exceedsNdisCap !== existingPricing.exceedsNdisCap) {
        updateObj.exceedsNdisCap = exceedsNdisCap;
        changes.push(`exceedsNdisCap: ${existingPricing.exceedsNdisCap} → ${exceedsNdisCap}`);
      }

      if (effectiveDate !== undefined) {
        const newEffectiveDate = new Date(effectiveDate);
        if (newEffectiveDate.getTime() !== new Date(existingPricing.effectiveDate).getTime()) {
          updateObj.effectiveDate = newEffectiveDate;
          changes.push(`effectiveDate: ${existingPricing.effectiveDate} → ${newEffectiveDate}`);
        }
      }

      if (expiryDate !== undefined) {
        const newExpiryDate = expiryDate ? new Date(expiryDate) : null;
        const existingExpiryDate = existingPricing.expiryDate ? new Date(existingPricing.expiryDate) : null;
        if ((newExpiryDate?.getTime() || null) !== (existingExpiryDate?.getTime() || null)) {
          updateObj.expiryDate = newExpiryDate;
          changes.push(`expiryDate: ${existingExpiryDate} → ${newExpiryDate}`);
        }
      }

      if (changes.length > 0) {
        auditTrailEntry.changes = changes.join(', ');
        updateObj.$push = { auditTrail: auditTrailEntry };
      }

      const result = await db.collection('customPricing').updateOne(
        { _id: new ObjectId(pricingId) },
        { $set: updateObj, ...(updateObj.$push && { $push: updateObj.$push }) }
      );

      if (result.modifiedCount === 0) {
        throw new Error('No changes were made to the pricing record');
      }

      // Create audit log
      await auditService.createAuditLog({
        entityType: 'pricing',
        entityId: pricingId,
        action: 'update',
        performedBy: userEmail,
        organizationId: existingPricing.organizationId,
        details: {
          changes: changes.join(', '),
          supportItemNumber: existingPricing.supportItemNumber
        }
      });

      return await this.getPricingById(pricingId);
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Delete custom pricing (soft delete)
   */
  async deleteCustomPricing(pricingId, userEmail) {
    const db = await this.connect();
    
    try {
      const existingPricing = await db.collection('customPricing').findOne({
        _id: new ObjectId(pricingId),
        isActive: true
      });

      if (!existingPricing) {
        throw new Error('Pricing record not found');
      }

      const result = await db.collection('customPricing').updateOne(
        { _id: new ObjectId(pricingId) },
        {
          $set: {
            isActive: false,
            deletedBy: userEmail,
            deletedAt: new Date(),
            updatedBy: userEmail,
            updatedAt: new Date()
          },
          $push: {
            auditTrail: {
              action: 'deleted',
              performedBy: userEmail,
              timestamp: new Date(),
              changes: 'Soft delete - isActive set to false',
              reason: 'Pricing deletion'
            }
          }
        }
      );

      // Create audit log
      await auditService.createAuditLog({
        entityType: 'pricing',
        entityId: pricingId,
        action: 'delete',
        performedBy: userEmail,
        organizationId: existingPricing.organizationId,
        details: {
          supportItemNumber: existingPricing.supportItemNumber,
          supportItemName: existingPricing.supportItemName
        }
      });

      return result.modifiedCount > 0;
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Update pricing approval status
   */
  async updatePricingApproval(pricingId, approvalStatus, userEmail) {
    const db = await this.connect();
    
    try {
      const existingPricing = await db.collection('customPricing').findOne({
        _id: new ObjectId(pricingId),
        isActive: true
      });

      if (!existingPricing) {
        throw new Error('Pricing record not found');
      }

      const result = await db.collection('customPricing').updateOne(
        { _id: new ObjectId(pricingId) },
        {
          $set: {
            approvalStatus,
            updatedBy: userEmail,
            updatedAt: new Date()
          },
          $push: {
            auditTrail: {
              action: 'approval_updated',
              performedBy: userEmail,
              timestamp: new Date(),
              changes: `Approval status changed from ${existingPricing.approvalStatus} to ${approvalStatus}`,
              reason: 'Approval status update'
            }
          }
        }
      );

      // Create audit log
      await auditService.createAuditLog({
        entityType: 'pricing',
        entityId: pricingId,
        action: 'approval_update',
        performedBy: userEmail,
        organizationId: existingPricing.organizationId,
        details: {
          approvalStatus,
          supportItemNumber: existingPricing.supportItemNumber
        }
      });

      return await this.getPricingById(pricingId);
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Get pricing lookup for a single item
   */
  async getPricingLookup(organizationId, supportItemNumber, clientId = null) {
    const db = await this.connect();
    
    try {
      const currentDate = new Date();
      let clientIdForQuery = null;

      // Convert clientId to string for consistent querying
      if (clientId) {
        if (typeof clientId === 'string') {
          clientIdForQuery = clientId;
        } else if (clientId._id) {
          clientIdForQuery = clientId._id.toString();
        } else {
          clientIdForQuery = clientId.toString();
        }
      }

      // Priority 1: Client-specific pricing
      if (clientIdForQuery) {
        const clientSpecificPricing = await db.collection('customPricing').findOne({
          organizationId,
          supportItemNumber,
          clientId: clientIdForQuery,
          clientSpecific: true,
          isActive: true,
          approvalStatus: 'approved',
          effectiveDate: { $lte: currentDate },
          $or: [
            { expiryDate: null },
            { expiryDate: { $gte: currentDate } }
          ]
        }, {
          sort: { effectiveDate: -1 }
        });

        if (clientSpecificPricing) {
          return {
            ...clientSpecificPricing,
            price: clientSpecificPricing.customPrice,
            source: 'client_specific'
          };
        }
      }

      // Priority 2: Organization-level pricing
      const organizationPricing = await db.collection('customPricing').findOne({
        organizationId,
        supportItemNumber,
        clientSpecific: false,
        isActive: true,
        approvalStatus: 'approved',
        effectiveDate: { $lte: currentDate },
        $or: [
          { expiryDate: null },
          { expiryDate: { $gte: currentDate } }
        ]
      }, {
        sort: { effectiveDate: -1 }
      });

      if (organizationPricing) {
        return {
          ...organizationPricing,
          price: organizationPricing.customPrice,
          source: 'organization'
        };
      }

      // Priority 3: NDIS default pricing
      const ndisItem = await db.collection('supportItems').findOne({
        supportItemNumber
      });

      if (ndisItem) {
        const baseRate = 30.00;
        let priceCap = null;
        let exceedsNdisCap = false;
        let priceCapWarning = null;

        if (ndisItem.priceCaps?.standard?.NSW) {
          priceCap = ndisItem.priceCaps.standard.NSW;
          if (baseRate > priceCap) {
            exceedsNdisCap = true;
            priceCapWarning = `Base rate $${baseRate.toFixed(2)} exceeds NDIS price cap of $${priceCap.toFixed(2)} for NSW standard services`;
          }
        }

        return {
          source: 'ndis_default',
          supportItemNumber,
          supportItemName: ndisItem.supportItemName,
          price: baseRate,
          pricingType: 'fixed',
          ndisCompliant: !exceedsNdisCap,
          exceedsNdisCap,
          priceCap,
          priceCapWarning,
          priceCaps: ndisItem.priceCaps
        };
      }

      return null;
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Get bulk pricing lookup for multiple items
   */
  async getBulkPricingLookup(organizationId, supportItemNumbers, clientId = null) {
    const db = await this.connect();
    
    try {
      let clientIdForQuery = null;
      if (clientId) {
        if (typeof clientId === 'string') {
          clientIdForQuery = clientId;
        } else if (clientId._id) {
          clientIdForQuery = clientId._id.toString();
        } else {
          clientIdForQuery = clientId.toString();
        }
      }

      const currentDate = new Date();
      const results = {};

      // Build aggregation pipeline for efficient bulk lookup
      const customPricingPipeline = [
        {
          $match: {
            organizationId,
            supportItemNumber: { $in: supportItemNumbers },
            isActive: true,
            approvalStatus: 'approved',
            effectiveDate: { $lte: currentDate },
            $or: [
              { expiryDate: null },
              { expiryDate: { $gte: currentDate } }
            ]
          }
        },
        {
          $addFields: {
            priority: {
              $cond: {
                if: { $and: [{ $eq: ['$clientSpecific', true] }, { $eq: ['$clientId', clientIdForQuery] }] },
                then: 1,
                else: {
                  $cond: {
                    if: { $eq: ['$clientSpecific', false] },
                    then: 2,
                    else: 3
                  }
                }
              }
            }
          }
        },
        { $sort: { supportItemNumber: 1, priority: 1, effectiveDate: -1 } },
        {
          $group: {
            _id: '$supportItemNumber',
            pricing: { $first: '$$ROOT' }
          }
        }
      ];

      const customPricingResults = await db.collection('customPricing')
        .aggregate(customPricingPipeline)
        .toArray();

      // Map custom pricing results
      const customPricingMap = {};
      customPricingResults.forEach(result => {
        const pricing = result.pricing;
        customPricingMap[result._id] = {
          ...pricing,
          price: pricing.customPrice,
          source: pricing.clientSpecific ? 'client_specific' : 'organization'
        };
      });

      // Find items without custom pricing
      const itemsWithoutCustomPricing = supportItemNumbers.filter(
        itemNumber => !customPricingMap[itemNumber]
      );

      // Get NDIS default pricing for items without custom pricing
      let ndisDefaultPricing = {};
      let priceCapsData = {};

      const allNdisItems = await db.collection('supportItems')
        .find({ supportItemNumber: { $in: supportItemNumbers } })
        .toArray();

      allNdisItems.forEach(item => {
        priceCapsData[item.supportItemNumber] = {
          priceCaps: item.priceCaps,
          supportItemName: item.supportItemName
        };

        if (itemsWithoutCustomPricing.includes(item.supportItemNumber)) {
          const baseRate = 30.00;
          let priceCap = null;
          let exceedsNdisCap = false;
          let priceCapWarning = null;

          if (item.priceCaps?.standard?.NSW) {
            priceCap = item.priceCaps.standard.NSW;
            if (baseRate > priceCap) {
              exceedsNdisCap = true;
              priceCapWarning = `Base rate $${baseRate.toFixed(2)} exceeds NDIS price cap of $${priceCap.toFixed(2)} for NSW standard services`;
            }
          }

          ndisDefaultPricing[item.supportItemNumber] = {
            source: 'ndis_default',
            supportItemNumber: item.supportItemNumber,
            supportItemName: item.supportItemName,
            price: baseRate,
            pricingType: 'fixed',
            ndisCompliant: !exceedsNdisCap,
            exceedsNdisCap,
            priceCap,
            priceCapWarning,
            priceCaps: item.priceCaps
          };
        }
      });

      // Combine results
      supportItemNumbers.forEach(itemNumber => {
        if (customPricingMap[itemNumber]) {
          results[itemNumber] = {
            ...customPricingMap[itemNumber],
            priceCaps: priceCapsData[itemNumber]?.priceCaps,
            supportItemName: priceCapsData[itemNumber]?.supportItemName
          };
        } else if (ndisDefaultPricing[itemNumber]) {
          results[itemNumber] = ndisDefaultPricing[itemNumber];
        } else {
          results[itemNumber] = {
            error: 'No pricing found for this support item',
            supportItemNumber: itemNumber,
            priceCaps: priceCapsData[itemNumber]?.priceCaps,
            supportItemName: priceCapsData[itemNumber]?.supportItemName
          };
        }
      });

      return {
        data: results,
        metadata: {
          totalItems: supportItemNumbers.length,
          customPricingItems: Object.keys(customPricingMap).length,
          ndisDefaultItems: Object.keys(ndisDefaultPricing).length,
          notFoundItems: supportItemNumbers.length - Object.keys(customPricingMap).length - Object.keys(ndisDefaultPricing).length
        }
      };
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Bulk import pricing records
   */
  async bulkImportPricing(organizationId, pricingRecords, userEmail, importNotes = null) {
    const db = await this.connect();
    
    try {
      const results = {
        successful: 0,
        failed: 0,
        errors: []
      };

      const bulkOps = [];
      const updateOps = [];

      for (let i = 0; i < pricingRecords.length; i++) {
        const record = pricingRecords[i];

        try {
          // Validate required fields
          if (!record.supportItemNumber || !record.supportItemName || !record.pricingType) {
            results.failed++;
            results.errors.push({
              row: i + 1,
              error: 'Missing required fields: supportItemNumber, supportItemName, pricingType'
            });
            continue;
          }

          const isClientSpecific = record.clientSpecific || false;
          const targetClientId = isClientSpecific ? record.clientId : null;

          // Check for existing pricing
          const duplicateCheckQuery = {
            organizationId,
            supportItemNumber: record.supportItemNumber,
            clientSpecific: isClientSpecific,
            isActive: true
          };

          if (isClientSpecific) {
            duplicateCheckQuery.clientId = targetClientId;
          } else {
            duplicateCheckQuery.clientId = null;
          }

          const existingCustomPricing = await db.collection('customPricing').findOne(duplicateCheckQuery);

          if (existingCustomPricing) {
            const newPrice = record.pricingType === 'fixed' ? record.customPrice : record.multiplier;
            const existingPrice = existingCustomPricing.pricingType === 'fixed' ? existingCustomPricing.customPrice : existingCustomPricing.multiplier;

            if (newPrice !== existingPrice) {
              updateOps.push({
                updateOne: {
                  filter: { _id: existingCustomPricing._id },
                  update: {
                    $set: {
                      pricingType: record.pricingType,
                      customPrice: record.pricingType === 'fixed' ? record.customPrice : null,
                      multiplier: record.pricingType === 'multiplier' ? record.multiplier : null,
                      updatedBy: userEmail,
                      updatedAt: new Date(),
                      version: (existingCustomPricing.version || 1) + 1
                    },
                    $push: {
                      auditTrail: {
                        action: 'bulk_updated',
                        performedBy: userEmail,
                        timestamp: new Date(),
                        changes: `Price updated from ${existingPrice} to ${newPrice} via bulk import`,
                        reason: importNotes || 'Bulk import operation'
                      }
                    }
                  }
                }
              });
            }
            results.successful++;
            continue;
          }

          // Create new pricing record
          const pricingDoc = {
            _id: new ObjectId(),
            organizationId,
            supportItemNumber: record.supportItemNumber,
            supportItemName: record.supportItemName,
            pricingType: record.pricingType,
            customPrice: record.pricingType === 'fixed' ? record.customPrice : null,
            multiplier: record.pricingType === 'multiplier' ? record.multiplier : null,
            clientId: targetClientId,
            clientSpecific: isClientSpecific,
            ndisCompliant: record.ndisCompliant !== undefined ? record.ndisCompliant : true,
            exceedsNdisCap: record.exceedsNdisCap || false,
            approvalStatus: record.exceedsNdisCap ? 'pending' : 'approved',
            effectiveDate: record.effectiveDate ? new Date(record.effectiveDate) : new Date(),
            expiryDate: record.expiryDate ? new Date(record.expiryDate) : null,
            createdBy: userEmail,
            createdAt: new Date(),
            updatedBy: userEmail,
            updatedAt: new Date(),
            isActive: true,
            version: 1,
            auditTrail: [{
              action: 'bulk_imported',
              performedBy: userEmail,
              timestamp: new Date(),
              changes: 'Bulk import',
              reason: importNotes || 'Bulk import operation'
            }]
          };

          bulkOps.push({
            insertOne: {
              document: pricingDoc
            }
          });

          results.successful++;
        } catch (error) {
          results.failed++;
          results.errors.push({
            row: i + 1,
            error: error.message
          });
        }
      }

      // Execute bulk operations
      if (bulkOps.length > 0) {
        await db.collection('customPricing').bulkWrite(bulkOps, { ordered: false });
      }

      if (updateOps.length > 0) {
        await db.collection('customPricing').bulkWrite(updateOps, { ordered: false });
      }

      return results;
    } finally {
      await this.disconnect();
    }
  }

  /**
   * Validate user authorization for organization
   */
  async validateUserAuthorization(userEmail, organizationId) {
    const db = await this.connect();
    
    try {
      const user = await db.collection('login').findOne({
        email: userEmail,
        organizationId
      });

      return !!user;
    } finally {
      await this.disconnect();
    }
  }
}

module.exports = new PricingService();