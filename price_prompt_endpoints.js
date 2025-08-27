/**
 * Price Prompt Endpoints
 * API endpoints for handling missing price prompts during invoice generation
 * Task 2.3: Create price prompt system for missing prices
 */

const PricePromptService = require('./price_prompt_service');
const { createAuditLogEndpoint } = require('./audit_trail_endpoints');
const { v4: uuidv4 } = require('uuid');

/**
 * Create a price prompt for missing pricing
 * POST /api/invoice/price-prompt/create
 */
async function createPricePrompt(req, res) {
  const service = new PricePromptService();
  
  try {
    const promptData = req.body;
    
    // Validate input data
    const validationErrors = service.validatePromptData(promptData);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }

    // Generate session ID if not provided
    if (!promptData.sessionId) {
      promptData.sessionId = uuidv4();
    }

    // Create the price prompt
    const result = await service.createPricePrompt(promptData);
    
    // Create audit log
    await createAuditLog({
      entityType: 'price_prompt',
      entityId: result.promptId,
      action: 'create_prompt',
      userId: promptData.userEmail,
      organizationId: promptData.organizationId,
      metadata: {
        ndisItemNumber: promptData.ndisItemNumber,
        clientEmail: promptData.clientEmail,
        sessionId: promptData.sessionId,
        context: 'invoice_generation'
      }
    });

    res.json({
      success: true,
      message: 'Price prompt created successfully',
      data: {
        promptId: result.promptId,
        sessionId: promptData.sessionId,
        prompt: result.prompt
      }
    });
    
  } catch (error) {
    console.error('Error creating price prompt:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create price prompt',
      error: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Resolve a price prompt with user-provided pricing
 * POST /api/invoice/price-prompt/resolve
 */
async function resolvePricePrompt(req, res) {
  const service = new PricePromptService();
  
  try {
    const { promptId, resolution } = req.body;
    
    if (!promptId) {
      return res.status(400).json({
        success: false,
        message: 'Prompt ID is required'
      });
    }

    // Validate resolution data
    const validationErrors = service.validateResolutionData(resolution);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }

    // Resolve the price prompt
    const result = await service.resolvePricePrompt(promptId, resolution);
    
    // Create audit log
    await createAuditLog({
      entityType: 'price_prompt',
      entityId: promptId,
      action: 'resolve_prompt',
      userId: req.body.userEmail || 'system',
      organizationId: req.body.organizationId,
      metadata: {
        providedPrice: resolution.providedPrice,
        saveAsCustomPricing: resolution.saveAsCustomPricing,
        applyToClient: resolution.applyToClient,
        applyToOrganization: resolution.applyToOrganization
      }
    });

    res.json({
      success: true,
      message: 'Price prompt resolved successfully',
      data: {
        promptId: promptId,
        resolvedPrice: resolution.providedPrice
      }
    });
    
  } catch (error) {
    console.error('Error resolving price prompt:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to resolve price prompt',
      error: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Get pending price prompts for a session
 * GET /api/invoice/price-prompt/pending/:sessionId
 */
async function getPendingPrompts(req, res) {
  const service = new PricePromptService();
  
  try {
    const { sessionId } = req.params;
    
    if (!sessionId) {
      return res.status(400).json({
        success: false,
        message: 'Session ID is required'
      });
    }

    // Get pending prompts
    const result = await service.getPendingPrompts(sessionId);
    
    res.json({
      success: true,
      message: 'Pending prompts retrieved successfully',
      data: {
        sessionId: sessionId,
        promptCount: result.prompts.length,
        prompts: result.prompts
      }
    });
    
  } catch (error) {
    console.error('Error getting pending prompts:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to get pending prompts',
      error: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Cancel a price prompt
 * POST /api/invoice/price-prompt/cancel
 */
async function cancelPricePrompt(req, res) {
  const service = new PricePromptService();
  
  try {
    const { promptId } = req.body;
    
    if (!promptId) {
      return res.status(400).json({
        success: false,
        message: 'Prompt ID is required'
      });
    }

    // Cancel the price prompt
    const result = await service.cancelPricePrompt(promptId);
    
    // Create audit log
    await createAuditLog({
      entityType: 'price_prompt',
      entityId: promptId,
      action: 'cancel_prompt',
      userId: req.body.userEmail || 'system',
      organizationId: req.body.organizationId,
      metadata: {
        reason: req.body.reason || 'User cancelled'
      }
    });

    res.json({
      success: true,
      message: 'Price prompt cancelled successfully',
      data: {
        promptId: promptId
      }
    });
    
  } catch (error) {
    console.error('Error cancelling price prompt:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to cancel price prompt',
      error: error.message
    });
  } finally {
    await service.disconnect();
  }
}

/**
 * Generate invoice with price prompt handling
 * POST /api/invoice/generate-with-prompts
 */
async function generateInvoiceWithPrompts(req, res) {
  const InvoiceGenerationService = require('./invoice_generation_service');
  const invoiceService = new InvoiceGenerationService();
  const promptService = new PricePromptService();
  
  try {
    const { userEmail, clientEmail, startDate, endDate, sessionId } = req.body;
    
    // Validate input parameters
    const validationErrors = invoiceService.validateGenerationParams(userEmail, clientEmail, startDate, endDate);
    if (validationErrors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: validationErrors
      });
    }

    // Generate session ID if not provided
    const currentSessionId = sessionId || uuidv4();

    // Generate line items
    const result = await invoiceService.generateInvoiceLineItems(userEmail, clientEmail, startDate, endDate);
    
    // Check for missing prices and create prompts
    const missingPriceItems = [];
    const validItems = [];
    
    for (let i = 0; i < result.lineItems.length; i++) {
      const item = result.lineItems[i];
      
      if (item.pricing && (item.pricing.source === 'missing' || item.pricing.requiresManualPricing)) {
        // Create price prompt for missing pricing
        const promptData = {
          ndisItemNumber: item.ndisItemNumber,
          itemDescription: item.description,
          organizationId: item.organizationId,
          clientId: item.clientId,
          userEmail: userEmail,
          clientEmail: clientEmail,
          quantity: item.quantity,
          unit: item.unit,
          suggestedPrice: item.pricing.price || 0,
          priceCap: item.pricing.priceCap,
          state: item.state || 'NSW',
          providerType: item.providerType || 'standard',
          sessionId: currentSessionId,
          lineItemIndex: i
        };
        
        const promptResult = await promptService.createPricePrompt(promptData);
        missingPriceItems.push({
          lineItemIndex: i,
          item: item,
          promptId: promptResult.promptId
        });
      } else {
        validItems.push(item);
      }
    }
    
    // Create audit log
    await createAuditLog({
      entityType: 'invoice',
      entityId: result.metadata.assignmentId,
      action: 'generate_with_prompts',
      userId: userEmail,
      organizationId: result.lineItems[0]?.organizationId,
      metadata: {
        clientEmail,
        startDate,
        endDate,
        sessionId: currentSessionId,
        totalItems: result.lineItems.length,
        validItems: validItems.length,
        missingPriceItems: missingPriceItems.length,
        extractionMethod: 'clientAssignment-based'
      }
    });

    res.json({
      success: true,
      message: missingPriceItems.length > 0 
        ? 'Invoice generated with price prompts required' 
        : 'Invoice generated successfully',
      data: {
        sessionId: currentSessionId,
        lineItems: result.lineItems,
        validItems: validItems,
        missingPriceItems: missingPriceItems,
        metadata: result.metadata,
        requiresPricePrompts: missingPriceItems.length > 0,
        promptCount: missingPriceItems.length
      }
    });
    
  } catch (error) {
    console.error('Error generating invoice with prompts:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to generate invoice with prompts',
      error: error.message
    });
  } finally {
    await invoiceService.disconnect();
    await promptService.disconnect();
  }
}

/**
 * Complete invoice generation after all prompts are resolved
 * POST /api/invoice/complete-generation
 */
async function completeInvoiceGeneration(req, res) {
  const promptService = new PricePromptService();
  
  try {
    const { sessionId, lineItems } = req.body;
    
    if (!sessionId) {
      return res.status(400).json({
        success: false,
        message: 'Session ID is required'
      });
    }

    // Get all prompts for this session to verify they're resolved
    const pendingPrompts = await promptService.getPendingPrompts(sessionId);
    
    if (pendingPrompts.prompts.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Cannot complete invoice generation with pending price prompts',
        data: {
          pendingPrompts: pendingPrompts.prompts.length
        }
      });
    }

    // Create audit log for completion
    await createAuditLog({
      entityType: 'invoice',
      entityId: sessionId,
      action: 'complete_generation',
      userId: req.body.userEmail || 'system',
      organizationId: req.body.organizationId,
      metadata: {
        sessionId: sessionId,
        finalItemCount: lineItems?.length || 0
      }
    });

    res.json({
      success: true,
      message: 'Invoice generation completed successfully',
      data: {
        sessionId: sessionId,
        status: 'completed'
      }
    });
    
  } catch (error) {
    console.error('Error completing invoice generation:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to complete invoice generation',
      error: error.message
    });
  } finally {
    await promptService.disconnect();
  }
}

/**
 * Create audit log helper function
 */
async function createAuditLog(auditData) {
  try {
    await createAuditLogEndpoint({
      body: auditData
    }, {
      json: () => {}, // Mock response object
      status: () => ({ json: () => {} })
    });
  } catch (error) {
    console.error('Error creating audit log:', error);
    // Don't throw error for audit log failures
  }
}

module.exports = {
  createPricePrompt,
  resolvePricePrompt,
  getPendingPrompts,
  cancelPricePrompt,
  generateInvoiceWithPrompts,
  completeInvoiceGeneration
};