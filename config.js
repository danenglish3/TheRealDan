var app = require('express')();
var pjson = require('./package.json');

module.exports = {
    'dbConfig': {
        'user': process.env.user || 'admin',
        'password': process.env.password || 'admin',
        'server': process.env.server || 'localhost\\SQLEXPRESS',
        'database': "TheRealDan",
        'port': process.env.port, //3000,
        'options': {
            'excrypt': true,
            "enableArithAbort": true
        }
    },
    'token': {
        'jwtSecret': 'SL-stoErg6OqfdZv32"3[Tg"-(.m^3',
        'expiresIn': '24h'
    },
    'spotify': {
        'authoriseEndpoint': 'https://accounts.spotify.com/authorize',
        'tokenEndpoint': 'https://accounts.spotify.com:443/api/token',
        'authoriseScopes': 'user-read-private user-read-email user-modify-playback-state user-read-currently-playing',
        'authoriseCallback': process.env.authoriseCallback || 'http://127.0.0.1:3000/api/callback',
        'clientId': 'eeae1743e10c4c548a3a0a5d43e01595',
        'clientSecret': '3f2fb62f975548cca7ed33493d856ddc',
        'search': 'https://api.spotify.com/v1/search',
        'addToQueueEndpoint': 'https://api.spotify.com/v1/me/player/queue',
        'searchArtist': 'https://api.spotify.com/v1/artists/{id}/top-tracks?country=NZ',
        'hostPlaylists': 'https://api.spotify.com/v1/me/playlists',
        'hostCurrentSong': 'https://api.spotify.com/v1/me/player/currently-playing'
    }
}