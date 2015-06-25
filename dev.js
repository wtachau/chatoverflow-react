var app = require('express')();
var http = require('http').Server(app);

app.get('/bundle.js', function(req, res){
  res.sendFile(__dirname + '/bundle.js');
});

app.get('*', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

http.listen(8080, function(){
  console.log('listening on *:8080');
});
