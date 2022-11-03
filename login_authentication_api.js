const express = require('express');
const bodyParser = require('body-parser');
const mysql = require("mysql");

var app = express();

var con = mysql.createConnection({
    host: 'sql113.epizy.com',
    user: 'epiz_31245973',
    password: 'REDACTED_MONGODB_PASSWORD',
    database: 'epiz_31245973_login'
});

con.connect(function(err) {
    if(err){
      console.log("Error in the connection")
      console.log(err)
    }
    else{
      console.log(`Database Connected`)
      connection.query(`SHOW DATABASES`, 
      function (err, result) {
        if(err)
          console.log(`Error executing the query - ${err}`)
        else
          console.log("Result: ",result) 
      })
    }
})


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
    const sqlInsert = "SELECT * FROM login";
    con.query(sqlInsert, (error, result) => {
        res.send("Data send to the Database");
        error.send(error)
    })
    res.send("Active");
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


var port = process.env.PORT || 9001;

const server = app.listen(port, function() {
    console.log('Server up at http://localhost:' + port);
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