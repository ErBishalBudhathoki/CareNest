const express = require('express');
const supportItemsController = require('../controllers/supportItemsController');
const router = express.Router();

/**
 * Search support items
 * GET /api/support-items/search?q=...
 */
router.get('/api/support-items/search', supportItemsController.searchSupportItems);

/**
 * Get all support items
 * GET /api/support-items/all
 */
router.get('/api/support-items/all', supportItemsController.getAllSupportItems);

module.exports = router;