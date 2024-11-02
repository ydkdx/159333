const express = require('express');
const router = express.Router();
const connection = require('../mydb');

router.get('/recommendations', (req, res) => {
    const query = `
        SELECT id, company_name, location, industry 
        FROM jobs
        ORDER BY RAND()
        LIMIT 8
    `;

    connection.query(query, (err, results) => {
        if (err) {
            console.error('An error occurred while getting job recommendations:', err);
            return res.status(500).json({ error: 'Unable to get recommended jobs' });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'No recommended positions found' });
        }

        res.json(results);
    });
});

module.exports = router;
