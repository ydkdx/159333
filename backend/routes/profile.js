const express = require('express');
const router = express.Router();
const connection = require('../mydb');
const multer = require('multer');

// Use multer to handle file uploads
const upload = multer({ dest: 'uploads/' });

router.post('/save-resume', upload.single('profile_picture'), (req, res) => {
    const { email, name, skills, job_preferences, experience, education } = req.body;
    const profilePicture = req.file ? req.file.path : null;

    if (!email) {
        return res.status(400).json({ success: false, message: 'Email is required' });
    }

    let query = `
        UPDATE jobseekers 
        SET full_name = ?, skills = ?, job_preferences = ?, experience = ?, education_background = ?
    `;
    const queryParams = [name, skills, job_preferences, experience, education];

    // If a profile picture was uploaded, add profile picture update
    if (profilePicture) {
        query += `, profile_picture = ?`;
        queryParams.push(profilePicture);
    }

    query += ` WHERE email = ?`;
    queryParams.push(email);

    connection.query(query, queryParams, (err, result) => {
        if (err) {
            console.error('Error updating resume:', err);
            return res.status(500).json({ success: false, message: 'Failed to update resume' });
        }

        res.status(200).json({ success: true, message: 'Resume updated successfully' });
    });
});

// Get user profile information
router.get('/profile', (req, res) => {
    const userId = req.query.userId; // Get userId from the request

    if (!userId) {
        return res.status(400).json({ message: 'Missing user ID' });
    }

    const query = `
        SELECT full_name, email, skills, job_preferences, education_background, experience 
        FROM jobseekers
        WHERE id = ?
    `;

    connection.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error getting user information:', err);
            return res.status(500).json({ error: 'Failed to get user information' });
        }

        if (results.length > 0) {
            res.json(results[0]); // Return user information
        } else {
            res.status(404).json({ error: 'User not found' });
        }
    });
});

// Get interested job information
router.get('/interested-jobs', (req, res) => {
    const userId = req.query.userId;

    if (!userId) {
        return res.status(400).json({ message: 'Missing user ID' });
    }

    const query = `
        SELECT job_id, created_at 
        FROM interested_jobs
        WHERE user_id = ?
    `;

    connection.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error getting interested jobs:', err);
            return res.status(500).json({ error: 'Failed to get interested jobs' });
        }

        res.json(results);
    });
});

router.delete('/delete-interested-job', (req, res) => {
    const { userId, jobId } = req.body;

    const query = `DELETE FROM interested_jobs WHERE user_id = ? AND job_id = ?`;
    connection.query(query, [userId, jobId], (err, result) => {
        if (err) {
            console.error('Database deletion failed:', err);
            return res.status(500).json({ success: false, message: 'Database deletion failed' });
        }

        if (result.affectedRows > 0) {
            res.status(200).json({ success: true, message: 'Interested job deleted successfully' });
        } else {
            res.status(404).json({ success: false, message: 'Job not found' });
        }
    });
});

module.exports = router;
