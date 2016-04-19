var mysql = require('mysql');

var connection = mysql.createConnection({
	host: 'mydb.conrqu16ybbt.us-east-1.rds.amazonaws.com',
  user     : 'adilp',
  password : 'v0f19py8',
  database: 'hockeydb'
});

module.exports = connection;