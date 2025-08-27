const { MongoClient } = require('mongodb');
require('dotenv').config();

const uri = process.env.MONGODB_URI;
const client = new MongoClient(uri);

async function createSubstantialWorkedTimeData() {
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    
    const db = client.db('Invoice');
    const workedTimeCollection = db.collection('workedTime');
    
    // Clear existing test data for abc@abc.com
    await workedTimeCollection.deleteMany({
      userEmail: 'test1@tester.com',
      clientEmail: 'abc@abc.com'
    });
    console.log('Cleared existing worked time data');
    
    // Create substantial worked time entries with realistic hours
    const substantialWorkedTimeData = [
      {
        userEmail: 'test1@tester.com',
        clientEmail: 'abc@abc.com',
        timeWorked: '08:30:00', // 8.5 hours
        shiftIndex: 1,
        assignedClientId: '684ffed80aff010e93f89938',
        shiftDate: '2025-06-22',
        shiftStartTime: '9:00 AM',
        shiftEndTime: '5:30 PM',
        shiftBreak: 'Yes',
        shiftKey: '2025-06-22_9:00 AM',
        createdAt: new Date(),
        isActive: true
      },
      {
        userEmail: 'test1@tester.com',
        clientEmail: 'abc@abc.com',
        timeWorked: '07:45:00', // 7.75 hours
        shiftIndex: 2,
        assignedClientId: '684ffed80aff010e93f89938',
        shiftDate: '2025-06-23',
        shiftStartTime: '8:00 AM',
        shiftEndTime: '4:00 PM',
        shiftBreak: 'No',
        shiftKey: '2025-06-23_8:00 AM',
        createdAt: new Date(),
        isActive: true
      },
      {
        userEmail: 'test1@tester.com',
        clientEmail: 'abc@abc.com',
        timeWorked: '06:15:00', // 6.25 hours
        shiftIndex: 3,
        assignedClientId: '684ffed80aff010e93f89938',
        shiftDate: '2025-06-24',
        shiftStartTime: '10:00 AM',
        shiftEndTime: '4:15 PM',
        shiftBreak: 'Yes',
        shiftKey: '2025-06-24_10:00 AM',
        createdAt: new Date(),
        isActive: true
      },
      {
        userEmail: 'test1@tester.com',
        clientEmail: 'abc@abc.com',
        timeWorked: '09:00:00', // 9 hours
        shiftIndex: 4,
        assignedClientId: '684ffed80aff010e93f89938',
        shiftDate: '2025-06-25',
        shiftStartTime: '8:00 AM',
        shiftEndTime: '5:00 PM',
        shiftBreak: 'Yes',
        shiftKey: '2025-06-25_8:00 AM',
        createdAt: new Date(),
        isActive: true
      },
      {
        userEmail: 'test1@tester.com',
        clientEmail: 'abc@abc.com',
        timeWorked: '05:30:00', // 5.5 hours
        shiftIndex: 5,
        assignedClientId: '684ffed80aff010e93f89938',
        shiftDate: '2025-06-26',
        shiftStartTime: '9:00 AM',
        shiftEndTime: '2:30 PM',
        shiftBreak: 'No',
        shiftKey: '2025-06-26_9:00 AM',
        createdAt: new Date(),
        isActive: true
      }
    ];
    
    // Insert the substantial worked time data
    const result = await workedTimeCollection.insertMany(substantialWorkedTimeData);
    console.log(`Inserted ${result.insertedCount} substantial worked time records`);
    
    // Verify the data
    const verifyData = await workedTimeCollection.find({
      userEmail: 'test1@tester.com',
      clientEmail: 'abc@abc.com'
    }).toArray();
    
    console.log('\nVerification - Inserted worked time data:');
    verifyData.forEach((entry, index) => {
      console.log(`${index + 1}. Date: ${entry.shiftDate}, Time Worked: ${entry.timeWorked}, Break: ${entry.shiftBreak}`);
    });
    
    // Calculate total expected hours
    const totalHours = substantialWorkedTimeData.reduce((total, entry) => {
      const [hours, minutes, seconds] = entry.timeWorked.split(':').map(Number);
      return total + hours + (minutes / 60) + (seconds / 3600);
    }, 0);
    
    const breaksCount = substantialWorkedTimeData.filter(entry => entry.shiftBreak === 'Yes').length;
    const totalBreakTime = breaksCount * 0.5; // 0.5 hours per break
    const expectedBillableHours = totalHours - totalBreakTime;
    
    console.log(`\nExpected calculations:`);
    console.log(`Total worked time: ${totalHours.toFixed(2)} hours`);
    console.log(`Total breaks: ${breaksCount} (${totalBreakTime} hours)`);
    console.log(`Expected billable hours: ${expectedBillableHours.toFixed(2)} hours`);
    
  } catch (error) {
    console.error('Error creating substantial worked time data:', error);
  } finally {
    await client.close();
    console.log('\nDatabase connection closed');
  }
}

createSubstantialWorkedTimeData();