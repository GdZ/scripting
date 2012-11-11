var server = require("./server");
var router = require("./router");
var requestHandlers = require("./requestHandlers");
var handle = {}
handle["/"] = requestHandlers.start;
handle["/tims"] = requestHandlers.tims;
handle["/cmd"] = requestHandlers.cmd;
handle["/setting"] = requestHandlers.setting;
handle["/VR5SIF"] = requestHandlers.sif;
handle["static"] = requestHandlers.static;
server.start(router.route,handle);
