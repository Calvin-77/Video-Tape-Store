var express = require('express');
var router = express.Router();
var con = require('./connection'); 
var multer = require("multer");
var storage = multer.diskStorage({
    destination: (req, res, cb) =>{
        cb(null, "./assets/")
    },
    filename: (req, filename, cb) =>{
        cb(null, filename.originalname)
    }
})

// Select data
router.get('/get', function(req, res, next) {
    const query = "SELECT * FROM library"

    con.query(query, (err, results) => {
        if(err) throw err; 
        res.send(results)
    })
});

// Select data (spesifik)
router.get('/getlibrary/:VideoTapeID', function(req, res, next){
    const VideoTapeID = req.params.VideoTapeID
    const query = `SELECT * FROM library WHERE VideoTapeID = ${VideoTapeID}`
    con.query(query, (err, results) => {
        if(err) throw err;
        res.send(results)
    })
});

module.exports = router;