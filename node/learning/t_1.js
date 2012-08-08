var http = require("http");
var url = require("url");
var static = require("node-static");
var file = new(static.Server)(".",{ cache : 1});
function onRequest(request, response) {
   file.server(request,response);
    var parsed = url.parse(request.url,true);
    var pathname = parsed.pathname;
    console.log("Request for " + pathname + " received.");
    response.writeHead(200, {"Content-Type": "text/html"});
    response.write("<h4>Hello World</h4>");
   for (var key in parsed.query)
      response.write(key + " => " 
         + parsed.query[key] + "<br/>");
    response.end();
}

http.createServer(onRequest).listen(8888);
console.log("It ... is ... alive!");
