// /**
//  * Active Timers Management Endpoints
//  * These endpoints handle database-backed timer tracking for employee monitoring
//  */

// const { MongoClient, ServerApiVersion } = require('mongodb');
// const { admin, messaging } = require('./firebase-admin-config');
// require('dotenv').config();

// const uri = process.env.MONGODB_URI;

// /**
//  * Start timer with database persistence
//  * POST /startTimerWithTracking
//  */
// async function startTimerWithTracking(req, res) {
//   let client;
  
//   try {
//     const { userEmail, clientEmail, organizationId } = req.body;
    
//     if (!userEmail || !clientEmail || !organizationId) {
//       return res.status(400).json({
//         success: false,
//         message: 'Missing required fields: userEmail, clientEmail, organizationId'
//       });
//     }
    
//     console.log('Starting timer with tracking for:', { userEmail, clientEmail, organizationId });
    
//     // Connect to MongoDB
//     client = await MongoClient.connect(uri, {
//       serverApi: ServerApiVersion.v1
//     });
    
//     const db = client.db('Invoice');
    
//     // Check if user already has an active timer
//     const existingTimer = await db.collection('activeTimers').findOne({
//       userEmail: userEmail,
//       organizationId: organizationId
//     });
    
//     if (existingTimer) {
//       return res.status(400).json({
//         success: false,
//         message: 'User already has an active timer running',
//         activeTimer: {
//           clientEmail: existingTimer.clientEmail,
//           startTime: existingTimer.startTime
//         }
//       });
//     }
    
//     // Create new active timer record
//     const timerData = {
//       userEmail: userEmail,
//       clientEmail: clientEmail,
//       organizationId: organizationId,
//       startTime: new Date(),
//       createdAt: new Date()
//     };
    
//     const result = await db.collection('activeTimers').insertOne(timerData);
    
//     // Send notification to the employee
//     const userToken = await db.collection('fcmTokens').findOne({ userEmail: userEmail });
//     if (userToken && userToken.fcmToken) {
//       const message = {
//         token: userToken.fcmToken,
//         notification: {
//           title: '⏱️ Timer Started',
//           body: `Timer started for client ${clientEmail}`
//         },
//         android: {
//           priority: 'high',
//           notification: {
//             channelId: 'invoice',
//             icon: '@drawable/ic_notification',
//             color: '#2196F3',
//             priority: 'max',
//             defaultSound: true,
//             defaultVibrateTimings: true,
//             visibility: 'public',
//             notificationCount: 1
//           }
//         },
//         data: {
//           type: 'TIMER_START',
//           clientEmail: clientEmail,
//           timestamp: new Date().toISOString(),
//           click_action: 'FLUTTER_NOTIFICATION_CLICK'
//         }
//       };
//       await messaging.send(message);
//     }

//     // Send notification to all admin users of the organization
//     console.log('Finding admin users for organization:', organizationId);
//     console.log('\n=== ADMIN NOTIFICATION FLOW - START TIMER ===');
//     console.log('Timestamp:', new Date().toISOString());
//     console.log('Employee Email:', userEmail);
//     console.log('Client Email:', clientEmail);
//     console.log('Organization ID:', organizationId);
    
//     const adminUsers = await db.collection('login').find({
//       organizationId: organizationId,
//       role: 'admin'
//     }).toArray();
//     console.log('Found admin users:', adminUsers.map(user => ({ email: user.email, role: user.role, organizationId: user.organizationId })));
//     console.log('Total admin users found:', adminUsers.length);
//     console.log('Organization ID being used for filtering:', organizationId);

//     if (adminUsers.length > 0) {
//       const adminEmails = adminUsers.map(user => user.email);
//       console.log('Admin emails to notify:', adminEmails);
      
//       const tokenDocs = await db.collection('fcmTokens').find({
//         userEmail: { $in: adminEmails },
//         organizationId: organizationId  // Add organizationId filtering for security
//       }).toArray();
//       console.log('Found FCM token documents:', tokenDocs.map(t => ({ userEmail: t.userEmail, organizationId: t.organizationId, hasToken: !!t.fcmToken })));
      
//       const adminTokens = tokenDocs
//         .map(doc => doc.fcmToken)
//         .filter(token => token && token.trim() !== '');
//       console.log('Valid admin FCM tokens count:', adminTokens.length);
      
//       // Enhanced FCM Token Debugging
//       console.log('\n--- DETAILED FCM TOKEN ANALYSIS ---');
//       tokenDocs.forEach((doc, index) => {
//         console.log(`Token Document ${index + 1}:`);
//         console.log(`  User Email: ${doc.userEmail}`);
//         console.log(`  Organization ID: ${doc.organizationId}`);
//         console.log(`  Token Preview: ${doc.fcmToken ? doc.fcmToken.substring(0, 20) + '...' : 'NULL'}`);
//         console.log(`  Full Token: ${doc.fcmToken}`);
//         console.log(`  Token Length: ${doc.fcmToken ? doc.fcmToken.length : 0} characters`);
//         console.log(`  Token Starts With: ${doc.fcmToken ? doc.fcmToken.substring(0, 10) : 'N/A'}`);
//         console.log(`  Token Ends With: ${doc.fcmToken ? doc.fcmToken.substring(doc.fcmToken.length - 10) : 'N/A'}`);
//         console.log(`  Created At: ${doc.createdAt || 'Not available'}`);
//         console.log(`  Updated At: ${doc.updatedAt || 'Not available'}`);
//         console.log('  ---');
//       });
//       console.log('--- END TOKEN ANALYSIS ---\n');

//       if (adminTokens.length > 0) {
//         const message = {
//           notification: {
//             title: '👤 Employee Started Shift',
//             body: `${userEmail} started working with client ${clientEmail}`
//           },
//           android: {
//             priority: 'high',
//             notification: {
//               channelId: 'timer_alerts',
//               sound: 'default',
//               icon: 'ic_notification',
//               color: '#4CAF50',
//               priority: 'high',
//               visibility: 'public',
//               defaultVibrateTimings: true,
//               defaultSound: true,
//               notificationCount: 1
//             }
//           },
//           data: {
//             type: 'EMPLOYEE_TIMER_START',
//             employeeEmail: userEmail,
//             clientEmail: clientEmail,
//             timestamp: new Date().toISOString(),
//             click_action: 'FLUTTER_NOTIFICATION_CLICK',
//             channelId: 'timer_alerts'
//           },
//           apns: {
//             payload: {
//               aps: {
//                 sound: 'default',
//                 badge: 1,
//                 'content-available': 1
//               }
//             }
//           }
//         };
        
//         console.log('\n--- SENDING NOTIFICATION TO ADMINS ---');
//         console.log('Notification Title:', message.notification.title);
//         console.log('Notification Body:', message.notification.body);
//         console.log('Notification Data:', JSON.stringify(message.data, null, 2));
//         console.log('Target Admin Tokens:', adminTokens);
//         console.log('Total tokens to send to:', adminTokens.length);
        
//         const fcmResponse = await messaging.sendEachForMulticast({
//           ...message,
//           tokens: adminTokens
//         });
        
//         console.log('\n--- FCM RESPONSE DETAILS ---');
//         console.log('Success Count:', fcmResponse.successCount);
//         console.log('Failure Count:', fcmResponse.failureCount);
//         console.log('Full FCM Response:', JSON.stringify(fcmResponse, null, 2));
        
//         if (fcmResponse.responses) {
//           fcmResponse.responses.forEach((response, index) => {
//             console.log(`Token ${index + 1} (${adminTokens[index].substring(0, 20)}...):`);  
//             if (response.success) {
//               console.log('  ✅ SUCCESS - Message ID:', response.messageId);
//             } else {
//               console.log('  ❌ FAILED - Error:', response.error?.message || 'Unknown error');
//               console.log('  Error Code:', response.error?.code);
//             }
//           });
//         }
        
//         console.log(`\n✅ Notification sending completed for START TIMER event`);
//         console.log('=== END ADMIN NOTIFICATION FLOW ===\n');
//         // Log details for each token's success/failure
//         fcmResponse.responses.forEach((resp, index) => {
//           if (resp.success) {
//             console.log(`  Admin notification successful for token index ${index}.`);
//           } else {
//             console.error(`  Admin notification failed for token index ${index}: ${resp.error}`);
//           }
//         });
//       }
//     }
    
//     res.status(200).json({
//       success: true,
//       message: 'Timer started successfully',
//       timerId: result.insertedId,
//       startTime: timerData.startTime
//     });
    
//   } catch (error) {
//     console.error('Error starting timer with tracking:', error);
//     res.status(500).json({
//       success: false,
//       message: 'Internal server error while starting timer'
//     });
//   } finally {
//     if (client) {
//       await client.close();
//     }
//   }
// }

// /**
//  * Stop timer and create worked time record
//  * POST /stopTimerWithTracking
//  */
// async function stopTimerWithTracking(req, res) {
//   let client;
  
//   try {
//     const { userEmail, organizationId } = req.body;
    
//     if (!userEmail || !organizationId) {
//       return res.status(400).json({
//         success: false,
//         message: 'Missing required fields: userEmail, organizationId'
//       });
//     }
    
//     console.log('Stopping timer with tracking for:', { userEmail, organizationId });
    
//     // Connect to MongoDB
//     client = await MongoClient.connect(uri, {
//       serverApi: ServerApiVersion.v1
//     });
    
//     const db = client.db('Invoice');
//     const activeTimer = await db.collection('activeTimers').findOne({
//       userEmail: userEmail,
//       organizationId: organizationId
//     });

//     if (!activeTimer) {
//       return res.status(404).json({
//         success: false,
//         message: 'No active timer found for this user'
//       });
//     }

//     // Now delete the found timer
//     const deleteResult = await db.collection('activeTimers').deleteOne({ _id: activeTimer._id });

//     if (deleteResult.deletedCount === 0) {
//       return res.status(500).json({
//         success: false,
//         message: 'Failed to delete active timer after finding it'
//       });
//     }
    
//     const stopTime = new Date();
//     const startTime = activeTimer.startTime;
//     const totalTimeMs = stopTime.getTime() - startTime.getTime();
//     const totalTimeSeconds = Math.floor(totalTimeMs / 1000);
    
//     // Format time as HH:MM:SS
//     const hours = Math.floor(totalTimeSeconds / 3600);
//     const minutes = Math.floor((totalTimeSeconds % 3600) / 60);
//     const seconds = totalTimeSeconds % 60;
//     const formattedTime = `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    
//     // Create worked time record
//     const workedTimeData = {
//       userEmail: userEmail,
//       clientEmail: activeTimer.clientEmail,
//       organizationId: organizationId,
//       startTime: startTime,
//       endTime: stopTime,
//       timeWorked: formattedTime,
//       totalSeconds: totalTimeSeconds,
//       createdAt: new Date()
//     };
    
//     await db.collection('workedTime').insertOne(workedTimeData);
    
//     // Send notification to the employee
//     const userToken = await db.collection('fcmTokens').findOne({ userEmail: userEmail });
//     if (userToken && userToken.fcmToken) {
//       const message = {
//         token: userToken.fcmToken,
//         notification: {
//           title: '⏱️ Timer Stopped',
//           body: `Timer stopped for client ${activeTimer.clientEmail}. Time worked: ${formattedTime}`
//         },
//         android: {
//           priority: 'high',
//           notification: {
//             channelId: 'timer_alerts',
//             sound: 'default',
//             icon: 'ic_notification',
//             color: '#4CAF50',
//             priority: 'high',
//             visibility: 'public',
//             defaultVibrateTimings: true,
//             defaultSound: true,
//             notificationCount: 1
//           }
//         },
//         data: {
//           type: 'TIMER_STOP',
//           clientEmail: activeTimer.clientEmail,
//           timestamp: new Date().toISOString(),
//           timeWorked: formattedTime,
//           click_action: 'FLUTTER_NOTIFICATION_CLICK',
//           channelId: 'timer_alerts'
//         },
//         apns: {
//           payload: {
//             aps: {
//               sound: 'default',
//               badge: 1,
//               'content-available': 1
//             }
//           }
//         }
//       };
//       await messaging.send(message);
//     }

//     // Send notification to all admin users
//     console.log('\n=== ADMIN NOTIFICATION FLOW - STOP TIMER ===');
//     console.log('Timestamp:', new Date().toISOString());
//     console.log('Employee Email:', userEmail);
//     console.log('Client Email:', activeTimer.clientEmail);
//     console.log('Organization ID:', organizationId);
//     console.log('Time Worked:', formattedTime);
//     console.log('Total Seconds:', totalTimeSeconds);
    
//     console.log('Finding admin users for stop timer, organization:', organizationId);
//     const adminUsers = await db.collection('login').find({
//       organizationId: organizationId,
//       role: 'admin'
//     }).toArray();
//     console.log('Found admin users for stop timer:', adminUsers.map(user => ({ email: user.email, role: user.role, organizationId: user.organizationId })));
//     console.log('Total admin users found:', adminUsers.length);
//     console.log('Organization ID being used for filtering:', organizationId);

//     if (adminUsers.length > 0) {
//       const adminEmails = adminUsers.map(user => user.email);
//       const tokenDocs = await db.collection('fcmTokens').find({
//         userEmail: { $in: adminEmails },
//         organizationId: organizationId  // Add organizationId filtering for security
//       }).toArray();
      
//       const adminTokens = tokenDocs
//         .map(doc => doc.fcmToken)
//         .filter(token => token && token.trim() !== '');
//       console.log('FCM tokens found for stop timer:', tokenDocs.map(t => ({ userEmail: t.userEmail, organizationId: t.organizationId, hasToken: !!t.fcmToken })));
//       console.log('Valid admin FCM tokens count for stop timer:', adminTokens.length);
      
//       // Enhanced FCM Token Debugging for Stop Timer
//       console.log('\n--- DETAILED FCM TOKEN ANALYSIS (STOP TIMER) ---');
//       tokenDocs.forEach((doc, index) => {
//         console.log(`Token Document ${index + 1}:`);
//         console.log(`  User Email: ${doc.userEmail}`);
//         console.log(`  Organization ID: ${doc.organizationId}`);
//         console.log(`  Token Preview: ${doc.fcmToken ? doc.fcmToken.substring(0, 20) + '...' : 'NULL'}`);
//         console.log(`  Full Token: ${doc.fcmToken}`);
//         console.log(`  Token Length: ${doc.fcmToken ? doc.fcmToken.length : 0} characters`);
//         console.log(`  Token Starts With: ${doc.fcmToken ? doc.fcmToken.substring(0, 10) : 'N/A'}`);
//         console.log(`  Token Ends With: ${doc.fcmToken ? doc.fcmToken.substring(doc.fcmToken.length - 10) : 'N/A'}`);
//         console.log(`  Created At: ${doc.createdAt || 'Not available'}`);
//         console.log(`  Updated At: ${doc.updatedAt || 'Not available'}`);
//         console.log('  ---');
//       });
//       console.log('--- END TOKEN ANALYSIS (STOP TIMER) ---\n');

//       if (adminTokens.length > 0) {
//         const message = {
//           notification: {
//             title: '👤 Employee Ended Shift',
//             body: `${userEmail} finished working with client ${activeTimer.clientEmail}. Duration: ${formattedTime}`
//           },
//           android: {
//             priority: 'high',
//             notification: {
//               channelId: 'timer_alerts',
//               sound: 'default',
//               icon: 'ic_notification',
//               color: '#4CAF50',
//               priority: 'high',
//               visibility: 'public',
//               defaultVibrateTimings: true,
//               defaultSound: true,
//               notificationCount: 1
//             }
//           },
//           data: {
//             type: 'EMPLOYEE_TIMER_STOP',
//             employeeEmail: userEmail,
//             clientEmail: activeTimer.clientEmail,
//             timestamp: new Date().toISOString(),
//             timeWorked: formattedTime,
//             click_action: 'FLUTTER_NOTIFICATION_CLICK',
//             channelId: 'timer_alerts'
//           },
//           apns: {
//             payload: {
//               aps: {
//                 sound: 'default',
//                 badge: 1,
//                 'content-available': 1
//               }
//             }
//           }
//         };
//         console.log('\n--- SENDING STOP TIMER NOTIFICATION TO ADMINS ---');
//         console.log('Notification Title:', message.notification.title);
//         console.log('Notification Body:', message.notification.body);
//         console.log('Notification Data:', JSON.stringify(message.data, null, 2));
//         console.log('Target Admin Tokens:', adminTokens);
//         console.log('Total tokens to send to:', adminTokens.length);
        
//         const fcmResponse = await messaging.sendEachForMulticast({
//           ...message,
//           tokens: adminTokens
//         });
        
//         console.log('\n--- FCM RESPONSE DETAILS ---');
//         console.log('Success Count:', fcmResponse.successCount);
//         console.log('Failure Count:', fcmResponse.failureCount);
//         console.log('Full FCM Response:', JSON.stringify(fcmResponse, null, 2));
        
//         if (fcmResponse.responses) {
//           fcmResponse.responses.forEach((response, index) => {
//             console.log(`Token ${index + 1} (${adminTokens[index].substring(0, 20)}...):`);  
//             if (response.success) {
//               console.log('  ✅ SUCCESS - Message ID:', response.messageId);
//             } else {
//               console.log('  ❌ FAILED - Error:', response.error?.message || 'Unknown error');
//               console.log('  Error Code:', response.error?.code);
//             }
//           });
//         }
        
//         console.log(`\n✅ Notification sending completed for STOP TIMER event`);
//         console.log('=== END ADMIN NOTIFICATION FLOW ===\n');
//       }
//     }

//     res.status(200).json({
//       success: true,
//       message: 'Timer stopped successfully',
//       timeWorked: formattedTime
//     });

//   } catch (error) {
//     console.error('Error stopping timer:', error);
//     res.status(500).json({
//       success: false,
//       message: 'Internal server error while stopping timer'
//     });
//   } finally {
//     if (client) {
//       await client.close();
//     }
//   }
// }

// /**
//  * Get active timers for an organization
//  * GET /getActiveTimers/:organizationId
//  */
// async function getActiveTimers(req, res) {
//   let client;
  
//   try {
//     const { organizationId } = req.params;
    
//     console.log('Getting active timers for organization:', organizationId);
    
//     // Connect to MongoDB
//     client = await MongoClient.connect(uri, {
//       serverApi: ServerApiVersion.v1
//     });
    
//     const db = client.db('Invoice');
    
//     // Get all active timers for the organization
//     const activeTimers = await db.collection('activeTimers').find({
//       organizationId: organizationId
//     }).toArray();
    
//     res.status(200).json({
//       success: true,
//       activeTimers: activeTimers,
//       count: activeTimers.length
//     });
    
//   } catch (error) {
//     console.error('Error getting active timers:', error);
//     res.status(500).json({
//       success: false,
//       message: 'Internal server error while getting active timers'
//     });
//   } finally {
//     if (client) {
//       await client.close();
//     }
//   }
// }

// module.exports = {
//   startTimerWithTracking,
//   stopTimerWithTracking,
//   getActiveTimers
// };


/**
 * ===========================================================================
 * Active Timers & Admin Notification Management
 * ===========================================================================
 * This file handles database-backed timer tracking for employees and sends
 * targeted notifications ONLY to admin users of the relevant organization.
 *
 * REFACTOR SUMMARY:
 * - The repetitive admin notification logic has been moved into a single,
 *   reusable helper function: `sendAdminNotification`.
 * - `startTimerWithTracking` and `stopTimerWithTracking` are now cleaner,
 *   focusing on their primary task and then calling the helper function.
 * - This approach follows the DRY (Don't Repeat Yourself) principle, making
 *   the code easier to read, debug, and maintain.
 */

const { MongoClient, ServerApiVersion } = require('mongodb');
const { messaging } = require('./firebase-admin-config'); // Correctly imports your initialized Firebase Admin
require('dotenv').config();

const uri = process.env.MONGODB_URI;

/**
 * ===========================================================================
 * NOTIFICATION HELPER - TARGETED FOR ADMINS (Centralized Logic)
 * ===========================================================================
 * This function finds and notifies ONLY the admin users within a specific organization.
 * It encapsulates all the logic for finding users, getting tokens, building the
 * message, and sending the notification.
 */
async function sendAdminNotification(db, organizationId, title, body, data) {
  console.log(`\n=== ADMIN NOTIFICATION FLOW - START: ${data.type} ===`);
  console.log(`Timestamp: ${new Date().toISOString()}`);
  console.log(`Finding admin users for organization: ${organizationId}`);

  try {
    // 1. Find all users in the organization with the role 'admin'.
    const adminUsers = await db.collection('login').find({
      organizationId: organizationId,
      role: 'admin', // The critical filter for the user's role
      isActive: true
    }).project({ email: 1 }).toArray();

    if (adminUsers.length === 0) {
      console.log('No active admin users found for this organization. No notifications sent.');
      console.log(`=== END ADMIN NOTIFICATION FLOW: ${data.type} ===\n`);
      return;
    }

    const adminEmails = adminUsers.map(user => user.email);
    console.log(`Found ${adminEmails.length} admin emails to notify:`, adminEmails);

    // 2. Get the FCM tokens for these specific admin users.
    const tokenDocs = await db.collection('fcmTokens').find({
      userEmail: { $in: adminEmails }
    }).toArray();

    const validTokens = tokenDocs.map(doc => doc.fcmToken).filter(Boolean);

    if (validTokens.length === 0) {
      console.log('No valid FCM tokens found for any admin users. No notifications sent.');
      console.log(`=== END ADMIN NOTIFICATION FLOW: ${data.type} ===\n`);
      return;
    }
    console.log(`Found ${validTokens.length} valid FCM tokens for admins.`);

    // 3. Construct the robust "Notification + Data" message payload.
    const message = {
      notification: { title, body },
      data: {
        ...data, // Includes type, employeeEmail, etc.
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
        channelId: data.channelId || 'timer_alerts',
        timestamp: new Date().toISOString(),
      },
      android: {
        priority: 'high',
        notification: {
          channel_id: data.channelId || 'timer_alerts',
          sound: 'default',
        },
      },
      apns: {
        payload: { aps: { sound: 'default', 'content-available': 1 } },
        headers: { 'apns-priority': '10' },
      },
      tokens: validTokens,
    };

    // 4. Send the notification and handle the response.
    console.log('\n--- Sending Notification to Admins ---');
    const fcmResponse = await messaging.sendEachForMulticast(message);
    console.log('--- FCM Response ---');
    console.log('Success Count:', fcmResponse.successCount);
    console.log('Failure Count:', fcmResponse.failureCount);

    // 5. Clean up any invalid tokens from the database.
    if (fcmResponse.failureCount > 0) {
      const tokensToRemove = [];
      fcmResponse.responses.forEach((response, index) => {
        if (!response.success) {
          const errorCode = response.error.code;
          if (['messaging/invalid-registration-token', 'messaging/registration-token-not-registered'].includes(errorCode)) {
            tokensToRemove.push(validTokens[index]);
          }
        }
      });
      if (tokensToRemove.length > 0) {
        await db.collection('fcmTokens').deleteMany({ fcmToken: { $in: tokensToRemove } });
        console.log(`Removed ${tokensToRemove.length} invalid admin tokens.`);
      }
    }
  } catch (error) {
    console.error('FATAL ERROR in sendAdminNotification:', error);
  } finally {
    console.log(`=== END ADMIN NOTIFICATION FLOW: ${data.type} ===\n`);
  }
}


/**
 * ===========================================================================
 * TIMER ENDPOINTS - REVISED AND CLEANED
 * ===========================================================================
 */

/**
 * Start timer with database persistence
 * POST /startTimerWithTracking
 */
async function startTimerWithTracking(req, res) {
  let client;
  try {
    const { userEmail, clientEmail, organizationId } = req.body;
    if (!userEmail || !clientEmail || !organizationId) {
      return res.status(400).json({ success: false, message: 'Missing required fields: userEmail, clientEmail, organizationId' });
    }

    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db('Invoice');

    const existingTimer = await db.collection('activeTimers').findOne({ userEmail });
    if (existingTimer) {
      return res.status(409).json({ success: false, message: 'User already has an active timer running.' });
    }

    const timerData = { userEmail, clientEmail, organizationId, startTime: new Date() };
    const result = await db.collection('activeTimers').insertOne(timerData);
    console.log('Timer started in DB for:', { userEmail, clientEmail });

    // --- NOTIFICATION LOGIC ---
    // 1. Notify the employee who started the timer.
    const userTokenDoc = await db.collection('fcmTokens').findOne({ userEmail });
    if (userTokenDoc && userTokenDoc.fcmToken) {
      await messaging.send({
        token: userTokenDoc.fcmToken,
        notification: { title: '⏱️ Timer Started', body: `Your timer for client ${clientEmail} has started.` },
        data: { type: 'TIMER_START', clientEmail },
      });
    }

    // 2. Notify ONLY the admins of the organization.
    await sendAdminNotification(
      db,
      organizationId,
      '👤 Employee Started Shift',
      `${userEmail} started working with client ${clientEmail}`,
      {
        type: 'EMPLOYEE_TIMER_START',
        employeeEmail: userEmail,
        clientEmail: clientEmail,
      }
    );

    res.status(200).json({ success: true, message: 'Timer started successfully', timerId: result.insertedId });

  } catch (error) {
    console.error('Error starting timer:', error);
    res.status(500).json({ success: false, message: 'Internal server error while starting timer' });
  } finally {
    if (client) await client.close();
  }
}

/**
 * Stop timer and create worked time record
 * POST /stopTimerWithTracking
 */
async function stopTimerWithTracking(req, res) {
  let client;
  try {
    const { userEmail, organizationId } = req.body;
    if (!userEmail || !organizationId) {
      return res.status(400).json({ success: false, message: 'Missing required fields: userEmail, organizationId' });
    }

    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db('Invoice');

    console.log(`Looking for active timer for user: ${userEmail}`);
    const activeTimer = await db.collection('activeTimers').findOneAndDelete({ userEmail });
    console.log('findOneAndDelete result:', activeTimer);
    
    if (!activeTimer) {
      console.log('No active timer found for user:', userEmail);
      return res.status(404).json({ success: false, message: 'No active timer found for this user.' });
    }

    const timerDoc = activeTimer;
    console.log('Timer document found:', timerDoc);
    const stopTime = new Date();
    const startTime = timerDoc.startTime;
    const totalSeconds = Math.floor((stopTime.getTime() - startTime.getTime()) / 1000);
    const hours = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;
    const formattedTime = `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;

    await db.collection('workedTime').insertOne({
      userEmail,
      clientEmail: timerDoc.clientEmail,
      organizationId,
      startTime,
      endTime: stopTime,
      timeWorked: formattedTime,
      totalSeconds,
      createdAt: new Date(),
    });
    console.log('Timer stopped and worked time recorded for:', { userEmail, timeWorked: formattedTime });

    // --- NOTIFICATION LOGIC ---
    // 1. Notify the employee who stopped the timer.
    const userTokenDoc = await db.collection('fcmTokens').findOne({ userEmail });
    if (userTokenDoc && userTokenDoc.fcmToken) {
      await messaging.send({
        token: userTokenDoc.fcmToken,
        notification: { title: '⏱️ Timer Stopped', body: `Time worked: ${formattedTime}` },
        data: { type: 'TIMER_STOP', clientEmail: timerDoc.clientEmail, timeWorked: formattedTime },
      });
    }

    // 2. Notify ONLY the admins of the organization.
    await sendAdminNotification(
      db,
      organizationId,
      '👤 Employee Ended Shift',
      `${userEmail} finished working with client ${timerDoc.clientEmail}. Duration: ${formattedTime}`,
      {
        type: 'EMPLOYEE_TIMER_STOP',
        employeeEmail: userEmail,
        clientEmail: timerDoc.clientEmail,
        timeWorked: formattedTime,
      }
    );

    res.status(200).json({ success: true, message: 'Timer stopped successfully', timeWorked: formattedTime });

  } catch (error) {
    console.error('Error stopping timer:', error);
    res.status(500).json({ success: false, message: 'Internal server error while stopping timer' });
  } finally {
    if (client) await client.close();
  }
}

/**
 * Get active timers for an organization
 * GET /getActiveTimers/:organizationId
 */
async function getActiveTimers(req, res) {
  let client;
  try {
    const { organizationId } = req.params;
    client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
    const db = client.db('Invoice');
    const activeTimers = await db.collection('activeTimers').find({ organizationId }).toArray();
    res.status(200).json({ success: true, activeTimers, count: activeTimers.length });
  } catch (error) {
    console.error('Error getting active timers:', error);
    res.status(500).json({ success: false, message: 'Internal server error while getting active timers' });
  } finally {
    if (client) await client.close();
  }
}

// Export the functions so your server.js can use them.
module.exports = {
  startTimerWithTracking,
  stopTimerWithTracking,
  getActiveTimers,
};