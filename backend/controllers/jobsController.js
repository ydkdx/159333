const express = require('express');
const router = express.Router();
const connection = require('../mydb');



router.get('/:jobId', (req, res) => {
    const jobId = req.params.jobId;
    const query = 'SELECT * FROM jobs WHERE id = ?';
    connection.query(query, [jobId], (err, result) => {
        if (err) {
            console.error('An error occurred while retrieving job details:', err);
            return res.status(500).json({ message: 'Failed to get job details' });
        }
        if (result.length > 0) {
            res.status(200).json(result[0]);
        } else {
            res.status(404).json({ message: 'Job not found' });
        }
    });
});


router.post('/interest', (req, res) => {
    const { userId, jobId } = req.body;
    if (!userId || !jobId) {
        return res.status(400).json({ success: false, message: 'Missing required fields' });
    }

    const query = 'INSERT INTO interested_jobs (user_id, job_id, created_at) VALUES (?, ?, NOW())';
    connection.query(query, [userId, jobId], (err) => {
        if (err) {
            console.error('An error occurred while marking a job of interest:', err);
            return res.status(500).json({ success: false, message: 'Marking interest failed' });
        }
        res.status(200).json({ success: true, message: 'Marked as interested' });
    });
});


module.exports = router;
