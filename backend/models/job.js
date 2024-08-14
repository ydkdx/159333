const { DataTypes } = require('sequelize');
const sequelize = require('../config/config');

const Job = sequelize.define('Job', {
  title: { type: DataTypes.STRING, allowNull: false },
  description: { type: DataTypes.TEXT, allowNull: false },
  location: { type: DataTypes.STRING, allowNull: false },
  salary: { type: DataTypes.STRING },
  industry: { type: DataTypes.STRING },
  jobType: { type: DataTypes.STRING },
  companyName: { type: DataTypes.STRING }
});

module.exports = Job;