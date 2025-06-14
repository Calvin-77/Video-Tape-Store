var express = require('express');
var router = express.Router();
var con = require('./connection'); 
var jwt = require('jsonwebtoken');
var multer = require("multer");

// multer
var storage = multer.diskStorage({
  destination: (req, res, cb) =>{     
      cb(null, "./assets/")
  },
  filename: (req, filename, cb) =>{
      cb(null, filename.originalname)
  }
})

// generate token
function generateToken(user) {
  var payload = {
    id: user.id,
    username: user.username
  };

  return jwt.sign(payload, 'SECRET KEY');
}

// register
router.post('/register', function(req, res, next) {
  var username = req.body.username;
  var password = req.body.password;
  var email = req.body.email;

  if (!username || !password || !email) {
    return res.status(400).send('Username, password, email diperlukan.');
  }

  var cek_user = 'SELECT * FROM users WHERE Username = ?';
  con.query(cek_user, [username], function(err, result) {
    if (err) throw err;

    if (result.length > 0) {
      return res.status(409).send('Username sudah digunakan.');
    }

    var insert_user = 'INSERT INTO users (Username, Password, Email) VALUES (?, ?, ?)';
    con.query(insert_user, [username, password, email], function(err, result) {
      if (err) throw err;

      return res.send({
        message: 'Registrasi berhasil!',
      });
    });
  });
});

// login
router.post('/login', function(req, res, next) {
  var username = req.body.username;
  var password = req.body.password;

  var query = 'SELECT * FROM users WHERE username = ? AND password = ?';

  con.query(query, [username, password], function(err, result){
    if(err) throw err;

    if(result.length === 0){
      return res.status(403).send('Invalid user creds.');
    }

    var user = result[0];

    var Token = generateToken(user);

    con.query('UPDATE users SET Token = ? WHERE UserID = ?', [Token, user.UserID], function(err, result) {
      if (err) throw err;
    });

    var data = {
      UserID: user.UserID,
      Username: user.Username,
      Role: user.Role,
      Token: Token
    };

    return res.send(data);
  });
});

function verifyToken(req, res, next){
  var token = req.headers.token || req.body.token;

  if(!token) {
    return req.status(401).send('Unautherized access!');
  }

  try{jwt.verify(token, 'SECRET KEY')}

  catch (e) {
    return res.status(401).send('Unauthorized access!');
  }
}

router.get('/secretLink', verifyToken, function(req, res, next){
  return res.send('Super Secret Message!');
})

router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;