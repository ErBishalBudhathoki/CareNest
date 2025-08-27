const { MongoClient, ObjectId } = require('mongodb');
require('dotenv').config();

class AssignmentDataDebugger {
    constructor() {
        this.client = null;
        this.db = null;
    }

    async connect() {
        const MONGODB_URI = process.env.MONGODB_URI;
        if (!MONGODB_URI) {
            throw new Error('MONGODB_URI not found in environment variables');
        }

        this.client = new MongoClient(MONGODB_URI);
        await this.client.connect();
        this.db = this.client.db('Invoice');
        console.log('✅ Connected to MongoDB');
    }

    async debugAssignmentData() {
        try {
            const assignmentId = '6888f161238dbd9912e83c77';
            
            console.log('\n🔍 DEBUGGING ASSIGNMENT DATA');
            console.log('==============================');
            
            // Get assignment details
            const assignment = await this.db.collection('clientAssignments').findOne({
                _id: new ObjectId(assignmentId)
            });
            
            if (!assignment) {
                console.log('❌ Assignment not found');
                return;
            }
            
            console.log('\n📋 Assignment Details:');
            console.log('- Assignment ID:', assignment._id);
            console.log('- Client ID:', assignment.clientId);
            console.log('- Organization ID:', assignment.organizationId);
            console.log('- Start Date:', assignment.startDate);
            console.log('- End Date:', assignment.endDate);
            console.log('- Status:', assignment.status);
            console.log('- Schedule Items:', assignment.scheduleItems?.length || 0);
            
            if (assignment.scheduleItems && assignment.scheduleItems.length > 0) {
                console.log('\n📅 Schedule Items:');
                assignment.scheduleItems.forEach((item, index) => {
                    console.log(`  ${index + 1}. NDIS Item: ${item.ndisItemNumber}`);
                    console.log(`     State: ${item.state}`);
                    console.log(`     Provider Type: ${item.providerType}`);
                    console.log(`     Hours: ${item.hours}`);
                    console.log(`     Rate: $${item.rate}`);
                    console.log(`     Date: ${item.date}`);
                    console.log('');
                });
            }
            
            // Check for worked time data
            console.log('\n⏰ Checking Worked Time Data...');
            const workedTimeCount = await this.db.collection('workedTime').countDocuments({
                assignmentId: new ObjectId(assignmentId)
            });
            console.log(`- Worked Time Records: ${workedTimeCount}`);
            
            if (workedTimeCount > 0) {
                const workedTimeRecords = await this.db.collection('workedTime').find({
                    assignmentId: new ObjectId(assignmentId)
                }).limit(5).toArray();
                
                console.log('\n📊 Sample Worked Time Records:');
                workedTimeRecords.forEach((record, index) => {
                    console.log(`  ${index + 1}. Date: ${record.date}`);
                    console.log(`     Hours: ${record.hoursWorked}`);
                    console.log(`     NDIS Item: ${record.ndisItemNumber}`);
                    console.log(`     Status: ${record.status}`);
                    console.log('');
                });
            }
            
            // Check for schedule data
            console.log('\n📋 Checking Schedule Data...');
            const scheduleCount = await this.db.collection('schedules').countDocuments({
                assignmentId: new ObjectId(assignmentId)
            });
            console.log(`- Schedule Records: ${scheduleCount}`);
            
            if (scheduleCount > 0) {
                const scheduleRecords = await this.db.collection('schedules').find({
                    assignmentId: new ObjectId(assignmentId)
                }).limit(5).toArray();
                
                console.log('\n📅 Sample Schedule Records:');
                scheduleRecords.forEach((record, index) => {
                    console.log(`  ${index + 1}. Date: ${record.scheduledDate}`);
                    console.log(`     Start: ${record.startTime}`);
                    console.log(`     End: ${record.endTime}`);
                    console.log(`     NDIS Item: ${record.ndisItemNumber}`);
                    console.log(`     Status: ${record.status}`);
                    console.log('');
                });
            }
            
            // Check what collections exist
            console.log('\n📚 Available Collections:');
            const collections = await this.db.listCollections().toArray();
            const collectionNames = collections.map(c => c.name).sort();
            collectionNames.forEach(name => {
                console.log(`- ${name}`);
            });
            
        } catch (error) {
            console.error('❌ Debug error:', error.message);
        }
    }

    async disconnect() {
        if (this.client) {
            await this.client.close();
            console.log('\n✅ Disconnected from MongoDB');
        }
    }
}

// Run the debugger
async function runDebugger() {
    const dataDebugger = new AssignmentDataDebugger();
    
    try {
        await dataDebugger.connect();
        await dataDebugger.debugAssignmentData();
    } catch (error) {
        console.error('❌ Debugger failed:', error.message);
    } finally {
        await dataDebugger.disconnect();
    }
}

runDebugger();