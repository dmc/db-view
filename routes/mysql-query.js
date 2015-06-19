/*
 * GET users listing.
 */

exports.execute = function(req, res) {

	var debug = require('./debug');
	var mysql = require('mysql');

	var connection = mysql.createConnection({
		host : req.body.host,
		port : req.body.port,
		user : req.body.user,
		password : req.body.password,
		database : req.body.database
	});

	var sql;
	if (req.body.event === "login") {
		sql = "SELECT 1";
	} else {
		sql = req.body.query;
	}

	connection.connect();
	connection.query({sql:sql}, function(err, results) {
		if (err) {
			debug.log(err);
			res.statusCode = 503;
			res.statusMessage = err.message;
			res.end();
		}

		
	    if(results.affectedRows) {
	    	res.json('{"affected":"' + results.affectedRows +'"}');
	    } else {
			res.json(results);
	    }
	});

	connection.end();

};
