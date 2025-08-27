const { MongoClient } = require('mongodb');

async function checkWorkedTime() {
  const client = new MongoClient('mongodb://localhost:27017');
  
  try {
    await client.connect();
    const db = client.db('invoice');
    
    // Check workedTime collection
    const workedTimeCount = await db.collection('workedTime').countDocuments();
    console.log('WorkedTime collection count:', workedTimeCount);
    
    const workedTimeDocs = await db.collection('workedTime').find({}).limit(3).toArray();
    console.log('WorkedTime documents:', JSON.stringify(workedTimeDocs, null, 2));
    
    // Check clientAssignments collection
    const assignmentsCount = await db.collection('clientAssignments').countDocuments();
    console.log('ClientAssignments collection count:', assignmentsCount);
    
    const assignmentsDocs = await db.collection('clientAssignments').find({}).limit(2).toArray();
    console.log('ClientAssignments documents:', JSON.stringify(assignmentsDocs, null, 2));
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await client.close();
  }
}

checkWorkedTime();