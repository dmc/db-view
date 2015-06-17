/*
 * GET users listing.
 */

exports.login = function(req, res) {


  var mysql = require('mysql');
  var connection = null;

  try {
    connection = mysql.createConnection({
      host: req.body.host,
      port: req.body.port,
      user: req.body.user,
      password: req.body.password,
      database: req.body.database
    });
    res.send('{"status": "success"}');
  } catch (err) {
    throw err;
  } finally {
    if (connection) {
      connection.end();
    }
  }

}
