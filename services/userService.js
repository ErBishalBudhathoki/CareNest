const { MongoClient, ServerApiVersion } = require('mongodb');

class UserService {
  constructor() {
    this.uri = process.env.MONGODB_URI;
  }

  async getConnection() {
    const client = new MongoClient(this.uri, {
      serverApi: ServerApiVersion.v1
    });
    await client.connect();
    return client;
  }

  /**
   * Get all users
   */
  async getAllUsers() {
    let client;
    try {
      client = await this.getConnection();
      const db = client.db("Invoice");
      
      const users = await db.collection("login").find({}).toArray();
      
      if (!users || users.length === 0) {
        return [];
      }
      
      // Map the users to the expected format
      const formattedUsers = users.map(user => ({
        firstName: user.firstName || "",
        lastName: user.lastName || "",
        email: user.email || "",
        password: user.password || ""
      }));
      
      return formattedUsers;
    } finally {
      if (client) {
        await client.close();
      }
    }
  }

  /**
   * Get all employees for a specific organization
   */
  async getOrganizationEmployees(organizationId) {
    let client;
    try {
      client = await this.getConnection();
      const db = client.db("Invoice");
      
      const employees = await db.collection("login").find({
        organizationId: organizationId,
        isActive: true
      }).project({
        password: 0, // Exclude sensitive fields
        salt: 0
      }).toArray();
      
      return employees;
    } finally {
      if (client) {
        await client.close();
      }
    }
  }

  /**
   * Fix client organizationId for existing records
   */
  async fixClientOrganizationId(userEmail, organizationId) {
    let client;
    try {
      client = await this.getConnection();
      const db = client.db("Invoice");
      
      // Verify user belongs to organization
      const user = await db.collection("login").findOne({
        email: userEmail,
        organizationId: organizationId,
        isActive: true
      });
      
      if (!user) {
        throw new Error('User not authorized for this organization');
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
      
      return {
        clientsUpdated: clientUpdateResult.modifiedCount,
        assignmentsUpdated: assignmentUpdateResult.modifiedCount
      };
    } finally {
      if (client) {
        await client.close();
      }
    }
  }
}

module.exports = new UserService();