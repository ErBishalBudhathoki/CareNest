/**
 * Invoice Generation Endpoints
 * Implements clientAssignment-based invoice generation endpoints
 * Task 2.1: Enhanced Invoice Generation Backend
 */

const InvoiceGenerationService = require('./services/invoiceGenerationService');
const { createAuditLogEndpoint } = require('./audit_trail_endpoints');
const { validateInvoiceLineItems: validateLineItemsWithPricing } = require('./price_validation_endpoints');
const logger = require('./config/logger');

/**
 * Generate invoice line items based on clientAssignment data
 * POST /api/invoice/generate-line-items
 */
async function generateInvoiceLineItems(req, res) {
  const service = new InvoiceGenerationService();
  
  try {
    const { userEmail, clientEmail, startDate, endDate, includeExpenses = false } = req.body;
    
    // Validate input parameters
    const validationErrors = service.validateGenerationParams(userEmail, clientEmail, startDate, endDate);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }

    // Generate line items using clientAssignment-based extraction
    const result = await service.generateInvoiceLineItems(userEmail, clientEmail, startDate, endDate);
    
    // Get expenses and convert to line items if requested
    let expenses = [];
    let expenseLineItems = [];
    if (includeExpenses) {
      logger.debug('Querying expenses for invoice generation', {
        organizationId: result.metadata.organizationId,
        clientId: result.metadata.clientId,
        startDate,
        endDate,
        assignmentId: result.metadata.assignmentId
      });
      
      expenses = await service.getApprovedExpensesForInvoice(
        result.metadata.organizationId,
        result.metadata.clientId,
        startDate,
        endDate
      );
      
      logger.debug('Expenses retrieved for invoice', {
        expenseCount: expenses.length,
        organizationId: result.metadata.organizationId,
        clientId: result.metadata.clientId,
        hasExpenses: expenses.length > 0
      });
      
      // Convert expenses to line items and add to main line items array
      const expenseLineItemPromises = expenses.map(expense => service.convertExpenseToLineItem(expense));
      const expenseLineItemResults = await Promise.all(expenseLineItemPromises);
      expenseLineItems = expenseLineItemResults.filter(item => item !== null);
      result.lineItems.push(...expenseLineItems);
    }
    
    // Enhanced validation with integrated price validation (after expenses are merged)
    const validation = await service.validateInvoiceLineItems(result.lineItems, {
      defaultState: req.body.defaultState || 'NSW',
      defaultProviderType: req.body.defaultProviderType || 'standard'
    });
    
    // Create audit log for invoice generation
    await createAuditLog({
      entityType: 'invoice',
      entityId: result.metadata.assignmentId,
      action: 'generate_line_items',
      userId: userEmail,
      organizationId: result.lineItems[0]?.organizationId,
      metadata: {
        clientEmail,
        startDate,
        endDate,
        itemCount: result.lineItems.length,
        validItems: validation.validItems,
        invalidItems: validation.invalidItems,
        extractionMethod: 'clientAssignment-based',
        ndisCompliant: validation.isValid
      }
    });

    res.status(200).json({
      success: true,
      message: 'Invoice line items generated successfully',
      data: {
        ...result,
        expenses: expenses, // Add expenses as separate array
        validation,
        summary: {
          totalItems: result.lineItems.length,
          serviceItems: result.lineItems.filter(item => item.type !== 'expense').length,
          expenseItems: expenseLineItems.length,
          validItems: validation.validItems,
          invalidItems: validation.invalidItems,
          totalAmount: result.lineItems.reduce((sum, item) => sum + item.totalPrice, 0),
          serviceAmount: result.lineItems.filter(item => item.type !== 'expense').reduce((sum, item) => sum + item.totalPrice, 0),
          expenseAmount: expenseLineItems.reduce((sum, item) => sum + item.totalPrice, 0),
          generatedAt: new Date().toISOString(),
          method: 'clientAssignment-based',
          ndisCompliant: validation.isValid,
          includeExpenses: includeExpenses
        }
      }
    });

  } catch (error) {
    logger.error('Invoice line items generation failed', {
      error: error.message,
      stack: error.stack,
      assignmentId: req.body.assignmentId,
      userEmail: req.body.userEmail
    });
    
    // Handle specific error types
    if (error.message.includes('No active assignment found')) {
      return res.status(404).json({
        success: false,
        message: 'No active client assignment found',
        error: error.message
      });
    }
    
    if (error.message.includes('Client not found')) {
      return res.status(404).json({
        success: false,
        message: 'Client not found or inactive',
        error: error.message
      });
    }

    res.status(500).json({
      success: false,
      message: 'Error generating invoice line items',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Get invoice generation preview
 * GET /api/invoice/preview/:userEmail/:clientEmail
 */
async function getInvoicePreview(req, res) {
  const service = new InvoiceGenerationService();
  
  try {
    const { userEmail, clientEmail } = req.params;
    const { startDate, endDate } = req.query;
    
    if (!startDate || !endDate) {
      return res.status(400).json({
        success: false,
        message: 'startDate and endDate query parameters are required'
      });
    }

    // Validate input parameters
    const validationErrors = service.validateGenerationParams(userEmail, clientEmail, startDate, endDate);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }

    // Generate preview without creating audit logs
    const result = await service.generateInvoiceLineItems(userEmail, clientEmail, startDate, endDate);
    
    // Validate the generated line items for NDIS compliance
    const validation = await service.validateInvoiceLineItems(result.lineItems);
    
    // Calculate totals for preview
    const totals = result.lineItems.reduce((acc, item) => {
      acc.totalAmount += item.totalPrice;
      acc.totalHours += item.hoursWorked || 0;
      acc.totalItems += 1;
      return acc;
    }, { totalAmount: 0, totalHours: 0, totalItems: 0 });

    res.status(200).json({
      success: true,
      message: 'Invoice preview generated successfully',
      data: {
        ...result,
        validation: {
          isValid: validation.isValid,
          errors: validation.errors,
          warnings: validation.warnings,
          summary: {
            totalItems: validation.totalItems,
            validItems: validation.validItems,
            invalidItems: validation.invalidItems
          }
        },
        totals: {
          totalAmount: parseFloat(totals.totalAmount.toFixed(2)),
          totalHours: parseFloat(totals.totalHours.toFixed(2)),
          totalItems: totals.totalItems,
          validItems: validation.validItems,
          invalidItems: validation.invalidItems
        },
        isPreview: true,
        ndisCompliant: validation.isValid
      }
    });

  } catch (error) {
    logger.error('Invoice preview generation failed', {
      error: error.message,
      stack: error.stack,
      assignmentId: req.body.assignmentId,
      userEmail: req.body.userEmail
    });
    
    res.status(500).json({
      success: false,
      message: 'Error generating invoice preview',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Get available assignments for invoice generation
 * GET /api/invoice/available-assignments/:userEmail
 */
async function getAvailableAssignments(req, res) {
  const service = new InvoiceGenerationService();
  
  try {
    const { userEmail } = req.params;
    
    if (!userEmail) {
      return res.status(400).json({
        success: false,
        message: 'userEmail parameter is required'
      });
    }

    await service.connect();
    
    // Get all active assignments for the user
    const assignments = await service.db.collection('clientAssignments').find({
      userEmail: userEmail,
      isActive: true
    }).toArray();

    // Enrich with client details
    const enrichedAssignments = [];
    for (const assignment of assignments) {
      const client = await service.db.collection('clients').findOne({
        clientEmail: assignment.clientEmail,
        isActive: true
      });
      
      if (client) {
        enrichedAssignments.push({
          assignmentId: assignment._id,
          clientEmail: assignment.clientEmail,
          clientName: `${client.clientFirstName} ${client.clientLastName}`,
          organizationId: assignment.organizationId,
          assignedNdisItemNumber: assignment.assignedNdisItemNumber,
          scheduleCount: assignment.schedule ? assignment.schedule.length : 0,
          createdAt: assignment.createdAt,
          hasScheduleData: !!(assignment.schedule && assignment.schedule.length > 0)
        });
      }
    }

    res.status(200).json({
      success: true,
      message: 'Available assignments retrieved successfully',
      data: {
        assignments: enrichedAssignments,
        totalCount: enrichedAssignments.length
      }
    });

  } catch (error) {
    logger.error('Failed to get available assignments', {
      error: error.message,
      stack: error.stack,
      organizationId: req.params.organizationId,
      userEmail: req.query.userEmail
    });
    
    res.status(500).json({
      success: false,
      message: 'Error retrieving available assignments',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Validate invoice generation data with enhanced NDIS compliance checking
 * POST /api/invoice/validate-generation-data
 */
async function validateInvoiceGenerationData(req, res) {
  const service = new InvoiceGenerationService();
  
  try {
    const { userEmail, clientEmail, startDate, endDate, validatePricing = true } = req.body;
    
    // Validate input parameters
    const validationErrors = service.validateGenerationParams(userEmail, clientEmail, startDate, endDate);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }

    await service.connect();
    
    // Check if assignment exists
    const assignment = await service.db.collection('clientAssignments').findOne({
      userEmail: userEmail,
      clientEmail: clientEmail,
      isActive: true
    });

    // Check if client exists
    const client = await service.db.collection('clients').findOne({
      clientEmail: clientEmail,
      isActive: true
    });

    // Check for worked time data
    const workedTimeData = await service.getWorkedTimeData(userEmail, clientEmail, startDate, endDate);
    
    let pricingValidation = null;
    if (validatePricing && assignment && client) {
      try {
        // Generate a preview to validate pricing
        const previewResult = await service.generateInvoiceLineItems(userEmail, clientEmail, startDate, endDate);
        
        // Enhanced validation with integrated price validation
        pricingValidation = await service.validateInvoiceLineItems(previewResult.lineItems, {
          defaultState: req.body.defaultState || 'NSW',
          defaultProviderType: req.body.defaultProviderType || 'standard'
        });
      } catch (pricingError) {
        logger.warn('Pricing validation failed during invoice validation', {
        error: pricingError.message,
        assignmentId: req.body.assignmentId,
        lineItemCount: req.body.lineItems ? req.body.lineItems.length : 0
      });
        pricingValidation = {
          isValid: false,
          errors: [pricingError.message],
          warnings: [],
          totalItems: 0,
          validItems: 0,
          invalidItems: 0
        };
      }
    }
    
    // Validation results
    const validation = {
      hasAssignment: !!assignment,
      hasClient: !!client,
      hasScheduleData: !!(assignment && assignment.schedule && assignment.schedule.length > 0),
      hasWorkedTimeData: workedTimeData.length > 0,
      hasNdisItem: !!(assignment && assignment.assignedNdisItemNumber),
      dateRangeValid: new Date(startDate) <= new Date(endDate),
      canGenerateInvoice: false,
      pricingValidation: pricingValidation ? {
        isValid: pricingValidation.isValid,
        totalItems: pricingValidation.totalItems,
        validItems: pricingValidation.validItems,
        invalidItems: pricingValidation.invalidItems,
        errorCount: pricingValidation.errors.length,
        warningCount: pricingValidation.warnings.length,
        ndisCompliant: pricingValidation.isValid
      } : null,
      recommendations: []
    };

    // Determine if invoice can be generated
    validation.canGenerateInvoice = validation.hasAssignment && 
                                   validation.hasClient && 
                                   validation.dateRangeValid && 
                                   (validation.hasScheduleData || validation.hasWorkedTimeData) &&
                                   (!pricingValidation || pricingValidation.isValid);

    const warnings = [];
    if (!validation.hasNdisItem) {
      warnings.push('No NDIS item assigned to this client assignment');
    }
    if (!validation.hasScheduleData && !validation.hasWorkedTimeData) {
      warnings.push('No schedule or worked time data found for the specified period');
    }

    // Add recommendations based on validation results
    if (!validation.hasAssignment) {
      validation.recommendations.push({
        type: 'error',
        message: 'No active client assignment found',
        action: 'Create or activate a client assignment for this user-client pair'
      });
    }

    if (!validation.hasClient) {
      validation.recommendations.push({
        type: 'error',
        message: 'Client not found or inactive',
        action: 'Verify client exists and is active in the system'
      });
    }

    if (pricingValidation && !pricingValidation.isValid) {
      validation.recommendations.push({
        type: 'error',
        message: `${pricingValidation.errors.length} pricing issues found`,
        action: 'Review custom pricing and NDIS compliance before generating invoice'
      });
    }

    if (pricingValidation && pricingValidation.warnings.length > 0) {
      validation.recommendations.push({
        type: 'warning',
        message: `${pricingValidation.warnings.length} pricing warnings found`,
        action: 'Review custom pricing compliance'
      });
    }

    res.status(200).json({
      success: true,
      message: 'Validation completed',
      data: {
        validation,
        warnings,
        assignmentDetails: assignment ? {
          assignmentId: assignment._id,
          organizationId: assignment.organizationId,
          assignedNdisItemNumber: assignment.assignedNdisItemNumber,
          scheduleCount: assignment.schedule ? assignment.schedule.length : 0
        } : null,
        clientDetails: client ? {
          clientId: client._id,
          clientName: `${client.clientFirstName} ${client.clientLastName}`,
          organizationId: client.organizationId
        } : null
      }
    });

  } catch (error) {
    logger.error('Invoice generation data validation failed', {
      error: error.message,
      stack: error.stack,
      userEmail: req.body.userEmail,
      clientEmail: req.body.clientEmail
    });
    
    res.status(500).json({
      success: false,
      message: 'Error validating invoice generation data',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Helper function to create audit logs
 */
async function createAuditLog(auditData) {
  try {
    // Create a mock request object for the audit endpoint
    const mockReq = {
      body: {
        entityType: auditData.entityType,
        entityId: auditData.entityId,
        action: auditData.action,
        userId: auditData.userId,
        organizationId: auditData.organizationId,
        metadata: auditData.metadata
      }
    };
    
    const mockRes = {
      status: () => ({ json: () => {} }),
      json: () => {}
    };
    
    await createAuditLogEndpoint(mockReq, mockRes);
  } catch (error) {
    logger.error('Failed to create audit log', {
      error: error.message,
      stack: error.stack,
      auditData
    });
    // Don't throw error as audit logging shouldn't break the main flow
  }
}

/**
 * Generate bulk invoices for multiple clients with pre-configured pricing
 * Task 2.5: Add bulk invoice generation with pre-configured pricing
 */
async function generateBulkInvoices(req, res) {
  try {
    const {
      organizationId,
      userEmail,
      clients,
      usePreConfiguredPricing = true,
      skipPricePrompts = true,
      includeExpenses = true,
      batchSize = 10
    } = req.body;
    
    // Validate required parameters
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required'
      });
    }
    
    if (!userEmail) {
      return res.status(400).json({
        success: false,
        message: 'User email is required'
      });
    }
    
    if (!clients || !Array.isArray(clients) || clients.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'At least one client is required for bulk generation'
      });
    }
    
    // Create audit log entry for bulk generation start
    await createAuditLog({
      entityType: 'invoice',
      entityId: organizationId,
      action: 'bulk_invoice_generation_started',
      userId: userEmail,
      organizationId: organizationId,
      metadata: {
        totalClients: clients.length,
        usePreConfiguredPricing,
        skipPricePrompts,
        includeExpenses,
        batchSize
      }
    });
    
    // Generate bulk invoices
    const invoiceService = new InvoiceGenerationService();
    const result = await invoiceService.generateBulkInvoices({
      organizationId,
      userEmail,
      clients,
      usePreConfiguredPricing,
      skipPricePrompts,
      includeExpenses,
      batchSize
    });
    
    // Create audit log entry for bulk generation completion
    await createAuditLog({
      entityType: 'invoice',
      entityId: organizationId,
      action: 'bulk_invoice_generation_completed',
      userId: userEmail,
      organizationId: organizationId,
      metadata: {
        success: result.success,
        totalClients: result.totalClients || 0,
        processedClients: result.processedClients || 0,
        successfulInvoices: result.successfulInvoices?.length || 0,
        failedInvoices: result.failedInvoices?.length || 0,
        totalAmount: result.summary?.totalAmount || 0,
        processingTime: result.summary?.processingTime || 0
      }
    });
    
    if (result.success) {
      res.status(200).json({
        success: true,
        message: 'Bulk invoice generation completed successfully',
        data: result
      });
    } else {
      res.status(400).json({
        success: false,
        message: result.message || 'Bulk invoice generation failed',
        error: result.error,
        errors: result.errors
      });
    }
    
  } catch (error) {
    logger.error('Bulk invoice generation failed', {
      error: error.message,
      stack: error.stack,
      organizationId: req.body.organizationId,
      userEmail: req.body.userEmail
    });
    
    // Create audit log entry for error
    try {
      await createAuditLog({
        entityType: 'invoice',
        entityId: req.body.organizationId || 'unknown',
        action: 'bulk_invoice_generation_error',
        userId: req.body.userEmail || 'unknown',
        organizationId: req.body.organizationId || 'unknown',
        metadata: {
          error: error.message,
          stack: error.stack
        }
      });
    } catch (auditError) {
      logger.error('Failed to create error audit log', {
        error: auditError.message,
        stack: auditError.stack
      });
    }
    
    res.status(500).json({
      success: false,
      message: 'Internal server error during bulk invoice generation',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  }
}

/**
 * Validate existing invoice line items with comprehensive price validation
 * POST /api/invoice/validate-line-items
 */
async function validateExistingInvoiceLineItems(req, res) {
  const service = new InvoiceGenerationService();
  
  try {
    const { 
      lineItems, 
      defaultState = 'NSW', 
      defaultProviderType = 'standard',
      skipPriceValidation = false 
    } = req.body;
    
    // Input validation
    if (!Array.isArray(lineItems) || lineItems.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Line items array is required and must not be empty'
      });
    }

    // Validate line items with enhanced price validation
    const validation = await service.validateInvoiceLineItems(lineItems, {
      defaultState,
      defaultProviderType,
      skipPriceValidation
    });

    // Create audit log for validation
    await createAuditLog({
      entityType: 'invoice',
      entityId: 'validation_request',
      action: 'validate_line_items',
      userId: req.body.userEmail || 'system',
      organizationId: lineItems[0]?.organizationId,
      metadata: {
        itemCount: lineItems.length,
        validItems: validation.validItems,
        invalidItems: validation.invalidItems,
        hasNonCompliantItems: validation.priceValidationSummary?.hasNonCompliantItems || false,
        compliancePercentage: validation.priceValidationSummary?.compliancePercentage || 100
      }
    });

    res.status(200).json({
      success: true,
      message: 'Line items validation completed',
      data: {
        validation,
        summary: {
          totalItems: validation.totalItems,
          validItems: validation.validItems,
          invalidItems: validation.invalidItems,
          errorCount: validation.errors.length,
          warningCount: validation.warnings.length,
          isValid: validation.isValid,
          priceValidation: validation.priceValidationSummary
        }
      }
    });

  } catch (error) {
    logger.error('Existing invoice line items validation failed', {
      error: error.message,
      stack: error.stack,
      lineItemCount: req.body.lineItems ? req.body.lineItems.length : 0
    });
    
    res.status(500).json({
      success: false,
      message: 'Error validating invoice line items',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Real-time price validation for invoice creation
 * POST /api/invoice/validate-pricing-realtime
 */
async function validatePricingRealtime(req, res) {
  const service = new InvoiceGenerationService();
  
  try {
    const { 
      lineItems, 
      state = 'NSW', 
      providerType = 'standard' 
    } = req.body;
    
    // Input validation
    if (!Array.isArray(lineItems) || lineItems.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Line items array is required and must not be empty'
      });
    }

    // Perform real-time price validation
    const priceValidationResult = await service.validateLineItemPricing(
      lineItems,
      state,
      providerType
    );

    // Create audit log for real-time validation
    await createAuditLog({
      entityType: 'invoice',
      entityId: 'realtime_validation',
      action: 'validate_pricing_realtime',
      userId: req.body.userEmail || 'system',
      organizationId: lineItems[0]?.organizationId,
      metadata: {
        itemCount: lineItems.length,
        validItems: priceValidationResult.summary.validItems,
        invalidItems: priceValidationResult.summary.invalidItems,
        totalInvoiceAmount: priceValidationResult.summary.totalInvoiceAmount,
        totalCompliantAmount: priceValidationResult.summary.totalCompliantAmount,
        compliancePercentage: priceValidationResult.summary.compliancePercentage
      }
    });

    res.status(200).json({
      success: true,
      message: 'Real-time price validation completed',
      data: priceValidationResult
    });

  } catch (error) {
    logger.error('Real-time price validation failed', {
      error: error.message,
      stack: error.stack,
      lineItemCount: req.body.lineItems ? req.body.lineItems.length : 0
    });
    
    res.status(500).json({
      success: false,
      message: 'Error performing real-time price validation',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Get comprehensive invoice validation report
 * POST /api/invoice/validation-report
 */
async function getInvoiceValidationReport(req, res) {
  const service = new InvoiceGenerationService();
  
  try {
    const { 
      userEmail, 
      clientEmail, 
      startDate, 
      endDate,
      includeExpenses = true,
      defaultState = 'NSW',
      defaultProviderType = 'standard'
    } = req.body;
    
    // Validate input parameters
    const validationErrors = service.validateGenerationParams(userEmail, clientEmail, startDate, endDate);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }

    await service.connect();
    
    // Generate invoice preview for validation
    const invoiceResult = await service.generateInvoiceLineItems(userEmail, clientEmail, startDate, endDate);
    
    // Comprehensive validation
    const validation = await service.validateInvoiceLineItems(invoiceResult.lineItems, {
      defaultState,
      defaultProviderType
    });

    // Get assignment and client details for context
    const assignment = await service.db.collection('clientAssignments').findOne({
      userEmail: userEmail,
      clientEmail: clientEmail,
      isActive: true
    });

    const client = await service.db.collection('clients').findOne({
      clientEmail: clientEmail,
      isActive: true
    });

    // Create comprehensive report
    const report = {
      invoiceDetails: {
        userEmail,
        clientEmail,
        startDate,
        endDate,
        totalLineItems: invoiceResult.lineItems.length,
        totalAmount: invoiceResult.lineItems.reduce((sum, item) => sum + (item.unitPrice * item.quantity), 0)
      },
      validation: {
        isValid: validation.isValid,
        totalItems: validation.totalItems,
        validItems: validation.validItems,
        invalidItems: validation.invalidItems,
        errorCount: validation.errors.length,
        warningCount: validation.warnings.length,
        errors: validation.errors,
        warnings: validation.warnings
      },
      priceValidation: validation.priceValidationSummary,
      itemValidations: validation.itemValidations,
      assignmentContext: assignment ? {
        assignmentId: assignment._id,
        organizationId: assignment.organizationId,
        assignedNdisItemNumber: assignment.assignedNdisItemNumber
      } : null,
      clientContext: client ? {
        clientId: client._id,
        clientName: `${client.clientFirstName} ${client.clientLastName}`,
        organizationId: client.organizationId
      } : null,
      recommendations: []
    };

    // Add recommendations based on validation results
    if (validation.invalidItems > 0) {
      report.recommendations.push({
        type: 'error',
        message: `${validation.invalidItems} items require attention before invoice generation`,
        action: 'Review and fix validation errors'
      });
    }

    if (validation.priceValidationSummary?.hasNonCompliantItems) {
      report.recommendations.push({
        type: 'warning',
        message: 'Some items exceed NDIS price caps',
        action: 'Review pricing or obtain quotes for non-compliant items'
      });
    }

    if (validation.priceValidationSummary?.compliancePercentage < 95) {
      report.recommendations.push({
        type: 'warning',
        message: `Invoice compliance is ${validation.priceValidationSummary.compliancePercentage}%`,
        action: 'Consider adjusting pricing to improve NDIS compliance'
      });
    }

    // Create audit log for validation report
    await createAuditLog({
      entityType: 'invoice',
      entityId: assignment?._id || 'validation_report',
      action: 'generate_validation_report',
      userId: userEmail,
      organizationId: assignment?.organizationId,
      metadata: {
        clientEmail,
        startDate,
        endDate,
        totalItems: report.validation.totalItems,
        validItems: report.validation.validItems,
        invalidItems: report.validation.invalidItems,
        compliancePercentage: validation.priceValidationSummary?.compliancePercentage || 100
      }
    });

    res.status(200).json({
      success: true,
      message: 'Invoice validation report generated',
      data: report
    });

  } catch (error) {
    logger.error('Invoice validation report generation failed', {
      error: error.message,
      stack: error.stack,
      userEmail: req.body.userEmail,
      clientEmail: req.body.clientEmail
    });
    
    res.status(500).json({
      success: false,
      message: 'Error generating validation report',
      error: process.env.NODE_ENV === 'development' ? error.message : 'Internal server error'
    });
  } finally {
    await service.disconnect();
  }
}

module.exports = {
  generateInvoiceLineItems,
  getInvoicePreview,
  getAvailableAssignments,
  validateInvoiceGenerationData,
  generateBulkInvoices,
  validateExistingInvoiceLineItems,
  validatePricingRealtime,
  getInvoiceValidationReport
};