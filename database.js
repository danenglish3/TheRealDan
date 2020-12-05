const sql = require('mssql');
const config = require('./config.js').dbConfig;
const poolPromise = new sql.ConnectionPool(config)
    .connect()
    .then(function(pool) {
        console.log('Connected to MSSQL');

        return pool;
    }).catch(function(err) {
        console.log('Database Connection Failed! Bad Config: ', err)
    });

//SPOTIFY
async function insertSpotifyUser(accessToken, refreshToken, expiresIn, pin, sid) {
    var pool = await poolPromise;
    var result = await pool.request()
        .input("AccessToken", accessToken)
        .input("RefreshToken", refreshToken)
        .input("ExpiresIn", expiresIn)
        .input("Pin", pin)
        .input("HostSessionId", sid)
        .output('Message', sql.NVarChar(Number.MAX_VALUE))
        .execute("dbo.SpotifyUser_Insert");

    return result;
}

async function getToken(pin) {
    var pool = await poolPromise;
    var result = await pool.request()
        .input("Pin", pin)
        .input("LastUsed", new Date())
        .execute("dbo.SpotifyToken_Select");

    return result.recordset[0];
}

async function updateToken(accessToken, identifier) {
    var pool = await poolPromise;

    var result = await pool.request()
        .input("AccessToken", accessToken)
        .input("Identifier", identifier)
        .execute("dbo.SpotifyToken_Update");
    
    return result.recordset[0];
}

async function removeInactivePins() {
    var pool = await poolPromise;

    var result = await pool.request()
        .execute("dbo.SpotifyUser_Delete");
}

async function getHostSID(pin) {
    var pool = await poolPromise;

    var result = await pool.request()
        .input("Pin", pin)
        .execute("dbo.SpotifyHost_Select");

    return result.recordset[0].HostSessionId;
}

module.exports.spotify = module.exports.spotify || {};
module.exports.account = module.exports.account || {};

//SPOTIFY
module.exports.spotify.insertUser = insertSpotifyUser;
module.exports.spotify.getToken = getToken;
module.exports.spotify.updateToken = updateToken;
module.exports.spotify.removeInactivePins = removeInactivePins;
module.exports.spotify.getHostSID = getHostSID;
