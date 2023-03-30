const express = require('express');
const bodyParser = require('body-parser');
const iconv = require('iconv-lite');
const fs = require('fs');
const csv = require('csv-parser');
const https = require('https');
const xlsx = require('xlsx');

var app = express();

var PORT = process.env.PORT || 9001;
const serverOptions = {
    poolsize:100 ,
    socketOptions:{
        socketTimeoutMS: 6000000
        }
    };

const { MongoClient, ServerApiVersion } = require('mongodb');
const uri = "mongodb+srv://username:password@cluster.mongodb.net/invoice?retryWrites=true&w=majority";
const client = new MongoClient(  process.env.MONGODB_URI || uri, { useNewUrlParser: true, useUnifiedTopology: true, serverApi: ServerApiVersion.v1 });
// process.env.MONGODB_URI ||

MongoClient.connect( process.env.MONGODB_URI || uri, function(err, db)  {
    
  if (err) throw err;
  var dbo = db.db("Invoice");
  dbo.collection("login").findOne({}, function(err, result) {
    if (err) throw err;
    console.log(result.email);
    db.close();
  });
});


app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

app.use(function(req, res, next) {
    res.header("Content-Type", 'application/json');
    res.header("Access-Control-Allow-Origin", "*");
    next();
});

app.get("/", (req, res) => {
    res.send("Active");
});

// app.post('/upload', (req, res) => {
//     // Read the contents of the CSV file
//     const fileStream = fs.createReadStream('https://github.com/BishalBudhathoki/backend_rest_api/blob/main/holiday.csv');
//     const holidays = [];
  
//     fileStream.pipe(csv())
//       .on('data', (data) => {
//         // Replace null bytes in the keys
//         const updatedData = {};
//         Object.keys(data).forEach((key) => {
//           const updatedKey = key.replace(/\0/g, '_'); // Replace null bytes with underscores
//           updatedData[updatedKey] = data[key];
//         });
  
//         holidays.push(updatedData);
//       })
//       .on('end', () => {
//         // Connect to MongoDB
//         MongoClient.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
//           .then(client => {
//             const db = client.db('Invoice');
//             const collection = db.collection('holidaysList');
            
//             // Insert the data into the MongoDB collection
//             collection.insertMany(holidays)
//               .then(result => {
//                 console.log(`${result.insertedCount} documents inserted`);
//                 client.close();
//                 res.send('Upload successful');
//               })
//               .catch(err => {
//                 console.error('Error inserting documents: ', err);
//                 client.close();
//                 res.status(500).send('Internal Server Error');
//               });
//           })
//           .catch(err => {
//             console.error('Error connecting to database: ', err);
//             res.status(500).send('Internal Server Error');
//           });
//       });
//   });

app.post('/uploadCSV', (req, res) => {
    // Send an HTTP GET request to the remote CSV file
    https.get('https://raw.githubusercontent.com/BishalBudhathoki/backend_rest_api/main/holiday.csv', (response) => {
        const holidays = [];  
    // Pipe the response data to csv.parse
    response.pipe(csv())
    .on('data', (data) => {
        // Replace null bytes in the keys
        const updatedData = {};
        Object.keys(data).forEach((key) => {
            const updatedKey = key.replace(/\0/g, '_'); // Replace null bytes with underscores
            updatedData[updatedKey] = data[key];
        });

        holidays.push(updatedData);
    })
    .on('end', () => {
        if (holidays.length === 0) {
            console.error('Error: No rows in CSV file');
            res.status(500).json({ message: 'Internal Server Error'});
            return;
        }
        // Connect to MongoDB
        MongoClient.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
            .then(client => {
                const db = client.db('Invoice');
                const collection = db.collection('holidaysList');

                // Insert the data into the MongoDB collection
                collection.insertMany(holidays)
                    .then(result => {
                        console.log(`${result.insertedCount} documents inserted`);
                        client.close();
                        res.status(200).json({ message: 'Upload successful' });
                    })
                    .catch(err => {
                        console.error('Error inserting documents: ', err);
                        client.close();
                        res.status(500).json({ message: 'Internal Server Error'});
                    });
            })
            .catch(err => {
                console.error('Error connecting to database: ', err);
                res.status(500).json({ message: 'Internal Server Error'});
            });
    });
});
});

app.get('/getHolidays', (req, res) => {
    // Connect to MongoDB
    MongoClient.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
      .then(client => {
        const db = client.db('Invoice');
        const collection = db.collection('holidaysList');
  
        // Find all documents in the collection
        collection.find().toArray()
          .then(holidays => {
            client.close();
            res.status(200).json(holidays);
          })
          .catch(err => {
            console.error('Error retrieving documents: ', err);
            client.close();
            res.status(500).json({ message: 'Internal Server Error'});
          });
      })
      .catch(err => {
        console.error('Error connecting to database: ', err);
        res.status(500).json({ message: 'Internal Server Error'});
      });
  });
  

app.post('/assignClientToUser/', function(req, res)  {
    var userEmail = req.body.userEmail;
    var clientEmail = req.body.clientEmail;
    var dateList = req.body.dateList;
    var startTimeList = req.body.startTimeList;
    var endTimeList = req.body.endTimeList;
    var breakList = req.body.breakList;
    console.log('Set assigned called');
   try {
    MongoClient.connect(uri, function(err, db, res)  {
        if (err) throw err;
        var dbo = db.db("Invoice");
        var myquery = { 
            'userEmail': userEmail, 
            'clientEmail': clientEmail,
            'dateList': dateList,
            'startTimeList': startTimeList,
            'endTimeList': endTimeList,
            'breakList': breakList
         };
        //var newvalues = { $set: {assignedClient: assignedClient} };
        dbo.collection("assignedClient").insertOne(myquery ,  {unique:true} ,function(err, result) {
            if (err) {
                console.log(err);
                return res
                .status(400)
                .jsonp({
                    'message': "Error",
            });
            }
            console.log("1 document inserted");
            db.close();
            
            }); 
            
    });
    return res
            .status(200)
            .jsonp({
                'message': "Success",
            });
   } catch(error){
    console.log("error");
   }
});

app.post('/signup/:email', function(req, res)  {

    var firstName = req.body.firstName,
        lastName = req.body.lastName,
        email = req.body.email,
        password = req.body.password;
        var emails = req.params.email;

        MongoClient.connect(uri, function(err, db)  {
            if (err) throw err;
            var dbo = db.db("Invoice");
                dbo.collection("login").insertOne({firstName, lastName, email, password}, {unique:true} ,function(err, result) {
                    if (err) throw err;
                    console.log(result.email);
                    //res.send(result.email);
                    
                    db.close();
                    
              });
            
           
        });
        //setAssignedClient(email);
        return res
                .status(200)
                .jsonp({
                    'firstName': firstName,
                    'lastName': lastName,
                    'email': email,
                    'password': password,
                });
});

app.post('/addClient', function(req, res) {

    var client = {
        clientFirstName: req.body.clientFirstName,
        clientLastName: req.body.clientLastName,
        clientEmail: req.body.clientEmail,
        clientPhone: req.body.clientPhone,
        clientAddress: req.body.clientAddress,
        clientCity: req.body.clientCity,
        clientState: req.body.clientState,
        clientZip: req.body.clientZip,
    } 

        MongoClient.connect(uri, function(err, db)  {
            if (err) throw err;
            var dbo = db.db("Invoice");
                // dbo.collection("clientDetails").createIndex({clientId: 2}, {unique:true} );
                dbo.collection("clientDetails").insertOne(
                  client
                , {unique: true, upsert: true} ,function(err, result) {
                    if (err) {
                        console.log(err);
                        return res
                        .status(400)
                        .jsonp({
                            message: "error",
                        });
                    }
                    //res.send(result.email);
                    // console.log(firstName, lastName, email, phone, address, city, state, zip);
                    db.close();
              });
            
           
        });
        return res
                .status(200)
                .jsonp({
                    message: 'success',
                });
});

app.post('/addBusiness', function(req, res) {

    var business = {
        businessName: req.body.businessName,
        businessEmail: req.body.businessEmail,
        businessPhone: req.body.businessPhone,
        businessAddress: req.body.businessAddress,
        businessCity: req.body.businessCity,
        businessState: req.body.businessState,
        businessZip: req.body.businessZip,
    } 

        MongoClient.connect(uri, function(err, db)  {
            if (err) throw err;
            var dbo = db.db("Invoice");
                // dbo.collection("clientDetails").createIndex({clientId: 2}, {unique:true} );
                dbo.collection("businessDetails").insertOne(
                  business
                , {unique: true, upsert: true} ,function(err, result) {
                    if (err) {
                        console.log(err);
                        return res
                        .status(400)
                        .jsonp({
                            message: "error",
                        });
                    }
                    db.close();
              });
            
           
        });
        return res
                .status(200)
                .jsonp({
                    message: 'success',
                });
});

app.post('/user/login', function(req, res) {

    var username = req.body.username,
        password = req.body.password;

    if (!username || !password) {
        return res
            .status(400)
            .jsonp({
                error: "Needs a json body with { username: <username>, password: <password>}"
            });
    }

    if (username !== password) {
        return res
            .status(401)
            .jsonp({
                error: "Authentication failied.",
            });
    }

    return res
        .status(200)
        .jsonp({
            'userId': '1908789',
            'username': username,
            'name': 'Peter Clarke',
            'lastLogin': "23 March 2020 03:34 PM",
            'email': 'x7uytx@mundanecode.com'
        });
});

app.get("/login/:email/:password", (req, res) => {
    var emails = req.params.email;
    var passwords = req.params.password;
    MongoClient.connect(uri, function(err, db)  {
        if (err) throw err;
        var dbo = db.db("Invoice");
        dbo.collection("login").findOne({email:emails,password:passwords}, function(err, result) {
          if (err) throw err;
          //if email not found
            if(result == null){
                console.log("Email not found");	
                return res
                .status(400)
                .jsonp({
                    message: "user not found",
                });
            } else {
                console.log("User found" +result._id, emails, passwords );
                return res
                .status(200)
                .jsonp({
                    message: 'user found',
                });
            }
          //console.log(result.email);
          //res.send(result.email);
         
          db.close();
        });
    });
    //res.send("Active");
});

app.get("/getUsers/", (req, res) => {
    //var email = req.params.email;
    MongoClient.connect(uri, function(err, db)  {
        if (err) throw err;
        var dbo = db.db("Invoice");
        var apt = dbo.collection("login").find({}).toArray(function(err, login) {
            var list = []; 
          if (err) throw err;
          //if email not found
            if(login == null){
                return res
                .status(400)
                .jsonp({
                    'firstName': '',
                    'lastName': '',
                    'email': '',
                });
            } else {
                console.log("User found" +login[0].toString());
                for(var i = 0; i < login.length; i++){
                    list.push(login[i]);
                     console.log(list);
                }
                return res.send(JSON.stringify(list)); 
            }

          db.close();
        });
        console.log(apt);
       
    });
    //res.send("Active");
});

app.get("/getClients/", (req, res) => {
    //var email = req.params.email;
    MongoClient.connect(uri, function(err, db)  {
        if (err) throw err;
        var dbo = db.db("Invoice");
        var apt = dbo.collection("clientDetails").find({}).toArray(function(err, clientDetails) {
            var list = []; 
          if (err) throw err;
          //if email not found
            if(clientDetails == null){
                return res
                .status(400)
                .jsonp({
                    'clientFirstName': '',
                    'clientLastName': '',
                    'clientEmail': '',
                });
            } else {
                console.log("Client found" +clientDetails[0].toString()); 
                for(var i = 0; i < clientDetails.length; i++){
                    list.push(clientDetails[i]);
                     console.log(list);
                }
                return res.send(JSON.stringify(list)); 
            }

          db.close();
        });
        console.log(apt);
       
    });
    //res.send("Active");
});

app.get("/getLineItems/", (req, res) => {
    MongoClient.connect(uri, function(err, db) {
        if (err) throw err;
        var dbo = db.db("Invoice");
        var apt = dbo.collection("lineItems").find({}).toArray(function(err, lineItems) {
            if (err) throw err;
            //if no line items found
            if (lineItems == null) {
                return res.status(400).jsonp({
                    'itemNumber': '',
                    'itemDescription': '',
                });
            } else {
                console.log("Line items found" + lineItems[0].toString()); 
                var list = lineItems.map(function(lineItem) {
                    return {
                        'itemNumber': lineItem.itemNumber,
                        'itemDescription': lineItem.itemDescription,
                    };
                });
                console.log(list);
                return res.send(JSON.stringify(list)); 
            }
            db.close();
        });
        console.log(apt);
    });
});

app.get("/initData/:email", (req, res) => {
    var email = req.params.email;
    MongoClient.connect(uri, function(err, db)  {
        if (err) throw err;
        var dbo = db.db("Invoice");
        dbo.collection("login").findOne({email}, function(err, result) {
          if (err) throw err;
          //if email not found
            if(result == null){
                return res
                .status(400)
                .jsonp({
                    'firstName': '',
                    'lastName': '',
                });
            } else {
                return res
                .status(200)
                .jsonp({
                    'firstName': result.firstName,
                    'lastName': result.lastName,
                });
            }
          //console.log(result.email);
          //res.send(result.email);
        });
        
        //db.close();
    });
    //res.send("Active");
});

app.get("/getMultipleClients/:emails", (req, res) => {
    console.log(req.params.emails);
    // Split the email string by the comma separator
    var emails = req.params.emails.split(',');
    MongoClient.connect(uri, function(err, db)  {
      if (err) throw err;
      var dbo = db.db("Invoice"); 
      // Use the $in operator to query the database for documents where the clientEmail field is in the list of emails
      var apt = dbo.collection("clientDetails").find({clientEmail: {$in: emails}}).toArray(function(err, clientDetails) {
        var list = []; 
        if (err) throw err;
        //if email not found
          if(clientDetails == null){
            console.log("Client not found");
              return res
              .status(400)
              .jsonp({
                  'clientFirstName': '',
                  'clientLastName': '',
                  'clientEmail': '',
              });
          } else {
              console.log("Client found" +clientDetails[0].toString()); 
              for(var i = 0; i < clientDetails.length; i++){
                  list.push(clientDetails[i]);
                   console.log(list);
              }
              return res.send(JSON.stringify(list)); 
          }
  
        db.close();
      });
      console.log(apt);
    });
  });
  
  app.get("/loadAppointments/:email", (req, res) => {
    // Get the email parameter from the route
    var email = req.params.email;
  
    // Connect to the MongoDB database
    MongoClient.connect(uri, function(err, db) {
      if (err) throw err;
  
      // Get the 'assignedClient' collection
      var dbo = db.db("Invoice");
      var collection = dbo.collection("assignedClient");
  
      // Find all documents that match the email address
      collection.find({'userEmail': email }).toArray(function(err, result) {
        if (err) {
          // If an error occurs, send a 500 (Internal Server Error) status code and the error message in the response
          return res.status(500).json({ error: err.message });
        }
  
        if (result.length == 0) {
          // If no matching documents are found, send a 404 (Not Found) status code and an error message in the response
          return res.status(404).json({ error: 'No matching documents found' });
        } else {
          // If matching documents are found, send a 200 (OK) status code and the data in the response
          console.log(result);
          return res.status(200).json({ data: result });
        }
        // Print the status code in the console
        console.log(`Status code: ${res.statusCode}`);
        // Close the database connection
        db.close();
      });
    });
  });

  app.get("/loadAppointmentDetails/:userEmail/:clientEmail", (req, res) => {
    // Get the email parameter from the route
    var userEmail = req.params.userEmail;
    var clientEmail = req.params.clientEmail;
  
    // Connect to the MongoDB database
    MongoClient.connect(uri, function(err, db) {
      if (err) throw err;
  
      // Get the 'assignedClient' and 'clientDetails' collections
      var dbo = db.db("Invoice");
      var assignedClientCollection = dbo.collection("assignedClient");
      var clientDetailsCollection = dbo.collection("clientDetails");
  
      let resultObj = {clientDetails: [], assignedClient: []};
  
      clientDetailsCollection.find({ clientEmail: clientEmail }).toArray(function(err, result) {
        if (err) throw err;
        resultObj.clientDetails.push(...result);
  
        assignedClientCollection.find({ userEmail: userEmail }).toArray(function(err, result) {
          if (err) throw err;
          resultObj.assignedClient.push(...result);
          console.log(resultObj);
          res.status(200).json({ data: resultObj });
          db.close();
   });
    });
  });
});
  
app.get("/hello/:email", (req, res) => {
    var email = req.params.email;
    MongoClient.connect(uri, function(err, db)  {
        if (err) throw err;
        var dbo = db.db("Invoice");
        dbo.collection("login").findOne({email}, function(err, result) {
          if (err) throw err;
          //console.log(result.email);
          //res.send(result.email);
          return res
            .status(200)
            .jsonp({
                'email': result.email,
                'password': result.password,
            });
          db.close();
        });
    });
    //res.send("Active");
});

app.get("/checkEmail/:email", (req, res) => {
    var email = req.params.email;
    MongoClient.connect(uri, function(err, db)  {
        if (err) throw err;
        var dbo = db.db("Invoice");
        dbo.collection("login").findOne({email}, function(err, result) {
          if (err) throw err;
          //if email not found
            if(result == null){
                return res
                .status(400)
                .jsonp({
                    'email': "Email not found",
                });
            } else {
                return res
                .status(200)
                .jsonp({
                    'email': result.email,
                });
            }
          //console.log(result.email);
          //res.send(result.email);
         
          db.close();
        });
    });
    //res.send("Active");
});

app.get("/getClientDetails/:email", (req, res) => {
    var email = req.params.email;
    MongoClient.connect(uri, function(err, db)  {
        if (err) throw err;
        var dbo = db.db("Invoice");
        dbo.collection("clientDetails").findOne({email}, function(err, result) {
          if (err) throw err;
          //if email not found
            if(result == null){
                return res
                .status(400)
                .jsonp({
                    'email': "Client not found",
                });
            } else {
                return res
                .status(200)
                .jsonp({
                    'clientFirstName': result.clientFirstName,
                    'clientLastName': result.clientLastName,
                    'clientAddress': result.clientAddress,
                    'clientCity': result.clientCity,
                });
            }
          //console.log(result.email);
          //res.send(result.email);
         
          db.close();
        });
    });
    //res.send("Active");
});

app.get('/getlogin', function(req, res) {

    var username = req.body.username,
        password = req.body.password;

    if (!username || !password) {
        return res
            .status(400)
            .jsonp({
                error: "Needs a json body with { username: <username>, password: <password>}"
            });
    }

    if (username !== password) {
        return res
            .status(401)
            .jsonp({
                error: "Authentication failed.",
            });
    }
    const sqlInsert = "SELECT * FROM login";
    con.query(sqlInsert, (error, result) => {
        if(error){
            res.send(error)
        } else {
            res.send(result)
        }
    });

    return res
        .status(200)
        .jsonp({
            'userId': '1908789',
            'username': username,
            'name': 'Peter Clarke',
            'lastLogin': "23 March 2020 03:34 PM",
            'email': 'x7uytx@mundanecode.com'
        });
});

app.get('/user/:id', function(req, res) {

    var userId = req.params.id;

    if (!userId) {
        return res
            .status(400)
            .jsonp({
                error: "Needs a json body with { username: <username>, password: <password>}",
            });
    }

    return res
        .status(200)
        .jsonp({
            'userId': '1908789',
            'username': 'pclarketx',
            'name': 'Peter Clarke',
            'lastLogin': "23 March 2020 03:34 PM",
            'email': 'x7uytx@mundanecode.com'
        });
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    /*var err = new Error('Not Found');
    err.status = 404;
    next(err);*/
    return res.status(404).json({
        success: false,
        message: "not found"
    });
});

if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        console.log(err);
        return res.status(err.status || 500).jsonp({
            success: false,
            "data": [{
                message: err.message
            }]
        });
    });
}

const server = app.listen(PORT, function() {
    console.log('Server up at http://localhost:' + PORT);
});

process.on('SIGTERM', () => {
    console.info('SIGTERM signal received.');
    console.log('Closing http server.');
    server.close(() => {
        console.log('Http server closed.');
    });
});

process.on('SIGINT', () => {
    console.info('SIGINT signal received.');
    console.log('Closing http server.');
    server.close(() => {
        console.log('Http server closed.');
    });
});


