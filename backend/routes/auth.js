const express = require('express');
const router = express.Router();
const connection = require('../mydb');

// 注册路由
router.post('/register', (req, res) => {
    const { username, password } = req.body;
    const insertUserQuery = 'INSERT INTO users (username, password) VALUES (?, ?)';
    connection.query(insertUserQuery, [username, password], (err, result) => {
        if (err) {
            console.error("Error registering user:", err);
            res.status(500).send('Error registering user');
            return;
        }
        console.log(`Registered successfully! User ID: ${result.insertId}`);
        res.status(200).send('Registered successfully');
    });
});

// 登录路由
router.post('/login', (req, res) => {
    const { username, password } = req.body;
    const selectUserQuery = 'SELECT * FROM users WHERE username = ? AND password = ?';
    connection.query(selectUserQuery, [username, password], (err, result) => {
        if (err) {
            console.error("Error logging in:", err);
            res.status(500).send('Error logging in');
            return;
        }

        if (result.length > 0) {
            console.log('Login successfully!');
            res.status(200).send('Login successfully');
        } else {
            console.log('Invalid username or password.');
            res.status(401).send('Invalid username or password');
        }
    });
});

module.exports = router;
