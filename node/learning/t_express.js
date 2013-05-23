  var express = require("express");
  var app = express();

app.use(express.static(__dirname));

app.listen(8080, "127.0.0.1");
