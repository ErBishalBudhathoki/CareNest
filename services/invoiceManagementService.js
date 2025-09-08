/**
 * Invoice Management Service
 * Handles CRUD operations for generated invoices with organization-based access control
 * Supports listing, viewing, sharing, and deleting invoices
 */

const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb');
const { InvoiceStatus, PaymentStatus, DeliveryStatus } = require('../models/invoiceSchema');
const logger = require('../config/logger');
const crypto = require('crypto');

class InvoiceManagementService {
  constructor() {
    this.client = null;
    this.db = null;
    this.uri = process.env.MONGODB_URI;
  }

  async connect() {
    if (!this.client) {
      this.client = await MongoClient.connect(this.uri, {
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
   * Get paginated list of invoices for an organization
   * @param {string} organizationId - Organization identifier
   * @param {Object} filters - Filter options
   * @param {Object} pagination - Pagination options
   * @returns {Object} Paginated invoice list
   */
  async getInvoicesList(organizationId, filters = {}, pagination = {}) {
    try {
      await this.connect();
      
      const {
        status,
        clientEmail,
        paymentStatus,
        dateFrom,
        dateTo,
        searchTerm
      } = filters;
      
      const {
        page = 1,
        limit = 20,
        sortBy = 'auditTrail.createdAt',
        sortOrder = -1
      } = pagination;
      
      // Build query filter
      const query = {
        organizationId,
        'deletion.isDeleted': { $ne: true }
      };
      
      if (status) {
        query['workflow.status'] = status;
      }
      
      if (clientEmail) {
        query.clientEmail = new RegExp(clientEmail, 'i');
      }
      
      if (paymentStatus) {
        query['payment.status'] = paymentStatus;
      }
      
      if (dateFrom || dateTo) {
        query['auditTrail.createdAt'] = {};
        if (dateFrom) query['auditTrail.createdAt'].$gte = new Date(dateFrom);
        if (dateTo) query['auditTrail.createdAt'].$lte = new Date(dateTo);
      }
      
      if (searchTerm) {
        query.$or = [
          { invoiceNumber: new RegExp(searchTerm, 'i') },
          { clientName: new RegExp(searchTerm, 'i') },
          { clientEmail: new RegExp(searchTerm, 'i') },
          { 'metadata.internalNotes': new RegExp(searchTerm, 'i') }
        ];
      }
      
      const invoicesCollection = this.db.collection('invoices');
      
      // Get total count
      const totalCount = await invoicesCollection.countDocuments(query);
      
      // Get paginated results
      const skip = (page - 1) * limit;
      const invoices = await invoicesCollection
        .find(query)
        .sort({ [sortBy]: sortOrder })
        .skip(skip)
        .limit(limit)
        .project({
          invoiceNumber: 1,
          clientEmail: 1,
          clientName: 1,
          'financialSummary.totalAmount': 1,
          'financialSummary.subtotal': 1,
          'financialSummary.taxAmount': 1,
          'financialSummary.currency': 1,
          'financialSummary.dueDate': 1,
          'workflow.status': 1,
          'payment.status': 1,
          'delivery.status': 1,
          'auditTrail.createdAt': 1,
          'auditTrail.updatedAt': 1,
          'metadata.priority': 1,
          'metadata.tags': 1
        })
        .toArray();
      
      const totalPages = Math.ceil(totalCount / limit);
      
      return {
        success: true,
        data: {
          invoices,
          pagination: {
            currentPage: page,
            totalPages,
            totalCount,
            hasNextPage: page < totalPages,
            hasPrevPage: page > 1
          }
        }
      };
      
    } catch (error) {
      logger.error('Error getting invoices list:', error);
      return {
        success: false,
        error: 'Failed to retrieve invoices list',
        details: error.message
      };
    }
  }

  /**
   * Get detailed view of a specific invoice
   * @param {string} invoiceId - Invoice ID
   * @param {string} organizationId - Organization identifier
   * @returns {Object} Invoice details
   */
  async getInvoiceDetails(invoiceId, organizationId) {
    try {
      await this.connect();
      
      const invoicesCollection = this.db.collection('invoices');
      
      const invoice = await invoicesCollection.findOne({
        _id: new ObjectId(invoiceId),
        organizationId,
        'deletion.isDeleted': { $ne: true }
      });
      
      if (!invoice) {
        return {
          success: false,
          error: 'Invoice not found or access denied'
        };
      }
      
      // Log access for audit trail
      await this.logInvoiceAccess(invoiceId, organizationId, 'view');
      
      return {
        success: true,
        data: invoice
      };
      
    } catch (error) {
      logger.error('Error getting invoice details:', error);
      return {
        success: false,
        error: 'Failed to retrieve invoice details',
        details: error.message
      };
    }
  }

  /**
   * Share an invoice with external parties
   * @param {string} invoiceId - Invoice ID
   * @param {string} organizationId - Organization identifier
   * @param {Object} shareOptions - Sharing configuration
   * @returns {Object} Share result with token
   */
  async shareInvoice(invoiceId, organizationId, shareOptions = {}) {
    try {
      await this.connect();
      
      const {
        sharedWith = [],
        permissions = 'view',
        expiryDays = 30,
        sharedBy
      } = shareOptions;
      
      const invoicesCollection = this.db.collection('invoices');
      
      // Verify invoice exists and belongs to organization
      const invoice = await invoicesCollection.findOne({
        _id: new ObjectId(invoiceId),
        organizationId,
        'deletion.isDeleted': { $ne: true }
      });
      
      if (!invoice) {
        return {
          success: false,
          error: 'Invoice not found or access denied'
        };
      }
      
      // Generate secure share token
      const shareToken = crypto.randomBytes(32).toString('hex');
      const shareExpiryDate = new Date();
      shareExpiryDate.setDate(shareExpiryDate.getDate() + expiryDays);
      
      // Update invoice with sharing information
      const shareHistory = {
        sharedWith: sharedWith.join(', '),
        sharedBy,
        sharedAt: new Date(),
        accessCount: 0,
        lastAccessed: null
      };
      
      await invoicesCollection.updateOne(
        { _id: new ObjectId(invoiceId) },
        {
          $set: {
            'sharing.isShared': true,
            'sharing.sharedWith': sharedWith,
            'sharing.shareToken': shareToken,
            'sharing.shareExpiryDate': shareExpiryDate,
            'sharing.sharePermissions': permissions,
            'auditTrail.updatedAt': new Date(),
            'auditTrail.updatedBy': sharedBy
          },
          $push: {
            'sharing.shareHistory': shareHistory
          }
        }
      );
      
      // Log sharing action
      await this.logInvoiceAccess(invoiceId, organizationId, 'share', {
        sharedWith,
        sharedBy,
        permissions
      });
      
      return {
        success: true,
        data: {
          shareToken,
          shareUrl: `${process.env.FRONTEND_URL}/shared-invoice/${shareToken}`,
          expiryDate: shareExpiryDate,
          sharedWith,
          permissions
        }
      };
      
    } catch (error) {
      logger.error('Error sharing invoice:', error);
      return {
        success: false,
        error: 'Failed to share invoice',
        details: error.message
      };
    }
  }

  /**
   * Get invoice PDF data
   * @param {string} invoiceId - Invoice ID
   * @param {string} organizationId - Organization identifier
   * @returns {Object} PDF data result
   */
  async getInvoicePdf(invoiceId, organizationId) {
    try {
      await this.connect();
      
      const invoicesCollection = this.db.collection('invoices');
      
      // Find the invoice
      const invoice = await invoicesCollection.findOne({
        _id: new ObjectId(invoiceId),
        organizationId,
        'deletion.isDeleted': { $ne: true }
      });
      
      if (!invoice) {
        return {
          success: false,
          error: 'Invoice not found or access denied'
        };
      }
      
      // Check if PDF path exists
      const pdfPath = invoice.metadata?.pdfPath;
      if (!pdfPath) {
        return {
          success: false,
          error: 'PDF not available for this invoice'
        };
      }
      
      // Return PDF metadata - frontend will handle file reading from device storage
      return {
        success: true,
        data: {
          pdfPath: pdfPath,
          filename: `invoice-${invoice.invoiceNumber || invoiceId}.pdf`,
          invoiceNumber: invoice.invoiceNumber,
          clientName: invoice.clientName
        }
      };
      
    } catch (error) {
      logger.error('Error getting invoice PDF:', error);
      return {
        success: false,
        error: 'Failed to retrieve invoice PDF',
        details: error.message
      };
    }
  }

  /**
   * Soft delete an invoice
   * @param {string} invoiceId - Invoice ID
   * @param {string} organizationId - Organization identifier
   * @param {Object} deleteOptions - Deletion configuration
   * @returns {Object} Deletion result
   */
  async deleteInvoice(invoiceId, organizationId, deleteOptions = {}) {
    try {
      await this.connect();
      
      const {
        deletedBy,
        deletionReason = 'User requested deletion',
        permanentDelete = false
      } = deleteOptions;
      
      const invoicesCollection = this.db.collection('invoices');
      
      // Verify invoice exists and belongs to organization
      const invoice = await invoicesCollection.findOne({
        _id: new ObjectId(invoiceId),
        organizationId,
        'deletion.isDeleted': { $ne: true }
      });
      
      if (!invoice) {
        return {
          success: false,
          error: 'Invoice not found or already deleted'
        };
      }
      
      // Check if invoice can be deleted (business rules)
      if (invoice.payment?.status === PaymentStatus.PAID) {
        return {
          success: false,
          error: 'Cannot delete paid invoices. Please contact administrator.'
        };
      }
      
      const deletionDate = new Date();
      const permanentDeletionDate = new Date();
      permanentDeletionDate.setDate(permanentDeletionDate.getDate() + 90); // 90 days retention
      
      if (permanentDelete) {
        // Permanent deletion (admin only)
        await invoicesCollection.deleteOne({ _id: new ObjectId(invoiceId) });
        
        // Log permanent deletion
        await this.logInvoiceAccess(invoiceId, organizationId, 'permanent_delete', {
          deletedBy,
          deletionReason
        });
        
        return {
          success: true,
          data: {
            message: 'Invoice permanently deleted',
            deletedAt: deletionDate
          }
        };
      } else {
        // Soft deletion
        await invoicesCollection.updateOne(
          { _id: new ObjectId(invoiceId) },
          {
            $set: {
              'deletion.isDeleted': true,
              'deletion.deletedBy': deletedBy,
              'deletion.deletedAt': deletionDate,
              'deletion.deletionReason': deletionReason,
              'deletion.canRestore': true,
              'deletion.permanentDeletionDate': permanentDeletionDate,
              'auditTrail.updatedAt': deletionDate,
              'auditTrail.updatedBy': deletedBy
            }
          }
        );
        
        // Log soft deletion
        await this.logInvoiceAccess(invoiceId, organizationId, 'soft_delete', {
          deletedBy,
          deletionReason
        });
        
        return {
          success: true,
          data: {
            message: 'Invoice deleted successfully',
            deletedAt: deletionDate,
            canRestore: true,
            permanentDeletionDate
          }
        };
      }
      
    } catch (error) {
      logger.error('Error deleting invoice:', error);
      return {
        success: false,
        error: 'Failed to delete invoice',
        details: error.message
      };
    }
  }

  /**
   * Get invoice statistics for an organization
   * @param {string} organizationId - Organization identifier
   * @returns {Object} Invoice statistics
   */
  async getInvoiceStats(organizationId) {
    try {
      await this.connect();
      
      const invoicesCollection = this.db.collection('invoices');
      
      const baseQuery = {
        organizationId,
        'deletion.isDeleted': { $ne: true }
      };
      
      // Aggregate statistics
      const stats = await invoicesCollection.aggregate([
        { $match: baseQuery },
        {
          $group: {
            _id: null,
            totalInvoices: { $sum: 1 },
            totalAmount: { $sum: '$financialSummary.totalAmount' },
            paidAmount: {
              $sum: {
                $cond: [
                  { $eq: ['$payment.status', PaymentStatus.PAID] },
                  '$financialSummary.totalAmount',
                  0
                ]
              }
            },
            pendingAmount: {
              $sum: {
                $cond: [
                  { $eq: ['$payment.status', PaymentStatus.PENDING] },
                  '$financialSummary.totalAmount',
                  0
                ]
              }
            },
            overdueAmount: {
              $sum: {
                $cond: [
                  { $eq: ['$payment.status', PaymentStatus.OVERDUE] },
                  '$financialSummary.totalAmount',
                  0
                ]
              }
            }
          }
        }
      ]).toArray();
      
      // Status breakdown
      const statusBreakdown = await invoicesCollection.aggregate([
        { $match: baseQuery },
        {
          $group: {
            _id: '$workflow.status',
            count: { $sum: 1 },
            totalAmount: { $sum: '$financialSummary.totalAmount' }
          }
        }
      ]).toArray();
      
      // Recent activity (last 30 days)
      const thirtyDaysAgo = new Date();
      thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
      
      const recentActivity = await invoicesCollection.countDocuments({
        ...baseQuery,
        'auditTrail.createdAt': { $gte: thirtyDaysAgo }
      });
      
      const result = stats[0] || {
        totalInvoices: 0,
        totalAmount: 0,
        paidAmount: 0,
        pendingAmount: 0,
        overdueAmount: 0
      };
      
      return {
        success: true,
        data: {
          ...result,
          statusBreakdown,
          recentActivity,
          collectionRate: result.totalAmount > 0 ? (result.paidAmount / result.totalAmount * 100).toFixed(2) : 0
        }
      };
      
    } catch (error) {
      logger.error('Error getting invoice stats:', error);
      return {
        success: false,
        error: 'Failed to retrieve invoice statistics',
        details: error.message
      };
    }
  }

  /**
   * Create a new invoice
   * @param {Object} invoiceData - Invoice data according to schema
   * @returns {Object} Creation result
   */
  async createInvoice(invoiceData) {
    try {
      await this.connect();
      
      const invoicesCollection = this.db.collection('invoices');
      
      // Insert the invoice
      const result = await invoicesCollection.insertOne(invoiceData);
      
      if (result.insertedId) {
        // Retrieve the created invoice
        const createdInvoice = await invoicesCollection.findOne({ _id: result.insertedId });
        
        logger.info('Invoice created in database', {
          invoiceId: result.insertedId,
          invoiceNumber: invoiceData.invoiceNumber,
          organizationId: invoiceData.organizationId,
          clientEmail: invoiceData.clientEmail
        });
        
        return {
          success: true,
          data: createdInvoice
        };
      } else {
        return {
          success: false,
          error: 'Failed to insert invoice into database'
        };
      }
      
    } catch (error) {
      logger.error('Error creating invoice:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Generate unique invoice number for organization
   * @param {string} organizationId - Organization identifier
   * @returns {string} Unique invoice number
   */
  async generateInvoiceNumber(organizationId) {
    try {
      await this.connect();
      
      const invoicesCollection = this.db.collection('invoices');
      
      // Get current year and month
      const now = new Date();
      const year = now.getFullYear();
      const month = String(now.getMonth() + 1).padStart(2, '0');
      
      // Create prefix: ORG-YYYY-MM-
      const prefix = `${organizationId.toUpperCase()}-${year}-${month}-`;
      
      // Find the highest existing invoice number for this prefix
      const lastInvoice = await invoicesCollection.findOne(
        {
          organizationId,
          invoiceNumber: { $regex: `^${prefix.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}` }
        },
        {
          sort: { invoiceNumber: -1 },
          projection: { invoiceNumber: 1 }
        }
      );
      
      let nextNumber = 1;
      if (lastInvoice && lastInvoice.invoiceNumber) {
        const lastNumberStr = lastInvoice.invoiceNumber.replace(prefix, '');
        const lastNumber = parseInt(lastNumberStr, 10);
        if (!isNaN(lastNumber)) {
          nextNumber = lastNumber + 1;
        }
      }
      
      // Format with leading zeros (4 digits)
      const formattedNumber = String(nextNumber).padStart(4, '0');
      
      return `${prefix}${formattedNumber}`;
      
    } catch (error) {
      logger.error('Error generating invoice number:', error);
      // Fallback to timestamp-based number
      const timestamp = Date.now();
      return `${organizationId.toUpperCase()}-${timestamp}`;
    }
  }

  /**
   * Log invoice access for audit trail
   * @param {string} invoiceId - Invoice ID
   * @param {string} organizationId - Organization identifier
   * @param {string} action - Action performed
   * @param {Object} metadata - Additional metadata
   */
  async logInvoiceAccess(invoiceId, organizationId, action, metadata = {}) {
    try {
      const auditEntry = {
        timestamp: new Date(),
        invoiceId,
        organizationId,
        action,
        metadata,
        userAgent: metadata.userAgent || 'system',
        ipAddress: metadata.ipAddress || 'unknown'
      };
      
      // Log to audit collection if it exists
      const auditCollection = this.db.collection('audit_trail');
      await auditCollection.insertOne(auditEntry);
      
    } catch (error) {
      logger.error('Error logging invoice access:', error);
      // Don't throw error as this is non-critical
    }
  }

  /**
   * Get business statistics for an organization
   * @param {string} organizationId - Organization identifier
   * @returns {Object} Business statistics including active businesses, clients, invoices, and revenue
   */
  async getBusinessStatistics(organizationId) {
    try {
      await this.connect();
      
      const invoicesCollection = this.db.collection('invoices');
      const organizationsCollection = this.db.collection('organizations');
      const clientsCollection = this.db.collection('clients');
      
      // Base query for organization
      const orgQuery = { organizationId };
      const activeInvoiceQuery = { 
        organizationId, 
        'deletion.isDeleted': { $ne: true }
      };
      
      // Get active businesses count (organizations)
      const activeBusinesses = await organizationsCollection.countDocuments({
        _id: new ObjectId(organizationId),
        isActive: { $ne: false }
      });
      
      // Get total clients count
      const totalClients = await clientsCollection.countDocuments(orgQuery);
      
      // Get total invoices count
      const totalInvoices = await invoicesCollection.countDocuments(activeInvoiceQuery);
      
      // Calculate total revenue from all invoices
      const revenueAggregation = await invoicesCollection.aggregate([
        { $match: activeInvoiceQuery },
        {
          $group: {
            _id: null,
            totalRevenue: {
              $sum: {
                $cond: {
                  if: { $isNumber: "$totals.grandTotal" },
                  then: "$totals.grandTotal",
                  else: 0
                }
              }
            }
          }
        }
      ]).toArray();
      
      const totalRevenue = revenueAggregation.length > 0 ? revenueAggregation[0].totalRevenue : 0;
      
      // Format revenue for display
      const formattedRevenue = this.formatCurrency(totalRevenue);
      
      const statistics = {
        activeBusinesses: activeBusinesses || 1, // At least 1 if organization exists
        totalClients,
        totalInvoices,
        totalRevenue: formattedRevenue,
        rawRevenue: totalRevenue
      };
      
      logger.info(`Business statistics calculated for organization: ${organizationId}`, {
        organizationId,
        statistics
      });
      
      return {
        success: true,
        data: statistics
      };
      
    } catch (error) {
      logger.error('Error calculating business statistics:', error);
      return {
        success: false,
        error: 'Failed to calculate business statistics',
        details: error.message
      };
    }
  }

  /**
   * Format currency value for display
   * @param {number} amount - Amount to format
   * @returns {string} Formatted currency string
   */
  formatCurrency(amount) {
    if (amount >= 1000000) {
      return `₹${(amount / 1000000).toFixed(1)}M`;
    } else if (amount >= 1000) {
      return `₹${(amount / 1000).toFixed(1)}k`;
    } else {
      return `₹${amount.toFixed(0)}`;
    }
  }
}

module.exports = { InvoiceManagementService };