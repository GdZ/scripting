var http = require('http');
var fs = require("fs");
var spawn = require('child_process').spawn;
http.createServer(function (req, res) {

   switch(req.url){

      case "/favicon.ico" :
         res.end("404");
      break;

      case "/" :
         // Return index.html
         fs.readFile("./index.html", function(e, data){
         res.writeHead(200, {"Content-Type": "text/html"});
         res.end(data);
      });
      break;

      default : 

         // Bust out the querystring params cause we're not interested
         // in using express to make our lives simple...
         var params = {};
      var paramsArray = [];
      var i, x;
      var newURL = ""

      if(req.url.indexOf("?") !== -1){

         newURL = req.url.split("?")[0];

         paramsArray = req.url.split("?")[1].split("&");
         for (i = paramsArray.length - 1; i >= 0; i--) {
            x = paramsArray[i].split("=");
            params[x[0]] = (x.length === 2)? unescape(x[1]) : null;
         };

         if(newURL === "/test"){

            res.writeHead(200, {"Content-Type": "text/html"});
            //res.end("END");
            var tail_child = spawn('tail',['-f','/var/log/apache2/access.log']);
            req.connection.on('end',function() {
               tail_child.kill();
            });
            tail_child.stdout.on('data',function(data) {
               console.log(data.toString());
               res.write(data);
            });

            //Do something with params
            console.log(params);

         } else {
            // 404 cause we dont know wut chu talk'n bout 
            // (some page we dont have)
            res.end("404");
         };

      } else {
         // 404 cause we dont know wut chu talk'n bout 
         // (some page we dont have)
         res.end("404");
      };

   };


}).listen(1337, "127.0.0.1");
