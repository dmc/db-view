
/**
 * Module dependencies.
 */

var express = require('express')
, mysql_query = require('./routes/mysql-query')
, postgresql_query = require('./routes/postgresql-query')
, debug = require('./routes/debug')
, http = require('http')
, path = require('path');

var app = express();
var router = express.Router();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}


app.get('/', function(req, res){
  res.sendfile(path.join(__dirname, 'public/index.html'));
});


//query
app.post('/query', function(req, res){

  if(req.body.vendor === "mysql"){

    mysql_query.execute(req, res);

  } else if (req.body.vendor === "postgresql") {

    postgresql_query.execute(req, res);

  } else {

    res.statusCode = 503;
    res.statusMessage = "unsupport database";
    res.end();
  }

});

process.on('uncaughtException', function (err) {
	console.log('Caught exception: ' + err);
	debug.log(err);
});

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
