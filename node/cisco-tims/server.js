var http = require('http');
var net = require('net');
var util = require('util');
var url = require('url');
var querystring = require("querystring");

function start(route,handle) {
   function onRequest(request,response) {
      var pathname = url.parse(request.url).pathname;
      var postdata = "";
      var query = "";
      var query = url.parse(request.url).query;
      //var query = querystring.parse(url.parse(request.url).query);
      console.log("Request for " + pathname + " received. ");
      request.setEncoding("utf8");
      request.addListener("data",function(postdatachunk) {
         postdata += postdatachunk;
         console.log("Received POST data chunk '" + postdatachunk + "'.");
      });
      request.addListener("end",function() {
         route(handle,pathname,response,postdata,query);
      });
      response.simpleText = function (code, body) {
         response.writeHead(code, { "Content-Type": "text/plain"
                            , "Content-Length": body.length
         });
         response.end(body);
      };
      response.simpleJSON = function (code, obj) {
         var body = new Buffer(JSON.stringify(obj));
         response.writeHead(code, { "Content-Type": "text/json"
                            , "Content-Length": body.length
         });
         response.end(body);
      };

   }
   http.createServer(onRequest).listen(1337);
   console.log("Server has started.");
}
exports.start = start;
