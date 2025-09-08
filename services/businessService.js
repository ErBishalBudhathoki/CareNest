const { MongoClient, ObjectId } = require('mongodb');
const { getDatabase } = require('../config/database');

class BusinessService {
  /**
   * Add a new business with organization context
   */
  async addBusiness(businessData) {
    const db = await getDatabase();
    
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
    } = businessData;
    
    // Verify user belongs to organization (if organizationId provided)
    if (organizationId && userEmail) {
      const user = await db.collection("login").findOne({ 
        email: userEmail,
        organizationId: organizationId 
      });
      
      if (!user) {
        throw new Error('User not authorized for this organization');
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
      throw new Error('Business with this name and email already exists');
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
    return result.insertedId.toString();
  }
  
  /**
   * Get businesses for organization
   */
  async getBusinessesByOrganization(organizationId) {
    const db = await getDatabase();
    
    const businesses = await db.collection("businesses").find({ 
      organizationId: organizationId,
      isActive: true 
    }).toArray();
    
    return businesses;
  }
}

module.exports = new BusinessService();