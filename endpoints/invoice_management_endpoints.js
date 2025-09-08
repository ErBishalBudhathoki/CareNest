/**
 * Invoice Management Endpoints
 * Provides API endpoints for managing generated invoices
 * Supports listing, viewing, sharing, and deleting invoices with organization-based access control
 */

const { InvoiceManagementService } = require('../services/invoiceManagementService');
const logger = require('../config/logger');

// Initialize service
const invoiceManagementService = new InvoiceManagementService();

/**
 * Get paginated list of invoices for an organization
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 */
async function getInvoicesList(req, res) {
  try {
    const {
      organizationId,
      page = 1,
      limit = 20,
      status,
      clientEmail,
      paymentStatus,
      dateFrom,
      dateTo,
      sortBy = 'auditTrail.createdAt',
      sortOrder = 'desc',
      searchTerm
    } = req.query;

    // Validate organization access
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        error: 'Organization ID is required'
      });
    }

    // Prepare filters and pagination
    const filters = {
      status,
      clientEmail,
      paymentStatus,
      dateFrom,
      dateTo,
      searchTerm
    };

    const pagination = {
      page: parseInt(page),
      limit: parseInt(limit),
      sortBy,
      sortOrder: sortOrder === 'desc' ? -1 : 1
    };

    // Use service to get invoices list
    const result = await invoiceManagementService.getInvoicesList(
      organizationId,
      filters,
      pagination
    );

    if (!result.success) {
      return res.status(500).json(result);
    }

    // Log access for audit trail
    logger.info(`Invoice list accessed for organization: ${organizationId}`, {
      organizationId,
      page,
      limit,
      totalCount: result.data.pagination.totalCount,
      filters
    });

    res.json(result);

  } catch (error) {
    logger.error('Error getting invoices list:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to retrieve invoices list',
      details: error.message
    });
  }
}

/**
 * Get detailed view of a specific invoice
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 */
async function getInvoiceDetails(req, res) {
  try {
    const { invoiceId } = req.params;
    const { organizationId } = req.query;

    if (!invoiceId || !organizationId) {
      return res.status(400).json({
        success: false,
        error: 'Invoice ID and Organization ID are required'
      });
    }

    // Use service to get invoice details
    const result = await invoiceManagementService.getInvoiceDetails(
      invoiceId,
      organizationId
    );

    if (!result.success) {
      const statusCode = result.error.includes('not found') ? 404 : 500;
      return res.status(statusCode).json(result);
    }

    res.json(result);

  } catch (error) {
    logger.error('Error getting invoice details:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to retrieve invoice details',
      details: error.message
    });
  }
}

/**
 * Share an invoice with external parties
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 */
async function shareInvoice(req, res) {
  try {
    const { invoiceId } = req.params;
    const {
      organizationId,
      shareMethod,
      recipientEmail,
      userEmail,
      message,
      expiryDays = 30
    } = req.body;

    // Check if this is a PDF sharing request
    const isPdfRequest = req.path.includes('/share/pdf');
    
    if (isPdfRequest) {
      // Handle PDF sharing request
      const result = await invoiceManagementService.getInvoicePdf(
        invoiceId,
        organizationId
      );
      
      if (!result.success) {
        const statusCode = result.error.includes('not found') ? 404 : 500;
        return res.status(statusCode).json(result);
      }
      
      // Return PDF data as base64
      return res.json({
        success: true,
        data: {
          pdfData: result.data.pdfData,
          filename: result.data.filename || `invoice-${invoiceId}.pdf`,
          mimeType: 'application/pdf'
        }
      });
    }

    if (!invoiceId || !organizationId) {
      return res.status(400).json({
        success: false,
        error: 'Invoice ID and Organization ID are required'
      });
    }

    if (!shareMethod || !['email', 'link'].includes(shareMethod)) {
      return res.status(400).json({
        success: false,
        error: 'Valid share method is required (email or link)'
      });
    }

    // Prepare share options
    const shareOptions = {
      shareMethod,
      recipientEmail,
      userEmail,
      message,
      expiryDays
    };

    // Use service to share invoice
    const result = await invoiceManagementService.shareInvoice(
      invoiceId,
      organizationId,
      shareOptions
    );

    if (!result.success) {
      const statusCode = result.error.includes('not found') ? 404 : 500;
      return res.status(statusCode).json(result);
    }

    res.json(result);

  } catch (error) {
    logger.error('Error sharing invoice:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to share invoice',
      details: error.message
    });
  }
}

/**
 * Delete an invoice (soft delete with audit trail)
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 */
async function deleteInvoice(req, res) {
  try {
    const { invoiceId } = req.params;
    const { organizationId, userEmail, reason } = req.body;

    if (!invoiceId || !organizationId) {
      return res.status(400).json({
        success: false,
        error: 'Invoice ID and Organization ID are required'
      });
    }

    // Prepare delete options
    const deleteOptions = {
      userEmail,
      reason
    };

    // Use service to delete invoice
    const result = await invoiceManagementService.deleteInvoice(
      invoiceId,
      organizationId,
      deleteOptions
    );

    if (!result.success) {
      const statusCode = result.error.includes('not found') ? 404 : 500;
      return res.status(statusCode).json(result);
    }

    res.json(result);

  } catch (error) {
    logger.error('Error deleting invoice:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete invoice',
      details: error.message
    });
  }
}

/**
 * Get invoice statistics for an organization
 * GET /api/invoices/stats/:organizationId
 */
// Removed duplicate getInvoiceStats function - using the service-based implementation below

/**
 * Create a new invoice
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 */
async function createInvoice(req, res) {
  try {
    console.log('=== CREATE INVOICE REQUEST ===');
    console.log('Request body:', JSON.stringify(req.body, null, 2));
    console.log('Request headers:', req.headers);
    
    const {
      organizationId,
      clientId,
      clientEmail,
      clientName,
      lineItems,
      financialSummary,
      metadata = {},
      pdfPath,
      userEmail,
      calculatedPayloadData,
      invoiceNumber: providedInvoiceNumber
    } = req.body;

    // Validate required fields
    if (!organizationId || !clientEmail || !lineItems || !Array.isArray(lineItems) || lineItems.length === 0) {
      return res.status(400).json({
        success: false,
        error: 'Missing required fields: organizationId, clientEmail, and lineItems are required'
      });
    }

    // Use provided invoice number or generate a new one
    const invoiceNumber = providedInvoiceNumber || await invoiceManagementService.generateInvoiceNumber(organizationId);
    
    console.log('=== INVOICE NUMBER HANDLING ===');
    console.log('Provided invoice number:', providedInvoiceNumber);
    console.log('Final invoice number:', invoiceNumber);
    console.log('================================')

    // Prepare invoice data according to schema
    const invoiceData = {
      invoiceNumber,
      organizationId,
      clientId,
      clientEmail,
      clientName,
      lineItems: lineItems.map(item => ({
        ...item,
        organizationId,
        _id: undefined // Let MongoDB generate the ID
      })),
      financialSummary: {
        subtotal: financialSummary?.subtotal || lineItems.reduce((sum, item) => sum + (item.totalPrice || 0), 0),
        taxAmount: financialSummary?.taxAmount || 0,
        discountAmount: financialSummary?.discountAmount || 0,
        expenseAmount: financialSummary?.expenseAmount || 0,
        totalAmount: financialSummary?.totalAmount || lineItems.reduce((sum, item) => sum + (item.totalPrice || 0), 0),
        currency: financialSummary?.currency || 'AUD',
        exchangeRate: financialSummary?.exchangeRate || 1.0,
        paymentTerms: financialSummary?.paymentTerms || 30,
        dueDate: financialSummary?.dueDate || new Date(Date.now() + 30 * 24 * 60 * 60 * 1000)
      },
      metadata: {
        invoiceType: metadata.invoiceType || 'service',
        generationMethod: metadata.generationMethod || 'automatic',
        templateUsed: metadata.templateUsed || 'default',
        customizations: metadata.customizations || [],
        tags: metadata.tags || [],
        category: metadata.category || 'standard',
        priority: metadata.priority || 'normal',
        internalNotes: metadata.internalNotes || '',
        pdfPath: pdfPath || null
      },
      calculatedPayloadData: calculatedPayloadData || null,
      compliance: {
        ndisCompliant: true, // Will be validated
        validationPassed: true,
        validationErrors: [],
        auditRequired: false,
        complianceNotes: '',
        lastComplianceCheck: new Date(),
        complianceOfficer: userEmail || ''
      },
      delivery: {
        method: 'email',
        status: 'pending',
        recipientEmail: clientEmail,
        deliveryAttempts: 0,
        deliveryNotes: ''
      },
      payment: {
        status: 'pending',
        method: '',
        paidAmount: 0,
        paymentNotes: '',
        remindersSent: 0,
        writeOffAmount: 0,
        writeOffReason: ''
      },
      workflow: {
        status: 'generated',
        approvalRequired: false,
        workflowNotes: '',
        currentStep: 'generated',
        nextAction: 'send'
      },
      auditTrail: {
        createdBy: userEmail || 'system',
        createdAt: new Date(),
        updatedBy: userEmail || 'system',
        updatedAt: new Date(),
        version: 1,
        changeHistory: [{
          timestamp: new Date(),
          userId: userEmail || 'system',
          action: 'created',
          changes: { status: 'Invoice created' },
          reason: 'Invoice generation completed'
        }]
      },
      sharing: {
        isShared: false,
        sharedWith: [],
        shareToken: '',
        sharePermissions: 'view',
        shareHistory: []
      },
      deletion: {
        isDeleted: false,
        canRestore: true
      }
    };

    // Create the invoice
    const result = await invoiceManagementService.createInvoice(invoiceData);

    if (result.success) {
      logger.info('Invoice created successfully', {
        invoiceId: result.data._id,
        invoiceNumber: result.data.invoiceNumber,
        organizationId,
        clientEmail,
        totalAmount: invoiceData.financialSummary.totalAmount,
        createdBy: userEmail
      });

      res.status(201).json({
        success: true,
        message: 'Invoice created successfully',
        data: {
          invoiceId: result.data._id,
          invoiceNumber: result.data.invoiceNumber,
          totalAmount: result.data.financialSummary.totalAmount,
          status: result.data.workflow.status,
          createdAt: result.data.auditTrail.createdAt
        }
      });
    } else {
      console.log('=== CREATE INVOICE FAILED ===');
      console.log('Service result:', result);
      res.status(500).json({
        success: false,
        error: result.error || 'Failed to create invoice'
      });
    }

  } catch (error) {
    console.log('=== CREATE INVOICE ERROR ===');
    console.log('Error:', error);
    logger.error('Error creating invoice:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error while creating invoice'
    });
  }
}

/**
 * Get business statistics for an organization
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 */
async function getInvoiceStats(req, res) {
  try {
    const { organizationId } = req.params;

    if (!organizationId) {
      return res.status(400).json({
        success: false,
        error: 'Organization ID is required'
      });
    }

    // Use service to get business statistics
    const result = await invoiceManagementService.getBusinessStatistics(organizationId);

    if (!result.success) {
      return res.status(500).json(result);
    }

    // Log access for audit trail
    logger.info(`Business statistics accessed for organization: ${organizationId}`, {
      organizationId,
      statistics: result.data
    });

    res.json(result);

  } catch (error) {
    logger.error('Error getting business statistics:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to retrieve business statistics',
      details: error.message
    });
  }
}

module.exports = {
  getInvoicesList,
  getInvoiceDetails,
  shareInvoice,
  deleteInvoice,
  getInvoiceStats,
  createInvoice
};