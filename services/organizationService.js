const { MongoClient, ObjectId } = require('mongodb');
const { generateOrganizationCode } = require('../utils/cryptoHelpers');

class OrganizationService {
  constructor() {
    this.dbName = "Invoice";
  }

  async getDbConnection() {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    return { client, db: client.db(this.dbName) };
  }

  async createOrganization(organizationData) {
    const { client, db } = await this.getDbConnection();
    
    try {
      const { organizationName, ownerEmail, ownerFirstName, ownerLastName } = organizationData;
      
      // Check if organization name already exists
      const existingOrg = await db.collection("organizations").findOne({ 
        name: { $regex: new RegExp(`^${organizationName}$`, 'i') } 
      });
      
      if (existingOrg) {
        throw new Error('Organization name already exists');
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
      
      // Add owner name if provided (for legacy endpoint)
      if (ownerFirstName) organizationDoc.ownerFirstName = ownerFirstName;
      if (ownerLastName) organizationDoc.ownerLastName = ownerLastName;
      
      const result = await db.collection("organizations").insertOne(organizationDoc);
      
      return {
        organizationId: result.insertedId.toString(),
        organizationCode: organizationCode,
        organizationName: organizationName
      };
    } finally {
      await client.close();
    }
  }

  async verifyOrganizationCode(organizationCode) {
    const { client, db } = await this.getDbConnection();
    
    try {
      const organization = await db.collection("organizations").findOne({ 
        code: organizationCode,
        isActive: true 
      });
      
      if (!organization) {
        return null;
      }
      
      return {
        organizationId: organization._id.toString(),
        organizationName: organization.name,
        ownerEmail: organization.ownerEmail
      };
    } finally {
      await client.close();
    }
  }

  async getOrganizationById(organizationId) {
    const { client, db } = await this.getDbConnection();
    
    try {
      const organization = await db.collection("organizations").findOne({ 
        _id: new ObjectId(organizationId) 
      });
      
      if (!organization) {
        return null;
      }
      
      return {
        id: organization._id.toString(),
        name: organization.name,
        code: organization.code,
        ownerEmail: organization.ownerEmail,
        createdAt: organization.createdAt,
        settings: organization.settings
      };
    } finally {
      await client.close();
    }
  }

  async getOrganizationMembers(organizationId) {
    const { client, db } = await this.getDbConnection();
    
    try {
      const members = await db.collection("login").find({ 
        organizationId: organizationId 
      }).project({ 
        password: 0, 
        salt: 0 
      }).toArray();
      
      return members;
    } finally {
      await client.close();
    }
  }

  async getOrganizationBusinesses(organizationId) {
    const { client, db } = await this.getDbConnection();
    
    try {
      const businesses = await db.collection("businesses").find({ 
        organizationId: organizationId,
        isActive: true 
      }).toArray();
      
      return businesses;
    } finally {
      await client.close();
    }
  }

  async getOrganizationClients(organizationId) {
    const { client, db } = await this.getDbConnection();
    
    try {
      const clients = await db.collection("clients").find({ 
        organizationId: organizationId,
        isActive: true 
      }).toArray();
      
      return clients;
    } finally {
      await client.close();
    }
  }

  async getOrganizationEmployees(organizationId) {
    const { client, db } = await this.getDbConnection();
    
    try {
      const employees = await db.collection("login").find({ 
        organizationId: organizationId,
        isActive: true 
      }).project({ 
        password: 0, 
        salt: 0 
      }).toArray();
      
      return employees;
    } finally {
      await client.close();
    }
  }
}

module.exports = new OrganizationService();