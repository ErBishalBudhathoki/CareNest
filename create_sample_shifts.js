const { MongoClient, ObjectId } = require('mongodb');

async function createSampleShifts() {
  const client = new MongoClient('mongodb://localhost:27017');
  
  try {
    await client.connect();
    const db = client.db('invoice');
    
    // Get existing assignments to link shifts to
    const assignments = await db.collection('clientAssignments').find({}).limit(2).toArray();
    
    if (assignments.length === 0) {
      console.log('No assignments found. Cannot create shifts without assignments.');
      return;
    }
    
    // Create sample shift data
    const sampleShifts = [
      {
        _id: new ObjectId(),
        userEmail: assignments[0].userEmail,
        assignedClientId: assignments[0]._id,
        timeWorked: "08:30:00",
        shiftDate: new Date().toISOString().split('T')[0], // Today's date
        shiftStartTime: "09:00",
        shiftEndTime: "17:30",
        shiftBreak: "01:00",
        shiftKey: `shift_${Date.now()}_1`,
        isActive: false, // Completed shift
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        _id: new ObjectId(),
        userEmail: assignments[0].userEmail,
        assignedClientId: assignments[0]._id,
        timeWorked: "07:45:00",
        shiftDate: new Date(Date.now() - 24*60*60*1000).toISOString().split('T')[0], // Yesterday
        shiftStartTime: "08:00",
        shiftEndTime: "16:45",
        shiftBreak: "01:00",
        shiftKey: `shift_${Date.now()}_2`,
        isActive: false, // Completed shift
        createdAt: new Date(Date.now() - 24*60*60*1000),
        updatedAt: new Date(Date.now() - 24*60*60*1000)
      }
    ];
    
    // Add second user's shifts if available
    if (assignments.length > 1) {
      sampleShifts.push({
        _id: new ObjectId(),
        userEmail: assignments[1].userEmail,
        assignedClientId: assignments[1]._id,
        timeWorked: "08:00:00",
        shiftDate: new Date().toISOString().split('T')[0], // Today's date
        shiftStartTime: "10:00",
        shiftEndTime: "18:00",
        shiftBreak: "00:00",
        shiftKey: `shift_${Date.now()}_3`,
        isActive: false, // Completed shift
        createdAt: new Date(),
        updatedAt: new Date()
      });
    }
    
    // Insert the sample shifts
    const result = await db.collection('workedTime').insertMany(sampleShifts);
    console.log(`Created ${result.insertedCount} sample shifts`);
    console.log('Sample shifts created successfully!');
    
  } catch (error) {
    console.error('Error creating sample shifts:', error);
  } finally {
    await client.close();
  }
}

createSampleShifts();