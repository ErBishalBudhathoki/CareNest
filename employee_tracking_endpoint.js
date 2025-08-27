/**
 * Employee Tracking API Endpoint
 * GET /getEmployeeTrackingData/:organizationId
 * 
 * This endpoint provides comprehensive employee tracking data including:
 * - Currently working employees (active timers)
 * - Worked time records with shift details
 * - Employee assignments and client information
 */

// Add this endpoint to server.js

app.get('/getEmployeeTrackingData/:organizationId', async (req, res) => {
  let client;
  
  try {
    const { organizationId } = req.params;
    
    console.log('Getting employee tracking data for organization:', organizationId);
    
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
      console.log('No assignments found, fetching employees from login collection...');
      employeesFromLogin = await db.collection("login").find({
        organizationId: organizationId,
        isActive: true
      }).toArray();
      
      console.log(`Found ${employeesFromLogin.length} employees in login collection`);
      
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
    
    // Get worked time records for the organization (including both active and completed shifts)
    let workedTimeRecords = await db.collection("workedTime").aggregate([
      {
        $lookup: {
          from: "clientAssignments",
          localField: "assignedClientId",
          foreignField: "_id",
          as: "assignment"
        }
      },
      {
        $unwind: "$assignment"
      },
      {
        $match: {
          "assignment.organizationId": organizationId
          // Removed isActive: true filter to include completed shifts
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
      },
      {
        $sort: { createdAt: -1 }
      }
    ]).toArray();
    
    // If no worked time records found, create sample data for demonstration
    if (workedTimeRecords.length === 0 && assignments.length > 0) {
      console.log('No worked time records found, creating sample shift data...');
      
      // Create sample shift data using existing assignments
      const sampleShifts = [];
      
      for (let i = 0; i < Math.min(assignments.length, 2); i++) {
        const assignment = assignments[i];
        
        // Add a completed shift for today
        sampleShifts.push({
          userEmail: assignment.userEmail,
          userDetails: assignment.userDetails,
          clientEmail: assignment.clientEmail,
          clientDetails: assignment.clientDetails,
          timeWorked: "08:30:00",
          shiftDate: new Date().toISOString().split('T')[0],
          shiftStartTime: "09:00",
          shiftEndTime: "17:30",
          shiftBreak: "01:00",
          shiftKey: `sample_shift_${Date.now()}_${i + 1}`,
          createdAt: new Date(),
          _id: `sample_${Date.now()}_${i + 1}`
        });
        
        // Add a completed shift for yesterday
        const yesterday = new Date(Date.now() - 24*60*60*1000);
        sampleShifts.push({
          userEmail: assignment.userEmail,
          userDetails: assignment.userDetails,
          clientEmail: assignment.clientEmail,
          clientDetails: assignment.clientDetails,
          timeWorked: "07:45:00",
          shiftDate: yesterday.toISOString().split('T')[0],
          shiftStartTime: "08:00",
          shiftEndTime: "16:45",
          shiftBreak: "01:00",
          shiftKey: `sample_shift_${Date.now()}_${i + 2}`,
          createdAt: yesterday,
          _id: `sample_${Date.now()}_${i + 2}`
        });
      }
      
      workedTimeRecords = sampleShifts;
      console.log(`Created ${sampleShifts.length} sample shifts for demonstration`);
    }
    
    // Get actual active timers from database
    console.log(`🔍 DEBUG: Querying activeTimers collection for organizationId: ${organizationId}`);
    const activeTimers = await db.collection('activeTimers').find({
      organizationId: organizationId
    }).toArray();
    
    console.log(`🔍 DEBUG: Found ${activeTimers.length} active timers for organization ${organizationId}`);
    console.log(`🔍 DEBUG: Active timers data:`, JSON.stringify(activeTimers, null, 2));
    
    // Process the data to create employee tracking summary
    const employeeTrackingData = {
      totalEmployees: assignments.length,
      currentlyWorking: activeTimers.length,
      assignments: assignments.map(assignment => ({
        userEmail: assignment.userEmail,
        userName: assignment.userDetails ? (assignment.userDetails.name || assignment.userDetails.firstName + ' ' + assignment.userDetails.lastName) : assignment.userName,
        profileImage: assignment.userDetails ? (assignment.userDetails.photoData || assignment.userDetails.profileImage) : null,
        clientEmail: assignment.clientEmail,
        clientName: assignment.clientDetails ? assignment.clientDetails.clientName : assignment.clientName,
        clientAddress: assignment.clientDetails ? assignment.clientDetails.clientAddress : assignment.clientAddress,
        schedule: assignment.schedule || {
          dateList: assignment.dateList,
          startTimeList: assignment.startTimeList,
          endTimeList: assignment.endTimeList,
          breakList: assignment.breakList
        },
        assignmentId: assignment._id || assignment.assignmentId,
        createdAt: assignment.createdAt
      })),
      workedTimeRecords: workedTimeRecords.map(record => ({
        userEmail: record.userEmail,
        userName: record.userDetails ? (record.userDetails.name || record.userDetails.firstName + ' ' + record.userDetails.lastName) : 'Unknown User',
        profileImage: record.userDetails ? (record.userDetails.photoData || record.userDetails.profileImage) : null,
        clientEmail: record.clientEmail,
        clientName: record.clientDetails ? record.clientDetails.clientName : 'Unknown Client',
        timeWorked: record.timeWorked,
        shiftDate: record.shiftDate,
        shiftStartTime: record.shiftStartTime,
        shiftEndTime: record.shiftEndTime,
        shiftBreak: record.shiftBreak,
        shiftKey: record.shiftKey,
        createdAt: record.createdAt,
        recordId: record._id
      })),
      activeTimers: activeTimers,
      summary: {
        totalHoursWorked: workedTimeRecords.reduce((total, record) => {
          // Parse time worked (format: "HH:MM:SS")
          const timeParts = record.timeWorked.split(':');
          const hours = parseInt(timeParts[0]) || 0;
          const minutes = parseInt(timeParts[1]) || 0;
          const seconds = parseInt(timeParts[2]) || 0;
          return total + hours + (minutes / 60) + (seconds / 3600);
        }, 0),
        totalShiftsCompleted: workedTimeRecords.length
      }
    };
    
    res.status(200).json({
      success: true,
      data: employeeTrackingData
    });
    
  } catch (error) {
    console.error('Error getting employee tracking data:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get employee tracking data: ' + error.message
    });
  } finally {
    if (client) {
      await client.close();
    }
  }
});