//
// This server will start child process as input string from UI and expose output
// over socket.io to a browser. See ./index.html for the 
// client side.
// Using 'KILL' to kill some kind of bash command will not exit itself, like ping hostname.
// 
//
// To start the server:
//
//   node server.js
//
//

var http  = require('http'),
url   = require('url'),
path  = require('path'),
fs    = require('fs'),
io    = require('socket.io'),
util  = require('util'),
spawn = require('child_process').spawn;


server = http.createServer(function(request, response){
   var uri = url.parse(request.url).pathname;
   var filename = path.join(process.cwd(), uri);
   fs.exists(filename, function(exists) {
      if (!exists) {
         response.writeHead(404, {'Content-Type':'text/plain'});
         response.end("Can''t find it...");
      }
      fs.readFile(filename, 'binary',function(err, file){
         if (err) {
            response.writeHead(500, {'Content-Type':'text/plain'});
            response.end(err + "\n");
            return;
         }
         response.writeHead(200);
         response.write(file, 'binary');
         response.end();

      });
   });
});
var command_pool = [];
var total_client = 0;
server.listen(1337);
var listener = io.listen(server);
listener.set('log level',1);
listener.sockets.on('disconnect', function(client) {
   total_client --;
   //
   listener.sockets.emit('leave',{clientNumber: total_client});
});
listener.sockets.on('connection', function(client){
   total_client ++;
   client.on('message', function(data){
      if(data === "KILL") {
         console.log('!!!!' + data);
         if(command_pool.length > 0) {
            command_pool.pop().kill();
         }
         //Both can do. 
         //broadcast will send message/event to all except the emitor.
         client.broadcast.send(new Buffer("KILLING "));
         //client.broadcast.emit("stdout",new Buffer("KILLING "));
         return;
      };
      console.log(data);
      var cmd = data.split(" ");
      var sh = spawn(cmd[0],cmd.slice(1));
      command_pool.push(sh);
      sh.stdout.on('data', function(data) {
         console.log('stdout : ' + data);
         //send to all:
         listener.sockets.emit("stdout",new Buffer(data));
      });
      sh.stderr.on('data', function(data) {
         console.log('stderr : ' + data);
         //listener.sockets.emit("stderr",new Buffer(data));
         //private msg
         client.emit("stderr",new Buffer(data));
      });

      sh.on('exit', function (code) {
         command_pool.pop();
         console.log('child process exit! ');
         listener.sockets.emit("exit",'** Shell exited: '+code+' **');
      });
      client.broadcast.send(new Buffer("> "+data));
   });
});


//var sh = spawn('bash');
