wslib = require('ws');
WebSocketServer = wslib.Server;
aServer = new WebSocketServer({host: "10.35.72.177", port : 8000 });

console.log("Listening");
aServer.on('connection', function(ws) {
   console.log("connection!");
   ws.on('message', function(message) {
      console.log('received: %s', message);
      setTimeout(function() {
         ws.send("hi! it's now " 
         + new Date().toString());
      }, 1000);
   });
   ws.send('connected');
});
