exports.login = function(req, res) {

    var pg = require('pg');
    var conString = "postgres://"+ req.body.user+":"+ req.body.password + "@" + req.body.host + ":" + req.body.port +"/" + req.body.database;

    pg.connect(conString, function(err) {

      if(err){
        res.statusCode = 503;
        res.statusMessage = err.message;
        res.end();
      } else {
        res.send('{"status": "success"}');
      }

    });


};
