const express = require('express');
const router = express.Router();
const { ObjectId } = require('mongodb');
const logger = require('../config/logger');
const {
  createExpense,
  getExpenseCategories,
  getOrganizationExpenses,
  getExpenseById,
  updateExpense,
  deleteExpense,
  updateExpenseApproval,
  bulkImportExpenses
} = require('../services/expenseService');

// Create a new expense
router.post('/api/expenses/create', async (req, res) => {
  try {
    const result = await createExpense(req.body);
    res.json(result);
  } catch (error) {
    logger.error('Expense creation failed', {
      error: error.message,
      stack: error.stack,
      expenseData: req.body
    });
    res.status(500).json({ error: 'Failed to create expense' });
  }
});

// Get expense categories
router.get('/api/expenses/categories', async (req, res) => {
  try {
    const categories = await getExpenseCategories();
    res.json(categories);
  } catch (error) {
    logger.error('Expense categories fetch failed', {
      error: error.message,
      stack: error.stack
    });
    res.status(500).json({ error: 'Failed to fetch expense categories' });
  }
});

// Get expenses for an organization
router.get('/api/expenses/organization/:organizationId', async (req, res) => {
  try {
    const { organizationId } = req.params;
    const { page = 1, limit = 50, status, category, startDate, endDate } = req.query;
    
    const result = await getOrganizationExpenses(organizationId, {
      page: parseInt(page),
      limit: parseInt(limit),
      status,
      category,
      startDate,
      endDate
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Organization expenses fetch failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      page,
      limit,
      status,
      category,
      startDate,
      endDate
    });
    res.status(500).json({ error: 'Failed to fetch organization expenses' });
  }
});

// Get expense by ID
router.get('/api/expenses/:expenseId', async (req, res) => {
  try {
    const { expenseId } = req.params;
    const expense = await getExpenseById(expenseId);
    
    if (!expense) {
      return res.status(404).json({ error: 'Expense not found' });
    }
    
    res.json(expense);
  } catch (error) {
    logger.error('Expense fetch failed', {
      error: error.message,
      stack: error.stack,
      expenseId
    });
    res.status(500).json({ error: 'Failed to fetch expense' });
  }
});

// Update expense
router.put('/api/expenses/:expenseId', async (req, res) => {
  try {
    const { expenseId } = req.params;
    const result = await updateExpense(expenseId, req.body);
    res.json(result);
  } catch (error) {
    logger.error('Expense update failed', {
      error: error.message,
      stack: error.stack,
      expenseId,
      updateData: req.body
    });
    res.status(500).json({ error: 'Failed to update expense' });
  }
});

// Delete expense
router.delete('/api/expenses/:expenseId', async (req, res) => {
  try {
    const { expenseId } = req.params;
    const result = await deleteExpense(expenseId);
    res.json(result);
  } catch (error) {
    logger.error('Expense deletion failed', {
      error: error.message,
      stack: error.stack,
      expenseId
    });
    res.status(500).json({ error: 'Failed to delete expense' });
  }
});

// Update expense approval status
router.put('/api/expenses/:expenseId/approval', async (req, res) => {
  try {
    const { expenseId } = req.params;
    const { status, approvedBy, approvalNotes } = req.body;
    
    const result = await updateExpenseApproval(expenseId, {
      status,
      approvedBy,
      approvalNotes
    });
    
    res.json(result);
  } catch (error) {
    logger.error('Expense approval update failed', {
      error: error.message,
      stack: error.stack,
      expenseId,
      status,
      approvedBy
    });
    res.status(500).json({ error: 'Failed to update expense approval' });
  }
});

// Bulk import expenses
router.post('/api/expenses/bulk-import', async (req, res) => {
  try {
    const { expenses, organizationId } = req.body;
    const result = await bulkImportExpenses(expenses, organizationId);
    res.json(result);
  } catch (error) {
    logger.error('Bulk expense import failed', {
      error: error.message,
      stack: error.stack,
      organizationId,
      expenseCount: expenses?.length
    });
    res.status(500).json({ error: 'Failed to bulk import expenses' });
  }
});

module.exports = router;