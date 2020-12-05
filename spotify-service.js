const config = require("./config").spotify;
const superagent = require('superagent');
const db = require("./database");

exports.requestToken = function(code, callback, sid) {
    superagent.post(config.tokenEndpoint)
    .send({
        client_id: config.clientId,
        client_secret: config.clientSecret,
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: config.authoriseCallback
    })
    .type('form')
    .end(async (err, res) => {
        if (res) {
            var pin = Math.floor(100000 + Math.random() * 900000);
            await db.spotify.insertUser(res.body.access_token, res.body.refresh_token, res.body.expires_in, pin, sid);

            callback(true, "", pin);
        }

        callback(false, "Problem getting the api token", err);
    });
}
exports.getHostsPlaylists = async function(token) {
    return new Promise((resolve, reject) => {
        let url = encodeURI(config.hostPlaylists);
        superagent.get(url)
            .set('Authorization', 'Bearer ' + token.AccessToken)
            .then(res => {
                resolve(res.body);
            })
            .catch(err => {
                console.log(err.status);
                if (err.status == "401" || err.status == 401) {
                    var accessToken = refreshToken(token);

                    superagent.get(url)
                    .set('Authorization', 'Bearer ' + accessToken)
                    .then(res => {
                        resolve(res.body);
                    })
                    .catch(err => {
                        reject(err);
                    })
                } else {
                    reject(err);
                }
            });
    });
}

exports.search = async function(token, query, offset) {
    return new Promise((resolve, reject) => {
        let url = encodeURI(config.search + "?q=" + query + "&type=artist,track&limit=12&offset=" + offset);
        superagent.get(url)
            .set('Authorization', 'Bearer ' + token.AccessToken)
            .then(res => {
                resolve(res.body.tracks.items);
            })
            .catch(err => {
                console.log(err.status);
                if (err.status == "401" || err.status == 401) {
                    var accessToken = refreshToken(token);

                    superagent.get(url)
                    .set('Authorization', 'Bearer ' + accessToken)
                    .then(res => {
                        resolve(res.body.tracks.items);
                    })
                    .catch(err => {
                        reject(err);
                    })
                } else {
                    reject(err);
                }
            });
    });
}

exports.searchArtist = async function(id, token) {
    return new Promise((resolve, reject) => {
        let url = encodeURI(config.searchArtist.replace('{id}', id));
        superagent.get(url)
            .set('Authorization', 'Bearer ' + token.AccessToken)
            .then(res => {
                resolve(res.body.tracks);
            })
            .catch(err => {
                console.log(err);
                if (err.status == "401" || err.status == 401) {
                    var accessToken = refreshToken(token);

                    superagent.get(url)
                    .set('Authorization', 'Bearer ' + accessToken)
                    .then(res => {
                        resolve(res.body.tracks);
                    })
                    .catch(err => {
                        reject(err);
                    })
                } else {
                    reject(err);
                }
            });
    });
}

exports.addSongToQueue = async function(token, uri) {
    return new Promise((resolve, reject) => {
        superagent.post(config.addToQueueEndpoint + '?uri='+uri)
        .set('Authorization', 'Bearer ' + token.AccessToken)
        .then(res => {
            resolve({"success": true});
        })
        .catch(res => {
            var error = res.response.body.error;
            
            if (error.status == "401" && error.message == "The access token expired") {
                var accessToken = refreshToken(token);

                superagent.post(config.addToQueueEndpoint + '?uri='+uri)
                .set('Authorization', 'Bearer ' + accessToken)
                .then(res => {
                    resolve(res);
                })
                .catch(err => {
                })
            } else if (error.status == "404") {
                resolve({"success": false, "message": "No active device found."});
            }
        });
    })
}

async function refreshToken(token) {
    return new Promise((resolve, reject) => {
        let data = config.clientId + ":" + config.clientSecret;
        let buff = new Buffer(data);
        let base64 = buff.toString('base64');
    
        superagent.post(config.tokenEndpoint)
        .set('Authorization', 'Basic ' + base64)
        .send({
            grant_type: 'refresh_token',
            refresh_token: token.RefreshToken
        })
        .type('form')
        .end(async (err, res) => {
            if (res != null) {
                await db.spotify.updateToken(res.body.access_token, token.Identifier);
                resolve(res.body.access_token);
            } else {
            }
        });
    })
}