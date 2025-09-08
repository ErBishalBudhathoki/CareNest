const { getDatabase } = require('../config/database');

class SupportItemsService {
  /**
   * Search support items by text query
   */
  async searchSupportItems(searchQuery) {
    const db = await getDatabase();
    
    // Ensure text index exists (run once, then comment out for prod)
    // await db.collection('supportItems').createIndex({ supportItemName: 'text', supportItemNumber: 'text' });
    
    const items = await db.collection('supportItems')
      .find({ $text: { $search: searchQuery } })
      .limit(20)
      .toArray();
      
    return items;
  }
  
  /**
   * Get all support items
   */
  async getAllSupportItems() {
    const db = await getDatabase();
    
    const items = await db.collection('supportItems')
      .find({})
      .limit(1000)
      .toArray();
      
    return items;
  }
}

module.exports = new SupportItemsService();