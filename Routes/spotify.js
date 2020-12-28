const express = require('express');
const spotify = express.Router();
const config = require('../config').spotify;
const db = require('../database');
const service = require('../spotify-service');

spotify.get('/*', function (req, res, next) {
    next();
});

spotify.get('/', async function (req, res) {
    try {
        let pin = req.url.split('=')[1];
        let sid = req.cookies["connect.sid"];
        let hostSID = await db.spotify.getHostSID(pin);
        let isHost = hostSID === sid;

        res.render('spotifyparty', { isHost: isHost });
    } catch (err) {
        res.status(500).end('{"success" : false, "status" : 500, sessage: "Something happened.", err": '+ err + '}');
    }
});

spotify.get('/login', function(req, res) {
    res.redirect(config.authoriseEndpoint +
        '?response_type=code' +
        '&client_id=' + config.clientId +
        '&scope=' + encodeURIComponent(config.authoriseScopes) +
        '&redirect_uri=' + encodeURIComponent(config.authoriseCallback));
});

spotify.get('/hostsPlaylists', async function(req, res) {
    try {
        var pin = req.query.pin;
        var token = await db.spotify.getToken(pin);
        var results = await service.getHostsPlaylists(token);

        if (results.items) {
            res.status(200).end('{"success" : true, "status" : 200, "data":' + JSON.stringify(results.items) + '}');
        } else {
            res.status(200).end('{"success" : false, "status" : 400, "message": "' + results.message + '"}');
        }
    } catch (err) {
        res.status(500).end('{"success" : false, "status" : 500, sessage: "Something happened.", err": '+ err + '}');
    }
});

spotify.get('/checkIfHost', async function(req, res) {
    try {
        var pin = req.query.pin;
        let sid = req.cookies["connect.sid"];
        var hostSID = await db.spotify.getHostSID(pin);
        let isHost = hostSID === sid;

        res.status(200).end('{"success" : true, "status" : 200, "isHost":' + sid == hostSID + '}');
    } catch (err) {
        res.status(500).end('{"success" : false, "status" : 500, sessage: "Something happened.", err": '+ err + '}');
    }
});

spotify.get('/hostsCurrentSong', async function(req, res) {
    try {
        var pin = req.query.pin;
        var token = await db.spotify.getToken(pin);
        var results = await service.getHostsCurrentlyPlayingSong(token);

        if (results.status == "200") {
            res.status(200).end('{"success" : true, "status" : 200, "data":' + JSON.stringify(results.body) + '}');
        } else if (results.status == "204"){
            res.status(200).end('{"success" : true, "status" : 204, "message": "No content currently playing."}');
        } else {
            res.status(200).end('{"success" : false, "status" : 400, "message": "' + results.message + '"}');
        }
    } catch (err) {
        res.status(500).end('{"success" : false, "status" : 500, sessage: "Something happened.", err": '+ err + '}');
    }
});

spotify.get('/addSong', async function(req, res) {
    try {
        db.spotify.removeInactivePins()
        var uri = req.query.uri;
        var pin = req.query.pin;
        var token = await db.spotify.getToken(pin);
        var results = await service.addSongToQueue(token, uri);

        if (results.success) {
            res.status(200).end('{"success" : true, "status" : 200}');
        } else {
            res.status(200).end('{"success" : false, "status" : 400, "message": "' + results.message + '"}');
        }
    } catch (err) {
        res.status(500).end('{"success" : false, "status" : 500, sessage: "Something happened.", err": '+ err + '}');
    }
});

spotify.get('/search', async function(req, res) {
    try {
        var query = req.query.query;
        var pin = req.query.pin;
        var offset = req.query.offset;
        var token = await db.spotify.getToken(pin);
        var results = await service.search(token, query, offset);

        if (results) {
            res.status(200).end('{"success" : true, "status" : 200, "data": '+ JSON.stringify(results) +'}');
        } else {
            res.status(400).end('{"success" : false, "status" : 400, "message": "' + + '"}');
        }
    } catch(err) {
        res.status(500).end('{"success" : false, "status" : 500, message: "Something happened.", err": '+ err + '}');
    }
});

spotify.get('/searchArtist', async function(req, res) {
    try {
        var id = req.query.id;
        var pin = req.query.pin;
        var token = await db.spotify.getToken(pin);
        var results = await service.searchArtist(id, token);

        if (results) {
            res.status(200).end('{"success" : true, "status" : 200, "data": '+ JSON.stringify(results) +'}');
        } else {
            res.status(400).end('{"success" : false, "status" : 400, "message": "' + + '"}');
        }
    } catch(err) {
        res.status(500).end('{"success" : false, "status" : 500, message: "Something happened.", err": '+ err + '}');
    }
});

spotify.get('/createPlaylist', async function(req, res) {
    try {
        var pin = req.query.pin;
        var name = req.query.name;
        var token = await db.spotify.getToken(pin);
        var profileResults = await service.getHostsProfile(token);
        
        if (typeof profileResults.id == "undefined") {
            res.status(400).end('{"success" : false, "status" : 400, "message": "Something happened."}');
        }

        var id = profileResults.id;

        var playlistResults = await service.createPlaylist(token, name, id);

        if (playlistResults.success) {
            res.status(200).end('{"success" : true, "status" : 200, "data": '+ JSON.stringify(results) +'}');
        } else {
            res.status(400).end('{"success" : false, "status" : 400, "message": "' + + '"}');
        }
    } catch(err) {
        res.status(500).end('{"success" : false, "status" : 500, message: "Something happened.", err": '+ err + '}');
    }
});

module.exports = spotify;