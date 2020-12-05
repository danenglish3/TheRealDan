const express = require('express');
const account = express.Router();

account.get('/ping', function (req, res) {
    res.status(200).send("Pinged account").end();
});

module.exports = account;