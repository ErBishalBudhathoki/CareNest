const { MongoClient, ServerApiVersion } = require('mongodb');
const logger = require('../config/logger');
const uri = process.env.MONGODB_URI;

class EmployeeTrackingService {
  /**
   * Get comprehensive employee tracking data for an organization
   * @param {string} organizationId - The organization ID
   * @returns {Object} Employee tracking data
   */
  static async getEmployeeTrackingData(organizationId) {
    let client;
    
    try {
      if (!organizationId) {
        throw new Error('Organization ID is required');
      }
      
      // Connect to MongoDB
      client = await MongoClient.connect(uri, {
        serverApi: ServerApiVersion.v1
      });
      
      const db = client.db("Invoice");
      
      // Get all active assignments for the organization
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
            from: "login",
            localField: "userEmail",
            foreignField: "email",
            as: "userDetails"
          }
        },
        {
          $unwind: "$userDetails"
        }
      ]).toArray();
      
      // If no assignments found, get employees directly from login collection
      let employeesFromLogin = [];
      if (assignments.length === 0) {
        employeesFromLogin = await db.collection("login").find({
          organizationId: organizationId,
          isActive: true
        }).toArray();
        
        // Transform login collection data to match assignment structure
        employeesFromLogin.forEach(employee => {
          assignments.push({
            assignmentId: employee._id.toString(),
            userEmail: employee.email,
            userName: `${employee.firstName} ${employee.lastName}`,
            organizationId: employee.organizationId,
            clientEmail: null,
            clientAddress: null,
            isActive: true,
            createdAt: employee.createdAt,
            userDetails: {
              name: `${employee.firstName} ${employee.lastName}`,
              firstName: employee.firstName,
              lastName: employee.lastName,
              email: employee.email,
              profileImage: employee.photoData || employee.profileImage
            },
            clientDetails: null
          });
        });
      }
      
      // Get worked time records for the organization
      const workedTimeRecords = await db.collection("workedTime").aggregate([
        {
          $lookup: {
            from: "clientAssignments",
            localField: "assignedClientId",
            foreignField: "_id",
            as: "assignmentDetails"
          }
        },
        {
          $unwind: {
            path: "$assignmentDetails",
            preserveNullAndEmptyArrays: true
          }
        },
        {
          $match: {
            $or: [
              { "assignmentDetails.organizationId": organizationId },
              { organizationId: organizationId }
            ]
          }
        },
        {
          $lookup: {
            from: "login",
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
          $sort: { startTime: -1 }
        }
      ]).toArray();
      
      // Get active timers for the organization
      const activeTimers = await db.collection("activeTimers").aggregate([
        {
          $match: {
            organizationId: organizationId
          }
        },
        {
          $lookup: {
            from: "login",
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
        }
      ]).toArray();
      
      // Calculate current working time for active timers
      const currentTime = new Date();
      const activeTimersWithDuration = activeTimers.map(timer => {
        const startTime = new Date(timer.startTime);
        const durationMs = currentTime - startTime;
        const hours = Math.floor(durationMs / (1000 * 60 * 60));
        const minutes = Math.floor((durationMs % (1000 * 60 * 60)) / (1000 * 60));
        
        return {
          ...timer,
          currentWorkingTime: `${hours}h ${minutes}m`,
          durationMs: durationMs
        };
      });
      
      // Group employees by their current status
      const employeeMap = new Map();
      
      // Add all employees from assignments
      assignments.forEach(assignment => {
        const userEmail = assignment.userEmail;
        if (!employeeMap.has(userEmail)) {
          employeeMap.set(userEmail, {
            userEmail: userEmail,
            userName: assignment.userDetails?.name || assignment.userName || 'Unknown',
            profileImage: assignment.userDetails?.profileImage || assignment.userDetails?.photoData,
            isCurrentlyWorking: false,
            currentTimer: null,
            assignments: [],
            recentShifts: []
          });
        }
        
        const employee = employeeMap.get(userEmail);
        employee.assignments.push(assignment);
      });
      
      // Add active timer information
      activeTimersWithDuration.forEach(timer => {
        const userEmail = timer.userEmail;
        if (!employeeMap.has(userEmail)) {
          employeeMap.set(userEmail, {
            userEmail: userEmail,
            userName: timer.userDetails?.name || `${timer.userDetails?.firstName} ${timer.userDetails?.lastName}` || 'Unknown',
            profileImage: timer.userDetails?.profileImage || timer.userDetails?.photoData,
            isCurrentlyWorking: true,
            currentTimer: timer,
            assignments: [],
            recentShifts: []
          });
        } else {
          const employee = employeeMap.get(userEmail);
          employee.isCurrentlyWorking = true;
          employee.currentTimer = timer;
        }
      });
      
      // Add recent shifts information
      workedTimeRecords.forEach(record => {
        const userEmail = record.userEmail;
        if (employeeMap.has(userEmail)) {
          const employee = employeeMap.get(userEmail);
          employee.recentShifts.push(record);
        }
      });
      
      // Convert map to array
      const employees = Array.from(employeeMap.values());
      
      // Separate currently working and not working employees
      const currentlyWorking = employees.filter(emp => emp.isCurrentlyWorking);
      const notCurrentlyWorking = employees.filter(emp => !emp.isCurrentlyWorking);
      
      return {
        organizationId: organizationId,
        totalEmployees: employees.length,
        currentlyWorking: currentlyWorking,
        notCurrentlyWorking: notCurrentlyWorking,
        allEmployees: employees,
        activeTimers: activeTimersWithDuration,
        recentShifts: workedTimeRecords.slice(0, 50), // Limit to 50 most recent
        summary: {
          totalActiveTimers: activeTimers.length,
          totalRecentShifts: workedTimeRecords.length,
          totalAssignments: assignments.length
        }
      };
      
    } catch (error) {
      logger.error('Error in EmployeeTrackingService.getEmployeeTrackingData', {
        error: error.message,
        stack: error.stack,
        organizationId
      });
      throw error;
    } finally {
      if (client) {
        await client.close();
      }
    }
  }
}

module.exports = EmployeeTrackingService;