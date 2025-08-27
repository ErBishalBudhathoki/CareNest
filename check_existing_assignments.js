const { MongoClient, ObjectId } = require('mongodb');
require('dotenv').config();

async function checkExistingAssignments() {
    const MONGODB_URI = process.env.MONGODB_URI;
    if (!MONGODB_URI) {
        throw new Error('MONGODB_URI not found in environment variables');
    }

    const client = new MongoClient(MONGODB_URI);
    
    try {
        await client.connect();
        const db = client.db('Invoice');
        console.log('✅ Connected to MongoDB');
        
        // Check all assignments
        console.log('\n📋 EXISTING CLIENT ASSIGNMENTS');
        console.log('==============================');
        
        const assignments = await db.collection('clientAssignments').find({}).toArray();
        console.log(`Total assignments found: ${assignments.length}`);
        
        if (assignments.length > 0) {
            console.log('\n📊 Assignment Details:');
            assignments.forEach((assignment, index) => {
                console.log(`\n${index + 1}. Assignment ID: ${assignment._id}`);
                console.log(`   Client ID: ${assignment.clientId}`);
                console.log(`   Organization ID: ${assignment.organizationId}`);
                console.log(`   Status: ${assignment.status}`);
                console.log(`   Start Date: ${assignment.startDate}`);
                console.log(`   End Date: ${assignment.endDate}`);
                console.log(`   Schedule Items: ${assignment.scheduleItems?.length || 0}`);
                
                if (assignment.scheduleItems && assignment.scheduleItems.length > 0) {
                    console.log('   NDIS Items:');
                    assignment.scheduleItems.forEach(item => {
                        console.log(`     - ${item.ndisItemNumber} (${item.state}, ${item.providerType})`);
                    });
                }
            });
        }
        
        // Check clients
        console.log('\n👥 EXISTING CLIENTS');
        console.log('===================');
        
        const clients = await db.collection('clients').find({}).toArray();
        console.log(`Total clients found: ${clients.length}`);
        
        if (clients.length > 0) {
            console.log('\n📊 Client Details:');
            clients.forEach((client, index) => {
                console.log(`\n${index + 1}. Client ID: ${client._id}`);
                console.log(`   Name: ${client.firstName} ${client.lastName}`);
                console.log(`   Email: ${client.email}`);
                console.log(`   Organization ID: ${client.organizationId}`);
                console.log(`   Status: ${client.status}`);
            });
        }
        
        // Check organizations
        console.log('\n🏢 EXISTING ORGANIZATIONS');
        console.log('=========================');
        
        const organizations = await db.collection('organizations').find({}).toArray();
        console.log(`Total organizations found: ${organizations.length}`);
        
        if (organizations.length > 0) {
            console.log('\n📊 Organization Details:');
            organizations.forEach((org, index) => {
                console.log(`\n${index + 1}. Organization ID: ${org._id}`);
                console.log(`   Name: ${org.name}`);
                console.log(`   Status: ${org.status}`);
            });
        }
        
        // Check worked time
        console.log('\n⏰ WORKED TIME DATA');
        console.log('==================');
        
        const workedTimeCount = await db.collection('workedTime').countDocuments({});
        console.log(`Total worked time records: ${workedTimeCount}`);
        
        if (workedTimeCount > 0) {
            const sampleWorkedTime = await db.collection('workedTime').find({}).limit(3).toArray();
            console.log('\n📊 Sample Worked Time Records:');
            sampleWorkedTime.forEach((record, index) => {
                console.log(`\n${index + 1}. Record ID: ${record._id}`);
                console.log(`   Assignment ID: ${record.assignmentId}`);
                console.log(`   Date: ${record.date}`);
                console.log(`   Hours: ${record.hoursWorked}`);
                console.log(`   NDIS Item: ${record.ndisItemNumber}`);
                console.log(`   Status: ${record.status}`);
            });
        }
        
    } catch (error) {
        console.error('❌ Error:', error.message);
    } finally {
        await client.close();
        console.log('\n✅ Disconnected from MongoDB');
    }
}

checkExistingAssignments();