const express = require('express');
const bodyParser = require('body-parser');
const mysql = require("mysql");

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
//   const collection = client.db("Invoice").collection("login");
//   // perform actions on the collection object
//   collection.insertOne({ 
//     "email": "bishalkc331@gmail.com", "password": "root123" });
//     if(err) console.log(err);
//   client.close();
});

// var con = mysql.createConnection({
//     host: 'sql164110.byetcluster.com',
//     user: 'epiz_31245973',
//     password: 'REDACTED_MONGODB_PASSWORD',
//     database: 'epiz_31245973_login',
//     multipleStatements: true,
//     connectTimeout: 90000
// });

// con.connect(function(err) {
//     if(err){
//       console.log("Error in the connection")
//       console.log(err)
//     }
//     else{
//       console.log(`Database Connected`)
//       connection.query(`SHOW DATABASES`, 
//       function (err, result) {
//         if(err)
//           console.log(`Error executing the query - ${err}`)
//         else
//           console.log("Result: ",result) 
//       })
//     }
// })


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
         
          db.close();
        });
    });
    //res.send("Active");
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
app.post('/signup/:email', function(req, res) {

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
                    if (err) throw err;
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
                    if (err) throw err;
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


