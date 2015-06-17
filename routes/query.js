/*
 * GET users listing.
 */

exports.execute = function(req, res) {

  if(req.body.vendor === "mysql"){

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

          res.statusCode = 503;
          res.statusMessage = err.message;
        }
        res.json(rows);
      });

    } finally {
      connection.end();
    }

  } else if (req.body.vendor === "postgresql") {

    var pg = require('pg');
    var conString = "postgres://"+ req.body.user+":"+ req.body.password + "@" + req.body.host + ":" + req.body.port +"/" + req.body.database;

    pg.connect(conString, function(err, client, done) {

      if(err) {
        res.statusCode = 503;
        res.statusMessage = err.message;
      }

      client.query(req.body.query, function(err, result) {
        done();

        if(err) {
          res.statusCode = 503;
          res.statusMessage = err.message;
        }

        console.log(result.rows);
        res.json(result.rows);

      });
    });


  } else {

    res.statusCode = 503;
    res.statusMessage = "unsupport database";
    res.end();
  }

};
