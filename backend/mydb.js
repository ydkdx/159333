const mysql = require('mysql2');

// 创建 MySQL 连接
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'CoIr166612',
    database: 'job'
});

// 连接 MySQL
connection.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL');
});

module.exports = connection;
