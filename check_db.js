const { MongoClient } = require('mongodb');
const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017/Invoice';

async function checkDB() {
  const client = await MongoClient.connect(uri);
  const db = client.db('Invoice');
  
  console.log('=== ClientAssignments Records ===');
  const assignments = await db.collection('clientAssignments').find({clientEmail: 'abc@abc.com'}).toArray();
  console.log(JSON.stringify(assignments, null, 2));
  
  console.log('\n=== WorkedTime Records ===');
  const workedTimes = await db.collection('workedTime').find({clientEmail: 'abc@abc.com'}).toArray();
  console.log(JSON.stringify(workedTimes, null, 2));
  
  await client.close();
}

checkDB().catch(console.error);