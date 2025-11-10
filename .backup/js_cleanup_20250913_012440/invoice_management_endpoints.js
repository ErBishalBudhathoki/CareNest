const InvoiceManagementService = require('./services/invoiceManagementService');
const logger = require('./logger');

// Initialize the service
const invoiceManagementService = new InvoiceManagementService();

/**
 * Get list of invoices for an organization
 */
async function getInvoicesList(req, res) {
    try {
        const { organizationId } = req.params;
        const { page = 1, limit = 10, status, search } = req.query;
        
        if (!organizationId) {
            return res.status(400).json({ 
                success: false, 
                message: 'Organization ID is required' 
            });
        }

        const options = {
            page: parseInt(page),
            limit: parseInt(limit),
            status,
            search
        };

        const result = await invoiceManagementService.getInvoicesList(organizationId, options);

        res.json({
            success: true,
            data: result.invoices,
            pagination: {
                currentPage: result.currentPage,
                totalPages: result.totalPages,
                totalCount: result.totalCount,
                hasNext: result.hasNext,
                hasPrev: result.hasPrev
            }
        });

    } catch (error) {
        logger.error('Error getting invoices list:', error);
        res.status(500).json({ 
            success: false, 
            message: 'Internal server error' 
        });
    }
}

/**
 * Get details of a specific invoice
 */
async function getInvoiceDetails(req, res) {
    try {
        const { invoiceId } = req.params;
        
        if (!invoiceId) {
            return res.status(400).json({ 
                success: false, 
                message: 'Invoice ID is required' 
            });
        }

        const result = await invoiceManagementService.getInvoiceDetails(invoiceId, req.query.organizationId || req.body.organizationId);
        
        if (!result.success) {
            return res.status(404).json({ 
                success: false, 
                message: result.error || 'Invoice not found' 
            });
        }
        
        const invoice = result.data;

        if (!invoice) {
            return res.status(404).json({ 
                success: false, 
                message: 'Invoice not found' 
            });
        }

        res.json({
            success: true,
            data: invoice
        });

    } catch (error) {
        logger.error('Error getting invoice details:', error);
        res.status(500).json({ 
            success: false, 
            message: 'Internal server error' 
        });
    }
}

/**
 * Share an invoice (generate shareable link or send email)
 */
async function shareInvoice(req, res) {
    try {
        const { invoiceId } = req.params;
        const { method, email, expiresIn } = req.body;
        
        if (!invoiceId) {
            return res.status(400).json({ 
                success: false, 
                message: 'Invoice ID is required' 
            });
        }

        const shareResult = await invoiceManagementService.shareInvoice(invoiceId, {
            method,
            email,
            expiresIn
        });

        res.json({
            success: true,
            data: shareResult
        });

    } catch (error) {
        logger.error('Error sharing invoice:', error);
        res.status(500).json({ 
            success: false, 
            message: 'Internal server error' 
        });
    }
}

/**
 * Delete an invoice (soft delete)
 */
async function deleteInvoice(req, res) {
    try {
        const { invoiceId } = req.params;
        
        if (!invoiceId) {
            return res.status(400).json({ 
                success: false, 
                message: 'Invoice ID is required' 
            });
        }

        const result = await invoiceManagementService.deleteInvoice(invoiceId);

        res.json({
            success: true,
            message: 'Invoice deleted successfully',
            data: result
        });

    } catch (error) {
        logger.error('Error deleting invoice:', error);
        res.status(500).json({ 
            success: false, 
            message: 'Internal server error' 
        });
    }
}

/**
 * Get invoice statistics for an organization
 */
async function getInvoiceStats(req, res) {
    try {
        const { organizationId } = req.params;
        
        if (!organizationId) {
            return res.status(400).json({ 
                success: false, 
                message: 'Organization ID is required' 
            });
        }

        const stats = await invoiceManagementService.getInvoiceStats(organizationId);

        res.json({
            success: true,
            data: stats
        });

    } catch (error) {
        logger.error('Error getting invoice stats:', error);
        res.status(500).json({ 
            success: false, 
            message: 'Internal server error' 
        });
    }
}

module.exports = {
    getInvoicesList,
    getInvoiceDetails,
    shareInvoice,
    deleteInvoice,
    getInvoiceStats
};