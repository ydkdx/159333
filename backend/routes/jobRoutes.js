const express = require('express');
const { searchJobs } = require('../controllers/jobController');
const router = express.Router();

router.get('/search', searchJobs);

module.exports = router;