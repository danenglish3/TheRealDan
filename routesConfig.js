var express = require('express');
var router = express.Router();
var config = require('./config.js');
const passport = require('passport');
const spotify = require('./spotify-service');
const url = require('url');

router.get('/*', function (req, res, next) {
    next();
});

router.get('/', async function (req, res) {
    var data = {};
    try {
        res.render('index', data);
    } catch(err) {
        console.log("Error: " + err);
    }
});

router.get('/ping', function (req, res) {
    res.status(200).end();
});

router.get('/api/callback', function (req, res) {
    if (!req.query.code)
    {
        res.render('index');
    }

    try {
        let sid = req.cookies["connect.sid"];
        console.log(req);
        console.log(sid);

        spotify.requestToken(req.query.code, function(success, message, response) {
            if (success) {
                res.redirect('/spotify?p='+response);
            } else {
            }
        }, sid)
    } catch (ex) {
        console.log(ex);
    }
});

router.get('/settings', function (req, res) {
    let sid = req.cookies["connect.sid"];
    res.render('spotifySettings');
});

router.use('/account', require('./Routes/account'));
router.use('/spotify', require('./Routes/spotify'));

module.exports = router;