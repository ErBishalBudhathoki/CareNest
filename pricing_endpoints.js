/**
 * Custom Pricing Management API Endpoints
 * Provides CRUD operations for the customPricing collection
 * Supports multi-tenant pricing with NDIS compliance and approval workflows
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '.env') });
const { createAuditLog, AUDIT_ACTIONS, AUDIT_ENTITIES } = require('./services/auditService');

const uri = process.env.MONGODB_URI;

/**
 * Create a new custom pricing record
 * POST /api/pricing/create
 */
async function createCustomPricing(req, res) {
  let client;
  
  try {
    const {
      organizationId,
      supportItemNumber,
      supportItemName,
      pricingType, // 'fixed' or 'multiplier'
      customPrice,
      multiplier,
      clientId,
      clientSpecific = false,
      ndisCompliant = true,
      exceedsNdisCap = false,
      effectiveDate,
      expiryDate,
      userEmail
    } = req.body;

    // Validation
    if (!organizationId || !supportItemNumber || !supportItemName || !pricingType || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Missing required fields: organizationId, supportItemNumber, supportItemName, pricingType, userEmail'
      });
    }

    if (pricingType === 'fixed' && !customPrice) {
      return res.status(400).json({
        statusCode: 400,
        message: 'customPrice is required for fixed pricing type'
      });
    }

    if (pricingType === 'multiplier' && !multiplier) {
      return res.status(400).json({
        statusCode: 400,
        message: 'multiplier is required for multiplier pricing type'
      });
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: organizationId
    });

    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
    }

    // Check for existing pricing record
    const existingQuery = {
      organizationId: organizationId,
      supportItemNumber: supportItemNumber,
      isActive: true
    };

    if (clientSpecific && clientId) {
      existingQuery.clientId = clientId;
    } else {
      existingQuery.clientSpecific = false;
    }

    const existingPricing = await db.collection('customPricing').findOne(existingQuery);
    
    if (existingPricing) {
      return res.status(409).json({
        statusCode: 409,
        message: 'Active pricing record already exists for this item and scope'
      });
    }

    // Create pricing document
    const pricingDoc = {
      _id: new ObjectId(),
      organizationId: organizationId,
      supportItemNumber: supportItemNumber,
      supportItemName: supportItemName,
      pricingType: pricingType,
      customPrice: pricingType === 'fixed' ? customPrice : null,
      multiplier: pricingType === 'multiplier' ? multiplier : null,
      clientId: clientSpecific ? clientId : null,
      clientSpecific: clientSpecific,
      ndisCompliant: ndisCompliant,
      exceedsNdisCap: exceedsNdisCap,
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
        changes: 'Initial pricing record creation'
      }]
    };

    const result = await db.collection('customPricing').insertOne(pricingDoc);

    // Create audit log for pricing creation
    try {
      await createAuditLog({
        action: AUDIT_ACTIONS.CREATE,
        entityType: AUDIT_ENTITIES.PRICING,
        entityId: result.insertedId.toString(),
        userEmail,
        organizationId,
        newValues: pricingDoc,
        reason: 'Custom pricing record created',
        metadata: {
          supportItemNumber,
          supportItemName,
          pricingType,
          customPrice,
          exceedsNdisCap
        }
      });
    } catch (auditError) {
      console.error('Error creating audit log for pricing creation:', auditError);
      // Don't fail the main operation if audit logging fails
    }

    res.status(201).json({
      statusCode: 201,
      message: 'Custom pricing created successfully',
      pricingId: result.insertedId.toString(),
      approvalRequired: exceedsNdisCap
    });

  } catch (error) {
    console.error('Error creating custom pricing:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error creating custom pricing'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get pricing records for an organization
 * GET /api/pricing/organization/:organizationId
 */
async function getOrganizationPricing(req, res) {
  let client;
  
  try {
    const { organizationId } = req.params;
    const { 
      clientId, 
      supportItemNumber, 
      approvalStatus, 
      isActive = 'true',
      page = 1,
      limit = 50,
      search
    } = req.query;

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Build query
    const query = { organizationId: organizationId };
    
    if (clientId) {
      query.clientId = clientId;
    }
    
    if (supportItemNumber) {
      query.supportItemNumber = supportItemNumber;
    }
    
    if (approvalStatus) {
      query.approvalStatus = approvalStatus;
    }
    
    if (isActive !== 'all') {
      query.isActive = isActive === 'true';
    }
    
    if (search) {
      query.$or = [
        { supportItemName: { $regex: search, $options: 'i' } },
        { supportItemNumber: { $regex: search, $options: 'i' } }
      ];
    }

    // Calculate pagination
    const skip = (parseInt(page) - 1) * parseInt(limit);
    
    // Get total count
    const totalCount = await db.collection('customPricing').countDocuments(query);
    
    // Get pricing records
    const pricingRecords = await db.collection('customPricing')
      .find(query)
      .sort({ createdAt: -1 })
      .skip(skip)
      .limit(parseInt(limit))
      .toArray();

    res.status(200).json({
      statusCode: 200,
      data: pricingRecords,
      pagination: {
        currentPage: parseInt(page),
        totalPages: Math.ceil(totalCount / parseInt(limit)),
        totalRecords: totalCount,
        hasNext: skip + pricingRecords.length < totalCount,
        hasPrev: parseInt(page) > 1
      }
    });

  } catch (error) {
    console.error('Error getting organization pricing:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error retrieving pricing records'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get specific pricing record by ID
 * GET /api/pricing/:pricingId
 */
async function getPricingById(req, res) {
  let client;
  
  try {
    const { pricingId } = req.params;
    
    if (!ObjectId.isValid(pricingId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid pricing ID format'
      });
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    const pricingRecord = await db.collection('customPricing').findOne({
      _id: new ObjectId(pricingId)
    });

    if (!pricingRecord) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Pricing record not found'
      });
    }

    res.status(200).json({
      statusCode: 200,
      data: pricingRecord
    });

  } catch (error) {
    console.error('Error getting pricing by ID:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error retrieving pricing record'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Update existing pricing record
 * PUT /api/pricing/:pricingId
 */
async function updateCustomPricing(req, res) {
  let client;
  
  try {
    const { pricingId } = req.params;
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
      expiryDate,
      userEmail,
      updateReason
    } = req.body;

    if (!ObjectId.isValid(pricingId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid pricing ID format'
      });
    }

    if (!userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'userEmail is required'
      });
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Get existing record
    const existingRecord = await db.collection('customPricing').findOne({
      _id: new ObjectId(pricingId)
    });

    if (!existingRecord) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Pricing record not found'
      });
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
    }

    // Build update object
    const updateDoc = {
      updatedBy: userEmail,
      updatedAt: new Date(),
      version: existingRecord.version + 1
    };

    // Track changes for audit trail
    const changes = [];
    
    if (supportItemName && supportItemName !== existingRecord.supportItemName) {
      updateDoc.supportItemName = supportItemName;
      changes.push(`supportItemName: ${existingRecord.supportItemName} → ${supportItemName}`);
    }
    
    if (pricingType && pricingType !== existingRecord.pricingType) {
      updateDoc.pricingType = pricingType;
      changes.push(`pricingType: ${existingRecord.pricingType} → ${pricingType}`);
    }
    
    if (customPrice !== undefined) {
      updateDoc.customPrice = customPrice;
      changes.push(`customPrice updated`);
    }
    
    if (multiplier !== undefined) {
      updateDoc.multiplier = multiplier;
      changes.push(`multiplier updated`);
    }
    
    if (clientId !== undefined) {
      updateDoc.clientId = clientId;
      changes.push(`clientId: ${existingRecord.clientId} → ${clientId}`);
    }
    
    if (clientSpecific !== undefined) {
      updateDoc.clientSpecific = clientSpecific;
      changes.push(`clientSpecific: ${existingRecord.clientSpecific} → ${clientSpecific}`);
    }
    
    if (ndisCompliant !== undefined) {
      updateDoc.ndisCompliant = ndisCompliant;
      changes.push(`ndisCompliant: ${existingRecord.ndisCompliant} → ${ndisCompliant}`);
    }
    
    if (exceedsNdisCap !== undefined) {
      updateDoc.exceedsNdisCap = exceedsNdisCap;
      // If exceeds NDIS cap changes, update approval status
      if (exceedsNdisCap && !existingRecord.exceedsNdisCap) {
        updateDoc.approvalStatus = 'pending';
        changes.push(`approvalStatus: ${existingRecord.approvalStatus} → pending (due to NDIS cap exceeded)`);
      }
      changes.push(`exceedsNdisCap: ${existingRecord.exceedsNdisCap} → ${exceedsNdisCap}`);
    }
    
    if (effectiveDate) {
      updateDoc.effectiveDate = new Date(effectiveDate);
      changes.push(`effectiveDate updated`);
    }
    
    if (expiryDate) {
      updateDoc.expiryDate = new Date(expiryDate);
      changes.push(`expiryDate updated`);
    }

    // Add audit trail entry
    const auditEntry = {
      action: 'updated',
      performedBy: userEmail,
      timestamp: new Date(),
      changes: changes.join(', '),
      reason: updateReason || 'No reason provided'
    };

    updateDoc.$push = {
      auditTrail: auditEntry
    };

    // Perform update
    const result = await db.collection('customPricing').updateOne(
      { _id: new ObjectId(pricingId) },
      { $set: updateDoc, $push: updateDoc.$push }
    );

    if (result.matchedCount === 0) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Pricing record not found'
      });
    }

    // Create audit log for pricing update
    try {
      await createAuditLog({
        action: AUDIT_ACTIONS.UPDATE,
        entityType: AUDIT_ENTITIES.PRICING,
        entityId: pricingId,
        userEmail,
        organizationId: existingRecord.organizationId,
        oldValues: existingRecord,
        newValues: updateDoc,
        reason: updateReason || 'Pricing record updated',
        metadata: {
          changesCount: changes.length,
          changes: changes.join(', '),
          approvalRequired: updateDoc.exceedsNdisCap
        }
      });
    } catch (auditError) {
      console.error('Error creating audit log for pricing update:', auditError);
      // Don't fail the main operation if audit logging fails
    }

    res.status(200).json({
      statusCode: 200,
      message: 'Pricing record updated successfully',
      changesCount: changes.length,
      approvalRequired: updateDoc.exceedsNdisCap
    });

  } catch (error) {
    console.error('Error updating custom pricing:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error updating pricing record'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Delete (deactivate) pricing record
 * DELETE /api/pricing/:pricingId
 */
async function deleteCustomPricing(req, res) {
  let client;
  
  try {
    const { pricingId } = req.params;
    const { userEmail, deleteReason } = req.body;

    if (!ObjectId.isValid(pricingId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid pricing ID format'
      });
    }

    if (!userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'userEmail is required'
      });
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Get existing record
    const existingRecord = await db.collection('customPricing').findOne({
      _id: new ObjectId(pricingId)
    });

    if (!existingRecord) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Pricing record not found'
      });
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
    }

    // Soft delete by setting isActive to false
    const auditEntry = {
      action: 'deleted',
      performedBy: userEmail,
      timestamp: new Date(),
      changes: 'Pricing record deactivated',
      reason: deleteReason || 'No reason provided'
    };

    const result = await db.collection('customPricing').updateOne(
      { _id: new ObjectId(pricingId) },
      {
        $set: {
          isActive: false,
          deletedBy: userEmail,
          deletedAt: new Date(),
          updatedBy: userEmail,
          updatedAt: new Date(),
          version: existingRecord.version + 1
        },
        $push: {
          auditTrail: auditEntry
        }
      }
    );

    if (result.matchedCount === 0) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Pricing record not found'
      });
    }

    // Create audit log for pricing deletion
    try {
      await createAuditLog({
        action: AUDIT_ACTIONS.DELETE,
        entityType: AUDIT_ENTITIES.PRICING,
        entityId: pricingId,
        userEmail,
        organizationId: existingRecord.organizationId,
        oldValues: existingRecord,
        reason: deleteReason || 'Pricing record deleted',
        metadata: {
          supportItemNumber: existingRecord.supportItemNumber,
          supportItemName: existingRecord.supportItemName,
          customPrice: existingRecord.customPrice
        }
      });
    } catch (auditError) {
      console.error('Error creating audit log for pricing deletion:', auditError);
      // Don't fail the main operation if audit logging fails
    }

    res.status(200).json({
      statusCode: 200,
      message: 'Pricing record deleted successfully'
    });

  } catch (error) {
    console.error('Error deleting custom pricing:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error deleting pricing record'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Update approval status for pricing record
 * PUT /api/pricing/:pricingId/approval
 */
async function updatePricingApproval(req, res) {
  let client;
  
  try {
    const { pricingId } = req.params;
    const { approvalStatus, userEmail, approvalNotes } = req.body;

    if (!ObjectId.isValid(pricingId)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'Invalid pricing ID format'
      });
    }

    if (!approvalStatus || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'approvalStatus and userEmail are required'
      });
    }

    if (!['pending', 'approved', 'rejected'].includes(approvalStatus)) {
      return res.status(400).json({
        statusCode: 400,
        message: 'approvalStatus must be pending, approved, or rejected'
      });
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Get existing record
    const existingRecord = await db.collection('customPricing').findOne({
      _id: new ObjectId(pricingId)
    });

    if (!existingRecord) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Pricing record not found'
      });
    }

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: existingRecord.organizationId
    });

    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
    }

    // Add audit trail entry
    const auditEntry = {
      action: 'approval_updated',
      performedBy: userEmail,
      timestamp: new Date(),
      changes: `approvalStatus: ${existingRecord.approvalStatus} → ${approvalStatus}`,
      reason: approvalNotes || 'No notes provided'
    };

    const updateDoc = {
      approvalStatus: approvalStatus,
      approvedBy: approvalStatus === 'approved' ? userEmail : existingRecord.approvedBy,
      approvedAt: approvalStatus === 'approved' ? new Date() : existingRecord.approvedAt,
      rejectedBy: approvalStatus === 'rejected' ? userEmail : existingRecord.rejectedBy,
      rejectedAt: approvalStatus === 'rejected' ? new Date() : existingRecord.rejectedAt,
      approvalNotes: approvalNotes,
      updatedBy: userEmail,
      updatedAt: new Date(),
      version: existingRecord.version + 1
    };

    const result = await db.collection('customPricing').updateOne(
      { _id: new ObjectId(pricingId) },
      {
        $set: updateDoc,
        $push: {
          auditTrail: auditEntry
        }
      }
    );

    if (result.matchedCount === 0) {
      return res.status(404).json({
        statusCode: 404,
        message: 'Pricing record not found'
      });
    }

    // Create audit log for approval status change
    try {
      await createAuditLog({
        action: AUDIT_ACTIONS.APPROVE,
        entityType: AUDIT_ENTITIES.PRICING,
        entityId: pricingId,
        userEmail,
        organizationId: existingRecord.organizationId,
        oldValues: { approvalStatus: existingRecord.approvalStatus },
        newValues: { approvalStatus: approvalStatus },
        reason: approvalNotes || `Pricing record ${approvalStatus}`,
        metadata: {
          previousStatus: existingRecord.approvalStatus,
          newStatus: approvalStatus,
          supportItemNumber: existingRecord.supportItemNumber,
          customPrice: existingRecord.customPrice
        }
      });
    } catch (auditError) {
      console.error('Error creating audit log for pricing approval:', auditError);
      // Don't fail the main operation if audit logging fails
    }

    res.status(200).json({
      statusCode: 200,
      message: `Pricing record ${approvalStatus} successfully`,
      approvalStatus: approvalStatus
    });

  } catch (error) {
    console.error('Error updating pricing approval:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error updating approval status'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get pricing lookup for invoice generation
 * GET /api/pricing/lookup/:organizationId/:supportItemNumber
 */
async function getPricingLookup(req, res) {
  let client;
  
  try {
    const { organizationId, supportItemNumber } = req.params;
    const { clientId } = req.query;
    
    console.log('🔍 PRICING LOOKUP CALLED:', {
      organizationId,
      supportItemNumber,
      clientId,
      timestamp: new Date().toISOString()
    });

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    const currentDate = new Date();
    
    // Priority order: client-specific → organization-level → NDIS default
    const queries = [];
    
    // 1. Client-specific pricing (highest priority)
    if (clientId) {
      queries.push({
        organizationId: organizationId,
        supportItemNumber: supportItemNumber,
        clientId: clientId,
        clientSpecific: true,
        isActive: true,
        approvalStatus: 'approved',
        effectiveDate: { $lte: currentDate },
        $or: [
          { expiryDate: null },
          { expiryDate: { $gte: currentDate } }
        ]
      });
    }
    
    // 2. Organization-level pricing
    queries.push({
      organizationId: organizationId,
      supportItemNumber: supportItemNumber,
      clientSpecific: false,
      isActive: true,
      approvalStatus: 'approved',
      effectiveDate: { $lte: currentDate },
      $or: [
        { expiryDate: null },
        { expiryDate: { $gte: currentDate } }
      ]
    });

    let pricingRecord = null;
    
    // Try each query in priority order
    for (const query of queries) {
      pricingRecord = await db.collection('customPricing')
        .findOne(query, { sort: { effectiveDate: -1 } });
      
      if (pricingRecord) {
        break;
      }
    }

    if (!pricingRecord) {
      console.log('❌ No custom pricing found, falling back to NDIS default');
      // Fallback to NDIS default pricing
      const ndisItem = await db.collection('supportItems').findOne({
        supportItemNumber: supportItemNumber
      });
      
      if (ndisItem) {
        // Get price from priceCaps structure (default to NSW standard pricing)
        let price = null;
        if (ndisItem.priceCaps && ndisItem.priceCaps.standard && ndisItem.priceCaps.standard.NSW) {
          price = ndisItem.priceCaps.standard.NSW;
        } else if (ndisItem.price) {
          // Fallback to direct price field if it exists
          price = ndisItem.price;
        }
        
        if (price !== null) {
          console.log('✅ NDIS default pricing found:', {
            supportItemNumber,
            price: price,
            supportItemName: ndisItem.supportItemName,
            priceCapsAvailable: !!ndisItem.priceCaps
          });
          return res.status(200).json({
            statusCode: 200,
            data: {
              source: 'ndis_default',
              supportItemNumber: supportItemNumber,
              supportItemName: ndisItem.supportItemName,
              price: price,
              pricingType: 'fixed',
              ndisCompliant: true,
              exceedsNdisCap: false
            }
          });
        } else {
          console.log('❌ No pricing found for:', supportItemNumber, '- missing both priceCaps and price field');
        }
      } else {
        console.log('❌ No NDIS default pricing found for:', supportItemNumber);
        return res.status(404).json({
          statusCode: 404,
          message: 'No pricing found for this support item'
        });
      }
    }

    // Determine source type
    let source = 'organization';
    if (pricingRecord.clientSpecific) {
      source = 'client_specific';
    }
    
    console.log('✅ Custom pricing found:', {
      source,
      supportItemNumber,
      price: pricingRecord.customPrice || pricingRecord.price,
      pricingType: pricingRecord.pricingType
    });

    res.status(200).json({
      statusCode: 200,
      data: {
        ...pricingRecord,
        source: source
      }
    });

  } catch (error) {
    console.error('Error getting pricing lookup:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error retrieving pricing information'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Get bulk pricing lookup for multiple NDIS items
 * POST /api/pricing/bulk-lookup
 * Body: { organizationId, supportItemNumbers: [], clientId? }
 */
async function getBulkPricingLookup(req, res) {
  let client;
  
  try {
    const { organizationId, supportItemNumbers, clientId } = req.body;
    
    if (!organizationId || !Array.isArray(supportItemNumbers) || supportItemNumbers.length === 0) {
      return res.status(400).json({
        statusCode: 400,
        message: 'organizationId and supportItemNumbers array are required'
      });
    }

    // Convert clientId to string to match how it's stored in customPricing collection
    let clientIdForQuery;
    if (typeof clientId === 'string') {
      clientIdForQuery = clientId;
    } else if (clientId && clientId._id) {
      clientIdForQuery = clientId._id.toString();
    } else if (clientId && clientId.toString) {
      clientIdForQuery = clientId.toString();
    } else {
      clientIdForQuery = clientId;
    }

    console.log('🔍 BULK PRICING LOOKUP CALLED:', {
      organizationId,
      itemCount: supportItemNumbers.length,
      clientId: clientIdForQuery,
      timestamp: new Date().toISOString()
    });

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    const currentDate = new Date();
    const results = {};
    
    // Build aggregation pipeline for efficient bulk lookup
    const customPricingPipeline = [];
    
    // Match conditions for custom pricing
    const matchConditions = {
      organizationId: organizationId,
      supportItemNumber: { $in: supportItemNumbers },
      isActive: true,
      approvalStatus: 'approved',
      effectiveDate: { $lte: currentDate },
      $or: [
        { expiryDate: null },
        { expiryDate: { $gte: currentDate } }
      ]
    };
    
    customPricingPipeline.push({ $match: matchConditions });
    
    // Sort by priority: client-specific first, then organization-level
    customPricingPipeline.push({
      $addFields: {
        priority: {
          $cond: {
            if: { $and: [{ $eq: ['$clientSpecific', true] }, { $eq: ['$clientId', clientIdForQuery] }] },
            then: 1, // Client-specific (highest priority)
            else: {
              $cond: {
                if: { $eq: ['$clientSpecific', false] },
                then: 2, // Organization-level
                else: 3  // Other (lowest priority)
              }
            }
          }
        }
      }
    });
    
    customPricingPipeline.push({ $sort: { supportItemNumber: 1, priority: 1, effectiveDate: -1 } });
    
    // Group by supportItemNumber to get the highest priority pricing for each item
    customPricingPipeline.push({
      $group: {
        _id: '$supportItemNumber',
        pricing: { $first: '$$ROOT' }
      }
    });
    
    // Execute custom pricing lookup
    const customPricingResults = await db.collection('customPricing')
      .aggregate(customPricingPipeline)
      .toArray();
    
    // Map custom pricing results
    const customPricingMap = {};
    customPricingResults.forEach(result => {
      const pricing = result.pricing;
      console.log(`📋 Custom pricing found for ${result._id}:`, {
        customPrice: pricing.customPrice,
        clientSpecific: pricing.clientSpecific,
        clientId: pricing.clientId,
        organizationId: pricing.organizationId
      });
      customPricingMap[result._id] = {
        ...pricing,
        price: pricing.customPrice, // Use customPrice field for consistency
        source: pricing.clientSpecific ? 'client_specific' : 'organization'
      };
    });
    
    // Find items that don't have custom pricing
    const itemsWithoutCustomPricing = supportItemNumbers.filter(
      itemNumber => !customPricingMap[itemNumber]
    );
    
    // Fetch NDIS default pricing and price caps for all items (both with and without custom pricing)
    let ndisDefaultPricing = {};
    let priceCapsData = {};
    
    // Get supportItems data for all requested items to include price caps
    const allNdisItems = await db.collection('supportItems')
      .find({ supportItemNumber: { $in: supportItemNumbers } })
      .toArray();
    
    allNdisItems.forEach(item => {
      // Store price caps data for all items
      priceCapsData[item.supportItemNumber] = {
        priceCaps: item.priceCaps,
        supportItemName: item.supportItemName
      };
      
      // Only set default pricing for items without custom pricing
      if (itemsWithoutCustomPricing.includes(item.supportItemNumber)) {
        // Use $30.00 base rate as specified in requirements
        const baseRate = 30.00;
        let priceCap = null;
        let exceedsNdisCap = false;
        let priceCapWarning = null;
        
        // Get price cap for validation if available
        if (item.priceCaps && item.priceCaps.standard && item.priceCaps.standard.NSW) {
          priceCap = item.priceCaps.standard.NSW;
          if (baseRate > priceCap) {
            exceedsNdisCap = true;
            priceCapWarning = `Base rate $${baseRate.toFixed(2)} exceeds NDIS price cap of $${priceCap.toFixed(2)} for NSW standard services`;
          }
        }
        
        console.log(`📋 Base rate pricing for ${item.supportItemNumber}:`, {
          baseRate: baseRate,
          supportItemName: item.supportItemName,
          priceCap: priceCap,
          exceedsNdisCap: exceedsNdisCap,
          priceCapWarning: priceCapWarning
        });
        
        ndisDefaultPricing[item.supportItemNumber] = {
          source: 'base-rate',
          supportItemNumber: item.supportItemNumber,
          supportItemName: item.supportItemName,
          price: baseRate,
          pricingType: 'fixed',
          ndisCompliant: !exceedsNdisCap,
          exceedsNdisCap: exceedsNdisCap,
          priceCap: priceCap,
          priceCapWarning: priceCapWarning,
          priceCaps: item.priceCaps
        };
      }
    });
    
    // Combine results with price caps data
    supportItemNumbers.forEach(itemNumber => {
      if (customPricingMap[itemNumber]) {
        // Add price caps data to custom pricing for comparison
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
    
    console.log('✅ Bulk pricing lookup completed:', {
      totalItems: supportItemNumbers.length,
      customPricing: Object.keys(customPricingMap).length,
      ndisDefault: Object.keys(ndisDefaultPricing).length,
      notFound: supportItemNumbers.length - Object.keys(customPricingMap).length - Object.keys(ndisDefaultPricing).length
    });

    res.status(200).json({
      statusCode: 200,
      data: results,
      metadata: {
        totalItems: supportItemNumbers.length,
        customPricingItems: Object.keys(customPricingMap).length,
        ndisDefaultItems: Object.keys(ndisDefaultPricing).length,
        notFoundItems: supportItemNumbers.length - Object.keys(customPricingMap).length - Object.keys(ndisDefaultPricing).length
      }
    });

  } catch (error) {
    console.error('Error getting bulk pricing lookup:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error retrieving bulk pricing information'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

/**
 * Bulk import pricing records
 * POST /api/pricing/bulk-import
 */
async function bulkImportPricing(req, res) {
  let client;
  
  try {
    const { organizationId, pricingRecords, userEmail, importNotes } = req.body;

    if (!organizationId || !pricingRecords || !Array.isArray(pricingRecords) || !userEmail) {
      return res.status(400).json({
        statusCode: 400,
        message: 'organizationId, pricingRecords array, and userEmail are required'
      });
    }

    // Connect to MongoDB
    client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
    await client.connect();
    const db = client.db('Invoice');

    // Verify user belongs to organization
    const user = await db.collection('login').findOne({
      email: userEmail,
      organizationId: organizationId
    });

    if (!user) {
      return res.status(403).json({
        statusCode: 403,
        message: 'User not authorized for this organization'
      });
    }

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

        // Determine if this is client-specific pricing
        const isClientSpecific = record.clientSpecific || false;
        const targetClientId = isClientSpecific ? record.clientId : null;
        
        // Build the query to check for existing custom pricing
        const duplicateCheckQuery = {
          organizationId: organizationId,
          supportItemNumber: record.supportItemNumber,
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
        
        // Check if custom pricing already exists
        const existingCustomPricing = await db.collection('customPricing').findOne(duplicateCheckQuery);
        
        if (existingCustomPricing) {
          // Check if the price is different
          const newPrice = record.pricingType === 'fixed' ? record.customPrice : record.multiplier;
          const existingPrice = existingCustomPricing.pricingType === 'fixed' ? existingCustomPricing.customPrice : existingCustomPricing.multiplier;
          
          if (newPrice !== existingPrice) {
            // Update existing record with new price
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
            results.successful++;
          } else {
            // Same price exists, skip
            console.log(`Skipping duplicate pricing for ${record.supportItemNumber} - same price already exists`);
            results.successful++; // Count as successful since no action needed
          }
          continue;
        }

        const pricingDoc = {
          _id: new ObjectId(),
          organizationId: organizationId,
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
    
    // Execute update operations
    if (updateOps.length > 0) {
      await db.collection('customPricing').bulkWrite(updateOps, { ordered: false });
    }

    res.status(200).json({
      statusCode: 200,
      message: 'Bulk import completed',
      results: results
    });

  } catch (error) {
    console.error('Error bulk importing pricing:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error performing bulk import'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
}

module.exports = {
  createCustomPricing,
  getOrganizationPricing,
  getPricingById,
  updateCustomPricing,
  deleteCustomPricing,
  updatePricingApproval,
  getPricingLookup,
  getBulkPricingLookup,
  bulkImportPricing
};