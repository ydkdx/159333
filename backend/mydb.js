// backend/db.js
const mysql = require('mysql2');

// 创建 MySQL 连接
const connection = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: 'yuyi021016',
    database: 'myapp'
});

// 连接 MySQL
connection.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL');
});

module.exports = connection;
