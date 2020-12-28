var AWS = require('aws-sdk');
var express = require('express');
var bodyParser = require('body-parser');
var path = require('path');
var expressSession = require('express-session');
var passport = require('passport');
var flash = require('connect-flash');
var app = express();

app.use(require('cookie-parser')());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(expressSession({
    secret: 'keyboard cat',
    resave: true,
    secure: true,
    saveUninitialized: true,
    cookie: {
        secure: true,
        maxAge: 24 * 60 * 60 * 1000
    }
}));
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());

AWS.config.region = process.env.REGION
app.set('view engine', 'ejs');
app.set('views', __dirname + '/Public/Views');
app.use(express.static(path.join(__dirname, 'Public')));
app.use(require('./routesConfig'));

var port = process.env.PORT || 3000;
var server = app.listen(port, function () {
    console.log('Server running at http://127.0.0.1:' + port + '/');
});