/*
 * GET users listing.
 */

exports.login = function(req, res) {


  var mysql = require('mysql');

  var connection = mysql.createConnection({
    host: req.body.host,
    port: req.body.port,
    user: req.body.user,
    password: req.body.password,
    database: req.body.database
  });


  try {

    connection.connect(function(err){
      if(err) {
        res.statusCode = 503;
        res.statusMessage = Error.message;
        res.end();
      } else {
        res.send('{"status": "success"}');
      }
    });


  } finally {
    connection.end();

  }

};
