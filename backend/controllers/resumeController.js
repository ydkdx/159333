const express = require('express');
const router = express.Router();
const connection = require('../mydb');  // Adjust the database connection path according to your project structure

// Handle the POST request to save a resume
router.post('/save-resume', (req, res) => {
    const { userId, name, email, skills, job_preferences, experience, education } = req.body;

    console.log('Received data:', req.body);  // Check the received data

    if (!userId) {
        return res.status(400).json({ success: false, message: 'Missing user ID' });
    }

    const query = `
        UPDATE jobseekers
        SET full_name = ?, email = ?, skills = ?, job_preferences = ?, experience = ?, education_background = ?
        WHERE id = ?
    `;

    const values = [name, email, skills, job_preferences, experience, education, userId];

    console.log('Processing save resume request');

    try {
        connection.query(query, values, (err, results) => {
            if (err) {
                console.error('Database update failed:', err);
                return res.status(500).json({ success: false, error: 'Database update failed' });
            }

            console.log('SQL query:', query);
            console.log('Updated user ID:', userId);
            console.log('Affected rows:', results.affectedRows);

            if (results.affectedRows > 0) {
                res.status(200).json({ success: true, message: 'Resume updated successfully' });
            } else {
                res.status(404).json({ success: false, message: 'User not found' });
            }
        });
    } catch (error) {
        console.error('Unhandled exception:', error);
    }
});

// API to get user resume information
router.get('/get-resume', (req, res) => {
    const email = req.query.email;

    connection.query('SELECT * FROM jobseekers WHERE email = ?', [email], (err, results) => {
        if (err) {
            console.error('Error retrieving resume information:', err);
            return res.status(500).json({ error: 'Unable to retrieve resume information' });
        }

        if (results.length > 0) {
            res.json(results[0]);
        } else {
            res.status(404).json({ message: 'Resume information not found' });
        }
    });
});

// Get interested jobs
// router.get('/get-interested-jobs', async (req, res) => {
//     const userId = req.session.userId; // Get user ID from session
//     if (!userId) {
//         return res.status(401).json({ message: 'Not logged in' });
//     }
//
//     try {
//         const query = 'SELECT * FROM interested_jobs WHERE user_id = ?';
//         connection.query(query, [userId], (err, rows) => {
//             if (err) {
//                 console.error('Error retrieving interested jobs:', err);
//                 return res.status(500).json({ message: 'Failed to retrieve interested jobs' });
//             }
//             if (rows.length > 0) {
//                 res.status(200).json({ jobs: rows });
//             } else {
//                 res.status(404).json({ message: 'No interested jobs found.' });
//             }
//         });
//     } catch (error) {
//         console.error('Error retrieving interested jobs:', error);
//         res.status(500).json({ message: 'Server error' });
//     }
// });
//
// // Mark a job as interested
// router.post('/mark-interest', async (req, res) => {
//     const { userId, jobId } = req.body; // Get userId and jobId from request body
//
//     if (!userId) {
//         return res.status(401).json({ success: false, message: 'Not logged in' });
//     }
//     if (!jobId) {
//         return res.status(400).json({ success: false, message: 'Missing jobId' });
//     }
//
//     const query = 'INSERT INTO interested_jobs (user_id, job_id, created_at) VALUES (?, ?, NOW())';
//     connection.query(query, [userId, jobId], (err, result) => {
//         if (err) {
//             console.error('Error saving interested job:', err);
//             return res.status(500).json({ success: false, message: 'Error saving interested job' });
//         }
//         res.status(200).json({ success: true, message: 'Job marked as interested successfully' });
//     });
// });

router.get('/get-user-session', (req, res) => {
    if (req.session.userId) {
        res.json({ userId: req.session.userId });
    } else {
        res.status(401).json({ message: 'Not logged in' });
    }
});

// Submit resume
router.post('/submit-resume', (req, res) => {
    const { jobId, jobseekerId, resumeContent } = req.body;

    if (!jobId || !jobseekerId) {
        return res.status(400).json({ success: false, message: 'Missing required fields' });
    }

    // Query the employer_id for the job
    const queryEmployerId = 'SELECT employer_id FROM jobs WHERE id = ?';
    connection.query(queryEmployerId, [jobId], (err, result) => {
        if (err || result.length === 0) {
            console.error('Error querying employer_id:', err);
            return res.status(500).json({ success: false, message: 'Failed to retrieve employer_id' });
        }

        const employerId = result[0].employer_id;

        // Insert resume submission information
        const insertResumeQuery = `
            INSERT INTO submitted_resumes (job_id, jobseeker_id, resume_content, employer_id)
            VALUES (?, ?, ?, ?)
        `;
        connection.query(insertResumeQuery, [jobId, jobseekerId, resumeContent, employerId], (err, result) => {
            if (err) {
                console.error('Error saving resume submission:', err);
                return res.status(500).json({ success: false, message: 'Failed to save resume submission' });
            }
            res.status(200).json({ success: true, message: 'Resume submitted successfully' });
        });
    });
});

// Get employer's list of resumes
router.get('/employer/:employerId/resumes', (req, res) => {
    const employerId = req.params.employerId;
    const query = `
        SELECT submitted_resumes.id AS resume_id, jobseekers.id AS jobseeker_id, jobseekers.username, jobseekers.skills, jobseekers.job_preferences,
               jobseekers.education_background, jobseekers.full_name, jobseekers.email, jobseekers.experience, submitted_resumes.resume_content
        FROM submitted_resumes
        JOIN jobseekers ON submitted_resumes.jobseeker_id = jobseekers.id
        WHERE submitted_resumes.employer_id = ?
    `;
    connection.query(query, [employerId], (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            res.status(500).json({ message: 'Internal server error' });
        } else if (results.length === 0) {
            res.status(404).json({ message: 'No resumes found' });
        } else {
            res.status(200).json(results);
        }
    });
});

router.get('/:jobseekerId/details', (req, res) => {
    const jobseekerId = req.params.jobseekerId;

    const query = `
        SELECT id, username, skills, job_preferences, education_background, full_name, email, experience
        FROM jobseekers
        WHERE id = ?
    `;

    connection.query(query, [jobseekerId], (err, result) => {
        if (err) {
            console.error('Error retrieving jobseeker details:', err);
            return res.status(500).json({ success: false, message: 'Failed to retrieve jobseeker details' });
        }

        if (result.length > 0) {
            res.status(200).json(result[0]);
        } else {
            res.status(404).json({ success: false, message: 'Jobseeker information not found' });
        }
    });
});

// Delete resume
router.delete('/:resumeId', (req, res) => {
    const resumeId = parseInt(req.params.resumeId, 10);

    const query = 'DELETE FROM submitted_resumes WHERE id = ?';
    connection.query(query, [resumeId], (err, result) => {
        if (err) {
            console.error('Error deleting resume:', err);
            return res.status(500).json({ message: 'Failed to delete resume' });
        }

        if (result.affectedRows > 0) {
            res.status(200).json({ message: 'Resume deleted successfully' });
        } else {
            res.status(404).json({ message: 'Resume to delete not found' });
        }
    });
});

module.exports = router;
