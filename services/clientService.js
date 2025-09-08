const { MongoClient, ObjectId } = require('mongodb');
const { processCustomPricing } = require('../utils/pricingHelpers');
const auditService = require('./auditService');

class ClientService {
  constructor() {
    this.uri = process.env.MONGODB_URI;
  }

  async addClient(clientData) {
    const { 
      clientFirstName, 
      clientLastName, 
      clientEmail, 
      clientPhone, 
      clientAddress, 
      clientCity, 
      clientState, 
      clientZip, 
      businessName,
      organizationId,
      userEmail 
    } = clientData;

    const client = new MongoClient(this.uri);
    try {
      await client.connect();
      const db = client.db("Invoice");
      
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
      
      // Create client document with organization context
      const clientDoc = {
        clientFirstName,
        clientLastName,
        clientEmail,
        clientPhone,
        clientAddress,
        clientCity,
        clientState,
        clientZip,
        businessName,
        organizationId: organizationId || null,
        createdAt: new Date(),
        updatedAt: new Date(),
        isActive: true
      };
      
      const result = await db.collection("clients").insertOne(clientDoc);
      
      // Log audit trail
      if (userEmail) {
        await auditService.logAction({
          userEmail,
          action: 'CLIENT_CREATED',
          details: {
            clientId: result.insertedId,
            clientName: `${clientFirstName} ${clientLastName}`,
            organizationId
          },
          timestamp: new Date()
        });
      }
      
      return {
        success: true,
        clientId: result.insertedId,
        message: "Client added successfully"
      };
      
    } finally {
      await client.close();
    }
  }

  async getClients(organizationId, userEmail) {
    const client = new MongoClient(this.uri);
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      // Verify user belongs to organization
      if (organizationId && userEmail) {
        const user = await db.collection("login").findOne({ 
          email: userEmail,
          organizationId: organizationId 
        });
        
        if (!user) {
          throw new Error('User not authorized for this organization');
        }
      }
      
      const query = { isActive: true };
      if (organizationId) {
        query.organizationId = organizationId;
      }
      
      const clients = await db.collection("clients").find(query).toArray();
      
      return {
        success: true,
        clients
      };
      
    } finally {
      await client.close();
    }
  }

  async getClientById(clientId, organizationId, userEmail) {
    const client = new MongoClient(this.uri);
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      // Verify user belongs to organization
      if (organizationId && userEmail) {
        const user = await db.collection("login").findOne({ 
          email: userEmail,
          organizationId: organizationId 
        });
        
        if (!user) {
          throw new Error('User not authorized for this organization');
        }
      }
      
      const query = { 
        _id: new ObjectId(clientId),
        isActive: true
      };
      
      if (organizationId) {
        query.organizationId = organizationId;
      }
      
      const clientDoc = await db.collection("clients").findOne(query);
      
      if (!clientDoc) {
        throw new Error('Client not found');
      }
      
      return {
        success: true,
        client: clientDoc
      };
      
    } finally {
      await client.close();
    }
  }

  async updateClient(clientId, updateData, organizationId, userEmail) {
    const client = new MongoClient(this.uri);
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      // Verify user belongs to organization
      if (organizationId && userEmail) {
        const user = await db.collection("login").findOne({ 
          email: userEmail,
          organizationId: organizationId 
        });
        
        if (!user) {
          throw new Error('User not authorized for this organization');
        }
      }
      
      const query = { 
        _id: new ObjectId(clientId),
        isActive: true
      };
      
      if (organizationId) {
        query.organizationId = organizationId;
      }
      
      const updateDoc = {
        ...updateData,
        updatedAt: new Date()
      };
      
      const result = await db.collection("clients").updateOne(
        query,
        { $set: updateDoc }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('Client not found');
      }
      
      // Log audit trail
      if (userEmail) {
        await auditService.logAction({
          userEmail,
          action: 'CLIENT_UPDATED',
          details: {
            clientId,
            organizationId,
            updatedFields: Object.keys(updateData)
          },
          timestamp: new Date()
        });
      }
      
      return {
        success: true,
        message: "Client updated successfully"
      };
      
    } finally {
      await client.close();
    }
  }

  async deleteClient(clientId, organizationId, userEmail) {
    const client = new MongoClient(this.uri);
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      // Verify user belongs to organization
      if (organizationId && userEmail) {
        const user = await db.collection("login").findOne({ 
          email: userEmail,
          organizationId: organizationId 
        });
        
        if (!user) {
          throw new Error('User not authorized for this organization');
        }
      }
      
      const query = { 
        _id: new ObjectId(clientId),
        isActive: true
      };
      
      if (organizationId) {
        query.organizationId = organizationId;
      }
      
      const result = await db.collection("clients").updateOne(
        query,
        { 
          $set: { 
            isActive: false,
            deletedAt: new Date(),
            updatedAt: new Date()
          }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('Client not found');
      }
      
      // Log audit trail
      if (userEmail) {
        await auditService.logAction({
          userEmail,
          action: 'CLIENT_DELETED',
          details: {
            clientId,
            organizationId
          },
          timestamp: new Date()
        });
      }
      
      return {
        success: true,
        message: "Client deleted successfully"
      };
      
    } finally {
      await client.close();
    }
  }

  async getClientPricing(clientId, organizationId, userEmail) {
    const client = new MongoClient(this.uri);
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      // Verify user belongs to organization
      if (organizationId && userEmail) {
        const user = await db.collection("login").findOne({ 
          email: userEmail,
          organizationId: organizationId 
        });
        
        if (!user) {
          throw new Error('User not authorized for this organization');
        }
      }
      
      const query = { 
        clientId: new ObjectId(clientId),
        isActive: true
      };
      
      if (organizationId) {
        query.organizationId = organizationId;
      }
      
      const pricing = await db.collection("custom_pricing").find(query).toArray();
      
      return {
        success: true,
        pricing
      };
      
    } finally {
      await client.close();
    }
  }

  async updateClientPricing(clientId, pricingData, organizationId, userEmail) {
    const client = new MongoClient(this.uri);
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      // Verify user belongs to organization
      if (organizationId && userEmail) {
        const user = await db.collection("login").findOne({ 
          email: userEmail,
          organizationId: organizationId 
        });
        
        if (!user) {
          throw new Error('User not authorized for this organization');
        }
      }
      
      // Process custom pricing
      const processedPricing = await processCustomPricing(pricingData, clientId, organizationId);
      
      // Log audit trail
      if (userEmail) {
        await auditService.logAction({
          userEmail,
          action: 'CLIENT_PRICING_UPDATED',
          details: {
            clientId,
            organizationId,
            pricingCount: processedPricing.length
          },
          timestamp: new Date()
        });
      }
      
      return {
        success: true,
        message: "Client pricing updated successfully",
        pricing: processedPricing
      };
      
    } finally {
      await client.close();
    }
  }

  async getMultipleClients(emails) {
    const client = new MongoClient(process.env.MONGODB_URI, {
      serverApi: ServerApiVersion.v1
    });
    
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      // Split emails if multiple are provided (comma-separated)
      const emailList = emails.split(',').map(email => email.trim());
      
      // Find clients with matching emails
      const clients = await db.collection("clients").find({
        clientEmail: { $in: emailList },
        isActive: true
      }).toArray();
      
      return clients;
    } finally {
      await client.close();
    }
  }

  async assignClientToUser(assignmentData) {
    const client = new MongoClient(process.env.MONGODB_URI, {
      serverApi: ServerApiVersion.v1
    });
    
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      const { 
        userEmail, 
        clientEmail, 
        dateList, 
        startTimeList, 
        endTimeList, 
        breakList, 
        ndisItem, 
        highIntensityList, 
        customPricing, 
        scheduleWithNdisItems 
      } = assignmentData;
      
      // Verify client exists
      const clientExists = await db.collection("clients").findOne({ 
        clientEmail: clientEmail,
        isActive: true
      });

      if (!clientExists) {
        throw new Error('Client not found or inactive');
      }

      // Parse ndisItem if it's a string
      let parsedNdisItem = ndisItem;
      if (typeof ndisItem === 'string') {
        try {
          parsedNdisItem = JSON.parse(ndisItem);
        } catch (e) {
          throw new Error('Invalid NDIS item format');
        }
      }

      // Extract customPricing from ndisItem if it exists
      let extractedCustomPricing = customPricing;
      if (parsedNdisItem && parsedNdisItem.customPricing) {
        extractedCustomPricing = parsedNdisItem.customPricing;
        delete parsedNdisItem.customPricing;
      }

      // Parse scheduleWithNdisItems if provided
      let parsedScheduleWithNdisItems = [];
      if (scheduleWithNdisItems && Array.isArray(scheduleWithNdisItems)) {
        for (let i = 0; i < scheduleWithNdisItems.length; i++) {
          let scheduleItem = scheduleWithNdisItems[i];
          if (typeof scheduleItem === 'string') {
            try {
              scheduleItem = JSON.parse(scheduleItem);
            } catch (e) {
              throw new Error(`Invalid schedule item format at index ${i}`);
            }
          }
          parsedScheduleWithNdisItems.push(scheduleItem);
        }
      }

      // Update client with NDIS information
      let clientNdisItem = parsedNdisItem;
      if (parsedScheduleWithNdisItems.length > 0 && parsedScheduleWithNdisItems[0].ndisItem) {
        clientNdisItem = parsedScheduleWithNdisItems[0].ndisItem;
      }
      
      if (clientNdisItem) {
        await db.collection("clients").updateOne(
          { clientEmail: clientEmail },
          { 
            $set: {
              ndisItem: clientNdisItem
            }
          }
        );
      }

      // Get user's organizationId if client doesn't have one
      let organizationId = clientExists.organizationId;
      if (!organizationId) {
        const user = await db.collection("login").findOne({ 
          email: userEmail,
          isActive: true 
        });

        if (user && user.organizationId) {
          organizationId = user.organizationId;
          
          await db.collection("clients").updateOne(
            { _id: clientExists._id },
            { 
              $set: {
                organizationId: organizationId,
                updatedAt: new Date()
              }
            }
          );
        }
      }
      
      // Create assignment data
      const scheduleData = dateList.map((date, i) => {
        let scheduleEntry = {
          date: date,
          startTime: startTimeList[i],
          endTime: endTimeList[i],
          break: breakList[i],
          highIntensity: highIntensityList[i],
        };
        
        if (parsedScheduleWithNdisItems.length > i && parsedScheduleWithNdisItems[i].ndisItem) {
          scheduleEntry.ndisItem = parsedScheduleWithNdisItems[i].ndisItem;
        } else if (parsedNdisItem) {
          scheduleEntry.ndisItem = parsedNdisItem;
        }
        
        return scheduleEntry;
      });
      
      const newAssignmentData = {
        userEmail: userEmail,
        clientEmail: clientEmail,
        clientId: clientExists._id,
        organizationId: organizationId,
        schedule: scheduleData,
        assignedNdisItemNumber: parsedNdisItem?.itemNumber || (parsedScheduleWithNdisItems.length > 0 ? parsedScheduleWithNdisItems[0].ndisItem?.itemNumber : null),
        createdAt: new Date(),
        isActive: true
      };

      // Check if assignment already exists
      const existingAssignment = await db.collection("clientAssignments").findOne({
        userEmail: userEmail,
        clientEmail: clientEmail,
        isActive: true
      });

      let finalAssignmentId;
      if (existingAssignment) {
        // Update existing assignment
        const existingSchedules = existingAssignment.schedule || [];
        const combinedSchedules = [...existingSchedules];
        
        scheduleData.forEach(newSchedule => {
          const conflictingScheduleIndex = combinedSchedules.findIndex(existingSchedule => 
            existingSchedule.date === newSchedule.date &&
            existingSchedule.startTime === newSchedule.startTime &&
            existingSchedule.endTime === newSchedule.endTime
          );
          
          if (conflictingScheduleIndex > -1) {
            combinedSchedules[conflictingScheduleIndex] = newSchedule;
          } else {
            combinedSchedules.push(newSchedule);
          }
        });

        const updateResult = await db.collection("clientAssignments").updateOne(
          { _id: existingAssignment._id },
          { 
            $set: {
              schedule: combinedSchedules,
              updatedAt: new Date()
            }
          }
        );
        
        if (updateResult.matchedCount === 0) {
          throw new Error('Assignment not found for update');
        }
        
        finalAssignmentId = existingAssignment._id;
      } else {
        // Create new assignment
        const insertResult = await db.collection("clientAssignments").insertOne(newAssignmentData);
        
        if (!insertResult.insertedId) {
          throw new Error('Failed to create new assignment');
        }
        
        finalAssignmentId = insertResult.insertedId;
      }
      
      return {
        success: true,
        message: existingAssignment ? 'Assignment updated successfully' : 'Assignment created successfully',
        assignmentId: finalAssignmentId
      };
    } finally {
      await client.close();
    }
  }

  async getUserAssignments(userEmail) {
    const client = new MongoClient(process.env.MONGODB_URI, {
      serverApi: ServerApiVersion.v1
    });
    
    try {
      await client.connect();
      const db = client.db("Invoice");
      
      const assignments = await db.collection("clientAssignments").aggregate([
        {
          $match: {
            userEmail: userEmail,
            isActive: true
          }
        },
        {
          $lookup: {
            from: "clients",
            localField: "clientEmail",
            foreignField: "clientEmail",
            as: "clientDetails"
          }
        },
        {
          $unwind: "$clientDetails"
        }
      ]).toArray();
      
      return assignments;
    } finally {
      await client.close();
    }
  }
}

module.exports = new ClientService();