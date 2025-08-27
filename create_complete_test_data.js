const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';

async function createCompleteTestData() {
  const client = new MongoClient(uri);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // 1. Create test employee if not exists
    const existingEmployee = await db.collection('login').findOne({ email: 'test@employee.com' });
    
    if (!existingEmployee) {
      const testEmployee = {
        email: 'test@employee.com',
        firstName: 'Test',
        lastName: 'Employee',
        role: 'employee',
        organizationId: 'test_org_001',
        isActive: true,
        createdAt: new Date(),
        updatedAt: new Date()
      };
      
      const employeeResult = await db.collection('login').insertOne(testEmployee);
      console.log('Test employee created:', employeeResult.insertedId);
    } else {
      console.log('Test employee already exists');
    }
    
    // 2. Create/update client assignment
    const existingAssignment = await db.collection('clientAssignments').findOne({
      userEmail: 'test@employee.com',
      clientEmail: 'abc@abc.com'
    });
    
    if (!existingAssignment) {
      const testAssignment = {
        userEmail: 'test@employee.com',
        clientEmail: 'abc@abc.com',
        clientId: '686e84990153f7b6e940d51d', // Client ID from previous script
        organizationId: 'test_org_001',
        isActive: true,
        assignedNdisItemNumber: '01_001_0107_1_1', // Default NDIS item
        schedule: [
          {
            date: '2025-01-06',
            startTime: '09:00',
            endTime: '17:00',
            break: 'yes'
          },
          {
            date: '2025-01-07',
            startTime: '10:00',
            endTime: '17:30',
            break: 'no'
          }
        ],
        // Legacy format for backward compatibility
        dateList: ['2025-01-06', '2025-01-07'],
        startTimeList: ['09:00', '10:00'],
        endTimeList: ['17:00', '17:30'],
        breakList: ['yes', 'no'],
        createdAt: new Date()
      };
      
      const assignmentResult = await db.collection('clientAssignments').insertOne(testAssignment);
      console.log('Test client assignment created:', assignmentResult.insertedId);
    } else {
      console.log('Test client assignment already exists');
    }
    
    // 3. Create test organization if not exists
    const existingOrg = await db.collection('organizations').findOne({ _id: 'test_org_001' });
    
    if (!existingOrg) {
      const testOrg = {
        _id: 'test_org_001',
        organizationName: 'Test Organization',
        organizationCode: 'TEST001',
        isActive: true,
        createdAt: new Date()
      };
      
      await db.collection('organizations').insertOne(testOrg);
      console.log('Test organization created');
    } else {
      console.log('Test organization already exists');
    }
    
    // 4. Verify all test data
    console.log('\n=== Verification ===');
    
    const employee = await db.collection('login').findOne({ email: 'test@employee.com' });
    console.log('Employee exists:', !!employee);
    
    const clientRecord = await db.collection('login').findOne({ email: 'abc@abc.com' });
    console.log('Client exists:', !!clientRecord);
    
    const assignment = await db.collection('clientAssignments').findOne({
      userEmail: 'test@employee.com',
      clientEmail: 'abc@abc.com'
    });
    console.log('Assignment exists:', !!assignment);
    
    const workedTimeCount = await db.collection('workedTime').countDocuments({
      userEmail: 'test@employee.com',
      clientEmail: 'abc@abc.com'
    });
    console.log('Worked time records:', workedTimeCount);
    
    const organization = await db.collection('organizations').findOne({ _id: 'test_org_001' });
    console.log('Organization exists:', !!organization);
    
    console.log('\n✅ Test data setup complete!');
    
  } catch (error) {
    console.error('Error creating complete test data:', error);
  } finally {
    await client.close();
    console.log('Database connection closed');
  }
}

// Run the script
if (require.main === module) {
  createCompleteTestData();
}

module.exports = { createCompleteTestData };