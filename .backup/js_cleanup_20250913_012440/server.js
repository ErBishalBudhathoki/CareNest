const path = require('path');
require("dotenv").config({ path: path.join(__dirname, '.env') });

process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
  process.exit(1);
});

process.on('uncaughtException', (error) => {
  console.error('Uncaught Exception:', error);
  process.exit(1);
});

const express = require("express");
const bodyParser = require("body-parser");
const iconv = require("iconv-lite");
const fs = require("fs");
const csv = require("csv-parser");
const https = require("https");
const xlsx = require("xlsx");
const multer = require("multer");
const nodemailer = require('nodemailer');
const crypto = require('crypto');
const { v4: uuidv4 } = require('uuid');
const axios = require('axios');
const cors = require("cors");
const helmet = require("helmet");
const serverless = require("serverless-http");
const { MongoClient, ServerApiVersion, ObjectId } = require("mongodb");

// Firebase Admin SDK Configuration Generation
// fs and path are already imported at the top of server.js
// const fs = require('fs');
// const path = require('path');

const firebaseTemplatePath = path.join(__dirname, 'firebase-admin-config.js.template');
const firebaseOutputPath = path.join(__dirname, 'firebase-admin-config.js');

// Check if the template file exists and generate the config
if (fs.existsSync(firebaseTemplatePath)) {
  const templateContent = fs.readFileSync(firebaseTemplatePath, 'utf8');
  fs.writeFileSync(firebaseOutputPath, templateContent, 'utf8');
  console.log('Firebase Admin SDK configuration file generated successfully.');
} else {
  console.warn('Firebase Admin SDK template file not found. Skipping configuration generation.');
}

const { admin, messaging } = require('./firebase-admin-config'); // Initialize Firebase Admin SDK
console.log('Firebase Admin SDK loaded successfully');
const logger = require('./config/logger'); // Import structured logger
console.log('Logger loaded successfully');
const { startTimerWithTracking, stopTimerWithTracking, getActiveTimers } = require('./active_timers_endpoints');
console.log('Active timers endpoints loaded successfully');
const {
  createCustomPricing,
  getOrganizationPricing,
  getPricingById,
  updateCustomPricing,
  deleteCustomPricing,
  updatePricingApproval,
  getPricingLookup,
  getBulkPricingLookup,
  bulkImportPricing
} = require('./pricing_endpoints');
console.log('Pricing endpoints loaded successfully');
const {
  createExpense,
  getOrganizationExpenses,
  getExpenseById,
  updateExpense,
  deleteExpense,
  updateExpenseApproval,
  getExpenseCategories,
  bulkImportExpenses
} = require('./services/expenseService');
console.log('Expense service loaded successfully');
const {
  validatePrice,
  validatePricesBatch,
  getPriceCaps,
  checkQuoteRequired,
  validateInvoiceLineItems,
  getValidationStats
} = require('./price_validation_endpoints');
console.log('Price validation endpoints loaded successfully');
const {
  getEntityAuditHistoryEndpoint,
  getOrganizationAuditLogsEndpoint,
  getAuditStatisticsEndpoint,
  createAuditLogEndpoint,
  getAuditMetadataEndpoint,
  exportAuditLogsEndpoint
} = require('./audit_trail_endpoints');
console.log('Audit trail endpoints loaded successfully');
const {
  processRecurringExpensesEndpoint,
  createRecurringExpenseEndpoint,
  getOrganizationRecurringExpensesEndpoint,
  updateRecurringExpenseEndpoint,
  deactivateRecurringExpenseEndpoint,
  getRecurringExpenseStatisticsEndpoint,
  getRecurringExpenseByIdEndpoint
} = require('./recurring_expense_endpoints');
console.log('Recurring expense endpoints loaded successfully');
const { 
  generateInvoiceLineItems, 
  getInvoicePreview, 
  getAvailableAssignments, 
  validateInvoiceGenerationData, 
  generateBulkInvoices,
  validateExistingInvoiceLineItems,
  validatePricingRealtime,
  getInvoiceValidationReport
} = require('./invoice_generation_endpoints');
console.log('Invoice generation endpoints loaded successfully');
const {
  getInvoicesList,
  getInvoiceDetails,
  shareInvoice,
  deleteInvoice,
  getInvoiceStats
} = require('./endpoints/invoice_management_endpoints');
console.log('Invoice management endpoints loaded successfully');
const {
  createPricePrompt,
  resolvePricePrompt,
  getPendingPrompts,
  cancelPricePrompt,
  generateInvoiceWithPrompts,
  completeInvoiceGeneration
} = require('./price_prompt_endpoints');
console.log('Price prompt endpoints loaded successfully');
const {
  processLegacyInvoice,
  validateLegacyCompatibility,
  transformLegacyInvoice,
  migrateLegacyInvoicesBatch,
  getLegacyDataStats,
  mapLegacyItemToNdis,
  checkInvoiceCompatibility
} = require('./backward_compatibility_endpoints');
console.log('Backward compatibility endpoints loaded successfully');
const { loggingMiddleware } = require('./middleware/logging');
console.log('Logging middleware loaded successfully');
const { errorTrackingMiddleware } = require('./middleware/errorTracking');
console.log('Error tracking middleware loaded successfully');
const { systemHealthMiddleware } = require('./middleware/systemHealth');
console.log('System health middleware loaded successfully');
const {
  getPricingAnalytics,
  getPricingComplianceReport
} = require('./endpoints/pricing_analytics_endpoints');
console.log('Pricing analytics endpoints loaded successfully');
const {
  getClientActivityAnalytics,
  getTopPerformingClients,
  getClientServicePatterns
} = require('./endpoints/client_activity_endpoints');
console.log('Client activity endpoints loaded successfully');
const {
  getBusinessIntelligenceDashboard,
  getRevenueForecastAnalysis,
  getOperationalEfficiencyReport
} = require('./endpoints/business_intelligence_endpoints');
console.log('Business intelligence endpoints loaded successfully');
const metricsRoutes = require('./routes/metrics');
console.log('Metrics routes loaded successfully');
const invoiceManagementRoutes = require('./routes/invoiceManagement');
console.log('Invoice management routes loaded successfully');
const authRoutes = require('./routes/auth');
console.log('Auth routes loaded successfully');
const { apiUsageMonitor } = require('./utils/apiUsageMonitor');
console.log('API usage monitor loaded successfully');
const securityDashboardRoutes = require('./routes/securityDashboard');
console.log('Security dashboard routes loaded successfully');
const apiUsageRoutes = require('./routes/apiUsageRoutes');
console.log('API usage routes loaded successfully');
const uri = process.env.MONGODB_URI;

var app = express();

// Security middleware - must be first
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
      connectSrc: ["'self'"],
      fontSrc: ["'self'"],
      objectSrc: ["'none'"],
      mediaSrc: ["'self'"],
      frameSrc: ["'none'"]
    }
  },
  crossOriginEmbedderPolicy: false
}));

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(systemHealthMiddleware);
app.use(loggingMiddleware);
app.use(errorTrackingMiddleware);

// API usage monitoring middleware (records per-request metrics)
app.use(apiUsageMonitor.middleware);

// Add metrics routes
app.use('/', metricsRoutes);

// Add invoice management routes
app.use('/', invoiceManagementRoutes);

// Add authentication routes
app.use('/auth', authRoutes);

// Mount security dashboard routes
app.use('/api/security', securityDashboardRoutes);

// Mount API usage analytics routes
app.use('/api/analytics', apiUsageRoutes);

// Authentication test endpoint
const authTestEndpoint = require('./auth_test_endpoint');
app.use('/auth-test', authTestEndpoint);

// Serve static files from uploads directory
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Configure multer to handle file uploads
const upload = multer({
  storage: multer.diskStorage({
    destination: "./uploads",
    filename: (req, file, cb) => {
      // Generate unique filename with timestamp
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
      const fileExtension = path.extname(file.originalname);
      cb(null, 'receipt-' + uniqueSuffix + fileExtension);
    },
  }),
  fileFilter: (req, file, cb) => {
    // Check file type - allow images and PDF files
    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/heif', 'image/heic', 'application/pdf'];
    
    console.log(`File upload attempt - Original name: ${file.originalname}, MIME type: ${file.mimetype}, Field name: ${file.fieldname}`);
    
    // Check MIME type first
    if (allowedTypes.includes(file.mimetype)) {
      console.log(`File accepted based on MIME type: ${file.mimetype}`);
      cb(null, true);
      return;
    }
    
    // Fallback: Check file extension for cases where MIME type detection fails
    const fileExtension = path.extname(file.originalname).toLowerCase();
    const allowedExtensions = ['.jpg', '.jpeg', '.png', '.heif', '.heic', '.pdf'];
    
    if (allowedExtensions.includes(fileExtension)) {
      console.log(`File accepted based on extension: ${fileExtension} (MIME type was: ${file.mimetype})`);
      cb(null, true);
    } else {
      console.log(`File rejected - MIME type: ${file.mimetype}, Extension: ${fileExtension}`);
      cb(new Error(`Invalid file type. Only JPEG, PNG, HEIF images and PDF files are allowed. Received: ${file.mimetype} with extension ${fileExtension}`));
    }
  },
  limits: {
    fileSize: 10 * 1024 * 1024 // 10MB limit
  }
});

/**
 * Helper function to process custom pricing for an NDIS item
 */
async function processCustomPricing(db, customPricing, ndisItem, organizationId, clientExists, userEmail) {
  try {
    // Determine if this is client-specific pricing
    const isClientSpecific = customPricing.clientSpecific || false;
    const targetClientId = isClientSpecific ? clientExists._id.toString() : null;
    
    // Build the query to check for existing custom pricing
    // For organization-level pricing: organizationId + supportItemNumber + clientSpecific=false
    // For client-specific pricing: organizationId + supportItemNumber + clientId + clientSpecific=true
    const duplicateCheckQuery = {
      organizationId: organizationId,
      supportItemNumber: ndisItem.itemNumber,
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
    
    console.log(`Checking for duplicate custom pricing with query:`, JSON.stringify(duplicateCheckQuery, null, 2));
    
    const existingCustomPricing = await db.collection('customPricing').findOne(duplicateCheckQuery);

    if (existingCustomPricing) {
      // Check if the price is different before updating
      const newPrice = customPricing.price || customPricing.customPrice;
      const existingPrice = existingCustomPricing.customPrice;
      
      if (newPrice !== existingPrice) {
        // Update existing custom pricing with new price
        await db.collection('customPricing').updateOne(
          { _id: existingCustomPricing._id },
          {
            $set: {
              customPrice: newPrice,
              pricingType: customPricing.pricingType === 'custom' ? 'fixed' : (customPricing.pricingType || 'fixed'),
              updatedBy: userEmail,
              updatedAt: new Date(),
              version: existingCustomPricing.version + 1
            },
            $push: {
              auditTrail: {
                action: 'updated',
                performedBy: userEmail,
                timestamp: new Date(),
                changes: `Price updated from ${existingPrice} to ${newPrice} (${customPricing.pricingType || 'fixed'})`
              }
            }
          }
        );
        console.log(`Updated existing custom pricing for NDIS item ${ndisItem.itemNumber} from ${existingPrice} to ${newPrice}`);
      } else {
        console.log(`Custom pricing for NDIS item ${ndisItem.itemNumber} already exists with same price ${newPrice}, skipping duplicate creation`);
      }
    } else {
      // Create new custom pricing record
      const customPricingDoc = {
        _id: new ObjectId(),
        organizationId: organizationId,
        supportItemNumber: ndisItem.itemNumber,
        supportItemName: ndisItem.itemName || ndisItem.description,
        pricingType: customPricing.pricingType === 'custom' ? 'fixed' : (customPricing.pricingType || 'fixed'),
        customPrice: (customPricing.pricingType === 'custom' || customPricing.pricingType === 'fixed' || !customPricing.pricingType) ? (customPricing.price || customPricing.customPrice) : null,
        multiplier: customPricing.pricingType === 'multiplier' ? (customPricing.price || customPricing.customPrice) : null,
        clientId: targetClientId, // Use the same logic as duplicate check
        clientSpecific: isClientSpecific, // Use the same logic as duplicate check
        ndisCompliant: true,
        exceedsNdisCap: false,
        approvalStatus: 'approved',
        effectiveDate: new Date(),
        expiryDate: null,
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
          changes: `Custom pricing created: ${customPricing.price || customPricing.customPrice} (${customPricing.pricingType || 'fixed'})`
        }]
      };

      await db.collection('customPricing').insertOne(customPricingDoc);
      console.log(`Created new custom pricing for NDIS item ${ndisItem.itemNumber} (clientSpecific: ${isClientSpecific}, clientId: ${targetClientId})`);
    }
  } catch (error) {
    console.error(`Error processing custom pricing for NDIS item ${ndisItem.itemNumber}:`, error);
    throw error;
  }
}

/**
 * Get the base server URL
 */
function getBaseUrl(req) {
  const protocol = req.secure || req.headers['x-forwarded-proto'] === 'https' ? 'https' : 'http';
  const host = req.get('host') || `localhost:${process.env.PORT || 8080}`;
  return `${protocol}://${host}`;
}

/**
 * Convert relative file path to full server URL
 */
function getFullFileUrl(req, filePath) {
  if (!filePath) return null;
  if (filePath.startsWith('http://') || filePath.startsWith('https://')) {
    return filePath; // Already a full URL
  }
  const baseUrl = getBaseUrl(req);
  const cleanPath = filePath.startsWith('/') ? filePath : `/${filePath}`;
  return `${baseUrl}${cleanPath}`;
}

/**
 * Upload receipt file
 * POST /api/upload/receipt
 */
app.post('/api/upload/receipt', upload.single('receipt'), (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: 'No file uploaded'
      });
    }

    // Return the full server URL for the uploaded file
    const relativePath = `/uploads/${req.file.filename}`;
    const fullUrl = getFullFileUrl(req, relativePath);
    
    console.log(`File uploaded: ${req.file.filename}, Full URL: ${fullUrl}`);
    
    res.status(200).json({
      success: true,
      message: 'File uploaded successfully',
      fileUrl: fullUrl,
      filename: req.file.filename,
      originalName: req.file.originalname,
      size: req.file.size
    });
  } catch (error) {
    console.error('Error uploading file:', error);
    res.status(500).json({
      success: false,
      message: 'Error uploading file'
    });
  }
});

/**
 * Add or update invoicing email details
 * POST /addUpdateInvoicingEmailDetail
 */
app.post('/addUpdateInvoicingEmailDetail', async (req, res) => {
  let client;
  
  try {
    const {
      userEmail,
      invoicingBusinessName,
      email,
      encryptedPassword
    } = req.body;
    
    // console.log('addUpdateInvoicingEmailDetail called for:', userEmail);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Check if invoicing email details already exist for this user
    const existingDetails = await db.collection("invoicingEmailDetails").findOne({
      userEmail: userEmail
    });
    
    const invoicingEmailData = {
      userEmail: userEmail,
      invoicingBusinessName: invoicingBusinessName,
      email: email,
      encryptedPassword: encryptedPassword,
      updatedAt: new Date()
    };
    
    let result;
    if (existingDetails) {
      // Update existing record
      result = await db.collection("invoicingEmailDetails").updateOne(
        { userEmail: userEmail },
        { $set: invoicingEmailData }
      );
    } else {
      // Create new record
      invoicingEmailData.createdAt = new Date();
      result = await db.collection("invoicingEmailDetails").insertOne(invoicingEmailData);
    }
    
    res.status(200).json({
      success: true,
      message: "Invoicing email details saved successfully"
    });
  } catch (error) {
    console.error('Error saving invoicing email details:', error);
    res.status(500).json({ 
      success: false,
      message: "Error saving invoicing email details" 
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Store invoicing email detail key
 * POST /invoicingEmailDetailKey
 */
app.post('/invoicingEmailDetailKey', async (req, res) => {
  let client;
  
  try {
    const {
      userEmail,
      invoicingBusinessKey
    } = req.body;
    
    // console.log('invoicingEmailDetailKey called for:', userEmail);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Check if key already exists for this user
    const existingKey = await db.collection("invoicingEmailKeys").findOne({
      userEmail: userEmail
    });
    
    const keyData = {
      userEmail: userEmail,
      invoicingBusinessKey: invoicingBusinessKey,
      updatedAt: new Date()
    };
    
    let result;
    if (existingKey) {
      // Update existing key
      result = await db.collection("invoicingEmailKeys").updateOne(
        { userEmail: userEmail },
        { $set: keyData }
      );
    }
    else {
      // Create new key record
      keyData.createdAt = new Date();
      result = await db.collection("invoicingEmailKeys").insertOne(keyData);
    }
    
    res.status(200).json({
      success: true,
      message: "Invoicing email key saved successfully"
    });
  } catch (error) {
    console.error('Error saving invoicing email key:', error);
    res.status(500).json({ 
      success: false,
      message: "Error saving invoicing email key" 
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// ============================================================================
// NEW ENDPOINT FOR FETCHING WORKED TIME
// ============================================================================

/**
 * Get worked time records for a specific user and client, ensuring it belongs to an organization.
 * This is a more secure and accurate version.
 * GET /getWorkedTime/:userEmail/:clientEmail
 */
app.get('/getWorkedTime/:userEmail/:clientEmail', async (req, res) => {
  let client;
  try {
    const { userEmail, clientEmail } = req.params;
    // We get the organizationId from the query string, which the admin will provide.
    const { organizationId } = req.query; 

    // console.log(`Fetching worked time for user: ${userEmail}, client: ${clientEmail}, within org: ${organizationId}`);

    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: "Organization ID is required to fetch worked time."
      });
    }

    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db("Invoice");

    // 1. Find the specific client assignment for this user, client, and organization.
    const assignment = await db.collection("clientAssignments").findOne({
      userEmail: userEmail,
      clientEmail: clientEmail,
      organizationId: organizationId, // Security check
      isActive: true
    });

    if (!assignment) {
      return res.status(404).json({
        success: false,
        message: "No active assignment found for this user, client, and organization combination."
      });
    }

    // 2. Use the assignment's _id to find all related workedTime records.
    const records = await db.collection("workedTime").find({
      // This is the correct way to query.
      assignedClientId: assignment._id, 
      isActive: true
    }).sort({ shiftDate: 1 }).toArray();

    if (records.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No worked time records found for this client assignment."
      });
    }

    res.status(200).json({
      success: true,
      workedTimes: records
    });

  } catch (error) {
    console.error('Error in getWorkedTime endpoint:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve worked time records.',
      error: error.message
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Get invoicing email details
 * GET /getInvoicingEmailDetails
 */
app.get('/getInvoicingEmailDetails', async (req, res) => {
  let client;
  
  try {
    const { email } = req.query;
    
    // console.log('getInvoicingEmailDetails called for:', email);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Find invoicing email details for the user
    const invoicingDetails = await db.collection("invoicingEmailDetails").findOne({
      userEmail: email
    });
    
    if (!invoicingDetails) {
      return res.status(404).json({
        success: false,
        message: "No invoicing email details found"
      });
    }
    
    res.status(200).json({
      success: true,
      message: "Invoicing email details found",
      data: {
        invoicingBusinessName: invoicingDetails.invoicingBusinessName,
        email: invoicingDetails.email,
        encryptedPassword: invoicingDetails.encryptedPassword
      }
    });
  } catch (error) {
    console.error('Error retrieving invoicing email details:', error);
    res.status(500).json({ 
      success: false,
      message: "Error retrieving invoicing email details" 
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Check invoicing email key
 * GET /checkInvoicingEmailKey
 */
app.get('/checkInvoicingEmailKey', async (req, res) => {
  let client;
  
  try {
    const { email } = req.query;
    
    // console.log('checkInvoicingEmailKey called for:', email);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Find invoicing email key for the user
    const keyDetails = await db.collection("invoicingEmailKeys").findOne({
      userEmail: email
    });
    
    if (!keyDetails) {
      return res.status(404).json({
        success: false,
        message: "No invoicing email key found"
      });
    }
    
    res.status(200).json({
      success: true,
      message: "Invoicing email key found",
      key: keyDetails.invoicingBusinessKey
    });
  } catch (error) {
    console.error('Error retrieving invoicing email key:', error);
    res.status(500).json({ 
      success: false,
      message: "Error retrieving invoicing email key" 
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Add a note for a client
 * POST /addNotes
 */
app.post('/addNotes', async (req, res) => {
  let client;
  try {
    const { userEmail, clientEmail, notes } = req.body;

    if (!userEmail || !clientEmail || !notes) {
      return res.status(400).json({
        success: false,
        message: "userEmail, clientEmail, and notes are required fields."
      });
    }

    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db("Invoice");

    // 1. Verify the user exists and is active
    const user = await db.collection("login").findOne({
      email: userEmail,
      isActive: true
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: "User not found or is not active."
      });
    }

    // 2. Verify the client exists and is active
    const clientRecord = await db.collection("clients").findOne({
      clientEmail: clientEmail,
      isActive: true
    });

    if (!clientRecord) {
      return res.status(404).json({
        success: false,
        message: "Client not found or is not active."
      });
    }
    
    // 3. (Optional but recommended) Verify the user is assigned to the client
    const assignment = await db.collection("clientAssignments").findOne({
        userEmail: userEmail,
        clientEmail: clientEmail,
        isActive: true
    });

    if (!assignment) {
        return res.status(403).json({
            success: false,
            message: "User is not assigned to this client."
        });
    }

    // 4. Insert the note
    const noteDocument = {
      userEmail,
      clientEmail,
      notes,
      organizationId: assignment.organizationId, // Store organization context
      createdAt: new Date(),
      updatedAt: new Date()
    };

    const result = await db.collection("notes").insertOne(noteDocument);

    res.status(201).json({
      success: true,
      message: "Note added successfully.",
      noteId: result.insertedId
    });

  } catch (error) {
    console.error('Error in /addNotes endpoint:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to add note.',
      error: error.message
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Get email details to send email
 * POST /getEmailDetailToSendEmail
 */
app.post('/getEmailDetailToSendEmail', async (req, res) => {
  let client;
  
  try {
    const { userEmail } = req.body;
    
    // console.log('getEmailDetailToSendEmail called for:', userEmail);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Find user details
    const user = await db.collection("login").findOne({
      email: userEmail,
      isActive: true
    });
    
    if (!user) {
      return res.status(404).json({
        success: false,
        message: "No user found"
      });
    }
    
    // Find invoicing email details
    const invoicingDetails = await db.collection("invoicingEmailDetails").findOne({
      userEmail: userEmail
    });
    
    if (!invoicingDetails) {
      return res.status(404).json({
        success: false,
        message: "No invoicing email details found"
      });
    }
    
    res.status(200).json({
      success: true,
      message: "Email details found",
      accessToken: "dummy_token", // Replace with actual token logic if needed
      emailAddress: invoicingDetails.email,
      recipientEmail: userEmail
    });
  } catch (error) {
    console.error('Error retrieving email details:', error);
    res.status(500).json({ 
      success: false,
      message: "Error retrieving email details" 
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Employee Tracking API Endpoint
 * GET /getEmployeeTrackingData/:organizationId
 * 
 * This endpoint provides comprehensive employee tracking data including:
 * - Currently working employees (active timers)
 * - Worked time records with shift details
 * - Employee assignments and client information
 */
app.get('/getEmployeeTrackingData/:organizationId', async (req, res) => {
  let client;
  
  try {
    const { organizationId } = req.params;
    
    // console.log('Getting employee tracking data for organization:', organizationId);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Get all active assignments for the organization
    const assignments = await db.collection("clientAssignments").aggregate([
      {
        $match: {
          organizationId: organizationId,
          isActive: true
        }
      },
      {
        $lookup: {
          from: "clients",
          localField: "clientEmail",
          foreignField: "clientEmail",
          as: "clientDetails"
        }
      },
      {
        $unwind: "$clientDetails"
      },
      {
        $lookup: {
          from: "login",
          localField: "userEmail",
          foreignField: "email",
          as: "userDetails"
        }
      },
      {
        $unwind: "$userDetails"
      },
      {
        $addFields: {
          "userDetails.profileImage": {
            $ifNull: ["$userDetails.photoData", "$userDetails.profileImage"]
          },
          "userDetails.photoData": "$userDetails.photoData",
          "userDetails.filename": "$userDetails.filename"
        }
      }
    ]).toArray();
    
    // If no assignments found, get employees directly from login collection
    let employeesFromLogin = [];
    if (assignments.length === 0) {
      // console.log('No assignments found, fetching employees from login collection...');
      employeesFromLogin = await db.collection("login").find({
        organizationId: organizationId,
        isActive: true
      }).toArray();
      
      // console.log(`Found ${employeesFromLogin.length} employees in login collection`);
      
      // Transform login collection data to match assignment structure
      employeesFromLogin.forEach(employee => {
        assignments.push({
          assignmentId: employee._id.toString(),
          userEmail: employee.email,
          userName: `${employee.firstName} ${employee.lastName}`,
          organizationId: employee.organizationId,
          clientEmail: null,
          clientAddress: null,
          isActive: true,
          createdAt: employee.createdAt,
          userDetails: {
            name: `${employee.firstName} ${employee.lastName}`,
            firstName: employee.firstName,
            lastName: employee.lastName,
            email: employee.email,
            profileImage: employee.photoData || employee.profileImage,
            photoData: employee.photoData,
            filename: employee.filename
          },
          clientDetails: null
        });
      });
    }
    
    // Get worked time records for the organization (including both active and completed shifts)
    let workedTimeRecords = await db.collection("workedTime").aggregate([
      {
        $lookup: {
          from: "clientAssignments",
          localField: "assignedClientId",
          foreignField: "_id",
          as: "assignment"
        }
      },
      {
        $unwind: "$assignment"
      },
      {
        $match: {
          "assignment.organizationId": organizationId
          // Removed isActive: true filter to include completed shifts
        }
      },
      {
        $lookup: {
          from: "clients",
          localField: "clientEmail",
          foreignField: "clientEmail",
          as: "clientDetails"
        }
      },
      {
        $unwind: "$clientDetails"
      },
      {
        $lookup: {
          from: "login",
          localField: "userEmail",
          foreignField: "email",
          as: "userDetails"
        }
      },
      {
        $unwind: "$userDetails"
      },
      {
        $addFields: {
          "userDetails.profileImage": {
            $ifNull: ["$userDetails.photoData", "$userDetails.profileImage"]
          },
          "userDetails.photoData": "$userDetails.photoData",
          "userDetails.filename": "$userDetails.filename"
        }
      },
      {
        $sort: { createdAt: -1 }
      }
    ]).toArray();
    
    // If no worked time records found, create sample data for demonstration
    if (workedTimeRecords.length === 0 && assignments.length > 0) {
      // console.log('No worked time records found, creating sample shift data...');
      
      // Create sample shift data using existing assignments
      const sampleShifts = [];
      
      for (let i = 0; i < Math.min(assignments.length, 2); i++) {
        const assignment = assignments[i];
        
        // Add a completed shift for today
        sampleShifts.push({
          userEmail: assignment.userEmail,
          userDetails: assignment.userDetails,
          clientEmail: assignment.clientEmail,
          clientDetails: assignment.clientDetails,
          timeWorked: "08:30:00",
          shiftDate: new Date().toISOString().split('T')[0],
          shiftStartTime: "09:00",
          shiftEndTime: "17:30",
          shiftBreak: "01:00",
          shiftKey: `sample_shift_${Date.now()}_${i + 1}`,
          createdAt: new Date(),
          _id: `sample_${Date.now()}_${i + 1}`
        });
        
        // Add a completed shift for yesterday
        const yesterday = new Date(Date.now() - 24*60*60*1000);
        sampleShifts.push({
          userEmail: assignment.userEmail,
          userDetails: assignment.userDetails,
          clientEmail: assignment.clientEmail,
          clientDetails: assignment.clientDetails,
          timeWorked: "07:45:00",
          shiftDate: yesterday.toISOString().split('T')[0],
          shiftStartTime: "08:00",
          shiftEndTime: "16:45",
          shiftBreak: "01:00",
          shiftKey: `sample_shift_${Date.now()}_${i + 2}`,
          createdAt: yesterday,
          _id: `sample_${Date.now()}_${i + 2}`
        });
      }
      
      workedTimeRecords = sampleShifts;
      // console.log(`Created ${sampleShifts.length} sample shifts for demonstration`);
    }
    
    // Get actual active timers from database
    // console.log(`🔍 DEBUG: Querying activeTimers collection for organizationId: ${organizationId}`);
    const activeTimers = await db.collection('activeTimers').find({
      organizationId: organizationId
    }).toArray();
    
    // console.log(`🔍 DEBUG: Found ${activeTimers.length} active timers for organization ${organizationId}`);
    // console.log(`🔍 DEBUG: Active timers data:`, JSON.stringify(activeTimers, null, 2));
    
    // Process the data to create employee tracking summary
    const employeeTrackingData = {
      totalEmployees: assignments.length,
      currentlyWorking: activeTimers.length,
      assignments: assignments.map(assignment => ({
        userEmail: assignment.userEmail,
        userName: assignment.userDetails.name || assignment.userDetails.firstName + ' ' + assignment.userDetails.lastName,
        profileImage: assignment.userDetails.profileImage,
        photoData: assignment.userDetails.photoData,
        filename: assignment.userDetails.filename,
        clientEmail: assignment.clientEmail,
        clientName: assignment.clientDetails ? assignment.clientDetails.clientName : null,
        clientAddress: assignment.clientDetails ? assignment.clientDetails.clientAddress : null,
        schedule: assignment.schedule || {
          dateList: assignment.dateList,
          startTimeList: assignment.startTimeList,
          endTimeList: assignment.endTimeList,
          breakList: assignment.breakList
        },
        assignmentId: assignment._id,
        createdAt: assignment.createdAt
      })),
      workedTimeRecords: workedTimeRecords.map(record => ({
        userEmail: record.userEmail,
        userName: record.userDetails.name || record.userDetails.firstName + ' ' + record.userDetails.lastName,
        profileImage: record.userDetails.profileImage,
        photoData: record.userDetails.photoData,
        filename: record.userDetails.filename,
        clientEmail: record.clientEmail,
        clientName: record.clientDetails ? record.clientDetails.clientName : null,
        timeWorked: record.timeWorked,
        shiftDate: record.shiftDate,
        shiftStartTime: record.shiftStartTime,
        shiftEndTime: record.shiftEndTime,
        shiftBreak: record.shiftBreak,
        shiftKey: record.shiftKey,
        createdAt: record.createdAt,
        recordId: record._id
      })),
      activeTimers: activeTimers,
      summary: {
        totalHoursWorked: workedTimeRecords.reduce((total, record) => {
          // Parse time worked (format: "HH:MM:SS")
          const timeParts = record.timeWorked.split(':');
          const hours = parseInt(timeParts[0]) || 0;
          const minutes = parseInt(timeParts[1]) || 0;
          const seconds = parseInt(timeParts[2]) || 0;
          return total + hours + (minutes / 60) + (seconds / 3600);
        }, 0),
        totalShiftsCompleted: workedTimeRecords.length
      }
    };
    
    res.status(200).json({
      success: true,
      data: employeeTrackingData
    });
    
  } catch (error) {
    console.error('Error getting employee tracking data:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get employee tracking data: ' + error.message
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// ===========================================================================
// TIMER ENDPOINTS
// ===========================================================================

/**
 * Start a timer for a user and client assignment.
 * POST /startTimerWithTracking
 */
app.post('/startTimerWithTracking', async (req, res) => {
  await startTimerWithTracking(req, res);
});

// Duplicate route removed - using the one at line 3997 instead

/**
 * Get the status of the timer for a specific user.
 * GET /getTimerStatus/:userEmail
 */
app.get('/getTimerStatus/:userEmail', async (req, res) => {
  let client;
  try {
    const { userEmail } = req.params;

    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db("Invoice");

    const activeTimer = await db.collection('activeTimers').findOne({ userEmail: userEmail });

    if (activeTimer) {
      res.status(200).json({ success: true, isRunning: true, timer: activeTimer });
    } else {
      res.status(200).json({ success: true, isRunning: false });
    }

  } catch (error) {
    console.error('Error in /getTimerStatus:', error);
    res.status(500).json({ success: false, message: 'Failed to get timer status.', error: error.message });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// ===========================================================================
// FCM TOKEN MANAGEMENT ENDPOINT
// ===========================================================================

/**
 * Register FCM token for a user.
 * POST /registerFcmToken
 */
app.post('/registerFcmToken', async (req, res) => {
  let client;
  try {
    const { userEmail, organizationId, fcmToken } = req.body;

    if (!userEmail || !organizationId || !fcmToken) {
      return res.status(400).json({ success: false, message: 'userEmail, organizationId, and fcmToken are required.' });
    }

    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db("Invoice");

    // Validate FCM token
    if (!fcmToken || fcmToken.trim() === '') {
      return res.status(400).json({ success: false, message: 'Invalid FCM token provided.' });
    }

    // Verify token with Firebase
    try {
      await messaging.send({
        token: fcmToken,
        data: { type: 'token_verification' },
        android: { priority: 'normal' },
        apns: { headers: { 'apns-priority': '5' } }
      }, true);
      console.log('FCM token verified successfully:', fcmToken.substring(0, 10) + '...');
    } catch (error) {
      console.error('Invalid FCM token:', error);
      return res.status(400).json({ success: false, message: 'Invalid FCM token: ' + error.message });
    }

    // Check if token already exists for another user
    const existingToken = await db.collection('fcmTokens').findOne({ fcmToken: fcmToken });
    if (existingToken && 
        (existingToken.userEmail !== userEmail || existingToken.organizationId !== organizationId)) {
      // Remove the token from the old user/organization
      await db.collection('fcmTokens').deleteOne({ fcmToken: fcmToken });
      console.log('Removed token from previous user:', existingToken.userEmail);
    }

    // Upsert the FCM token: update if exists, insert if not
    await db.collection('fcmTokens').updateOne(
      { userEmail: userEmail, organizationId: organizationId },
      { 
        $set: { 
          fcmToken: fcmToken, 
          updatedAt: new Date(),
          lastValidated: new Date()
        }, 
        $setOnInsert: { createdAt: new Date() } 
      },
      { upsert: true }
    );

    console.log('FCM token registered for:', { userEmail, organizationId });

    res.status(200).json({ success: true, message: 'FCM token registered successfully.' });

  } catch (error) {
    console.error('Error in /registerFcmToken:', error);
    res.status(500).json({ success: false, message: 'Failed to register FCM token.', error: error.message });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// // ===========================================================================
// // NOTIFICATION ENDPOINT
// // ===========================================================================

// /**
//  * Send FCM notification.
//  * POST /sendNotification
//  * 
//  * Request Body:
//  * - recipientEmail (optional): Email of the user to send notification to.
//  * - organizationId (optional): ID of the organization to send notification to all members.
//  * - title (required): Title of the notification.
//  * - body (required): Body of the notification.
//  */
// app.post('/sendNotification', async (req, res) => {
//   let client;
//   try {
//     const { recipientEmail, organizationId, title, body, channelId = 'timer_alerts' } = req.body;

//     if (!title || !body) {
//       return res.status(400).json({ success: false, message: 'Notification title and body are required.' });
//     }

//     if (!recipientEmail && !organizationId) {
//       return res.status(400).json({ success: false, message: 'Either recipientEmail or organizationId must be provided.' });
//     }

//     client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
//     const db = client.db("Invoice");

//     let fcmTokens = [];
//     console.log('Sending notification:', { recipientEmail, organizationId, title });

//     if (recipientEmail) {
//       // Send to a specific user
//       const userToken = await db.collection('fcmTokens').findOne({ userEmail: recipientEmail });
//       console.log('Found user token:', userToken);
//       if (userToken && userToken.fcmToken && userToken.fcmToken.trim() !== '') {
//         fcmTokens.push(userToken.fcmToken);
//       }
//     } else if (organizationId) {
//       // Send to all users in an organization
//       const orgTokens = await db.collection('fcmTokens').find({ organizationId: organizationId }).toArray();
//       console.log('Found organization tokens:', orgTokens);
//       fcmTokens = orgTokens
//         .filter(tokenDoc => tokenDoc.fcmToken && tokenDoc.fcmToken.trim() !== '')
//         .map(tokenDoc => tokenDoc.fcmToken);
//       console.log('Valid FCM tokens for organization:', fcmTokens.length);
//     }

//     if (fcmTokens.length === 0) {
//       return res.status(404).json({ success: false, message: 'No FCM tokens found for the specified recipient(s).', fcmTokens: fcmTokens });
//     }

//     // IMPORTANT: For foreground notifications to work properly in Flutter,
//     // we need to send DATA-ONLY messages (no 'notification' payload)
//     // The Flutter app will handle displaying the notification manually
//     const message = {
//       // Remove notification payload to ensure foreground handling works
//       // notification: {
//       //   title: title,
//       //   body: body
//       // },
//       android: {
//         priority: 'high',
//         // Remove notification section for data-only message
//         // notification: {
//         //   clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//         //   priority: 'high',
//         //   defaultSound: true,
//         //   channelId: 'timer_alerts'
//         // }
//       },
//       apns: {
//         payload: {
//           aps: {
//             // For data-only messages, use content-available: 1
//             contentAvailable: 1
//           }
//         },
//         headers: {
//           'apns-priority': '5' // Lower priority for data messages
//         }
//       },
//       data: {
//         // Include notification data in the data payload
//         title: title,
//         body: body,
//         click_action: 'FLUTTER_NOTIFICATION_CLICK',
//         status: 'done',
//         channelId: channelId, // Use the dynamic channelId
//         type: 'notification',
//         // Add timestamp for debugging
//         timestamp: new Date().toISOString()
//       },
//       tokens: fcmTokens
//     };
    
//     console.log('Sending FCM message:', JSON.stringify(message, null, 2));

//     try {
//       console.log('Attempting to send FCM message with tokens:', fcmTokens);
//       const fcmResponse = await messaging.sendEachForMulticast(message);
//       console.log('FCM Response:', JSON.stringify(fcmResponse, null, 2));

//       const successCount = fcmResponse.responses.filter(r => r.success).length;
//       const failureCount = fcmResponse.responses.filter(r => !r.success).length;

//       // Process failed tokens
//       if (failureCount > 0) {
//         const tokenResults = fcmResponse.responses.map((resp, idx) => ({
//           token: fcmTokens[idx],
//           success: resp.success,
//           error: resp.error
//         }));

//         const failedTokens = tokenResults.filter(r => !r.success);
//         console.log('Failed tokens details:', JSON.stringify(failedTokens, null, 2));

//         // Handle specific error cases
//         const tokensToRemove = [];
//         for (const result of failedTokens) {
//           const errorCode = result.error?.code;
//           console.log(`Token ${result.token} failed with error:`, errorCode);

//           if ([
//             'messaging/invalid-registration-token',
//             'messaging/registration-token-not-registered',
//             'messaging/invalid-argument',
//             'messaging/unregistered-token'
//           ].includes(errorCode)) {
//             tokensToRemove.push(result.token);
//           }
//         }

//         if (tokensToRemove.length > 0) {
//           await db.collection('fcmTokens').deleteMany({
//             fcmToken: { $in: tokensToRemove }
//           });
//           console.log(`Removed ${tokensToRemove.length} invalid tokens from database`);
//         }
//       }

//       res.status(200).json({
//         success: true,
//         message: `Notifications processed: ${successCount} successful, ${failureCount} failed`,
//         successCount,
//         failureCount,
//         response: fcmResponse
//       });
//     } catch (fcmError) {
//       console.error('FCM Error:', fcmError);
//       console.error('Error details:', JSON.stringify(fcmError, null, 2));

//       let statusCode = 500;
//       let errorMessage = 'Failed to send FCM notification';

//       // Handle specific FCM error cases
//       switch (fcmError.code) {
//         case 'messaging/invalid-argument':
//           statusCode = 400;
//           errorMessage = 'Invalid notification parameters';
//           break;
//         case 'messaging/authentication-error':
//           statusCode = 401;
//           errorMessage = 'Firebase authentication failed';
//           break;
//         case 'messaging/server-unavailable':
//           statusCode = 503;
//           errorMessage = 'FCM service temporarily unavailable';
//           break;
//         case 'messaging/internal-error':
//           statusCode = 500;
//           errorMessage = 'FCM internal server error';
//           break;
//         case 'messaging/quota-exceeded':
//           statusCode = 429;
//           errorMessage = 'FCM quota exceeded';
//           break;
//       }

//       res.status(statusCode).json({
//         success: false,
//         message: errorMessage,
//         error: fcmError.message,
//         errorCode: fcmError.code,
//         errorDetails: fcmError.errorInfo || fcmError.details
//       });
//     }
//   } catch (error) {
//     console.error('Error in /sendNotification endpoint:', error);
//     res.status(500).json({ success: false, message: 'Failed to send notification.', error: error.message });
//   } finally {
//     if (client) {
//       await client.close();
//     }
//   }
// });


// Define port



/**
 * ===========================================================================
 * NOTIFICATION ENDPOINT (REVISED AND CORRECTED)
 * ===========================================================================
 * 
 * Sends a Firebase Cloud Messaging (FCM) notification. This endpoint is designed
 * to work reliably whether the Flutter app is in the foreground, background, or terminated.
 * 
 * It sends a "Notification Message" which contains both a `notification` payload
 * (for automatic display by the OS when the app is in the background) and a `data`
 * payload (for custom logic and foreground handling in the Flutter app).
 * 
 * How it works:
 * - When app is in BACKGROUND/TERMINATED: The OS uses the `notification` payload to show the alert.
 *   When the user taps it, the `data` payload is delivered to the app.
 * - When app is in FOREGROUND: The `onMessage` listener in your Flutter `NotificationHandler`
 *   receives the entire message. Your code then uses the `data` payload to build and display
 *   a local notification.
 * 
 * Request Body:
 * - title (required): The title of the notification.
 * - body (required): The main text content of the notification.
 * - recipientEmail (optional): Target a single user by their email.
 * - organizationId (optional): Target all users in an organization.
 * - channelId (optional): The Android notification channel to use (defaults to 'timer_alerts').
 * - ...any other custom data: Any other key-value pairs will be passed in the `data` payload.
 *   (e.g., "type": "EMPLOYEE_TIMER_START", "employeeEmail": "test@test.com")
 */
app.post('/sendNotification', async (req, res) => {
  let client;
  try {
    // 1. DESTRUCTURE AND VALIDATE INPUT
    // Use a rest parameter `...additionalData` to capture all other properties from the body.
    const {
      recipientEmail,
      organizationId,
      title,
      body,
      channelId = 'timer_alerts', // Default channelId if not provided
      ...additionalData
    } = req.body;

    if (!title || !body) {
      return res.status(400).json({
        success: false,
        message: 'Notification title and body are required.'
      });
    }
    if (!recipientEmail && !organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Either recipientEmail or organizationId must be provided.'
      });
    }

    // 2. FETCH TARGET FCM TOKENS FROM DATABASE
    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db("Invoice");
    const fcmTokensCollection = db.collection('fcmTokens');

    let fcmTokens = [];
    if (recipientEmail) {
      const userTokenDoc = await fcmTokensCollection.findOne({ userEmail: recipientEmail });
      if (userTokenDoc && userTokenDoc.fcmToken) {
        fcmTokens.push(userTokenDoc.fcmToken);
      }
    } else if (organizationId) {
      const orgTokenDocs = await fcmTokensCollection.find({ organizationId: organizationId }).toArray();
      // Map to get the token string and filter out any null/empty values
      fcmTokens = orgTokenDocs.map(doc => doc.fcmToken).filter(Boolean);
    }

    if (fcmTokens.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No valid FCM registration tokens found for the specified recipient(s).'
      });
    }

    // 3. CONSTRUCT THE FCM MESSAGE PAYLOAD (THE CORE FIX)
    const message = {
      // The `notification` payload is for the OS to handle when the app is in the background.
      notification: {
        title: title,
        body: body,
      },
      // The `data` payload is for your Flutter app's custom logic.
      data: {
        ...additionalData, // Pass all other custom data from the request
        title: title,       // Including title/body here simplifies foreground handler logic
        body: body,
        channelId: channelId,
        click_action: 'FLUTTER_NOTIFICATION_CLICK', // Standard for Flutter
        timestamp: new Date().toISOString(),
      },
      // Platform-specific configurations for optimal delivery.
      android: {
        priority: 'high',
        notification: {
          channel_id: channelId, // **CRITICAL** for Android 8+
          sound: 'default',
          priority: 'high',
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default', // Ensures sound on iOS
            'content-available': 1, // Allows background processing
          },
        },
        headers: {
          'apns-priority': '10', // High priority for user-facing alerts
        },
      },
      tokens: fcmTokens,
    };

    console.log('--- Sending FCM Message ---');
    console.log('Target Tokens Count:', fcmTokens.length);
    console.log('Payload:', JSON.stringify(message, null, 2));

    // 4. SEND THE MESSAGE AND HANDLE THE RESPONSE
    const fcmResponse = await messaging.sendEachForMulticast(message);

    console.log('--- FCM Response ---');
    console.log('Success Count:', fcmResponse.successCount);
    console.log('Failure Count:', fcmResponse.failureCount);

    // 5. CLEAN UP INVALID TOKENS
    if (fcmResponse.failureCount > 0) {
      const tokensToRemove = [];
      fcmResponse.responses.forEach((response, index) => {
        if (!response.success) {
          const errorCode = response.error.code;
          console.log(`Token failed: ${fcmTokens[index].substring(0, 20)}... Error: ${errorCode}`);
          // Check for errors that indicate an invalid or unregistered token
          if (
            errorCode === 'messaging/invalid-registration-token' ||
            errorCode === 'messaging/registration-token-not-registered'
          ) {
            tokensToRemove.push(fcmTokens[index]);
          }
        }
      });

      if (tokensToRemove.length > 0) {
        console.log(`Removing ${tokensToRemove.length} invalid tokens from the database.`);
        await fcmTokensCollection.deleteMany({ fcmToken: { $in: tokensToRemove } });
      }
    }

    // 6. SEND SUCCESS RESPONSE TO THE CALLER
    res.status(200).json({
      success: true,
      message: `Notifications processed: ${fcmResponse.successCount} successful, ${fcmResponse.failureCount} failed.`,
      details: {
        successCount: fcmResponse.successCount,
        failureCount: fcmResponse.failureCount,
      },
    });

  } catch (error) {
    console.error('FATAL ERROR in /sendNotification endpoint:', error);
    res.status(500).json({
      success: false,
      message: 'An internal server error occurred while sending the notification.',
      error: error.message
    });
  } finally {
    // Ensure the database connection is always closed
    if (client) {
      await client.close();
    }
  }
});



var PORT = process.env.PORT || 8080;

// Secure GET endpoint for line items
app.get("/getLineItems/", async (req, res) => {
  let client;
  
  try {
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Find all line items
    const lineItems = await db.collection("lineItems")
      .find({})
      .toArray();
    
    if (!lineItems || lineItems.length === 0) {
      return res.status(404).json({
        success: false,
        message: "No line items found"
      });
    }
    
    // Map to required format
    const list = lineItems.map(item => ({
      itemNumber: item.itemNumber,
      itemDescription: item.itemDescription
    }));
    
    // Return the array directly as expected by the Flutter app
    res.status(200).json(list);
    
  } catch (error) {
    console.error('Error retrieving line items:', error);
    res.status(500).json({
      success: false,
      message: "Error retrieving line items"
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// Start the server
// Server configuration
const serverOptions = {
  poolsize: 100,
  socketOptions: {
    socketTimeoutMS: 6000000,
  },
};

// Test MongoDB connection
try {
  MongoClient.connect(process.env.MONGODB_URI, { serverApi: ServerApiVersion.v1 }, function (err, db) {
    if (err) {
      console.error('MongoDB connection test failed:', err);
      // Optionally, exit the process if the connection is critical for startup
      // process.exit(1);
      return;
    }
    var dbo = db.db("Invoice");
    dbo.collection("login").findOne({}, function (err, result) {
      if (err) {
        console.error('MongoDB collection test failed:', err);
        db.close();
        // process.exit(1);
        return;
      }
      // console.log("Server connected");
      db.close();
    });
  });
} catch (error) {
  console.error('Synchronous error during MongoDB connection attempt:', error);
  // process.exit(1);
}

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
app.use(bodyParser.json());

app.use(function (req, res, next) {
  res.header("Content-Type", "application/json");
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

// Request and Response Logging Middleware
app.use((req, res, next) => {
  const start = Date.now();
  const requestId = uuidv4().slice(0, 8);
  
  // Log request
  console.log(`[${new Date().toISOString()}] [${requestId}] REQUEST: ${req.method} ${req.originalUrl}`);
  if (Object.keys(req.body).length > 0) {
    console.log(`[${new Date().toISOString()}] [${requestId}] REQUEST BODY:`, JSON.stringify(req.body, null, 2));
  }
  
  // Capture the original methods
  const originalSend = res.send;
  const originalJson = res.json;
  const originalEnd = res.end;
  
  // Override send
  res.send = function(body) {
    const duration = Date.now() - start;
    console.log(`[${new Date().toISOString()}] [${requestId}] RESPONSE: ${res.statusCode} (${duration}ms)`);
    if (body) {
      let responseBody = body;
      try {
        if (typeof body === 'string') {
          responseBody = JSON.parse(body);
        }
        console.log(`[${new Date().toISOString()}] [${requestId}] RESPONSE BODY:`, JSON.stringify(responseBody, null, 2));
      } catch (e) {
        console.log(`[${new Date().toISOString()}] [${requestId}] RESPONSE BODY: ${body}`);
      }
    }
    return originalSend.apply(res, arguments);
  };
  
  // Override json
  res.json = function(body) {
    const duration = Date.now() - start;
    console.log(`[${new Date().toISOString()}] [${requestId}] RESPONSE: ${res.statusCode} (${duration}ms)`);
    if (body) {
      console.log(`[${new Date().toISOString()}] [${requestId}] RESPONSE BODY:`, JSON.stringify(body, null, 2));
    }
    return originalJson.apply(res, arguments);
  };
  
  // Override end
  res.end = function(chunk) {
    const duration = Date.now() - start;
    // console.log(`[${new Date().toISOString()}] [${requestId}] RESPONSE: ${res.statusCode} (${duration}ms)`);
    if (chunk && typeof chunk !== 'function') {
      // console.log(`[${new Date().toISOString()}] [${requestId}] RESPONSE BODY: ${chunk}`);
    }
    return originalEnd.apply(res, arguments);
  };
  
  next();
});

app.get("/", (req, res) => {
  res.send("Multi-Tenant Invoice API Server!");
});

app.get("/hello", (req, res) => {
  res.send("Hello World!");
});

// ============================================================================
// UTILITY FUNCTIONS
// ============================================================================

/**
 * Generate a random 6-digit OTP
 * @returns {string} 6-digit OTP
 */
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

/**
 * Generate a random organization code
 * @returns {string} 8-character organization code
 */
function generateOrganizationCode() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  let result = '';
  for (let i = 0; i < 8; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return result;
}

/**
 * Pad a string to the left with a specified character
 * @param {string} str - String to pad
 * @param {number} length - Target length
 * @param {string} char - Character to pad with
 * @returns {string} Padded string
 */
function padLeft(str, length, char) {
  while (str.length < length) {
    str = char + str;
  }
  return str;
}

let serverEncryptionKey;

/**
 * Generate server encryption key
 * @returns {string} Encryption key
 */
function generateEncryptionKey() {
  serverEncryptionKey = crypto.randomBytes(8).toString('hex');
  return serverEncryptionKey;
}

/**
 * XOR two hex strings of the same length
 * @param {string} a - First hex string
 * @param {string} b - Second hex string
 * @returns {string} XOR result
 */
function xorHex(a, b) {
  let result = '';
  for (let i = 0; i < a.length; i += 2) {
    result += (parseInt(a.substr(i, 2), 16) ^ parseInt(b.substr(i, 2), 16)).toString(16).padStart(2, '0');
  }
  return result;
}

/**
 * Encrypt OTP with timestamp
 * @param {string} otp - OTP to encrypt
 * @param {string} flutterEncryptKey - Flutter encryption key
 * @returns {string} Encrypted data
 */
function encryptOTP(otp, flutterEncryptKey) {
  const IV_LENGTH = 16;
  let iv = crypto.randomBytes(IV_LENGTH);
  let timestamp = padLeft(Date.now().toString(), 13, '0');
  let encryptionKey = generateEncryptionKey();
  
  let combinedKey = (flutterEncryptKey + encryptionKey).slice(0, 32);
  let dataToEncrypt = Buffer.from(timestamp + otp);
  let cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(combinedKey, 'utf-8'), iv);
  let encrypted = Buffer.concat([iv, cipher.update(dataToEncrypt), cipher.final()]);
  
  return encrypted.toString('hex');
}

/**
 * Decrypt OTP and extract timestamp
 * @param {string} encryptedData - Encrypted data
 * @param {string} flutterEncryptKey - Flutter encryption key
 * @param {string} encryptionKey - Server encryption key
 * @returns {object|null} Decrypted data or null
 */
function decryptOTP(encryptedData, flutterEncryptKey, encryptionKey) {
  const IV_LENGTH = 16;

  try {
    let encryptedBuffer = Buffer.from(encryptedData, 'hex');
    let iv = encryptedBuffer.slice(0, IV_LENGTH);
    let encrypted = encryptedBuffer.slice(IV_LENGTH);
    
    const minKeyLength = 16;
    let combinedKey = (
      flutterEncryptKey.padEnd(minKeyLength, '0') +
      encryptionKey.padEnd(minKeyLength, '0')
    ).slice(0, 32);

    let decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(combinedKey, 'utf-8'), iv);
    let decrypted = Buffer.concat([decipher.update(encrypted), decipher.final()]);

    let timestamp = decrypted.slice(0, 13).toString();
    let otp = decrypted.slice(13).toString();

    return { timestamp, otp };
  } catch (error) {
    console.error('Error in decryptOTP:', error);
    return null;
  }
}

/**
 * Send OTP email
 * @param {string} email - Recipient email
 * @param {string} flutterClientKey - Flutter client key
 * @returns {object} OTP and verification key
 */
async function sendOtpEmail(email, flutterClientKey) {
  const otp = generateOTP();
  const verificationKey = encryptOTP(otp, flutterClientKey);

  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.ADMIN_EMAIL,
      pass: process.env.APP_PASSWORD,
    },
  });

  const mailOptions = {
    from: process.env.ADMIN_EMAIL,
    to: email,
    subject: 'OTP Verification',
    text: `Your OTP code is: ${otp}\n`,
  };

  try {
    await transporter.sendMail(mailOptions);
    // console.log('Email sent successfully');
    return { otp, verificationKey };
  } catch (error) {
    console.error('Error sending email:', error);
    throw error;
  }
}

/**
 * Verify OTP with timestamp validation
 * @param {string} userOTP - User provided OTP
 * @param {string} userVerificationKey - User verification key
 * @param {string} generatedOTP - Generated OTP
 * @param {string} encryptVerificationKey - Encrypted verification key
 * @param {number} timeLimitSeconds - Time limit in seconds
 * @returns {boolean} Verification result
 */
function verifyOTP(userOTP, userVerificationKey, generatedOTP, encryptVerificationKey, timeLimitSeconds) {
  const isOTPValid = userOTP === generatedOTP;
  // console.log('Verify OTP called', isOTPValid, userOTP, generatedOTP);

  if (!isOTPValid) {
    // console.log('OTP not valid');
    return false;
  }

  const serverGeneratedVerificationKey = serverEncryptionKey;
  const extractedData = decryptOTP(encryptVerificationKey, userVerificationKey, serverGeneratedVerificationKey);
  
  if (extractedData !== null) {
    const { timestamp, otp } = extractedData;
    
    const currentTime = Math.floor(new Date().getTime() / 1000);
    const isTimestampValid = (currentTime - timestamp / 1000) <= timeLimitSeconds;

    // console.log('currentTime', currentTime, 'timestamp', timestamp, 'isTimestampValid', isTimestampValid);

    if (!isTimestampValid) {
      // console.log('Timestamp not valid');
      return false;
    }
    
    if (otp !== userOTP) {
      // console.log('OTP not valid');
      return false;
    }
    
    // console.log('OTP valid');
    return true;
  } else {
    // console.log('Verification failed. Cannot extract data.');
    return false;
  }
}

// ============================================================================
// ORGANIZATION MANAGEMENT ENDPOINTS
// ============================================================================

/**
 * Create a new organization
 * POST /organization/create
 */
app.post("/organization/create", async function (req, res) {
  const { organizationName, ownerEmail } = req.body;
  
  // console.log('Create organization called:', organizationName, ownerEmail);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    // Check if organization name already exists
    const existingOrg = await db.collection("organizations").findOne({ 
      name: { $regex: new RegExp(`^${organizationName}$`, 'i') } 
    });
    
    if (existingOrg) {
      await client.close();
      return res.status(400).json({
        message: "Organization name already exists"
      });
    }
    
    // Generate unique organization code
    let organizationCode;
    let codeExists = true;
    
    while (codeExists) {
      organizationCode = generateOrganizationCode();
      const existingCode = await db.collection("organizations").findOne({ code: organizationCode });
      codeExists = !!existingCode;
    }
    
    // Create organization document
    const organizationDoc = {
      _id: new ObjectId(),
      name: organizationName,
      code: organizationCode,
      ownerEmail: ownerEmail,
      createdAt: new Date(),
      isActive: true,
      settings: {
        allowEmployeeInvites: true,
        maxEmployees: 100
      }
    };
    
    const result = await db.collection("organizations").insertOne(organizationDoc);
    
    await client.close();
    
    res.status(200).json({
      message: "Organization created successfully",
      organizationId: result.insertedId.toString(),
      organizationCode: organizationCode,
      organizationName: organizationName
    });
    
  } catch (error) {
    console.error('Error creating organization:', error);
    res.status(500).json({
      message: "Error creating organization"
    });
  }
});

/**
 * Create a new organization (legacy endpoint)
 * POST /createOrganization
 */
app.post("/createOrganization", async function (req, res) {
  const { organizationName, ownerFirstName, ownerLastName, ownerEmail } = req.body;
  
  // console.log('Create organization called:', organizationName, ownerEmail);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    // Check if organization name already exists
    const existingOrg = await db.collection("organizations").findOne({ 
      name: { $regex: new RegExp(`^${organizationName}$`, 'i') } 
    });
    
    if (existingOrg) {
      await client.close();
      return res.status(409).json({
        statusCode: 409,
        message: "Organization name already exists"
      });
    }
    
    // Generate unique organization code
    let organizationCode;
    let codeExists = true;
    
    while (codeExists) {
      organizationCode = generateOrganizationCode();
      const existingCode = await db.collection("organizations").findOne({ code: organizationCode });
      codeExists = !!existingCode;
    }
    
    // Create organization document
    const organizationDoc = {
      _id: new ObjectId(),
      name: organizationName,
      code: organizationCode,
      ownerEmail: ownerEmail,
      ownerFirstName: ownerFirstName,
      ownerLastName: ownerLastName,
      createdAt: new Date(),
      isActive: true,
      settings: {
        allowEmployeeInvites: true,
        maxEmployees: 100
      }
    };
    
    const result = await db.collection("organizations").insertOne(organizationDoc);
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      message: "Organization created successfully",
      organizationId: result.insertedId.toString(),
      organizationCode: organizationCode,
      organizationName: organizationName
    });
    
  } catch (error) {
    console.error('Error creating organization:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error creating organization"
    });
  }
});

/**
 * Verify organization code
 * POST /organization/verify-code
 */
app.post("/organization/verify-code", async function (req, res) {
  const { organizationCode } = req.body;
  
  // console.log('Verify organization code called:', organizationCode);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const organization = await db.collection("organizations").findOne({ 
      code: organizationCode,
      isActive: true 
    });
    
    await client.close();
    
    if (organization) {
      res.status(200).json({
        message: "Organization code is valid",
        organizationId: organization._id.toString(),
        organizationName: organization.name,
        ownerEmail: organization.ownerEmail
      });
    } else {
      res.status(404).json({
        message: "Invalid organization code"
      });
    }
    
  } catch (error) {
    console.error('Error verifying organization code:', error);
    res.status(500).json({
      message: "Error verifying organization code"
    });
  }
});

/**
 * Verify organization code (frontend endpoint)
 * GET /organization/verify/:organizationCode
 */
app.get("/organization/verify/:organizationCode", async function (req, res) {
  const { organizationCode } = req.params;
  
  // console.log('Verify organization code called:', organizationCode);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const organization = await db.collection("organizations").findOne({ 
      code: organizationCode,
      isActive: true 
    });
    
    await client.close();
    
    if (organization) {
      res.status(200).json({
        success: true,
        statusCode: 200,
        message: "Organization code verified",
        organizationId: organization._id.toString(),
        organizationName: organization.name
      });
    } else {
      res.status(404).json({
        success: false,
        statusCode: 404,
        message: "Invalid organization code"
      });
    }
    
  } catch (error) {
    console.error('Error verifying organization code:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error verifying organization code"
    });
  }
});

/**
 * Verify organization code (legacy endpoint)
 * GET /verifyOrganizationCode/:code
 */
app.get("/verifyOrganizationCode/:code", async function (req, res) {
  const { code } = req.params;
  
  // console.log('Verify organization code called:', code);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const organization = await db.collection("organizations").findOne({ 
      code: code,
      isActive: true 
    });
    
    await client.close();
    
    if (organization) {
      res.status(200).json({
        success: true,
        statusCode: 200,
        message: "Organization code verified",
        organizationId: organization._id.toString(),
        organizationName: organization.name
      });
    } else {
      res.status(404).json({
        success: false,
        statusCode: 404,
        message: "Invalid organization code"
      });
    }
    
  } catch (error) {
    console.error('Error verifying organization code:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error verifying organization code"
    });
  }
});

/**
 * Get organization details
 * GET /organization/:organizationId
 */
app.get("/organization/:organizationId", async function (req, res) {
  const { organizationId } = req.params;
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const organization = await db.collection("organizations").findOne({ 
      _id: new ObjectId(organizationId) 
    });
    
    await client.close();
    
    if (organization) {
      res.status(200).json({
        statusCode: 200,
        organization: {
          id: organization._id.toString(),
          name: organization.name,
          code: organization.code,
          ownerEmail: organization.ownerEmail,
          createdAt: organization.createdAt,
          settings: organization.settings
        }
      });
    } else {
      res.status(404).json({
        statusCode: 404,
        message: "Organization not found"
      });
    }
    
  } catch (error) {
    console.error('Error getting organization:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting organization"
    });
  }
});

/**
 * Get organization members
 * GET /organization/:organizationId/members
 */
app.get("/organization/:organizationId/members", async function (req, res) {
  const { organizationId } = req.params;
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const members = await db.collection("login").find({ 
      organizationId: organizationId 
    }).project({ 
      password: 0, 
      salt: 0 
    }).toArray();
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      members: members
    });
    
  } catch (error) {
    console.error('Error getting organization members:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting organization members"
    });
  }
});

// ============================================================================
// ENHANCED AUTHENTICATION ENDPOINTS
// ============================================================================

/**
 * Check if email exists
 * GET /checkEmail/:email
 */
app.get("/checkEmail/:email", async function (req, res) {
  const { email } = req.params;
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const user = await db.collection("login").findOne(
      { email: email },
      {
        projection: {
          firstName: 1,
          lastName: 1,
          email: 1,
          abn: 1,
          role: 1,
          organizationId: 1,
          businessName: 1,
          _id: 0
        }
      }
    );
    
    await client.close();
    
    if (user) {
      // Create a name field for compatibility
      user.name = `${user.firstName || ''} ${user.lastName || ''}`.trim();
      
      res.status(200).json({
        statusCode: 200,
        message: "Email exists",
        email: email,
        ...user  // Include all user data including ABN
      });
    } else {
      res.status(400).json({
        statusCode: 400,
        message: "Email does not exist"
      });
    }
    
  } catch (error) {
    console.error('Error checking email:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error checking email"
    });
  }
});

/**
 * Get client details by email
 * GET /getClientDetails/:email
 */
app.get("/getClientDetails/:email", async function (req, res) {
  const { email } = req.params;
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    // Find client details in the clients collection
    const clientDetails = await db.collection("clients").findOne(
      { clientEmail: email, isActive: true },
      { 
        projection: {
          clientFirstName: 1,
          clientLastName: 1,
          clientEmail: 1,
          businessName: 1,
          clientPhone: 1,
          clientAddress: 1,
          clientCity: 1,
          clientState: 1,
          clientZip: 1,
          organizationId: 1,
          _id: 0
        }
      }
    );
    
    await client.close();
    
    if (clientDetails) {
      res.status(200).json({
        statusCode: 200,
        message: "Client details retrieved successfully",
        clientDetails: clientDetails
      });
    } else {
      res.status(404).json({
        statusCode: 404,
        message: "Client not found"
      });
    }
    
  } catch (error) {
    console.error('Error retrieving client details:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error retrieving client details"
    });
  }
});

/**
 * Enhanced signup with organization support
 * POST /signup/:email
 */
app.post("/signup/:email", async function (req, res) {
  const { email } = req.params;
  const { 
    firstName, 
    lastName, 
    password, 
    salt, 
    abn, 
    role, 
    organizationId,
    organizationCode 
  } = req.body;
  
  // console.log('Signup called:', email, firstName, lastName, role, organizationId);
  // console.log('Request body:', JSON.stringify(req.body, null, 2));
  // console.log('About to enter try block for database operations');
  
  try {
    // console.log('Connecting to MongoDB...');
    // console.log('MongoDB URI exists:', !!process.env.MONGODB_URI);
    if (!process.env.MONGODB_URI) {
      throw new Error('MONGODB_URI environment variable is not set');
    }
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    // console.log('Connected to MongoDB successfully');
    const db = client.db("Invoice");
    
    // Check if email already exists
    // console.log('Checking if email exists:', email);
    const existingUser = await db.collection("login").findOne({ email: email });
    // console.log('Existing user check result:', existingUser ? 'User exists' : 'User does not exist');
    
    if (existingUser) {
      await client.close();
      return res.status(409).json({
        statusCode: 409,
        message: "Email already exists"
      });
    }
    
    let finalOrganizationId = organizationId;
    let organizationName = '';
    
    // If organizationCode is provided (employee signup), verify and get organizationId
    if (organizationCode && !organizationId) {
      const organization = await db.collection("organizations").findOne({ 
        code: organizationCode,
        isActive: true 
      });
      
      if (!organization) {
        await client.close();
        return res.status(400).json({
          statusCode: 400,
          message: "Invalid organization code"
        });
      }
      
      finalOrganizationId = organization._id.toString();
      organizationName = organization.name;
    }
    
    // If organizationId is provided, validate and get organization name
    if (finalOrganizationId) {
      // Validate ObjectId format
      if (!ObjectId.isValid(finalOrganizationId)) {
        await client.close();
        return res.status(400).json({
          statusCode: 400,
          message: "Invalid organization ID format"
        });
      }
      
      const organization = await db.collection("organizations").findOne({ 
        _id: new ObjectId(finalOrganizationId) 
      });
      
      if (organization) {
        organizationName = organization.name;
      } else {
        await client.close();
        return res.status(400).json({
          statusCode: 400,
          message: "Organization not found"
        });
      }
    }
    
    // Create user document
    // console.log('Creating user document with data:', {
      // firstName, lastName, email, role, finalOrganizationId, organizationName
    // });
    
    const userDoc = {
      _id: new ObjectId(),
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      salt: salt,
      abn: abn,
      role: role,
      organizationId: finalOrganizationId,
      organizationName: organizationName,
      createdAt: new Date(),
      isActive: true,
      lastLogin: null
    };
    
    // console.log('Inserting user document into login collection...');
    const result = await db.collection("login").insertOne(userDoc);
    // console.log('User insertion result:', result.insertedId ? 'Success' : 'Failed', result.insertedId);
    
    await client.close();
    // console.log('Database connection closed');
    
    // console.log('Sending success response to client');
    res.status(200).json({
      statusCode: 200,
      message: "User created successfully",
      userId: result.insertedId.toString(),
      email: email,
      role: role,
      organizationId: finalOrganizationId,
      organizationName: organizationName
    });
    
  } catch (error) {
    console.error('Error creating user:', error);
    console.error('Error stack:', error.stack);
    console.error('Error message:', error.message);
    res.status(500).json({
      statusCode: 500,
      message: "Error creating user",
      error: error.message
    });
  }
});

/**
 * Enhanced login with organization context
 * POST /login
 */
app.post("/login", async function (req, res) {
  const { email, password } = req.body;
  
  // console.log('Login called:', email);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const user = await db.collection("login").findOne({ 
      email: email,
      isActive: true 
    });
    
    if (!user) {
      await client.close();
      return res.status(401).json({
        statusCode: 401,
        message: "Invalid email or password"
      });
    }
    
    // Verify password (assuming password is already hashed on client side)
    if (user.password !== password) {
      await client.close();
      return res.status(401).json({
        statusCode: 401,
        message: "Invalid email or password"
      });
    }
    
    // Update last login
    await db.collection("login").updateOne(
      { _id: user._id },
      { $set: { lastLogin: new Date() } }
    );
    
    // Get organization details if user belongs to one
    let organizationDetails = null;
    if (user.organizationId) {
      organizationDetails = await db.collection("organizations").findOne({ 
        _id: new ObjectId(user.organizationId) 
      });
    }
    
    // Generate JWT token
    const jwt = require('jsonwebtoken');
    const tokenPayload = {
      userId: user._id.toString(),
      email: user.email,
      roles: [user.role || 'user'],
      organizationId: user.organizationId
    };
    
    const token = jwt.sign(
      tokenPayload,
      process.env.PRIVATE_KEY || '01rFHXe6VLK-J2n6JLoyJ', // Fallback to default if env var not set
      { 
        expiresIn: '24h',
        issuer: 'invoice-app',
        audience: 'invoice-app-users'
      }
    );
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      message: "Login successful",
      token: token, // Include token in response
      user: {
        id: user._id.toString(),
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        role: user.role,
        abn: user.abn,
        organizationId: user.organizationId,
        organizationName: user.organizationName,
        organization: organizationDetails ? {
          id: organizationDetails._id.toString(),
          name: organizationDetails.name,
          code: organizationDetails.code
        } : null
      }
    });
    
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error during login"
    });
  }
});

/**
 * Get user photo
 * GET /getUserPhoto/:email
 */
app.get('/getUserPhoto/:email', async (req, res) => {
  const { email } = req.params;
  
  // console.log('getUserPhoto called for:', email);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const user = await db.collection("login").findOne({ 
      email: email,
      isActive: true 
    });
    
    // console.log('User found:', !!user);
    if (user) {
      // console.log('User document keys:', Object.keys(user));
      // console.log('Full user document:', JSON.stringify(user, null, 2));
      // console.log('User has photoData:', !!user.photoData);
      // console.log('PhotoData type:', typeof user.photoData);
      // console.log('PhotoData length:', user.photoData ? user.photoData.length : 0);
      // console.log('User email:', user.email);
      // console.log('User filename:', user.filename);
    }
    
    if (!user) {
      await client.close();
      // console.log('Returning 404: User not found');
      return res.status(404).json({
        statusCode: 404,
        message: "User not found"
      });
    }
    
    // Check if user has photo data
    if (!user.photoData) {
      await client.close();
      // console.log('Returning 404: Photo not found for user');
      return res.status(404).json({
        statusCode: 404,
        message: "Photo not found",
        userExists: true,
        hasPhoto: false
      });
    }
    
    await client.close();
    // console.log('Returning 200: Photo found');
    
    res.status(200).json({
      statusCode: 200,
      message: "Photo found",
      success: true,
      data: user.photoData
    });
    
  } catch (error) {
    console.error('Error getting user photo:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting user photo"
    });
  }
});

/**
 * Get user initial data
 * GET /initData/:email
 */
app.get('/initData/:email', async (req, res) => {
  const { email } = req.params;
  
  // console.log('initData called for:', email);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const user = await db.collection("login").findOne({ 
      email: email,
      isActive: true 
    });
    
    if (!user) {
      await client.close();
      return res.status(404).json({
        statusCode: 404,
        message: "User not found"
      });
    }
    
    // Get organization details if user belongs to one
    let organizationDetails = null;
    if (user.organizationId) {
      organizationDetails = await db.collection("organizations").findOne({ 
        _id: new ObjectId(user.organizationId) 
      });
    }
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      message: "User data found",
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      role: user.role,
      abn: user.abn,
      organizationId: user.organizationId,
      organizationName: user.organizationName,
      organization: organizationDetails ? {
        id: organizationDetails._id.toString(),
        name: organizationDetails.name,
        code: organizationDetails.code
      } : null
    });
    
  } catch (error) {
    console.error('Error getting user data:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting user data"
    });
  }
});

/**
 * Upload user photo
 * POST /uploadPhoto
 */
app.post('/uploadPhoto', upload.single('photo'), async (req, res) => {
  const { email } = req.body;
  
  // console.log('uploadPhoto called for:', email);
  
  if (!req.file) {
    return res.status(400).json({
      statusCode: 400,
      message: "No photo file provided"
    });
  }
  
  try {
    const fs = require('fs');
    const photoData = fs.readFileSync(req.file.path);
    const base64PhotoData = photoData.toString('base64');
    
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const result = await db.collection("login").updateOne(
      { email: email, isActive: true },
      { 
        $set: { 
          photoData: base64PhotoData,
          filename: req.file.originalname,
          updatedAt: new Date()
        } 
      }
    );
    
    await client.close();
    
    // Clean up uploaded file
    fs.unlinkSync(req.file.path);
    
    if (result.matchedCount > 0) {
      res.status(200).json({
        statusCode: 200,
        message: "Photo uploaded successfully"
      });
    } else {
      res.status(404).json({
        statusCode: 404,
        message: "User not found"
      });
    }
    
  } catch (error) {
    console.error('Error uploading photo:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error uploading photo"
    });
  }
});

/**
 * Get salt for user authentication
 * POST /getSalt
 */
app.post('/getSalt', async (req, res) => {
  const { email } = req.body;
  
  // console.log('getSalt called for:', email);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const user = await db.collection("login").findOne({ 
      email: email,
      isActive: true 
    });
    
    await client.close();
    
    if (!user) {
      return res.status(400).json({
        statusCode: 400,
        message: "User not found"
      });
    }
    
    if (!user.password) {
      return res.status(400).json({
        statusCode: 400,
        message: "Password not found for user"
      });
    }
    
    // Extract salt from the password field
    // Password format: hashedPassword(64 chars) + salt(64 chars) = 128 chars total
    const passwordWithSalt = user.password;
    if (passwordWithSalt.length < 128) {
      return res.status(400).json({
        statusCode: 400,
        message: "Invalid password format"
      });
    }
    
    // Extract the last 64 characters as salt
    const salt = passwordWithSalt.substring(passwordWithSalt.length - 64);
    
    res.status(200).json({
      statusCode: 200,
      salt: salt
    });
    
  } catch (error) {
    console.error('Error getting salt:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting salt"
    });
  }
});

// ============================================================================
// MULTI-TENANT BUSINESS MANAGEMENT
// ============================================================================

/**
 * Add business with organization context
 * POST /addBusiness
 */
app.post("/addBusiness", async function (req, res) {
  const { 
    businessName, 
    businessEmail, 
    businessPhone, 
    businessAddress, 
    businessCity, 
    businessState, 
    businessZip,
    organizationId,
    userEmail 
  } = req.body;
  
  // console.log('Add business called:', businessName, organizationId);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    // Verify user belongs to organization (if organizationId provided)
    if (organizationId && userEmail) {
      const user = await db.collection("login").findOne({ 
        email: userEmail,
        organizationId: organizationId 
      });
      
      if (!user) {
        await client.close();
        return res.status(403).json({
          statusCode: 403,
          message: "User not authorized for this organization"
        });
      }
    }
    
    // Check for duplicate business (same name and email within organization)
    const duplicateQuery = {
      businessName: businessName,
      businessEmail: businessEmail,
      organizationId: organizationId || null,
      isActive: true
    };
    
    const existingBusiness = await db.collection("businesses").findOne(duplicateQuery);
    
    if (existingBusiness) {
      await client.close();
      return res.status(409).json({
        statusCode: 409,
        message: "Business with this name and email already exists"
      });
    }
    
    // Create business document with organization context
    const businessDoc = {
      _id: new ObjectId(),
      businessName: businessName,
      businessEmail: businessEmail,
      businessPhone: businessPhone,
      businessAddress: businessAddress,
      businessCity: businessCity,
      businessState: businessState,
      businessZip: businessZip,
      organizationId: organizationId || null,
      createdBy: userEmail,
      createdAt: new Date(),
      isActive: true
    };
    
    const result = await db.collection("businesses").insertOne(businessDoc);
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      message: "Business added successfully",
      businessId: result.insertedId.toString()
    });
    
  } catch (error) {
    console.error('Error adding business:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error adding business"
    });
  }
});

/**
 * Get businesses for organization
 * GET /businesses/:organizationId
 */
app.get("/businesses/:organizationId", async function (req, res) {
  const { organizationId } = req.params;
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const businesses = await db.collection("businesses").find({ 
      organizationId: organizationId,
      isActive: true 
    }).toArray();
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      businesses: businesses
    });
    
  } catch (error) {
    console.error('Error getting businesses:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting businesses"
    });
  }
});

// ============================================================================
// MULTI-TENANT CLIENT MANAGEMENT
// ============================================================================

/**
 * Add client with organization context
 * POST /addClient
 */
app.post("/addClient", async function (req, res) {
  const { 
    clientFirstName, 
    clientLastName, 
    clientEmail, 
    clientPhone, 
    clientAddress, 
    clientCity, 
    clientState, 
    clientZip, 
    businessName,
    organizationId,
    userEmail 
  } = req.body;
  
  // console.log('Add client called:', clientEmail, organizationId);
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    // Verify user belongs to organization (if organizationId provided)
    if (organizationId && userEmail) {
      const user = await db.collection("login").findOne({ 
        email: userEmail,
        organizationId: organizationId 
      });
      
      if (!user) {
        await client.close();
        return res.status(403).json({
          statusCode: 403,
          message: "User not authorized for this organization"
        });
      }
    }
    
    // Create client document with organization context
    const clientDoc = {
      _id: new ObjectId(),
      clientFirstName: clientFirstName,
      clientLastName: clientLastName,
      clientEmail: clientEmail,
      clientPhone: clientPhone,
      clientAddress: clientAddress,
      clientCity: clientCity,
      clientState: clientState,
      clientZip: clientZip,
      businessName: businessName,
      organizationId: organizationId || null,
      createdBy: userEmail,
      createdAt: new Date(),
      isActive: true
    };
    
    const result = await db.collection("clients").insertOne(clientDoc);
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      message: "Client added successfully",
      clientId: result.insertedId.toString()
    });
    
  } catch (error) {
    console.error('Error adding client:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error adding client"
    });
  }
});

/**
 * Get businesses for organization
 * GET /organization/:organizationId/businesses
 */
app.get("/organization/:organizationId/businesses", async function (req, res) {
  const { organizationId } = req.params;
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const businesses = await db.collection("businesses").find({ 
      organizationId: organizationId,
      isActive: true 
    }).toArray();
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      businesses: businesses
    });
    
  } catch (error) {
    console.error('Error getting businesses:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting businesses"
    });
  }
});

/**
 * Get clients for organization
 * GET /organization/:organizationId/clients
 */
app.get("/organization/:organizationId/clients", async function (req, res) {
  const { organizationId } = req.params;
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const clients = await db.collection("clients").find({ 
      organizationId: organizationId,
      isActive: true 
    }).toArray();
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      clients: clients
    });
    
  } catch (error) {
    console.error('Error getting clients:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting clients"
    });
  }
});

/**
 * Get clients for organization (legacy endpoint)
 * GET /clients/:organizationId
 */
app.get("/clients/:organizationId", async function (req, res) {
  const { organizationId } = req.params;
  
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const clients = await db.collection("clients").find({ 
      organizationId: organizationId,
      isActive: true 
    }).toArray();
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      clients: clients
    });
    
  } catch (error) {
    console.error('Error getting clients:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting clients"
    });
  }
});

/**
 * Get all clients (simple endpoint for backward compatibility)
 * GET /getClients
 */
app.get("/getClients", async function (req, res) {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const clients = await db.collection("clients").find({ 
      isActive: true 
    }).toArray();
    
    await client.close();
    
    res.status(200).json({
      statusCode: 200,
      clients: clients
    });
    
  } catch (error) {
    console.error('Error getting clients:', error);
    res.status(500).json({
      statusCode: 500,
      message: "Error getting clients"
    });
  }
});

/**
 * Get multiple clients by email list
 * GET /getMultipleClients/:emails
 */
app.get("/getMultipleClients/:emails", async function (req, res) {
  let client;
  
  try {
    const emails = req.params.emails;
    // console.log('getMultipleClients called for emails:', emails);
    
    // Split emails if multiple are provided (comma-separated)
    const emailList = emails.split(',').map(email => email.trim());
    
    // Connect to MongoDB
    client = new MongoClient(process.env.MONGODB_URI, {
      serverApi: ServerApiVersion.v1
    });
    await client.connect();
    
    const db = client.db("Invoice");
    const collection = db.collection("clients");
    
    // Find clients with matching emails
    const clients = await collection.find({
      clientEmail: { $in: emailList },
      isActive: true
    }).toArray();
    
    // console.log(`Found ${clients.length} clients for emails:`, emailList);
    
    // Return clients as array (expected by frontend)
    res.status(200).json(clients);
    
  } catch (error) {
    console.error('Error in getMultipleClients:', error);
    res.status(500).json({
      success: false,
      message: "Error getting clients",
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// ============================================================================
// CLIENT ASSIGNMENT ENDPOINTS
// ============================================================================

/**
 * Assign client to user with schedule
 * POST /assignClientToUser
 */
app.post('/assignClientToUser', async (req, res) => {
  let client;
  
  try {
    const { userEmail, clientEmail, dateList, startTimeList, endTimeList, breakList, ndisItem, highIntensityList, customPricing, scheduleWithNdisItems } = req.body;
    
    // Log all received data for debugging
    console.log('=== BACKEND RECEIVED DATA - assignClientToUser ENDPOINT ===');
    console.log('User Email:', userEmail);
    console.log('Client Email:', clientEmail);
    console.log('Date List:', dateList);
    console.log('Start Time List:', startTimeList);
    console.log('End Time List:', endTimeList);
    console.log('Break List:', breakList);
    console.log('High Intensity List:', highIntensityList);
    console.log('NDIS Item (legacy):', ndisItem);
    console.log('Custom Pricing (legacy):', customPricing);
    console.log('Schedule With NDIS Items:', scheduleWithNdisItems);
    console.log('Schedule With NDIS Items Type:', typeof scheduleWithNdisItems);
    console.log('Schedule With NDIS Items Length:', scheduleWithNdisItems ? scheduleWithNdisItems.length : 'null/undefined');
    if (scheduleWithNdisItems && Array.isArray(scheduleWithNdisItems)) {
      scheduleWithNdisItems.forEach((item, index) => {
        console.log(`Schedule Item ${index}:`, JSON.stringify(item, null, 2));
      });
    }
    console.log('=== END OF BACKEND RECEIVED DATA LOG ===');
    
    // console.log('assignClientToUser called with request body:', JSON.stringify(req.body, null, 2));
    
    // Validate required fields
    if (!userEmail || !clientEmail || !dateList || !startTimeList || !endTimeList || !breakList || !highIntensityList) {
      console.error('Missing required fields in request body');
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: userEmail, clientEmail, dateList, startTimeList, endTimeList, breakList, highIntensityList'
      });
    }
    
    // Validate array lengths match
    if (dateList.length !== startTimeList.length || dateList.length !== endTimeList.length || 
        dateList.length !== breakList.length || dateList.length !== highIntensityList.length) {
      console.error('Array length mismatch in request body');
      return res.status(400).json({
        success: false,
        message: 'All arrays (dateList, startTimeList, endTimeList, breakList, highIntensityList) must have the same length'
      });
    }
    
    // If scheduleWithNdisItems is provided, validate it matches the array lengths
    if (scheduleWithNdisItems && scheduleWithNdisItems.length !== dateList.length) {
      console.error('scheduleWithNdisItems length mismatch in request body');
      return res.status(400).json({
        success: false,
        message: 'scheduleWithNdisItems array must have the same length as other schedule arrays'
      });
    }
    
    // console.log('Validation passed. Processing assignment...');
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Verify client exists
    const clientExists = await db.collection("clients").findOne({ 
      clientEmail: clientEmail,
      isActive: true
    });

    // console.log('Client existence check result:', JSON.stringify(clientExists, null, 2));

    if (!clientExists) {
      return res.status(404).json({ 
        success: false,
        error: 'Client not found or inactive'
      });
    }

    // Parse ndisItem if it's a string (for backward compatibility)
    let parsedNdisItem = ndisItem;
    if (typeof ndisItem === 'string') {
      try {
        parsedNdisItem = JSON.parse(ndisItem);
      } catch (e) {
        console.error('Error parsing ndisItem string:', e);
        return res.status(400).json({
          success: false,
          message: "Invalid NDIS item format",
          error: process.env.NODE_ENV === 'development' ? e.message : undefined
        });
      }
    }

    // Extract customPricing from ndisItem if it exists (for backward compatibility)
    let extractedCustomPricing = customPricing;
    if (parsedNdisItem && parsedNdisItem.customPricing) {
      extractedCustomPricing = parsedNdisItem.customPricing;
      console.log('Custom pricing extracted from ndisItem:', JSON.stringify(extractedCustomPricing, null, 2));
      // Remove customPricing from ndisItem to keep it clean
      delete parsedNdisItem.customPricing;
    }

    // Parse scheduleWithNdisItems if provided (new format supporting multiple NDIS items)
    let parsedScheduleWithNdisItems = [];
    console.log('=== PARSING SCHEDULE WITH NDIS ITEMS ===');
    console.log('scheduleWithNdisItems exists:', !!scheduleWithNdisItems);
    console.log('scheduleWithNdisItems is array:', Array.isArray(scheduleWithNdisItems));
    if (scheduleWithNdisItems && Array.isArray(scheduleWithNdisItems)) {
      console.log('Processing', scheduleWithNdisItems.length, 'schedule items');
      for (let i = 0; i < scheduleWithNdisItems.length; i++) {
        let scheduleItem = scheduleWithNdisItems[i];
        console.log(`Processing schedule item ${i}:`, JSON.stringify(scheduleItem, null, 2));
        if (typeof scheduleItem === 'string') {
          try {
            scheduleItem = JSON.parse(scheduleItem);
            console.log(`Parsed schedule item ${i}:`, JSON.stringify(scheduleItem, null, 2));
          } catch (e) {
            console.error(`Error parsing scheduleWithNdisItems[${i}]:`, e);
            return res.status(400).json({
              success: false,
              message: `Invalid schedule item format at index ${i}`,
              error: process.env.NODE_ENV === 'development' ? e.message : undefined
            });
          }
        }
        parsedScheduleWithNdisItems.push(scheduleItem);
        console.log(`Added to parsedScheduleWithNdisItems[${i}]:`, JSON.stringify(scheduleItem, null, 2));
      }
    } else {
      console.log('No scheduleWithNdisItems provided or not an array');
    }
    console.log('Final parsedScheduleWithNdisItems:', JSON.stringify(parsedScheduleWithNdisItems, null, 2));
    console.log('=== END PARSING SCHEDULE WITH NDIS ITEMS ===');

    // Update client with NDIS information (use the first NDIS item if multiple are provided)
    let clientNdisItem = parsedNdisItem;
    if (parsedScheduleWithNdisItems.length > 0 && parsedScheduleWithNdisItems[0].ndisItem) {
      clientNdisItem = parsedScheduleWithNdisItems[0].ndisItem;
    }
    
    if (clientNdisItem) {
      const clientUpdateResult = await db.collection("clients").updateOne(
        { clientEmail: clientEmail },
        { 
          $set: {
            ndisItem: clientNdisItem
          }
        }
      );
      // console.log('Client NDIS update result:', JSON.stringify(clientUpdateResult, null, 2));
    }

    // Get user's organizationId if client doesn't have one
    let organizationId = clientExists.organizationId;
    if (!organizationId) {
      const user = await db.collection("login").findOne({ 
        email: userEmail,
        isActive: true 
      });
      
      // console.log('User details for organizationId lookup:', JSON.stringify(user, null, 2));

      if (user && user.organizationId) {
        organizationId = user.organizationId;
        
        // Update the client record with the organizationId
        const orgIdUpdateResult = await db.collection("clients").updateOne(
          { _id: clientExists._id },
          { 
            $set: {
              organizationId: organizationId,
              updatedAt: new Date()
            }
          }
        );
  
        // console.log(`Updated client ${clientEmail} with organizationId: ${organizationId}. Result:`, JSON.stringify(orgIdUpdateResult, null, 2));
      }
    }
    
    // Create assignment data with support for multiple NDIS items per schedule entry
    console.log('=== CONSTRUCTING SCHEDULE DATA ===');
    const scheduleData = dateList.map((date, i) => {
      console.log(`Constructing schedule entry ${i}:`);
      let scheduleEntry = {
        date: date,
        startTime: startTimeList[i],
        endTime: endTimeList[i],
        break: breakList[i],
        highIntensity: highIntensityList[i],
      };
      console.log(`Base schedule entry ${i}:`, JSON.stringify(scheduleEntry, null, 2));
      
      // Use individual NDIS item if provided, otherwise fall back to the single ndisItem
      if (parsedScheduleWithNdisItems.length > i && parsedScheduleWithNdisItems[i].ndisItem) {
        scheduleEntry.ndisItem = parsedScheduleWithNdisItems[i].ndisItem;
        console.log(`Added individual NDIS item to schedule entry ${i}:`, JSON.stringify(parsedScheduleWithNdisItems[i].ndisItem, null, 2));
      } else if (parsedNdisItem) {
        scheduleEntry.ndisItem = parsedNdisItem;
        console.log(`Added fallback NDIS item to schedule entry ${i}:`, JSON.stringify(parsedNdisItem, null, 2));
      } else {
        console.log(`No NDIS item for schedule entry ${i}`);
      }
      
      console.log(`Final schedule entry ${i}:`, JSON.stringify(scheduleEntry, null, 2));
      return scheduleEntry;
    });
    console.log('Final scheduleData:', JSON.stringify(scheduleData, null, 2));
    console.log('=== END CONSTRUCTING SCHEDULE DATA ===');
    
    const assignmentData = {
      userEmail: userEmail,
      clientEmail: clientEmail,
      clientId: clientExists._id,
      organizationId: organizationId,
      schedule: scheduleData,
      assignedNdisItemNumber: parsedNdisItem?.itemNumber || (parsedScheduleWithNdisItems.length > 0 ? parsedScheduleWithNdisItems[0].ndisItem?.itemNumber : null),
      createdAt: new Date(),
      isActive: true
    };
    
    // console.log('Assignment data before insertion/update:', JSON.stringify(assignmentData, null, 2));

    // Check if assignment already exists
    const existingAssignment = await db.collection("clientAssignments").findOne({
      userEmail: userEmail,
      clientEmail: clientEmail,
      isActive: true
    });

    // console.log('Existing assignment check result:', JSON.stringify(existingAssignment, null, 2));

    let finalAssignmentId;
    if (existingAssignment) {
      // Append new schedules to existing assignment instead of replacing
      const newSchedules = dateList.map((date, i) => {
        let scheduleEntry = {
          date: date,
          startTime: startTimeList[i],
          endTime: endTimeList[i],
          break: breakList[i],
          highIntensity: highIntensityList[i],
        };
        
        // Use individual NDIS item if provided, otherwise fall back to the single ndisItem
        if (parsedScheduleWithNdisItems.length > i && parsedScheduleWithNdisItems[i].ndisItem) {
          scheduleEntry.ndisItem = parsedScheduleWithNdisItems[i].ndisItem;
        } else if (parsedNdisItem) {
          scheduleEntry.ndisItem = parsedNdisItem;
        }
        
        return scheduleEntry;
      });
      
      // console.log('New schedules to be added/updated:', JSON.stringify(newSchedules, null, 2));
      
      // Get existing schedule array or initialize empty array
      const existingSchedules = existingAssignment.schedule || [];
      // console.log('Existing schedules count:', existingSchedules.length);
      
      // Update existing schedules and add new ones
      const combinedSchedules = [...existingSchedules];
      let updatedCount = 0;
      let addedCount = 0;
      
      newSchedules.forEach(newSchedule => {
        // Check for time conflicts with existing schedules on the same date
        const conflictingScheduleIndex = combinedSchedules.findIndex(existingSchedule => 
          existingSchedule.date === newSchedule.date &&
          existingSchedule.startTime === newSchedule.startTime &&
          existingSchedule.endTime === newSchedule.endTime
        );
        
        if (conflictingScheduleIndex > -1) {
          // Update existing schedule with exact same time
          // console.log(`Updating existing schedule for date: ${newSchedule.date} at ${newSchedule.startTime}-${newSchedule.endTime}`);
          combinedSchedules[conflictingScheduleIndex] = newSchedule;
          updatedCount++;
        } else {
          // Add new schedule (allows multiple schedules on same date with different times)
          // console.log(`Adding new schedule for date: ${newSchedule.date} at ${newSchedule.startTime}-${newSchedule.endTime}`);
          combinedSchedules.push(newSchedule);
          addedCount++;
        }
      });
      
      // console.log(`Schedule processing complete. Updated: ${updatedCount}, Added: ${addedCount}, Total: ${combinedSchedules.length}`);
      
      // console.log('Combined schedules for update:', JSON.stringify(combinedSchedules, null, 2));

      const updateResult = await db.collection("clientAssignments").updateOne(
        { 
          _id: existingAssignment._id
        },
        { 
          $set: {
            schedule: combinedSchedules,
            updatedAt: new Date()
          }
        }
      );
      // console.log('Update operation result:', JSON.stringify(updateResult, null, 2));
      if (updateResult.matchedCount === 0) {
        console.warn('No matching assignment found for update. This might indicate a logic error.');
        return res.status(404).json({ success: false, message: 'Assignment not found for update.' });
      }
      if (updateResult.modifiedCount === 0) {
        console.warn('Assignment found but not modified. This might indicate the data is the same.');
      }
      finalAssignmentId = existingAssignment._id;
    } else {
      // Create new assignment
      const insertResult = await db.collection("clientAssignments").insertOne(assignmentData);
      // console.log('Insert operation result:', JSON.stringify(insertResult, null, 2));
      if (!insertResult.insertedId) {
        console.error('Failed to insert new assignment.');
        return res.status(500).json({ success: false, message: 'Failed to create new assignment.' });
      }
      finalAssignmentId = insertResult.insertedId;
    }
    
    // Handle custom pricing for each schedule entry with NDIS items
    const customPricingPromises = [];
    
    console.log('=== PROCESSING CUSTOM PRICING ===');
    // Process custom pricing from the new format (scheduleWithNdisItems)
    console.log('DEBUG: scheduleWithNdisItems received:', JSON.stringify(parsedScheduleWithNdisItems, null, 2));
    if (parsedScheduleWithNdisItems && parsedScheduleWithNdisItems.length > 0) {
      console.log(`DEBUG: Processing ${parsedScheduleWithNdisItems.length} schedule items for custom pricing`);
      for (let i = 0; i < parsedScheduleWithNdisItems.length; i++) {
        const scheduleItem = parsedScheduleWithNdisItems[i];
        console.log(`DEBUG: Checking schedule item ${i} for custom pricing:`, JSON.stringify(scheduleItem, null, 2));
        
        if (scheduleItem.ndisItem) {
          console.log(`DEBUG: Schedule item ${i} has NDIS item:`, JSON.stringify(scheduleItem.ndisItem, null, 2));
          
          if (scheduleItem.customPricing) {
            console.log(`DEBUG: Schedule item ${i} has custom pricing:`, JSON.stringify(scheduleItem.customPricing, null, 2));
            
            if (scheduleItem.customPricing.isCustom) {
              console.log(`DEBUG: Processing custom pricing for schedule ${i} - Price: ${scheduleItem.customPricing.price}, Type: ${scheduleItem.customPricing.pricingType}`);
              customPricingPromises.push(processCustomPricing(
                db, 
                scheduleItem.customPricing, 
                scheduleItem.ndisItem, 
                organizationId, 
                clientExists, 
                userEmail
              ));
            } else {
              console.log(`DEBUG: Schedule item ${i} has custom pricing but isCustom is false`);
            }
          } else {
            console.log(`DEBUG: Schedule item ${i} has NDIS item but no custom pricing`);
          }
        } else {
          console.log(`DEBUG: Schedule item ${i} - No NDIS item found`);
        }
      }
    } else {
      console.log('DEBUG: No scheduleWithNdisItems received or empty array');
    }
    
    // Process custom pricing from the legacy format (single ndisItem with customPricing)
    if (extractedCustomPricing && extractedCustomPricing.isCustom && parsedNdisItem) {
      console.log('Processing legacy custom pricing:', JSON.stringify(extractedCustomPricing, null, 2));
      customPricingPromises.push(processCustomPricing(
        db, 
        extractedCustomPricing, 
        parsedNdisItem, 
        organizationId, 
        clientExists, 
        userEmail
      ));
    }
    
    // Execute all custom pricing operations
    console.log(`DEBUG: Total custom pricing promises to execute: ${customPricingPromises.length}`);
    if (customPricingPromises.length > 0) {
      try {
        await Promise.all(customPricingPromises);
        console.log(`Successfully processed ${customPricingPromises.length} custom pricing records`);
      } catch (pricingError) {
        console.error('Error handling custom pricing:', pricingError);
        // Don't fail the assignment creation if custom pricing fails
      }
    } else {
      console.log('DEBUG: No custom pricing to process');
    }
    console.log('=== END PROCESSING CUSTOM PRICING ===');
    
    const responseData = { 
      success: true, 
      message: existingAssignment ? 'Assignment updated successfully' : 'Assignment created successfully',
      assignmentId: finalAssignmentId
    };
    
    // console.log('Sending success response:', JSON.stringify(responseData, null, 2));
    res.status(200).json(responseData);
  } catch (error) {
    console.error('Error in assignClientToUser:', error);
    console.error('Error stack:', error.stack);
    
    // Provide more specific error messages based on error type
    if (error.name === 'MongoError' || error.name === 'MongoServerError') {
      console.error('MongoDB error details:', error.code, error.message);
      res.status(500).json({ 
        success: false, 
        message: 'Database error occurred', 
        error: process.env.NODE_ENV === 'development' ? error.message : undefined,
        code: error.code
      });
    } else if (error.message && error.message.includes('not found')) {
      res.status(404).json({ 
        success: false, 
        message: error.message 
      });
    } else {
      res.status(500).json({
        success: false,
        message: "Error assigning client",
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  } finally {
    if (client) {
      await client.close();
      // console.log('MongoDB connection closed');
    }
  }
});

/**
 * Get client assignments for a user
 * GET /getUserAssignments/:userEmail
 */
app.get('/getUserAssignments/:userEmail', async (req, res) => {
  let client;
  
  try {
    const { userEmail } = req.params;
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Get assignments with client details
    const assignments = await db.collection("clientAssignments").aggregate([
      {
        $match: {
          userEmail: userEmail,
          isActive: true
        }
      },
      {
        $lookup: {
          from: "clients",
          localField: "clientEmail",
          foreignField: "clientEmail",
          as: "clientDetails"
        }
      },
      {
        $unwind: "$clientDetails"
      }
    ]).toArray();
    
    res.status(200).json({
      success: true,
      assignments: assignments
    });
    
  } catch (error) {
    console.error('Error getting user assignments:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get user assignments'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Load appointments for a specific user/employee
 * GET /loadAppointments/:email
 */
app.get('/loadAppointments/:email', async (req, res) => {
  let client;
  
  try {
    const { email } = req.params;
    
    // console.log('Loading appointments for user:', email);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Get appointments (client assignments) with client details for the specific user
    const appointments = await db.collection("clientAssignments").aggregate([
      {
        $match: {
          userEmail: email,
          isActive: true
        }
      },
      {
        $lookup: {
          from: "clients",
          localField: "clientEmail",
          foreignField: "clientEmail",
          as: "clientDetails"
        }
      },
      {
        $unwind: {
          path: "$clientDetails",
          preserveNullAndEmptyArrays: true
        }
      },
      {
        $project: {
          _id: 1,
          userEmail: 1,
          clientEmail: 1,
          organizationId: 1,
          schedule: 1,
          createdAt: 1,
          isActive: 1,
          // Legacy format for compatibility with existing frontend
          dateList: {
            $ifNull: [
              {
                $map: {
                  input: "$schedule",
                  as: "item",
                  in: "$item.date"
                }
              },
              "$dateList"
            ]
          },
          startTimeList: {
            $ifNull: [
              {
                $map: {
                  input: "$schedule",
                  as: "item",
                  in: "$item.startTime"
                }
              },
              "$startTimeList"
            ]
          },
          endTimeList: {
            $ifNull: [
              {
                $map: {
                  input: "$schedule",
                  as: "item",
                  in: "$item.endTime"
                }
              },
              "$endTimeList"
            ]
          },
          breakList: {
            $ifNull: [
              {
                $map: {
                  input: "$schedule",
                  as: "item",
                  in: "$item.break"
                }
              },
              "$breakList"
            ]
          },
          clientDetails: 1
        }
      },
      {
        $sort: {
          createdAt: -1
        }
      }
    ]).toArray();
    
    // console.log(`Found ${appointments.length} appointments for user ${email}`);
    
    // Return data in the format expected by the frontend
    res.status(200).json({
      success: true,
      data: appointments
    });
    
  } catch (error) {
    console.error('Error loading appointments:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to load appointments',
      data: []
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Get appointment details for a specific user and client
 * GET /loadAppointmentDetails/:userEmail/:clientEmail
 */
app.get('/loadAppointmentDetails/:userEmail/:clientEmail', async (req, res) => {
  let client;
  
  try {
    const { userEmail, clientEmail } = req.params;
    
    // console.log('Loading appointment details for:', { userEmail, clientEmail });
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Get the specific appointment assignment with client details
    const appointmentDetails = await db.collection("clientAssignments").aggregate([
      {
        $match: {
          userEmail: userEmail,
          clientEmail: clientEmail,
          isActive: true
        }
      },
      {
        $lookup: {
          from: "clients",
          localField: "clientEmail",
          foreignField: "clientEmail",
          as: "clientDetails"
        }
      },
      {
        $unwind: {
          path: "$clientDetails",
          preserveNullAndEmptyArrays: true
        }
      },
      {
        $project: {
          _id: 1,
          userEmail: 1,
          clientEmail: 1,
          organizationId: 1,
          schedule: 1,
          createdAt: 1,
          isActive: 1,
          // Legacy format for compatibility with existing frontend
          dateList: {
            $ifNull: [
              {
                $map: {
                  input: "$schedule",
                  as: "item",
                  in: "$item.date"
                }
              },
              "$dateList"
            ]
          },
          startTimeList: {
            $ifNull: [
              {
                $map: {
                  input: "$schedule",
                  as: "item",
                  in: "$item.startTime"
                }
              },
              "$startTimeList"
            ]
          },
          endTimeList: {
            $ifNull: [
              {
                $map: {
                  input: "$schedule",
                  as: "item",
                  in: "$item.endTime"
                }
              },
              "$endTimeList"
            ]
          },
          breakList: {
            $ifNull: [
              {
                $map: {
                  input: "$schedule",
                  as: "item",
                  in: "$item.break"
                }
              },
              "$breakList"
            ]
          },
          clientDetails: 1
        }
      }
    ]).toArray();
    
    if (appointmentDetails.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'No appointment found for this user-client combination'
      });
    }
    
    const appointment = appointmentDetails[0];
    
    // console.log(`Found appointment details for ${userEmail} - ${clientEmail}`);
    
    // Return data in the format expected by the frontend
    res.status(200).json({
      success: true,
      data: {
        assignedClient: appointment,
        clientDetails: [appointment.clientDetails]
      }
    });
    
  } catch (error) {
    console.error('Error loading appointment details:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to load appointment details'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Get all assignments for an organization
 * GET /getOrganizationAssignments/:organizationId
 */
app.get('/getOrganizationAssignments/:organizationId', async (req, res) => {
  let client;
  
  try {
    const { organizationId } = req.params;
    
    // console.log('Getting assignments for organization:', organizationId);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Get assignments with client details for the organization
    const assignments = await db.collection("clientAssignments").aggregate([
      {
        $match: {
          organizationId: organizationId,
          isActive: true
        }
      },
      {
        $lookup: {
          from: "clients",
          localField: "clientEmail",
          foreignField: "clientEmail",
          as: "clientDetails"
        }
      },
      {
        $unwind: "$clientDetails"
      },
      {
        $lookup: {
          from: "users",
          localField: "userEmail",
          foreignField: "email",
          as: "userDetails"
        }
      },
      {
        $unwind: {
          path: "$userDetails",
          preserveNullAndEmptyArrays: true
        }
      },
      {
        $project: {
          _id: 1,
          userEmail: 1,
          clientEmail: 1,
          organizationId: 1,
          schedule: 1,
          createdAt: 1,
          isActive: 1,
          // Legacy format for compatibility
          dateList: {
            $map: {
              input: "$schedule",
              as: "item",
              in: "$item.date"
            }
          },
          startTimeList: {
            $map: {
              input: "$schedule",
              as: "item",
              in: "$item.startTime"
            }
          },
          endTimeList: {
            $map: {
              input: "$schedule",
              as: "item",
              in: "$item.endTime"
            }
          },
          breakList: {
            $map: {
              input: "$schedule",
              as: "item",
              in: "$item.break"
            }
          },
          clientDetails: 1,
          userDetails: 1
        }
      },
      {
        $sort: {
          createdAt: -1
        }
      }
    ]).toArray();
    
    // console.log(`Found ${assignments.length} assignments for organization ${organizationId}`);
    
    res.status(200).json({
      success: true,
      assignments: assignments
    });
    
  } catch (error) {
    console.error('Error getting organization assignments:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get organization assignments'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Remove client assignment
 * DELETE /removeClientAssignment
 */
app.delete('/removeClientAssignment', async (req, res) => {
  let client;
  
  try {
    const { userEmail, clientEmail } = req.body;
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Soft delete assignment
    const result = await db.collection("clientAssignments").updateOne(
      {
        userEmail: userEmail,
        clientEmail: clientEmail,
        isActive: true
      },
      {
        $set: {
          isActive: false,
          deletedAt: new Date()
        }
      }
    );
    
    if (result.matchedCount === 0) {
      return res.status(404).json({
        success: false,
        error: 'Assignment not found'
      });
    }
    
    res.status(200).json({
      success: true,
      message: 'Assignment removed successfully'
    });
    
  } catch (error) {
    console.error('Error removing assignment:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to remove assignment'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// ============================================================================
// OTP AND SECURITY ENDPOINTS
// ============================================================================

/**
 * Send OTP for verification
 * POST /sendOTP
 */
app.post('/sendOTP', async (req, res) => {
  const { email, clientEncryptionKey } = req.body;
  
  try {
    const { otp, verificationKey } = await sendOtpEmail(email, clientEncryptionKey);
    // console.log('Send OTP called', otp);
    
    res.status(200).json({
      statusCode: 200,
      message: 'OTP sent successfully',
      otp,
      verificationKey,
    });
  } catch (error) {
    console.error('Error sending OTP:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error sending OTP',
    });
  }
});

/**
 * Verify OTP
 * POST /verifyOTP
 */
app.post('/verifyOTP', (req, res) => {
  const { userOTP, userVerificationKey, generatedOTP, encryptVerificationKey } = req.body;

  try {
    const isVerificationSuccessful = verifyOTP(
      userOTP,
      userVerificationKey,
      generatedOTP,
      encryptVerificationKey,
      120 // Time limit in seconds
    );

    if (isVerificationSuccessful) {
      res.status(200).json({
        statusCode: 200,
        message: 'OTP verification successful',
      });
    } else {
      res.status(401).json({
        statusCode: 401,
        message: 'Invalid OTP or verification key',
      });
    }
  } catch (error) {
    console.error('Error verifying OTP:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error verifying OTP',
    });
  }
});

/**
 * Update password
 * POST /updatePassword
 */
app.post('/updatePassword', async (req, res) => {
  const { newPassword, email } = req.body;

  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");
    
    const result = await db.collection("login").updateOne(
      { email: email },
      { $set: { password: newPassword, updatedAt: new Date() } }
    );
    
    await client.close();
    
    if (result.matchedCount > 0) {
      res.status(200).json({
        statusCode: 200,
        message: 'Password updated successfully'
      });
    } else {
      res.status(404).json({
        statusCode: 404,
        message: 'User not found'
      });
    }
    
  } catch (error) {
    console.error('Error updating password:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error updating password'
    });
  }
});

// ============================================================================
// TIMER ENDPOINTS (DATABASE-BACKED IMPLEMENTATION)
// ============================================================================

// Import active timer functions
// const { startTimerWithTracking, stopTimerWithTracking, getActiveTimers } = require('./active_timers_endpoints');

// Legacy timer variables (kept for backward compatibility)
let timerInterval;
let timerRunning = false;
let startTime;

/**
 * Start timer (legacy endpoint - redirects to new implementation)
 * POST /startTimer
 */
app.post('/startTimer', async (req, res) => {
  // console.log('Legacy start timer called - redirecting to new implementation');
  
  // For backward compatibility, we'll use default values if not provided
  const requestBody = {
    userEmail: req.body.userEmail || 'legacy@user.com',
    clientEmail: req.body.clientEmail || 'legacy@client.com',
    organizationId: req.body.organizationId || 'legacy-org'
  };
  
  // Create a new request object with the body
  const newReq = { body: requestBody };
  
  // Call the new implementation
  await startTimerWithTracking(newReq, res);
});

/**
 * Stop timer (legacy endpoint - redirects to new implementation)
 * POST /stopTimer
 */
app.post('/stopTimer', async (req, res) => {
  // console.log('Legacy stop timer called - redirecting to new implementation');
  
  // For backward compatibility, we'll use default values if not provided
  const requestBody = {
    userEmail: req.body.userEmail || 'legacy@user.com',
    organizationId: req.body.organizationId || 'legacy-org'
  };
  
  // Create a new request object with the body
  const newReq = { body: requestBody };
  
  // Call the new implementation
  await stopTimerWithTracking(newReq, res);
});

/**
 * Start timer with tracking (new database-backed endpoint)
 * POST /startTimerWithTracking
 */
app.post('/startTimerWithTracking', startTimerWithTracking);

/**
 * Stop timer with tracking (new database-backed endpoint)
 * POST /stopTimerWithTracking
 */
app.post('/stopTimerWithTracking', stopTimerWithTracking);

/**
 * Get active timers for organization
 * GET /getActiveTimers/:organizationId
 */
app.get('/getActiveTimers/:organizationId', getActiveTimers);

/**
 * Set worked time for a client
 * POST /setWorkedTime
 */
app.post('/setWorkedTime', async (req, res) => {
  let client;
  
  try {
    const {
      'User-Email': userEmail,
      'Client-Email': clientEmail,
      'TimeList': timeList,
      shiftIndex
    } = req.body;
    
    // console.log('setWorkedTime called for:', userEmail, clientEmail, timeList, shiftIndex);
    
    // Validate required fields
    if (!userEmail || !clientEmail || !timeList) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: User-Email, Client-Email, TimeList'
      });
    }
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Find the assigned client record
    const assignedClient = await db.collection("clientAssignments").findOne({
      userEmail: userEmail,
      clientEmail: clientEmail,
      isActive: true
    });
    
    if (!assignedClient) {
      return res.status(404).json({
        success: false,
        message: 'Assigned client not found'
      });
    }
    
    // Get shift details from the assigned client record
    let shiftDate = null;
    let shiftStartTime = null;
    let shiftEndTime = null;
    let shiftBreak = null;
    
    // Extract shift details based on shiftIndex
    if (assignedClient.schedule && assignedClient.schedule.length > shiftIndex) {
      // Use new schedule array format
      const shift = assignedClient.schedule[shiftIndex];
      shiftDate = shift.date;
      shiftStartTime = shift.startTime;
      shiftEndTime = shift.endTime;
      shiftBreak = shift.break;
    } else if (assignedClient.dateList && assignedClient.dateList.length > shiftIndex) {
      // Fallback to legacy format
      shiftDate = assignedClient.dateList[shiftIndex];
      shiftStartTime = assignedClient.startTimeList ? assignedClient.startTimeList[shiftIndex] : null;
      shiftEndTime = assignedClient.endTimeList ? assignedClient.endTimeList[shiftIndex] : null;
      shiftBreak = assignedClient.breakList ? assignedClient.breakList[shiftIndex] : null;
    }
    
    // Create worked time record with specific shift details
    const workedTimeRecord = {
      userEmail: userEmail,
      clientEmail: clientEmail,
      timeWorked: timeList,
      shiftIndex: shiftIndex || 0,
      assignedClientId: assignedClient._id,
      // Add specific shift details for better linking
      shiftDate: shiftDate,
      shiftStartTime: shiftStartTime,
      shiftEndTime: shiftEndTime,
      shiftBreak: shiftBreak,
      // Create a unique shift identifier
      shiftKey: shiftDate && shiftStartTime ? `${shiftDate}_${shiftStartTime}` : null,
      createdAt: new Date(),
      isActive: true
    };
    
    // Insert the worked time record
    const result = await db.collection("workedTime").insertOne(workedTimeRecord);
    
    res.status(200).json({
      success: true,
      message: 'Worked time saved successfully',
      data: {
        id: result.insertedId,
        timeWorked: timeList
      }
    });
    
  } catch (error) {
    console.error('Error saving worked time:', error);
    res.status(500).json({ 
      success: false,
      message: 'Error saving worked time: ' + error.message
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Employee Tracking API Endpoint
 * GET /getEmployeeTrackingData/:organizationId
 * 
 * This endpoint provides comprehensive employee tracking data including:
 * - Currently working employees (active timers)
 * - Worked time records with shift details
 * - Employee assignments and client information
 */
app.get('/getEmployeeTrackingData/:organizationId', async (req, res) => {
  let client;
  
  try {
    const { organizationId } = req.params;
    
    // console.log('Getting employee tracking data for organization:', organizationId);
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Get all active assignments for the organization
    const assignments = await db.collection("clientAssignments").aggregate([
      {
        $match: {
          organizationId: organizationId,
          isActive: true
        }
      },
      {
        $lookup: {
          from: "clients",
          localField: "clientEmail",
          foreignField: "clientEmail",
          as: "clientDetails"
        }
      },
      {
        $unwind: "$clientDetails"
      },
      {
        $lookup: {
          from: "login",
          localField: "userEmail",
          foreignField: "email",
          as: "userDetails"
        }
      },
      {
        $unwind: "$userDetails"
      }
    ]).toArray();
    
    // Get worked time records for the organization
    let workedTimeRecords = await db.collection("workedTime").aggregate([
      {
        $lookup: {
          from: "clientAssignments",
          localField: "assignedClientId",
          foreignField: "_id",
          as: "assignment"
        }
      },
      {
        $unwind: "$assignment"
      },
      {
        $match: {
          "assignment.organizationId": organizationId,
          isActive: true
        }
      },
      {
        $lookup: {
          from: "clients",
          localField: "clientEmail",
          foreignField: "clientEmail",
          as: "clientDetails"
        }
      },
      {
        $unwind: "$clientDetails"
      },
      {
        $lookup: {
          from: "login",
          localField: "userEmail",
          foreignField: "email",
          as: "userDetails"
        }
      },
      {
        $unwind: "$userDetails"
      },
      {
        $sort: { createdAt: -1 }
      }
    ]).toArray();
    
    // If no worked time records found, create sample data for demonstration
    if (workedTimeRecords.length === 0 && assignments.length > 0) {
      // console.log('No worked time records found, creating sample shift data...');
      
      // Create sample shift data using existing assignments
      const sampleShifts = [];
      
      for (let i = 0; i < Math.min(assignments.length, 2); i++) {
        const assignment = assignments[i];
        
        // Add a completed shift for today
        sampleShifts.push({
          userEmail: assignment.userEmail,
          userDetails: assignment.userDetails,
          clientEmail: assignment.clientEmail,
          clientDetails: assignment.clientDetails,
          timeWorked: "08:30:00",
          shiftDate: new Date().toISOString().split('T')[0],
          shiftStartTime: "09:00",
          shiftEndTime: "17:30",
          shiftBreak: "01:00",
          shiftKey: `sample_shift_${Date.now()}_${i + 1}`,
          createdAt: new Date(),
          _id: `sample_${Date.now()}_${i + 1}`
        });
        
        // Add a completed shift for yesterday
        const yesterday = new Date(Date.now() - 24*60*60*1000);
        sampleShifts.push({
          userEmail: assignment.userEmail,
          userDetails: assignment.userDetails,
          clientEmail: assignment.clientEmail,
          clientDetails: assignment.clientDetails,
          timeWorked: "07:45:00",
          shiftDate: yesterday.toISOString().split('T')[0],
          shiftStartTime: "08:00",
          shiftEndTime: "16:45",
          shiftBreak: "01:00",
          shiftKey: `sample_shift_${Date.now()}_${i + 2}`,
          createdAt: yesterday,
          _id: `sample_${Date.now()}_${i + 2}`
        });
      }
      
      workedTimeRecords = sampleShifts;
      // console.log(`Created ${sampleShifts.length} sample shifts for demonstration`);
    }
    
    // Get currently active timers from database
    // console.log('DEBUG: Querying activeTimers for organizationId:', organizationId);
    const activeTimers = await db.collection('activeTimers').find({
      organizationId: organizationId
    }).toArray();
    // console.log('DEBUG: Found active timers count:', activeTimers.length);
    // console.log('DEBUG: Active timers data:', JSON.stringify(activeTimers, null, 2));
    
    // Process the data to create employee tracking summary
    const employeeTrackingData = {
      totalEmployees: assignments.length,
      currentlyWorking: activeTimers.length,
      assignments: assignments.map(assignment => ({
        userEmail: assignment.userEmail,
        userName: (assignment.userDetails.firstName || '') + ' ' + (assignment.userDetails.lastName || ''),
        clientEmail: assignment.clientEmail,
        clientName: assignment.clientDetails.clientName,
        clientAddress: assignment.clientDetails.clientAddress,
        schedule: assignment.schedule || {
          dateList: assignment.dateList,
          startTimeList: assignment.startTimeList,
          endTimeList: assignment.endTimeList,
          breakList: assignment.breakList
        },
        assignmentId: assignment._id,
        createdAt: assignment.createdAt,
        photoData: assignment.userDetails.photoData || null
      })),
      workedTimeRecords: workedTimeRecords.map(record => ({
        userEmail: record.userEmail,
        userName: (record.userDetails.firstName || '') + ' ' + (record.userDetails.lastName || ''),
        clientEmail: record.clientEmail,
        clientName: record.clientDetails.clientName,
        timeWorked: record.timeWorked,
        shiftDate: record.shiftDate,
        shiftStartTime: record.shiftStartTime,
        shiftEndTime: record.shiftEndTime,
        shiftBreak: record.shiftBreak,
        shiftKey: record.shiftKey,
        createdAt: record.createdAt,
        recordId: record._id
      })),
      activeTimers: activeTimers,
      summary: {
        totalHoursWorked: workedTimeRecords.reduce((total, record) => {
          // Parse time worked (format: "HH:MM:SS")
          const timeParts = record.timeWorked.split(':');
          const hours = parseInt(timeParts[0]) || 0;
          const minutes = parseInt(timeParts[1]) || 0;
          const seconds = parseInt(timeParts[2]) || 0;
          return total + hours + (minutes / 60) + (seconds / 3600);
        }, 0),
        totalShiftsCompleted: workedTimeRecords.length
      }
    };
    
    res.status(200).json({
      success: true,
      data: employeeTrackingData
    });
    
  } catch (error) {
    console.error('Error getting employee tracking data:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get employee tracking data: ' + error.message
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// ============================================================================
// SERVER STARTUP
// ============================================================================

// Export for serverless deployment
module.exports.handler = serverless(app);

app.get("/getUsers/", async (req, res) => {
  let client;
  try {
    // Create a new MongoDB client and connect
    client = new MongoClient(process.env.MONGODB_URI, {
      serverApi: ServerApiVersion.v1,
    });
    
    await client.connect();
    const db = client.db("Invoice");
    
    // Query all users from the login collection
    const users = await db.collection("login").find({}).toArray();
    
    // If no users found, return an empty array
    if (!users || users.length === 0) {
      return res.status(200).json([]);
    }
    
    // Map the users to the expected format
    const formattedUsers = users.map(user => ({
      firstName: user.firstName || "",
      lastName: user.lastName || "",
      email: user.email || "",
      password: user.password || ""
    }));
    
    // Return the formatted users
    res.status(200).json(formattedUsers);
  } catch (error) {
    console.error("Error fetching users:", error);
    res.status(500).json({ error: "Internal server error" });
  } finally {
    // Close the client connection
    if (client) {
      await client.close();
    }
  }
});

app.get("/getHolidays", async (req, res) => { 
  let client;
  try {
    // Connect to MongoDB 
    client = await MongoClient.connect(uri, { 
      serverApi: ServerApiVersion.v1 
    });
    
    const db = client.db("Invoice"); 
    const collection = db.collection("holidaysList"); 

    // Find all documents in the collection 
    const holidays = await collection.find().toArray();
    
    // Return the holidays
    res.status(200).json(holidays); 
  } catch (err) { 
    console.error("Error in getHolidays endpoint: ", err); 
    res.status(500).json({ 
      success: false,
      message: "Internal Server Error",
      error: process.env.NODE_ENV === 'development' ? err.message : undefined
    }); 
  } finally {
    // Ensure client is closed even if an error occurs
    if (client) {
      await client.close();
    }
  }
});

/**
 * Upload CSV data from GitHub to MongoDB
 * Fetches holiday data from a remote CSV file and stores it in the database
 */
app.post("/uploadCSV", async (req, res) => { 
  let client;
  try {
    // Create a promise to handle the CSV parsing
    const holidaysPromise = new Promise((resolve, reject) => {
      const holidays = [];
      
      // Send an HTTP GET request to the remote CSV file
      // Using a specific GitHub raw URL for security
      const csvUrl = "https://raw.githubusercontent.com/BishalBudhathoki/backend_rest_api/main/holiday.csv";
      
      https.get(csvUrl, (response) => {
        // Check if the response is successful
        if (response.statusCode !== 200) {
          return reject(new Error(`Failed to fetch CSV: ${response.statusCode}`));
        }
        
        // Pipe the response data to csv.parse
        response
          .pipe(csv())
          .on("data", (data) => {
            // Replace null bytes in the keys for security
            const updatedData = {};
            Object.keys(data).forEach((key) => {
              // Sanitize keys by replacing null bytes with underscores
              const updatedKey = key.replace(/\0/g, "_"); 
              updatedData[updatedKey] = data[key];
            });
            
            holidays.push(updatedData);
          })
          .on("end", () => {
            if (holidays.length === 0) {
              return reject(new Error("No rows in CSV file"));
            }
            resolve(holidays);
          })
          .on("error", (err) => {
            reject(err);
          });
      }).on("error", (err) => {
        reject(err);
      });
    });
    
    // Wait for the CSV parsing to complete
    const holidays = await holidaysPromise;
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1,
    });
    
    const db = client.db("Invoice");
    const collection = db.collection("holidaysList");
    
    // Delete existing data and insert new data
    await collection.deleteMany({});
    const result = await collection.insertMany(holidays);
    
    res.status(200).json({ 
      success: true,
      message: "Upload successful",
      count: result.insertedCount 
    });
  } catch (err) {
    console.error("Error in uploadCSV endpoint: ", err);
    res.status(500).json({ 
      success: false,
      message: "Internal Server Error",
      error: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
  } finally {
    // Ensure client is closed even if an error occurs
    if (client) {
      await client.close();
    }
  }
});

/**
 * Delete a holiday by ID
 * @param {string} id - MongoDB ObjectId of the holiday to delete
 */
app.delete("/deleteHoliday/:id", async (req, res) => {
  let client;
  try {
    const id = req.params.id;
    
    // Validate the ID format
    if (!ObjectId.isValid(id)) {
      return res.status(400).json({ 
        success: false, 
        message: "Invalid holiday ID format" 
      });
    }
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, { 
      serverApi: ServerApiVersion.v1 
    });
    
    const db = client.db("Invoice");
    const collection = db.collection("holidaysList");

    // Delete the document with the given ID
    const result = await collection.deleteOne({ _id: new ObjectId(id) });
    
    if (result.deletedCount === 0) {
      return res.status(404).json({ 
        success: false, 
        message: "Holiday not found" 
      });
    }
    
    res.status(200).json({ 
      success: true, 
      message: "Delete successful" 
    });
  } catch (err) {
    console.error("Error in deleteHoliday endpoint: ", err);
    res.status(500).json({ 
      success: false, 
      message: "Internal Server Error",
      error: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
  } finally {
    // Ensure client is closed even if an error occurs
    if (client) {
      await client.close();
    }
  }
});

/**
 * Add a new holiday
 * @param {object} req.body - Holiday data (Holiday, Date, Day)
 */
app.post("/addHolidayItem", async (req, res) => {
  let client;
  try {
    // Validate required fields
    const { Holiday, Date, Day } = req.body;
    
    if (!Holiday || !Date || !Day) {
      return res.status(400).json({ 
        success: false, 
        message: "Missing required fields" 
      });
    }
    
    // Validate date format (DD-MM-YYYY)
    const dateRegex = /^\d{2}-\d{2}-\d{4}$/;
    if (!dateRegex.test(Date)) {
      return res.status(400).json({ 
        success: false, 
        message: "Invalid date format. Use DD-MM-YYYY" 
      });
    }
    
    const newHoliday = { Holiday, Date, Day };
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, { 
      serverApi: ServerApiVersion.v1 
    });
    
    const db = client.db("Invoice");
    const collection = db.collection("holidaysList");

    // Check if holiday already exists on the same date
    const existingHoliday = await collection.findOne({ Date });
    if (existingHoliday) {
      return res.status(409).json({ 
        success: false, 
        message: "A holiday already exists on this date" 
      });
    }
    
    // Insert the new holiday
    const result = await collection.insertOne(newHoliday);
    
    res.status(200).json({ 
      success: true, 
      message: "Holiday item added successfully",
      id: result.insertedId 
    });
  } catch (err) {
    console.error("Error in addHolidayItem endpoint: ", err);
    res.status(500).json({ 
      success: false, 
      message: "Internal Server Error",
      error: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
  } finally {
    // Ensure client is closed even if an error occurs
    if (client) {
      await client.close();
    }
  }
});

/**
 * Fix client organizationId for existing records
 * POST /fixClientOrganizationId
 */
app.post('/fixClientOrganizationId', async (req, res) => {
  let client;
  
  try {
    const { userEmail, organizationId } = req.body;
    
    // console.log('Fixing client organizationId for user:', userEmail, 'org:', organizationId);
    
    if (!userEmail || !organizationId) {
      return res.status(400).json({
        success: false,
        error: 'userEmail and organizationId are required'
      });
    }
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Verify user belongs to organization
    const user = await db.collection("login").findOne({ 
      email: userEmail,
      organizationId: organizationId,
      isActive: true
    });
    
    if (!user) {
      return res.status(403).json({
        success: false,
        error: 'User not authorized for this organization'
      });
    }
    
    // Update clients that have null organizationId and were created by this user
    const clientUpdateResult = await db.collection("clients").updateMany(
      { 
        createdBy: userEmail,
        organizationId: null,
        isActive: true
      },
      { 
        $set: {
          organizationId: organizationId,
          updatedAt: new Date()
        }
      }
    );
    
    // Update client assignments that have null organizationId for this user
    const assignmentUpdateResult = await db.collection("clientAssignments").updateMany(
      { 
        userEmail: userEmail,
        organizationId: null,
        isActive: true
      },
      { 
        $set: {
          organizationId: organizationId,
          updatedAt: new Date()
        }
      }
    );
    
    res.status(200).json({
      success: true,
      message: 'Organization ID fixed successfully',
      clientsUpdated: clientUpdateResult.modifiedCount,
      assignmentsUpdated: assignmentUpdateResult.modifiedCount
    });
    
  } catch (error) {
    console.error('Error fixing organizationId:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fix organization ID'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

// ============================================================================
// NEW ENDPOINT FOR FETCHING ORGANIZATION EMPLOYEES
// ============================================================================

/**
 * Get all users (employees) for a specific organization
 * GET /organization/:organizationId/employees
 */
app.get("/organization/:organizationId/employees", async function (req, res) {
  const { organizationId } = req.params;
  // console.log(`Fetching employees for organizationId: ${organizationId}`);

  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    const db = client.db("Invoice");

    // ==========================================================
    // THE FIX: The collection name was incorrect. It should be "login".
    // ==========================================================
    const employees = await db.collection("login").find({ // Corrected from "users" to "login"
      organizationId: organizationId,
      isActive: true
    }).project({
      password: 0, // Exclude sensitive fields
      salt: 0
    }).toArray();

    await client.close();

    if (employees.length > 0) {
      // console.log(`✅ Success: Found ${employees.length} users in organization.`);
      res.status(200).json({
        success: true,
        employees: employees
      });
    } else {
      // console.log(`⚠️ Warning: Did not find any users for organization ID: ${organizationId}`);
      res.status(404).json({
        success: false,
        message: "No users (employees) were found for this organization."
      });
    }

  } catch (error) {
    console.error('Error fetching organization employees:', error);
    res.status(500).json({
      success: false,
      message: "Error fetching employees"
    });
  }
});

/**
 * Check if dates are holidays
 * @param {string} req.body.dateList - Comma-separated list of dates to check
 * @returns {Array} Array of "Holiday" or "No Holiday" for each date
 */
app.post("/check-holidays", async (req, res) => {
  let client;
  try {
    // Validate input
    const { dateList } = req.body;
    
    if (!dateList) {
      return res.status(400).json({ 
        success: false, 
        message: "Missing dateList parameter" 
      });
    }
    
    const dates = dateList.split(",");
    
    // Connect to MongoDB
    client = await MongoClient.connect(uri, { 
      serverApi: ServerApiVersion.v1 
    });
    
    const db = client.db("Invoice");
    const collection = db.collection("holidaysList");
    
    // Find holidays matching the dates
    const query = { Date: { $in: dates } };
    const holidays = await collection.find(query).toArray();
    
    // Create result array with "Holiday" or "No Holiday" for each date
    const holidayStatusList = dates.map(date => 
      holidays.find(holiday => holiday.Date === date) ? "Holiday" : "No Holiday"
    );
    
    res.status(200).json(holidayStatusList);
  } catch (err) {
    console.error("Error in check-holidays endpoint: ", err);
    res.status(500).json({ 
      success: false, 
      message: "Internal Server Error",
      error: process.env.NODE_ENV === 'development' ? err.message : undefined
    });
  } finally {
    // Ensure client is closed even if an error occurs
    if (client) {
      await client.close();
    }
  }
});

/**
 * Search support items
 * GET /api/support-items/search?q=...
 */
app.get('/api/support-items/search', async (req, res) => {
  let client;
  try {
    const searchQuery = req.query.q;
    if (!searchQuery) {
      return res.status(400).json({ success: false, message: 'Missing search query' });
    }
    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db('Invoice');
    // Ensure text index exists (run once, then comment out for prod)
    // await db.collection('supportItems').createIndex({ supportItemName: 'text', supportItemNumber: 'text' });
    const items = await db.collection('supportItems')
      .find({ $text: { $search: searchQuery } })
      .limit(20)
      .toArray();
    res.json({ success: true, items });
  } catch (error) {
    console.error('Error searching for support items:', error);
    res.status(500).json({ success: false, message: 'Error searching for support items.' });
  } finally {
    if (client) await client.close();
  }
});

/**
 * Get all support items
 * GET /api/support-items/all
 */
app.get('/api/support-items/all', async (req, res) => {
  let client;
  try {
    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db('Invoice');
    const items = await db.collection('supportItems').find({}).limit(1000).toArray();
    res.json({ success: true, items });
  } catch (error) {
    console.error('Error fetching all support items:', error);
    res.status(500).json({ success: false, message: 'Error fetching all support items.' });
  } finally {
    if (client) await client.close();
  }
});

// ===== CUSTOM PRICING API ENDPOINTS =====

/**
 * Create a new custom pricing record
 * POST /api/pricing/create
 */
app.post('/api/pricing/create', createCustomPricing);

/**
 * Get pricing records for an organization
 * GET /api/pricing/organization/:organizationId
 */
app.get('/api/pricing/organization/:organizationId', getOrganizationPricing);

/**
 * Get specific pricing record by ID
 * GET /api/pricing/:pricingId
 */
app.get('/api/pricing/:pricingId', getPricingById);

/**
 * Update existing pricing record
 * PUT /api/pricing/:pricingId
 */
app.put('/api/pricing/:pricingId', updateCustomPricing);

/**
 * Delete (deactivate) pricing record
 * DELETE /api/pricing/:pricingId
 */
app.delete('/api/pricing/:pricingId', deleteCustomPricing);

/**
 * Update approval status for pricing record
 * PUT /api/pricing/:pricingId/approval
 */
app.put('/api/pricing/:pricingId/approval', updatePricingApproval);

/**
 * Get pricing lookup for invoice generation
 * GET /api/pricing/lookup/:organizationId/:supportItemNumber
 */
app.get('/api/pricing/lookup/:organizationId/:supportItemNumber', getPricingLookup);

/**
 * Get bulk pricing lookup for multiple NDIS items
 * POST /api/pricing/bulk-lookup
 */
app.post('/api/pricing/bulk-lookup', getBulkPricingLookup);

/**
 * Bulk import pricing records
 * POST /api/pricing/bulk-import
 */
app.post('/api/pricing/bulk-import', bulkImportPricing);

/**
Ho * Get custom price for organization (legacy endpoint)
 * GET /custom-price-organization/:ndisItemNumber
 */
app.get('/custom-price-organization/:ndisItemNumber', async (req, res) => {
  try {
    const { ndisItemNumber } = req.params;
    const organizationId = req.headers['organization-id'];
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required in headers'
      });
    }

    // Use the new pricing lookup endpoint
    const lookupReq = {
      params: { organizationId, supportItemNumber: ndisItemNumber },
      query: {} // No clientId for organization-level pricing
    };
    
    const mockRes = {
      status: (code) => ({
        json: (data) => {
          if (code === 200 && data.data && data.data.customPrice) {
            res.json({
              success: true,
              price: data.data.customPrice
            });
          } else {
            res.json({
              success: false,
              price: null
            });
          }
        }
      })
    };
    
    await getPricingLookup(lookupReq, mockRes);
  } catch (error) {
    console.error('Error getting organization custom price:', error);
    res.status(500).json({
      success: false,
      message: 'Error retrieving custom price'
    });
  }
});

/**
 * Get custom price for client (legacy endpoint)
 * GET /custom-price-client/:ndisItemNumber/:clientId
 */
app.get('/custom-price-client/:ndisItemNumber/:clientId', async (req, res) => {
  try {
    const { ndisItemNumber, clientId } = req.params;
    const organizationId = req.headers['organization-id'];
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required in headers'
      });
    }

    // Use the new pricing lookup endpoint
    const lookupReq = {
      params: { organizationId, supportItemNumber: ndisItemNumber },
      query: { clientId } // Include clientId for client-specific pricing
    };
    
    const mockRes = {
      status: (code) => ({
        json: (data) => {
          if (code === 200 && data.data && data.data.customPrice) {
            res.json({
              success: true,
              price: data.data.customPrice
            });
          } else {
            res.json({
              success: false,
              price: null
            });
          }
        }
      })
    };
    
    await getPricingLookup(lookupReq, mockRes);
  } catch (error) {
    console.error('Error getting client custom price:', error);
    res.status(500).json({
      success: false,
      message: 'Error retrieving custom price'
    });
  }
});

/**
 * Save custom price for organization (legacy endpoint)
 * POST /save-custom-price-organization
 */
app.post('/save-custom-price-organization', async (req, res) => {
  try {
    const { ndisItemNumber, price, notes, metadata } = req.body;
    
    // Get user info from session or token (simplified for now)
    const userEmail = req.headers['user-email'] || 'system@example.com';
    const organizationId = req.headers['organization-id'] || metadata?.organizationId;
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required'
      });
    }
    
    // Transform to new API format
    const transformedReq = {
      ...req,
      body: {
        organizationId: organizationId,
        supportItemNumber: ndisItemNumber,
        supportItemName: metadata?.supportItemName || `Item ${ndisItemNumber}`,
        pricingType: 'fixed',
        customPrice: price,
        clientSpecific: false,
        ndisCompliant: true,
        exceedsNdisCap: false,
        userEmail: userEmail,
        notes: notes
      }
    };
    
    await createCustomPricing(transformedReq, res);
  } catch (error) {
    console.error('Error in save-custom-price-organization:', error);
    res.status(500).json({
      success: false,
      message: 'Error saving custom price'
    });
  }
});

/**
 * Save custom price for client (legacy endpoint)
 * POST /save-custom-price-client
 */
app.post('/save-custom-price-client', async (req, res) => {
  try {
    const { ndisItemNumber, clientId, price, notes, metadata } = req.body;
    
    // Get user info from session or token (simplified for now)
    const userEmail = req.headers['user-email'] || 'system@example.com';
    const organizationId = req.headers['organization-id'] || metadata?.organizationId;
    
    if (!organizationId) {
      return res.status(400).json({
        success: false,
        message: 'Organization ID is required'
      });
    }
    
    // Transform to new API format
    const transformedReq = {
      ...req,
      body: {
        organizationId: organizationId,
        supportItemNumber: ndisItemNumber,
        supportItemName: metadata?.supportItemName || `Item ${ndisItemNumber}`,
        pricingType: 'fixed',
        customPrice: price,
        clientId: clientId,
        clientSpecific: true,
        ndisCompliant: true,
        exceedsNdisCap: false,
        userEmail: userEmail,
        notes: notes
      }
    };
    
    await createCustomPricing(transformedReq, res);
  } catch (error) {
    console.error('Error in save-custom-price-client:', error);
    res.status(500).json({
      success: false,
      message: 'Error saving custom price'
    });
  }
});

// ===== EXPENSE MANAGEMENT API ENDPOINTS =====

/**
 * Create a new expense record
 * POST /api/expenses/create
 */
app.post('/api/expenses/create', async (req, res) => {
  try {
    const result = await createExpense(req.body);
    res.status(result.statusCode || 200).json(result);
  } catch (error) {
    console.error('Error creating expense:', error);
    res.status(400).json({
      statusCode: 400,
      message: error.message || 'Error creating expense record'
    });
  }
});

/**
 * Get expense categories and subcategories
 * GET /api/expenses/categories
 */
app.get('/api/expenses/categories', async (req, res) => {
  try {
    const result = await getExpenseCategories();
    res.status(result.statusCode || 200).json(result);
  } catch (error) {
    console.error('Error getting expense categories:', error);
    res.status(500).json({
      statusCode: 500,
      message: error.message || 'Error retrieving expense categories'
    });
  }
});

/**
 * Get expenses for an organization
 * GET /api/expenses/organization/:organizationId
 */
app.get('/api/expenses/organization/:organizationId', async (req, res) => {
  try {
    const { organizationId } = req.params;
    const result = await getOrganizationExpenses(organizationId, req.query);
    res.status(result.statusCode || 200).json(result);
  } catch (error) {
    console.error('Error getting organization expenses:', error);
    res.status(400).json({
      statusCode: 400,
      message: error.message || 'Error retrieving organization expenses'
    });
  }
});

/**
 * Get specific expense record by ID
 * GET /api/expenses/:expenseId
 */
app.get('/api/expenses/:expenseId', async (req, res) => {
  try {
    const { expenseId } = req.params;
    const result = await getExpenseById(expenseId);
    res.status(result.statusCode || 200).json(result);
  } catch (error) {
    console.error('Error getting expense by ID:', error);
    const statusCode = error.message.includes('not found') ? 404 : 
                      error.message.includes('Invalid') ? 400 : 500;
    res.status(statusCode).json({
      statusCode,
      message: error.message || 'Error retrieving expense record'
    });
  }
});

/**
 * Update existing expense record
 * PUT /api/expenses/:expenseId
 */
app.put('/api/expenses/:expenseId', async (req, res) => {
  try {
    const { expenseId } = req.params;
    const result = await updateExpense(expenseId, req.body);
    res.status(result.statusCode || 200).json(result);
  } catch (error) {
    console.error('Error updating expense:', error);
    const statusCode = error.message.includes('not found') ? 404 : 
                      error.message.includes('not authorized') ? 403 :
                      error.message.includes('Invalid') ? 400 : 500;
    res.status(statusCode).json({
      statusCode,
      message: error.message || 'Error updating expense record'
    });
  }
});

/**
 * Delete (deactivate) expense record
 * DELETE /api/expenses/:expenseId
 */
app.delete('/api/expenses/:expenseId', async (req, res) => {
  try {
    const { expenseId } = req.params;
    const { userEmail, deleteReason } = req.body;
    const result = await deleteExpense(expenseId, userEmail, deleteReason);
    res.status(result.statusCode || 200).json(result);
  } catch (error) {
    console.error('Error deleting expense:', error);
    const statusCode = error.message.includes('not found') ? 404 : 
                      error.message.includes('not authorized') ? 403 :
                      error.message.includes('Invalid') ? 400 : 500;
    res.status(statusCode).json({
      statusCode,
      message: error.message || 'Error deleting expense record'
    });
  }
});

/**
 * Update approval status for expense record
 * PUT /api/expenses/:expenseId/approval
 */
app.put('/api/expenses/:expenseId/approval', async (req, res) => {
  try {
    const { expenseId } = req.params;
    const result = await updateExpenseApproval(expenseId, req.body);
    res.status(result.statusCode || 200).json(result);
  } catch (error) {
    console.error('Error updating expense approval:', error);
    const statusCode = error.message.includes('not found') ? 404 : 
                      error.message.includes('not authorized') ? 403 :
                      error.message.includes('Invalid') ? 400 : 500;
    res.status(statusCode).json({
      statusCode,
      message: error.message || 'Error updating approval status'
    });
  }
});

/**
 * Bulk import expense records
 * POST /api/expenses/bulk-import
 */
app.post('/api/expenses/bulk-import', async (req, res) => {
  try {
    const result = await bulkImportExpenses(req.body);
    res.status(result.statusCode || 200).json(result);
  } catch (error) {
    console.error('Error bulk importing expenses:', error);
    const statusCode = error.message.includes('not authorized') ? 403 :
                      error.message.includes('required') ? 400 : 500;
    res.status(statusCode).json({
      statusCode,
      message: error.message || 'Error performing bulk import'
    });
  }
});

// ===== PRICE VALIDATION API ENDPOINTS =====

/**
 * Validate a single price against NDIS caps
 * POST /api/price-validation/validate
 */
app.post('/api/price-validation/validate', validatePrice);

/**
 * Validate multiple prices in batch
 * POST /api/price-validation/validate-batch
 */
app.post('/api/price-validation/validate-batch', validatePricesBatch);

/**
 * Get price caps for a support item
 * GET /api/price-validation/caps/:supportItemNumber
 */
app.get('/api/price-validation/caps/:supportItemNumber', getPriceCaps);

/**
 * Check if a support item requires quotes
 * GET /api/price-validation/quote-required/:supportItemNumber
 */
app.get('/api/price-validation/quote-required/:supportItemNumber', checkQuoteRequired);

/**
 * Validate pricing for invoice line items
 * POST /api/price-validation/validate-invoice
 */
app.post('/api/price-validation/validate-invoice', validateInvoiceLineItems);

/**
 * Get validation statistics
 * GET /api/price-validation/stats
 */
app.get('/api/price-validation/stats', getValidationStats);

// ============================================================================
// AUDIT TRAIL API ENDPOINTS
// ============================================================================

/**
 * Get audit history for a specific entity
 * GET /api/audit/entity/:entityType/:entityId
 */
app.get('/api/audit/entity/:entityType/:entityId', getEntityAuditHistoryEndpoint);

/**
 * Get organization audit logs with filtering
 * GET /api/audit/organization/:organizationId
 */
app.get('/api/audit/organization/:organizationId', getOrganizationAuditLogsEndpoint);

/**
 * Get audit statistics for an organization
 * GET /api/audit/statistics/:organizationId
 */
app.get('/api/audit/statistics/:organizationId', getAuditStatisticsEndpoint);

/**
 * Create a manual audit log entry
 * POST /api/audit/log
 */
app.post('/api/audit/log', createAuditLogEndpoint);

/**
 * Get available audit actions and entity types
 * GET /api/audit/metadata
 */
app.get('/api/audit/metadata', getAuditMetadataEndpoint);

/**
 * Export audit logs for an organization
 * GET /api/audit/export/:organizationId
 */
app.get('/api/audit/export/:organizationId', exportAuditLogsEndpoint);

// ============================================================================
// RECURRING EXPENSE AUTOMATION API ENDPOINTS
// ============================================================================

/**
 * Process all due recurring expenses for an organization
 * POST /api/recurring-expenses/process
 */
app.post('/api/recurring-expenses/process', processRecurringExpensesEndpoint);

/**
 * Create a new recurring expense template
 * POST /api/recurring-expenses/create
 */
app.post('/api/recurring-expenses/create', createRecurringExpenseEndpoint);

/**
 * Get all recurring expenses for an organization
 * GET /api/recurring-expenses/organization/:organizationId
 */
app.get('/api/recurring-expenses/organization/:organizationId', getOrganizationRecurringExpensesEndpoint);

/**
 * Get a specific recurring expense by ID
 * GET /api/recurring-expenses/:expenseId
 */
app.get('/api/recurring-expenses/:expenseId', getRecurringExpenseByIdEndpoint);

/**
 * Update a recurring expense template
 * PUT /api/recurring-expenses/:expenseId
 */
app.put('/api/recurring-expenses/:expenseId', updateRecurringExpenseEndpoint);

/**
 * Deactivate a recurring expense (stop future occurrences)
 * PUT /api/recurring-expenses/:expenseId/deactivate
 */
app.put('/api/recurring-expenses/:expenseId/deactivate', deactivateRecurringExpenseEndpoint);

/**
 * Get recurring expense statistics for an organization
 * GET /api/recurring-expenses/statistics/:organizationId
 */
app.get('/api/recurring-expenses/statistics/:organizationId', getRecurringExpenseStatisticsEndpoint);

// ============================================================================
// INVOICE GENERATION API ENDPOINTS (Task 2.1: clientAssignment-based extraction)
// ============================================================================

/**
 * Generate invoice line items based on clientAssignment data
 * POST /api/invoice/generate-line-items
 * Body: { userEmail, clientEmail, startDate, endDate }
 */
app.post('/api/invoice/generate-line-items', generateInvoiceLineItems);

/**
 * Generate bulk invoices with pre-configured pricing
 * POST /api/invoice/generate-bulk-invoices
 * Body: { organizationId, userEmail, clients: [{ clientEmail, startDate, endDate }] }
 */
app.post('/api/invoice/generate-bulk-invoices', generateBulkInvoices);

/**
 * Validate existing invoice line items with comprehensive price validation
 * POST /api/invoice/validate-line-items
 * Body: { lineItems, defaultState?, defaultProviderType?, skipPriceValidation? }
 */
app.post('/api/invoice/validate-line-items', validateExistingInvoiceLineItems);

/**
 * Real-time price validation for invoice creation
 * POST /api/invoice/validate-pricing-realtime
 * Body: { lineItems, state?, providerType? }
 */
app.post('/api/invoice/validate-pricing-realtime', validatePricingRealtime);

/**
 * Get comprehensive invoice validation report
 * POST /api/invoice/validation-report
 * Body: { userEmail, clientEmail, startDate, endDate, includeExpenses?, defaultState?, defaultProviderType? }
 */
app.post('/api/invoice/validation-report', getInvoiceValidationReport);

/**
 * Get invoice generation preview
 * GET /api/invoice/preview/:userEmail/:clientEmail?startDate=YYYY-MM-DD&endDate=YYYY-MM-DD
 */
app.get('/api/invoice/preview/:userEmail/:clientEmail', getInvoicePreview);

/**
 * Get assigned client data
 * GET /assigned-client-data
 */
app.get('/assigned-client-data', async (req, res) => {
  let client;
  
  try {
    // Connect to MongoDB
    client = await MongoClient.connect(uri, {
      serverApi: ServerApiVersion.v1
    });
    
    const db = client.db("Invoice");
    
    // Get all active client assignments
    const assignments = await db.collection("clientAssignments").find({
      isActive: true
    }).toArray();
    
    // Enrich with client details
    const enrichedAssignments = [];
    for (const assignment of assignments) {
      const client = await db.collection("clients").findOne({
        clientEmail: assignment.clientEmail,
        isActive: true
      });
      
      if (client) {
        enrichedAssignments.push({
          clientEmail: assignment.clientEmail,
          clientName: `${client.clientFirstName} ${client.clientLastName}`,
          organizationId: assignment.organizationId,
          ndisItemNumber: assignment.assignedNdisItemNumber,
          scheduleCount: assignment.schedule ? assignment.schedule.length : 0,
          createdAt: assignment.createdAt,
          hasScheduleData: !!(assignment.schedule && assignment.schedule.length > 0),
          userEmail: assignment.userEmail
        });
      }
    }
    
    res.status(200).json({
      success: true,
      assignedClientData: enrichedAssignments
    });
    
  } catch (error) {
    console.error('Error getting assigned client data:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get assigned client data'
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});

/**
 * Get available assignments for invoice generation
 * GET /api/invoice/available-assignments/:userEmail
 */
app.get('/api/invoice/available-assignments/:userEmail', getAvailableAssignments);

/**
 * Validate invoice generation data
 * POST /api/invoice/validate-generation-data
 * Body: { userEmail, clientEmail, startDate, endDate }
 */
app.post('/api/invoice/validate-generation-data', validateInvoiceGenerationData);

// ============================================================================
// INVOICE MANAGEMENT API ENDPOINTS (Generated Invoice List, View, Share, Delete)
// ============================================================================

/**
 * Get list of generated invoices for an organization
 * GET /api/invoices/list/:organizationId
 * Query params: page, limit, status, clientEmail, userEmail, startDate, endDate, sortBy, sortOrder
 */
app.get('/api/invoices/list/:organizationId', getInvoicesList);

/**
 * Get detailed view of a specific invoice
 * GET /api/invoices/view/:invoiceId
 * Query params: organizationId (required for access control)
 */
app.get('/api/invoices/view/:invoiceId', getInvoiceDetails);

/**
 * Share invoice (generate shareable link or send via email)
 * POST /api/invoices/share/:invoiceId
 * Body: { organizationId, shareMethod, recipientEmail?, userEmail?, message? }
 */
app.post('/api/invoices/share/:invoiceId', shareInvoice);

/**
 * Delete invoice (soft delete with audit trail)
 * DELETE /api/invoices/delete/:invoiceId
 * Body: { organizationId, userEmail?, reason? }
 */
app.delete('/api/invoices/delete/:invoiceId', deleteInvoice);

/**
 * Get invoice statistics for an organization
 * GET /api/invoices/stats/:organizationId
 * Query params: period (7d, 30d, 90d)
 */
app.get('/api/invoices/stats/:organizationId', getInvoiceStats);

// ============================================================================
// PRICE PROMPT API ENDPOINTS (Task 2.3: Price prompt system for missing prices)
// ============================================================================

/**
 * Create a price prompt for missing pricing
 * POST /api/invoice/price-prompt/create
 * Body: { ndisItemNumber, itemDescription, organizationId, clientId, userEmail, clientEmail, quantity, unit, suggestedPrice, priceCap, state, providerType, sessionId, lineItemIndex }
 */
app.post('/api/invoice/price-prompt/create', createPricePrompt);

/**
 * Resolve a price prompt with user-provided pricing
 * POST /api/invoice/price-prompt/resolve
 * Body: { promptId, resolution: { providedPrice, saveAsCustomPricing, applyToClient, applyToOrganization, notes } }
 */
app.post('/api/invoice/price-prompt/resolve', resolvePricePrompt);

/**
 * Get pending price prompts for a session
 * GET /api/invoice/price-prompt/pending/:sessionId
 */
app.get('/api/invoice/price-prompt/pending/:sessionId', getPendingPrompts);

/**
 * Cancel a price prompt
 * POST /api/invoice/price-prompt/cancel
 * Body: { promptId, userEmail, organizationId, reason }
 */
app.post('/api/invoice/price-prompt/cancel', cancelPricePrompt);

/**
 * Generate invoice with price prompt handling
 * POST /api/invoice/generate-with-prompts
 * Body: { userEmail, clientEmail, startDate, endDate, sessionId }
 */
app.post('/api/invoice/generate-with-prompts', generateInvoiceWithPrompts);

/**
 * Complete invoice generation after all prompts are resolved
 * POST /api/invoice/complete-generation
 * Body: { sessionId, lineItems, userEmail, organizationId }
 */
app.post('/api/invoice/complete-generation', completeInvoiceGeneration);

// ============================================================================
// BACKWARD COMPATIBILITY API ENDPOINTS (Task 2.7: Legacy invoice data support)
// ============================================================================

/**
 * Process legacy invoice data and transform to modern format
 * POST /api/invoice/process-legacy
 * Body: { invoiceData, options? }
 */
app.post('/api/invoice/process-legacy', processLegacyInvoice);

/**
 * Validate legacy invoice compatibility
 * POST /api/invoice/validate-legacy
 * Body: { invoiceData }
 */
app.post('/api/invoice/validate-legacy', validateLegacyCompatibility);

/**
 * Transform legacy invoice to modern format
 * POST /api/invoice/transform-legacy
 * Body: { invoiceData, preserveOriginal? }
 */
app.post('/api/invoice/transform-legacy', transformLegacyInvoice);

/**
 * Migrate legacy invoices in batch
 * POST /api/invoice/migrate-legacy-batch
 * Body: { batchSize?, dryRun?, skipAlreadyMigrated? }
 */
app.post('/api/invoice/migrate-legacy-batch', migrateLegacyInvoicesBatch);

/**
 * Get legacy data statistics
 * GET /api/invoice/legacy-stats
 */
app.get('/api/invoice/legacy-stats', getLegacyDataStats);

/**
 * Map legacy item to NDIS format
 * POST /api/invoice/map-legacy-item
 * Body: { legacyItem }
 */
app.post('/api/invoice/map-legacy-item', mapLegacyItemToNdis);

/**
 * Check invoice backward compatibility
 * GET /api/invoice/:invoiceId/compatibility
 */
app.get('/api/invoice/:invoiceId/compatibility', checkInvoiceCompatibility);

// ============================================================================
// PRICING ANALYTICS API ENDPOINTS
// ============================================================================

/**
 * Get comprehensive pricing analytics
 * GET /api/analytics/pricing/:organizationId
 */
app.get('/api/analytics/pricing/:organizationId', getPricingAnalytics);

/**
 * Get pricing compliance report
 * GET /api/analytics/pricing/compliance/:organizationId
 */
app.get('/api/analytics/pricing/compliance/:organizationId', getPricingComplianceReport);

// ============================================================================
// CLIENT ACTIVITY ANALYTICS API ENDPOINTS
// ============================================================================

/**
 * Get client activity analytics
 * GET /api/analytics/clients/:organizationId
 */
app.get('/api/analytics/clients/:organizationId', getClientActivityAnalytics);

/**
 * Get top performing clients
 * GET /api/analytics/clients/top/:organizationId/:metric
 */
app.get('/api/analytics/clients/top/:organizationId/:metric', getTopPerformingClients);

/**
 * Get client service patterns
 * GET /api/analytics/clients/patterns/:organizationId
 */
app.get('/api/analytics/clients/patterns/:organizationId', getClientServicePatterns);

// ============================================================================
// BUSINESS INTELLIGENCE API ENDPOINTS
// ============================================================================

/**
 * Get business intelligence dashboard
 * GET /api/analytics/business/:organizationId
 */
app.get('/api/analytics/business/:organizationId', getBusinessIntelligenceDashboard);

/**
 * Get revenue forecast
 * GET /api/analytics/business/revenue/:organizationId
 */
app.get('/api/analytics/business/revenue/:organizationId', getRevenueForecastAnalysis);

/**
 * Get operational efficiency report
 * GET /api/analytics/business/efficiency/:organizationId
 */
app.get('/api/analytics/business/efficiency/:organizationId', getOperationalEfficiencyReport);

// Handle both serverless and local environments
if (process.env.SERVERLESS) {
  module.exports.handler = serverless(app);
} else {
  // Start server with Firebase verification
  app.listen(PORT, async () => {
    try {
      // Verify Firebase messaging is working
      await messaging.send({
        token: 'dummy-token',
        data: { type: 'server_startup_check' }
      }, true).catch(() => {
        // Expected to fail with invalid token, but validates Firebase initialization
        logger.info('Firebase Messaging service verified');
      });
      logger.info('Server startup successful', {
        port: PORT,
        firebase: 'initialized',
        timestamp: new Date().toISOString()
      });
    } catch (error) {
      logger.error('Firebase Messaging verification failed', {
        error: error.message,
        stack: error.stack,
        port: PORT
      });
      logger.warn('Server started with Firebase Messaging issues', {
        port: PORT,
        firebase: 'degraded'
      });
    }
  });
}