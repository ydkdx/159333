const { Op } = require('sequelize');
const Job = require('../models/job');

exports.searchJobs = async (req, res) => {
  try {
    const { title, location, industry, jobType, companyName } = req.query;

    let filter = {};

    if (title) {
      filter.title = { [Op.like]: `%${title}%` };
    }
    if (location) {
      filter.location = location;
    }
    if (industry) {
      filter.industry = industry;
    }
    if (jobType) {
      filter.jobType = jobType;
    }
    if (companyName) {
      filter.companyName = { [Op.like]: `%${companyName}%` };
    }

    const jobs = await Job.findAll({ where: filter });
    res.json(jobs);

  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};