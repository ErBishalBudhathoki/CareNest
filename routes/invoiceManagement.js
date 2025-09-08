const express = require('express');
const router = express.Router();
const {
  getInvoicesList,
  getInvoiceDetails,
  shareInvoice,
  deleteInvoice,
  getInvoiceStats,
  createInvoice
} = require('../endpoints/invoice_management_endpoints');

// Create a new invoice
router.post('/api/invoices', createInvoice);

// Get list of invoices for an organization
router.get('/api/invoices', getInvoicesList);

// Get details of a specific invoice
router.get('/api/invoices/:invoiceId', getInvoiceDetails);

// Share an invoice
router.post('/api/invoices/:invoiceId/share', shareInvoice);

// Share an invoice as PDF
router.post('/api/invoices/:invoiceId/share/pdf', shareInvoice);

// Delete an invoice
router.delete('/api/invoices/:invoiceId', deleteInvoice);

// Get invoice statistics
router.get('/api/invoices/stats', getInvoiceStats);

module.exports = router;