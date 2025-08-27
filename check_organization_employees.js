require('dotenv').config();
const { MongoClient } = require('mongodb');

async function checkOrganizationEmployees() {
  try {
    const client = new MongoClient(process.env.MONGODB_URI);
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check the organization ID from the images: 6846b040808f01d85897bbd8
    const orgId = '6846b040808f01d85897bbd8';
    
    console.log(`\nChecking employees for organization ID: ${orgId}`);
    
    // Check all users in login collection for this organization
    const employees = await db.collection('login').find({ 
      organizationId: orgId 
    }).toArray();
    
    console.log(`\nFound ${employees.length} employees in login collection:`);
    employees.forEach((emp, index) => {
      console.log(`${index + 1}. ${emp.firstName} ${emp.lastName} (${emp.email}) - Role: ${emp.role}`);
    });
    
    // Check assignments collection for this organization
    const assignments = await db.collection('assignments').find({ 
      organizationId: orgId 
    }).toArray();
    
    console.log(`\nFound ${assignments.length} assignments for this organization:`);
    assignments.forEach((assignment, index) => {
      console.log(`${index + 1}. User: ${assignment.userName} (${assignment.userEmail}) - Status: ${assignment.status}`);
    });
    
    // Check worked_time_records for this organization
    const workRecords = await db.collection('worked_time_records').find({ 
      organizationId: orgId 
    }).toArray();
    
    console.log(`\nFound ${workRecords.length} work time records for this organization:`);
    workRecords.forEach((record, index) => {
      console.log(`${index + 1}. User: ${record.userName} (${record.userEmail}) - Date: ${record.date}`);
    });
    
    // Check active_timers for this organization
    const activeTimers = await db.collection('active_timers').find({ 
      organizationId: orgId 
    }).toArray();
    
    console.log(`\nFound ${activeTimers.length} active timers for this organization:`);
    activeTimers.forEach((timer, index) => {
      console.log(`${index + 1}. User: ${timer.userName} (${timer.userEmail}) - Started: ${timer.startTime}`);
    });
    
    await client.close();
  } catch (error) {
    console.error('Error:', error);
  }
}

checkOrganizationEmployees();