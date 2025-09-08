/**
 * Invoice Generation Service
 * Replaces random algorithm with clientAssignment-based item extraction
 * Task 2.1: Enhanced Invoice Generation Backend
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const { priceValidationService } = require('./priceValidationService');
const axios = require('axios');
const logger = require('../config/logger');
const uri = process.env.MONGODB_URI;

class InvoiceGenerationService {
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
   * Generate bulk invoices for multiple clients with pre-configured pricing
   * Task 2.5: Add bulk invoice generation with pre-configured pricing
   */
  async generateBulkInvoices(bulkGenerationParams) {
    try {
      await this.connect();
      
      const {
        organizationId,
        userEmail,
        clients, // Array of client objects with clientEmail, startDate, endDate
        usePreConfiguredPricing = true,
        skipPricePrompts = true,
        includeExpenses = true,
        batchSize = 10
      } = bulkGenerationParams;
      
      // Validate bulk generation parameters
      const validationErrors = this.validateBulkGenerationParams(bulkGenerationParams);
      if (validationErrors.length > 0) {
        return {
          success: false,
          message: 'Bulk generation validation failed',
          errors: validationErrors
        };
      }
      
      const results = {
        success: true,
        totalClients: clients.length,
        processedClients: 0,
        successfulInvoices: [],
        failedInvoices: [],
        summary: {
          totalInvoices: 0,
          totalLineItems: 0,
          totalAmount: 0,
          totalServiceAmount: 0,
          totalExpenseAmount: 0,
          processingTime: 0
        },
        metadata: {
          organizationId,
          userEmail,
          generatedAt: new Date(),
          usePreConfiguredPricing,
          skipPricePrompts,
          includeExpenses,
          batchSize
        }
      };
      
      const startTime = Date.now();
      
      // Process clients in batches to avoid overwhelming the system
      for (let i = 0; i < clients.length; i += batchSize) {
        const batch = clients.slice(i, i + batchSize);
        const batchPromises = batch.map(async (clientData) => {
          try {
            const invoiceResult = await this.generateSingleInvoiceForBulk(
              userEmail,
              clientData.clientEmail,
              clientData.startDate,
              clientData.endDate,
              {
                usePreConfiguredPricing,
                skipPricePrompts,
                includeExpenses,
                organizationId
              }
            );
            
            if (invoiceResult.success) {
              results.successfulInvoices.push({
                clientEmail: clientData.clientEmail,
                ...invoiceResult
              });
              
              // Update summary
              results.summary.totalInvoices++;
              results.summary.totalLineItems += invoiceResult.summary.totalItems;
              results.summary.totalAmount += invoiceResult.summary.totalAmount;
              results.summary.totalServiceAmount += invoiceResult.summary.serviceAmount || 0;
              results.summary.totalExpenseAmount += invoiceResult.summary.expenseAmount || 0;
            } else {
              results.failedInvoices.push({
                clientEmail: clientData.clientEmail,
                error: invoiceResult.error || 'Unknown error',
                details: invoiceResult.details
              });
            }
            
            results.processedClients++;
          } catch (error) {
            results.failedInvoices.push({
              clientEmail: clientData.clientEmail,
              error: error.message,
              details: 'Exception during invoice generation'
            });
            results.processedClients++;
          }
        });
        
        // Wait for current batch to complete before processing next batch
        await Promise.all(batchPromises);
      }
      
      results.summary.processingTime = Date.now() - startTime;
      
      return results;
      
    } catch (error) {
      logger.error('Bulk invoice generation failed', {
        error: error.message,
        stack: error.stack,
        organizationId: bulkGenerationParams.organizationId,
        clientCount: bulkGenerationParams.clients?.length
      });
      return {
        success: false,
        message: 'Bulk invoice generation failed',
        error: error.message
      };
    }
  }
  
  /**
   * Generate a single invoice for bulk processing with pre-configured pricing
   */
  async generateSingleInvoiceForBulk(userEmail, clientEmail, startDate, endDate, options = {}) {
    try {
      const {
        usePreConfiguredPricing = true,
        skipPricePrompts = true,
        includeExpenses = true,
        organizationId
      } = options;
      
      // Get client assignment data
      const assignment = await this.db.collection('clientAssignments').findOne({
        userEmail: userEmail,
        clientEmail: clientEmail,
        isActive: true
      });
      
      if (!assignment) {
        return {
          success: false,
          error: 'No active assignment found',
          details: `No assignment found for user ${userEmail} and client ${clientEmail}`
        };
      }
      
      // Get client data
      const client = await this.db.collection('clients').findOne({
        clientEmail: clientEmail,
        isActive: true
      });
      
      if (!client) {
        return {
          success: false,
          error: 'Client not found',
          details: `Client ${clientEmail} not found or inactive`
        };
      }
      
      // Get worked time data
      const workedTimeData = await this.getWorkedTimeData(userEmail, clientEmail, startDate, endDate);
      
      // Extract line items from assignment
      const lineItems = await this.extractLineItemsFromAssignment(
        assignment, 
        client, 
        workedTimeData, 
        startDate, 
        endDate
      );
      
      // Include expenses if requested
      if (includeExpenses) {
        const expenseLineItems = await this.getApprovedExpensesForInvoice(
          organizationId || assignment.organizationId,
          client._id,
          startDate,
          endDate
        );
        
        const convertedExpensePromises = expenseLineItems.map(expense => 
          this.convertExpenseToLineItem(expense)
        );
        const convertedExpenses = await Promise.all(convertedExpensePromises);
        
        lineItems.push(...convertedExpenses);
      }
      
      // Apply pre-configured pricing if enabled
      if (usePreConfiguredPricing) {
        await this.applyPreConfiguredPricing(lineItems, organizationId || assignment.organizationId, client._id);
      }
      
      // Filter out items with missing prices if skipPricePrompts is true
      let validLineItems = lineItems;
      if (skipPricePrompts) {
        validLineItems = lineItems.filter(item => item.unitPrice > 0);
      }
      
      // Validate line items
      const validation = await this.validateInvoiceLineItems(validLineItems);
      
      // Separate service items and expense items for summary
      const serviceItems = validLineItems.filter(item => item.type !== 'expense');
      const expenseItems = validLineItems.filter(item => item.type === 'expense');
      
      const result = {
        success: true,
        lineItems: validLineItems,
        validation,
        metadata: {
          assignmentId: assignment._id,
          clientId: client._id,
          generatedAt: new Date(),
          extractionMethod: 'bulk generation with pre-configured pricing',
          totalItems: validLineItems.length,
          serviceItems: serviceItems.length,
          expenseItems: expenseItems.length,
          usePreConfiguredPricing,
          skipPricePrompts,
          includeExpenses
        },
        summary: {
          totalItems: validLineItems.length,
          serviceItems: serviceItems.length,
          expenseItems: expenseItems.length,
          totalAmount: validLineItems.reduce((sum, item) => sum + item.totalPrice, 0),
          serviceAmount: serviceItems.reduce((sum, item) => sum + item.totalPrice, 0),
          expenseAmount: expenseItems.reduce((sum, item) => sum + item.totalPrice, 0),
          ndisCompliant: validation.isValid,
          hasErrors: validation.errors.length > 0,
          hasWarnings: validation.warnings.length > 0
        }
      };
      
      return result;
      
    } catch (error) {
      return {
        success: false,
        error: error.message,
        details: 'Exception during single invoice generation for bulk processing'
      };
    }
  }
  
  /**
   * Apply pre-configured pricing to line items
   */
  async applyPreConfiguredPricing(lineItems, organizationId, clientId) {
    for (const item of lineItems) {
      if (!item.unitPrice || item.unitPrice === 0) {
        try {
          const pricing = await this.getPricingForItem(
            item.ndisItemNumber,
            organizationId,
            clientId,
            'NSW', // Default state, could be made configurable
            'standard' // Default provider type, could be made configurable
          );
          
          if (pricing && pricing.price > 0) {
            item.unitPrice = pricing.price;
            item.totalPrice = item.quantity * pricing.price;
            item.pricingSource = pricing.source;
            item.pricingApplied = true;
          }
        } catch (error) {
          logger.warn('Failed to apply pricing for item', {
            ndisItemNumber: item.ndisItemNumber,
            error: error.message,
            organizationId: item.organizationId
          });
          item.pricingApplied = false;
        }
      }
    }
  }
  
  /**
    * Validate bulk generation parameters
    */
   validateBulkGenerationParams(params) {
     const errors = [];
     
     if (!params.organizationId) {
       errors.push('Organization ID is required for bulk generation');
     }
     
     if (!params.userEmail || typeof params.userEmail !== 'string') {
       errors.push('Valid userEmail is required for bulk generation');
     }
     
     if (!params.clients || !Array.isArray(params.clients) || params.clients.length === 0) {
       errors.push('At least one client is required for bulk generation');
     }
     
     if (params.clients && Array.isArray(params.clients)) {
       params.clients.forEach((client, index) => {
         if (!client.clientEmail) {
           errors.push(`Client at index ${index} is missing clientEmail`);
         }
         if (!client.startDate) {
           errors.push(`Client at index ${index} is missing startDate`);
         }
         if (!client.endDate) {
           errors.push(`Client at index ${index} is missing endDate`);
         }
         
         // Validate date format
         if (client.startDate && isNaN(Date.parse(client.startDate))) {
           errors.push(`Client at index ${index} has invalid startDate format`);
         }
         if (client.endDate && isNaN(Date.parse(client.endDate))) {
           errors.push(`Client at index ${index} has invalid endDate format`);
         }
       });
     }
     
     if (params.batchSize && (typeof params.batchSize !== 'number' || params.batchSize < 1 || params.batchSize > 50)) {
       errors.push('Batch size must be a number between 1 and 50');
     }
     
     return errors;
   }
   
   /**
    * Get pricing for a specific NDIS item
    * This method looks up pre-configured pricing from the pricing collection
    */
   async getPricingForItem(ndisItemNumber, organizationId, clientId, state = 'NSW', providerType = 'standard') {
     try {
       // First try to find organization-specific pricing
       let pricing = await this.db.collection('pricing').findOne({
         ndisItemNumber: ndisItemNumber,
         organizationId: organizationId,
         isActive: true,
         $or: [
           { state: state },
           { state: { $exists: false } }, // Global pricing
           { state: null }
         ]
       });
       
       if (pricing) {
         return {
           price: pricing.unitPrice || pricing.price,
           source: 'organization-specific',
           pricingId: pricing._id,
           state: pricing.state || 'global',
           providerType: pricing.providerType || 'standard'
         };
       }
       
       // If no organization-specific pricing, try client-specific pricing
       // Convert clientId to string for consistent querying
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
       
       pricing = await this.db.collection('pricing').findOne({
         ndisItemNumber: ndisItemNumber,
         clientId: clientIdForQuery,
         isActive: true,
         $or: [
           { state: state },
           { state: { $exists: false } },
           { state: null }
         ]
       });
       
       if (pricing) {
         return {
           price: pricing.unitPrice || pricing.price,
           source: 'client-specific',
           pricingId: pricing._id,
           state: pricing.state || 'global',
           providerType: pricing.providerType || 'standard'
         };
       }
       
       // Finally, try to find default/global pricing
       pricing = await this.db.collection('pricing').findOne({
         ndisItemNumber: ndisItemNumber,
         isActive: true,
         $and: [
           { organizationId: { $exists: false } },
           { clientId: { $exists: false } }
         ],
         $or: [
           { state: state },
           { state: { $exists: false } },
           { state: null }
         ]
       });
       
       if (pricing) {
         return {
           price: pricing.unitPrice || pricing.price,
           source: 'default',
           pricingId: pricing._id,
           state: pricing.state || 'global',
           providerType: pricing.providerType || 'standard'
         };
       }
       
       // If no pricing found, try to get NDIS standard pricing
       const ndisStandardPricing = await this.getNdisStandardPricing(ndisItemNumber, state);
       if (ndisStandardPricing) {
         return {
           price: ndisStandardPricing.price,
           source: 'ndis-standard',
           state: state,
           providerType: 'standard'
         };
       }
       
       return null;
       
     } catch (error) {
       logger.error('Error getting pricing for item', {
         ndisItemNumber,
         error: error.message,
         stack: error.stack
       });
       return null;
     }
   }
   
   /**
    * Get NDIS standard pricing for an item
    * This is a placeholder for NDIS price guide integration
    */
   async getNdisStandardPricing(ndisItemNumber, state = 'NSW') {
     try {
       // This would typically integrate with NDIS price guide API or database
       // For now, return some default pricing based on common NDIS items
       const standardPrices = {
         '01_011_0107_1_1': { price: 62.17, description: 'Assistance with self-care activities' },
         '01_013_0107_1_1': { price: 62.17, description: 'Assistance with household tasks' },
         '04_104_0136_6_1': { price: 193.99, description: 'Group and centre based activities' },
         '15_054_0128_1_1': { price: 194.46, description: 'Therapeutic supports' },
         'EXPENSE_OTHER': { price: 0, description: 'Other expenses' }
       };
       
       const standardPrice = standardPrices[ndisItemNumber];
       if (standardPrice) {
         return {
           price: standardPrice.price,
           description: standardPrice.description,
           source: 'ndis-standard',
           state: state
         };
       }
       
       return null;
       
     } catch (error) {
       logger.error('Error getting NDIS standard pricing', {
        ndisItemNumber,
        error: error.message,
        stack: error.stack
      });
       return null;
     }
   }

  /**
   * Generate invoice line items based on clientAssignment data
   * Replaces the random algorithm with intelligent item extraction
   */
  async generateInvoiceLineItems(userEmail, clientEmail, startDate, endDate) {
    try {
      await this.connect();

      // Get client assignment data
      const assignment = await this.db.collection('clientAssignments').findOne({
        userEmail: userEmail,
        clientEmail: clientEmail,
        isActive: true
      });

      if (!assignment) {
        throw new Error('No active assignment found for the specified user and client');
      }

      // Get client details for additional context
      const client = await this.db.collection('clients').findOne({
        clientEmail: clientEmail,
        isActive: true
      });

      if (!client) {
        throw new Error('Client not found or inactive');
      }

      // Get worked time data for the specified period
      const workedTimeData = await this.getWorkedTimeData(userEmail, clientEmail, startDate, endDate);

      // Generate line items based on assignment schedule and worked time
      const lineItems = await this.extractLineItemsFromAssignment(
        assignment,
        client,
        workedTimeData,
        startDate,
        endDate
      );

      // Note: Expenses are now handled separately via the includeExpenses parameter
      // in the endpoint, not automatically included in line items
      const allLineItems = lineItems;

      // Check for missing prices that require prompts
      const itemsWithMissingPrices = allLineItems.filter(item => item.promptRequired);
      const validLineItems = allLineItems.filter(item => !item.promptRequired);

      // Validate line items for NDIS compliance (only valid items)
      const validation = await this.validateInvoiceLineItems(validLineItems);

      // Separate service items and expense items for summary
      const serviceItems = validLineItems.filter(item => item.type !== 'expense');
      const expenseItems = validLineItems.filter(item => item.type === 'expense');

      const result = {
        success: true,
        lineItems: validLineItems,
        validation,
        metadata: {
          assignmentId: assignment._id,
          clientId: client._id,
          organizationId: client.organizationId,
          generatedAt: new Date(),
          extractionMethod: 'clientAssignment-based with automatic expense inclusion',
          totalItems: validLineItems.length,
          serviceItems: serviceItems.length,
          expenseItems: expenseItems.length
        },
        summary: {
          totalItems: validLineItems.length,
          serviceItems: serviceItems.length,
          expenseItems: expenseItems.length,
          totalAmount: validLineItems.reduce((sum, item) => sum + item.totalPrice, 0),
          serviceAmount: serviceItems.reduce((sum, item) => sum + item.totalPrice, 0),
          expenseAmount: expenseItems.reduce((sum, item) => sum + item.totalPrice, 0),
          ndisCompliant: validation.isValid,
          hasErrors: validation.errors.length > 0,
          hasWarnings: validation.warnings.length > 0
        }
      };

      // Add prompt information if there are missing prices
      if (itemsWithMissingPrices.length > 0) {
        result.pricePrompts = {
          required: true,
          count: itemsWithMissingPrices.length,
          items: itemsWithMissingPrices.map(item => ({
            ndisItemNumber: item.ndisItemNumber,
            description: item.description,
            quantity: item.quantity,
            unit: item.unit,
            promptData: item.promptData
          }))
        };
        result.summary.requiresPricePrompts = true;
      }

      return result;

    } catch (error) {
      logger.error('Invoice line items generation failed', {
        error: error.message,
        stack: error.stack,
        userEmail,
        clientEmail,
        startDate,
        endDate
      });
      throw error;
    }
  }

  /**
   * Extract line items from client assignment data
   */
  async extractLineItemsFromAssignment(assignment, client, workedTimeData, startDate, endDate) {
    const lineItems = [];
    const start = new Date(startDate);
    const end = new Date(endDate);

    // Process assignment schedule data
    if (assignment.schedule && Array.isArray(assignment.schedule)) {
      for (const scheduleItem of assignment.schedule) {
        const scheduleDate = new Date(scheduleItem.date);
        
        // Check if schedule date falls within the invoice period
        if (scheduleDate >= start && scheduleDate <= end) {
          const lineItem = await this.createLineItemFromSchedule(
            scheduleItem,
            assignment,
            client,
            workedTimeData
          );
          
          if (lineItem) {
            lineItems.push(lineItem);
          }
        }
      }
    }

    // If no schedule data, fall back to worked time data
    if (lineItems.length === 0 && workedTimeData.length > 0) {
      for (const workEntry of workedTimeData) {
        const lineItem = await this.createLineItemFromWorkedTime(
          workEntry,
          assignment,
          client
        );
        
        if (lineItem) {
          lineItems.push(lineItem);
        }
      }
    }

    return lineItems;
  }

  /**
   * Create line item from schedule data
   */
  async createLineItemFromSchedule(scheduleItem, assignment, client, workedTimeData) {
    try {
      // Get NDIS item information
      const ndisItem = scheduleItem.ndisItem || assignment.ndisItem;
      
      if (!ndisItem || !ndisItem.itemNumber) {
        logger.warn('No NDIS item found for schedule', {
          scheduleDate: scheduleItem.date,
          userEmail: assignment.userEmail,
          clientEmail: assignment.clientEmail
        });
        return null;
      }

      // Calculate hours worked
      const startTime = this.parseTime(scheduleItem.startTime);
      const endTime = this.parseTime(scheduleItem.endTime);
      const breakMinutes = parseInt(scheduleItem.break) || 0;
      
      const totalMinutes = this.calculateWorkMinutes(startTime, endTime, breakMinutes);
      const hoursWorked = totalMinutes / 60;

      // Get pricing information with enhanced validation
      const pricing = await this.getPricingForItem(
        ndisItem.itemNumber,
        client.organizationId,
        client._id,
        scheduleItem.state || 'NSW',
        scheduleItem.providerType || 'standard'
      );

      // Determine quantity and unit price based on NDIS item unit
      // Validate pricing before calculations
      if (!pricing || pricing.price === null || pricing.price === undefined || isNaN(pricing.price)) {
        logger.warn('Invalid pricing for NDIS item', {
          ndisItemNumber: ndisItem.itemNumber,
          pricing,
          scheduleDate: scheduleItem.date
        });
        return null;
      }

      let quantity, unitPrice;
      if (ndisItem.unit && ndisItem.unit.toUpperCase() === 'H') {
        // Hourly service
        quantity = hoursWorked;
        unitPrice = pricing.price;
      } else {
        // Per-item service
        quantity = 1;
        unitPrice = pricing.price * hoursWorked;
      }

      // Ensure values are valid numbers before calling toFixed
      const safeQuantity = isNaN(quantity) ? 0 : quantity;
      const safeUnitPrice = isNaN(unitPrice) ? 0 : unitPrice;
      const safeTotalPrice = safeQuantity * safeUnitPrice;

      return {
        date: scheduleItem.date,
        description: `${ndisItem.itemNumber} - ${ndisItem.itemName || ndisItem.description}`,
        quantity: parseFloat(safeQuantity.toFixed(2)),
        unitPrice: parseFloat(safeUnitPrice.toFixed(2)),
        totalPrice: parseFloat(safeTotalPrice.toFixed(2)),
        ndisItemNumber: ndisItem.itemNumber,
        ndisItemName: ndisItem.itemName || ndisItem.description,
        unit: ndisItem.unit || 'H',
        isHighIntensity: scheduleItem.highIntensity || false,
        startTime: scheduleItem.startTime,
        endTime: scheduleItem.endTime,
        breakMinutes: breakMinutes,
        hoursWorked: parseFloat(hoursWorked.toFixed(2)),
        source: 'clientAssignment',
        organizationId: client.organizationId,
        clientId: client._id,
        assignmentId: assignment._id,
        pricingMetadata: {
          pricingSource: pricing.source,
          isCustomPricing: pricing.isCustom,
          ndisCompliant: pricing.ndisCompliant
        }
      };

    } catch (error) {
      logger.error('Error creating line item from schedule', {
      error: error.message,
      stack: error.stack,
      scheduleData: schedule
    });
      return null;
    }
  }

  /**
   * Create line item from worked time data (fallback method)
   */
  async createLineItemFromWorkedTime(workEntry, assignment, client) {
    try {
      // Use assigned NDIS item or default
      const ndisItemNumber = assignment.assignedNdisItemNumber || '01_001_0107_1_1'; // Default support item
      
      // Get NDIS item details
      const ndisItem = await this.getNdisItemDetails(ndisItemNumber);
      
      if (!ndisItem) {
        logger.warn('NDIS item not found', {
      ndisItemNumber
    });
        return null;
      }

      // Get pricing information with enhanced validation
      const pricing = await this.getPricingForItem(
        ndisItemNumber,
        client.organizationId,
        client._id,
        workEntry.state || 'NSW',
        workEntry.providerType || 'standard'
      );

      const hoursWorked = parseFloat(workEntry.timeWorked) || 0;
      
      // Validate pricing before calculations
      if (!pricing || pricing.price === null || pricing.price === undefined || isNaN(pricing.price)) {
        logger.warn('Invalid pricing for NDIS item', {
      ndisItemNumber,
      pricing
    });
        // Return a line item with zero pricing for manual review
        return {
          date: workEntry.date,
          description: `${ndisItemNumber} - ${ndisItem.itemName}`,
          quantity: parseFloat(hoursWorked.toFixed(2)),
          unitPrice: 0,
          totalPrice: 0,
          ndisItemNumber: ndisItemNumber,
          ndisItemName: ndisItem.itemName,
          unit: ndisItem.unit || 'H',
          hoursWorked: hoursWorked,
          source: 'workedTime',
          organizationId: client.organizationId,
          clientId: client._id,
          assignmentId: assignment._id,
          pricingStatus: 'invalid',
          promptRequired: true,
          pricingMetadata: {
            pricingSource: 'invalid',
            isCustomPricing: false,
            ndisCompliant: false,
            error: 'Invalid or missing pricing data'
          }
        };
      }

      let quantity, unitPrice;
      if (ndisItem.unit && ndisItem.unit.toUpperCase() === 'H') {
        quantity = hoursWorked;
        unitPrice = pricing.price;
      } else {
        quantity = 1;
        unitPrice = pricing.price * hoursWorked;
      }

      // Handle missing pricing - store prompt data for later resolution
      if (pricing.source === 'missing') {
        const safeQuantity = isNaN(quantity) ? 0 : quantity;
        return {
          date: workEntry.date,
          description: `${ndisItemNumber} - ${ndisItem.itemName}`,
          quantity: parseFloat(safeQuantity.toFixed(2)),
          unitPrice: 0,
          totalPrice: 0,
          ndisItemNumber: ndisItemNumber,
          ndisItemName: ndisItem.itemName,
          unit: ndisItem.unit || 'H',
          hoursWorked: hoursWorked,
          source: 'workedTime',
          organizationId: client.organizationId,
          clientId: client._id,
          assignmentId: assignment._id,
          pricingStatus: 'missing',
          promptRequired: true,
          promptData: {
            ...pricing.promptData,
            quantity: quantity,
            unit: ndisItem.unit || 'H',
            workEntryId: workEntry._id,
            clientId: client._id,
            organizationId: client.organizationId
          },
          pricingMetadata: {
            pricingSource: pricing.source,
            isCustomPricing: pricing.isCustom,
            ndisCompliant: pricing.ndisCompliant,
            requiresManualPricing: pricing.requiresManualPricing
          }
        };
      }

      // Ensure values are valid numbers before calling toFixed
      const safeQuantity = isNaN(quantity) ? 0 : quantity;
      const safeUnitPrice = isNaN(unitPrice) ? 0 : unitPrice;
      const safeTotalPrice = safeQuantity * safeUnitPrice;

      return {
        date: workEntry.date,
        description: `${ndisItemNumber} - ${ndisItem.itemName}`,
        quantity: parseFloat(safeQuantity.toFixed(2)),
        unitPrice: parseFloat(safeUnitPrice.toFixed(2)),
        totalPrice: parseFloat(safeTotalPrice.toFixed(2)),
        ndisItemNumber: ndisItemNumber,
        ndisItemName: ndisItem.itemName,
        unit: ndisItem.unit || 'H',
        hoursWorked: hoursWorked,
        source: 'workedTime',
        organizationId: client.organizationId,
        clientId: client._id,
        assignmentId: assignment._id,
        pricingMetadata: {
          pricingSource: pricing.source,
          isCustomPricing: pricing.isCustom,
          ndisCompliant: pricing.ndisCompliant
        }
      };

    } catch (error) {
      logger.error('Error creating line item from worked time', {
      error: error.message,
      stack: error.stack,
      workedTimeData: workedTime
    });
      return null;
    }
  }

  /**
   * Get worked time data for the specified period
   */
  async getWorkedTimeData(userEmail, clientEmail, startDate, endDate) {
    try {
      const workedTimeData = await this.db.collection('workedTime').find({
        userEmail: userEmail,
        clientEmail: clientEmail,
        date: {
          $gte: startDate,
          $lte: endDate
        }
      }).toArray();

      return workedTimeData || [];
    } catch (error) {
      logger.error('Error fetching worked time data', {
      error: error.message,
      stack: error.stack,
      organizationId,
      clientId,
      startDate,
      endDate
    });
      return [];
    }
  }

  /**
   * Get approved expenses for automatic inclusion in invoice generation
   * Task 2.4: Implement automatic expense inclusion in invoice generation
   * Returns raw expense data instead of converting to line items
   */
  async getApprovedExpensesForInvoice(organizationId, clientId, startDate, endDate) {
    try {
      logger.debug('getApprovedExpensesForInvoice called', {
      organizationId,
      organizationIdType: typeof organizationId,
      clientId,
      clientIdType: typeof clientId,
      startDate,
      startDateType: typeof startDate,
      endDate,
      endDateType: typeof endDate
    });
      
      // Keep clientId as string since it's stored as string in the database
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
      
      logger.debug('Using clientId for query', {
      clientIdForQuery,
      clientIdForQueryType: typeof clientIdForQuery
    });
      
      const query = {
        organizationId: organizationId,
        clientId: clientIdForQuery,
        expenseDate: {
          $gte: new Date(startDate),
          $lte: new Date(endDate)
        },
        approvalStatus: 'approved',
        isActive: true,
        isReimbursable: true // Only include reimbursable expenses in invoices
      };
      
      logger.debug('MongoDB query details', {
      query,
      clientIdForQuery
    });
      
      // Test query without clientId first to see if other filters work
      const testQuery = {
        organizationId: organizationId,
        expenseDate: {
          $gte: new Date(startDate),
          $lte: new Date(endDate)
        },
        approvalStatus: 'approved',
        isActive: true,
        isReimbursable: true
      };
      
      const testExpenses = await this.db.collection('expenses').find(testQuery).toArray();
      logger.debug('Test query without clientId results', {
         testExpensesCount: testExpenses.length,
         sampleExpenseClientId: testExpenses.length > 0 ? testExpenses[0].clientId : null,
         sampleExpenseClientIdType: testExpenses.length > 0 ? typeof testExpenses[0].clientId : null
       });
      
      // Query for approved expenses within the date range
      const expenses = await this.db.collection('expenses').find(query).toArray();
      
      logger.debug('Approved expenses found', {
         expensesCount: expenses.length,
         sampleExpense: expenses.length > 0 ? expenses[0] : null
       });

      // Return raw expense data with formatted fields for invoice display
      const formattedExpenses = expenses.map(expense => ({
        _id: expense._id,
        description: expense.description,
        amount: expense.amount,
        category: expense.category,
        subcategory: expense.subcategory,
        expenseDate: expense.expenseDate,
        receiptUrl: expense.receiptUrl,
        submittedBy: expense.submittedBy,
        approvedAt: expense.updatedAt,
        clientId: expense.clientId,
        organizationId: expense.organizationId,
        isReimbursable: expense.isReimbursable,
        metadata: {
          source: 'expense',
          originalExpenseId: expense._id
        }
      }));

      return formattedExpenses;
    } catch (error) {
      logger.error('Error retrieving approved expenses for invoice', {
       error: error.message,
       stack: error.stack,
       organizationId,
       clientId,
       startDate,
       endDate
     });
      return []; // Return empty array on error to not break invoice generation
    }
  }

  /**
   * Convert expense record to invoice line item format
   */
  async convertExpenseToLineItem(expense) {
    try {
      // If expense has a support item number, use it for NDIS compliance
      let ndisItemNumber = expense.supportItemNumber;
      let itemDescription = expense.supportItemName || expense.description;
      let unitPrice = expense.amount;
      let quantity = 1;
      let unit = 'each';

      // If no support item number, create a generic expense line item
      if (!ndisItemNumber) {
        // Use a generic expense code or create one based on category
        ndisItemNumber = this.getExpenseCategoryCode(expense.category);
        itemDescription = `${expense.category}: ${expense.description}`;
      }

      // Get NDIS item details for validation if available
      let ndisDetails = null;
      if (ndisItemNumber && ndisItemNumber !== 'EXPENSE_OTHER') {
        ndisDetails = await this.getNdisItemDetails(ndisItemNumber);
      }

      const lineItem = {
        id: expense._id.toString(),
        type: 'expense',
        ndisItemNumber: ndisItemNumber,
        itemDescription: itemDescription,
        quantity: quantity,
        unit: unit,
        unitPrice: unitPrice,
        totalPrice: unitPrice * quantity,
        date: expense.expenseDate,
        expenseId: expense._id,
        category: expense.category,
        subcategory: expense.subcategory,
        receiptUrl: expense.receiptUrl,
        notes: expense.notes,
        submittedBy: expense.submittedBy,
        approvedAt: expense.updatedAt,
        pricingStatus: 'fixed', // Expenses have fixed pricing
        promptRequired: false,
        ndisCompliant: ndisDetails ? true : false,
        metadata: {
          source: 'expense',
          expenseCategory: expense.category,
          expenseSubcategory: expense.subcategory,
          originalExpenseId: expense._id,
          isReimbursable: expense.isReimbursable
        }
      };

      return lineItem;
    } catch (error) {
      logger.error('Expense to line item conversion failed', {
        error: error.message,
        stack: error.stack,
        expenseId: expense._id
      });
      return null;
    }
  }

  /**
   * Get NDIS item code for expense categories
   */
  getExpenseCategoryCode(category) {
    const categoryMappings = {
      'transportation': '01_011_0107_1_1', // Transport - Public transport
      'accommodation': '01_012_0117_1_1', // Accommodation/Tenancy
      'meals': '01_013_0133_1_1', // Daily Tasks/Shared Living
      'equipment': '03_092_0104_6_1', // Assistive Technology
      'training': '02_104_0125_6_1', // Capacity Building
      'support': '01_015_0106_1_1', // Community/Social/Civic
      'other': 'EXPENSE_OTHER'
    };

    return categoryMappings[category.toLowerCase()] || 'EXPENSE_OTHER';
  }

  /**
   * Get pricing for NDIS item with dynamic lookup
   * Priority: Client-specific → Organization → NDIS caps
   */
  async getPricingForItem(ndisItemNumber, organizationId, clientId, state = 'NSW', providerType = 'standard') {
    try {
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

      // 1. Check for client-specific pricing
      const clientPricing = await this.db.collection('customPricing').findOne({
        supportItemNumber: ndisItemNumber,
        organizationId: organizationId,
        clientId: clientIdForQuery,
        isActive: true,
        approvalStatus: 'approved'
      });

      if (clientPricing) {
        // Validate client-specific pricing against NDIS caps
        const validation = await priceValidationService.validatePrice(
          ndisItemNumber,
          clientPricing.customPrice,
          state,
          providerType
        );

        // Generate warning message if price exceeds cap
        let priceCapWarning = null;
        if (!validation.isValid && validation.status === 'exceeds_cap') {
          priceCapWarning = `Client-specific price $${clientPricing.customPrice.toFixed(2)} exceeds NDIS price cap of $${validation.priceCap.toFixed(2)} for ${state} ${providerType} services`;
        }

        return {
          price: clientPricing.customPrice,
          source: 'client-specific',
          isCustom: true,
          ndisCompliant: validation.isValid,
          exceedsNdisCap: !validation.isValid && validation.status === 'exceeds_cap',
          priceCap: validation.priceCap,
          priceCapWarning: priceCapWarning,
          validationDetails: validation
        };
      }

      // 2. Check for organization custom pricing
      const orgPricing = await this.db.collection('customPricing').findOne({
        supportItemNumber: ndisItemNumber,
        organizationId: organizationId,
        clientId: { $exists: false },
        isActive: true,
        approvalStatus: 'approved'
      });

      if (orgPricing) {
        // Validate organization pricing against NDIS caps
        const validation = await priceValidationService.validatePrice(
          ndisItemNumber,
          orgPricing.customPrice,
          state,
          providerType
        );

        // Generate warning message if price exceeds cap
        let priceCapWarning = null;
        if (!validation.isValid && validation.status === 'exceeds_cap') {
          priceCapWarning = `Organization price $${orgPricing.customPrice.toFixed(2)} exceeds NDIS price cap of $${validation.priceCap.toFixed(2)} for ${state} ${providerType} services`;
        }

        return {
          price: orgPricing.customPrice,
          source: 'organization',
          isCustom: true,
          ndisCompliant: validation.isValid,
          exceedsNdisCap: !validation.isValid && validation.status === 'exceeds_cap',
          priceCap: validation.priceCap,
          priceCapWarning: priceCapWarning,
          validationDetails: validation
        };
      }

      // 3. Fall back to $30.00 base rate as specified in requirements
      const baseRate = 30.00;
      const ndisItem = await this.getNdisItemDetails(ndisItemNumber);
      
      // Get price cap for validation if NDIS item exists
      let priceCap = null;
      let exceedsNdisCap = false;
      let priceCapWarning = null;
      
      if (ndisItem && ndisItem.priceCaps) {
        const stateKey = state.toUpperCase();
        const providerKey = providerType === 'highIntensity' ? 'highIntensity' : 'standard';
        
        // Get the appropriate price cap for validation
        if (ndisItem.priceCaps[providerKey] && ndisItem.priceCaps[providerKey][stateKey]) {
          priceCap = parseFloat(ndisItem.priceCaps[providerKey][stateKey]);
        } else if (ndisItem.priceCaps.standard && ndisItem.priceCaps.standard[stateKey]) {
          priceCap = parseFloat(ndisItem.priceCaps.standard[stateKey]);
        }
        
        // Check if base rate exceeds price cap
        if (priceCap && baseRate > priceCap) {
          exceedsNdisCap = true;
          priceCapWarning = `Base rate $${baseRate.toFixed(2)} exceeds NDIS price cap of $${priceCap.toFixed(2)} for ${state} ${providerType} services`;
        }
      }

      return {
        price: baseRate,
        source: 'base-rate',
        isCustom: false,
        ndisCompliant: !exceedsNdisCap,
        exceedsNdisCap: exceedsNdisCap,
        priceCap: priceCap,
        priceCapWarning: priceCapWarning,
        supportItemDetails: ndisItem ? {
          supportItemName: ndisItem.supportItemName,
          supportType: ndisItem.supportType,
          unit: ndisItem.unit,
          quoteRequired: ndisItem.quoteRequired
        } : null
      };

    } catch (error) {
      logger.error('Item pricing retrieval failed', {
        error: error.message,
        stack: error.stack,
        ndisItemNumber,
        organizationId,
        clientId,
        state,
        providerType
      });
      return {
        price: 0,
        source: 'error',
        isCustom: false,
        ndisCompliant: false,
        exceedsNdisCap: false,
        error: error.message,
        priceCap: null
      };
    }
  }

  /**
   * Get NDIS item details
   */
  async getNdisItemDetails(itemNumber) {
    try {
      const ndisItem = await this.db.collection('supportItems').findOne({
        supportItemNumber: itemNumber
      });
      
      return ndisItem;
    } catch (error) {
      logger.error('NDIS item details fetch failed', {
        error: error.message,
        stack: error.stack,
        itemNumber
      });
      return null;
    }
  }

  /**
   * Parse time string to minutes from midnight
   */
  parseTime(timeStr) {
    const [hours, minutes] = timeStr.split(':').map(Number);
    return hours * 60 + minutes;
  }

  /**
   * Calculate work minutes between start and end time, minus break
   */
  calculateWorkMinutes(startMinutes, endMinutes, breakMinutes) {
    let totalMinutes = endMinutes - startMinutes;
    
    // Handle overnight shifts
    if (totalMinutes < 0) {
      totalMinutes += 24 * 60; // Add 24 hours
    }
    
    return Math.max(0, totalMinutes - breakMinutes);
  }

  /**
   * Validate invoice generation parameters
   */
  validateGenerationParams(userEmail, clientEmail, startDate, endDate) {
    const errors = [];

    if (!userEmail || typeof userEmail !== 'string') {
      errors.push('Valid userEmail is required');
    }

    if (!clientEmail || typeof clientEmail !== 'string') {
      errors.push('Valid clientEmail is required');
    }

    if (!startDate || isNaN(new Date(startDate))) {
      errors.push('Valid startDate is required');
    }

    if (!endDate || isNaN(new Date(endDate))) {
      errors.push('Valid endDate is required');
    }

    if (startDate && endDate && new Date(startDate) > new Date(endDate)) {
      errors.push('startDate must be before endDate');
    }

    return errors;
  }

  /**
   * Validate invoice generation parameters
   */
  validateInvoiceGenerationParams(params) {
    const errors = [];

    if (!params.organizationId) {
      errors.push('Organization ID is required');
    }

    if (!params.clientId) {
      errors.push('Client ID is required');
    }

    if (!params.startDate || !params.endDate) {
      errors.push('Start date and end date are required');
    }

    if (params.startDate && params.endDate) {
      const start = new Date(params.startDate);
      const end = new Date(params.endDate);
      
      if (start >= end) {
        errors.push('Start date must be before end date');
      }

      // Check if date range is reasonable (not more than 3 months)
      const diffMonths = (end - start) / (1000 * 60 * 60 * 24 * 30);
      if (diffMonths > 3) {
        errors.push('Date range cannot exceed 3 months');
      }
    }

    return {
      isValid: errors.length === 0,
      errors
    };
  }

  /**
   * Validate invoice line items for NDIS compliance and pricing issues
   */
  /**
   * Enhanced invoice line items validation using integrated price validation service
   * Combines basic validation with comprehensive NDIS price validation
   */
  async validateInvoiceLineItems(lineItems, options = {}) {
    try {
      const {
        defaultState = 'NSW',
        defaultProviderType = 'standard',
        skipPriceValidation = false
      } = options;

      const validationResults = {
        isValid: true,
        totalItems: lineItems.length,
        validItems: 0,
        invalidItems: 0,
        warnings: [],
        errors: [],
        itemValidations: [],
        priceValidationSummary: null
      };

      // Basic validation first
      for (const item of lineItems) {
        const itemValidation = {
          lineItemId: item.id || item._id,
          ndisItemNumber: item.ndisItemNumber,
          isValid: true,
          issues: []
        };

        // Check for zero or negative quantities
        if (!item.quantity || item.quantity <= 0) {
          itemValidation.isValid = false;
          itemValidation.issues.push({
            type: 'invalid_quantity',
            message: 'Quantity must be greater than zero',
            severity: 'error'
          });
          validationResults.errors.push(`Item ${item.ndisItemNumber}: Invalid quantity`);
        }

        // Check for zero or negative unit price
        if (!item.unitPrice || item.unitPrice <= 0) {
          itemValidation.isValid = false;
          itemValidation.issues.push({
            type: 'invalid_unit_price',
            message: 'Unit price must be greater than zero',
            severity: 'error'
          });
          validationResults.errors.push(`Item ${item.ndisItemNumber}: Invalid unit price`);
        }

        // Check for missing NDIS item number
        if (!item.ndisItemNumber) {
          itemValidation.isValid = false;
          itemValidation.issues.push({
            type: 'missing_ndis_item',
            message: 'NDIS item number is required',
            severity: 'error'
          });
          validationResults.errors.push(`Line item missing NDIS item number`);
        }

        if (itemValidation.isValid) {
          validationResults.validItems++;
        } else {
          validationResults.invalidItems++;
          validationResults.isValid = false;
        }

        validationResults.itemValidations.push(itemValidation);
      }

      // Enhanced price validation using dedicated price validation service
      if (!skipPriceValidation && lineItems.length > 0) {
        try {
          const priceValidationResult = await this.validateLineItemPricing(
            lineItems,
            defaultState,
            defaultProviderType
          );

          validationResults.priceValidationSummary = priceValidationResult.summary;

          // Merge price validation results with basic validation
          priceValidationResult.results.forEach((priceResult, index) => {
            const itemValidation = validationResults.itemValidations[index];
            if (itemValidation) {
              // Add price validation issues
              if (!priceResult.isValid) {
                itemValidation.isValid = false;
                validationResults.isValid = false;
                
                if (priceResult.status === 'exceeds_cap') {
                  itemValidation.issues.push({
                    type: 'pricing_exceeds_cap',
                    message: `Price $${priceResult.proposedPrice} exceeds NDIS cap of $${priceResult.priceCap}`,
                    severity: 'error',
                    priceCap: priceResult.priceCap,
                    proposedPrice: priceResult.proposedPrice
                  });
                  validationResults.errors.push(`Item ${priceResult.supportItemNumber}: Price exceeds NDIS cap`);
                } else if (priceResult.status === 'item_not_found') {
                  itemValidation.issues.push({
                    type: 'ndis_item_not_found',
                    message: 'NDIS item not found in price guide',
                    severity: 'error'
                  });
                  validationResults.errors.push(`Item ${priceResult.supportItemNumber}: Not found in NDIS price guide`);
                }
              }

              // Add warnings for quote requirements
              if (priceResult.requiresQuote) {
                itemValidation.issues.push({
                  type: 'quote_required',
                  message: 'This item requires a quote for pricing above standard rates',
                  severity: 'warning'
                });
                validationResults.warnings.push(`Item ${priceResult.supportItemNumber}: Quote required`);
              }

              // Add price validation details
              itemValidation.priceValidation = {
                isValid: priceResult.isValid,
                status: priceResult.status,
                priceCap: priceResult.priceCap,
                proposedPrice: priceResult.proposedPrice,
                requiresQuote: priceResult.requiresQuote,
                compliancePercentage: priceResult.compliancePercentage
              };
            }
          });

          // Recalculate valid/invalid counts after price validation
          validationResults.validItems = validationResults.itemValidations.filter(item => item.isValid).length;
          validationResults.invalidItems = validationResults.itemValidations.filter(item => !item.isValid).length;

        } catch (priceValidationError) {
          logger.warn('Price validation service unavailable', {
            error: priceValidationError.message,
            lineItemCount: lineItems.length
          });
          validationResults.warnings.push('Price validation service unavailable - basic validation only');
        }
      }

      return validationResults;

    } catch (error) {
      logger.error('Invoice line items validation failed', {
        error: error.message,
        stack: error.stack,
        lineItemCount: lineItems.length
      });
      return {
        isValid: false,
        error: error.message,
        totalItems: lineItems.length,
        validItems: 0,
        invalidItems: lineItems.length,
        warnings: [],
        errors: [error.message],
        itemValidations: []
      };
    }
  }

  /**
   * Validate line item pricing using the dedicated price validation service
   */
  async validateLineItemPricing(lineItems, defaultState = 'NSW', defaultProviderType = 'standard') {
    try {
      // Transform line items for price validation
      const validationRequests = lineItems.map((item, index) => ({
        requestId: item.id || `line_${index}`,
        supportItemNumber: item.ndisItemNumber,
        proposedPrice: item.unitPrice,
        state: item.state || defaultState,
        providerType: item.providerType || defaultProviderType,
        serviceDate: item.serviceDate || new Date(),
        quantity: item.quantity || 1,
        description: item.description || item.itemName
      }));

      // Use the price validation service directly
      const results = await priceValidationService.validatePricesBatch(validationRequests);
      const summary = priceValidationService.getValidationSummary(results);

      // Calculate enhanced summary with invoice-specific metrics
      let totalInvoiceAmount = 0;
      let totalCompliantAmount = 0;
      let hasNonCompliantItems = false;

      const enhancedResults = results.map((result, index) => {
        const lineItem = lineItems[index];
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

      const enhancedSummary = {
        ...summary,
        totalInvoiceAmount,
        totalCompliantAmount,
        totalExcessAmount: totalInvoiceAmount - totalCompliantAmount,
        hasNonCompliantItems,
        compliancePercentage: totalInvoiceAmount > 0 ? ((totalCompliantAmount / totalInvoiceAmount) * 100).toFixed(2) : 100
      };

      return {
        results: enhancedResults,
        summary: enhancedSummary
      };

    } catch (error) {
      logger.error('Line item pricing validation failed', {
        error: error.message,
        stack: error.stack,
        lineItemCount: lineItems.length,
        defaultState,
        defaultProviderType
      });
      throw new Error(`Price validation failed: ${error.message}`);
    }
  }
}

module.exports = InvoiceGenerationService;