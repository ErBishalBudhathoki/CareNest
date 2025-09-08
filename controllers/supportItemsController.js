const supportItemsService = require('../services/supportItemsService');
const logger = require('../config/logger');

class SupportItemsController {
  /**
   * Search support items
   * GET /api/support-items/search?q=...
   */
  async searchSupportItems(req, res) {
    try {
      const searchQuery = req.query.q;
      
      if (!searchQuery) {
        return res.status(400).json({ 
          success: false, 
          message: 'Missing search query' 
        });
      }
      
      const items = await supportItemsService.searchSupportItems(searchQuery);
      
      res.json({ 
        success: true, 
        items 
      });
      
    } catch (error) {
      logger.error('Error searching for support items', {
      error: error.message,
      stack: error.stack,
      searchQuery: req.query.q
    });
      res.status(500).json({ 
        success: false, 
        message: 'Error searching for support items.' 
      });
    }
  }
  
  /**
   * Get all support items
   * GET /api/support-items/all
   */
  async getAllSupportItems(req, res) {
    try {
      const items = await supportItemsService.getAllSupportItems();
      
      res.json({ 
        success: true, 
        items 
      });
      
    } catch (error) {
      logger.error('Error fetching all support items', {
      error: error.message,
      stack: error.stack
    });
      res.status(500).json({ 
        success: false, 
        message: 'Error fetching all support items.' 
      });
    }
  }
}

module.exports = new SupportItemsController();