const connection = require('../mydb');
const path = require('path');
const fs = require('fs');

// Controller function for searching jobs
const searchJobs = (req, res) => {
    const { location, industry, keyword, minSalary, maxSalary, page = 1, limit = 10 } = req.query;

    let query = "SELECT id, company_name, location, industry, job_type, salary, posted_date FROM jobs WHERE 1=1";
    let queryParams = [];

    if (location) {
        query += " AND location = ?";
        queryParams.push(location);
    }
    if (industry) {
        query += " AND industry = ?";
        queryParams.push(industry);
    }
    if (keyword) {
        query += " AND (company_name LIKE ? OR industry LIKE ?)";
        queryParams.push(`%${keyword}%`, `%${keyword}%`);
    }
    if (minSalary) {
        query += " AND salary >= ?";
        queryParams.push(parseFloat(minSalary));
    }
    if (maxSalary) {
        query += " AND salary <= ?";
        queryParams.push(parseFloat(maxSalary));
    }

    const offset = (page - 1) * limit;
    query += " LIMIT ? OFFSET ?";
    queryParams.push(parseInt(limit), parseInt(offset));

    console.log('Executing query:', query);
    console.log('With parameters:', queryParams);

    connection.query(query, queryParams, (err, results) => {
        if (err) {
            console.error('Database query failed:', err);
            return res.status(500).json({ error: 'Database query failed' });
        }
        res.json(results);
    });
};

// Get all unique locations
const getUniqueLocations = (req, res) => {
    connection.query('SELECT DISTINCT location FROM jobs', (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Database query failed' });
        }
        res.json(results.map(result => result.location));
    });
};

// Get all unique industries
const getUniqueIndustries = (req, res) => {
    connection.query('SELECT DISTINCT industry FROM jobs', (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Database query failed' });
        }
        res.json(results.map(result => result.industry));
    });
};

// Get all unique job types
const getUniqueJobTypes = (req, res) => {
    connection.query('SELECT DISTINCT job_type FROM jobs', (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Database query failed' });
        }
        res.json(results.map(result => result.job_type));
    });
};

// Get job details by jobId
const getJobDetails = (req, res) => {
    const jobId = req.params.jobId;

    connection.query('SELECT * FROM jobs WHERE id = ?', [jobId], (err, results) => {
        if (err) {
            console.error('Database query failed:', err);
            return res.status(500).json({ error: 'Database query failed' });
        }
        if (results.length > 0) {
            const job = results[0];
            res.json({
                id: job.id,
                company_name: job.company_name,
                location: job.location,
                industry: job.industry,
                job_type: job.job_type,
                salary: job.salary,
                posted_date: job.posted_date,
                employer_id: job.employer_id, // Added this line
                description: job.description || 'No description',
                requirements: job.requirements || 'No specific requirements',
                responsibilities: job.responsibilities || 'No specific responsibilities',
                benefits: job.benefits || 'No benefits information',
            });
        } else {
            res.status(404).json({ error: 'Job not found' });
        }
    });
};

module.exports = {
    searchJobs,
    getUniqueLocations,
    getUniqueIndustries,
    getUniqueJobTypes,
    getJobDetails,
};
