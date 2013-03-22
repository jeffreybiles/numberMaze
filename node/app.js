
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http')
  , path = require('path')
  , config = require('./config')
  , mongoose = require('mongoose')
  , expressValidator = require('express-validator')
  , users = require('./users/routes');

var app = exports.app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(expressValidator);
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));

});

app.configure('development', function(){
  app.use(express.errorHandler());
});

app.configure(function () {
 // set the 'dbUrl' to the mongodb url that corresponds to the
 // environment we are in
 app.set('dbUrl', config.db[app.settings.env]);
 // connect mongoose to the mongo dbUrl
 mongoose.connect(app.get('dbUrl'));
 //...
});

app.get('/', function(req, res){
  res.render('index.jade', {
    locals: { title: 'Number Maze' }
  });
});
// app.get('/users', user.list);

app.get('/add/:first/:second', function(req, res){
  var sum = parseFloat(req.params.first) + parseFloat(req.params.second)
  res.send(200, String(sum))
})

app.post('/signup', users.signup)

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
