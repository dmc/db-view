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


  try {
    connection.connect();
    connection.query(req.body.query, function(err, rows, fields) {
      if (err) {
        res.statusCode = 503;
        res.statusMessage = err.message;
        res.end();
      }
      res.json(rows);
    });

  } finally {
    connection.end();
  }


};
