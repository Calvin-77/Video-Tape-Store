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
    const query = "SELECT * FROM videos"

    con.query(query, (err, results) => {
        if(err) throw err; 
        res.send(results)
    })
});

// Insert data
router.post('/insert', multer({ storage: storage }).fields([
    { name: 'portraitImage', maxCount: 1 }, 
    { name: 'landscapeImage', maxCount: 1 }
]), function(req, res, next) {
    const data = req.body;
    const files = req.files;

    const portraitFilePath = "/" + files.portraitImage[0].path.replace("\\", "/");
    const landscapeFilePath = "/" + files.landscapeImage[0].path.replace("\\", "/");

    const query = `INSERT INTO videos (Title, Price, Description, VideoTapeImage, Genre, Level, Image_landscape)
                   VALUES (?, ?, ?, ?, ?, ?, ?)`;

    con.query(query, [data.Title, data.Price, data.Description, portraitFilePath, data.Genre, data.Level, landscapeFilePath], (err, results) => {
        if (err) throw err;
        res.status(200).send("Data inserted successfully");
    });
});

// Delete data
router.delete('/delete', function(req, res, next){
    const data = req.body
    const query = `DELETE FROM videos WHERE VideoTapeID = ${data.VideoTapeID}`
    con.query(query, (err, results) => {
        if(err) throw err;
        res.send(results)
    })
});

// Update data
router.put('/update', multer({ storage: storage }).single('image'), function(req, res, next){
    const data = req.body
    const file = req.file;

    const filePath = file ? "/" + file.path.replace("\\", "/") : data.VideoTapeImage;

    const query = `UPDATE videos SET Title = ?, Price = ?, Description = ?, VideoTapeImage = ?, Genre = ?, Level = ? 
    where VideoTapeID = ?`;
        con.query(query, [data.Title, data.Price, data.Description, filePath, data.Genre, data.Level, data.VideoTapeID], (err, results) => {
            if (err) throw err;
            res.send(results);
        });
});

module.exports = router;