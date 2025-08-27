const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';

async function createTestWorkedTime() {
  const client = new MongoClient(uri);
  
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    
    // Check if worked time data already exists
    const existingWorkedTime = await db.collection('workedTime').findOne({
      userEmail: 'test@employee.com',
      clientEmail: 'abc@abc.com'
    });
    
    if (existingWorkedTime) {
      console.log('Test worked time data already exists');
      console.log('Existing data:', JSON.stringify(existingWorkedTime, null, 2));
      return;
    }
    
    // Create test worked time records
    const testWorkedTimeRecords = [
      {
        userEmail: 'test@employee.com',
        clientEmail: 'abc@abc.com',
        timeWorked: '08:00:00', // 8 hours in HH:MM:SS format
        shiftIndex: 0,
        assignedClientId: '686e84990153f7b6e940d51d', // Use the client ID from previous script
        shiftDate: '2025-01-06',
        shiftStartTime: '09:00',
        shiftEndTime: '17:00',
        shiftBreak: 'yes',
        shiftKey: '2025-01-06_09:00',
        createdAt: new Date(),
        isActive: true
      },
      {
        userEmail: 'test@employee.com',
        clientEmail: 'abc@abc.com',
        timeWorked: '07:30:00', // 7.5 hours in HH:MM:SS format
        shiftIndex: 1,
        assignedClientId: '686e84990153f7b6e940d51d',
        shiftDate: '2025-01-07',
        shiftStartTime: '10:00',
        shiftEndTime: '17:30',
        shiftBreak: 'no',
        shiftKey: '2025-01-07_10:00',
        createdAt: new Date(),
        isActive: true
      }
    ];
    
    // Insert the test worked time records
    const result = await db.collection('workedTime').insertMany(testWorkedTimeRecords);
    console.log('Test worked time records created successfully:');
    console.log('Inserted IDs:', result.insertedIds);
    console.log('Records count:', testWorkedTimeRecords.length);
    
    // Display the created records
    testWorkedTimeRecords.forEach((record, index) => {
      console.log(`\nRecord ${index + 1}:`);
      console.log(JSON.stringify(record, null, 2));
    });
    
  } catch (error) {
    console.error('Error creating test worked time data:', error);
  } finally {
    await client.close();
    console.log('\nDatabase connection closed');
  }
}

// Run the script
if (require.main === module) {
  createTestWorkedTime();
}

module.exports = { createTestWorkedTime };