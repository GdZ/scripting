var http = require('http');
var spawn = require('child_process').spawn;
http.createServer(function (req, res) {
   res.writeHead(200, {'Content-Type': 'text/plain'});
   var tail_child = spawn('tail',['-f','/var/log/apache2/access.log']);
   //var tail_child = spawn('adb',['-s','HT06WHL03270','logcat']);
   req.connection.on('end',function() {
      tail_child.kill();
   });
   tail_child.stdout.on('data',function(data) {
      console.log(data.toString());
      res.write(data);
   });
}).listen(1337);
console.log('Server running at http://127.0.0.1:1337/');
