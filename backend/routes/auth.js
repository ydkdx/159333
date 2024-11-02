const express = require('express');
const router = express.Router();
const connection = require('../mydb');

//register
router.post('/register/:userType', (req, res) => {
    const { username, password } = req.body;
    const userType = req.params.userType;

    let insertUserQuery;

    if (userType === 'jobseeker') {
        insertUserQuery = 'INSERT INTO jobseekers (username, password) VALUES (?, ?)';
    } else if (userType === 'employer') {
        insertUserQuery = 'INSERT INTO employers (username, password) VALUES (?, ?)';
    } else {
        return res.status(400).send('Invalid user type');
    }

    connection.query(insertUserQuery, [username, password], (err, result) => {
        if (err) {
            console.error("Error registering user:", err);
            res.status(500).send('Error registering user');
            return;
        }
        console.log(`User registered successfully! User ID: ${result.insertId}`);
        res.status(200).send('Registered successfully');
    });
});

// login
router.post('/login/:userType', (req, res) => {
    const { username, password } = req.body;
    const userType = req.params.userType;

    let selectUserQuery;

    if (userType === 'jobseeker') {
        selectUserQuery = 'SELECT id FROM jobseekers WHERE username = ? AND password = ?';
    } else if (userType === 'employer') {
        selectUserQuery = 'SELECT id FROM employers WHERE username = ? AND password = ?';
    } else {
        return res.status(400).send('Invalid user type');
    }

    connection.query(selectUserQuery, [username, password], (err, result) => {
        if (err) {
            console.error("Error logging in:", err);
            res.status(500).send('Error logging in');
            return;
        }


        if (result.length > 0) {
            const userId = result[0].id; // 获取用户ID
            const username = result[0].username; // 获取用户名
            req.session.userId = userId; // 将用户ID存入会话
            req.session.username = username; // 将用户名存入会话


            console.log('Login successful.');

            // 返回userId给前端
            res.status(200).json({ success: true, userId: userId }); // 修改此处
        } else {
            res.status(401).send('Invalid username or password');
        }

    });
});

router.get('/get-user-session', (req, res) => {
    if (req.session && req.session.userId) {
        res.status(200).json({ userId: req.session.userId });
    } else {
        res.status(404).json({ message: '未登录' });
    }
});



module.exports = router;
