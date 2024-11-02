const express = require('express');
const connection = require('../mydb');  // Import the database connection

const router = express.Router();
const {
    searchJobs,
    getUniqueLocations,
    getUniqueIndustries,
    getUniqueJobTypes,
    getJobDetails,
    submitResume,
    getResumesForEmployer
} = require('../controllers/searchController');

// Job search route
router.get('/jobs', searchJobs);

// Routes to get unique locations, industries, and job types
router.get('/locations', getUniqueLocations);
router.get('/industries', getUniqueIndustries);
router.get('/job-types', getUniqueJobTypes);

router.get('/jobs/:jobId', getJobDetails);

// Example API for job recommendations
router.get('/recommendations/:userId', (req, res) => {
    const { userId } = req.params;

    const query = `SELECT * FROM jobs WHERE user_id = ?`; // Adjust the query as per logic
    connection.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error getting job recommendations:', err);
            return res.status(500).json({ success: false, message: 'Failed to get job recommendations' });
        }
        res.status(200).json(results);
    });
});

router.post('/interest-job/:jobId', (req, res) => {
    const { jobId } = req.params;
    const userId = req.body.userId;

    if (!userId) {
        return res.status(400).json({ success: false, message: 'User ID is required' });
    }

    const query = `INSERT INTO interested_jobs (user_id, job_id) VALUES (?, ?)`;

    connection.query(query, [userId, jobId], (err) => {
        if (err) {
            console.error('Error adding interested job:', err);
            return res.status(500).json({ success: false, message: 'Failed to add interested job' });
        }
        res.status(200).json({ success: true, message: 'Job has been added to the interested list' });
    });
});

module.exports = router;
