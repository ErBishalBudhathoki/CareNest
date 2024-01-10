const express = require("express");
const bodyParser = require("body-parser");
const iconv = require("iconv-lite");
const fs = require("fs");
const csv = require("csv-parser");
const https = require("https");
const xlsx = require("xlsx");
const multer = require("multer");
const nodemailer = require('nodemailer');
const crypto = require('crypto');
require("dotenv").config();

// Configure multer to handle file uploads
const upload = multer({
  storage: multer.diskStorage({
    destination: "./uploads",
    filename: (req, file, cb) => {
      cb(null, file.originalname);
    },
  }),
  allowedFiles: ["image/jpeg", "image/png", "image/heif"],
});
var app = express();

var PORT = process.env.PORT || 9001;
const serverOptions = {
  poolsize: 100,
  socketOptions: {
    socketTimeoutMS: 6000000,
  },
};
const uri = process.env.MONGODB_URI;
const { MongoClient, ServerApiVersion, ObjectId } = require("mongodb");
require("dotenv").config();
const client = new MongoClient(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  serverApi: ServerApiVersion.v1,
});
// process.env.MONGODB_URI ||

MongoClient.connect(process.env.MONGODB_URI, function (err, db) {
  if (err) throw err;
  var dbo = db.db("Invoice");
  dbo.collection("login").findOne({}, function (err, result) {
    if (err) throw err;
    console.log("Server connected");
    db.close();
  });
});

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
app.use(bodyParser.json());

app.use(function (req, res, next) {
  res.header("Content-Type", "application/json");
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

app.get("/", (req, res) => {
  res.send("Active");
});

let timerInterval;
let timerRunning = false;
let startTime;

app.post('/startTimer', (req, res) => {
  console.log('Start timer called');
  if (!timerRunning) {
    startTime = new Date().getTime();
    timerInterval = setInterval(() => {
      // Your timer logic goes here
      console.log('Timer is running...');
    }, 1000); // Timer runs every 1 second
    timerRunning = true;
    res.status(200).json({ message: 'Timer started' });
  } else {
    res.status(400).json({ message: 'Timer is already running' });
  }
});

app.post('/stopTimer', (req, res) => {
  if (timerRunning) {
    clearInterval(timerInterval);
    timerRunning = false;
    const stopTime = new Date().getTime();
    const totalTime = (stopTime - startTime) / 1000; // Convert to seconds
    console.log('Timer has stopped...');
    res.status(200).json({ message: 'Timer stopped', totalTime: totalTime });
  } else {
    res.status(400).json({ message: 'Timer is not running' });
  }
});

// Function to generate a random OTP
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}
// Function to pad a string to the left with a specified character to reach a certain length
function padLeft(str, length, char) {
  while (str.length < length) {
    str = char + str;
  }
  return str;
}
let serverEncryptionKey;

function generateEncryptionKey() {
  // Check if the key has already been generated
  // if (!serverEncryptionKey) {
    // If not generated, generate a new key
    serverEncryptionKey = crypto.randomBytes(8).toString('hex');
    // console.log('Server generated Encryption Key: ' + serverEncryptionKey);
  //}

  // Return the existing or newly generated key
  return serverEncryptionKey;
}


// function encryptOTP(otp, flutterEncryptKey) {
//   console.log('encryptOTP called ' + otp + ' ## ' + flutterEncryptKey);
//   const IV_LENGTH = 16; // For AES, this is always 16
//   let iv = crypto.randomBytes(IV_LENGTH);
//   let timestamp = padLeft(Date.now().toString(), 13, '0'); // Pad with zeros to ensure length is 13
//   let encryptionKey = generateEncryptionKey();
//   console.log('encryptionKey: ' + encryptionKey);

//   // Decode flutterEncryptKey from Base64
//   let decodedFlutterEncryptKey = Buffer.from(flutterEncryptKey, 'base64').toString('hex');

//   // Trim or pad the decodedFlutterEncryptKey to match the length of encryptionKey
//   if (decodedFlutterEncryptKey.length > encryptionKey.length) {
//     decodedFlutterEncryptKey = decodedFlutterEncryptKey.slice(0, encryptionKey.length);
//   } else if (decodedFlutterEncryptKey.length < encryptionKey.length) {
//     decodedFlutterEncryptKey = decodedFlutterEncryptKey.padEnd(encryptionKey.length, '0');
//   }

//   let combinedKey = xorHex(decodedFlutterEncryptKey, encryptionKey);
//   let cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(combinedKey, 'hex'), iv);
//   let dataToEncrypt = Buffer.from(timestamp + otp); // Prepend timestamp to OTP
//   let encrypted = cipher.update(dataToEncrypt);
//   encrypted = Buffer.concat([encrypted, cipher.final()]);
//   console.log('encrypted: ' + encrypted.toString('hex'));
//   return Buffer.concat([iv, encrypted]).toString('hex'); // Prepend IV to encrypted data
// }

// XOR two hex strings of the same length

function xorHex(a, b) {
  let result = '';
  for (let i = 0; i < a.length; i += 2) {
    result += (parseInt(a.substr(i, 2), 16) ^ parseInt(b.substr(i, 2), 16)).toString(16).padStart(2, '0');
  }
  return result;
}

function encryptOTP(otp, flutterEncryptKey) {
  // console.log('encryptOTP called ' + otp + ' ## ' + flutterEncryptKey);
  const IV_LENGTH = 16; // For AES, this is always 16
  let iv = crypto.randomBytes(IV_LENGTH);
  // console.log('iv: ' + iv.toString('hex'));
  let timestamp = padLeft(Date.now().toString(), 13, '0'); // Pad with zeros to ensure length is 13
  let encryptionKey = generateEncryptionKey();
  // console.log('encryptionKey: ' + encryptionKey + 'timestamp: ' + timestamp );

  // Ensure the encryption key is 32 characters by using only the first 32 characters
  let combinedKey = (flutterEncryptKey + encryptionKey).slice(0, 32);

  // console.log('combinedKey: ' + combinedKey);

  // Encrypt the data
  let dataToEncrypt = Buffer.from(timestamp + otp); // Prepend timestamp to OTP
  // console.log('dataToEncrypt: ' + dataToEncrypt.toString('hex') + ' ## ' + Buffer.from(combinedKey, 'utf-8'));
  // Create a cipher with the combined key and IV
  let cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(combinedKey, 'utf-8'), iv);

  // // Encrypt the data
  // let dataToEncrypt = Buffer.from(timestamp + otp); // Prepend timestamp to OTP
  let encrypted = Buffer.concat([iv, cipher.update(dataToEncrypt), cipher.final()]);
  // console.log('encrypted: ' + encrypted.toString('hex'));

  return encrypted.toString('hex'); // Return the complete encrypted data
}

// function decryptOTP(encryptedOTP, encryptionKey) {
//   console.log('decryptOTP called ' + encryptedOTP + ' ## ' + encryptionKey);
//   const IV_LENGTH = 16; // For AES, this is always 16
//   //try {
//     let encryptedText = Buffer.from(encryptedOTP, 'hex');

//     // Ensure the encrypted text is at least the size of the IV
//     // if (encryptedText.length < IV_LENGTH) {
//     //   throw new Error('Invalid encrypted text length');
//     // }

//     let iv = encryptedText.slice(0, IV_LENGTH);
//     let encryptedData = encryptedText.slice(IV_LENGTH);

//     // Create a decipher with the provided key and IV
//     //let decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(encryptionKey, 'hex'), iv);
//     let decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(encryptionKey, 'hex'), Buffer.from(iv, 'hex'));

//     // Decrypt the data
//     let decryptedData = decipher.update(encryptedData);
//     decryptedData = Buffer.concat([decryptedData, decipher.final()]);

//     // Ensure the decrypted data is not empty
//     if (decryptedData.length === 0) {
//       throw new Error('Invalid decryption result');
//     }

//     // Extract timestamp and OTP from decrypted data
//     const decryptedTimestamp = decryptedData.slice(0, 13).toString();
//     const decryptedOTP = decryptedData.slice(13).toString();
//     console.log('decryptedTimestamp: ' + decryptedTimestamp + ' decryptedOTP: ' + decryptedOTP);
    
//     return {
//       timestamp: decryptedTimestamp,
//       otp: decryptedOTP
//     };
//   // } catch (error) {
//   //   console.error('Error decrypting OTP:', error.message);
//   //   return null;
//   // }
// }

// var serverGeneratedVerificationKey;

// // Function to generate a verification key using the encryption key
// function generateVerificationKey(otp, clientEncryptionKey) {
//   const hmac = crypto.createHmac('sha256', clientEncryptionKey);
  
//   // Include a timestamp in milliseconds
//   const timestamp = padLeft(Date.now().toString(), 13, '0'); // Pad with zeros to ensure length is 13

//   // Update HMAC with timestamp and OTP
//   hmac.update(timestamp);
//   hmac.update(otp);

//   // Save the generated verification key with timestamp
//   serverGeneratedVerificationKey = hmac.digest('hex');
//   console.log('serverGeneratedVerificationKey: ' + serverGeneratedVerificationKey);
//   return serverGeneratedVerificationKey;
// }

// // // Function to extract timestamp from the verification key
// // function extractTimestampFromVerificationKey() {
// //   // Assuming timestamp length is 13 characters
// //   const timestampLength = 13;
  
// //   const timestamp = serverGeneratedVerificationKey.substring(0, timestampLength);
// //   console.log('timestamp: ' + timestamp);
// //   return timestamp;
// // }

// // Function to extract timestamp from the verification key
// function extractTimestampAndOTPFromVerificationKey(clientEncryptionKey) {
//   // Assuming timestamp length is 13 characters
//   const timestampLength = 13;
//   const otpLength = 6;
 
//     // Extract timestamp and OTP from the serverGeneratedVerificationKey
//     const timestamp = serverGeneratedVerificationKey.substring(0, timestampLength);
//     const otp = serverGeneratedVerificationKey.substring(timestampLength, timestampLength + otpLength);
//     console.log('timestamp: ' + timestamp + ' otp: ' + otp);
//     // Return the extracted data along with a verification status
//   return {
//     timestamp,
//     otp,
//     //isVerificationValid: computedHMAC === serverGeneratedVerificationKey.substring(timestampLength + otpLength),
//   };
// }

// Function to send an email with the OTP and verification key

function decryptOTP(encryptedData, flutterEncryptKey, encryptionKey) {
  const IV_LENGTH = 16;

  try {
    let encryptedBuffer = Buffer.from(encryptedData, 'hex');
    let iv = encryptedBuffer.slice(0, IV_LENGTH);
    let encrypted = encryptedBuffer.slice(IV_LENGTH);
    // let combinedKey = (flutterEncryptKey + encryptionKey).slice(0, 32);
    // Assuming minimum key length is 16 characters
    const minKeyLength = 16;

    let combinedKey = (
      flutterEncryptKey.padEnd(minKeyLength, '0') +
      encryptionKey.padEnd(minKeyLength, '0')
    ).slice(0, 32);

    let decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(combinedKey, 'utf-8'), iv);

    let decrypted = Buffer.concat([decipher.update(encrypted), decipher.final()]);

    let timestamp = decrypted.slice(0, 13).toString();
    let otp = decrypted.slice(13).toString();

    // console.log('Decryption successful - timestamp:', timestamp, 'otp:', otp);

    return { timestamp, otp };
  } catch (error) {
    console.error('Error in decryptOTP:', error);
    return null;
  }
}

async function sendOtpEmail(email, flutterClientKey) {
  const otp = generateOTP();
  const verificationKey = encryptOTP(otp, flutterClientKey);

  // Configure nodemailer transport
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.ADMIN_EMAIL,
      pass: process.env.APP_PASSWORD,
    },
  });

  // Email configuration
  const mailOptions = {
    from: process.env.ADMIN_EMAIL, // Replace with your Gmail email address
    to: email,
    subject: 'OTP Verification',
    text: `Your OTP code is: ${otp}\n`,
  };

  try {
    // Send the email
    await transporter.sendMail(mailOptions);
    console.log('Email sent successfully');

    // Return the OTP and verification key so they can be used for verification
    return { otp, verificationKey };
  } catch (error) {
    console.error('Error sending email:', error);
    throw error;
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
}

app.post('/sendOTP', async (req, res) => {
  const { email, clientEncryptionKey } = req.body;
  try {
    const { otp, verificationKey } = await sendOtpEmail(email, clientEncryptionKey);
    console.log('Send OTP called ' + otp);
    res.status(200).json({
      statusCode: 200,
      message: 'OTP sent successfully',
      otp,
      verificationKey,
    });
  } catch (error) {
    console.error('Error sending OTP:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error sending OTP',
    });
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});
  
// function verifyOTP(userOTP, userVerificationKey, generatedOTP, timeLimitSeconds) {
//   // Compare the user-provided OTP with the generated OTP
//   const isOTPValid = userOTP === generatedOTP;
//   console.log('Verify OTP called ' + isOTPValid + ' ## ' + userOTP 
//     + ' ## ser' + generatedOTP + ' ver ## ' 
//   );

//   const generatedVerificationKey = serverGeneratedVerificationKey;
//   console.log('generatedVerificationKey ' + generatedVerificationKey);
//   if (isOTPValid != true) {
//     console.log('OTP not valid');
//     return false;
//   }

//   // Extract the timestamp from the generatedVerificationKey
//   //const timestamp = parseInt(generatedVerificationKey.substring(0, 10), 16);
//   const timestamp = extractTimestampFromVerificationKey();
//   // Check if the timestamp is within the time limit
//   const currentTime = Math.floor(new Date().getTime() / 1000);
//   const isTimestampValid = currentTime - timestamp <= timeLimitSeconds;

//   console.log('currentTime ' 
//   + currentTime + ' timestamp ' 
//   + timestamp + ' isTimestampValid ' 
//   + isTimestampValid);
//   if (!isTimestampValid) {
//     console.log('Timestamp not valid');
//     return false;
//   }

//   // Verify the verification key using the encryption key
//   const hmac = crypto.createHmac('sha256', userVerificationKey);
//   hmac.update(generatedOTP);
//   const calculatedVerificationKey = hmac.digest('hex');
//   console.log('calculatedVerificationKey ' + calculatedVerificationKey);
//   // Check if the calculated verification key matches the one provided by the user
//   const isVerificationKeyValid = calculatedVerificationKey === generatedVerificationKey;
//   console.log('isVerificationKeyValid ' + isVerificationKeyValid);
//   return isVerificationKeyValid;
// }

function verifyOTP(userOTP, userVerificationKey, generatedOTP, encryptVerificationKey, timeLimitSeconds) {
  // Compare the user-provided OTP with the generated OTP
  const isOTPValid = userOTP === generatedOTP;
  console.log('Verify OTP called ' + isOTPValid + ' ## ' + userOTP + ' ## ser' + generatedOTP + ' ver ## ');

  if (!isOTPValid) {
    console.log('OTP not valid');
    return false;
  }
  const serverGeneratedVerificationKey = serverEncryptionKey;
  console.log(
  '\n enc ver key ' + encryptVerificationKey
  + '\n user ver key ' + userVerificationKey
  + '\n user otp ' + userOTP
  + '\n generated otp ' + generatedOTP
  + '\n time limit ' + timeLimitSeconds
  + '\n flutter key ' + encryptVerificationKey
  + '\n server key ' + serverGeneratedVerificationKey);
  const extractedData = decryptOTP( encryptVerificationKey, userVerificationKey, serverGeneratedVerificationKey);
  
  if (extractedData !== null) {
    const { timestamp, otp } = extractedData;
    
    console.log('Extracted Timestamp:', timestamp);
    console.log('Extracted OTP:', otp);

    // Check if the timestamp is within the time limit
    const currentTime = Math.floor(new Date().getTime() / 1000);
    // const isTimestampValid = currentTime - timestamp <= timeLimitSeconds;
    const isTimestampValid = (currentTime - timestamp / 1000) <= timeLimitSeconds;

    console.log('currentTime ' + currentTime + ' timestamp ' + timestamp + ' isTimestampValid ' + isTimestampValid);

    if (!isTimestampValid) {
      console.log('Timestamp not valid');
      return false;
    }
    else {
      console.log('Timestamp valid');
      if (otp != userOTP) {
        console.log('OTP not valid');
        return false;
      } else {
        console.log('OTP valid');
        return true;
      }
    }
  } else {
    console.log('Verification failed. Cannot extract data.');
    return false;
  }
}

app.post('/updatePassword', async (req, res) => {
  const { newPassword, email } = req.body;

  // The filter to find the document to update
  var filter = { email: email };

  // The update operation to set the new password
  var update = { $set: { password: newPassword } };

  // The options object
  var options = { upsert: false };

  try {
    MongoClient.connect(process.env.MONGODB_URI, function (err, db) {
      if (err) throw err;
      var dbo = db.db("Invoice");
      
      dbo.collection("login").updateOne(filter, update, options, function (err, result) {
        if (err) throw err;
        console.log("Document updated successfully");
        db.close();
      });
    });

    res.json({
      statusCode: 200,
      message: 'Password updated successfully'
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({
      statusCode: 500, 
      message: 'Error updating password'
    });
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});


// Endpoint for OTP and verification key verification
app.post('/verifyOTP', (req, res) => {
  const { userOTP, userVerificationKey, generatedOTP, encryptVerificationKey } = req.body;

  try {
    // Verify the OTP and verification key
    const isVerificationSuccessful = verifyOTP(
      userOTP,
      userVerificationKey,
      generatedOTP,
      encryptVerificationKey,
      120 // Time limit in seconds (adjust as needed)
    );

    if (isVerificationSuccessful) {
      res.status(200).json({
        statusCode: 200,
        message: 'OTP verification successful',
      });
    } else {
      res.status(401).json({
        statusCode: 401,
        message: 'Invalid OTP or verification key',
      });
    }
  } catch (error) {
    console.error('Error verifying OTP:', error);
    res.status(500).json({
      statusCode: 500,
      message: 'Error verifying OTP',
    });
  } 
});

app.post("/uploadCSV", (req, res) => {
  // Send an HTTP GET request to the remote CSV file
  https.get(
    "https://raw.githubusercontent.com/BishalBudhathoki/backend_rest_api/main/holiday.csv",
    (response) => {
      const holidays = [];
      // Pipe the response data to csv.parse
      response
        .pipe(csv())
        .on("data", (data) => {
          // Replace null bytes in the keys
          const updatedData = {};
          Object.keys(data).forEach((key) => {
            const updatedKey = key.replace(/\0/g, "_"); // Replace null bytes with underscores
            updatedData[updatedKey] = data[key];
          });

          holidays.push(updatedData);
        })
        .on("end", () => {
          if (holidays.length === 0) {
            console.error("Error: No rows in CSV file");
            res.status(500).json({ message: "Internal Server Error" });
            return;
          }
          // Connect to MongoDB
          MongoClient.connect(uri, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
          })
            .then((client) => {
              const db = client.db("Invoice");
              const collection = db.collection("holidaysList");
              collection
                .deleteMany({})
                .then(() => {
                  // Insert the new data into the MongoDB collection
                  collection
                    .insertMany(holidays)
                    .then((result) => {
                      // console.log(`${result.insertedCount} documents inserted`);
                      client.close();
                      res.status(200).json({ message: "Upload successful" });
                    })
                    .catch((err) => {
                      console.error("Error inserting documents: ", err);
                      client.close();
                      res
                        .status(500)
                        .json({ message: "Internal Server Error" });
                    });
                })
                .catch((err) => {
                  console.error("Error deleting documents: ", err);
                  client.close();
                  res.status(500).json({ message: "Internal Server Error" });
                });
            })
            .catch((err) => {
              console.error("Error connecting to database: ", err);
              res.status(500).json({ message: "Internal Server Error" });
            });
        });
    }
  );
});

app.delete("/deleteHoliday/:id", (req, res) => {
  var id = req.params.id;
  // console.log(id);
  // Connect to MongoDB
  MongoClient.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
    .then((client) => {
      const db = client.db("Invoice");
      const collection = db.collection("holidaysList");

      // Delete the document with the given ID
      collection
        .deleteOne({ _id: ObjectId(id) })
        .then((result) => {
          console.log(`${result.deletedCount} documents deleted`);
          client.close();
          res.status(200).json({ success: true, message: "Delete successful" });
        })
        .catch((err) => {
          console.error("Error deleting document: ", err);
          client.close();
          res
            .status(500)
            .json({ success: false, message: "Internal Server Error" });
        });
    })
    .catch((err) => {
      console.error("Error connecting to database: ", err);
      res
        .status(500)
        .json({ success: false, message: "Internal Server Error" });
    });
});

app.post("/addHolidayItem", (req, res) => {
  const newHoliday = {
    Holiday: req.body.Holiday,
    Date: req.body.Date,
    Day: req.body.Day,
  };
  // console.log("newHoliday:", newHoliday);
  MongoClient.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
    .then((client) => {
      const db = client.db("Invoice");
      const collection = db.collection("holidaysList");

      // Insert the new holiday item into the MongoDB collection
      collection
        .insertOne(newHoliday)
        .then((result) => {
          console.log(`${result.insertedCount} document inserted`);
          client.close();
          res.status(200).json({ message: "Holiday item added successfully" });
        })
        .catch((err) => {
          console.error("Error inserting document: ", err);
          client.close();
          res.status(500).json({ message: "Internal Server Error" });
        });
    })
    .catch((err) => {
      console.error("Error connecting to database: ", err);
      res.status(500).json({ message: "Internal Server Error" });
    });
});

app.post("/check-holidays", async (req, res) => {
  try {
    const dateList = req.body.dateList.split(",");
    console.log(dateList);
    MongoClient.connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    })
      .then(async (client) => {
        const db = client.db("Invoice");
        const collection = db.collection("holidaysList");
        const query = { Date: { $in: dateList } };
        collection.find(query).toArray((err, result) => {
          if (err) {
            console.error("Error finding documents: ", err);
            client.close();
            res.status(500).json({ message: "Internal Server Error" });
          } else {
            console.log(result);
            const holidayStatusList = dateList.map((date) =>
              result.find((holiday) => holiday.Date === date)
                ? "Holiday"
                : "No Holiday"
            );
            client.close();
            res.status(200).json(holidayStatusList);
          }
        });
      })
      .catch((err) => {
        console.error("Error connecting to database: ", err);
        res.status(500).json({ message: "Internal Server Error" });
      });
  } catch (err) {
    console.error("Error: ", err);
    res.status(500).json({ message: "Internal Server Error" });
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.get("/user-docs", async (req, res) => {
  console.log("user-docs");
  try {
    MongoClient.connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    }).then(async (client) => {
      const db = client.db("Invoice");
      const loginCollection = db.collection("login");
      const assignedClientCollection = db.collection("assignedClient");

      const usersObj = await loginCollection
        .find(
          {},
          {
            projection: { _id: 0, firstName: 1, lastName: 1, email: 1, abn: 1 },
          }
        )
        .toArray();
      const users = Object.values(usersObj);
      //console.log(usersObj);
      const userDocs = [];

      for (const user of users) {
        const userEmail = user.email;
        const docs = await assignedClientCollection
          .find({ userEmail }, { projection: { _id: 0, userEmail: 0 } })
          .toArray();
        if (docs.length > 0) {
          // only push users with assigned docs
          userDocs.push({ email: userEmail, docs });
        }
      }

      const nonEmptyUserDocs = userDocs
        .map((userDoc) => {
          const nonEmptyDocs = userDoc.docs.filter(
            (doc) => doc.Time && doc.Time.length > 0
          );
          return { email: userDoc.email, docs: nonEmptyDocs };
        })
        .filter((userDoc) => userDoc.docs.length > 0);

      // read the clientEmails from the nonEmptyUserDocs
      const clientEmails = nonEmptyUserDocs
        .map((userDoc) => userDoc.docs.map((doc) => doc.clientEmail))
        .flat();
      console.log(clientEmails);

      // using clientEmails, get all the details of clients except for _id from
      // the clientDetails collection
      const clientDetailsCollection = db.collection("clientDetails");
      const clientDetails = await clientDetailsCollection
        .find(
          { clientEmail: { $in: clientEmails } },
          { projection: { _id: 0 } }
        )
        .toArray();
      console.log(clientDetails);

      // Filter usersObj based on emails present in nonEmptyUserDocs
      const filteredUsersObj = usersObj.filter((userObj) => {
        return nonEmptyUserDocs.some(
          (userDoc) => userDoc.email === userObj.email
        );
      });

      console.log(nonEmptyUserDocs, filteredUsersObj);
      res.send({
        user: filteredUsersObj,
        clientDetail: clientDetails,
        userDocs: nonEmptyUserDocs,
      });
    });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: "Internal Server Error" });
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.get("/getHolidays", (req, res) => {
  // Connect to MongoDB
  MongoClient.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
    .then((client) => {
      const db = client.db("Invoice");
      const collection = db.collection("holidaysList");

      // Find all documents in the collection
      collection
        .find()
        .toArray()
        .then((holidays) => {
          client.close();
          res.status(200).json(holidays);
        })
        .catch((err) => {
          console.error("Error retrieving documents: ", err);
          client.close();
          res.status(500).json({ message: "Internal Server Error" });
        });
    })
    .catch((err) => {
      console.error("Error connecting to database: ", err);
      res.status(500).json({ message: "Internal Server Error" });
    });
});

app.post("/setWorkedTime", (req, res) => {
  var userEmail = req.body["User-Email"];
  var clientEmail = req.body["Client-Email"];
  var time = req.body.TimeList;
  console.log(userEmail, clientEmail, time);
  var today = new Date();
  var formattedDate = today.toLocaleDateString("en-US", { weekday: "short" }); // format the current day as short name (e.g. Thu)

  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;
    var dbo = db.db("Invoice");
    var query = { userEmail: userEmail, clientEmail: clientEmail };
    var update = { $push: { Time: `${time} ${formattedDate}` } }; // use $push to add time to the array
    dbo
      .collection("assignedClient")
      .updateOne(query, update, (error, result) => {
        if (error) {
          console.error(error);
          res.status(500).send("Unexpected error occurred");
        } else {
          res.status(200).send("Updated successfully");
        }
        db.close();
      });
  });
  // MongoClient.connect(uri, function (err, db) {
  //     if (err) throw err;
  //     var dbo = db.db("Invoice");
  //     var update = { $set: { Time: [] } }; // set Time field to an empty array
  //     dbo
  //       .collection("assignedClient")
  //       .updateMany({}, update, (error, result) => {
  //         if (error) {
  //           console.error(error);
  //           res.status(500).send("Unexpected error occurred");
  //         } else {
  //           res.send("Reset successful");
  //         }
  //         db.close();
  //       });
  //   });
});

app.post("/assignClientToUser/", function (req, res) {
  var userEmail = req.body.userEmail;
  var clientEmail = req.body.clientEmail;
  var dateList = req.body.dateList;
  var startTimeList = req.body.startTimeList;
  var endTimeList = req.body.endTimeList;
  var breakList = req.body.breakList;
  console.log("Set assigned called");
  try {
    MongoClient.connect(uri, function (err, db, res) {
      if (err) throw err;
      var dbo = db.db("Invoice");
      var myquery = {
        userEmail: userEmail,
        clientEmail: clientEmail,
        dateList: dateList,
        startTimeList: startTimeList,
        endTimeList: endTimeList,
        breakList: breakList,
      };
      //var newvalues = { $set: {assignedClient: assignedClient} };
      dbo
        .collection("assignedClient")
        .insertOne(myquery, { unique: true }, function (err, result) {
          if (err) {
            console.log(err);
            return res.status(400).jsonp({
              message: "Error",
            });
          }
          console.log("1 document inserted");
          db.close();
        });
    });
    return res.status(200).jsonp({
      message: "Success",
    });
  } catch (error) {
    console.log("error");
  }
});

app.post("/addClient", async function (req, res) {
  var client = {
    clientFirstName: req.body.clientFirstName,
    clientLastName: req.body.clientLastName,
    clientEmail: req.body.clientEmail,
    clientPhone: req.body.clientPhone,
    clientAddress: req.body.clientAddress,
    clientCity: req.body.clientCity,
    clientState: req.body.clientState,
    clientZip: req.body.clientZip,
    clientBusinessName: req.body.businessName,
  };
try {
  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;
    var dbo = db.db("Invoice");
    // dbo.collection("clientDetails").createIndex({clientId: 2}, {unique:true} );
    dbo
      .collection("clientDetails")
      .insertOne(
        client,
        { unique: true, upsert: true },
        function (err, result) {
          if (err) {
            console.log(err);
            return res.status(400).jsonp({
              message: "error",
            });
          }
          //res.send(result.email);
          // console.log(firstName, lastName, email, phone, address, city, state, zip);
          db.close();
        }
      );
  });
  return res.status(200).jsonp({
    message: "success",
  });
} catch (error) {
  console.log("error");
} finally {
  // Ensures that the client will close when you finish/error
  await client.close();
}
});

app.post("/addBusiness", async function (req, res) {
  var business = {
    businessName: req.body.businessName,
    businessEmail: req.body.businessEmail,
    businessPhone: req.body.businessPhone,
    businessAddress: req.body.businessAddress,
    businessCity: req.body.businessCity,
    businessState: req.body.businessState,
    businessZip: req.body.businessZip,
  };
try {
  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;
    var dbo = db.db("Invoice");
    // dbo.collection("clientDetails").createIndex({clientId: 2}, {unique:true} );
    dbo
      .collection("businessDetails")
      .insertOne(
        business,
        { unique: true, upsert: true },
        function (err, result) {
          if (err) {
            console.log(err);
            return res.status(400).jsonp({
              message: "error",
            });
          }
          db.close();
        }
      );
  });
  return res.status(200).jsonp({
    message: "success",
  });
} catch (error) {
  console.log("error");
} finally {
  // Ensures that the client will close when you finish/error
  await client.close();
}
});

app.get("/business-names", async (req, res) => {
  try {
    const client = await MongoClient.connect(uri);
    const db = client.db("Invoice");
    const businessDetails = db.collection("businessDetails");
    const result = await businessDetails
      .find({}, { projection: { _id: 0, businessName: 1 } })
      .toArray();
    res.send(result);
    client.close();
  } catch (error) {
    console.log(error);
    res.status(500).send("Error retrieving business names from database.");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

const path = require('path');

app.post("/uploadPhoto", upload.single("photo"), async (req, res) => {
  try {
    console.log("Upload photo called");
    const { email } = req.body; // Assuming you're receiving the user's email address in the request body
    // console.log(req.body);
    // Check if the request has a photo
    if (!req.file) {
      // The request does not have a photo
      console.log("No photo provided");
      res.status(400).json({
        message: "No photo was uploaded"
      });
      return;
    }

    // Read the photo data from disk
    const photoPath = req.file.path;
    const photoData = await fs.promises.readFile(photoPath);
    const client = await MongoClient.connect(uri);
    const db = client.db('Invoice');

    // Check if a photo exists for the given email
    const existingPhoto = await db.collection('userPhoto').findOne({ email });
    if (existingPhoto) {
      // Update the existing photo
      await db.collection('userPhoto').updateOne({ email }, { $set: { photoData } });
      console.log("Photo updated");
    } else {
      // Insert a new photo entry
      const originalFilename = req.file.originalname;
      const photo = { email, filename: originalFilename, photoData };
      await db.collection('userPhoto').insertOne(photo);
      console.log("New photo uploaded");
    }

    res.status(200).json({ message: 'Photo uploaded successfully' });
  } catch (error) {
    console.error("Error uploading photo:", error);
    res.status(500).json({ message: "Error uploading photo" });
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.get("/getUserPhoto/:email", async (req, res) => {
  try {
    console.log("Get user photo called");
    const { email } = req.params;
    const client = await MongoClient.connect(uri);
    const db = client.db('Invoice');

    // Find the photo data for the given email
    const photo = await db.collection('userPhoto').findOne({ email });
    if (!photo) {
      res.status(404).json({ message: 'Photo not found' });
      return;
    }
    // Convert the photoData to base64
    const base64PhotoData = photo.photoData.buffer.toString('base64');

    res.contentType('image/jpeg');
    res.send(base64PhotoData);
  } catch (error) {
    console.error("Error retrieving photo:", error);
    res.status(500).json({ message: "Error retrieving photo" });
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.post("/login", async (req, res) => {
  var emails = req.body.email;
  var hashedPassword = req.body.password;
  try {
  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;
    console.log("Connected to database" +req.body.email +req.body.password);
    var dbo = db.db("Invoice");
    dbo
      .collection("login")
      .findOne({ email: emails, password: hashedPassword }, function (err, result) {
        if (err) throw err;
        //if email not found
        if (result == null) {
          console.log("Email not found");
          return res.status(400).jsonp({
            message: "user not found",
          });
        } else {
          // console.log("User found" + result._id, emails, hashedPassword);
          return res.status(200).jsonp({
            message: "user found",
            role: result.role,
          });
        }
        //console.log(result.email);
        //res.send(result.email);

        db.close();
      });
  });
} catch (error) {
  console.log("error");
} finally {
  // Ensures that the client will close when you finish/error
  await client.close();
}
  //res.send("Active");
});

app.delete("/deleteUser/", async (req, res) => {
  var email = req.body.email;
  // console.log(email);
  try {
  // Connect to MongoDB
  MongoClient.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
    .then((client) => {
      const db = client.db("Invoice");
      const collection = db.collection("login");

      // Delete the document with the given ID
      collection
        .deleteOne({ email: email })
        .then((result) => {
          console.log(`${result.deletedCount} documents deleted`);
          client.close();
          res.status(200).json({ success: true, message: "User deleted successfully" });
        })
        .catch((err) => {
          console.error("Error deleting document: ", err);
          client.close();
          res
            .status(500)
            .json({ success: false, message: "Internal Server Error" });
        });
    })
    .catch((err) => {
      console.error("Error connecting to database: ", err);
      res
        .status(500)
        .json({ success: false, message: "Internal Server Error" });
    });
  } catch (error) {
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});


app.post('/getSalt', async (req, res) => {
  const email = req.body.email;
  // console.log('Email:', req.body);
  try {
    //run().catch(console.dir);
    const client = await MongoClient.connect(uri, function (err, db) {
      if (err) throw err;
      console.log('Connected to database');
      var dbo = db.db("Invoice");
      dbo.collection("login").findOne({ email }, function (err, result) {
        if (err) {
          print(err);
          throw err;
        }
  
        // If email not found
        if (!result) {
          console.log('Email not found');
          return res.status(400).json({
            message: 'User not found',
          });
        } else {
          const salt = result.password.substring(64);
          // console.log('Salt found:', salt);
          return res.status(200).json({
            message: 'Salt found',
            salt: salt,
          });
        }
      });
    });
  } catch (error) {
    console.error("Salt error: "+err);

    return res.status(500).json({
      message: 'Internal Server Error',
    }); 
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.get("/getUsers/", async (req, res) => {
  //var email = req.params.email;
  try {
  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;
    var dbo = db.db("Invoice");
    var apt = dbo
      .collection("login")
      .find({})
      .toArray(function (err, login) {
        var list = [];
        if (err) throw err;
        //if email not found
        if (login == null) {
          return res.status(400).jsonp({
            firstName: "",
            lastName: "",
            email: "",
            abn: "",
          });
        } else {
          // console.log("User found" + login[0].toString());
          for (var i = 0; i < login.length; i++) {
            list.push(login[i]);
            console.log(list);
          }
          return res.send(JSON.stringify(list));
        }

        db.close();
      });
    // console.log(apt);
  });
} catch (error) {
  console.log("error");
} finally {
  // Ensures that the client will close when you finish/error
  await client.close();
}
  //res.send("Active");
});

app.get("/getClients/", async (req, res) => {
  //var email = req.params.email;
  
  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;
    var dbo = db.db("Invoice");
    var apt = dbo
      .collection("clientDetails")
      .find({})
      .toArray(function (err, clientDetails) {
        var list = [];
        if (err) throw err;
        //if email not found
        if (clientDetails == null) {
          return res.status(400).jsonp({
            clientFirstName: "",
            clientLastName: "",
            clientEmail: "",
          });
        } else {
          // console.log("Client found" + clientDetails[0].toString());
          for (var i = 0; i < clientDetails.length; i++) {
            list.push(clientDetails[i]);
            // console.log(list);
          }
          return res.send(JSON.stringify(list));
        }
      });
    // console.log(apt);
  }).close();
  //res.send("Active");
});

app.get("/getLineItems/", async (req, res) => {
  try {
    MongoClient.connect(uri, function (err, db) {
      if (err) throw err;
      var dbo = db.db("Invoice");
      var apt = dbo
        .collection("lineItems")
        .find({})
        .toArray(function (err, lineItems) {
          if (err) throw err;
          //if no line items found
          if (lineItems == null) {
            return res.status(400).jsonp({
              itemNumber: "",
              itemDescription: "",
            });
          } else {
            // console.log("Line items found" + lineItems[0].toString());
            var list = lineItems.map(function (lineItem) {
              return {
                itemNumber: lineItem.itemNumber,
                itemDescription: lineItem.itemDescription,
              };
            });
            // console.log(list);
            return res.send(JSON.stringify(list));
          }
          db.close();
        });
      // console.log(apt);
    });
  } catch (error) {
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.get("/initData/:email", async (req, res) => {
  var email = req.params.email;
  try {
    MongoClient.connect(uri, function (err, db) {
      if (err) throw err;
      var dbo = db.db("Invoice");
      dbo.collection("login").findOne({ email }, function (err, result) {
        if (err) throw err;
        //if email not found
        if (result == null) {
          return res.status(400).jsonp({
            firstName: "",
            lastName: "",
          });
        } else {
          return res.status(200).jsonp({
            firstName: result.firstName,
            lastName: result.lastName,
          });
        }
        //console.log(result.email);
        //res.send(result.email);
      });
  
      //db.close();
    });
  } catch (error) {
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
  //res.send("Active");
});

app.get("/getMultipleClients/:emails", async (req, res) => {
  // console.log(req.params.emails);
  // Split the email string by the comma separator
  var emails = req.params.emails.split(",");
  try {
    MongoClient.connect(uri, function (err, db) {
      if (err) throw err;
      var dbo = db.db("Invoice");
      // Use the $in operator to query the database for documents where the clientEmail field is in the list of emails
      var apt = dbo
        .collection("clientDetails")
        .find({ clientEmail: { $in: emails } })
        .toArray(function (err, clientDetails) {
          var list = [];
          if (err) throw err;
          //if email not found
          if (clientDetails == null) {
            console.log("Client not found");
            return res.status(400).jsonp({
              clientFirstName: "",
              clientLastName: "",
              clientEmail: "",
            });
          } else {
            // console.log("Client found" + clientDetails[0].toString());
            for (var i = 0; i < clientDetails.length; i++) {
              list.push(clientDetails[i]);
              // console.log(list);
            }
            return res.send(JSON.stringify(list));
          }
  
          db.close();
        });
      // console.log(apt);
    });
  } catch (error) {
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.get("/loadAppointments/:email", async (req, res) => {
  // Get the email parameter from the route
  var email = req.params.email;
  try {
    // Connect to the MongoDB database
  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;

    // Get the 'assignedClient' collection
    var dbo = db.db("Invoice");
    var collection = dbo.collection("assignedClient");

    // Find all documents that match the email address
    collection.find({ userEmail: email }).toArray(function (err, result) {
      if (err) {
        // If an error occurs, send a 500 (Internal Server Error) status code and the error message in the response
        return res.status(500).json({ error: err.message });
      }

      if (result.length == 0) {
        // If no matching documents are found, send a 404 (Not Found) status code and an error message in the response
        return res.status(404).json({ error: "No matching documents found" });
      } else {
        // If matching documents are found, send a 200 (OK) status code and the data in the response
        // console.log(result);
        return res.status(200).json({ data: result });
      }
    
    });
  });
  } catch (error) {
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.get("/loadAppointmentDetails/:userEmail/:clientEmail", async (req, res) => {
  // Get the email parameter from the route
  var userEmail = req.params.userEmail;
  var clientEmail = req.params.clientEmail;
  try {
    // Connect to the MongoDB database
  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;

    // Get the 'assignedClient' and 'clientDetails' collections
    var dbo = db.db("Invoice");
    var assignedClientCollection = dbo.collection("assignedClient");
    var clientDetailsCollection = dbo.collection("clientDetails");

    let resultObj = { clientDetails: [], assignedClient: [] };

    clientDetailsCollection
      .find({ clientEmail: clientEmail })
      .toArray(function (err, result) {
        if (err) throw err;
        resultObj.clientDetails.push(...result);

        assignedClientCollection
          .find({ userEmail: userEmail })
          .toArray(function (err, result) {
            if (err) throw err;
            resultObj.assignedClient.push(...result);
            // console.log(resultObj);
            res.status(200).json({ data: resultObj });
            db.close();
          });
      });
  });
  } catch (error) {
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.get("/checkEmail/:email", async (req, res) => {
  var email = req.params.email;
  console.log("Check email called");
  try {
    MongoClient.connect(uri, function (err, db) {
    
      if (err) {
        console.error(err);
        return res.status(500).send("Database error");
      }
      var dbo = db.db("Invoice");
      dbo.collection("login").findOne({ email }, function (err, result) {
        
        if (err) {
          console.error(err);
          return res.status(500).send("Database error");
        }
        if (result === null) {
          return res.status(400).json({
            message: "Email not found",
          });
        } else {
          return res.status(200).json({
            email: result.email,
          });
        }
        
      });
      
    });
  } catch (error) {
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
});

app.post("/signup/:email", async function (req, res) {
  var firstName = req.body.firstName,
    lastName = req.body.lastName,
    email = req.body.email,
    password = req.body.password,
    abn = req.body.abn,
    role = req.body.role || "normal"; // Default role is "normal" if not specified
  console.log("Signup called");
  try {
    MongoClient.connect(uri, function (err, db) {
    
      if (err) {
        console.error(err);
        return res.status(500).send("Database error");
      }
      var dbo = db.db("Invoice");
      dbo.collection("login").insertOne(
        { firstName, lastName, email, password, abn, role },
        { unique: true },
        function (err, result) {
          //db.close();
          if (err) {
            console.error(err);
            return res.status(500).json({
              success: false,
              message: "Database Error",
              data: result.ops,
            });
          }
          console.log("Signup done"); // Logs the inserted document(s)
  
          // Send a success response
          return res.status(200).json({
            success: true,
            message: "Signup successful",
            data: result.ops,
          });
        }
      );
    });
  } catch (error) {
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
 
});

app.get("/getClientDetails/:email", async (req, res) => {
  var email = req.params.email;
  try {
    MongoClient.connect(uri, function (err, db) {
      if (err) throw err;
      var dbo = db.db("Invoice");
      dbo.collection("clientDetails").findOne({ email }, function (err, result) {
        if (err) throw err;
        //if email not found
        if (result == null) {
          return res.status(400).jsonp({
            email: "Client not found",
          });
        } else {
          return res.status(200).jsonp({
            clientFirstName: result.clientFirstName,
            clientLastName: result.clientLastName,
            clientAddress: result.clientAddress,
            clientCity: result.clientCity,
          });
        }
        //console.log(result.email);
        //res.send(result.email);
  
        db.close();
      });
    });
  } catch(error){
    console.log("error");
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
  //res.send("Active");
});


// catch 404 and forward to error handler
app.use(function (req, res, next) {
  /*var err = new Error('Not Found');
    err.status = 404;
    next(err);*/
  return res.status(404).json({
    success: false,
    message: "not found",
  });
});

if (app.get("env") === "development") {
  app.use(function (err, req, res, next) {
    console.log(err);
    return res.status(err.status || 500).jsonp({
      success: false,
      data: [
        {
          message: err.message,
        },
      ],
    });
  });
}

const server = app.listen(PORT, function () {
  console.log("Server up at http://localhost:" + PORT);
});

process.on("SIGTERM", () => {
  console.info("SIGTERM signal received.");
  console.log("Closing http server.");
  server.close(() => {
    console.log("Http server closed.");
  });
});

process.on("SIGINT", () => {
  console.info("SIGINT signal received.");
  console.log("Closing http server.");
  server.close(() => {
    console.log("Http server closed.");
  });
});
