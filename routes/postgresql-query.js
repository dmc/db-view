exports.execute = function(req, res) {

    var pg = require('pg');
    var clinet = require('pg').Client;
    var conString = "postgres://"+ req.body.user+":"+ req.body.password + "@" + req.body.host + ":" + req.body.port +"/" + req.body.database;
    
    try {
      pg.connect(conString, function(err, client, done) {
        client.query(req.body.query, function(err, result) {
          done();
          console.log(result);
          res.json(result.rows);

        });
      });

    } catch (err) {

      res.statusCode = 503;
      res.statusMessage = err.message;

    } finally {
      client.end();
    }

};
