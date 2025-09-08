const { MongoClient, ObjectId, ServerApiVersion } = require('mongodb');
const { getDbConnection } = require('../config/database');
const logger = require('../config/logger');

/**
 * Service for handling appointment-related database operations
 */
class AppointmentService {
  /**
   * Load appointments for a user
   * @param {string} email - User email
   * @returns {Promise<Array>} Array of appointments
   */
  static async loadAppointments(email) {
    let client;
    
    try {
      client = await getDbConnection();
      const db = client.db("Invoice");
      
      // Get appointments (client assignments) with client details
      const appointments = await db.collection("clientAssignments").aggregate([
        {
          $match: {
            userEmail: email,
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
          $unwind: {
            path: "$clientDetails",
            preserveNullAndEmptyArrays: true
          }
        },
        {
          $project: {
            _id: 1,
            userEmail: 1,
            clientEmail: 1,
            organizationId: 1,
            schedule: 1,
            createdAt: 1,
            isActive: 1,
            // Legacy format for compatibility with existing frontend
            dateList: {
              $ifNull: [
                {
                  $map: {
                    input: "$schedule",
                    as: "item",
                    in: "$item.date"
                  }
                },
                "$dateList"
              ]
            },
            startTimeList: {
              $ifNull: [
                {
                  $map: {
                    input: "$schedule",
                    as: "item",
                    in: "$item.startTime"
                  }
                },
                "$startTimeList"
              ]
            },
            endTimeList: {
              $ifNull: [
                {
                  $map: {
                    input: "$schedule",
                    as: "item",
                    in: "$item.endTime"
                  }
                },
                "$endTimeList"
              ]
            },
            breakList: {
              $ifNull: [
                {
                  $map: {
                    input: "$schedule",
                    as: "item",
                    in: "$item.break"
                  }
                },
                "$breakList"
              ]
            },
            clientDetails: 1
          }
        },
        {
          $sort: {
            createdAt: -1
          }
        }
      ]).toArray();
      
      return appointments;
    } catch (error) {
      logger.error('Appointments load failed', {
        error: error.message,
        stack: error.stack,
        email
      });
      throw new Error('Failed to load appointments');
    } finally {
      if (client) {
        await client.close();
      }
    }
  }

  /**
   * Get appointment details for a specific user and client
   * @param {string} userEmail - User email
   * @param {string} clientEmail - Client email
   * @returns {Promise<Object>} Appointment details
   */
  static async loadAppointmentDetails(userEmail, clientEmail) {
    let client;
    
    try {
      client = await getDbConnection();
      const db = client.db("Invoice");
      
      // Get the specific appointment assignment with client details
      const appointmentDetails = await db.collection("clientAssignments").aggregate([
        {
          $match: {
            userEmail: userEmail,
            clientEmail: clientEmail,
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
          $unwind: {
            path: "$clientDetails",
            preserveNullAndEmptyArrays: true
          }
        },
        {
          $project: {
            _id: 1,
            userEmail: 1,
            clientEmail: 1,
            organizationId: 1,
            schedule: 1,
            createdAt: 1,
            isActive: 1,
            // Legacy format for compatibility with existing frontend
            dateList: {
              $ifNull: [
                {
                  $map: {
                    input: "$schedule",
                    as: "item",
                    in: "$item.date"
                  }
                },
                "$dateList"
              ]
            },
            startTimeList: {
              $ifNull: [
                {
                  $map: {
                    input: "$schedule",
                    as: "item",
                    in: "$item.startTime"
                  }
                },
                "$startTimeList"
              ]
            },
            endTimeList: {
              $ifNull: [
                {
                  $map: {
                    input: "$schedule",
                    as: "item",
                    in: "$item.endTime"
                  }
                },
                "$endTimeList"
              ]
            },
            breakList: {
              $ifNull: [
                {
                  $map: {
                    input: "$schedule",
                    as: "item",
                    in: "$item.break"
                  }
                },
                "$breakList"
              ]
            },
            clientDetails: 1
          }
        }
      ]).toArray();
      
      if (appointmentDetails.length === 0) {
        throw new Error('No appointment found for this user-client combination');
      }
      
      const appointment = appointmentDetails[0];
      
      return {
        assignedClient: appointment,
        clientDetails: [appointment.clientDetails]
      };
    } catch (error) {
      logger.error('Appointment details load failed', {
        error: error.message,
        stack: error.stack,
        userEmail,
        clientEmail
      });
      throw error;
    } finally {
      if (client) {
        await client.close();
      }
    }
  }

  /**
   * Get all assignments for an organization
   * @param {string} organizationId - Organization ID
   * @returns {Promise<Array>} Array of assignments
   */
  static async getOrganizationAssignments(organizationId) {
    let client;
    
    try {
      client = await getDbConnection();
      const db = client.db("Invoice");
      
      // Get assignments with client details for the organization
      const assignments = await db.collection("clientAssignments").aggregate([
        {
          $match: {
            organizationId: organizationId,
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
        },
        {
          $lookup: {
            from: "users",
            localField: "userEmail",
            foreignField: "email",
            as: "userDetails"
          }
        },
        {
          $unwind: {
            path: "$userDetails",
            preserveNullAndEmptyArrays: true
          }
        },
        {
          $project: {
            _id: 1,
            userEmail: 1,
            clientEmail: 1,
            organizationId: 1,
            schedule: 1,
            createdAt: 1,
            isActive: 1,
            // Legacy format for compatibility
            dateList: {
              $map: {
                input: "$schedule",
                as: "item",
                in: "$item.date"
              }
            },
            startTimeList: {
              $map: {
                input: "$schedule",
                as: "item",
                in: "$item.startTime"
              }
            },
            endTimeList: {
              $map: {
                input: "$schedule",
                as: "item",
                in: "$item.endTime"
              }
            },
            breakList: {
              $map: {
                input: "$schedule",
                as: "item",
                in: "$item.break"
              }
            },
            clientDetails: 1,
            userDetails: 1
          }
        },
        {
          $sort: {
            createdAt: -1
          }
        }
      ]).toArray();
      
      return assignments;
    } catch (error) {
      logger.error('Organization assignments fetch failed', {
        error: error.message,
        stack: error.stack,
        organizationId
      });
      throw new Error('Failed to get organization assignments');
    } finally {
      if (client) {
        await client.close();
      }
    }
  }

  /**
   * Remove client assignment (soft delete)
   * @param {string} userEmail - User email
   * @param {string} clientEmail - Client email
   * @returns {Promise<Object>} Result of the operation
   */
  static async removeClientAssignment(userEmail, clientEmail) {
    let client;
    
    try {
      client = await getDbConnection();
      const db = client.db("Invoice");
      
      // Soft delete assignment
      const result = await db.collection("clientAssignments").updateOne(
        {
          userEmail: userEmail,
          clientEmail: clientEmail,
          isActive: true
        },
        {
          $set: {
            isActive: false,
            deletedAt: new Date()
          }
        }
      );
      
      if (result.matchedCount === 0) {
        throw new Error('Assignment not found');
      }
      
      return { success: true, message: 'Assignment removed successfully' };
    } catch (error) {
      logger.error('Client assignment removal failed', {
        error: error.message,
        stack: error.stack,
        userEmail,
        clientEmail
      });
      throw error;
    } finally {
      if (client) {
        await client.close();
      }
    }
  }

  /**
   * Set worked time for a client
   * @param {Object} workedTimeData - Worked time data
   * @returns {Promise<Object>} Result of the operation
   */
  static async setWorkedTime(workedTimeData) {
    let client;
    
    try {
      const {
        userEmail,
        clientEmail,
        timeList,
        shiftIndex
      } = workedTimeData;
      
      // Validate required fields
      if (!userEmail || !clientEmail || !timeList) {
        throw new Error('Missing required fields: userEmail, clientEmail, timeList');
      }
      
      client = await getDbConnection();
      const db = client.db("Invoice");
      
      // Find the assigned client record
      const assignedClient = await db.collection("clientAssignments").findOne({
        userEmail: userEmail,
        clientEmail: clientEmail,
        isActive: true
      });
      
      if (!assignedClient) {
        throw new Error('Assigned client not found');
      }
      
      // Get shift details from the assigned client record
      let shiftDate = null;
      let shiftStartTime = null;
      let shiftEndTime = null;
      let shiftBreak = null;
      
      // Extract shift details based on shiftIndex
      if (assignedClient.schedule && assignedClient.schedule.length > shiftIndex) {
        // Use new schedule array format
        const shift = assignedClient.schedule[shiftIndex];
        shiftDate = shift.date;
        shiftStartTime = shift.startTime;
        shiftEndTime = shift.endTime;
        shiftBreak = shift.break;
      } else if (assignedClient.dateList && assignedClient.dateList.length > shiftIndex) {
        // Fallback to legacy format
        shiftDate = assignedClient.dateList[shiftIndex];
        shiftStartTime = assignedClient.startTimeList ? assignedClient.startTimeList[shiftIndex] : null;
        shiftEndTime = assignedClient.endTimeList ? assignedClient.endTimeList[shiftIndex] : null;
        shiftBreak = assignedClient.breakList ? assignedClient.breakList[shiftIndex] : null;
      }
      
      // Create worked time record with specific shift details
      const workedTimeRecord = {
        userEmail: userEmail,
        clientEmail: clientEmail,
        timeWorked: timeList,
        shiftIndex: shiftIndex || 0,
        assignedClientId: assignedClient._id,
        // Add specific shift details for better linking
        shiftDate: shiftDate,
        shiftStartTime: shiftStartTime,
        shiftEndTime: shiftEndTime,
        shiftBreak: shiftBreak,
        // Create a unique shift identifier
        shiftKey: shiftDate && shiftStartTime ? `${shiftDate}_${shiftStartTime}` : null,
        createdAt: new Date(),
        isActive: true
      };
      
      // Insert the worked time record
      const result = await db.collection("workedTime").insertOne(workedTimeRecord);
      
      return {
        success: true,
        message: 'Worked time saved successfully',
        data: {
          id: result.insertedId,
          timeWorked: timeList
        }
      };
    } catch (error) {
      logger.error('Worked time setting failed', {
        error: error.message,
        stack: error.stack,
        userEmail: workedTimeData?.userEmail,
        clientEmail: workedTimeData?.clientEmail
      });
      throw error;
    } finally {
      if (client) {
        await client.close();
      }
    }
  }
}

module.exports = AppointmentService;