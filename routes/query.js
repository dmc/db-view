/*
 * GET users listing.
 */

exports.execute = function(req, res) {


  var mysql = require('mysql');

  var connection = mysql.createConnection({
    host: req.body.host,
    port: req.body.port,
    user: req.body.user,
    password: req.body.password,
    database: req.body.database
  });

  connection.connect();

  try {
    connection.query(req.body.query, function(err, rows, fields) {
      if (err) {
    	
        res.json(err);
      }
      res.json(rows);
    });

  } finally {
    connection.end();
  }
};
