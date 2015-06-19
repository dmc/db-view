exports.execute = function(req, res) {

	var debug = require('./debug');
	var pg = require('pg');
	var conString = "postgres://"+ req.body.user+":"+ req.body.password + "@" + req.body.host + ":" + req.body.port +"/" + req.body.database;

	  var sql;
	  if(req.body.event === "login"){
		  sql = "SELECT 1";
	  } else {
		  sql = req.body.query;
	  }

	
	pg.connect(conString, function(err, client, done) {
	  if(err) {
			res.statusCode = 503;
			res.statusMessage = err.message;
			res.end();
	  }
		client.query(sql, function(err, result) {
	    //call `done()` to release the client back to the pool
	    done();

	    if(err) {
			debug.log(err);
			res.statusCode = 503;
			res.statusMessage = err.message;
			res.end();
	    }

	    
	    if(result.command === "SELECT"){
	    	res.json(result.rows);
	    	
	    } else {
	    	res.json('{"affected":"' + result.rowCount +'"}');
	    }
	    
	  });
	});

}
