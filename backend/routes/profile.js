const express = require('express');
const router = express.Router();
const connection = require('../mydb');

// 更新用户信息路由
router.post('/update-profile', (req, res) => {
    const { user_id, full_name, email, job_preferences } = req.body;

    const updateQuery = `
        UPDATE user_profiles SET
        full_name = ?,
        email = ?,
        job_preferences = ?,
        updated_at = NOW()
        WHERE user_id = ?`;

    connection.query(updateQuery, [full_name, email, job_preferences, user_id], (err, result) => {
        if (err) {
            console.error("Error updating profile:", err);
            res.status(500).json({ success: false, message: 'Error updating profile' });
            return;
        }
        console.log('Profile updated successfully!');
        res.status(200).json({ success: true, message: 'Profile updated successfully' });
    });
});

module.exports = router;
