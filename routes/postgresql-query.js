exports.execute = function(req, res) {

	var pg = require('pg');
	var conString = "postgres://"+ req.body.user+":"+ req.body.password + "@" + req.body.host + ":" + req.body.port +"/" + req.body.database;

	pg.connect(conString, function(err, client, done) {
	  if(err) {
			res.statusCode = 503;
			res.statusMessage = err.message;
			res.end();
	  }
		client.query(req.body.query, function(err, result) {
	    //call `done()` to release the client back to the pool
	    done();

	    if(err) {
				res.statusCode = 503;
				res.statusMessage = err.message;
				res.end();
	    }

			res.json(result.rows);
	  });
	});

}
