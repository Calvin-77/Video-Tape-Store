const mysql = require('mysql');
const router = require('.');
const connection = mysql.createConnection({
    host: 'localhost', 
    user: 'root',
    password: '',
    database: 'video_tape_store_db'
})

connection.connect();
module.exports = connection;